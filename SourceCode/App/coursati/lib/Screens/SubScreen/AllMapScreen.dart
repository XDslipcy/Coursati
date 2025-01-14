import 'package:coursati/Screens/SubScreen/TrainingCenterInfo/TrainingCenterInfoPage.dart';
import 'package:coursati/Services/ScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Classes/GlobalVariables.dart';
import '../../Classes/TCLocation.dart';

class AllMapScreen extends StatefulWidget {
  const AllMapScreen({super.key});

  @override
  State<AllMapScreen> createState() => _AllMapScreenState();
}

//
class _AllMapScreenState extends State<AllMapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(32.87027040045473, 13.173934429128234);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.setMapStyle((isDark) ? _mapStyle : "[]");
  }

  String _mapStyle = "";

  @override
  void initState() {
    // TODO: implement initState
    rootBundle
        .loadString('Assets/GoogleMapsTheme/DarkTheme.txt')
        .then((string) {
      _mapStyle = string;
    });
    super.initState();
  }

  // Lat
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Color(0xff424242) : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        bottomOpacity: 0,
        title: Text(
          (languageType == 0) ? "الموقع" : "Location",
          style: TextStyle(color: isDark ? Colors.white : Colors.black54),
        ),
      ),
      body: FutureBuilder(
        future: fetchTrainingCenter(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Set<Marker> mark = snapshot.data!;

            //?????????????????????????????????????????????????
            //*** Google Map */
            return GoogleMap(
              onMapCreated: _onMapCreated,
              buildingsEnabled: true,
              markers: mark,
              initialCameraPosition:
                  CameraPosition(target: _center, zoom: 11.0),
            );

            //???????????????????????????????????????????????????
          } else {
            return Container(
                width: double.infinity,
                height: 250,
                child: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  Future<Set<Marker>> fetchTrainingCenter() async {
    var url = "map";

    List<TCLocation> list = [];
    try {
      var response = await dioTestApi.get(url);
      if (response.statusCode == 200) {
        List<dynamic> tcJson = response.data["tc"];
        for (var tcJson in tcJson) {
          list.add(TCLocation.fromJson(tcJson));
        }
      }
    } catch (e) {
      print(e);
    }

    Set<Marker> mark = {};
    for (int i = 0; i < list.length; i++) {
      mark.add(Marker(
          markerId: MarkerId(list[i].id.toString()),
          position: LatLng(list[i].lat, list[i].lng),
          draggable: true,
          infoWindow: InfoWindow(
              title: (languageType == 0 ? "<  " : "") +
                  list[i].name +
                  (languageType == 0 ? "" : "  >"),
              onTap: () {
                //** Going to TrainingCenter page */
                Navigator.of(context).push(ScreenController().createRoute(
                    TrainingCenterPage(id: list[i].id.toString(), loc: false),
                    0));
              })));
    }
    return mark;
  }
}
