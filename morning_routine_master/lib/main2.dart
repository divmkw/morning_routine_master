import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MorningRoutineApp());
}

class MorningRoutineApp extends StatelessWidget {
  const MorningRoutineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morning Routine Master',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFFF6B6B),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}
//******************************************************HOME PAGE *******************************************/
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    RoutineScreen(),
    StatsPage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: "Routine"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
  
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Build lasting morning habits",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.yellow[100],
            child: const ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text("Morning rituals create extraordinary days"),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.green[100],
            child: const ListTile(
              title: Text("Current Streak: 0 days in a row"),
              subtitle: Text("Longest: 0 days"),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Today's Progress"),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.3, backgroundColor: Colors.grey[200]),
          const SizedBox(height: 16),
          const Text("Today's Routine", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (var task in [
            {"title": "Drink Water", "time": "1 min"},
            {"title": "Stretch for 5 minutes", "time": "5 min"},
            {"title": "Meditate", "time": "10 min"},
          ])
            Card(
              child: ListTile(
                leading: const Icon(Icons.circle_outlined),
                title: Text(task["title"]!),
                subtitle: Text(task["time"]!),
              ),
            ),
        ],
      ),
    );
  }
}
  
//****************************************************** Routine PAGE *******************************************/



class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  RoutineScreenState createState() => RoutineScreenState();
}

class RoutineScreenState extends State<RoutineScreen> {
  // List to hold tasks
  List<Map<String, String>> tasks = [
    {"title": "Drink Water", "time": "1 min"},
    {"title": "Stretch for 5 minutes", "time": "5 min"},
    {"title": "Meditate", "time": "10 min"},
  ];

  // Function to add a new task
  void _addTask(String title, String time) {
    setState(() {
      tasks.add({"title": title, "time": time});
    });
  }

