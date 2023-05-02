import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mad_final/controller/product_notifier.dart';
import 'package:mad_final/models/product.dart';

class ProductList extends StatelessWidget {
//  final List<User> users;
//   final Function(User) onDelete;

  ProductList();

  // const UserList({ Key? key, required this.users, required this.onDelete }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // only using it for printing the userlist length
     ProductNotifier userNotifier = Provider.of<ProductNotifier>(context);


    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ProductNotifier>(builder: (_,notifier,__) => 
                  Text(
                    'Name: ${notifier.productList[index].name}',
                    style: TextStyle(fontSize: 18),
                  ),
                  ),
                  
                  Consumer<ProductNotifier>(builder: (_,notifier,__) => 
                  Text(
                    'Price: ${notifier.productList[index].price}',
                    style: TextStyle(fontSize: 18),
                  ),
                  ),
                ],
              ),
              Consumer<ProductNotifier>(
                builder: (_, notifier, __)=>
                Text("Add"),
              )
            ],
          ),
          ),
      ),
      itemCount: userNotifier.productList.length,
      );
  }
}