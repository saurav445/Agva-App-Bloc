// // ignore_for_file: prefer_const_constructors

// import 'dart:convert';
// import 'package:agva_app/config.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'DoctorDeviceList.dart';
// import 'package:http/http.dart' as http;

// class DoctorHospitals extends StatefulWidget {
//   DoctorHospitals();

//   @override
//   _DoctorHospitalsState createState() => _DoctorHospitalsState();
// }

// class _DoctorHospitalsState extends State<DoctorHospitals> {
//   late SharedPreferences prefs;
//   bool isLoading = true;
//   List<dynamic> hospitals = [];
//   Map<String, bool> expansionStates = {};

//   @override
//   void initState() {
//     super.initState();
//     getHospitals();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.portraitUp,
//     ]);
//   }

//   List<String> projectsForHospital = [
//     'AgVa PRO',
//     'Emergency',
//   ];

//   Future<void> getHospitals() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? mytoken = prefs.getString('mytoken');
//     if (mytoken != null) {
//       var response = await http.get(Uri.parse(gethospitallist), headers: {
//         "Authorization": 'Bearer $mytoken',
//       });
//       var jsonResponse = jsonDecode(response.body);
//       print(jsonResponse);
//       if (jsonResponse['statusCode'] == 200) {
//         setState(() {
//           hospitals = jsonResponse['data'];

