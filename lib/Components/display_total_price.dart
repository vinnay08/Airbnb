import 'package:flutter/material.dart';

class DisplayTotalPrice extends StatefulWidget {
  const DisplayTotalPrice({super.key});

  @override
  State<DisplayTotalPrice> createState() => _DisplayTotalPriceState();
}

class _DisplayTotalPriceState extends State<DisplayTotalPrice> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Display total price",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Including all fees, before taxes",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                Switch(
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                      });
                    }),
              ],
            ),
          ),
          ),
    );
  }
}
