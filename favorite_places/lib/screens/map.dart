import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BMFMapOptions mapOptions = BMFMapOptions(
    center: BMFCoordinate(39.917215, 116.380341),
    zoomLevel: 12,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick Your Location' : 'Your Location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: () {}, icon: Icon(Icons.save)),
        ],
      ),
      body: BMFMapWidget(
        onBMFMapCreated: (controller) {},
        mapOptions: mapOptions,
      ),
    );
  }
}
