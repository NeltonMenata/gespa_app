/* import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/controller/data_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/ticket_model.dart';
import '../utils/app_color.dart';
import '../views/event_page/event_page_view.dart';
import '../views/profile/add_profile.dart';

List<AustinYogaWork> austin = [
  AustinYogaWork(rangeText: '7-8', title: 'CONCERN'),
  AustinYogaWork(rangeText: '8-9', title: 'VINYASA'),
  AustinYogaWork(rangeText: '9-10', title: 'MEDITATION'),
];
List<String> imageList = [
  'assets/#1.png',
  'assets/#2.png',
  'assets/#3.png',
  'assets/#1.png',
];

Widget EventsFeed() {
  DataController dataController = Get.find<DataController>();

  return Obx(() => dataController.isEventsLoading.value
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, i) {
            return EventItem(dataController.allEvents[i]);
          },
          itemCount: dataController.allEvents.length,
        ));
}

Widget buildCard(
    {String? image, text, Function? func, DocumentSnapshot? eventData}) {
  DataController dataController = Get.find<DataController>();

  List joinedUsers = [];

  try {
    joinedUsers = eventData!.get('joined');
  } catch (e) {
    joinedUsers = [];
  }

  List dateInformation = [];
  try {
    dateInformation = eventData!.get('date').toString().split('-');
  } catch (e) {
    dateInformation = [];
  }

  int comments = 0;

  List userLikes = [];

  try {
    userLikes = eventData!.get('likes');
  } catch (e) {
    userLikes = [];
  }

  try {
    comments = eventData!.get('comments').length;
  } catch (e) {
    comments = 0;
  }

  List eventSavedByUsers = [];
  try {
    eventSavedByUsers = eventData!.get('saves');
  } catch (e) {
    eventSavedByUsers = [];
  }

  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: const Color(393939).withOpacity(0.15),
          spreadRadius: 0.1,
          blurRadius: 2,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ],
    ),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            func!();
          },
          child: Container(
             width: double.infinity,
            height: Get.width * 0.5,
            // child: Image.network(image!,fit: BoxFit.fill,),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(image!),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),

           
            //color: Colors.red,
          ),
          /* CachedNetworkImage(
        imageUrl: "http://via.placeholder.com/350x150",
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ), */
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 41,
                height: 24,
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xffADD8E6))),
                child: Text(
                  '${dateInformation[0]}-${dateInformation[1]}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (eventSavedByUsers
                      .contains(FirebaseAuth.instance.currentUser!.uid)) {
                    FirebaseFirestore.instance
                        .collection('events')
                        .doc(eventData!.id)
                        .set({
                      'saves': FieldValue.arrayRemove(
                          [FirebaseAuth.instance.currentUser!.uid])
                    }, SetOptions(merge: true));
                  } else {
                    FirebaseFirestore.instance
                        .collection('events')
                        .doc(eventData!.id)
                        .set({
                      'saves': FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser!.uid])
                    }, SetOptions(merge: true));
                  }
                },
                child: Container(
                  width: 16,
                  height: 19,
                  child: Image.asset(
                    'assets/boomMark.png',
                    fit: BoxFit.contain,
                    color: eventSavedByUsers
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
                width: Get.width * 0.6,
                height: 50,
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    DocumentSnapshot user = dataController.allUsers
                        .firstWhere((e) => e.id == joinedUsers[index]);

                    String image = '';

                    try {
                      image = user.get('image');
                    } catch (e) {
                      image = '';
                    }

                    return Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        minRadius: 13,
                        backgroundImage: NetworkImage(image),
                      ),
                    );
                  },
                  itemCount: joinedUsers.length,
                  scrollDirection: Axis.horizontal,
                )),
          ],
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Row(
          children: [
            const SizedBox(
              width: 68,
            ),
            InkWell(
              onTap: () {
                if (userLikes
                    .contains(FirebaseAuth.instance.currentUser!.uid)) {
                  FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventData!.id)
                      .set({
                    'likes': FieldValue.arrayRemove(
                        [FirebaseAuth.instance.currentUser!.uid]),
                  }, SetOptions(merge: true));
                } else {
                  FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventData!.id)
                      .set({
                    'likes': FieldValue.arrayUnion(
                        [FirebaseAuth.instance.currentUser!.uid]),
                  }, SetOptions(merge: true));
                }
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffD24698).withOpacity(0.02),
                    )
                  ],
                ),
                child: Icon(
                  Icons.favorite,
                  size: 14,
                  color:
                      userLikes.contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Colors.red
                          : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '${userLikes.length}',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.all(0.5),
              width: 17,
              height: 17,
              child: Image.asset(
                'assets/message.png',
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '$comments',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              padding: const EdgeInsets.all(0.5),
              width: 16,
              height: 16,
              child: Image.asset(
                'assets/send.png',
                fit: BoxFit.contain,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

EventItem(DocumentSnapshot event) {
  DataController dataController = Get.find<DataController>();

  DocumentSnapshot user =
      dataController.allUsers.firstWhere((e) => event.get('uid') == e.id);

  String image = '';

  try {
    image = user.get('image');
  } catch (e) {
    image = '';
  }

  String eventImage = '';
  try {
    List media = event.get('media') as List;
    Map mediaItem =
        media.firstWhere((element) => element['isImage'] == true) as Map;
    eventImage = mediaItem['url'];
  } catch (e) {
    eventImage = '';
  }

  return Column(
    children: [
      Row(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => ProfileScreen());
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(image),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${user.get('first')} ${user.get('last')}',
            style:
                GoogleFonts.raleway(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ],
      ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      buildCard(
          image: eventImage,
          text: event.get('event_name'),
          eventData: event,
          func: () {
            Get.to(() => EventPageView(event, user));
          }),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}

EventsIJoined() {
  DataController dataController = Get.find<DataController>();

  DocumentSnapshot myUser = dataController.allUsers
      .firstWhere((e) => e.id == FirebaseAuth.instance.currentUser!.uid);

  String userImage = '';
  String userName = '';

  try {
    userImage = myUser.get('image');
  } catch (e) {
    userImage = '';
  }

  try {
    userName = '${myUser.get('first')} ${myUser.get('last')}';
  } catch (e) {
    userName = '';
  }

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/doneCircle.png',
              fit: BoxFit.cover,
              color: AppColors.blue,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Text(
            'You\'re all caught up!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      SizedBox(
        height: Get.height * 0.015,
      ),
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                  radius: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(
              color: const Color(0xff918F8F).withOpacity(0.2),
            ),
            Obx(
              () => dataController.isEventsLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: dataController.joinedEvents.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        String name =
                            dataController.joinedEvents[i].get('event_name');

                        String date =
                            dataController.joinedEvents[i].get('date');

                        date = date.split('-')[0] + '-' + date.split('-')[1];

                        List joinedUsers = [];

                        try {
                          joinedUsers =
                              dataController.joinedEvents[i].get('joined');
                        } catch (e) {
                          joinedUsers = [];
                        }

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 41, height: 24,
                                    alignment: Alignment.center,
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color(0xffADD8E6),
                                      ),
                                    ),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.06,
                                  ),
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: Get.width * 0.6,
                                height: 50,
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    DocumentSnapshot user =
                                        dataController.allUsers.firstWhere(
                                            (e) => e.id == joinedUsers[index]);

                                    String image = '';

                                    try {
                                      image = user.get('image');
                                    } catch (e) {
                                      image = '';
                                    }

                                    return Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        minRadius: 13,
                                        backgroundImage: NetworkImage(image),
                                      ),
                                    );
                                  },
                                  itemCount: joinedUsers.length,
                                  scrollDirection: Axis.horizontal,
                                )),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
 */