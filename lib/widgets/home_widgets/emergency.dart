import 'package:flutter/material.dart';
import 'package:guardiana/widgets/home_widgets/emergencies/AmbulanceEmergency.dart';
import 'package:guardiana/widgets/home_widgets/emergencies/FireBrigadeEmergency.dart';
import 'package:guardiana/widgets/home_widgets/emergencies/policecall.dart';
import 'package:guardiana/widgets/home_widgets/emergencies/policeemergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
            PoliceEmergency(),
            AmbulanceEmergency(),
            FireBrigadeEmergency(),
            PoliceCall(),
        ],
      )
    );
  }
}