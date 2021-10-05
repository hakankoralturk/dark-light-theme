import 'package:DarkTheme_Hive_Provider/providers/theme_provider.dart';
import 'package:DarkTheme_Hive_Provider/widgets/animated_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * .01),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .35,
                    width: width * .35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: themeProvider.themeMode().gradient,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 50),
                    child: ScaleTransition(
                      scale: _animationController.drive(
                          Tween<double>(begin: 0.0, end: 1.0)
                              .chain(CurveTween(curve: Curves.decelerate))),
                      alignment: Alignment.topRight,
                      child: Container(
                        width: width * .26,
                        height: width * .26,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: themeProvider.isLightTheme
                              ? Colors.white
                              : Color(0xFF26242E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.1),
              Text(
                "Stilinizi seçin",
                style: TextStyle(
                    fontSize: width * .06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * .03),
              Container(
                width: width * .6,
                child: Text(
                  "Gündüz veya gece. Arayüzü özelleştirin",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * .1),
              AnimatedToggle(
                values: ['Açık', 'Koyu'],
                onToggleCallback: (v) async {
                  await themeProvider.toogleThemeData();
                  setState(() {});
                  changeThemeMode(themeProvider.isLightTheme);
                },
              ),
              SizedBox(height: height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDot(
                    width: width * .022,
                    height: width * .022,
                    color: Color(0xFFD9D9D9),
                  ),
                  buildDot(
                      width: width * .055,
                      height: width * .022,
                      color: themeProvider.isLightTheme
                          ? Color(0xFF26242E)
                          : Colors.white),
                  buildDot(
                    width: width * .022,
                    height: width * .022,
                    color: Color(0xFFD9D9D9),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot({double width, double height, Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
      ),
    );
  }
}
