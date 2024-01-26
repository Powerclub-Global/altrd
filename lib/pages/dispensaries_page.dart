import 'dart:async';
import 'dart:convert';
import 'package:fineartsociety/widgets/store_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import 'dart:math' as math;
part 'dispensaries_page.g.dart';

class CheckBoxStates {
  CheckBoxStates({required this.state1, required this.state2});
  bool state1;
  bool state2;
}

@riverpod
class Value extends _$Value {
  @override
  CheckBoxStates build() => CheckBoxStates(state1: false, state2: false);

  void changeState(int index) {
    if (index == 0) {
      state = CheckBoxStates(state1: !state.state1, state2: state.state2);
    } else {
      state = CheckBoxStates(state1: state.state1, state2: !state.state2);
    }
  }
}

class IsExpandedValues {
  IsExpandedValues(
      {required this.isExpanded1,
      required this.isExpanded2,
      required this.isExpanded3,
      required this.isExpanded4});
  bool isExpanded1;
  bool isExpanded2;
  bool isExpanded3;
  bool isExpanded4;
}

@riverpod
class IsExpandedValueStates extends _$IsExpandedValueStates {
  @override
  IsExpandedValues build() => IsExpandedValues(
      isExpanded1: false,
      isExpanded2: false,
      isExpanded3: false,
      isExpanded4: false);

  void changeState(int index) {
    if (index == 0) {
      state = IsExpandedValues(
          isExpanded1: !state.isExpanded1,
          isExpanded2: false,
          isExpanded3: false,
          isExpanded4: false);
    } else if (index == 1) {
      state = IsExpandedValues(
          isExpanded1: false,
          isExpanded2: !state.isExpanded2,
          isExpanded3: false,
          isExpanded4: false);
    } else if (index == 2) {
      state = IsExpandedValues(
          isExpanded1: false,
          isExpanded2: false,
          isExpanded3: !state.isExpanded3,
          isExpanded4: false);
    } else {
      state = IsExpandedValues(
        isExpanded1: false,
        isExpanded2: false,
        isExpanded3: false,
        isExpanded4: !state.isExpanded4,
      );
    }
  }
}

class MyAnimationProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}

class DispensariesScreen extends ConsumerWidget {
  DispensariesScreen({super.key});

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/artists_data.json');
    var data = await json.decode(response);
    List<dynamic> artists = data['artists'];

