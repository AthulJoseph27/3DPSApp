/*
Collections -> Users, Orders
User-> role, email
Orders -> userId, timeOfCreation, status, price, paymentStatus, amount, fileUrl, description
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:print_shop/Auth/Order.dart';
import '../Auth/User.dart';

class Database{
  final String uid;
  static const String _PENDING = "PENDING";
  static const String _SHIPPED = "SHIPPED";

  Database({this.uid});

  static final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference orderCollection = FirebaseFirestore.instance.collection('Orders');

  Future<bool> alreadyRegistered()async{
    return (await userCollection.doc(uid).get()).exists;
  }

  Future<void> insertUser(String email, String role){
    return userCollection.doc(uid).set({
      'email':email,
      'role':role
    });
  }

  Future<User> getUser()async{
    Map<dynamic,dynamic> result = (await userCollection.doc(uid).get()).data();
    return User(email: result['email'],role: result['role']);
  }

  Future<List<Order>> getPendingOrders()async{
    List result = (await orderCollection.where('userId',isEqualTo: uid).where('status',isNotEqualTo: _SHIPPED).get()).docs;
    List<Order>orders = [];

    result.forEach((element) {
      Map<dynamic,dynamic>mp = element;
      orders.add(Order(
        userId: uid,
        status: mp['status'],
        price: mp['price'],
        paymentStatus: mp['paymentStatus'],
        description: mp['description'],
        amount: mp['amount'],
        fileUrls: mp['fileUrls'],
        timeOfCreation: mp['timeOfCreation']
      ));
    });

    return orders;
  }

  Future<void> placeOrder(Order order)async{
    order.userId = uid;
    order.status = _PENDING;
    return await orderCollection.doc().set(order);
  }

}