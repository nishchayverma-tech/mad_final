import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mad_final/controller/product_notifier.dart';
import 'package:mad_final/models/product.dart';
import 'package:mad_final/screens/product_list.dart';
import 'package:mad_final/utils/constants.dart';
import 'package:mad_final/widget/custom_button.dart';
import 'package:mad_final/widget/product_list.dart';


class AddProduct extends StatefulWidget 
{
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  String? _name;
  double? _price;
  String? _photoUrl;
  String? _description;
  int? _quantity;

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('useremail@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/alex_unsplash.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Product'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                FirebaseAuth.instance.signOut();
                await Future.delayed(Duration(seconds: 1));
                Navigator.pushNamed(context, RoutesConstants.LOGIN);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Product ID',
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product ID';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _id = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Product Name',
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Price',
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter valid price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Photo URL',
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter photo URL';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _photoUrl = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Description',
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Quantity', border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter quantity';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter valid quantity';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _quantity = int.parse(value);
                    }),
              ),
              SizedBox(height: 16.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: 'Add',
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        _formKey.currentState!.save();
                        productNotifier.addProduct(Product(_id!, _name!, _price, _photoUrl, _description, _quantity));
                        // addUser(User(_name!, _city!));
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 8),
                    CustomButton(
                      text: 'List',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductListScreen(),
                          ),
                        );
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ProductList(),
            ],
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
// TODO: Add product to database
// Navigator.pop(context);
      // Navigator.pushNamed(context, RoutesConstants.LOGIN);
    }
  }
}