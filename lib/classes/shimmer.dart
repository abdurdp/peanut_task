// shimmer loader
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/dimensions.dart';

// global shimmer
class GlobalShimmer extends StatelessWidget {
  const GlobalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.extraSmallSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 65,
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 5, bottom: 5, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    Dimensions.extraSmallSize * 0.5),
                              ),
                            ),
                            width: 60,
                            height: 50,
                            child: Icon(Icons.image, color: Colors.white),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.extraSmallSize * 0.5),
                                    ),
                                  ),
                                  // color: Colors.grey,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.extraSmallSize * 0.5),
                                    ),
                                  ),
                                  // color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// notification shimmer
class NotificationDataShimmer extends StatelessWidget {
  const NotificationDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.extraSmallSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 65,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Dimensions.circleSize,
                                ),
                              ),
                            ),
                            width: 50,
                            height: 50,
                            child: Icon(Icons.image, color: Colors.white),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.extraSmallSize *
                                                    0.5),
                                          ),
                                        ),
                                        // color: Colors.grey,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.extraSmallSize *
                                                    0.5),
                                          ),
                                        ),
                                        // color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                    left: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.extraSmallSize),
                                    ),
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: Icon(Icons.image, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// profile shimmer
class ProfileDataShimmer extends StatelessWidget {
  const ProfileDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.extraSmallSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Container(
                  height: 90.0,
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                ),
              ),
              Positioned(
                bottom: -20.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  enabled: true,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(
                        Dimensions.circleSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.extraLargerSize),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: Dimensions.extraLargerSize * 1.75,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(Dimensions.defaultSize),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.defaultSize),
                Expanded(
                  child: Container(
                    height: Dimensions.extraLargerSize * 1.75,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(Dimensions.defaultSize),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.defaultSize),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 65,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.defaultSize),
                              ),
                            ),
                            width: 50,
                            height: 50,
                            child: Icon(Icons.image, color: Colors.white),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.extraSmallSize * 0.5),
                                    ),
                                  ),
                                  // color: Colors.grey,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.extraSmallSize * 0.5),
                                    ),
                                  ),
                                  // color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

