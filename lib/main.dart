import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xfff5f4f9),
        body: Container(
          width: double.infinity,
          child: FavoritesPage(),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPagState createState() => _FavoritesPagState();
}

class _FavoritesPagState extends State<FavoritesPage> {
  Widget _singleCard(
    String image,
    String title,
    String location,
    String price,
  ) {
    return CardCity(
      image: image,
      title: title,
      location: location,
      price: price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Favoritos",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "4 Resultados",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Color(
                            0xff170f58,
                          ),
                        ),
                        children: [
                          TextSpan(text: "Ordenar por: "),
                          TextSpan(
                            text: "Recientes",
                            style: TextStyle(
                              letterSpacing: -1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                _singleCard(
                  "https://image.freepik.com/vector-gratis/edificio-hotelero-ciudad_52683-10040.jpg",
                  "Paris",
                  "Seoul",
                  "\$476.000",
                ),
                _singleCard(
                  "https://image.freepik.com/vector-gratis/edificio-hotelero-ciudad_52683-10040.jpg",
                  "CummerDown",
                  "Sereland",
                  "\$376.000",
                ),
                _singleCard(
                  "https://image.freepik.com/vector-gratis/edificio-hotelero-ciudad_52683-10040.jpg",
                  "Paris",
                  "Seoul",
                  "\$476.000",
                ),
                _singleCard(
                  "https://image.freepik.com/vector-gratis/edificio-hotelero-ciudad_52683-10040.jpg",
                  "CummerDown",
                  "Sereland",
                  "\$376.000",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardCity extends StatefulWidget {
  CardCity({
    required this.image,
    required this.title,
    required this.location,
    required this.price,
  });

  final String image;
  final String title;
  final String location;
  final String price;

  @override
  _CardCityState createState() => _CardCityState();
}

class _CardCityState extends State<CardCity> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleAnimController;

  @override
  void initState() {
    super.initState();
    /**Controladores de todas las animaciones */
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );
    _scaleAnimController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );
    _scaleAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scaleAnimController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _scaleAnimController.stop();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    /** Cuando salga eliminar state widget */
    _animationController.dispose();
    _scaleAnimController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(_animationController),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xff170f58),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      debugPrint("Imprimiendo icon button");
                    },
                    icon: Icon(Icons.delete_outline),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _scaleAnimController,
            builder: (context, child) {
              return Transform.scale(
                scale: Tween<double>(
                  begin: 1,
                  end: 0.8,
                ).animate(_scaleAnimController).value,
                child: child,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onHorizontalDragUpdate: (dragDetails) {
                  if (dragDetails.primaryDelta! < 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                },
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0),
                    end: Offset(-0.25, 0),
                  ).animate(
                    _animationController,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 70,
                            width: 70,
                            child: Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            height: 85,
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: -1,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  widget.location,
                                  style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: -1,
                                    color: Color(0xffafafaf),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  widget.price,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: -1,
                                    color: Color(0xff170f58),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Color(0xff170f58),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  _scaleAnimController.forward();

                                  Timer(Duration(milliseconds: 200), () {
                                    Navigator.of(context).push(
                                      _createRoute(
                                        ProfilePage(),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _initAnimator;

  @override
  void initState() {
    super.initState();
    _initAnimator = new AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1300,
      ),
    );
    Timer(
      Duration(
        microseconds: 200,
      ),
      () => _initAnimator.forward(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _initAnimator.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://co.habcdn.com/photos/project/big/patio-interior-y-hall-de-habitaciones-primer-piso-181720.jpg",
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 28,
                    left: 14,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.keyboard_backspace,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _initAnimator.drive(CurveTween(
                        curve: Interval(0.2, 0.7, curve: Curves.easeInCirc),
                      )),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 16,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/22.jpg",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 59,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jack Beneth",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Text(
                                      "Propietario",
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: Colors.grey[200],
                                    ),
                                    child: IconButton(
                                      iconSize: 18,
                                      padding: EdgeInsets.all(0),
                                      color: Colors.grey[400],
                                      icon: Icon(Icons.phone),
                                      onPressed: () {
                                        print("Presiona para llamar");
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: Colors.grey[200],
                                    ),
                                    child: IconButton(
                                      iconSize: 18,
                                      padding: EdgeInsets.all(0),
                                      color: Colors.grey[400],
                                      icon: Icon(
                                        Icons.chat_bubble,
                                      ),
                                      onPressed: () {
                                        print("Presiona para escribir");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Presupuestos */
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FadeTransition(
                            opacity: _initAnimator.drive(
                              CurveTween(curve: Curves.ease),
                            ),
                            child: SlideTransition(
                              position: Tween(
                                begin: Offset(-0.6, 0),
                                end: Offset(0, 0),
                              ).animate(
                                CurvedAnimation(
                                    parent: _initAnimator, curve: Curves.ease),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      "Presupuesto XX",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$2.690.000",
                                    style: TextStyle(
                                      color: Color(0xff1700f58),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _initAnimator.drive(
                              CurveTween(curve: Curves.ease),
                            ),
                            child: SlideTransition(
                              position: Tween(
                                begin: Offset(0.6, 0),
                                end: Offset(0, 0),
                              ).animate(
                                CurvedAnimation(
                                  parent: _initAnimator,
                                  curve: Curves.ease,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.widgets,
                                      size: 18,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "\$3.962.000/mo",
                                            style: TextStyle(
                                              color: Color(0xff1700f58),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Ver capacidad",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Detalles de Sitio */

                    FadeTransition(
                      opacity: Tween<double>(
                        begin: 0,
                        end: 1,
                      ).animate(CurvedAnimation(
                        parent: _initAnimator,
                        curve: Interval(0.3, 1, curve: Curves.ease),
                      )),
                      child: Container(
                        margin: EdgeInsets.only(top: 24),
                        height: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Detalles de sitio",
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: GridView.count(
                                  padding: EdgeInsets.all(0),
                                  primary: false,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.3,
                                  children: [
                                    _singleFieldProperty("Habitaciones", "4"),
                                    _singleFieldProperty("Baños", "2"),
                                    _singleFieldProperty("Área", "680 mt2"),
                                    _singleFieldProperty("Antiguedad", "2015"),
                                    _singleFieldProperty("Parqueadero", "No"),
                                    _singleFieldProperty("Sector", "Alta"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Descripciones de sitio */
                    FadeTransition(
                      opacity: Tween<double>(
                        begin: 0,
                        end: 1,
                      ).animate(CurvedAnimation(
                        parent: _initAnimator,
                        curve: Interval(0.6, 1, curve: Curves.ease),
                      )),
                      child: SlideTransition(
                        position: Tween(
                          begin: Offset(0, 0.3),
                          end: Offset(0, 0),
                        ).animate(
                          CurvedAnimation(
                            parent: _initAnimator,
                            curve: Interval(0.6, 1, curve: Curves.ease),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsetsDirectional,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget _singleFieldProperty(String key, String val) {
  return Container(
    child: Column(
      children: [
        Text(
          key,
          style: TextStyle(
            color: Colors.grey[600],
            height: 1,
          ),
        ),
        Text(
          val,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
}

Route _createRoute(Widget childWidget) {
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, animation, seconAnim) => childWidget,
      transitionsBuilder: (BuildContext context, anim, seconAnim, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
              .animate(anim),
          child: Scaffold(
            body: child,
          ),
        );
      });
}
