import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/models/house.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Manage_house_approval/House_information/admin_approve_house_detail_screen.dart';
import 'package:flutter/material.dart';

class HouseItem extends StatelessWidget {
  final House house;

  const HouseItem({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HouseDetailScreen(house: house),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(padding(context, padding: 0.02)),
        margin: const EdgeInsets.symmetric(
            vertical: 4),
        child: AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(
                borderRadius(context),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius(context)),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
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
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(padding(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            house.houseName,
                            style: largeTextStyle(context, size: 0.03),
                          ),
                          spaceHeight(context, height: 0.01),
                          Text(
                            "Landlord: \n${house.userName}",
                            style: largeTextStyle(context, size: 0.024),
                          ),
                          spaceHeight(context, height: 0.01),
                          Text(
                            house.address,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: smallTextStyle(context,
                                color: Colors.grey, size: 0.018),
                          ),
                          spaceHeight(context, height: 0.01),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
