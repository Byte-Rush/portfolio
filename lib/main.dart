import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rushil Sharma - Cosmic Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0B0B0F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _heroAnimationController;
  late AnimationController _floatingController;
  late AnimationController _glowController;
  late AnimationController _particleController;
  late AnimationController _nebulaeController;
  late AnimationController _galaxyController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _nebulaeAnimation;
  late Animation<double> _galaxyAnimation;

  bool _showScrollButton = false;

  // Cosmic color palette
  static const Color spaceBg = Color(0xFF0B0B0F);
  static const Color deepSpace = Color(0xFF0F0F1A);
  static const Color stardust = Color(0xFF1A1A2E);
  static const Color nebulaPurple = Color(0xFF6366F1);
  static const Color cosmicBlue = Color(0xFF0EA5E9);
  static const Color stellarPink = Color(0xFFF472B6);
  static const Color galaxyGreen = Color(0xFF34D399);
  static const Color starWhite = Color(0xFFFFFFFF);
  static const Color moonGlow = Color(0xFFF1F5F9);
  static const Color asteroidGray = Color(0xFF94A3B8);
  static const Color voidBorder = Color(0xFF1E293B);

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _scrollController.addListener(_scrollListener);
  }

  void _setupAnimations() {
    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );

    _nebulaeController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    );

    _galaxyController = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _heroAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );

    _nebulaeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _nebulaeController, curve: Curves.easeInOut),
    );

    _galaxyAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _galaxyController, curve: Curves.linear),
    );

    _heroAnimationController.forward();
    _floatingController.repeat(reverse: true);
    _glowController.repeat(reverse: true);
    _particleController.repeat();
    _nebulaeController.repeat(reverse: true);
    _galaxyController.repeat();
  }

  void _scrollListener() {
    if (_scrollController.offset > 300 && !_showScrollButton) {
      setState(() => _showScrollButton = true);
    } else if (_scrollController.offset <= 300 && _showScrollButton) {
      setState(() => _showScrollButton = false);
    }
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _floatingController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    _nebulaeController.dispose();
    _galaxyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 1200),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: spaceBg,
      body: Stack(
        children: [
          _buildCosmicBackground(),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildHeroSection(),
              _buildAboutSection(),
              _buildProjectsSection(),
              _buildSkillsSection(),
              _buildContactSection(),
              _buildFooter(),
            ],
          ),
          if (isDesktop) _buildNavigationSidebar(),
          if (_showScrollButton) _buildScrollToTopButton(),
        ],
      ),
    );
  }

  Widget _buildCosmicBackground() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            // Stars background
            AnimatedBuilder(
              animation: _particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarFieldPainter(_particleAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
            // Nebulae
            AnimatedBuilder(
              animation: _nebulaeAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: NebulaePainter(_nebulaeAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
            // Galaxy spiral
            AnimatedBuilder(
              animation: _galaxyAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: GalaxyPainter(_galaxyAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSidebar() {
    return Positioned(
      right: 50,
      top: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        decoration: BoxDecoration(
          color: stardust.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: nebulaPurple.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: nebulaPurple.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            _buildNavItem('About', Icons.person_outline, () => _scrollToSection(_aboutKey)),
            SizedBox(height: 25),
            _buildNavItem('Projects', Icons.rocket_launch_outlined, () => _scrollToSection(_projectsKey)),
            SizedBox(height: 25),
            _buildNavItem('Skills', Icons.auto_awesome_outlined, () => _scrollToSection(_skillsKey)),
            SizedBox(height: 25),
            _buildNavItem('Contact', Icons.satellite_alt_outlined, () => _scrollToSection(_contactKey)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, VoidCallback onTap) {
    return Tooltip(
      message: label,
      decoration: BoxDecoration(
        color: stardust,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: voidBorder),
      ),
      textStyle: TextStyle(color: starWhite, fontSize: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: deepSpace,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: nebulaPurple.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: nebulaPurple.withOpacity(_glowAnimation.value * 0.5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(icon, color: moonGlow, size: 22),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildScrollToTopButton() {
    return Positioned(
      bottom: 30,
      right: 30,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: cosmicBlue.withOpacity(_glowAnimation.value * 0.4),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: stardust,
              elevation: 0,
              child: Icon(Icons.keyboard_arrow_up, color: cosmicBlue, size: 28),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: _heroAnimationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _buildHeroBackground(),
                    ),
                    Center(
                      child: _buildHeroContent(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroBackground() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: CosmicHeroBackgroundPainter(_glowAnimation.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildHeroContent() {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: stardust.withOpacity(0.4),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: galaxyGreen.withOpacity(0.4), width: 2),
              boxShadow: [
                BoxShadow(
                  color: galaxyGreen.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, child) {
                    return Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: galaxyGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: galaxyGreen.withOpacity(_glowAnimation.value),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                Text(
                  'Available for work',
                  style: TextStyle(
                    color: galaxyGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),

          // Main title with stellar effect
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [starWhite, moonGlow, cosmicBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Rushil Sharma',
              style: TextStyle(
                fontSize: isDesktop ? 84 : 56,
                fontWeight: FontWeight.w900,
                color: starWhite,
                letterSpacing: -3,
                height: 0.85,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 25),

          // Subtitle with gradient
          AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    nebulaPurple,
                    cosmicBlue.withOpacity(0.7 + _glowAnimation.value * 0.3),
                    stellarPink,
                    galaxyGreen.withOpacity(0.8 + _glowAnimation.value * 0.2),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ).createShader(bounds),
                child: Text(
                  'Flutter Developer & UI/UX Designer',
                  style: TextStyle(
                    fontSize: isDesktop ? 32 : 24,
                    fontWeight: FontWeight.w700,
                    color: starWhite,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          SizedBox(height: 35),

          // Description
          Container(
            constraints: BoxConstraints(maxWidth: 650),
            child: Text(
              'I craft beautiful, performant mobile applications with Flutter, focusing on exceptional user experiences and clean, maintainable code.',
              style: TextStyle(
                fontSize: 19,
                color: asteroidGray.withOpacity(0.9),
                height: 1.7,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 55),

          // CTA Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCosmicButton(
                'View My Work',
                    () => _scrollToSection(_projectsKey),
                [nebulaPurple, cosmicBlue],
                Icons.work,
              ),
              SizedBox(width: 25),
              _buildCosmicOutlineButton(
                'Get In Touch',
                    () => _scrollToSection(_contactKey),
                Icons.mail,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCosmicButton(String text, VoidCallback onPressed, List<Color> colors, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: colors[0].withOpacity(0.4 + _glowAnimation.value * 0.2),
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: starWhite, size: 18),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      color: starWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCosmicOutlineButton(String text, VoidCallback onPressed, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: voidBorder.withOpacity(0.6 + _glowAnimation.value * 0.4),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: moonGlow, size: 18),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      color: moonGlow,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return SliverToBoxAdapter(
      child: Container(
        key: _aboutKey,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 30,
          vertical: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCosmicSectionHeader('About Me', 'Getting to know me', Icons.person),
            SizedBox(height: 70),
            isDesktop ? _buildDesktopAbout() : _buildMobileAbout(),
          ],
        ),
      ),
    );
  }

  Widget _buildCosmicSectionHeader(String title, String subtitle, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: nebulaPurple, size: 24),
            SizedBox(width: 12),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                color: nebulaPurple,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [starWhite, cosmicBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              color: starWhite,
              letterSpacing: -2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopAbout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildAboutContent(),
        ),
        SizedBox(width: 70),
        Expanded(
          child: _buildAboutStats(),
        ),
      ],
    );
  }

  Widget _buildMobileAbout() {
    return Column(
      children: [
        _buildAboutContent(),
        SizedBox(height: 50),
        _buildAboutStats(),
      ],
    );
  }

  Widget _buildAboutContent() {
    return Container(
      padding: EdgeInsets.all(45),
      decoration: BoxDecoration(
        color: stardust.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: voidBorder.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: nebulaPurple.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: stellarPink, size: 28),
              SizedBox(width: 15),
              Text(
                'Passionate Flutter Developer',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: starWhite,
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Text(
            'I specialize in creating beautiful, high-performance mobile applications using Flutter. With a focus on healthcare, sustainability, and environmental technology, I bring ideas to life through clean code and thoughtful design.',
            style: TextStyle(
              fontSize: 17,
              height: 1.8,
              color: asteroidGray,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 35),
          _buildCosmicExpertiseList(),
        ],
      ),
    );
  }

  Widget _buildCosmicExpertiseList() {
    final expertise = [
      {'text': 'Cross-Platform Mobile Development', 'icon': Icons.phonelink},
      {'text': 'UI/UX Design Implementation', 'icon': Icons.design_services},
      {'text': 'Healthcare Application Systems', 'icon': Icons.health_and_safety},
      {'text': 'Environmental Tech Solutions', 'icon': Icons.eco},
      {'text': 'Performance Optimization', 'icon': Icons.speed},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: expertise.map((item) => Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Icon(item['icon'] as IconData, color: cosmicBlue, size: 18),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                item['text'] as String,
                style: TextStyle(
                  fontSize: 15,
                  color: moonGlow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildAboutStats() {
    final stats = [
      {'value': '3+', 'label': 'Years\nExperience', 'icon': Icons.timeline, 'color': nebulaPurple},
      {'value': '15+', 'label': 'Projects\nCompleted', 'icon': Icons.work, 'color': cosmicBlue},
      {'value': '100%', 'label': 'Client\nSatisfaction', 'icon': Icons.star, 'color': stellarPink},
    ];

    return Column(
      children: stats.map((stat) => Container(
        margin: EdgeInsets.only(bottom: 25),
        padding: EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: stardust.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: (stat['color'] as Color).withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: (stat['color'] as Color).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 32),
            SizedBox(height: 15),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [stat['color'] as Color, starWhite],
              ).createShader(bounds),
              child: Text(
                stat['value']! as String,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: starWhite,
                  letterSpacing: -1.5,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              stat['label']! as String,
              style: TextStyle(
                fontSize: 14,
                color: asteroidGray,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildProjectsSection() {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return SliverToBoxAdapter(
      child: Container(
        key: _projectsKey,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 30,
          vertical: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCosmicSectionHeader('Featured Projects', 'My recent work', Icons.work),
            SizedBox(height: 70),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 2 : 1,
                crossAxisSpacing: 50,
                mainAxisSpacing: 50,
                childAspectRatio: isDesktop ? 1.1 : 0.75,
              ),
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                return _buildCosmicProjectCard(_projects[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  final List<ProjectData> _projects = [
    ProjectData(
      title: 'Tele-ICU Care System',
      description: 'Advanced healthcare platform enabling remote ICU monitoring with real-time patient data visualization and alert systems.',
      technologies: ['Flutter', 'Firebase', 'WebRTC', 'Charts'],
      gradientColors: [nebulaPurple, cosmicBlue],
      category: 'Healthcare',
      url: 'https://example.com',
      icon: Icons.health_and_safety,
    ),
    ProjectData(
      title: 'VIKALP Sustainability App',
      description: 'Environmental awareness platform with gamification features to promote sustainable living practices.',
      technologies: ['Flutter', 'Gamification', 'Analytics', 'Social'],
      gradientColors: [galaxyGreen, cosmicBlue],
      category: 'Environment',
      url: 'https://example.com',
      icon: Icons.eco,
    ),
    ProjectData(
      title: 'Wetlands Assessment Tool',
      description: 'Comprehensive environmental monitoring system for wetland ecosystem evaluation and data collection.',
      technologies: ['Flutter', 'GIS', 'Data Visualization', 'APIs'],
      gradientColors: [cosmicBlue, stellarPink],
      category: 'Environment',
      url: 'https://example.com',
      icon: Icons.water_drop,
    ),
  ];

  Widget _buildCosmicProjectCard(ProjectData project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(project.url),
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: stardust.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: project.gradientColors[0].withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: project.gradientColors[0].withOpacity(0.1 + _glowAnimation.value * 0.1),
                    blurRadius: 30,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: project.gradientColors),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(project.icon, color: starWhite, size: 16),
                            SizedBox(width: 8),
                            Text(
                              project.category,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: starWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.launch, color: asteroidGray, size: 24),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: starWhite,
                      letterSpacing: -0.8,
                    ),
                  ),
                  SizedBox(height: 18),
                  Expanded(
                    child: Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: asteroidGray,
                        height: 1.7,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: project.technologies.map((tech) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: deepSpace.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: voidBorder.withOpacity(0.5)),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          fontSize: 13,
                          color: moonGlow,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return SliverToBoxAdapter(
      child: Container(
        key: _skillsKey,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 30,
          vertical: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCosmicSectionHeader('Skills & Technologies', 'What I work with', Icons.code),
            SizedBox(height: 70),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: isDesktop ? 4 : 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              childAspectRatio: isDesktop ? 1.3 : 1.2,
              children: _skills.map((skill) => _buildCosmicSkillCard(skill)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  final List<SkillData> _skills = [
    SkillData('Flutter', 0.95, nebulaPurple, Icons.phone_android),
    SkillData('Dart', 0.90, cosmicBlue, Icons.code),
    SkillData('Firebase', 0.85, stellarPink, Icons.cloud),
    SkillData('UI/UX', 0.88, galaxyGreen, Icons.palette),
    SkillData('Git', 0.92, nebulaPurple, Icons.account_tree),
    SkillData('APIs', 0.87, cosmicBlue, Icons.api),
    SkillData('Testing', 0.80, stellarPink, Icons.science),
    SkillData('DevOps', 0.75, galaxyGreen, Icons.settings_applications),
  ];

  Widget _buildCosmicSkillCard(SkillData skill) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: stardust.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: skill.color.withOpacity(0.3 + _glowAnimation.value * 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: skill.color.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: skill.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: skill.color.withOpacity(0.3)),
                ),
                child: Icon(skill.icon, color: skill.color, size: 32),
              ),
              SizedBox(height: 15),
              Text(
                skill.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: starWhite,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: deepSpace,
                ),
                child: LinearProgressIndicator(
                  value: skill.proficiency,
                  backgroundColor: deepSpace,
                  valueColor: AlwaysStoppedAnimation<Color>(skill.color),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${(skill.proficiency * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  color: asteroidGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactSection() {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return SliverToBoxAdapter(
      child: Container(
        key: _contactKey,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 30,
          vertical: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCosmicSectionHeader('Let\'s Work Together', 'Get in touch', Icons.mail),
            SizedBox(height: 70),
            Container(
              padding: EdgeInsets.all(60),
              decoration: BoxDecoration(
                color: stardust.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: voidBorder.withOpacity(0.5), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: nebulaPurple.withOpacity(0.1),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.handshake, color: cosmicBlue, size: 32),
                      SizedBox(width: 15),
                      Text(
                        'Ready to bring your ideas to life?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: starWhite,
                          letterSpacing: -1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'I\'m always open to discussing new opportunities and interesting projects.',
                    style: TextStyle(
                      fontSize: 17,
                      color: asteroidGray,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 55),
                  isDesktop ? _buildDesktopContact() : _buildMobileContact(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopContact() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _contactItems,
    );
  }

  Widget _buildMobileContact() {
    return Column(
      children: _contactItems.map((item) => Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: item,
      )).toList(),
    );
  }

  List<Widget> get _contactItems => [
    _buildCosmicContactItem(
      'Email',
      'rushil@example.com',
      Icons.email,
          () => _launchURL('mailto:rushil@example.com'),
      nebulaPurple,
    ),
    _buildCosmicContactItem(
      'LinkedIn',
      'Connect with me',
      Icons.work,
          () => _launchURL('https://linkedin.com'),
      cosmicBlue,
    ),
    _buildCosmicContactItem(
      'GitHub',
      'View my code',
      Icons.code,
          () => _launchURL('https://github.com/Byte-Rush'),
      stellarPink,
    ),
  ];

  Widget _buildCosmicContactItem(String title, String subtitle, IconData icon, VoidCallback onTap, Color color) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: deepSpace.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: color.withOpacity(0.3 + _glowAnimation.value * 0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Icon(icon, color: color, size: 36),
                  ),
                  SizedBox(height: 20),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: starWhite,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15,
                      color: asteroidGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(70),
        decoration: BoxDecoration(
          color: deepSpace.withOpacity(0.8),
          border: Border(top: BorderSide(color: voidBorder.withOpacity(0.3), width: 2)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: stellarPink, size: 24),
                SizedBox(width: 12),
                Text(
                  'Crafted with ❤️ using Flutter',
                  style: TextStyle(
                    fontSize: 18,
                    color: moonGlow,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '© 2024 Rushil Sharma. All rights reserved.',
              style: TextStyle(
                fontSize: 14,
                color: asteroidGray.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) {
    html.window.open(url, '_blank');
  }
}

class ProjectData {
  final String title;
  final String description;
  final List<String> technologies;
  final List<Color> gradientColors;
  final String category;
  final String url;
  final IconData icon;

  ProjectData({
    required this.title,
    required this.description,
    required this.technologies,
    required this.gradientColors,
    required this.category,
    required this.url,
    required this.icon,
  });
}

class SkillData {
  final String name;
  final double proficiency;
  final Color color;
  final IconData icon;

  SkillData(this.name, this.proficiency, this.color, this.icon);
}

// Cosmic Background Painters
class StarFieldPainter extends CustomPainter {
  final double animation;

  StarFieldPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Create twinkling stars
    for (int i = 0; i < 150; i++) {
      final double x = (size.width * 0.1 * i * 1.7) % size.width;
      final double y = (size.height * 0.3 * i * 2.1) % size.height;
      final double twinkle = math.sin(animation * 4 * math.pi + i * 0.5);
      final double radius = 0.5 + math.cos(twinkle) * 1.5;
      final double opacity = 0.3 + math.cos(twinkle) * 0.7;

      paint.color = Color(0xFFFFFFFF).withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Create shooting stars
    for (int i = 0; i < 3; i++) {
      final double progress = (animation + i * 0.3) % 1.0;
      final double x = progress * size.width * 1.2 - size.width * 0.1;
      final double y = size.height * 0.2 + i * size.height * 0.3;

      if (x > -50 && x < size.width + 50) {
        paint.color = Color(0xFF06B6D4).withOpacity(0.8);
        canvas.drawCircle(Offset(x, y), 2, paint);

        // Trail effect
        for (int j = 1; j <= 10; j++) {
          final trailX = x - j * 8;
          final trailOpacity = (0.8 * (10 - j) / 10);
          paint.color = Color(0xFF06B6D4).withOpacity(trailOpacity);
          canvas.drawCircle(Offset(trailX, y), 1.5 - j * 0.1, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class NebulaePainter extends CustomPainter {
  final double animation;

  NebulaePainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Purple nebula
    final purpleCenter = Offset(size.width * 0.2, size.height * 0.7);
    paint.shader = RadialGradient(
      colors: [
        Color(0xFF6366F1).withOpacity(0.1 + animation * 0.05),
        Color(0xFF8B5CF6).withOpacity(0.05 + animation * 0.03),
        Color(0xFF6366F1).withOpacity(0.0),
      ],
      stops: [0.0, 0.6, 1.0],
    ).createShader(Rect.fromCircle(center: purpleCenter, radius: 300));

    canvas.drawCircle(
        Offset(purpleCenter.dx + math.cos(animation * math.pi) * 30,
            purpleCenter.dy + math.sin(animation * math.pi * 0.7) * 20),
        280 + math.sin(animation * 2 * math.pi) * 20,
        paint
    );

    // Blue nebula
    final blueCenter = Offset(size.width * 0.8, size.height * 0.3);
    paint.shader = RadialGradient(
      colors: [
        Color(0xFF0EA5E9).withOpacity(0.08 + animation * 0.04),
        Color(0xFF06B6D4).withOpacity(0.04 + animation * 0.02),
        Color(0xFF0EA5E9).withOpacity(0.0),
      ],
      stops: [0.0, 0.7, 1.0],
    ).createShader(Rect.fromCircle(center: blueCenter, radius: 250));

    canvas.drawCircle(
        Offset(blueCenter.dx - math.cos(animation * math.pi * 1.3) * 25,
            blueCenter.dy + math.sin(animation * math.pi * 0.9) * 35),
        220 + math.cos(animation * 3 * math.pi) * 15,
        paint
    );

    // Pink nebula
    final pinkCenter = Offset(size.width * 0.5, size.height * 0.1);
    paint.shader = RadialGradient(
      colors: [
        Color(0xFFF472B6).withOpacity(0.06 + animation * 0.03),
        Color(0xFFEC4899).withOpacity(0.03 + animation * 0.02),
        Color(0xFFF472B6).withOpacity(0.0),
      ],
      stops: [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: pinkCenter, radius: 180));

    canvas.drawCircle(
        Offset(pinkCenter.dx + math.sin(animation * math.pi * 1.1) * 20,
            pinkCenter.dy + math.cos(animation * math.pi * 0.8) * 15),
        160 + math.sin(animation * 2.5 * math.pi) * 12,
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GalaxyPainter extends CustomPainter {
  final double animation;

  GalaxyPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width * 0.6, size.height * 0.6);

    // Draw spiral galaxy arms
    for (int arm = 0; arm < 3; arm++) {
      final Path spiralPath = Path();
      bool isFirstPoint = true;

      for (double t = 0; t < 4 * math.pi; t += 0.1) {
        final double armOffset = arm * 2 * math.pi / 3;
        final double spiralRadius = 20 + t * 15;
        final double x = center.dx + spiralRadius * math.cos(t + armOffset + animation * 0.5);
        final double y = center.dy + spiralRadius * math.sin(t + armOffset + animation * 0.5);

        if (spiralRadius > 200) break;

        if (isFirstPoint) {
          spiralPath.moveTo(x, y);
          isFirstPoint = false;
        } else {
          spiralPath.lineTo(x, y);
        }
      }

      // Gradient effect for spiral arms
      paint.shader = LinearGradient(
        colors: [
          Color(0xFF6366F1).withOpacity(0.6),
          Color(0xFF0EA5E9).withOpacity(0.3),
          Color(0xFF34D399).withOpacity(0.1),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 200));

      canvas.drawPath(spiralPath, paint);
    }

    // Galaxy center
    paint.style = PaintingStyle.fill;
    paint.shader = RadialGradient(
      colors: [
        Color(0xFFFFFFFF).withOpacity(0.8),
        Color(0xFF6366F1).withOpacity(0.4),
        Color(0xFF6366F1).withOpacity(0.0),
      ],
    ).createShader(Rect.fromCircle(center: center, radius: 25));

    canvas.drawCircle(center, 20 + math.sin(animation * 3 * math.pi) * 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CosmicHeroBackgroundPainter extends CustomPainter {
  final double animation;

  CosmicHeroBackgroundPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    // Main cosmic orb
    paint.shader = RadialGradient(
      colors: [
        Color(0xFF6366F1).withOpacity(0.15 + animation * 0.1),
        Color(0xFF8B5CF6).withOpacity(0.08 + animation * 0.05),
        Color(0xFF0EA5E9).withOpacity(0.03 + animation * 0.02),
        Color(0xFF6366F1).withOpacity(0.0),
      ],
      stops: [0.0, 0.4, 0.7, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: 400));

    canvas.drawCircle(
        Offset(center.dx + math.cos(animation * 2 * math.pi) * 60,
            center.dy + math.sin(animation * 2 * math.pi) * 40),
        350 + math.sin(animation * 3 * math.pi) * 50,
        paint
    );

    // Secondary cosmic orb
    paint.shader = RadialGradient(
      colors: [
        Color(0xFF0EA5E9).withOpacity(0.12 + animation * 0.08),
        Color(0xFF06B6D4).withOpacity(0.06 + animation * 0.04),
        Color(0xFF0EA5E9).withOpacity(0.0),
      ],
      stops: [0.0, 0.6, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: 300));

    canvas.drawCircle(
        Offset(center.dx - math.cos(animation * 1.5 * math.pi) * 80,
            center.dy - math.sin(animation * 1.5 * math.pi) * 60),
        280 + math.cos(animation * 2.5 * math.pi) * 40,
        paint
    );

    // Tertiary cosmic orb
    paint.shader = RadialGradient(
      colors: [
        Color(0xFFF472B6).withOpacity(0.08 + animation * 0.06),
        Color(0xFFEC4899).withOpacity(0.04 + animation * 0.03),
        Color(0xFFF472B6).withOpacity(0.0),
      ],
      stops: [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: 200));

    canvas.drawCircle(
        Offset(center.dx + math.sin(animation * 1.8 * math.pi) * 100,
            center.dy + math.cos(animation * 1.8 * math.pi) * 70),
        180 + math.sin(animation * 4 * math.pi) * 30,
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}