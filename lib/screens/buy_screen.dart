import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BuyScreen extends StatefulWidget {
  final String pId;

  BuyScreen({
    required this.pId,
  });

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? authorName;
  String? price;
  String? productName;

  void detUserData() async {
    User? user = _firebaseAuth.currentUser;
    String uid = user!.uid;
    final DocumentSnapshot UserDataBuy =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (UserDataBuy == null) {
      return;
    } else {
      setState(() {
        authorName = UserDataBuy.get('fullName');
      });
    }
  }

  void getData() async {
    final DocumentSnapshot proBuy = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.pId)
        .get();
    if (proBuy == null) {
      return;
    } else {
      setState(() {
        productName = proBuy.get('name');
        price = proBuy.get('price');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    User? user = _firebaseAuth.currentUser;
    String uid = user!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Buy Screen',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/main_screen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image.asset('images/visaa.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image.asset('images/payPal.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image.asset('images/masterCard.png'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Product Name :',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$productName',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Total Price : ',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$price \$',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Choose your payment method:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                Text('Visa',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue,
                                ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                Text('Master Card',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue,
                                ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                Text('PayPal',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue,
                                ),
                                ),

                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  if (true) {
                    final _generatedId = Uuid().v4();
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc('mt2jwFBQkRK23PMrqqnH')
                        .update({
                      'orders': FieldValue.arrayUnion(
                        [
                          {
                            'ProBuyId': _generatedId,
                            'time': Timestamp.now(),
                            'ProductID': widget.pId,
                            'UserID': uid,
                            'ProductName': productName,
                            'Price': price,
                            'name': authorName,
                          }
                        ],
                      ),
                    });
                    showSnackBar(
                        context: context,
                        message: 'Order uploaded successfully',
                        error: false);
                  }
                  setState(() {});
                } catch (e) {
                  showSnackBar(
                      context: context,
                      message: 'Something error',
                      error: true);
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.6),
                minimumSize: Size(30, 50),
                fixedSize: Size(300, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Buy Now',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