  // Function to show the Add Task dialog
  void _showAddTaskDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Task Name",
                  hintText: "e.g., Drink water, Stretch",
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: "Time Estimate (minutes)",
                  hintText: "e.g., 5",
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final String title = titleController.text.trim();
                final String time = timeController.text.trim();
                if (title.isNotEmpty && time.isNotEmpty) {
                  _addTask(title, "$time min");
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Task"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Build lasting morning habits",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Morning Routine", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ElevatedButton.icon(
                onPressed: _showAddTaskDialog, // Show Add Task dialog
                icon: const Icon(Icons.add),
                label: const Text("Add Task"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text("Total time: ${tasks.fold<int>(0, (sum, task) => sum + int.parse(task["time"]!.split(" ")[0]))} minutes"),
          const SizedBox(height: 16),
          for (var task in tasks)
            Card(
              child: ListTile(
                leading: const Icon(Icons.drag_handle),
                title: Text(task["title"]!),
                subtitle: Text(task["time"]!),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Add functionality for editing tasks here
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          tasks.remove(task);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          Card(
            color: Colors.blue[50],
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("💡 Pro Tips", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("• Drag tasks to reorder\n• Start with 3–5 habits\n• Keep time estimates realistic\n• Add gradually over time"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//****************************************************** Stats PAGE *******************************************/

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Sample dynamic data
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadMockData();
  }

  void _loadMockData() {
    _events = {
      DateTime.utc(2025, 10, 1): ['Completed Morning Routine'],
      DateTime.utc(2025, 10, 2): ['Missed Routine'],
      DateTime.utc(2025, 10, 5): ['Completed Routine'],
      DateTime.utc(2025, 10, 6): ['Completed Routine'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  Color _getDayStatusColor(DateTime day) {
    final events = _getEventsForDay(day);
    if (events.isEmpty) return Colors.grey.shade300;
    if (events.first.contains('Missed')) return Colors.redAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF7E5F), Color(0xFFFD3A84)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Morning Routine Master",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Build lasting morning habits",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Stats Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard("Current Streak", "2"),
                  _buildStatCard("Best Streak", "7"),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard("Success Rate", "75%"),
                  _buildStatCard("Total Days", "30"),
                ],
              ),
              const SizedBox(height: 20),

              // Calendar Section
              const Text(
                "Last 30 Days",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2025, 9, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: _getEventsForDay,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 1,
                    markerDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 40),
                          decoration: BoxDecoration(
                            color: _getDayStatusColor(date),
                            shape: BoxShape.circle,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _LegendDot(color: Colors.greenAccent, label: "Completed"),
                  SizedBox(width: 12),
                  _LegendDot(color: Colors.redAccent, label: "Missed"),
                  SizedBox(width: 12),
                  _LegendDot(color: Colors.grey, label: "Not Tracked"),
                ],
              ),

              const SizedBox(height: 20),

              // Selected Date Info
              if (_selectedDay != null)
                _buildSelectedDayInfo(_selectedDay!, _getEventsForDay(_selectedDay!)),

              const SizedBox(height: 20),

              // Achievements
              const Text(
                "🏆 Achievements",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _achievementCard("🌅 First Day", "Started your journey", true),
              _achievementCard("🔥 Week Warrior", "7 day streak", false),
              _achievementCard("🌕 Perfect Month", "30 day streak", false),
              _achievementCard("👑 Consistency King", "80% completion", false),

              const SizedBox(height: 20),

              // Motivation
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "💡 Every journey starts with a single step. Start small and be patient with yourself. Consistency matters more than perfection!",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDayInfo(DateTime date, List<String> events) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📅 ${DateFormat('EEEE, d MMMM y').format(date)}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          if (events.isEmpty)
            const Text("No routines tracked on this day.",
                style: TextStyle(color: Colors.grey)),
          ...events.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 18, color: Colors.deepPurple),
                    const SizedBox(width: 6),
                    Text(e, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _achievementCard(String title, String subtitle, bool unlocked) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: unlocked ? Colors.yellow.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(unlocked ? "Unlocked" : "Locked",
              style: TextStyle(
                  color: unlocked ? Colors.green : Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}



// ---------------- Helper Widgets ---------------- //

// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String? subtitle;

//   const _StatCard({required this.title, required this.value, this.subtitle});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 4),
//             Text(title, style: const TextStyle(color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Simple mock calendar widget
// class _CalendarWidget extends StatelessWidget {
//   const _CalendarWidget();

//   @override
//   Widget build(BuildContext context) {
//     // Simple 5x7 grid for mock 30-day calendar
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 30,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 7,
//         crossAxisSpacing: 4,
//         mainAxisSpacing: 4,
//       ),
//       itemBuilder: (context, index) {
//         return Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(6),
//             color: index == 29 ? Colors.blue.shade50 : Colors.white,
//           ),
//           alignment: Alignment.center,
//           child: Text("${index + 1}", style: const TextStyle(fontSize: 12)),
//         );
//       },
//     );
//   }
// }

// class _LegendItem extends StatelessWidget {
//   final Color color;
//   final String label;

//   const _LegendItem({required this.color, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
//         const SizedBox(width: 4),
//         Text(label, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }

// class _AchievementCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final bool locked;
//   final Color color;

//   const _AchievementCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.locked,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: color,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.orange),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(subtitle),
//         trailing: locked
//             ? const Text("Locked", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
//             : const Icon(Icons.check_circle, color: Colors.green),
//       ),
//     );
//   }
// }


//****************************************************** Settings PAGE *******************************************/

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Build lasting morning habits",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.access_time),
            title: Text("Morning Start Time"),
            subtitle: Text("07:00"),
            trailing: Icon(Icons.edit),
          ),
          SwitchListTile(
            title: const Text("Daily Reminders"),
            value: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 8),         
          const Text("Theme"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.light_mode),
                  label: const Text("Light"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.dark_mode),
                  label: const Text("Dark"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Save Settings"),
          ),
          const SizedBox(height: 24),
          const Text("Data Management"),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.file_download),
            label: const Text("Export Backup"),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.file_upload),
            label: const Text("Import Backup"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {},
            icon: const Icon(Icons.delete),
            label: const Text("Reset All Data"),
          ),
        ],
      ),
    );
  }
}
