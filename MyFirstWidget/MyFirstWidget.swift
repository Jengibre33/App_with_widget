//
//  MyFirstWidget.swift
//  MyFirstWidget
//
//  Created by Javier on 18/09/23.
//

import WidgetKit
import SwiftUI

struct WeatherProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), degrees: 0, title: "", desc: "", icon: "thermometer")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        
        completion(WeatherEntry(date: Date(), degrees: 10, title: "Nublado", desc: "Alerta de tormenta severa", icon: "cloud.rain.fill"))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        
        var entries: [WeatherEntry] = []
        
        entries.append(WeatherEntry(date: Date(), degrees: -15, title: "Nieve", desc: "Alerta granizo", icon: "snowflake"))
        
        entries.append(WeatherEntry(date: Date().addingTimeInterval(5), degrees: 10, title: "Despejado", desc: "Vientos de hasta 30km/h", icon: "cloud.bolt.rain"))
        
        entries.append(WeatherEntry(date: Date().addingTimeInterval(10), degrees: 27, title: "Alerta de calor extremo", desc: "Alerta de tormenta severa", icon: "sun.max.fill"))
        
        completion(Timeline(entries: entries, policy: .atEnd))
    }
    
}

struct WeatherEntry: TimelineEntry {
    
    let date: Date
    let degrees: Int
    let title: String
    let desc: String
    let icon: String
    
}

struct MyFirstWidgetEntryView : View {
    var entry: WeatherProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: entry.icon).resizable().frame(width: 60, height: 60)
                Text("\(entry.degrees)°C").font(.title2)
                Text(entry.date, style: .time)
            }
            if family == .systemMedium {
                VStack {
                    Text(entry.title).font(. title).bold()
                    Text(entry.desc)
                }
            }
        }
    }
}
struct MyFirstWidget: Widget {
    let kind: String = "MyFirstWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            MyFirstWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct MyFirstWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyFirstWidgetEntryView(entry: WeatherEntry(date: Date(), degrees: 10, title: "Nublado", desc: "Alerta de Tormenta Severa", icon: "cloud.rain.fill"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
