import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/provider/user_provider.dart';
import 'package:admin_app_xem_tro/config/widget/app_bar_draw.dart';
import 'package:admin_app_xem_tro/config/widget/navigation_draw.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    userNormalList = await _userProvider.loadUserListByRole(1);
    userHostList = await _userProvider.loadUserListByRole(2);
    blacklist = await _userProvider.loadBlacklist();
    setState(() {});
  }

  Future<void> _toggleUserStatus(User user) async {
    await _userProvider.toggleUserStatus(user);

    // Reload data after updating the user status
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CommonAppBar(
          title: "Welcome Back",
          tabs: [
            Tab(text: "Người dùng"),
            Tab(text: "Chủ trọ"),
            Tab(text: "Blacklist"),
          ],
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
    return userList.isEmpty
        ? const Center(child: Text("No data available"))
        : ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              User user = userList[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: ElevatedButton(
                  onPressed: () => _toggleUserStatus(user),
                  child: Text(user.isBanned ? 'Unban' : 'Ban'),
                ),
              );
            },
          );
  }
}
