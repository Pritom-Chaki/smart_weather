import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:smart_weather/screens/landing_page.dart';

import '../../api/weather/weather_api.dart';
import '../../models/weather_search_model.dart';
import '../../utils/constant_data.dart';
import '../../utils/local_storage/local_store_manager.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({Key? key}) : super(key: key);

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController _controller = TextEditingController();
  List<WeatherSearchModel> _dataList = [];
  @override
  void initState() {
    super.initState();
  }

  _getSearchData(String location) {
    WeatherApi().getSearchApi(location).then((value) {
      setState(() {
        _dataList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: TextFormField(
          controller: _controller,
          onChanged: (value) {
            _getSearchData(value);
          },
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
      body: Center(
        child: _dataList.isNotEmpty
            ? ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () {
                      LocalStorageManager.saveData(AppConstant.location,
                          "${_dataList[i].lat!}, ${_dataList[i].lon!}");
                      pushNewScreen(
                        context,
                        screen: const LandingPage(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colors.grey.shade200,
                      child: Text(
                          "${_dataList[i].name!}, ${_dataList[i].country!} "),
                    ),
                  );
                })
            : const Text("No Search Result Found"),
      ),
    );
  }
}
