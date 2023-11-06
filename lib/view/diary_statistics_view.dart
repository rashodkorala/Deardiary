import 'package:flutter/material.dart';

import '../controller/diary_entry_service.dart';
// Import your DiaryEntryService

class DiaryStatisticView extends StatefulWidget {
  @override
  _DiaryStatisticViewState createState() => _DiaryStatisticViewState();
}

class _DiaryStatisticViewState extends State<DiaryStatisticView> {
  late Map<int, double> monthlyAverages = {};

  @override
  void initState() {
    super.initState();
    fetchMonthlyAverages();
  }

  Future<void> fetchMonthlyAverages() async {
    final Map<int, double> averages = {};

    for (int month = 1; month <= 12; month++) {
      final averageRating = await calculateAverageRatingForMonth(
          month, 2023); // Replace with the desired year
      averages[month] = averageRating;
    }

    setState(() {
      monthlyAverages = averages;
    });
  }

  Future<double> calculateAverageRatingForMonth(int month, int year) async {
    final entries =
        await DiaryEntryService().getDiaryEntriesForMonth(month, year);

    if (entries.isEmpty) {
      return 0;
    }

    final totalRating =
        entries.fold(0, (previous, entry) => previous + entry.rating);
    return totalRating / entries.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics and Insights'),
        backgroundColor: Colors.black,
      ),
      body: monthlyAverages.isNotEmpty
          ? Column(
              children: [
                for (int month = 1; month <= 12; month++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Month $month: Average Rating: ${monthlyAverages[month]?.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
