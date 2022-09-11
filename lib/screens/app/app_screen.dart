import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/controller/fb_controllers/fb_auth_controllers.dart';
import 'package:ecommerce_fb/controller/fb_controllers/fb_firestore_controller.dart';
import 'package:ecommerce_fb/screens/app/category_screen.dart';
import 'package:ecommerce_fb/screens/app/products_screen.dart';
import 'package:ecommerce_fb/screens/app/profile_screen.dart';
import 'package:ecommerce_fb/widgets/slider_top_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

int _counter = 0;
String _content = '';

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? user = _firebaseAuth.currentUser;
    final uid = user!.uid;
    return Scaffold(
        drawer: Container(
          width: 250,
          child: Drawer(
            elevation: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 23,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Colors.blue.shade200,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('mohammed al shayah'),
                      subtitle: Text('mohammedalshayah@gmail.com'),
                      leading: CircleAvatar(
                        // backgroundColor: Colors.black,
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-3XIZuMnGZSM9c4c2huLkoHkKIA5BmMrKQsI1dpZR3sVFroorXKzhajLDONaANwxte4E&usqp=CAU',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ListTile(
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  leading: Icon(
                    Icons.man_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen(
                            userId: uid,
                          );
                        },
                      ));
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  leading: Icon(Icons.email, color: Colors.black, size: 30),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                ListTile(
                  title: Text('FQS',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  leading: Icon(Icons.question_answer,
                      color: Colors.black, size: 30),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                ListTile(
                  title: Text('Setting',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  leading: Icon(Icons.settings, color: Colors.black, size: 30),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                ListTile(
                  title: Text('Logout',
                      style: TextStyle(
                        fontSize: 23,
                      )),
                  leading: Icon(Icons.login, color: Colors.black, size: 30),
                  trailing: IconButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        content: const Text('Are you sure you want logout'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await FbAuthController().signOut();
                              Navigator.pushReplacementNamed(context, '/login_screen');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Spacer(),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                'Made with ❤',
                              )),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'by. mohammed alshayah',
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'E-Commerce',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 30,
                fontFamily: 'Redressed-Regular',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 30,
                ),
              );
            },
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            PopupMenuButton<String>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onSelected: (String selectedItem) {
                  if (_content != selectedItem) {
                    setState(() {
                      _content = selectedItem;
                      _counter = 0;
                    });
                  }
                },
                offset: Offset(15, 40),
                color: Colors.lightBlueAccent.withOpacity(0.5),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text(
                            'language',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'fontToAll',

                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.language,
                                color: Colors.black,

                              ))
                        ],
                      ),
                      value: ' language',
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text(
                            'Color',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'fontToAll',
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.color_lens,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      value: 'Color',
                    ),
                  ];
                }),
          ],
        ),
        body: ListView(
          children: [
            // SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 5, top: 20),
              child: Container(
                  height: 40,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        slider_top_app(
                          text: 'Food',
                          color: Colors.black.withOpacity(0.3),
                        ),
                        slider_top_app(
                          text: 'Cat',
                          color: Colors.amber.withOpacity(0.3),
                        ),
                        slider_top_app(
                          text: 'Pro',
                          color: Colors.blue.withOpacity(0.3),
                        ),
                        slider_top_app(
                          text: 'Fave',
                          color: Colors.green.withOpacity(0.3),
                        ),
                      ],
                    ),
                  )),
            ),

            Row(
              children: [
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return CategoryScreen(
                            proID: '',
                          );
                        },
                      ));
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
              child: StreamBuilder<QuerySnapshot>(
                  // stream: prodref.snapshots(),
                  stream: FbFireStoreController().getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> pro = snapshot.data!.docs;
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: (snapshot.data!).docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 130,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      // color:Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          '${pro[index].get('imageUrl')}',
                                          fit: BoxFit.fill,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Text(
                                            '${pro[index].get('name')}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Text(
                                            '${pro[index].get('price')} \$',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              size: 80,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'No Category',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ),
            Row(
              children: [
                // ignore: prefer_const_constructors
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Special Products ',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/new');
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            StreamBuilder<QuerySnapshot>(
                // stream: specialProduct.snapshots(),
                stream: FbFireStoreController().getSpecialProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> specialProduct =
                        snapshot.data!.docs;
                    return CarouselSlider.builder(
                      itemCount: specialProduct.length,
                      itemBuilder:
                          (BuildContext context, int itemIndex, snapshot) =>
                              // pro.isEmpty || pro== null ?Text('Waitting'):
                              Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.network(
                              '${specialProduct[itemIndex].get('imageUrl')}',
                              fit: BoxFit.cover,
                            ),
                            clipBehavior: Clip.antiAlias,
                            /**
                             * '${specialProducts[itemIndex]['imageUrl']}'
                             * Text('${SpecialProducts[itemIndex]['imageUrl']}'),
                             */
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Name : ${specialProduct[itemIndex].get('name')}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                      'Price :  ${specialProduct[itemIndex].get('price')} \$',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      options: CarouselOptions(height: 230.0),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            size: 80,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No Category',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),

            SizedBox(
              height: 15,
            ),

            Row(
              children: [
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ProductsScreen(
                            proID: '',
                          );
                        },
                      ));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
              child: StreamBuilder<QuerySnapshot>(
                  // stream: products.snapshots(),
                  stream: FbFireStoreController().getProducts1(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> pro = snapshot.data!.docs;
                      return SizedBox(
                        height: 400,
                        child: Container(
                          child: GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              // itemCount: pro.length,
                              itemCount: 4,
                              itemBuilder: (BuildContext ctx, index) {
                                return Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image(
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        image: NetworkImage(
                                          '${pro[index].get('imageUrl')}',
                                        ),
                                      ),
                                      PositionedDirectional(
                                        bottom: 0,
                                        end: 0,
                                        start: 0,
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional.center,
                                          color: Colors.black45,
                                          height: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${pro[index].get('name')}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              size: 80,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'No Category',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Text('');
                  }),
            ),
          ],
        ));
  }
}
