
import 'package:location/location.dart';

class FetchLocation {


  Future<LocationData?> getCurrentLocation() async {


    LocationData _currentPosition;
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        //something will happen if not permitted
        return null;
      }

    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
        //something will happen if not permitted
      }
    }

    _currentPosition = await location.getLocation();
    return _currentPosition;
  }
}
