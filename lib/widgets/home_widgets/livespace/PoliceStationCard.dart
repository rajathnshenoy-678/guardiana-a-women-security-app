import 'package:flutter/material.dart';

class PoliceStationCard extends StatelessWidget {
  final Function? onMapfunction;
  const PoliceStationCard({Key? key, this.onMapfunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapfunction!("Police stations near me");
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Icon(Icons.local_police,)
              ),
            ),
          ),
          Text("Police Stations")
        ],
      ),
    );
  }
}
