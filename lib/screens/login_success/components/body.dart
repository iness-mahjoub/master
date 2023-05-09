import 'package:flutter/material.dart';
import 'package:flutterp/components/default_button.dart';
import 'package:flutterp/constant.dart';
import 'package:flutterp/screens/cart_list/cart_list_screen.dart';
import 'package:flutterp/screens/categorie_list/categorie_list_screen.dart';



import '../../../size_config.dart';
import '../../favorie_list/componenets/body.dart';
import '../../favorie_list/favoorie_list_screen.dart';
import '../login_success_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToFavoritePage() {
    // This function will be called when the favorite icon is pressed
    // Add your navigation logic here
    Navigator.pushNamed(context,FavorieList.routeName);
    
  }
  void _navigateToCatgorieList() {
    // This function will be called when the favorite icon is pressed
    // Add your navigation logic here
    Navigator.pushNamed(context,CategoryListScreen.routeName);
    
  }
  void _navigateToHomePage() {
    // This function will be called when the favorite icon is pressed
    // Add your navigation logic here
    Navigator.pushNamed(context,CartList.routeName);
    
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.7,
                      height: 50,
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Search Product",
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToFavoritePage,
                      child: Container(
                        height: getProportionateScreenWidth(46),
                        width: getProportionateScreenWidth(46),
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: kPrimaryColor,
                          size: getProportionateScreenWidth(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  // Navigate to the home screen
                 Navigator.pushNamed(context,LoginSuccessScreen.routeName);
                },
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.category),
                onPressed: () {
                  // Navigate to the categories screen
                 Navigator.pushNamed(context,CategoryListScreen.routeName);
                },
              ),
              label: 'Categories',
            ),
           BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigate to the cart screen
                 Navigator.pushNamed(context,CartList.routeName);
                },
              ),
              label: 'Cart'),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}


