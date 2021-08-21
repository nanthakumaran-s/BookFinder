import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/lockedProduct.dart';
import 'package:BookFinder/models/product.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/ProductPage.dart';
import 'package:BookFinder/screens/Profile.dart';
import 'package:BookFinder/screens/Upload.dart';
import 'package:BookFinder/service/notificationService.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<Product> bookProduct = [];
List<Product> stationaryProduct = [];
List<LockedProduct> lockedProducts = [];
UserData rootUser;

class HomePage extends StatefulWidget {
  final UserData currentUser;
  final int pageIndex;
  HomePage({
    @required this.currentUser,
    this.pageIndex,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex != null ? widget.pageIndex : 0;
    pageController = PageController(
      initialPage: pageIndex,
    );
    getLockedProducts();
    rootUser = widget.currentUser;
  }

  getLockedProducts() async {
    await init(widget.currentUser.email);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  pageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          ProductPage(
            currentUser: widget.currentUser,
            page: CommonStrings.books.capitalize(),
            category: CommonStrings.books,
            product: bookProduct,
          ),
          ProductPage(
            currentUser: widget.currentUser,
            page: CommonStrings.stationary.capitalize(),
            category: CommonStrings.stationary,
            product: stationaryProduct,
          ),
          UploadPage(
            currentUser: widget.currentUser,
          ),
          ProfilePage(
            currentUser: widget.currentUser,
            profileVisitor: widget.currentUser,
          )
        ],
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: pageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: CupertinoColors.darkBackgroundGray,
        inactiveColor: CupertinoColors.inactiveGray,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.book)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.pen)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.gift)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
        ],
        backgroundColor: Colors.grey[50],
      ),
    );
  }
}
