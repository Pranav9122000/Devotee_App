//
//  DevoteeWidget.swift
//  DevoteeWidget
//
//  Created by Kulkarni, Pranav on 28/01/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct DevoteeWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroungGradient.ignoresSafeArea(.all)
                
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .frame(
                        width: widgetFamily != .systemSmall ? 56 : 36,
                        height: widgetFamily != .systemSmall ? 56 : 36)
                    .offset(
                        x: (geometry.size.width/2) - 20,
                        y: (geometry.size.height / -2) + 20)
                    .padding([.top, .trailing], widgetFamily != .systemSmall ? 32 : 12)
                
                HStack {
                    Text("Just Do It")
                        .foregroundStyle(.white)
                        .font(.system(.footnote, design: .rounded, weight: .bold))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 4)
                        .background(.black.opacity(0.5).blendMode(.overlay))
                        .clipShape(Capsule())
                    
                    if widgetFamily != .systemSmall {
                        Spacer()
                    }
                }
                .padding()
                .offset(y: (geometry.size.height/2) - 24)
            }
        }
    }
}

struct DevoteeWidget: Widget {
    let kind: String = "DevoteeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devotee Launcher")
        .description("This is an example widget for personal task manager app.")
    }
}

#Preview(as: .systemSmall) {
    DevoteeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
#Preview(as: .systemMedium) {
    DevoteeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
#Preview(as: .systemLarge) {
    DevoteeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
