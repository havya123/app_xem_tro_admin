// ignore_for_file: unused_element

import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/provider/user_provider.dart';
import 'package:admin_app_xem_tro/config/widget/navigation_draw.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminAccountScreen extends StatefulWidget {
  const AdminAccountScreen({super.key});

  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen> {
  final AdminUserProvider _userProvider = AdminUserProvider();
  List<User> userNormalList = [];
  List<User> userHostList = [];
  List<User> blacklist = [];
  Map<int, bool> showPasswordMap = {};

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    userNormalList = await _userProvider.loadUserListByRole(0);
    userHostList = await _userProvider.loadUserListByRole(1);
    blacklist = await _userProvider.loadBlacklist();
    if (kDebugMode) {
      print('Blacklist Users: $blacklist');
    }
    setState(() {});
  }

  Future<void> _toggleUserStatus(User user) async {
    bool isBanning =
        user.isBanned; // Determine if the action is banning or unbanning
    String actionText = isBanning ? 'unban' : 'ban';

    // Show a confirmation dialog
    bool confirmAction = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$actionText ${user.name}?'.toUpperCase()),
          content: Text('Bạn có chắc $actionText ${user.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed "Cancel"
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed "Confirm"
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmAction == true) {
      try {
        if (user.phoneNumber.isNotEmpty) {
          await _userProvider.toggleUserStatus(user);
          _loadUsers();
        } else {
          if (kDebugMode) {
            print('Invalid user object or document ID.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error toggling user status: $e');
        }
      }
    }
  }

  List<User> _filterUsers(String query, List<User> userList) {
    return userList.where((user) {
      final lowerCaseQuery = query.toLowerCase();
      return user.name.toLowerCase().contains(lowerCaseQuery) ||
          user.phoneNumber.contains(lowerCaseQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome Back"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Người dùng"),
              Tab(text: "Chủ trọ"),
              Tab(text: "Blacklist"),
            ],
          ),
        ),
        drawer: const NavigationDraw(),
        body: SafeArea(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildUserList(userNormalList),
              _buildUserList(userHostList),
              _buildUserList(blacklist),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(List<User> userList) {
    final filteredUsers = searchController.text.isEmpty
        ? userList
        : _filterUsers(searchController.text.toLowerCase(), userList);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Search by name or phone',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text('STT', textAlign: TextAlign.center),
                  ),
                  DataColumn(
                    label: Text('Name', textAlign: TextAlign.center),
                  ),
                  DataColumn(
                    label: Text('Phone', textAlign: TextAlign.center),
                  ),
                  DataColumn(
                    label: Text('Pass', textAlign: TextAlign.center),
                  ),
                  DataColumn(
                    label: Text('Actions', textAlign: TextAlign.center),
                  ),
                ],
                rows: filteredUsers.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final User user = entry.value;
                  final bool showPassword = showPasswordMap[index] ?? false;

                  return DataRow(cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(user.name)),
                    DataCell(Text(user.phoneNumber)),
                    DataCell(
                      Row(
                        children: [
                          Expanded(
                            child: showPassword
                                ? Text(user.password)
                                : Text(
                                    '*' * user.password.length,
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          IconButton(
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                showPasswordMap[index] =
                                    !(showPasswordMap[index] ?? false);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          _toggleUserStatus(user);
                        },
                        child: Text(user.isBanned ? 'Unban' : 'Ban'),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
