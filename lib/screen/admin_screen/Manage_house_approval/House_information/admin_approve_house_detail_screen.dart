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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder:
                      const AssetImage("assets/images/home_img/loading.gif"),
                  image: NetworkImage(house.img ?? ""),
                  imageErrorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.network(
                        "https://icons.veryicon.com/png/o/education-technology/alibaba-cloud-iot-business-department/image-load-failed.png");
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "House Name: ${house.userName}",
                    style: largeTextStyle(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                "Address: ${house.address}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                       houseProvider.acceptHouse(house.houseId);
                      Navigator.pop(context);
                    },
                    child: const Text("Accept"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text("Decline"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
