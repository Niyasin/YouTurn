import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import '../components/new_tag_payload.dart';
import '../components/send_http_get.dart';
import '../components/send_http_post.dart';
import '../components/tag_data.dart';

import 'package:location/location.dart';

List<LatLng> tappedPoints = [];
List<LatLng> confirmedPoints = [];
List<Marker> markers = [];
List<CircleMarker> circles = [];
String type = "default";
String range = "50";
final location = Location();

//controllers
final MapController mapController = MapController(); //contoller for map
final DraggableScrollableController bottomSheetController =
    DraggableScrollableController(); //controller for bottom sheet
TextEditingController textEditingController = TextEditingController();

Tag dataSet =
    Tag(lat: 0, lng: 0, type: "Nil", range: 0, desc: "Nil", date: "Nil");
int upvotes = 0;
int downvotes = 0;

//icon assets
ImageIcon landSlideIcon =
    const ImageIcon(AssetImage("assets/images/landslide.png"), size: 10);
Color landSlideColor = Color.fromARGB(83, 173, 57, 31);

ImageIcon floodIcon =
    const ImageIcon(AssetImage("assets/images/flood.png"), size: 10);
Color floodColor = Colors.blue;

ImageIcon powerLineIcon =
    const ImageIcon(AssetImage("assets/images/powerline.png"), size: 10);
Color powerLineColor = Color.fromARGB(153, 255, 218, 30);

ImageIcon tigerIcon =
    const ImageIcon(AssetImage("assets/images/tiger.png"), size: 10);
Color tigerColor = const Color.fromARGB(108, 250, 107, 25);

ImageIcon roadBlockIcon =
    const ImageIcon(AssetImage("assets/images/roadblock.png"), size: 10);
Color roadBlockColor = const Color.fromARGB(142, 79, 35, 25);

ImageIcon otherIcon =
    const ImageIcon(AssetImage("assets/images/flood.png"), size: 10);
Color otherColor = Color.fromARGB(131, 33, 243, 100);

List<dynamic> currentMarker = [0, 0];

class TagProvider with ChangeNotifier {
  void addNewTappedPoint(latlng, icon) {
    tappedPoints.add(latlng);

    Marker mk = Marker(
      width: 80,
      height: 80,
      point: latlng,
      builder: (ctx) => GestureDetector(
        onTap: () {
          bottomSheetController.animateTo(.80,
              duration: const Duration(seconds: 1), curve: Curves.linear);
          // bottomSheetController.jumpTo(0.8);
          findTagExists(latlng);
        },
        child: icon,
      ),
    );

    markers.add(mk);
    notifyListeners();

    // markers = tappedPoints.map((latlng) {
    //   return Marker(
    //     width: 80,
    //     height: 80,
    //     point: latlng,
    //     builder: (ctx) => GestureDetector(
    //       onTap: () {
    //         bottomSheetController.animateTo(.80,
    //             duration: const Duration(seconds: 1), curve: Curves.linear);
    //         // bottomSheetController.jumpTo(0.8);
    //         findTagExists(latlng);
    //       },
    //       child: icon,
    //     ),
    //   );
    // }).toList();
    // for (var i = 0; i < markers.length; i++) {
    //   print(markers[i]);
    // }
  }

  void addConfirmedPoint(latlng, color) {
    // print("Color i am sending: ");
    // print(color);
    confirmedPoints.add(latlng);
    CircleMarker cm = CircleMarker(
      point: latlng,
      radius: 100,
      color: color,
      borderStrokeWidth: 1,
      borderColor: Colors.white,
      useRadiusInMeter: true,
    );
    circles.add(cm);
    // circles = confirmedPoints.map((latlng) {
    //   return CircleMarker(
    //       point: latlng,
    //       color: color,
    //       borderStrokeWidth: 1,
    //       borderColor: Colors.white,
    //       useRadiusInMeter: true,
    //       radius: 100);
    // }).toList();
    // for (var i = 0; i < circles.length; i++) {
    //   var ele = circles[i];
    //   print("Color assigned");
    //   print(ele.color);
    // }
    notifyListeners();
  }

  void addType(String typeData) {
    type = typeData;
  }

  List<LatLng> get getTappedPoints => tappedPoints;
  List<LatLng> get getConfirmedPoints => confirmedPoints;
  List<Marker> get getMarkers => markers;
  List<CircleMarker> get getCircles => circles;
  MapController get getMapController => mapController;
  DraggableScrollableController get getBottomSheetController =>
      bottomSheetController;
  Tag get getTagData => dataSet;
  TextEditingController get getTextEditingController => textEditingController;
  String get getType => type;
  int get getDownVotes => downvotes;
  int get getUpVotes => upvotes;

  void addTapPosition(TapPosition tapPosition, LatLng latlng) {
    //adding new marker
    ImageIcon icon = landSlideIcon;
    Color color = Colors.white;

    icon = getIcon(type);
    color = getColor(type);
    // if (type == "Landslide") {
    //   icon = landSlideIcon;
    //   color = landSlideColor;
    // } else if (type == "Tiger") {
    //   icon = tigerIcon;
    //   color = tigerColor;
    // } else if (type == "Road Block") {
    //   icon = roadBlockIcon;
    //   color = roadColor;
    // }
    String desc = textEditingController.text;

    addNewTappedPoint(latlng, icon);
    notifyListeners();

    var isSuccess = sendHttpPost(
        lat: latlng.latitude.toString(),
        lon: latlng.longitude.toString(),
        range: range,
        type: type,
        desc: desc,
        date: DateTime.now().toString());

    isSuccess.then((value) {
      if (value == "Success") {
        addConfirmedPoint(latlng, color);
        notifyListeners();
      }
    });
  }

