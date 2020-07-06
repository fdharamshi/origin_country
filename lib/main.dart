import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            brightness: Brightness.light
          )),
      title: 'Origin Country',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Origin Country",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter Barcode", border: InputBorder.none),
              ),
            ),
            RaisedButton(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text("Find the Country"),
              ),
              onPressed: () {
                findCountry(controller.text);
              },
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Divider(
                thickness: 2,
              ),
            ),
            RaisedButton(
              color: Colors.green,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/scan.png',
                      height: 40,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Scan a Barcode",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              onPressed: () async {
                var result = await BarcodeScanner.scan();
                findCountry(result.rawContent);
              },
            )
          ],
        ),
      ),
    );
  }

  void findCountry(String barcode) {

    //A function to find the country. You can call it a controller function.

    int first3 = int.parse(barcode.substring(0, 3));

    Map countryMap = getCountry(first3);
//    print("${countryMap['country']} - ${countryMap['code']}");
    if (countryMap == null) {
      Fluttertoast.showToast(
          msg: "Product Origin not identified", toastLength: Toast.LENGTH_LONG);
    }

    //showDialog is a ready function to show a Dialog Box.
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          _countryDialog(countryMap['Country'], countryMap['Code']),
    );
  }

  Widget _countryDialog(String country, String code) {

    //This function will return a dialog box widget that will be popped up to show the country of the product.

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(66),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                //The images for country flags are stored in images/countryflags
                'images/countryflags/$code.png',
                height: 75,
              ),
              SizedBox(
                height: 25,
              ),
              Text("This Product is from : $country"),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> getCountry(int x) {

    // This function will return the country name and country Code on the basis of first three numbers of the barcode string.

    if (x == 890)
      return {'Country': 'India', 'Code': 'in'};
    else if (x >= 690 && x <= 699)
      return {'Country': 'China', 'Code': 'cn'};
    else if (x >= 000 && x <= 019)
      return {'Country': 'United States of America and Canada', 'Code': 'us'};
    else if (x >= 030 && x <= 039)
      return {'Country': 'United States of America ', 'Code': 'us'};
    else if (x >= 060 && x <= 099)
      return {'Country': 'United States of America and Canada', 'Code': 'us'};
    else if (x >= 100 && x <= 139)
      return {'Country': 'United States of America', 'Code': 'us'};
    else if (x >= 300 && x <= 379)
      return {'Country': 'France and Monaco', 'Code': 'fr'};
    else if (x == 380)
      return {'Country': 'Bulgaria', 'Code': 'bg'};
    else if (x == 383)
      return {'Country': 'Slovenia', 'Code': 'si'};
    else if (x == 385)
      return {'Country': 'Croatia', 'Code': 'hr'};
    else if (x == 387)
      return {'Country': 'Bosnia and Herzegovina', 'Code': 'ba'};
    else if (x == 389)
      return {'Country': 'Montenegro', 'Code': 'me'};
    else if (x == 390)
      return {'Country': 'Kosovo', 'Code': 'xk'};
    else if (x >= 400 && x <= 440)
      return {'Country': 'Germany', 'Code': 'de'};
    else if (x >= 459 && x <= 459)
      return {'Country': 'Japan', 'Code': 'jp'};
    else if (x >= 460 && x <= 469)
      return {'Country': 'Russia', 'Code': 'ru'};
    else if (x == 470)
      return {'Country': 'Kyrgyzstan', 'Code': 'kg'};
    else if (x == 471)
      return {'Country': 'Taiwan', 'Code': 'tw'};
    else if (x == 474)
      return {'Country': 'Estonia', 'Code': 'ee'};
    else if (x == 475)
      return {'Country': 'Latvia', 'Code': 'lv'};
    else if (x == 476)
      return {'Country': 'Azerbaijan', 'Code': 'az'};
    else if (x == 477)
      return {'Country': 'Lithuania', 'Code': 'lt'};
    else if (x == 478)
      return {'Country': 'Uzbekistan', 'Code': 'uz'};
    else if (x == 479)
      return {'Country': 'Sri Lanka', 'Code': 'lk'};
    else if (x == 480)
      return {'Country': 'Philippines', 'Code': 'ph'};
    else if (x == 481)
      return {'Country': 'Belarus', 'Code': 'by'};
    else if (x == 482)
      return {'Country': 'Ukraine', 'Code': 'ua'};
    else if (x == 483)
      return {'Country': 'Turkmenistan', 'Code': 'tm'};
    else if (x == 484)
      return {'Country': 'Moldova', 'Code': 'md'};
    else if (x == 485)
      return {'Country': 'Armenia', 'Code': 'am'};
    else if (x == 486)
      return {'Country': 'Georgia', 'Code': 'ge'};
    else if (x == 487)
      return {'Country': 'Kazakhstan', 'Code': 'kz'};
    else if (x == 488)
      return {'Country': 'Tajikistan', 'Code': 'tj'};
    else if (x == 489)
      return {'Country': 'Hong Kong', 'Code': 'hk'};
    else if (x >= 490 && x <= 499)
      return {'Country': 'Japan', 'Code': 'jp'};
    else if (x >= 500 && x <= 509)
      return {'Country': 'United Kingdom', 'Code': 'gb'};
    else if (x >= 520 && x <= 521)
      return {'Country': 'Greece', 'Code': 'gr'};
    else if (x == 528)
      return {'Country': 'Lebanon', 'Code': 'lb'};
    else if (x == 529)
      return {'Country': 'Cyprus', 'Code': 'cy'};
    else if (x == 530)
      return {'Country': 'Albania', 'Code': 'al'};
    else if (x == 531)
      return {'Country': 'North Macedonia', 'Code': 'mk'};
    else if (x == 535)
      return {'Country': 'Malta', 'Code': 'mt'};
    else if (x == 539)
      return {'Country': 'Ireland', 'Code': 'ie'};
    else if (x >= 540 && x <= 549)
      return {'Country': 'Belgium and Luxembourg', 'Code': 'be'};
    else if (x == 560)
      return {'Country': 'Portugal', 'Code': 'pt'};
    else if (x == 569)
      return {'Country': 'Icelnad', 'Code': 'is'};
    else if (x >= 570 && x <= 579)
      return {'Country': 'Denmark, Faroe Islands and Greenland', 'Code': 'dk'};
    else if (x == 590)
      return {'Country': 'Poland', 'Code': 'pl'};
    else if (x == 594)
      return {'Country': 'Romania', 'Code': 'ro'};
    else if (x == 599)
      return {'Country': 'Hungary', 'Code': 'hu'};
    else if (x >= 600 && x <= 601)
      return {'Country': 'South Africa', 'Code': 'za'};
    else if (x == 603)
      return {'Country': 'Ghana', 'Code': 'gh'};
    else if (x == 604)
      return {'Country': 'Senegal', 'Code': 'sn'};
    else if (x == 608)
      return {'Country': 'Bahrain', 'Code': 'bh'};
    else if (x == 609)
      return {'Country': 'Mauritius', 'Code': 'mu'};
    else if (x == 611)
      return {'Country': 'Morocco', 'Code': 'ma'};
    else if (x == 613)
      return {'Country': 'Algeria', 'Code': 'dz'};
    else if (x == 615)
      return {'Country': 'Nigeria', 'Code': 'ng'};
    else if (x == 616)
      return {'Country': 'Kenya', 'Code': 'ke'};
    else if (x == 617)
      return {'Country': 'Cameroon', 'Code': 'cm'};
    else if (x == 618)
      return {'Country': 'Ivory Coast', 'Code': 'cl'};
    else if (x == 619)
      return {'Country': 'Tunisia', 'Code': 'tn'};
    else if (x == 620)
      return {'Country': 'Tanzania', 'Code': 'tz'};
    else if (x == 621)
      return {'Country': 'Syria', 'Code': 'sy'};
    else if (x == 622)
      return {'Country': 'Egypt', 'Code': 'eg'};
    else if (x == 623)
      return {'Country': 'Brunei', 'Code': 'bn'};
    else if (x == 624)
      return {'Country': 'Libya', 'Code': 'ly'};
    else if (x == 625)
      return {'Country': 'Jordon', 'Code': 'jo'};
    else if (x == 626)
      return {'Country': 'Iran', 'Code': 'ir'};
    else if (x == 627)
      return {'Country': 'Kuwait', 'Code': 'kw'};
    else if (x == 628)
      return {'Country': 'Saudi Arabia', 'Code': 'sa'};
    else if (x == 629)
      return {'Country': 'United Arab Emirates', 'Code': 'ae'};
    else if (x == 630)
      return {'Country': 'Qatar', 'Code': 'qa'};
    else if (x >= 640 && x <= 649)
      return {'Country': 'Finland', 'Code': 'fi'};
    else if (x >= 700 && x <= 709)
      return {'Country': 'Norway', 'Code': 'no'};
    else if (x == 729)
      return {'Country': 'Israel', 'Code': 'il'};
    else if (x >= 730 && x <= 739)
      return {'Country': 'Sweden', 'Code': 'swe'};
    else if (x == 740)
      return {'Country': 'Guatemala', 'Code': 'gt'};
    else if (x == 741)
      return {'Country': 'El Salvador', 'Code': 'sv'};
    else if (x == 742)
      return {'Country': 'Honduras', 'Code': 'hn'};
    else if (x == 743)
      return {'Country': 'Nicaragua', 'Code': 'ni'};
    else if (x == 744)
      return {'Country': 'Costa Rica', 'Code': 'cr'};
    else if (x == 745)
      return {'Country': 'Panama', 'Code': 'pa'};
    else if (x == 746)
      return {'Country': 'Dominican Republic', 'Code': 'do'};
    else if (x == 750)
      return {'Country': 'Mexico', 'Code': 'mx'};
    else if (x >= 754 && x <= 755)
      return {'Country': 'Canada', 'Code': 'ca'};
    else if (x == 759)
      return {'Country': 'Venezuela', 'Code': 've'};
    else if (x >= 760 && x <= 769)
      return {'Country': 'Switzerland and Liechtenstein', 'Code': 'ch'};
    else if (x >= 770 && x <= 771)
      return {'Country': 'Colombia', 'Code': 'co'};
    else if (x == 773)
      return {'Country': 'Uruguay', 'Code': 'uy'};
    else if (x == 775)
      return {'Country': 'Peru', 'Code': 'pe'};
    else if (x == 777)
      return {'Country': 'Bolivia', 'Code': 'bo'};
    else if (x >= 778 && x <= 779)
      return {'Country': 'Argentina', 'Code': 'ar'};
    else if (x == 780)
      return {'Country': 'Chile', 'Code': 'cl'};
    else if (x == 784)
      return {'Country': 'Paraguay', 'Code': 'py'};
    else if (x == 786)
      return {'Country': 'Ecuador', 'Code': 'ec'};
    else if (x >= 789 && x <= 790)
      return {'Country': 'Brazil', 'Code': 'br'};
    else if (x >= 800 && x <= 839)
      return {'Country': 'Italy, San Marino and Vatican City', 'Code': 'it'};
    else if (x >= 840 && x <= 849)
      return {'Country': 'Spain and Andorra', 'Code': 'es'};
    else if (x == 850)
      return {'Country': 'Cuba', 'Code': 'cu'};
    else if (x == 858)
      return {'Country': 'Slovakia', 'Code': 'sk'};
    else if (x == 859)
      return {'Country': 'Czech Rupublic', 'Code': 'cz'};
    else if (x == 860)
      return {'Country': 'Serbia', 'Code': 'rs'};
    else if (x == 865)
      return {'Country': 'Mongolia', 'Code': 'mn'};
    else if (x == 867)
      return {'Country': 'North Korea', 'Code': 'kp'};
    else if (x >= 868 && x <= 869)
      return {'Country': 'Turkey', 'Code': 'tr'};
    else if (x >= 870 && x <= 879)
      return {'Country': 'Netherlands', 'Code': 'nl'};
    else if (x == 880)
      return {'Country': 'South Korea', 'Code': 'kr'};
    else if (x == 883)
      return {'Country': 'Myanmar', 'Code': 'mm'};
    else if (x == 884)
      return {'Country': 'Cambodia', 'Code': 'kh'};
    else if (x == 885)
      return {'Country': 'Thailand', 'Code': 'th'};
    else if (x == 888)
      return {'Country': 'Singapore', 'Code': 'sg'};
    else if (x == 893)
      return {'Country': 'Vietnam', 'Code': 'vn'};
    else if (x == 896)
      return {'Country': 'Pakistan', 'Code': 'pk'};
    else if (x == 899)
      return {'Country': 'Indonesia', 'Code': 'id'};
    else if (x >= 900 && x <= 919)
      return {'Country': 'Austria', 'Code': 'at'};
    else if (x >= 930 && x <= 939)
      return {'Country': 'Australia', 'Code': 'au'};
    else if (x >= 940 && x <= 949)
      return {'Country': 'New Zealand', 'Code': 'nz'};
    else if (x == 955)
      return {'Country': 'Malaysia', 'Code': 'my'};
    else if (x == 958) return {'Country': 'Macau', 'Code': 'mo'};
  }
}
