import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';
import 'package:shop_x/controllers/orders_controller.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  // OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderCollection = FirebaseFirestore.instance
        .collection('Order')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} orders');
    final OrderController orderController =
        Get.put(OrderController(), permanent: true);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          actions: [
            IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  print(orderController.orderList[0].price);
                }),
          ],
        ),
        body: StreamBuilder(
          stream: orderCollection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data.docs.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(
                      'https://image.shutterstock.com/image-vector/shopping-basket-vector-icon-illustration-600w-678796057.jpg',
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No items added in your cart yet, add some !!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map<Widget>((documents) {
                  return ListTile(
                    title: Text(
                      DateFormat('dd/MM/yyyy        hh:mm').format(
                        documents['dateTime'].toDate(),
                      ),
                    ),
                    subtitle: Text(
                      'Total Price : \$${documents['totalPrice']}',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle_outlined),
                      onPressed: () {},
                    ),
                  );
                }).toList(),
              );
            }
          },
        ));
  }
}
