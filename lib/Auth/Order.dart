class Order{
  String userId;
  String status;
  String price;
  String paymentStatus;
  String description;
  double amount;
  List<String> fileUrls;
  int timeOfCreation;
  Order({this.userId,this.status,this.price,this.paymentStatus,this.description,this.amount,this.fileUrls,this.timeOfCreation});
}