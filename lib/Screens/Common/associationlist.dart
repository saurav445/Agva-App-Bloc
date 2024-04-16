import 'package:agva_app/Bloc/bloc/post_bloc.dart';
import 'package:agva_app/Bloc/bloc/post_state.dart';
import 'package:agva_app/Bloc/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.postStatus) {
          case PostStatus.loading:
            return SizedBox(
                height: 1, child: LinearProgressIndicator(color: Colors.pink));
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
            return Column(
              children: state.profileList.map((item) {
                var associationname = item.associationName.toString();
                var workaddress = item.workAddress.toString();
                var workemail = item.workEmail.toString();
                var department = item.department.toString();
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 41, 41, 41),
                        borderRadius: BorderRadius.circular(5)),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            associationname,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              color: Color.fromARGB(255, 218, 218, 218),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            'Department : $department',
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Text(
                            'Work Email : $workemail',
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.005,
                          ),
                          SizedBox(
                            child: Text(
                              workaddress,
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
