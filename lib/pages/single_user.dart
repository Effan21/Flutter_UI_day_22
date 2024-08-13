import 'dart:ui';

import 'package:flutter/material.dart';

import '../helper/colors_sys.dart';
import '../models/collocation.dart';
import '../models/user.dart';

class SingleUser extends StatefulWidget {
  final User? user;

  const SingleUser({Key? key, this.user}) : super(key: key);

  @override
  SingleUserState createState() => SingleUserState();
}

class SingleUserState extends State<SingleUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSys.lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorSys.grey,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, size: 25, color: ColorSys.grey,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                  color: Colors.white
              ),
              child: Column(
                children: <Widget>[
                  Hero(
                    transitionOnUserGestures: true,
                    tag: widget.user!.username,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.user!.profilePicture),
                      maxRadius: 40,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(widget.user!.name, style: TextStyle(
                      fontSize: 20,
                      color: ColorSys.black,
                      fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 5,),
                  Text(widget.user!.username, style: TextStyle(
                      fontSize: 15,
                      color: ColorSys.grey
                  ),),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      makeFollowWidgets(
                          count: widget.user!.followers,
                          name: "Followers"
                      ),
                      Container(
                        width: 2,
                        height: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: ColorSys.lightGrey,
                      ),
                      makeFollowWidgets(
                          count: widget.user!.following,
                          name: "Following"
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  makeActionButtons()
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: ColorSys.grey300,
                        ))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Collotion", style: TextStyle(
                                color: ColorSys.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),),
                            Container(
                              width: 50,
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(
                                      color: ColorSys.orange,
                                      width: 3
                                  ))
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20,),
                        Text("Likes", style: TextStyle(
                            color: ColorSys.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                  makeCollocation(widget.user!.collocation)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeCollocation(List<Collocation> collocation) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20),
          height: 320,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: collocation.length,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 1.2/1,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(collocation[index].thumbnail),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orange
                          ),
                          child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                        height: 90,
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(collocation[index].name, style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15
                                            ),),
                                            const SizedBox(height: 5,),
                                            Text("${collocation[index].tags.length} photos", style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300
                                            ),)
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 32,
                      margin: const EdgeInsets.only(right: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: collocation[index].tags.length,
                        itemBuilder: (context, tagIndex) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorSys.grey300
                          ),
                          child: Center(
                            child: Text(collocation[index].tags[tagIndex], style: const TextStyle(
                            ),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget makeFollowWidgets({count, name}) {
    return Row(
      children: <Widget>[
        Text(count.toString(),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorSys.black
          ),
        ),
        const SizedBox(width: 5,),
        Text(name,
          style: TextStyle(
              fontSize: 15,
              color: ColorSys.darkGray
          ),
        ),
      ],
    );
  }

  Widget makeActionButtons() {
    return Transform.translate(
      offset: const Offset(0, 20),
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 20,
                  offset: const Offset(0, 10)
              )
            ]
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: double.infinity,
                  elevation: 0,
                  onPressed: () {
                  },
                  color: ColorSys.orange,
                  child: const Text("Follow", style: TextStyle(
                    color: Colors.white,
                  ),)
              ),
            ),
            Expanded(
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: double.infinity,
                  elevation: 0,
                  onPressed: () {
                  },
                  color: Colors.transparent,
                  child: Text("Message", style: TextStyle(
                      color: ColorSys.black,
                      fontWeight: FontWeight.w400
                  ),)
              ),
            )
          ],
        ),
      ),
    );
  }
}