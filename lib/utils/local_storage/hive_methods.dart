// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import '../../model/data_ui_model/local_cart_model.dart';
//
// class HiveMethods  extends ChangeNotifier {
//   String hiveBox = 'cart_local_db';
//
//   //Adding cart model to hive db
//   Future<int?> addProduct( cartModel) async {
//     var box = await Hive.openBox(hiveBox); //open the hive box before writing
//
//     //check product already exist or not
//     for (int i = 0; i < box.length; i++) {
//       var cartMap = box.getAt(i);
//       if (cartModel.id == cartMap['id']) {
//         // incrementsValue(cartModel.id);
//         return null;
//       }
//     }
//
//     var mapCartData = cartModel.toMap(cartModel);
//
//     var result = await box.add(mapCartData);
//     //closing the hive box
//     Hive.close();
//     notifyListeners();
//     return result;
//   }
//
//   //Reading all the cart data
//   Future<List<LocalCartModel>> getProductLists() async {
//     var box = await Hive.openBox(hiveBox);
//     List<LocalCartModel> carts = [];
//
//     for (int i = 0; i < box.length; i++) {
//       var cartMap = box.getAt(i);
//
//       if (cartMap != null) {
//         carts.add(LocalCartModel.fromMap(Map.from(cartMap)));
//       }
//     }
//     return carts;
//   }
//
//   //Deleting one data from hive DB
//   deleteProduct(int id) async {
//     var box = await Hive.openBox(hiveBox);
//
//     await box.deleteAt(id);
//   }
//
//   //Deleting whole data from Hive
//   deleteAllProducts() async {
//     var box = await Hive.openBox(hiveBox);
//     await box.clear();
//   }
//
//   incrementsValue(id) async {
//     var box = await Hive.openBox(hiveBox);
//
//     for (int i = 0; i < box.length; i++) {
//       var cartMap = box.getAt(i);
//       if (id == cartMap['id'] && cartMap['quantity'] < 99) {
//         var key = box.keyAt(i);
//         LocalCartModel cartModel = LocalCartModel(
//           id: cartMap['id'],
//           quantity: cartMap['quantity'] + 1,
//           price: cartMap['price'],
//           image: cartMap['image'],
//           name: cartMap['name'],
//           offerAmount: cartMap['offerAmount'],
//           offerType: cartMap['offerType'],
//         );
//         var mapCartData = cartModel.toMap(cartModel);
//         await box.put(key, mapCartData);
//       }
//     }
//   }
//
//   decrementValue(id) async {
//     var box = await Hive.openBox(hiveBox);
//
//     for (int i = 0; i < box.length; i++) {
//       var cartMap = box.getAt(i);
//       if (id == cartMap['id'] && cartMap['quantity'] > 1) {
//         var key = box.keyAt(i);
//         LocalCartModel cartModel = LocalCartModel(
//           id: cartMap['id'],
//           quantity: cartMap['quantity'] - 1,
//           price: cartMap['price'],
//           image: cartMap['image'],
//           name: cartMap['name'],
//           offerAmount: cartMap['offerAmount'],
//           offerType: cartMap['offerType'],
//         );
//         var mapCartData = cartModel.toMap(cartModel);
//         await box.put(key, mapCartData);
//       }
//     }
//   }
// }
