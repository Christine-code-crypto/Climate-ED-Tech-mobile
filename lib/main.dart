import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SolEduApp());
}

class SolEduApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolEdu - Climate Education',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF2E7D32),
        accentColor: Color(0xFF66BB6A),
        scaffoldBackgroundColor: Color(0xFFF1F8E9),
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/learn': (context) => LearnScreen(),
        '/quiz': (context) => QuizScreen(),
        '/progress': (context) => ProgressScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    _controller.forward();
    
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E7D32),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.eco,
                  size: 60,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'SolEdu',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Climate Education Without Borders',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SolEdu', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              _showNotifications(context);
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildHomeTab(),
          LearnScreen(),
          QuizScreen(),
          ProgressScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Progress'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          SizedBox(height: 20),
          _buildQuickStats(),
          SizedBox(height: 20),
          _buildFeaturedTopics(),
          SizedBox(height: 20),
          _buildDailyChallenge(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Climate Learning!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Continue your journey to understand and protect our planet.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF2E7D32),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Start Learning'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Lessons\nCompleted', '12', Icons.check_circle, Colors.green),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildStatCard('Quiz\nScore', '85%', Icons.quiz, Colors.blue),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildStatCard('Streak\nDays', '7', Icons.local_fire_department, Colors.orange),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black05,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedTopics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Topics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTopicCard('Climate Change Basics', 'Understanding the fundamentals', Icons.thermostat, Colors.red),
              _buildTopicCard('Renewable Energy', 'Solar, wind, and clean power', Icons.wb_sunny, Colors.yellow),
              _buildTopicCard('Ocean Conservation', 'Protecting marine ecosystems', Icons.waves, Colors.blue),
              _buildTopicCard('Sustainable Living', 'Eco-friendly lifestyle tips', Icons.eco, Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopicCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black05,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: color, size: 25),
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallenge() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFF66BB6A), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Color(0xFF66BB6A), size: 24),
              SizedBox(width: 10),
              Text(
                'Daily Challenge',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Calculate your carbon footprint for today and learn 3 ways to reduce it!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              _showDailyChallengeDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF66BB6A),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Take Challenge'),
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notifications'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.eco, color: Colors.green),
              title: Text('New lesson available!'),
              subtitle: Text('Ocean Acidification - 5 min read'),
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text('Achievement unlocked!'),
              subtitle: Text('Climate Champion - Complete 10 lessons'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDailyChallengeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Daily Challenge'),
        content: Text('Carbon Footprint Calculator\n\nTrack your daily activities and discover your environmental impact. Complete this challenge to earn 50 points!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to carbon calculator
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}

class LearnScreen extends StatelessWidget {
  final List<Map<String, dynamic>> lessons = [
    {
      'title': 'Climate Change Fundamentals',
      'duration': '15 min',
      'difficulty': 'Beginner',
      'icon': Icons.thermostat,
      'color': Colors.red,
      'description': 'Learn the basic science behind climate change and global warming.',
    },
    {
      'title': 'Renewable Energy Sources',
      'duration': '20 min',
      'difficulty': 'Intermediate',
      'icon': Icons.wb_sunny,
      'color': Colors.orange,
      'description': 'Explore solar, wind, hydro and other clean energy solutions.',
    },
    {
      'title': 'Carbon Footprint Basics',
      'duration': '12 min',
      'difficulty': 'Beginner',
      'icon': Icons.co2,
      'color': Colors.grey,
      'description': 'Understand what carbon footprint means and how to measure it.',
    },
    {
      'title': 'Ocean and Climate',
      'duration': '18 min',
      'difficulty': 'Intermediate',
      'icon': Icons.waves,
      'color': Colors.blue,
      'description': 'Discover how oceans regulate climate and face acidification.',
    },
    {
      'title': 'Sustainable Transportation',
      'duration': '10 min',
      'difficulty': 'Beginner',
      'icon': Icons.directions_bus,
      'color': Colors.green,
      'description': 'Learn about eco-friendly ways to get around.',
    },
    {
      'title': 'Climate Solutions',
      'duration': '25 min',
      'difficulty': 'Advanced',
      'icon': Icons.lightbulb,
      'color': Colors.yellow,
      'description': 'Explore innovative technologies and policies fighting climate change.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressSection(),
            SizedBox(height: 20),
            Text(
              'Available Lessons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 15),
            ...lessons.map((lesson) => _buildLessonCard(context, lesson)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learning Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '12 of 25 lessons completed',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.48,
                      backgroundColor: Colors.white30,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  '48%',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, Map<String, dynamic> lesson) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () => _openLesson(context, lesson),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: lesson['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    lesson['icon'],
                    color: lesson['color'],
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        lesson['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildTag(lesson['duration'], Icons.access_time, Colors.blue),
                          SizedBox(width: 8),
                          _buildTag(lesson['difficulty'], Icons.signal_cellular_alt, Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _openLesson(BuildContext context, Map<String, dynamic> lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonDetailScreen(lesson: lesson),
      ),
    );
  }
}

class LessonDetailScreen extends StatefulWidget {
  final Map<String, dynamic> lesson;

  LessonDetailScreen({required this.lesson});

  @override
  _LessonDetailScreenState createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int currentPage = 0;
  late PageController pageController;
  
  late List<Map<String, String>> lessonContent;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    lessonContent = _getLessonContent(widget.lesson['title']);
  }

  List<Map<String, String>> _getLessonContent(String title) {
    switch (title) {
      case 'Climate Change Fundamentals':
        return [
          {
            'title': 'What is Climate Change?',
            'content': 'Climate change refers to long-term shifts in global temperatures and weather patterns. While climate variations occur naturally, human activities since the 1800s have been the main driver of climate change.',
          },
          {
            'title': 'The Greenhouse Effect',
            'content': 'The greenhouse effect is a natural process where certain gases in Earth\'s atmosphere trap heat from the sun, keeping our planet warm enough to support life. However, human activities have increased these greenhouse gases.',
          },
          {
            'title': 'Main Causes',
            'content': 'The primary cause is burning fossil fuels like coal, oil, and gas. This releases carbon dioxide and other greenhouse gases into the atmosphere, enhancing the natural greenhouse effect.',
          },
          {
            'title': 'Global Impact',
            'content': 'Climate change is causing rising sea levels, extreme weather events, changes in precipitation patterns, and threats to food security and biodiversity worldwide.',
          },
        ];
      default:
        return [
          {
            'title': 'Introduction',
            'content': 'Welcome to this lesson on ${widget.lesson['title']}. This comprehensive guide will help you understand the key concepts and their importance in climate science.',
          },
          {
            'title': 'Key Concepts',
            'content': 'In this section, we\'ll explore the fundamental principles and scientific basis behind ${widget.lesson['title']}.',
          },
          {
            'title': 'Real-World Applications',
            'content': 'Learn how these concepts apply to real-world scenarios and their impact on our daily lives and the environment.',
          },
          {
            'title': 'What You Can Do',
            'content': 'Discover practical actions you can take to make a positive impact and contribute to climate solutions.',
          },
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson['title']),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (currentPage + 1) / lessonContent.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '${currentPage + 1}/${lessonContent.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: lessonContent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lessonContent[index]['title']!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      SizedBox(height: 24),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            lessonContent[index]['content']!,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Navigation buttons
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage > 0
                    ? ElevatedButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black87,
                        ),
                        child: Text('Previous'),
                      )
                    : SizedBox(),
                currentPage < lessonContent.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4CAF50),
                        ),
                        child: Text('Next'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _completLesson(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2E7D32),
                        ),
                        child: Text('Complete'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completLesson(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lesson Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 50),
            SizedBox(height: 16),
            Text('Congratulations! You\'ve completed this lesson.'),
            SizedBox(height: 8),
            Text('Points earned: +50', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Continue Learning'),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;
  bool answered = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the main cause of current climate change?',
      'options': [
        'Natural climate variations',
        'Solar radiation changes',
        'Human activities and fossil fuel burning',
        'Volcanic eruptions',
      ],
      'correct': 2,
      'explanation': 'Human activities, particularly burning fossil fuels, are the primary driver of current climate change.',
    },
    {
      'question': 'Which gas contributes most to the greenhouse effect?',
      'options': [
        'Oxygen',
        'Carbon dioxide',
        'Nitrogen',
        'Hydrogen',
      ],
      'correct': 1,
      'explanation': 'Carbon dioxide is the most significant greenhouse gas contributing to climate change.',
    },
    {
      'question': 'What percentage of global greenhouse gas emissions come from transportation?',
      'options': [
        '10%',
        '14%',
        '25%',
        '35%',
      ],
      'correct': 1,
      'explanation': 'Transportation accounts for approximately 14% of global greenhouse gas emissions.',
    },
    {
      'question': 'Which renewable energy source is most widely used globally?',
      'options': [
        'Solar power',
        'Wind power',
        'Hydroelectric power',
        'Geothermal power',
      ],
      'correct': 2,
      'explanation': 'Hydroelectric power is currently the most widely used renewable energy source worldwide.',
    },
    {
      'question': 'What is the Paris Agreement\'s main goal?',
      'options': [
        'Eliminate all fossil fuels by 2030',
        'Limit global warming to well below 2°C',
        'Plant 1 billion trees worldwide',
        'Ban single-use plastics globally',
      ],
      'correct': 1,
      'explanation': 'The Paris Agreement aims to limit global warming to well below 2°C above pre-industrial levels.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Climate Quiz'),
        automaticallyImplyLeading: false,
      ),
      body: currentQuestion < questions.length
          ? _buildQuizContent()
          : _buildQuizResults(),
    );
  }

  Widget _buildQuizContent() {
    final question = questions[currentQuestion];
    
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress indicator
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (currentQuestion + 1) / questions.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                ),
              ),
              SizedBox(width: 16),
              Text(
                '${currentQuestion + 1}/${questions.length}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 30),
          
          // Question
          Text(
            question['question'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 30),
          
          // Options
          Expanded(
            child: ListView.builder(
              itemCount: question['options'].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: answered ? null : () => _selectAnswer(index),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _getOptionColor(index, question['correct']),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: _getOptionBackgroundColor(index, question['correct']),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _getOptionColor(index, question['correct']),
                                width: 2,
                              ),
                              color: selectedAnswer == index 
                                  ? _getOptionColor(index, question['correct'])
                                  : Colors.transparent,
                            ),
                            child: selectedAnswer == index
                                ? Icon(Icons.check, color: Colors.white, size: 16)
                                : null,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              question['options'][index],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
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
          
          // Explanation (shown after answering)
          if (answered) ...[
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Explanation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    question['explanation'],
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ],
              ),
            ),
          ],
          
          // Next button
          if (answered)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentQuestion < questions.length - 1 ? 'Next Question' : 'See Results',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuizResults() {
    double percentage = (score / questions.length) * 100;
    String grade = percentage >= 80 ? 'Excellent!' : 
                   percentage >= 60 ? 'Good!' : 
                   percentage >= 40 ? 'Fair' : 'Keep Learning!';
    
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: percentage >= 60 ? Colors.green[100] : Colors.orange[100],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${percentage.toInt()}%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: percentage >= 60 ? Colors.green[800] : Colors.orange[800],
                    ),
                  ),
                  Text(
                    '$score/${questions.length}',
                    style: TextStyle(
                      fontSize: 16,
                      color: percentage >= 60 ? Colors.green[600] : Colors.orange[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            grade,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'You scored $score out of ${questions.length} questions correctly!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _retakeQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Retake Quiz'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to learning
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Continue Learning'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getOptionColor(int index, int correct) {
    if (!answered) return Colors.grey[400]!;
    if (index == correct) return Colors.green;
    if (index == selectedAnswer && index != correct) return Colors.red;
    return Colors.grey[400]!;
  }

  Color _getOptionBackgroundColor(int index, int correct) {
    if (!answered) return Colors.transparent;
    if (index == correct) return Colors.green[50]!;
    if (index == selectedAnswer && index != correct) return Colors.red[50]!;
    return Colors.transparent;
  }

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswer = index;
      answered = true;
      if (index == questions[currentQuestion]['correct']) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      currentQuestion++;
      selectedAnswer = null;
      answered = false;
    });
  }

  void _retakeQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      selectedAnswer = null;
      answered = false;
    });
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Progress'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsOverview(),
            SizedBox(height: 20),
            _buildAchievements(),
            SizedBox(height: 20),
            _buildLearningStreak(),
            SizedBox(height: 20),
            _buildWeeklyProgress(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Total Points', '1,240', Icons.star),
              ),
              Expanded(
                child: _buildStatItem('Lessons Done', '12/25', Icons.school),
              ),
              Expanded(
                child: _buildStatItem('Avg. Score', '85%', Icons.trending_up),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {'title': 'First Steps', 'desc': 'Complete your first lesson', 'earned': true, 'icon': Icons.flag},
      {'title': 'Quiz Master', 'desc': 'Score 100% on any quiz', 'earned': true, 'icon': Icons.quiz},
      {'title': 'Streak Keeper', 'desc': '7-day learning streak', 'earned': true, 'icon': Icons.local_fire_department},
      {'title': 'Climate Expert', 'desc': 'Complete all lessons', 'earned': false, 'icon': Icons.eco},
      {'title': 'Knowledge Sharer', 'desc': 'Share a lesson with friends', 'earned': false, 'icon': Icons.share},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: achievement['earned'] as bool 
                            ? Color(0xFF4CAF50) 
                            : Colors.grey[300],
                      ),
                      child: Icon(
                        achievement['icon'] as IconData,
                        color: achievement['earned'] as bool 
                            ? Colors.white 
                            : Colors.grey[600],
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      achievement['title'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: achievement['earned'] as bool 
                            ? Colors.black87 
                            : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLearningStreak() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black05,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
              SizedBox(width: 8),
              Text(
                'Learning Streak',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(
                '7',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Days',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'Keep it up!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: List.generate(7, (index) {
              return Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black05,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week\'s Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].asMap().entries.map((entry) {
              int index = entry.key;
              String day = entry.value;
              bool isActive = index < 5; // First 5 days are active
              
              return Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 30,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isActive ? Color(0xFF4CAF50) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 15),
          Text(
            '5 days active this week • 2 lessons completed',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildProfileSection(),
          SizedBox(height: 20),
          _buildSettingsSection('Notifications', [
            _buildSettingTile('Push Notifications', 'Get notified about new lessons', true),
            _buildSettingTile('Daily Reminders', 'Remind me to learn daily', true),
            _buildSettingTile('Achievement Alerts', 'Notify when I earn achievements', false),
          ]),
          SizedBox(height: 20),
          _buildSettingsSection('Learning', [
            _buildSettingTile('Offline Mode', 'Download lessons for offline use', false),
            _buildActionTile('Clear Progress', 'Reset all learning progress', Icons.refresh),
            _buildActionTile('Export Data', 'Download your learning data', Icons.download),
          ]),
          SizedBox(height: 20),
          _buildSettingsSection('About', [
            _buildActionTile('Help & Support', 'Get help and contact us', Icons.help),
            _buildActionTile('Privacy Policy', 'Read our privacy policy', Icons.privacy_tip),
            _buildActionTile('Terms of Service', 'Read terms and conditions', Icons.description),
          ]),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black05,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF4CAF50),
            child: Text(
              'U',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Climate Learner',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Level 3 • 1,240 points',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.edit, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black05,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingTile(String title, String subtitle, bool value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: (newValue) {
          // Handle switch change
        },
        activeColor: Color(0xFF4CAF50),
      ),
    );
  }

  Widget _buildActionTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4CAF50)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: () {
        // Handle action
      },
    );
  }
}