import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String imageURL;
  final String price;
  final String description;
  final double rating;

  ProductDetailScreen({
    this.description,
    this.imageURL,
    this.price,
    this.productName,
    this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          //height: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                //color: Colors.red,
                width: double.infinity,
                height: 300,
                child: Hero(
                  tag: imageURL,
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  productName,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '\$$price',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.shopping_cart), onPressed: () {}),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                      child: Row(
                        children: [
                          Text(
                            rating.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Card(
                  elevation: 15,
                  color: Colors.pink[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        //color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