    List<dynamic> featuredArtists = artists.where((item) {
      return item['featured'] == true;
    }).toList();
    print(featuredArtists);
    return featuredArtists;
  }

  List<String> steps = [
    "Insert your Bank Card",
    "Select Cash or Bitcoin",
    "Input your Desired Amount",
    "Enter your KYC Verification ( Bitcoin Only )",
    "Receive your Cash or Bitcoin!"
  ];

  List<dynamic> storeData = [
    [
      {
        "name": "Hourglass Sydney",
        "description":
            "A trendy coffee shop in the heart of Sydney offering a cozy ambiance and a variety of freshly brewed coffee.",
        "address": "123 George Street, Sydney",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Melbourne",
        "description":
            "Discover the essence of Melbourne at Hourglass, where artisanal coffee meets a vibrant atmosphere.",
        "address": "456 Collins Street, Melbourne",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Brisbane",
        "description":
            "Escape the hustle and bustle at Hourglass Brisbane, a serene coffee haven serving the finest blends.",
        "address": "789 Queen Street, Brisbane",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Sydney",
        "description":
            "A trendy coffee shop in the heart of Sydney offering a cozy ambiance and a variety of freshly brewed coffee.",
        "address": "123 George Street, Sydney",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Melbourne",
        "description":
            "Discover the essence of Melbourne at Hourglass, where artisanal coffee meets a vibrant atmosphere.",
        "address": "456 Collins Street, Melbourne",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Brisbane",
        "description":
            "Escape the hustle and bustle at Hourglass Brisbane, a serene coffee haven serving the finest blends.",
        "address": "789 Queen Street, Brisbane",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
    ],
    [
      {
        "name": "Hourglass Toronto",
        "description":
            "Indulge in the warmth of Toronto at Hourglass, where every cup tells a tale of quality and passion.",
        "address": "101 Yonge Street, Toronto",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Vancouver",
        "description":
            "Sip on excellence in Vancouver at Hourglass, a place where coffee enthusiasts gather for a delightful experience.",
        "address": "202 Granville Street, Vancouver",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Montreal",
        "description":
            "Montreal's rendezvous for coffee lovers – Hourglass Montreal, where each cup is a journey of flavors.",
        "address": "303 Saint-Catherine Street, Montreal",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
    ],
    [
      {
        "name": "Hourglass Carolina",
        "description":
            "Experience the charm of Carolina at Hourglass, a coffee sanctuary nestled in the heart of the city.",
        "address": "45 Main Street, Carolina",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Ponce",
        "description":
            "Hourglass Ponce invites you to savor the richness of coffee in a tranquil setting that feels like home.",
        "address": "67 Ponce de Leon Avenue, Ponce",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Caguas",
        "description":
            "Caguas' haven for coffee aficionados – Hourglass Caguas, where passion and quality unite in every cup.",
        "address": "89 Juana Díaz Street, Caguas",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Carolina",
        "description":
            "Experience the charm of Carolina at Hourglass, a coffee sanctuary nestled in the heart of the city.",
        "address": "45 Main Street, Carolina",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Ponce",
        "description":
            "Hourglass Ponce invites you to savor the richness of coffee in a tranquil setting that feels like home.",
        "address": "67 Ponce de Leon Avenue, Ponce",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Caguas",
        "description":
            "Caguas' haven for coffee aficionados – Hourglass Caguas, where passion and quality unite in every cup.",
        "address": "89 Juana Díaz Street, Caguas",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Carolina",
        "description":
            "Experience the charm of Carolina at Hourglass, a coffee sanctuary nestled in the heart of the city.",
        "address": "45 Main Street, Carolina",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Ponce",
        "description":
            "Hourglass Ponce invites you to savor the richness of coffee in a tranquil setting that feels like home.",
        "address": "67 Ponce de Leon Avenue, Ponce",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Caguas",
        "description":
            "Caguas' haven for coffee aficionados – Hourglass Caguas, where passion and quality unite in every cup.",
        "address": "89 Juana Díaz Street, Caguas",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
    ],
    [
      {
        "name": "Hourglass New York",
        "description":
            "Immerse yourself in the energy of New York at Hourglass, a coffee destination in the city that never sleeps.",
        "address": "150 Fifth Avenue, New York",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass San Francisco",
        "description":
            "Discover the flavors of San Francisco at Hourglass, where artisanal coffee meets breathtaking views.",
        "address": "200 Market Street, San Francisco",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
      {
        "name": "Hourglass Chicago",
        "description":
            "Chicago's coffee gem – Hourglass Chicago, where quality meets comfort in every cup served.",
        "address": "300 Michigan Avenue, Chicago",
        "timings": "Monday - Sunday: 6:00 AM - 9:45 PM"
      },
    ],
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MyAnimationProvider animationProvider = MyAnimationProvider();
    CheckBoxStates state = ref.watch(valueProvider);
    IsExpandedValues isExpandedValueStates =
        ref.watch(isExpandedValueStatesProvider);

    Map<String, dynamic> firstFoldList = {
      "Australia": [isExpandedValueStates.isExpanded1, 0],
      "Canada": [isExpandedValueStates.isExpanded2, 1],
      "Rico": [isExpandedValueStates.isExpanded3, 2],
      "United States": [isExpandedValueStates.isExpanded4, 3],
    };

    double firstFoldHeight = MediaQuery.of(context).size.height * 0.6;
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);

    return Scaffold(
      endDrawer: const CustomAppBar(),
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: firstFoldHeight,
                  color: Colors.black,
                  child: GFAnimation(
                    turnsAnimation: animation,
                    controller: controller,
                    type: GFAnimationType.scaleTransition,
                    child: Image.network(
                      'https://picsum.photos/800/500',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    color: Colors.white,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Find A Location",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                SizedBox(
                                  height:
                                      0.05 * MediaQuery.sizeOf(context).height,
                                ),
                                SizedBox(
                                  width: 0.3 * MediaQuery.sizeOf(context).width,
                                  child: const Text(
                                    "Search using address city and state or ZIP",
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      0.03 * MediaQuery.sizeOf(context).height,
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width >
                                                    1000
                                                ? 500
                                                : 0.8 *
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            suffixIcon: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.search),
                                                SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            ),
                                            label: const Text('Find Location'),
                                            hintText: 'Enter your search',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Transform.rotate(
                                          angle: 45 * math.pi / 180,
                                          child: const Icon(
                                              Icons.navigation_rounded))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      0.04 * MediaQuery.sizeOf(context).height,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "I want to: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Checkbox(
                                        value: state.state1,
                                        onChanged: (onChanged) {
                                          ref
                                              .read(valueProvider.notifier)
                                              .changeState(0);
                                        }),
                                    const Text(
                                      "Buy",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Checkbox(
                                        value: state.state2,
                                        onChanged: (onChanged) {
                                          ref
                                              .read(valueProvider.notifier)
                                              .changeState(1);
                                        }),
                                    const Text(
                                      "Sell",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Get notified of new locations",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor:
                                          Color.fromARGB(255, 241, 240, 240),
                                      filled: true,
                                      hintText: 'Your Name',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor:
                                          Color.fromARGB(255, 241, 240, 240),
                                      filled: true,
                                      hintText: 'Your Phone',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor:
                                          Color.fromARGB(255, 241, 240, 240),
                                      filled: true,
                                      hintText: 'Your Email',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {},
                                  child: const SizedBox(
                                    width: 120,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "NOTIFY ME!",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {},
                                  child: const SizedBox(
                                    width: 220,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "SHOW ALL LOCATIONS",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              height: 720,
                              width: 800,
                              child: GoogleMap(
                                zoomControlsEnabled: false,
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                ExpansionPanelList(
                  expandIconColor: Colors.white,
                  expansionCallback: (int index, bool isExpanded) {
                    ref
                        .read(isExpandedValueStatesProvider.notifier)
                        .changeState(index);
                  },
                  children: firstFoldList.entries.map<ExpansionPanel>((data) {
                    return ExpansionPanel(
                        isExpanded: data.value[0],
                        canTapOnHeader: true,
                        backgroundColor: Colors.black,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          // Your header widget or logic here
                          return SizedBox(
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  data.key,
                                  style: const TextStyle(
                                      fontSize: 28, color: Colors.white),
                                )
                              ],
                            ),
                          );
                        },
                        body: StoreGrid(girdData: storeData[data.value[1]]));
                  }).toList(),
                ),
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}