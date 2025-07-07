
import SwiftUI

struct SwiftUIView : View {
    
    init(controller: FlutterBinaryMessenger, isTapped: Bool = false, username: String = "") {
        self.controller = controller
        self.isTapped = isTapped
        self.username = username
    }
    
    var controller : FlutterBinaryMessenger
    
    @State private var isTapped = true
    @State var username = ""
    @State var temperature = ""
    @State var isRegular = false
    
    var body : some View {
        
        VStack {
            Text("Temperature in Flutter: "+temperature).font(.largeTitle).foregroundColor(isTapped ? Color.blue : Color.black).padding().onTapGesture {
                withAnimation {
                    self.isTapped.toggle()
                }
            }
            
            if isTapped {
                Image(systemName: "star.fill").foregroundColor(.yellow).font(.largeTitle).padding()
            }
            
            TextField("Enter username", text: $username)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         .padding(.horizontal)
                         .onChange(of: username) { newValue in
                             onUsernameChange(newValue)
                         }
        }
    }
    
    private func onUsernameChange(_ newValue: String) {
        let reverseApi = ReverseMessageApi(binaryMessenger: controller)
        
        reverseApi.getTemperatureInCityFromFlutter(city: newValue) { result in
            switch result {
            case .success(let temperature):
                print("Temperature: \(temperature)")
                self.temperature = temperature.description
            case .failure(let error):
                print("Failed to get temperature: \(error)")
                self.temperature = "Fluter error"
            }
        }
    }
}
