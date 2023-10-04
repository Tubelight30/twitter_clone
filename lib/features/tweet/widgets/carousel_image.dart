import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;
  const CarouselImage({super.key, required this.imageLinks});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.imageLinks.map(
                (link) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      link,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: 400,
                enableInfiniteScroll:
                    false, //after last image it will not scroll to first image again
              ),
            ),
          ],
        ),
      ],
    );
  }
}
