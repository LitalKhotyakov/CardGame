import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var name: String = ""
    @State private var locationText: String = "Locating..."
    @State private var side: String = ""
    @State private var locationManager = CLLocationManager()
    @State private var canStart = false
    @State private var showGame = false
    @State private var locationDelegate: LocationDelegate?
    @State private var locationTimer: Timer?
    @Environment(\.colorScheme) var colorScheme
    
    let midpointLatitude = 34.817549168324334
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                HStack(spacing: 40) {
                    VStack {
                        Image(colorScheme == .dark ? "left-dark" : "left")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("West Side")
                            .font(.headline)
                    }
                    
                    VStack {
                        Image(colorScheme == .dark ? "right-dark" : "right")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("East Side")
                            .font(.headline)
                    }
                }
                
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                
                Text(locationText)
                    .font(.headline)
                    .foregroundColor(canStart ? .primary : .secondary)
                
                // הסר את כפתורי הדמו - עכשיו זה אוטומטי
                
                Button("Start Game") {
                    showGame = true
                }
                .disabled(!canStart || name.isEmpty)
                .padding()
                .background(canStart && !name.isEmpty ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                NavigationLink(
                    "",
                    destination: GameView(playerName: name, playerSide: side, showGame: $showGame),
                    isActive: $showGame
                )
            }
            .padding()
            .navigationTitle("Card Game")
            .onAppear {
                setupLocation()
            }
            .onDisappear {
                locationTimer?.invalidate()
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func setupLocation() {
        locationDelegate = LocationDelegate { location in
            handleLocationUpdate(location)
        }
        
        locationManager.delegate = locationDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // בדיקת סטטוס הרשאות
        checkLocationPermission()
        
        // טיימאוט לאחר 5 שניות - אם לא מוצא מיקום, קבע דמו
        locationTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            if !canStart {
                // קבע דמו מיקום - East כברירת מחדל
                setDemoLocation(isEast: true)
            }
        }
    }
    
    func checkLocationPermission() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            locationText = "Location access denied - Use demo buttons"
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            locationText = "Unknown location status"
        }
    }
    
    func handleLocationUpdate(_ location: CLLocation) {
        locationTimer?.invalidate()
        
        if location.coordinate.latitude > midpointLatitude {
            side = "East"
        } else {
            side = "West"
        }
        
        locationText = "You are on the \(side) side"
        canStart = true
        locationManager.stopUpdatingLocation()
    }
    
    func setDemoLocation(isEast: Bool) {
        locationTimer?.invalidate()
        
        if isEast {
            side = "East"
        } else {
            side = "West"
        }
        
        locationText = "You are on the \(side) side"
        canStart = true
    }
}
