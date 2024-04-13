// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:helper/pages/search.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class UserMap extends StatefulWidget {
  const UserMap({Key? key}) : super(key: key);

  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  final Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(51.5505, -0.304841),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[];
  bool loading = false;
  var lat;
  final Mode _mode = Mode.overlay;

  var long;
  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    if (LocationPermission.always == true ||
        LocationPermission.whileInUse == true) {
      // await Geolocator.requestPermission();
      return await Geolocator.getCurrentPosition();
    } else {
      await Geolocator.requestPermission();

      return await Geolocator.getCurrentPosition();
    }
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    lat = detail.result.geometry!.location.lat;
    long = detail.result.geometry!.location.lng;
    _markers.clear();
    _markers.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: detail.result.name)));
    CameraPosition cameraPosition = new CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> _handlePressButton() async {
    setState(() {});
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "uk"),
          // Component(Component.country, "usa")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  @override
  void initState() {
    getUserCurrentLocation().then((value) async {
      lat = value.latitude;
      long = value.longitude;
      setState(() {});
      // marker added for current users location
      _markers.add(Marker(
        markerId: const MarkerId("2"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
      ));

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton.icon(
                        onPressed: () async {
                          var res = await http.get(Uri.parse(
                              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=${"$lat,$long"}&radius=1500&type=restaurant&key=AIzaSyCokFGbpzoXLJ3wYgQ6MJvMfet8pSwzGFE'));
                          // print(res.statusCode);
                          // print(res.request);
                          var maping = jsonDecode(res.body);
                          List data = [];
                          data.add(maping);
                          var name = data[0]['results'][0]['name'].toString();
                          print(name);

                          var newLat = data[0]['results'][0]['geometry']
                              ['location']['lat'];
                          var newLong = data[0]['results'][0]['geometry']
                              ['location']['lng'];
                          print(newLat);
                          print(newLong);
                          _markers.clear();

                          _markers.add(Marker(
                            markerId: const MarkerId("2"),
                            position: LatLng(newLat, newLong),
                            infoWindow: InfoWindow(
                              title: name,
                            ),
                          ));

                          // specified current users location
                          CameraPosition cameraPosition = new CameraPosition(
                            target: LatLng(newLat, newLong),
                            zoom: 15,
                          );

                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.restaurant,
                          color: Colors.white,
                        ),
                        label: "Restaurant".text.white.make()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton.icon(
                        onPressed: () async {
                          var res = await http.get(Uri.parse(
                              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=${"$lat,$long"}&radius=1500&type=atm&key=AIzaSyCokFGbpzoXLJ3wYgQ6MJvMfet8pSwzGFE'));
                          // print(res.statusCode);
                          // print(res.request);
                          var maping = jsonDecode(res.body);
                          List data = [];
                          data.add(maping);
                          var name = data[0]['results'][0]['name'].toString();
                          print(name);

                          var newLat = data[0]['results'][0]['geometry']
                              ['location']['lat'];
                          var newLong = data[0]['results'][0]['geometry']
                              ['location']['lng'];
                          _markers.clear();

                          print(newLat);
                          print(newLong);
                          _markers.add(Marker(
                            markerId: const MarkerId("2"),
                            position: LatLng(newLat, newLong),
                            infoWindow: InfoWindow(
                              title: name,
                            ),
                          ));

                          // specified current users location
                          CameraPosition cameraPosition = new CameraPosition(
                            target: LatLng(newLat, newLong),
                            zoom: 15,
                          );

                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.atm,
                          color: Colors.white,
                        ),
                        label: "ATM".text.white.make()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton.icon(
                        onPressed: () async {
                          var res = await http.get(Uri.parse(
                              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=${"$lat,$long"}&radius=1500&type=bank&key=AIzaSyCokFGbpzoXLJ3wYgQ6MJvMfet8pSwzGFE'));
                          // print(res.statusCode);
                          // print(res.request);
                          var maping = jsonDecode(res.body);
                          List data = [];
                          data.add(maping);
                          var name = data[0]['results'][0]['name'].toString();
                          print(name);

                          var newLat = data[0]['results'][0]['geometry']
                              ['location']['lat'];
                          var newLong = data[0]['results'][0]['geometry']
                              ['location']['lng'];
                          print(newLat);
                          print(newLong);
                          _markers.clear();
                          _markers.add(Marker(
                            markerId: const MarkerId("2"),
                            position: LatLng(newLat, newLong),
                            infoWindow: InfoWindow(
                              title: name,
                            ),
                          ));

                          // specified current users location
                          CameraPosition cameraPosition = new CameraPosition(
                            target: LatLng(newLat, newLong),
                            zoom: 15,
                          );

                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.money,
                          color: Colors.white,
                        ),
                        label: "Bank".text.white.make()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton.icon(
                        onPressed: () async {
                          var res = await http.get(Uri.parse(
                              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=${"$lat,$long"}&radius=1500&type=university&key=AIzaSyCokFGbpzoXLJ3wYgQ6MJvMfet8pSwzGFE'));
                          // print(res.statusCode);
                          // print(res.request);
                          var maping = jsonDecode(res.body);
                          List data = [];
                          data.add(maping);
                          var name = data[0]['results'][0]['name'].toString();
                          print(name);

                          var newLat = data[0]['results'][0]['geometry']
                              ['location']['lat'];
                          var newLong = data[0]['results'][0]['geometry']
                              ['location']['lng'];
                          print(newLat);
                          print(newLong);
                          _markers.clear();

                          _markers.add(Marker(
                            markerId: const MarkerId("2"),
                            position: LatLng(newLat, newLong),
                            infoWindow: InfoWindow(
                              title: name,
                            ),
                          ));

                          // specified current users location
                          CameraPosition cameraPosition = new CameraPosition(
                            target: LatLng(newLat, newLong),
                            zoom: 15,
                          );

                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                        label: "University".text.white.make()),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height - 210,
                child: GoogleMap(
                  // on below line setting camera position
                  initialCameraPosition: _kGoogle,
                  zoomControlsEnabled: false,
                  // on below line we are setting markers on the map
                  markers: Set<Marker>.of(_markers),
                  // on below line specifying map type.
                  mapType: MapType.normal,
                  // on below line setting user location enabled.
                  // myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,

                  myLocationEnabled: true,
                  // myLocationButtonEnabled: true,

                  // on below line setting compass enabled.
                  // compassEnabled: true,
                  // on below line specifying controller on map complete.
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      // on pressing floating action button the camera will take to user current location
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SizedBox(
          //   height: MediaQuery.sizeOf(context).height - 270,
          // ),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: _handlePressButton,
            isExtended: true,
            child: Icon(Icons.search),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              getUserCurrentLocation().then((value) async {
                print(value.latitude.toString() +
                    " " +
                    value.longitude.toString());
                lat = value.latitude;
                long = value.longitude;
                setState(() {});
                // marker added for current users location
                _markers.add(Marker(
                  markerId: const MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'My Current Location',
                  ),
                ));

                // specified current users location
                CameraPosition cameraPosition = new CameraPosition(
                  target: LatLng(value.latitude, value.longitude),
                  zoom: 14,
                );

                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
                setState(() {});
              });
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.location_on),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
