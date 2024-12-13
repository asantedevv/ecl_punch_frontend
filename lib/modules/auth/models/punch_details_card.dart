// import 'package:flutter/material.dart';

// class PunchDetailsCard extends StatelessWidget {
//   // final int id;
//   final String? punchDate;
//   final String? punchInTime;
//   final String? punchOutTime;
//   final int? totalHours;

//   PunchDetailsCard({
//     this.punchDate,
//     this.punchInTime,
//     // required this.id,
//     this.punchOutTime,
//     this.totalHours,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Punch Date Header
//               Center(
//                 child: Text(
//                   punchDate!,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Divider(thickness: 1, color: Colors.grey.shade300),
//               SizedBox(height: 16),
//               // Punch In Time
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Punch In Time:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     punchInTime!,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               // Punch Out Time
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Punch Out Time:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     punchOutTime!,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               // Total Hours
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Hours:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     totalHours.toString()!,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class PunchDetailsCard extends StatelessWidget {
  final String? punchDate;
  final String? punchInTime;
  final String? punchOutTime;
  final int? totalHours;

  PunchDetailsCard({
    this.punchDate,
    this.punchInTime,
    this.punchOutTime,
    this.totalHours,
  });

  /// Extracts only the date (YYYY-MM-DD) from a full DateTime string
  String _extractDate(String? dateTime) {
    if (dateTime == null) return 'N/A';
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy-MM-dd')
          .format(parsedDate); // Format as YYYY-MM-DD
    } catch (e) {
      return 'Invalid Date';
    }
  }

  /// Extracts only the time (HH:mm:ss) from a full DateTime string
  String _extractTime(String? dateTime) {
    if (dateTime == null) return 'N/A';
    try {
      DateTime parsedTime = DateTime.parse(dateTime);
      return DateFormat('HH:mm:ss').format(parsedTime); // Format as HH:mm:ss
    } catch (e) {
      return 'Invalid Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Punch Date Header
              Center(
                child: Text(
                  _extractDate(punchDate), // Extracted date
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: 16),
              // Punch In Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Punch In Time:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _extractTime(punchInTime), // Extracted time
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Punch Out Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Punch Out Time:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _extractTime(punchOutTime), // Extracted time
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Total Hours
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Hours:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    totalHours != null ? totalHours.toString() : 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
