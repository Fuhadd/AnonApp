import 'package:anon/screens/confessions/confession_detail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/custom_colors.dart';
import '../../models/confession_response_model.dart';
import '../../utils/spacers.dart';
import 'confession_view_model.dart';

class ConfessionCard extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final bool read;
  final ConfessionViewModel confessionVM;
  const ConfessionCard(
      {Key? key,
      required this.snapshot,
      required this.read,
      required this.confessionVM})
      : super(key: key);

  @override
  _ConfessionCardState createState() => _ConfessionCardState();
}

class _ConfessionCardState extends State<ConfessionCard> {
  // final controller = ScreenshotController();
  int _current = 0;
  final int _currentSlider = 0;
  ConfessionResponse? _selectedIndex;

  final CarouselController _carouselController = CarouselController();

  final List<dynamic> _products = [
    {
      'title': 'Adidas Originals \nby Alexander Wang',
      'image':
          'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzV8fGFkaWRhc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
      'description': 'Limited collection'
    },
    {
      'title': 'Adidas Originals \nby Alexander Wang',
      'image':
          'https://images.unsplash.com/photo-1582588678413-dbf45f4823e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2265&q=80',
      'description': 'Limited collection'
    },
    {
      'title': 'Adidas Originals \nby Alexander Wang',
      'image':
          'https://images.unsplash.com/photo-1589188056053-28910dc61d38?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2264&q=80',
      'description': 'Limited collection'
    }
  ];

