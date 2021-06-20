import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/orders_controller.dart';

class OrderScreen extends StatelessWidget {
  // OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: orderController.orderList.length,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${orderController.orderList[index].price}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${orderController.orderList[index].dateTime}',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ));
        },
      ),
    );
  }
}
