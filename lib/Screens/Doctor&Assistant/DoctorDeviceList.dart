// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously, must_be_immutable
import 'dart:convert';
import 'package:agva_app/Bloc/bloc/post_bloc.dart';
import 'package:agva_app/Bloc/bloc/post_event.dart';
import 'package:agva_app/Bloc/bloc/post_state.dart';
import 'package:agva_app/Bloc/enums.dart';
import 'package:agva_app/Screens/Doctor&Assistant/DoctorDeviceDetails.dart';
import 'package:agva_app/Service/SocketService.dart';
import 'package:agva_app/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDeviceList extends StatefulWidget {
  final String hospital;
  final String hospitaladdress;

  const DoctorDeviceList(this.hospital, this.hospitaladdress);

  @override
  _DoctorDeviceListState createState() => _DoctorDeviceListState();
}

class _DoctorDeviceListState extends State<DoctorDeviceList> {
  late String hospital;
  late String hospitaladdress;
  bool isLoading = true;

  List<Map<String, dynamic>> focusedDevices = [];
  bool requestdata = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    print('i am in device list');
    context.read<BlocAllDevices>().add(FetchAllDevices(widget.hospital));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mytoken');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            ' ',
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
          //  StreamBuilder<AllDevicesState>(
        //     stream: context.read<BlocAllDevices>().allDevicesStream,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text(
                widget.hospital,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text(
                widget.hospitaladdress,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BlocAllDevices, AllDevicesState>(
                builder: (context, state) {
                  switch (state.postStatus) {
                    case PostStatus.loading:
                      return Center(child: Text('Loading...'));

                    case PostStatus.Failure:
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Devices Found',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 39, 14, 14),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                         
                          ],
                        ),
                      );

                    case PostStatus.success:
                      return ListView.builder(
                          itemCount: state.alldeviceList.length,
                          itemBuilder: (context, index) {
                            final item = state.alldeviceList[index];
                            var wardno = item.wardno.toString();
                            var hospital = item.hospital.toString();
                            var devicetype = item.devicetype.toString();
                            var deviceId = item.deviceId.toString();
                            var message = item.message.toString();
                            var addTofocus = item.addTofocus.toString();
                            var newColor;
                            print(addTofocus);
                            if (addTofocus.contains('true')) {
                              newColor = Color.fromARGB(255, 174, 34, 104);
                            } else {
                              newColor = Color.fromARGB(
                                  255, 58, 58, 58); // Or any default color
                            }
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorDeviceDetails(
                                                  deviceId,
                                                  SocketServices(),
                                                  wardno,
                                                  devicetype,
                                                  message,
                                                ),
                                              ),
                                            );

                                            if (result != null &&
                                                result == 'refresh') {}
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.green,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: newColor),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 58, 58, 58),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 11,
                                                          vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                devicetype,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.05,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01,
                                                              ),
                                                              Text(
                                                                hospital,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.03,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.005,
                                                              ),
                                                              Text(
                                                                'Ward No. $wardno',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.03,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                'PT. Salim Raza',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              Text(
                                                                '24 YEARS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.03,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01,
                                                              ),
                                                              Text(
                                                                '58 KG',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.03,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
