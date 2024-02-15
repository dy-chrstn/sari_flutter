import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sari/pages/login/login.dart';
import 'package:sari/pages/product_details.dart';
import 'add_product_form.dart';
import 'record.dart';
import 'settings.dart';
import 'scanner.dart';
import 'analytics.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

void main() {
  runApp(const Login());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BottomNavBar(),
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
    );
  }
}

//bottom nav bar
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const HomePage(),
        const Analytics(),
        const Scanner(),
        const Record(),
        const Settings(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('lib/assets/home.svg'),
          inactiveIcon: SvgPicture.asset(
            'lib/assets/home.svg',
            color: const Color(0xFF557793),
          ),
          title: ("Home"),
          activeColorPrimary: const Color(0xFF1D3F58),
          inactiveColorPrimary: const Color(0xFF557793),
          activeColorSecondary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'lib/assets/analytics.svg',
          ),
          inactiveIcon: SvgPicture.asset(
            'lib/assets/analytics.svg',
            color: const Color(0xFF557793),
          ),
          title: ("Analytics"),
          activeColorPrimary: const Color(0xFF1D3F58),
          inactiveColorPrimary: const Color(0xFF557793),
          activeColorSecondary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'lib/assets/scanner.svg',
          ),
          inactiveIcon: SvgPicture.asset(
            'lib/assets/scanner.svg',
            color: const Color(0xFF557793),
          ),
          title: ("Scanner"),
          activeColorPrimary: const Color(0xFF1D3F58),
          inactiveColorPrimary: const Color(0xFF557793),
          activeColorSecondary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('lib/assets/record.svg'),
          inactiveIcon: SvgPicture.asset(
            'lib/assets/record.svg',
            color: const Color(0xFF557793),
          ),
          title: ("Reccord"),
          activeColorPrimary: const Color(0xFF1D3F58),
          inactiveColorPrimary: const Color(0xFF557793),
          activeColorSecondary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('lib/assets/settings.svg'),
          inactiveIcon: SvgPicture.asset(
            'lib/assets/settings.svg',
            color: const Color(0xFF557793),
          ),
          title: ('Settings'),
          activeColorPrimary: const Color(0xFF1D3F58),
          inactiveColorPrimary: const Color(0xFF557793),
          activeColorSecondary: Colors.white,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: const Color(0xFFEEF3F9),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style10, // Choose the nav bar style with this property.
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search overlay
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFB3CDE4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    const Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF1D3F58),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_alt,
                          color: Color(0xFF1D3F58),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // GridView.builder for the products section
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8333,
                  ),
                  itemCount: 16, // Adjust the itemCount based on your data
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to ProductDetails screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetails(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/century.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8, top: 8),
                              child: Text(
                                '380 grams',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Century Tuna',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 3),
                              child: Text(
                                '₱49.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFC80D0D),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductForm()),
          );
        },
        backgroundColor: const Color(0xFF1D3F58),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Suggestions 1'),
          onTap: () {
            query = 'Suggestions 1';
          },
        ),
        ListTile(
          title: const Text('Suggestions 2'),
          onTap: () {
            query = 'Suggestions 2';
          },
        ),
      ],
    );
  }
}
