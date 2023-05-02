import 'package:flutter/material.dart';
import 'package:mad_final/models/message.dart';
import 'package:mad_final/models/seller.dart';
import 'package:mad_final/screens/add_product.dart';
import 'package:mad_final/services/seller_operations.dart';
import 'package:mad_final/utils/constants.dart';
import 'package:mad_final/utils/toast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController sellerIdCtrl;
  late TextEditingController passwordCtrl;
  late TextEditingController appIdCtrl;

  @override
  void initState() {
    super.initState();
    sellerIdCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    appIdCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register Here'),
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                  controller: sellerIdCtrl,
                  decoration: InputDecoration(
                      hintText: 'Enter your username here',
                      prefixIcon: Icon(Icons.login),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter valid name';
                    }
                    return null;
                  }),
            ),
            // SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter your password here',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: appIdCtrl,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter your App Id here',
                    prefixIcon: Icon(Icons.app_registration),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter your email here',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                initialValue: '',
                    autovalidateMode: AutovalidateMode.always,
                    validator: (String? value) {
                      print("Validating email field...");
                      var regex = RegExp(r"^[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+$");
                      if (!regex.hasMatch(value!)) {
                        return "Provide a valid email";
                      }
                      return null;
                    }
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter your address here',
                    prefixIcon: Icon(Icons.house),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.all(16),
                    child: ElevatedButton(
                        onPressed: () {
                          _register();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AddProduct()));
                        },
                        child: Text('Add'))),
                Container(
                    margin: EdgeInsets.all(16),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')))
              ],
            )
          ],
        )));
  }

  // fetching values from text controllers
  dynamic _register() async {
    String message = '';
    String sellerId = sellerIdCtrl.text;
    String password = passwordCtrl.text;
    String appId = appIdCtrl.text;
    // checking if correct App Id is entered or not!
    if (appId != Constants.APP_ID) {
      message = 'Wrong App Id!';
      return;
    } else {
      // initialize the Seller object and send it to add() method.
      Seller sellerObj =
          Seller.takeInput(userId: sellerId, password: password, appId: appId);
      SellerOperations opr = SellerOperations();
      Message msgObj = await opr.add(sellerObj);
      print(msgObj.message);
      createToast(msgObj.message, context);

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }
  }
}