  @override
  Widget build(BuildContext context) {
    //If problem, wrap below with expanded
    return CarouselSlider(
        carouselController: _carouselController,
        options: CarouselOptions(
            enableInfiniteScroll: false,
            //350 before
            height: 320.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.70,
            enlargeCenterPage: true,
            pageSnapping: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
                print('This is selected index $index');
                print(_currentSlider);
                // print('This is confession $confession');
              });
            }),
        // items: widget.snapshot.data!.docs.map((data) {
        //   setState(() {
        //     _currentSlider = widget.snapshot.data!.docs.indexOf(data);
        //   });
        items: widget.snapshot.data!.docs.asMap().entries.map((entry) {
          var index = entry.key;
          var data = entry.value;
          // var confession = ConfessionResponse.fromJson(data);

          var confession = ConfessionResponse.fromJson(data);
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () async {
                  setState(() {
                    if (_selectedIndex == confession) {
                      _selectedIndex = null;
                    } else {
                      _selectedIndex = confession;
                    }
                  });
                  await Future.delayed(const Duration(milliseconds: 500));
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfessionDetailScreen(
                        title: 'Send me a message',
                        content: confession.content,
                      ),
                    ),
                  );

                  setState(() {
                    _selectedIndex = null;
                  });
                  widget.confessionVM.readConfession(confession.id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: _selectedIndex == confession
                          ? Border.all(color: Colors.blue.shade500, width: 3)
                          : null,
                      boxShadow: _selectedIndex == confession
                          ? [
                              BoxShadow(
                                color:
                                    const Color(0xFF1059C6).withOpacity(0.15),
                                blurRadius: 50,
                                spreadRadius: 10,
                                offset: const Offset(0, 40),
                              )
                            ]
                          : [
                              BoxShadow(
                                color:
                                    const Color(0xFF1059C6).withOpacity(0.15),
                                blurRadius: 20,
                                spreadRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ]),
                  // boxShadow: _selectedIndex == movie
                  //     ? [
                  //         BoxShadow(
                  //             color: Colors.blue.shade100,
                  //             blurRadius: 30,
                  //             offset: const Offset(0, 10))
                  //       ]
                  //     : [
                  //         BoxShadow(
                  //             color: Colors.grey.withOpacity(0.2),
                  //             blurRadius: 20,
                  //             offset: const Offset(0, 5))
                  //       ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        confession.imageUrl != ""
                            ? Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.mainBlueColor,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(confession.imageUrl),
                                        fit: BoxFit.cover)),
                                // child: const Icon(Icons.person_2_outlined),
                              )
                            : Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.mainBlueColor),
                                child: const Icon(Icons.person_2_outlined),
                              ),
                        verticalSpacer(10),
                        Text(
                          // confession.userName,
                          // '@elviss',
                          confession.userName,
                          style: TextStyle(
                              fontSize: 11,
                              // fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                        verticalSpacer(15),
                        Text(
                          // confession.title,
                          // 'Send me a message',
                          // "Had a bad day at the gym, I'm wheezing",
                          confession.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        verticalSpacer(15),
                        const Expanded(
                          child: Text(
                            // "confession.content",
                            "Unlimited cards and spaces, investments tips and much more more more more more more more more ts tips and much more more more more more more more mots tips and much more more more more more more more mo more more more more more more more more more",
                            // textAlign: TextAlign.center,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.3),
                          ),
                        ),
                        // verticalSpacer(10),
                        // Text(
                        //   "read all features",
                        //   style: TextStyle(
                        //       fontSize: 11,
                        //       // fontWeight: FontWeight.w400,
                        //       color: Colors.grey.shade500),
                        // ),
                        verticalSpacer(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                // margin:
                                //     const EdgeInsets.only(top: 5, bottom: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: index == _current
                                        ? CustomColors.mainBlueColor
                                            .withOpacity(0.6)
                                        : Colors.grey.shade500),
                                child: const Center(
                                  child: Icon(
                                    FontAwesomeIcons.reply,
                                    size: 16,
                                    color: CustomColors.whiteColor,
                                  ),
                                  // FaIcon(
                                  //   FontAwesomeIcons.message,
                                  //   size: 20,
                                  // ),
                                )),
                            horizontalSpacer(20),
                            GestureDetector(
                              // onTap: () async {
                              //   final image = await controller.capture();
                              //   if (image == null) return;

                              //   await saveImage(image);
                              // },
                              child: Container(
                                  // margin:
                                  //     const EdgeInsets.only(top: 5, bottom: 5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: index == _current
                                          ? CustomColors.mainBlueColor
                                              .withOpacity(0.6)
                                          : Colors.grey.shade500),
                                  child: const Center(
                                    child: Icon(
                                      FontAwesomeIcons.camera,
                                      size: 16,
                                      color: CustomColors.whiteColor,
                                    ),
                                    // FaIcon(
                                    //   FontAwesomeIcons.message,
                                    //   size: 20,
                                    // ),
                                  )),
                            ),
                            horizontalSpacer(20),
                            widget.read
                                ? const SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      widget.confessionVM
                                          .readConfession(confession.id);
                                    },
                                    // onTap: () async {
                                    //   final image = await controller.capture();
                                    //   if (image == null) return;

                                    //   await saveImage(image);
                                    // },
                                    child: Container(
                                        // margin:
                                        //     const EdgeInsets.only(top: 5, bottom: 5),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: index == _current
                                                ? CustomColors.mainBlueColor
                                                    .withOpacity(0.6)
                                                : Colors.grey.shade500),
                                        child: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.checkDouble,
                                            size: 16,
                                            color: CustomColors.whiteColor,
                                          ),
                                          // FaIcon(
                                          //   FontAwesomeIcons.message,
                                          //   size: 20,
                                          // ),
                                        )),
                                  ),
                            horizontalSpacer(10),
                          ],
                        ),

                        // Container(
                        //   height: 320,
                        //   margin: const EdgeInsets.only(top: 10),
                        //   clipBehavior: Clip.hardEdge,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Image.network(movie['image'],
                        //       fit: BoxFit.cover),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   movie['title'],
                        //   style: const TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   movie['description'],
                        //   style: TextStyle(
                        //       fontSize: 14, color: Colors.grey.shade600),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList());
  }

  // Future<String> saveImage(Uint8List bytes) async {
  //   await [Permission.storage].request();
  //   final time = DateTime.now()
  //       .toIso8601String()
  //       .replaceAll('.', '-')
  //       .replaceAll(':', '-');
  //   final name = 'screenshot_$time';
  //   final result = await ImageGallerySaver.saveImage(bytes, name: name);
  //   return result['filePath'];
  // }
}
