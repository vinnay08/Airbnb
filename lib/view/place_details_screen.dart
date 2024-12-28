import 'package:airbnb_app/Components/my_icon_button.dart';
import 'package:airbnb_app/Components/star_rating.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Provider/favorite_provider.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final DocumentSnapshot<Object?>? place;
  const PlaceDetailsScreen({super.key, this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = FavoriteProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailImagesandIcons(size, context, provider),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place!['title'],
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "Room in ${widget.place!['address']}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.place!['bedAndBathroom'],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            widget.place!['isActive'] == true
                ? ratingAndStartrue()
                : ratingAndStarfalse(),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  placePropertyList(
                    size,
                    "https://static.vecteezy.com/system/resources/previews/018/923/486/original/diamond-symbol-icon-png.png",
                    "This is a rare find",
                    "${widget.place!['vendor']}'s place is usually fully booked.",
                  ),
                  const Divider(),
                  placePropertyList(
                    size,
                    widget.place!['vendorProfile'],
                    "Stay with ${widget.place!['vendor']}",
                    "Superhost . ${widget.place!['yearOfHostin']} years hosting",
                  ),
                  const Divider(),
                  placePropertyList(
                      size,
                      "https://cdn-icons-png.flaticon.com/512/6192/6192020.png",
                      "Room in a rental unit",
                      "Your own room in a home, pluse access to shared spaces."),
                  placePropertyList(
                      size,
                      "https://cdn0.iconfinder.com/data/icons/co-working/512/coworking-sharing-17-512.png",
                      "Shared common spaces",
                      "You'll share parts of the home with the host,"),
                  placePropertyList(
                      size,
                      "https://img.pikbest.com/element_our/20230223/bg/102f90fb4dec6.png!w700wp",
                      "Shared bathroom",
                      "Your'll share the bathroom with others."),
                  const Divider(),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "About this place",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      "Welcome to our establishment, where comfort and elegance come together to create a memorable experience. We offer top-notch amenities, personalized service, and a peaceful ambiance, perfect for both business and leisure travelers. With well-designed accommodations, exquisite dining options, and a focus on your satisfaction, we strive to make your stay truly exceptional."),
                  SizedBox(height: size.height * 0.02),
                  Divider(),
                  Text(
                    "Where you'll be",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.place!['address'],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 400,
                    width: size.width,
                    // child: LocationInMap(place: widget.place!),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: priceAndReserve(size),
    );
  }

  Container priceAndReserve(Size size) {
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    text: "\$${widget.place!['price']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: " per night",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
              Text(widget.place!['date'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
          SizedBox(
            width: size.width * 0.3,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Reserve",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding placePropertyList(Size size, image, title, subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Divider(),
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
            radius: 29,
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: size.width * 0.0356,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding ratingAndStarfalse() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.star),
            SizedBox(
              width: 5,
            ),
            Text(
              "${widget.place!['rating'].toString()} . ",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.place!['review'].toString()}reviews",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      );

  Container ratingAndStartrue() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.place!['rating'].toString(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              StarRating(rating: widget.place!['rating']),
            ],
          ),
          Stack(
            children: [
              Image.network(
                "https://wallpapers.com/images/hd/golden-laurel-wreathon-teal-background-k5791qxis5rtcx7w-k5791qxis5rtcx7w.png",
                height: 50,
                width: 130,
                color: Colors.amber,
              ),
              Positioned(
                left: 32,
                child: Text(
                  "Guest\nFavorites",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(widget.place!['review'].toString(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "Reviews",
                style: TextStyle(
                    height: 0.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack detailImagesandIcons(Size size, BuildContext context, provider) {
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.35,
          child: AnotherCarousel(
            images: widget.place!['imageUrls']
                .map((url) => NetworkImage(url))
                .toList(),
            showIndicator: false,
            dotBgColor: Colors.transparent,
            onImageChange: (p0, p1) {
              setState(() {
                currentIndex = p1;
              });
            },
            autoplay: true,
            boxFit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 20,
          bottom: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black45,
            ),
            child: Text(
              "${currentIndex + 1} / ${widget.place!['imageUrls'].length}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 25,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: MyIconButton(
                    icon: Icons.arrow_back_ios_new,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.55,
                ),
                MyIconButton(icon: Icons.share_outlined),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    provider.toggleFavorite(widget.place);
                  },
                  child: MyIconButton(
                    icon: provider.isExist(widget.place)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    iconColor: provider.isExist(widget.place)
                        ? Colors.red
                        : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
