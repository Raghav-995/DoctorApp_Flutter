import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Assets/CareTeamModel.dart';
import '../CareTeam/GetCareTeam.dart';
import 'care.dart';

class CareTeam extends StatefulWidget {
  @override
  _CareTeamState createState() => _CareTeamState();
}

class _CareTeamState extends State<CareTeam> {
  List<dynamic>? responseList;

  Map<String, dynamic> careTeamData() {
    return {
      ('careTeamName'): (careTeamName.toString()),
    };
  }

//   void fetchCareTeamData() async {
//     try {
//       final SharedPreferences sharedPreferences =
//       await SharedPreferences.getInstance();
//       final String? obtainedToken = sharedPreferences.getString('token');
//
//       if (obtainedToken == null) {
//         throw Exception('Token not found in SharedPreferences');
//       }
//       // Fetch data using getCareteam API
//       // final api = ApiServices(Dio(), "/getCareTeams");
//       // final response = await api.ApiUser(careTeamData(), context); // Adjust this based on your API services
//       final Dio dio = Dio();
//
//       // final innerJsonString = json.encode(data);
//       // final jsonData = json.encode({'data': innerJsonString});
//
//       final response = await dio.post(
//         'https://seerecs.org/user/getCareTeams',
//         options: Options(
//           method: 'POST',
//           headers: {'Authorization': 'Bearer $obtainedToken'},
//         ),
//         data: careTeamData(),
//       );
//       if (response.statusCode == 200) {
//         setState(() {
//           // If response is successful, update the responseList
//           responseList = response.data['careTeams'];
//         });
//       } else {
//         // Handle error cases
//         print("Error: ${response.statusCode}");
//       }
//     } catch (error) {
//       // Handle errors
//       print("Error: $error");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (responseList == null || responseList!.isEmpty) {
//     //   // Show Care page if responseList is null
//     //   WidgetsBinding.instance!.addPostFrameCallback((_) {
//     //     Navigator.of(context).pushReplacement(
//     //       MaterialPageRoute(
//     //         builder: (context) => Care(),
//     //       ),
//     //     );
//     //   });
//     //   return Container(); // Return an empty container for now
//     // } else {
//     //   return Center(
//     //     child: Padding(
//     //       padding: const EdgeInsets.only(bottom: 1.0),
//     //       child: GetCareteam(),
//     //     ),
//     //   );
//     // }
//     // return Center(
//     //   child: Stack(
//     //     children: [
//     //       // Widget to show when responseList is null
//     //       if (responseList == null)
//     //         Care(), // Show Care page if responseList is null
//     //
//     //       // Widget to show when responseList is not null
//     //       if (responseList != null)
//     //         GetCareteam(),
//     //     ],
//     //   ),
//     // );
//     if (responseList == null || responseList!.isEmpty) {
//       // Show Care page if responseList is null or empty
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => Care(),
//           ),
//         );
//       });
//       return Container(); // Return an empty container for now
//     } else {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 1.0),
//           child: GetCareteam(),
//         ),
//       );
//     }
//
//   }
// }
  @override
  void initState() {
    super.initState();
    fetchCareTeamData();
  }
  bool isLoading = true;
  void fetchCareTeamData() async {
    try {
      // Fetch care team data here
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      final String? obtainedToken = sharedPreferences.getString('token');

      if (obtainedToken == null ){
        throw Exception('Token not found in SharedPreferences');
      }
      final Dio dio = Dio();
      print(obtainedToken);
      final response = await dio.post(
        'https://seerecs.org/user/getCareTeams',
        options: Options(
          method: 'POST',
          headers: {'Authorization': 'Bearer $obtainedToken'},
        ),
        data: careTeamData(),
      );
      if (response.statusCode == 200) {
        setState(() {
          // If response is successful, update the responseList
          responseList = response.data['careTeams'];
          isLoading = false; // Data fetching is completed
        });
      } else {
        // Handle error cases
        print("Error: ${response.statusCode}");
        isLoading = false; 
        // Data fetching is completed even in case of an error
      }
    } on DioError catch (error) {
      // Handle errors
      print("Error Hello: $error");
      isLoading = false; // Data fetching is completed even in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while data is being fetched
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Data fetching is completed
      if (responseList != null && responseList!.isNotEmpty) {
        // Show GetCareteam widget if responseList is not empty
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: GetCareteam(),
          ),
        );
      } else {
        // Show Care widget if responseList is null or empty
        return Center(
          child: Care(),
        );
      }
    }
  }
}