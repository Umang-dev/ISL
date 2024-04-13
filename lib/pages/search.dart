import 'dart:async';
import 'dart:ffi';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

const kGoogleApiKey = 'AIzaSyCokFGbpzoXLJ3wYgQ6MJvMfet8pSwzGFE';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchState extends State<Search> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(51.5505, -0.304841), zoom: 14.0);

  late GoogleMapController googleMapController;
  Set<Marker> markersList = {};

  final Mode _mode = Mode.overlay;
  bool show = false;
  var lat;
  var lng;
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

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    lat = detail.result.geometry!.location.lat;
    lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

  Future<void> _handlePressButton() async {
    show = true;
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
  final List<Marker> _markers = <Marker>[];
  bool loading = false;
  Completer<GoogleMapController> _controller = Completer();

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

  getPermission() async {
    var serviceStatus = await LocationPermission.whileInUse == false;
    print(serviceStatus);
  }

  var currentLat;
  var currentlong;
  @override
  void initState() {
    super.initState();
    getUserCurrentLocation().then((value) async {
      lat = value.latitude;
      lng = value.longitude;
      setState(() {});
      // marker added for current users location
      markersList.add(Marker(
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
      key: homeScaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _handlePressButton,
        isExtended: true,
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
