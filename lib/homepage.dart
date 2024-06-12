import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/tabs/doa_tab.dart';
import 'package:quran_app/tabs/surah_tab.dart';
import 'package:quran_app/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: header(),
            ),
            SliverAppBar(
              backgroundColor: background,
              elevation: 0,
              pinned: true,
              shape: Border(
                bottom: BorderSide(
                  color: Color(0xFFA19CC5).withOpacity(.1),
                  width: 3,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: text,
                  labelColor: Colors.white,
                  indicatorColor: purple,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    _tabBar(label: 'Surah'),
                    _tabBar(label: 'Doa'),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              SurahTab(),
              DoaTab(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Tab _tabBar({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: background,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svg/bar-icon.svg')),
          SizedBox(
            width: 24,
          ),
          Text(
            "Qur'an Qu",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svg/search-icon.svg')),
        ],
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: abu,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        _bottomBarIcon(
            icon: 'assets/svg/quran-icon.svg', label: "alquran", index: 0),
        _bottomBarIcon(icon: 'assets/svg/doa-icon.svg', label: "doa", index: 1),
      ],
    );
  }

  BottomNavigationBarItem _bottomBarIcon(
      {required String icon, required String label, required int index}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: _selectedIndex == index ? purple : Colors.grey,
      ),
      label: label,
    );
  }
}

class header extends StatelessWidget {
  const header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              Container(
                height: 131,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0,
                          1,
                        ],
                        colors: [
                          Color(0xFFDF98FA),
                          Color(0xFF9055FF)
                        ])),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset('assets/svg/quran.svg')),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/book.svg'),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Last Read',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "AL-FATIHAH",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Ayat No: 1',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
