import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guardiana/widgets/home_widgets/livespace/BusStationCard.dart';
import 'package:guardiana/widgets/home_widgets/livespace/HospitalCard.dart';
import 'package:guardiana/widgets/home_widgets/livespace/Pharmacycard.dart';
import 'package:guardiana/widgets/home_widgets/livespace/Policestationcard.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = "https://www.google.co.in/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong!! Call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(onMapfunction: openMap),
          HospitalCard(onMapfunction: openMap),
          PharmacyCard(onMapfunction: openMap),
          BusStationCard(onMapfunction: openMap),
        ],
      ),
    );
  }
}