  void getAllMarkers() async {
    //finding all markers
    ImageIcon icon = landSlideIcon;
    Color color = Colors.white;
    try {
      print("Fetching current location");
      final currentLocation = await location.getLocation();
      print("Found coordinates: $currentLocation");
      mapController.move(
          LatLng(currentLocation.latitude!, currentLocation.longitude!), 16);
      notifyListeners();
      Future<List<Tag>> data = httpGetAllMarkers(
          currentLocation.latitude!, currentLocation.longitude!);
      data.then((value) {
        for (var element in value) {
          print(element.type);
          icon = getIcon(element.type);
          color = getColor(element.type);
          // if (element.type == "Landslide") {
          //   icon = landSlideIcon;
          //   color = currentMarker[1] = landSlideColor;
          // } else if (element.type == "Tiger") {
          //   print("Setting color to $tigerColor");
          //   icon = tigerIcon;
          //   color = tigerColor;
          //   print("Color set to $color");
          // } else if (element.type == "Road Block") {
          //   icon = roadBlockIcon;
          //   color = roadColor;
          // }
          print("Current color: $color");
          LatLng latlng = LatLng(element.lat, element.lng);
          addNewTappedPoint(latlng, icon);
          addConfirmedPoint(latlng, color);
          print(element);
          notifyListeners();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  bool findTagExists(LatLng latLng) {
    var isSuccess = sendHttpGet(
        lat: latLng.latitude.toString(), lng: latLng.longitude.toString());
    //print("Here it is");
    isSuccess.then((value) {
      print(value);
      setDataSet(value); //updating data for bottom sheet
      if (value.type == "Nil") {
        return false;
      }
    });
    return true;
  }

  void setDataSet(Tag data) {
    //sets the data read by bottom sheet
    dataSet = data;
    notifyListeners();
  }

  ImageIcon getIcon(String type) {
    if (type == "Landslide") {
      return landSlideIcon;
    } else if (type == "Tiger") {
      return tigerIcon;
    } else if (type == "Road Block") {
      return roadBlockIcon;
    } else if (type == "Downed powerline") {
      return powerLineIcon;
    } else {
      return otherIcon;
    }
  }

  Color getColor(String type) {
    if (type == "Landslide") {
      return landSlideColor;
    } else if (type == "Tiger") {
      return tigerColor;
    } else if (type == "Road Block") {
      return roadBlockColor;
    } else if (type == "Downed powerline") {
      return powerLineColor;
    } else {
      return otherColor;
    }
  }

  void doUpVote() {
    upvotes++;
    notifyListeners();
  }

  void doDownVote() {
    downvotes++;
    notifyListeners();
  }
}



  // void handleTap(TapPosition tapPosition, LatLng latlng) {
  //   ImageIcon icon = landSlideIcon;
  //   Color color = Colors.blue;

  //   if (type == "Landslide") {
  //     icon = landSlideIcon;
  //     color = Colors.amber;
  //   } else if (type == "Tiger") {
  //     icon = tigerIcon;
  //     color = tigerColor;
  //   } else if (type == "Road Block") {
  //     icon = roadBlockIcon;
  //     color = roadColor;
  //   }
  //   if (!findTagExists(latlng)) {
  //     addNewTappedPoint(latlng, icon);
  //     notifyListeners();

  //     var isSuccess = sendHttpPost(
  //         lat: latlng.latitude.toString(),
  //         lon: latlng.longitude.toString(),
  //         range: range,
  //         type: type);

  //     isSuccess.then((value) {
  //       if (value == "Success") {
  //         print("Delwin: ");
  //         print(color);
  //         addConfirmedPoint(latlng, color);
  //         notifyListeners();
  //       } else {
  //         print("Not success");
  //       }
  //     });
  //   }
  // }


  // void addMarkerMetaData({required Icon icon, required Color color}) {
  //   currentMarker[0] = icon;
  //   currentMarker[1] = color;
  // }

  // Tag findExistingTag(LatLng latLng) {
  //   Tag data =
  //       Tag(lat: 0, lng: 0, type: "Nil", range: 0, desc: "Nil", date: "Nil");
  //   var isSuccess = sendHttpGet(
  //       lat: latLng.latitude.toString(), lng: latLng.longitude.toString());
  //   //print("Here it is");
  //   isSuccess.then((value) {
  //     print(value);
  //     data = value;
  //   });
  //   return data;
  // }

  // void getAllMarkersNext(MapEvent event) async {
  //   ImageIcon icon = landSlideIcon;
  //   Color color = Colors.black;
  //   try {
  //     final currentLocation = await location.getLocation();
  //     mapController.move(
  //         LatLng(currentLocation.latitude!, currentLocation.longitude!), 10);
  //     Future<List<Tag>> data = httpGetAllMarkers(
  //         currentLocation.latitude!, currentLocation.longitude!);
  //     data.then((value) {
  //       for (var element in value) {
  //         if (element.type == "Landslide") {
  //           icon = landSlideIcon;
  //           color = currentMarker[1] = Colors.amber;
  //         } else if (type == "Tiger") {
  //           icon = tigerIcon;
  //           color = tigerColor;
  //         } else if (type == "Road Block") {
  //           icon = roadBlockIcon;
  //           color = roadColor;
  //         }
  //         LatLng latlng = LatLng(element.lat, element.lng);
  //         addNewTappedPoint(latlng, icon);
  //         addConfirmedPoint(latlng, color);
  //         notifyListeners();
  //       }
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
