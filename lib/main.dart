import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_api_search_1/home_page.dart';
import 'package:test_api_search_1/model/map_model.dart';
import 'package:test_api_search_1/provider/google_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentPositionLatLng =
      const LatLng(13.752763431986214, 100.53257266015626);

  bool isLoading = true;
  MapModel? data;
  callAPI() async {
    try {
      var res = await GoogleAPI().getPlace();
      if (res.statusCode == 200) {
        var rs = json.decode(res.body);
        data = MapModel.fromJson(rs);
        print(data!.results!.length);
        markers.clear();
        for (var i = 0; i < data!.results!.length; i++) {
          print(i);
          Result only = data!.results![i];
          await setMarker(
            i,
            only.geometry!.location!.lat!,
            only.geometry!.location!.lng!,
          );
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("error");
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  setMarker(int index, double lat, double lng) {
    // creating a new MARKER
    MarkerId id = MarkerId("$index");
    final Marker marker = Marker(
      markerId: MarkerId("$index"),
      position: LatLng(
        lat,
        lng,
      ),
      infoWindow: InfoWindow(title: "", snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    setState(() {
      markers[id] = marker;
    });
  }

  Future<void> goToCurrent() async {
    CameraPosition loadCurrentPosition = CameraPosition(
      target: currentPositionLatLng,
      zoom: 14,
    );
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(loadCurrentPosition));
  }

  @override
  void initState() {
    callAPI();
    super.initState();
  }

  double? _height;
  double? _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านอาหาร"),
        actions: [
          IconButton(
              onPressed: goToCurrent, icon: Icon(Icons.location_searching))
        ],
      ),
      body: isLoading
          ? Center(child: Text("Loading..."))
          : Container(
              height: _height,
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: currentPositionLatLng,
                      zoom: 12,
                    ),
                    mapType: MapType.terrain,
                    markers: Set<Marker>.of(markers.values),
                    // onCameraMove: _onCameraMove,
                  ),
                ],
              ),
            ),
    );
  }
}
