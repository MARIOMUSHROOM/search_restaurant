import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_api_search_1/model/map_model.dart';
import 'package:test_api_search_1/provider/google_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchText = TextEditingController();
  bool isLoading = true;
  MapModel? data;
  callAPI() async {
    print("in call api");
    try {
      var res = await GoogleAPI().searchRestaurant(searchText.text);
      if (res.statusCode == 200) {
        var rs = json.decode(res.body);
        data = MapModel.fromJson(rs);
        print(data!.results!.length);
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text("ร้านอาหาร"),
        ),
        body: isLoading
            ? Center(child: Text("Loading..."))
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data!.results!.length,
                        itemBuilder: (context, index) {
                          Result only = data!.results![index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                                constraints: BoxConstraints(minHeight: 80),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(only.name ?? "-"),
                                    SizedBox(height: 5),
                                    Text(only.formattedAddress ?? "-"),
                                  ],
                                )),
                          );
                        }),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
        bottomSheet: Container(
          // height: 60,
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: searchText,
            style: TextStyle(),
            decoration: InputDecoration(
              fillColor: Colors.grey[50],
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchText.clear();
                },
                icon: Icon(Icons.close),
              ),
              hintText: "ค้นหา...",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.grey[100]!,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
            ),
            onEditingComplete: callAPI,
            onChanged: (String value) {
              callAPI();
            },
            // validator: (String? value) {
            //   _userNameValidator(value!);
            // },
          ),
        ),
      ),
    );
  }
}
