// All application routes are placed here
import 'package:flutter/cupertino.dart';
import 'package:mad_final/screens/add_product.dart';
import 'package:mad_final/screens/login.dart';
import 'package:mad_final/screens/register.dart';
import 'package:mad_final/utils/constants.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    RoutesConstants.LOGIN: (context) => const Login(),
    RoutesConstants.REGISTER: (context) => const Register(),
    RoutesConstants.ADD_PRODUCT: (context) => AddProduct(),
  };
}