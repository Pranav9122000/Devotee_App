//
//  ContentView.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 21/01/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showNewTaskItem: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    Spacer(minLength: 80)
                    
                    Button {
                        showNewTaskItem.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                            Text("New Tasks")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.5), radius: 8, x: 8, y: 4)
                    
                    List {
                        ForEach(items) { item in
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline).bold()
                                
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(.plain)
                    .shadow(color: .black.opacity(0.6), radius: 12)
                    .padding()
                }
                .opacity(showNewTaskItem ? 0.6 : 1)
                .animation(.easeOut(duration: 1), value: showNewTaskItem)
                
                if(showNewTaskItem) {
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .navigationTitle("Daily Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .background(
                BackgroundImageView()
            )
            .background(backgroungGradient.ignoresSafeArea(.all))
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
