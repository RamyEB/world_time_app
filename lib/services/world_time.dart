import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // the time in the location
  String flag; //Url the flag icon
  String url; //Url api endpoint
  bool isDayTime = false; // true or false daytime or not
  int status;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    var endpoint = Uri.parse('https://worldtimeapi.org/api/timezone/$url');

    try {
      Response response = await get(endpoint);
      Map data = jsonDecode(response.body);
      this.status = response.statusCode;
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      this.time = DateFormat.jm().format(now);
    } catch (e) {
      //print("erreur : $e ");
      time = "error";
      isDayTime = false;
    }
  }

  String toString() {
    print(
        "status : $status ,location : $location, time : $time, flag : $flag, url : $url");
  }
}
