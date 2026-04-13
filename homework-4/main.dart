import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Product layout demo home page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Listing")),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: <Widget>[
          ProductBox(
            name: "apple iPhone",
            description: "iPhone is the stylist phone ever",
            price: 1000,
            image: "iphone.png",
          ),
          ProductBox(
            name: "google Pixel",
            description: "Pixel is the most featureful phone ever",
            price: 800,
            image: "pixel.png",
          ),
          ProductBox(
            name: "huawei Laptop",
            description: "Laptop is most productive development tool",
            price: 2000,
            image: "laptop.png",
          ),
          ProductBox(
            name: "honor Tablet",
            description: "Tablet is the most useful device ever for meeting",
            price: 1500,
            image: "tablet.png",
          ),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final String name;
  final String description;
  final int price;
  final String image;

  ProductBox({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          children: <Widget>[
            Image.asset("assets/appimages/" + image),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(description),
                    Text("Price: $price"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
