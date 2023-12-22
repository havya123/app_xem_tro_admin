import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/models/house.dart';
import 'package:admin_app_xem_tro/provider/house_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseDetailScreen extends StatelessWidget {
  final House house;

  const HouseDetailScreen({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final houseProvider = Provider.of<HouseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("House Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding(context)),
        child: FutureBuilder<void>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading..."),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error loading data"),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(
                            "assets/images/home_img/loading.gif"),
                        image: NetworkImage(house.img ?? ""),
                        imageErrorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                          return Image.network(
                              "https://icons.veryicon.com/png/o/education-technology/alibaba-cloud-iot-business-department/image-load-failed.png");
                        },
                      ),
                    ),
                  ),
                  spaceHeight(context),

                  // Larger Font Size
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "House Name: ${house.houseName}",
                          style: largeTextStyle(context),
                        ),
                        Text(
                          "Landlord Name: ${house.userName}",
                          style: largeTextStyle(context),
                        ),
                        Text(
                          "Phone: ${house.phoneNumber}",
                          style: largeTextStyle(context),
                        ),

                        // Smaller Font Size
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Address: ${house.address}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description: ${house.description}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        spaceHeight(context),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Status: ${house.status.toUpperCase()}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        spaceHeight(context),
                      ],
                    ),
                  ),

                  // Buttons
                  Row(
                    children: [
                      if (house.status != 'accept' &&
                          house.status != 'declines')
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showConfirmationDialog(
                                context,
                                "Accept",
                                () {
                                  houseProvider.acceptHouse(house.houseId);
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: const Text("Accept"),
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (house.status != 'declines')
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showConfirmationDialog(
                                context,
                                "Decline",
                                () {
                                  houseProvider.rejectHouse(house.houseId);
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: const Text("Decline"),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  void _showConfirmationDialog(
    BuildContext context,
    String action,
    VoidCallback onConfirmed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm $action"),
          content: Text("Bạn có chắc $action duyệt nhà trọ này?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirmed();
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }
}
