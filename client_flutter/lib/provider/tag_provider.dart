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
final MapController mapController = MapController();
final DraggableScrollableController bottomSheetController =
    DraggableScrollableController();
Tag dataSet =
    Tag(lat: 0, lng: 0, type: "Nil", range: 0, desc: "Nil", date: "Nil");
TextEditingController textEditingController = TextEditingController();

ImageIcon landSlideIcon =
    const ImageIcon(AssetImage("assets/images/landslide.png"), size: 10);

ImageIcon floodIcon =
    const ImageIcon(AssetImage("assets/images/flood.png"), size: 10);
Color floodColor = Colors.blue;

ImageIcon powerLineIcon =
    const ImageIcon(AssetImage("assets/images/powerline.png"), size: 10);

ImageIcon tigerIcon =
    const ImageIcon(AssetImage("assets/images/tiger.png"), size: 10);
Color tigerColor = const Color(0xffFA6Aff);

ImageIcon roadBlockIcon =
    const ImageIcon(AssetImage("assets/images/roadblock.png"), size: 10);
Color roadColor = Colors.lightGreen;

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

  void addTapPosition(TapPosition tapPosition, LatLng latlng) {
    //adding new marker
    ImageIcon icon = landSlideIcon;
    Color color = Colors.white;

    if (type == "Landslide") {
      icon = landSlideIcon;
      color = Colors.amber;
    } else if (type == "Tiger") {
      icon = tigerIcon;
      color = tigerColor;
    } else if (type == "Road Block") {
      icon = roadBlockIcon;
      color = roadColor;
    }

    addNewTappedPoint(latlng, icon);
    notifyListeners();

    var isSuccess = sendHttpPost(
        lat: latlng.latitude.toString(),
        lon: latlng.longitude.toString(),
        range: range,
        type: type);

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
          if (element.type == "Landslide") {
            icon = landSlideIcon;
            color = currentMarker[1] = Colors.amber;
          } else if (element.type == "Tiger") {
            print("Setting color to $tigerColor");
            icon = tigerIcon;
            color = tigerColor;
            print("Color set to $color");
          } else if (element.type == "Road Block") {
            icon = roadBlockIcon;
            color = roadColor;
          }
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
      //setDataSet(value);
      if (value.type == "Nil") {
        return false;
      }
    });
    return true;
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

  // ImageIcon getIcon(String type) {
  //   ImageIcon landSlideIcon =
  //       const ImageIcon(AssetImage("assets/images/landslide.png"), size: 10);

  //   if (type == "Landslide") {
  //     return landSlideIcon;
  //   } else if (type == "Tiger") {
  //     return tigerIcon;
  //   } else if (type == "Road Block") {
  //     return roadBlockIcon;
  //   }

  //   return landSlideIcon;
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

  // void setDataSet(Tag data) {
  //   dataSet = data;
  //   notifyListeners();
  // }