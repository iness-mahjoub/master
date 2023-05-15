import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutterp/constant.dart';
import 'package:flutterp/screens/cart_list/cart_list_screen.dart';
import 'package:flutterp/screens/categorie_list/categorie_list_screen.dart';
import '../../../size_config.dart';
import '../../favorie_list/favoorie_list_screen.dart';
import '../login_success_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;
  List<dynamic> categories = [];
  List<dynamic> produits = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProduits();
  }

  Future<void> fetchCategories() async {
    final response =
          await http.get(Uri.parse('http://localhost:8000/api/categories'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        categories = jsonData['hydra:member'];
         categories.forEach((category) {
      category['image'] = 'http://localhost:8000/${category['image']}';
    });
      });
    } else {
      // Handle error
      print('Failed to fetch categories');
    }
  }
   Future<void> fetchProduits() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/produits'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        produits = jsonData['hydra:member'];
         produits.forEach((product) {
      product['image'] = 'http://localhost:8000/${product['image']}';
    });
      });
    } else {
      // Handle error
      print('Failed to fetch categories');
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToFavoritePage() {
    Navigator.pushNamed(context, FavorieList.routeName);
  } void _navigateToCatgorieList() {
    Navigator.pushNamed(context, CategoryListScreen.routeName);}
  void _navigateToHomePage() {
    Navigator.pushNamed(context, CartList.routeName);}

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

              //caintainner text categorie  
              Container(
                margin: EdgeInsets.only(top: 30, right: 290),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 5, 36, 89),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ),
              // end categorie name
              SizedBox(height: 30,),
              
              // container main of the list category 
               Container(
                height: 140,
                width: 380,
                child: ListView.separated(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Column(
                      children: [
                        // container of each catgeorie 
                                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 80,
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  // conatainer image
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(category['image']),
                        fit: BoxFit.cover, // Adjusts the image to fill the container
                      ),
                    ),
                    // end conatiner image 
                  ),
                ),
              ),//end container of each category 

                        SizedBox(height: 15),
                        Text(category['name']),
                      
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 18),
                ),
              ),
           
              //end of the main controller 
               Container(
                margin: EdgeInsets.only( top:10 ,right: 300),
                child: Text(
                  'Product',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 7, 57, 97),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                   
              ),
              SizedBox(height: 30,),
              // main controller product 
            Container(
  height: 700,
  width: 380,
  child: ListView.separated(
    itemCount: produits.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
      if (index % 2 == 0) {
        final product = produits[index];
        final nextIndex = index + 1;
        final nextProduct = nextIndex < produits.length ? produits[nextIndex] : null;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildProductContainer(context, product),
                if (nextProduct != null) buildProductContainer(context, nextProduct),
              ],
            ),
            SizedBox(height: 18),
          ],
        );
      } else {
        return Container();
      }
    },
    separatorBuilder: (context, index) => SizedBox(height: 18),
  ),
)


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
                  Navigator.pushNamed(context, LoginSuccessScreen.routeName);
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
  Container buildProductContainer(BuildContext context, Map<String, dynamic> product) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),

    width: MediaQuery.of(context).size.width * 0.4,
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 250,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(product['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            product['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
                textAlign: TextAlign.center,
       
          ),
                SizedBox(height: 10,),
        Text(
          '\$${product['prix']}',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 96, 209, 100),
            fontWeight: FontWeight.bold,
          ),
              textAlign: TextAlign.center,
        ),

        ],
      ),
    ),
  );
}

}

