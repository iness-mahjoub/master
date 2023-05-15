import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryListScreen extends StatefulWidget {
  static const String routeName = "/category_list";

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List categories = [];
  List filteredCategories = [];
  TextEditingController searchController = TextEditingController();

  Future<List<dynamic>> getCategories() async {
    String url ="http://localhost:8000/api/categories";
    var response = await http.get(Uri.parse(url,));
    var data = jsonDecode(response.body);
    var categories = data['hydra:member'];

    // replace the image field value with complete URL
    categories.forEach((category) {
      category['image'] = 'http://localhost:8000/${category['image']}';
    });

    return categories;
  }

  @override
  void initState() {
    super.initState();
  }

  void filterCategories(String query) {
    setState(() {
      filteredCategories = categories.where((category) {
        String categoryName = category['name'];
        return categoryName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Column(
        children: [
    Padding(
  padding: const EdgeInsets.symmetric(horizontal: 17.0),
  child: TextField(
    controller: searchController,
    style: TextStyle(fontSize: 10.0),
    decoration: InputDecoration(
      hintText: "Search",
    
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onChanged: (value) {
      filterCategories(value);
    },
  ),
),

          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  categories = snapshot.data!;
                  filteredCategories = categories;
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    children: List.generate(filteredCategories.length, (index) {
                      return InkWell(
                        onTap: () {
                          // Navigate to category details screen
                          // using Navigator.push() method
                        },

                        // containe design lsit 
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(filteredCategories[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                filteredCategories[index]['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // end contain design list 
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
