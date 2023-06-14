//
//  WeatherDayView.swift
//  SwiftWeatherTask
//
//  Created by Oufaa on 13/06/2023.
//

import SwiftUI

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            AsyncImage(url: URL(string: K.getFullImagePath(imgUrl: imageName) )){ image in
                      image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 40, height: 40)
                          .scaleEffect(x:2,y: 2)
                  
                  } placeholder: {
                      Image(systemName: "sun.max")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 40, height: 40)
                  }
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
//
//struct WeatherDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherDayView()
//    }
//}
