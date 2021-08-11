import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_codigo3_ui_3/pages/data_dummy.dart';

int touchedIndex = -1;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xfff7f7f7),
        ),
        actions: [
          // CircleAvatar(
          //   backgroundColor: Color(0xffCED1FF),
          //   child: Icon(Icons.person, color: Color(0xff5C48F2),),
          // ),
          Container(
            height: 42,
            width: 42,
            margin: EdgeInsets.only(right: 14.0),
            decoration: BoxDecoration(
              color: Color(0xffCED1FF),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xff5C48F2),
                width: 1.4,
              ),
            ),
            child: Icon(
              Icons.person,
              color: Color(0xff5C48F2),
            ),
          ),
        ],
      ),
      drawer: Drawer(), //añade un menu eneste caso al lado izquierdo superior
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mi files",
                    style: TextStyle(
                        color: Color(0xff565656),
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Color(0xff7f7f7f),
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 1.6,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
              Text("Gráfico Pie"),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      //color: Colors.blueAccent,
                      child: PageView.builder(
                        itemCount: miDataMap.length, // cantidad de Page a dibujar
                        scrollDirection: Axis.horizontal,
                        controller: PageController(
                          initialPage: 1, // inicio de Pagina en este caso el 1
                          viewportFraction:
                              0.5, //el tamaño de la Pages baja y esta entre 0 y 1
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          return ItemCarrouselWidget(index: i + 1,);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCarrouselWidget extends StatelessWidget {

  int index;
  ItemCarrouselWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    //int rnd = Random().nextInt(3) + 1;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 18.0, vertical: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: miDataMap[index]["backgroundColor"],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Icon(
              miDataMap[index]["icon"],//Icons.folder,
            color: miDataMap[index]["iconColor"],
            size: 30.0,
          ),
          Expanded(
            child: Container(),
          ),
          Text(
              miDataMap[index]["title"],//"Photes",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87.withOpacity(0.7),
                fontWeight: FontWeight.w500),
          ),
          Text(
              miDataMap[index]["number"],//"682 items",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Icon(
                miDataMap[index]["icon"],//Icons.lock_rounded,
                color: miDataMap[index]["iconColor"],//Color(0xff15C692),
              ),
              Text(
                "Private Folder",
                style:
                    TextStyle(color: miDataMap[index]["iconColor"],),
              )
            ],
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xff13d38e),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        throw Error();
    }
  });
}
