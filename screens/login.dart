import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mad_final/controller/product_notifier.dart';
import 'package:mad_final/models/message.dart';
import 'package:mad_final/models/seller.dart';
import 'package:mad_final/screens/register.dart';
import 'package:mad_final/services/seller_operations.dart';
import 'package:mad_final/utils/constants.dart';
import 'package:mad_final/utils/toast.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController sellerCtrl;
  late TextEditingController passwordCtrl;
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sellerCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(Constants.LOGIN_IMAGE),
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              controller: sellerCtrl,
              decoration: InputDecoration(
                  hintText: 'Enter your username here',
                  prefixIcon: Icon(Icons.login),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: () {
                        _doLogin().then((value) async {
                          if (value == 1) {
                            await Future.delayed(Duration(seconds: 1));
                            Navigator.pushNamed(
                                context, RoutesConstants.ADD_PRODUCT);
                          }
                        });
                      },
                      child: Text('Login'))),
              Container(
                  margin: EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        Navigator.pushNamed(context, RoutesConstants.REGISTER);
                      },
                      child: Text('Register')))
            ],
          )
        ],
      )),
    ));
  }

  Future<int> _doLogin() async {
    String sellerId = sellerCtrl.text;
    String password = passwordCtrl.text;
    Seller seller = Seller.takeInput(
        userId: sellerId, password: password, appId: Constants.APP_ID);
    SellerOperations opr = SellerOperations();
    Message msgObject = await opr.read(seller);
    createToast(msgObject.message, context);
    return msgObject.code;
  }
}