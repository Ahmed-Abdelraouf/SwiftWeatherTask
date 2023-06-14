//
//  ContentView.swift
//  SwiftWeatherTask
//
//  Created by Oufaa on 11/06/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainVm = MainViewModel()
    var body: some View {
        ZStack {
            GeometryReader { reader in
        Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .trailing){
                    navBarView().padding(.bottom,42)
            dayInfoView()
            weathersOfWeekView()
            Spacer()
        }.padding(.horizontal)
                    .searchable(text: $mainVm.searchText)
            }
            .onChange(of: mainVm.searchText, perform: { newValue in
                mainVm.fetchLocations()
            })
            .alert(mainVm.errorMessage , isPresented: $mainVm.isError) {
                Button(NSLocalizedString("Close", comment: "")) {}
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } label: {
                    Text("Go to Setting")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}

extension MainView {
    
    private func navBarView() -> some View{
        VStack{
            HStack{
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.textFgColor)
                    .onTapGesture {
                        mainVm.fetchWeatherByLocation()
                    }
                
                TextField("Search", text: $mainVm.searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 30)
                    .onSubmit {
                        mainVm.fetchWeather()
                        mainVm.searchText = ""
                    }
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.textFgColor)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        mainVm.fetchWeather()
                        mainVm.searchText = ""
                    }
            }
            if mainVm.isDropDownView {
                VStack(spacing: 16){
                    ForEach(mainVm.locations ?? []) {
                        locaion in
                        Text(locaion.name)
                            .onTapGesture {
                                mainVm.searchText = locaion.name
                                mainVm.fetchWeather()
                                mainVm.searchText = ""
                                mainVm.isDropDownView = false
                            }
                    }
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal)
                .background(.white)
                .cornerRadius(15)
                    .padding()
                
            }
        }.padding(.bottom)
    }
    private func dayInfoView() -> some View{
        VStack{
            AsyncImage(url: URL(string: K.getFullImagePath(imgUrl: mainVm.weather?.current.condition.icon ?? "") )){ image in
                      image
                          .resizable()
                          .scaledToFill()
                          .frame(width: 90,height: 90)
                          .scaleEffect(x:2,y: 2)
                  
                  } placeholder: {
                      Image(systemName: "sun.max")
                          .resizable()
                          .frame(width: 90,height: 90)
                  }
             
                  .foregroundColor(.white)
                  .padding(.trailing)
            HStack {
                Text("\(mainVm.temp(temp: mainVm.weather?.current.temp_c ?? 10))°")
                Text("C")
            }.font(.system(size: 60, weight: .medium))
                .foregroundColor(.textFgColor)
                .padding(.trailing)
            HStack {
                Text("\(mainVm.temp(temp: mainVm.weather?.current.temp_f ?? 10))°")
                Text("F")
            }.font(.system(size: 60, weight: .medium))
                .foregroundColor(.textFgColor)
                .padding(.trailing)
            Text(mainVm.weather?.location.name ?? "giza")
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(.textFgColor)
                .padding(.trailing)
        }
    }
    private func weathersOfWeekView() -> some View{
        HStack(spacing: 20) {
            
            ForEach(mainVm.weather?.forecast.forecastday ?? [], id: \.date) {
                row in
                WeatherDayView(dayOfWeek: mainVm.printDayName(dayOfWeather: row.date),
                               imageName: row.day.condition.icon,
                               temperature: Int(row.day.maxtemp_c))
            }
//            WeatherDayView(dayOfWeek: "TUE",
//                           imageName: "cloud.sun.fill",
//                           temperature: 74)
//
//            WeatherDayView(dayOfWeek: "WED",
//                           imageName: "sun.max.fill",
//                           temperature: 88)
//
//            WeatherDayView(dayOfWeek: "THU",
//                           imageName: "wind.snow",
//                           temperature: 55)
//
//            WeatherDayView(dayOfWeek: "FRI",
//                           imageName: "sunset.fill",
//                           temperature: 60)
//
//            WeatherDayView(dayOfWeek: "SAT",
//                           imageName: "snow",
//                           temperature: 25)
        }.frame(maxWidth: .infinity,alignment: .center)
                    .padding(.vertical)

    }
}

