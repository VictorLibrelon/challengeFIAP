import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imgList;

  const ImageCarousel({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                    child: Image.asset(item,
                        fit: BoxFit.cover, width: double.infinity),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
