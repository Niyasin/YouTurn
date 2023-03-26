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
late final MapController mapController = MapController();
final DraggableScrollableController bottomSheetController =
    DraggableScrollableController();
Tag dataSet =
    Tag(lat: 0, lng: 0, type: "Nil", range: 0, desc: "Nil", date: "Nil");
TextEditingController textEditingController = TextEditingController();

class TagProvider with ChangeNotifier {
  void addNewTappedPoint(latlng) {
    String path;
    tappedPoints.add(latlng);

    markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80,
        height: 80,
        point: latlng,
        builder: (ctx) => GestureDetector(
          onTap: () {
            bottomSheetController.animateTo(.80,
                duration: const Duration(seconds: 1), curve: Curves.linear);
            // bottomSheetController.jumpTo(0.8);
            findTagData(latlng);
          },
          child: Icon(
            Icons.location_on,
            size: 20,
            color: Colors.black,
          ),
        ),
      );
    }).toList();
    notifyListeners();
  }

  void addConfirmedPoint(latlng) {
    confirmedPoints.add(latlng);
    circles = confirmedPoints.map((latlng) {
      return CircleMarker(
          point: latlng,
          color: const Color.fromARGB(99, 55, 138, 227),
          borderStrokeWidth: 1,
          borderColor: Colors.white,
          useRadiusInMeter: true,
          radius: 100);
    }).toList();
    notifyListeners();
  }

  void addType(String typeData) {
    type = typeData;
    notifyListeners();
  }

  void setDataSet(Tag data) {
    dataSet = data;
    notifyListeners();
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

  void addTapPosition(TapPosition tapPosition, LatLng latlng) {
    addNewTappedPoint(latlng);
    notifyListeners();

    var isSuccess = sendHttpPost(
        lat: latlng.latitude.toString(),
        lon: latlng.longitude.toString(),
        range: range,
        type: type);

    isSuccess.then((value) {
      if (value == "Success") {
        addConfirmedPoint(latlng);
        notifyListeners();
      }
    });
  }

  void handleTap(TapPosition tapPosition, LatLng latlng) {
    if (findTagData(latlng)) {
      addNewTappedPoint(latlng);
      notifyListeners();

      var isSuccess = sendHttpPost(
          lat: latlng.latitude.toString(),
          lon: latlng.longitude.toString(),
          range: range,
          type: type);

      isSuccess.then((value) {
        if (value == "Success") {
          addConfirmedPoint(latlng);
          notifyListeners();
        }
      });
    }
  }

  void getAllMarkers() async {
    try {
      print("HERE EEEEEEEE");
      final currentLocation = await location.getLocation();
      mapController.move(
          LatLng(currentLocation.latitude!, currentLocation.longitude!), 14);
      Future<List<Tag>> data = httpGetAllMarkers(
          currentLocation.latitude!, currentLocation.longitude!);
      data.then((value) {
        for (var element in value) {
          LatLng latlng = LatLng(element.lat, element.lng);
          addNewTappedPoint(latlng);
          addConfirmedPoint(latlng);
          notifyListeners();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void getAllMarkersNext(MapEvent event) async {
    try {
      final currentLocation = await location.getLocation();
      mapController.move(
          LatLng(currentLocation.latitude!, currentLocation.longitude!), 14);
      Future<List<Tag>> data = httpGetAllMarkers(
          currentLocation.latitude!, currentLocation.longitude!);
      data.then((value) {
        for (var element in value) {
          LatLng latlng = LatLng(element.lat, element.lng);
          addNewTappedPoint(latlng);
          addConfirmedPoint(latlng);
          notifyListeners();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  bool findTagData(LatLng latLng) {
    var isSuccess = sendHttpGet(
        lat: latLng.latitude.toString(), lng: latLng.longitude.toString());
    //print("Here it is");
    isSuccess.then((value) {
      print(value);
      setDataSet(value);
    });
    return true;
  }

  Tag findTag(LatLng latLng) {
    Tag data =
        Tag(lat: 0, lng: 0, type: "Nil", range: 0, desc: "Nil", date: "Nil");
    var isSuccess = sendHttpGet(
        lat: latLng.latitude.toString(), lng: latLng.longitude.toString());
    //print("Here it is");
    isSuccess.then((value) {
      print(value);
      data = value;
    });
    return data;
  }

  String getIcon(LatLng latlng) {
    Tag data = findTag(latlng);
    if (data.type == "Landslide") {
      return "assets/images/landslide.png";
    }
    return "assets/images/default.png";
  }
}
