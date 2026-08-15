import 'package:flutter/material.dart';

class BusStationCard extends StatelessWidget {
  final Function? onMapfunction;
  const BusStationCard({Key? key, this.onMapfunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapfunction!("Bus Stations near me");
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(Icons.bus_alert,)
                ),
              ),
            ),
          ),
          Text("Bus Stations")
        ],
      ),
    );
  }
}
