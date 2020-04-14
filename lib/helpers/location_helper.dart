import 'package:dio/dio.dart';

const GOOGLE_API_KEY = 'AIzaSyAQVUeJifi6PFOPNynFYcCtQEuPR2Ylm98';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAdress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await Dio().get(url);
    print(url);
    if((response.data['results'] as List).length <=0 ) return 'can\'t load address $lat $lng';
    return response.data['results'][0]['formatted_address'];
  }
}
