import 'package:flutter/material.dart';

void main() => runApp(const TiliTiliApp());

class TiliTiliApp extends StatelessWidget {
  const TiliTiliApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Tili Tili',
    theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
    home: const MainScreen(),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final pages = const [HomePage(), DiscoverPage(), UploadPage(), MessagesPage(), ProfilePage()];
  final icons = [Icons.home, Icons.search, Icons.add_box, Icons.chat, Icons.person];
  final labels = ['Home', 'Discover', 'Upload', 'Messages', 'Profile'];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: Colors.black, centerTitle: true, title: const Text('Tili Tili', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold))),
    body: pages[index],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: index, type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black, selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.white70,
      onTap: (i) => setState(() => index = i),
      items: List.generate(5, (i) => BottomNavigationBarItem(icon: Icon(icons[i]), label: labels[i])),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.play_circle_fill, color: Colors.pink, size: 90), SizedBox(height: 20), Text('Welcome to Tili Tili', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)), Text('Your world, your videos!') ]));
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}
class _DiscoverPageState extends State<DiscoverPage> {
  String query = '';
  final items = ['Trending Videos', 'Popular Creators', 'Music', 'Comedy', 'Dance'];
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(16), child: Column(children: [TextField(decoration: const InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search)), onChanged: (v) => setState(() => query = v)), Expanded(child: ListView(children: items.where((e) => e.toLowerCase().contains(query.toLowerCase())).map((e) => ListTile(leading: const Icon(Icons.play_circle, color: Colors.pink), title: Text(e))).toList()))]));
}

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.video_library, color: Colors.pink, size: 85), const Text('Upload your video', style: TextStyle(fontSize: 24)), ElevatedButton(onPressed: () => showDialog(context: context, builder: (c) => AlertDialog(title: const Text('Upload'), content: const Text('Video upload service will be connected next.'), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('OK'))])), child: const Text('Choose video'))]));
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}
class _MessagesPageState extends State<MessagesPage> {
  final controller = TextEditingController();
  final messages = <String>[];
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Column(children: [const Padding(padding: EdgeInsets.all(20), child: Text('Messages', style: TextStyle(fontSize: 24))), Expanded(child: ListView(children: messages.map((m) => ListTile(title: Text(m))).toList())), Padding(padding: const EdgeInsets.all(12), child: Row(children: [Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Write a message'))), IconButton(icon: const Icon(Icons.send, color: Colors.pink), onPressed: () {if(controller.text.trim().isNotEmpty) {setState(() => messages.add(controller.text.trim())); controller.clear();}})]))]);
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  String username = 'Tili Tili User';
  @override
  Widget build(BuildContext context) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const CircleAvatar(radius: 50, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 60)), Text(username, style: const TextStyle(fontSize: 24)), const Text('0 Followers     0 Following'), ElevatedButton(onPressed: () async {final c = TextEditingController(text: username); final result = await showDialog<String>(context: context, builder: (ctx) => AlertDialog(title: const Text('Edit Profile'), content: TextField(controller: c), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')), TextButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('Save'))])); if(result != null && result.isNotEmpty) setState(() => username = result);}, child: const Text('Edit Profile'))]));
}
