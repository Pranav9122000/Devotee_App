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
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    HStack(spacing: 10) {
                        Text("Devotee")
                            .font(.system(.largeTitle, design: .rounded, weight: .heavy))
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(Capsule().stroke(lineWidth: 2))
                        
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                        
                    }
                    .padding()
                    .foregroundStyle(.white)
                    
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
            .toolbar(.hidden)
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