//           hospitals.forEach((hospital) {
//             expansionStates[hospital['Hospital_Name']] = false;
//             isLoading = false;
//           });
//         });
//       } else {
//         print('Invalid User Credential : ${response.statusCode}');
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         title: Text(
//           'HOSPITALS',
//           style: TextStyle(
//             fontFamily: 'Avenir',
//             color: Color.fromARGB(255, 255, 255, 255),
//           ),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: getHospitals,
//         child: Stack(children: [
//            if (isLoading)
//           SizedBox(
//               height: 1,
//               child: LinearProgressIndicator(color: Colors.pink))
//          else if (hospitals.isEmpty)
//             SizedBox(
//               width: double.infinity,

//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'No Hospital List Found',
//                     style: TextStyle(
//                       fontFamily: 'Avenir',
//                       color: Color.fromARGB(255, 158, 158, 158),
//                       fontSize: MediaQuery.of(context).size.width * 0.05,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Please Contact Doctor to Access List',
//                     style: TextStyle(
//                       fontFamily: 'Avenir',
//                       color: Color.fromARGB(255, 218, 218, 218),
//                       fontSize: MediaQuery.of(context).size.width * 0.04,
//                       fontWeight: FontWeight.w100,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           else
//             ListView(children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: buildPatientListWidgets(),
//                 ),
//               ),
//             ]),
//         ]),
//       ),
//     );
//   }

//   List<Widget> buildPatientListWidgets() {
//     return hospitals.map((hospital) {
//       String hospitalname = '${hospital['Hospital_Name']}';
//       String city = '${hospital['City']}';
//       String pincode = '${hospital['Pincode']}';
//       String hospitaladdress = '${hospital['Hospital_Address']}';
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 expansionStates[hospitalname] = !expansionStates[hospitalname]!;
//               });
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Color.fromARGB(255, 51, 50, 50),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(top: 5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             hospitalname,
//                             style: TextStyle(
//                               fontFamily: 'Avenir',
//                               color: Color.fromARGB(255, 218, 218, 218),
//                               fontSize:
//                                   MediaQuery.of(context).size.width * 0.045,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 1),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   '$city,',
//                                   style: TextStyle(
//                                     fontFamily: 'Avenir',
//                                     color: Color.fromARGB(255, 218, 218, 218),
//                                     fontSize:
//                                         MediaQuery.of(context).size.width *
//                                             0.03,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.01,
//                                 ),
//                                 Text(
//                                   pincode,
//                                   style: TextStyle(
//                                     fontFamily: 'Avenir',
//                                     color: Color.fromARGB(255, 218, 218, 218),
//                                     fontSize:
//                                         MediaQuery.of(context).size.width *
//                                             0.03,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 5),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.1,
//                         child: Image.asset("assets/images/hospital.png"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.01,
//           ),
//           if (expansionStates[hospitalname]!)
//             ...projectsForHospital.map(
//               (project) => Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () async {
//                     if (project == 'AgVa PRO') {
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               DoctorDeviceList(hospitalname, hospitaladdress),
//                         ),
//                       );
//                       if (result != null && result == 'refresh') {
//                         getHospitals();
//                       }
//                     } else {
//                       final snackBar = SnackBar(
//                         backgroundColor: const Color.fromARGB(255, 65, 65, 65),
//                         content: Text(
//                           "Not Available",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         action: SnackBarAction(
//                           textColor: Colors.black,
//                           backgroundColor: Colors.white,
//                           label: 'OK',
//                           onPressed: () {},
//                         ),
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color.fromARGB(255, 62, 62, 62),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               project,
//                               style: TextStyle(
//                                 fontFamily: 'Avenir',
//                                 color: Color.fromARGB(255, 228, 228, 228),
//                                 fontSize:
//                                     MediaQuery.of(context).size.width * 0.05,
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.08,
//                               child: Image.asset(
//                                 getImagePath(project),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.010,
//           ),
//         ],
//       );
//     }).toList();
//   }

//   String getImagePath(project) {
//     switch (project) {
//       case 'AgVa PRO':
//         return "assets/images/deviceimage.png";
//       case 'Emergency':
//         return "assets/images/deviceimage.png";
//       default:
//         return "assets/images/inactive.png";
//     }
//   }
// }

//screen using bloc implementation
// ignore_for_file: prefer_const_constructors

import 'package:agva_app/Bloc/bloc/post_bloc.dart';
import 'package:agva_app/Bloc/bloc/post_event.dart';
import 'package:agva_app/Bloc/bloc/post_state.dart';
import 'package:agva_app/Bloc/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DoctorDeviceList.dart';


class DoctorHospitals extends StatefulWidget {
  DoctorHospitals();

  @override
  _DoctorHospitalsState createState() => _DoctorHospitalsState();
}

class _DoctorHospitalsState extends State<DoctorHospitals> {
  late SharedPreferences prefs;
  bool isLoading = true;
  bool expansionStates = false;

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'HOSPITALS',
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: BlocBuilder<PostBloc, PostStates>(builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return SizedBox(
                  height: 1,
                  child: LinearProgressIndicator(color: Colors.pink));
            case PostStatus.Failure:
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No Hospital List Found',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 158, 158, 158),
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Please Contact Doctor to Access List',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              );
            case PostStatus.success:
              return ListView.builder(
                  itemCount: state.postList.length,
                  itemBuilder: (context, index) {
                    final item = state.postList[index];
                    var hospital = item.hospitalname.toString();
                    var hospitaladdress = item.city.toString();
                    var pincode = item.pincode.toString();
                    print('this is hospital name : $hospitaladdress');

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          expansionStates = !expansionStates;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 51, 50, 50),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          hospital,
                                          style: TextStyle(
                                            fontFamily: 'Avenir',
                                            color: Color.fromARGB(
                                                255, 218, 218, 218),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.045,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 1),
                                          child: Row(
                                            children: [
                                              Text(
                                                hospitaladdress,
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  color: Color.fromARGB(
                                                      255, 218, 218, 218),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                              ),
                                      
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Image.asset(
                                          "assets/images/hospital.png"),
                                    ),
                                  ),
                                ],
                                
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.010,
                          ),
                          if (expansionStates == true)
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorDeviceList(
                                                  hospital, hospitaladdress),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color.fromARGB(
                                                  255, 62, 62, 62),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'AgVa PRO',
                                                      style: TextStyle(
                                                        fontFamily: 'Avenir',
                                                        color: Color.fromARGB(
                                                            255, 228, 228, 228),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.08,
                                                      child: Image.asset(
                                                          "assets/images/deviceimage.png"),
                                                    ),
                                                  ]),
                                            )))))
                        ],
                      ),
                    );
                  });
          }
        }));
  }
}


// String getImagePath(project) {
//   switch (project) {
//     case 'AgVa PRO':
//       return "assets/images/deviceimage.png";
//     case 'Emergency':
//       return "assets/images/deviceimage.png";
//     default:
//       return "assets/images/inactive.png";
//   }
// }
