//
//  NewTaskItemView.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 27/01/24.
//

import SwiftUI

struct NewTaskItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var task: String = ""
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    @Binding var isShowing: Bool
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                
                TextField("Add new task", text: $task)
                    .foregroundStyle(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .font(.headline)
                .foregroundStyle(.white)
                .background(isButtonDisabled ? .blue : .pink)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(isDarkMode ? Color(UIColor.secondarySystemBackground) : .white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.7), radius: 25)
            .frame(maxWidth: 640)
        }
        .padding()
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
}

#Preview {
    NewTaskItemView(isShowing: .constant(true))
        .background(Color.gray.ignoresSafeArea(.all))
}
