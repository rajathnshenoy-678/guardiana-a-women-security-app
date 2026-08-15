import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final Function? onMapfunction;
  const HospitalCard({Key? key, this.onMapfunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapfunction!("Hospitals near me");
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
                  child: Icon(Icons.local_hospital)
                ),
              ),
            ),
          ),
          Text("Hospitals"),
        ],
      ),
    );
  }
}
