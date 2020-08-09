import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/db_provider.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  @override
  _FloatingActionButtonWidgetState createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 260));

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String description;
  setTitle(String value) {
    this.title = value;
  }

  setDescription(String value) {
    this.description = value;
  }

  deleteAllTask(BuildContext context) {
    Provider.of<DBProvider>(context, listen: false).deleteAllTasks();
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DBProvider>(context, listen: false).insertNewTask(Task(
          title: this.title,
        ));
        Navigator.pop(context);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item

        Bubble(
          title: "",
          iconColor: Colors.white,
          bubbleColor: Colors.red,
          icon: FontAwesomeIcons.plus,
          titleStyle: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          onPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    child: AlertDialog(
                      title: Text('Add Task'),
                      content: Form(
                          key: formKey,
                          child: Container(
                            height: 200,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: (value) {
                                    // ignore: missing_return
                                    if (value.isEmpty) {
                                      return 'text title is required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                  ),
                                  onSaved: (value) {
                                    setTitle(value);
                                  },
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    submitTask(context);
                                  },
                                  child: Text('Submit'),
                                )
                              ],
                            ),
                          )),
                    ),
                  );
                });

            _animationController.reverse();
            setState(() {});
          },
        ),
        Bubble(
          title: "",
          iconColor: Colors.white,
          bubbleColor: Colors.red,
          icon: FontAwesomeIcons.trashAlt,
          titleStyle: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          onPress: () {
            deleteAllTask(context);
            _animationController.reverse();
            setState(() {});
          },
        ),

//        Bubble(
//          title: "",
//          iconColor: Colors.white,
//          bubbleColor: Colors.red,
//          icon: FontAwesomeIcons.plus,
//          titleStyle: TextStyle(
//              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
//          onPress: () {
//            showModalBottomSheet(
//                backgroundColor: Colors.transparent,
//                builder: (BuildContext context) {
//                  return Padding(
//                    padding: MediaQuery.of(context).viewInsets,
//                    child: Form(
//                      key: formKey,
//                      child: CupertinoActionSheet(
//                        actions: <Widget>[
//                          CupertinoActionSheetAction(
//                            onPressed: () {},
//                            child: Card(
//                              color: Colors.transparent,
//                              elevation: 0.0,
//                              child: TextFormField(
//                                validator: (value) {
//                                  // ignore: missing_return
//                                  if (value.isEmpty) {
//                                    return 'text title is required';
//                                  }
//                                  return null;
//                                },
//                                decoration: InputDecoration(
//                                  labelText: 'Title',
//                                  fillColor: Colors.grey[200],
//                                  filled: true,
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(20)),
//                                ),
//                                onSaved: (value) {
//                                  setTitle(value);
//                                },
//                              ),
//                            ),
//                          ),
//                          CupertinoActionSheetAction(
//                            onPressed: () {
//                              submitTask(context);
//                            },
//                            child: Card(
//                              color: Colors.transparent,
//                              elevation: 0.0,
//                              child: TextFormField(
//                                validator: (value) {
//                                  // ignore: missing_return
//                                  if (value.isEmpty) {
//                                    return 'text description is required';
//                                  }
//                                  return null;
//                                },
//                                decoration: InputDecoration(
//                                  labelText: 'Description',
//                                  fillColor: Colors.grey[200],
//                                  filled: true,
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(20)),
//                                ),
//                                onSaved: (value) {
//                                  setDescription(value);
//                                },
//                              ),
//                            ),
//                          ),
//                        ],
//                        cancelButton: CupertinoActionSheetAction(
//                          onPressed: () {
//                            submitTask(context);
//                          },
//                          child: Container(
//                            alignment: Alignment.center,
//                            child: Text('Submit'),
//                          ),
//                        ),
//                      ),
//                    ),
//                  );
//                },
//                context: context);
//
//            _animationController.reverse();
//            setState(() {});
//          },
//        ),

        // Floating action menu item
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: () {
        bool x = _animationController.isCompleted;
        x ? _animationController.reverse() : _animationController.forward();

        x = !_animationController.isCompleted;
        setState(() {});
      },

      // Floating Action button Icon color
      iconColor: Colors.red,

      // Flaoting Action button Icon
      icon: AnimatedIcons.menu_arrow,
    );
  }
}
