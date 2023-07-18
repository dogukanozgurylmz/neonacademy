// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:travel_ease_app/models/hotel_model.dart';

class HotelReservationView extends StatefulWidget {
  List<HotelModel> hotels;
  HotelReservationView({
    Key? key,
    required this.hotels,
  }) : super(key: key);

  @override
  State<HotelReservationView> createState() => _HotelReservationViewState();
}

class _HotelReservationViewState extends State<HotelReservationView> {
  void reserve(HotelModel model) {
    if (model.isReserved) {
      model.isReserved = false;
      return;
    }
    model.isReserved = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hotels[index].hotelName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.hotels[index].phoneNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.hotels[index].address,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.hotels[index].isReserved ? "Rezerve" : "Rezerve değil",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reserve(widget.hotels[index]);
                      });
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(220, 30)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      widget.hotels[index].isReserved
                          ? "Rezerve etme"
                          : "Rezerve et",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
