import 'package:flutter/material.dart';
import 'package:svms_screening/models/todo.dart';
import 'package:svms_screening/models/user.dart';
import 'package:svms_screening/services/db.dart';

class TodosPage extends StatefulWidget {
  final User user;

  const TodosPage({Key? key, required this.user}) : super(key: key);
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  DBhelper dbhelper = DBhelper();
  late List<Todo> todos;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getTodos();
  }

  Future<List<Todo>> getTodos() async {
    todos = await dbhelper.getTodos(widget.user);
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("To Dos"),
        ),
        body: FutureBuilder(
          future: getTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2),
                      height: 100,
                      child: Card(
                        color: todos[index].completed == true
                            ? Colors.green
                            : Colors.grey,
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  todos[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
