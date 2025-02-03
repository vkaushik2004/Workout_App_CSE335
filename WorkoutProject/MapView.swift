import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    //no longer needed
    
    //    @Binding var selectedLocation: String
    //    @StateObject private var viewModel = MapViewModel()
    
    //use location manager from model
    @StateObject var viewModel = LocationManager()
    let locationManager = CLLocationManager()
    //initaiate with random coords again
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//use tracking mode if allowed
    var body: some View {
        Map(
            coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow))
              .edgesIgnoringSafeArea(.all)
              .onAppear {
                  locationManager.requestWhenInUseAuthorization()
              }
      }
        
    }

