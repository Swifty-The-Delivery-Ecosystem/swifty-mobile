import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swifty_mobile/components/popular_now_carousel.dart';
import '../components/location_modal.dart';
import 'profile_screen.dart';
import 'package:swifty_mobile/providers/restaurants_provider.dart';
import 'placeholders.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedLocation = 'BH1';

  void _showLocationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LocationModal(
          onLocationSelected: (location) {
            setState(() {
              selectedLocation = location;
            });

            int locationId = getLocationId(location);

            // Use context.read to get the RestaurantProvider and trigger the rebuild
            context.read<RestaurantProvider>().getRestaurants(locationId);

            Navigator.pop(context);
          },
          selectedLocation: selectedLocation,
        );
      },
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () => _showLocationModal(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivering to',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            selectedLocation,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue, // Change the color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(), // Use Spacer to push the next widget to the right
                CircleAvatar(
                  backgroundColor: Colors.grey[300], // Light gray color
                  radius: 24.0,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () => _navigateToProfile(context),
                    color: Colors.grey[600], // Dark gray color
                  ),
                ),
              ],
            ),
            Consumer<RestaurantProvider>(
              builder: (context, restaurantProvider, _) {
                if (!restaurantProvider.isLoading) {
                  return Expanded(
                    child: Column(
                      children: [
                        PopularNowCarousel(
                          restaurants: restaurantProvider.restaurants,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: const SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BannerPlaceholder(),
                            TitlePlaceholder(width: double.infinity),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.threeLines,
                            ),
                            SizedBox(height: 16.0),
                            TitlePlaceholder(width: 200.0),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.twoLines,
                            ),
                            SizedBox(height: 16.0),
                            TitlePlaceholder(width: 200.0),
                            SizedBox(height: 16.0),
                            ContentPlaceholder(
                              lineType: ContentLineType.twoLines,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
