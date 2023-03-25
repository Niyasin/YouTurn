import 'package:client_flutter/provider/tag_provider.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:provider/provider.dart';

import '../components/current_location.dart';
import '../components/send_http_post.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    var tagProvider = Provider.of<TagProvider>(context);

    return Scaffold(
      body: Stack(children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              center: LatLng(11.605, 76.083), // 11.605°N 76.083°E
              zoom: 13,
              onTap: tagProvider.handleTap),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            CircleLayer(circles: tagProvider.getCircles),
            MarkerLayer(markers: tagProvider.getMarkers),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 60),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: CurrentLocation(
                mapController: _mapController,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
