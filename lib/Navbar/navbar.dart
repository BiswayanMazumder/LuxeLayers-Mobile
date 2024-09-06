import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:luxelayers/Add%20To%20Cart%20Page/cartpage.dart';
import 'package:luxelayers/Favourites%20Page/favourites.dart';
import 'package:luxelayers/Logged%20In%20Page/homepage.dart';
import 'package:luxelayers/Order%20Page/orderpage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  // final _controller = NotchBottomBarController(index: 0);

  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List screens = [HomePage(), FavouritePage(), CartPage(), MyOrders()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      backgroundColor: Colors.white,
      bottomNavigationBar: GNav(
          haptic: true,
          curve: Curves.bounceInOut,
          rippleColor: Colors.yellow,
          tabActiveBorder:
              Border.all(color: Colors.green, style: BorderStyle.solid),
          hoverColor: Colors.white,
          activeColor: Colors.black,
          color: Colors.deepPurpleAccent,
          // rippleColor: Colors.green,
          tabBackgroundColor: Colors.green,
          selectedIndex: _index,
          // tabBorder: Border.all(color: Colors.red),
          gap: 1,
          onTabChange: (value) {
            setState(() {
              _index = value;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'HomePage',
              rippleColor: Colors.green,
              backgroundColor: Colors.cyan,
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favourite',
              backgroundColor: Colors.lightGreenAccent,
            ),
            GButton(
              icon: Icons.shopping_cart,
              text: 'Cart',
              backgroundColor: Colors.deepOrangeAccent,
              haptic: true,
              debug: true,
            ),
            GButton(
              icon: Icons.person,
              text: 'Orders',
              backgroundColor: Colors.yellow,
              haptic: true,
              debug: true,
            ),
          ]),
    );
  }
}
