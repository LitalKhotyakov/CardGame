import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var locationUpdate: (CLLocation) -> Void
    var errorCallback: ((Error) -> Void)?

    init(locationUpdate: @escaping (CLLocation) -> Void, errorCallback: ((Error) -> Void)? = nil) {
        self.locationUpdate = locationUpdate
        self.errorCallback = errorCallback
        super.init()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationUpdate(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
        errorCallback?(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            print("Location access denied")
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}
