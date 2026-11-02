import 'package:flutter/material.dart';

void main() {
  runApp(const TiliTiliApp());
}

class TiliTiliApp extends StatelessWidget {
  const TiliTiliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tili Tili',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.pink,
        colorScheme: const ColorScheme.dark(
          primary: Colors.pink,
          secondary: Colors.pinkAccent,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    FriendsPage(),
    CreatePage(),
    InboxPage(),
    ProfilePage(),
  ];

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Friends',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_box),
      label: 'Create',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: 'Inbox',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Tili Tili',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: items,
      ),
    );
  }
}

// HOME PAGE

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Welcome to Tili Tili!',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Icon(
            Icons.play_circle_fill,
            size: 100,
            color: Colors.pink,
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'Your world, your videos!',
            style: TextStyle(fontSize: 19),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Video Feed',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const VideoCard(
          username: 'Tili Tili Creator',
          description: 'Welcome to our new social media platform!',
        ),
        const VideoCard(
          username: 'New Creator',
          description: 'Share your talent with the world!',
        ),
      ],
    );
  }
}

class VideoCard extends StatelessWidget {
  final String username;
  final String description;

  const VideoCard({
    super.key,
    required this.username,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                color: Colors.pink,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.play_circle_fill,
                size: 75,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Like button clicked')),
                    );
                  },
                  icon: const Icon(Icons.favorite_border, color: Colors.pink),
                ),
                const Text('Like'),
                const SizedBox(width: 20),
                const Icon(Icons.comment, color: Colors.white70),
                const SizedBox(width: 6),
                const Text('Comment'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// FRIENDS PAGE

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List<String> friends = [
    'Rahul Creator',
    'Amit Kumar',
    'New Creator',
    'Tili Tili User',
  ];

  final Set<String> following = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Find Friends',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        for (final name in friends)
          Card(
            color: Colors.grey[900],
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.pink,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(name),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (following.contains(name)) {
                      following.remove(name);
                    } else {
                      following.add(name);
                    }
                  });
                },
                child: Text(
                  following.contains(name) ? 'Following' : 'Follow',
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// CREATE PAGE

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_library,
              color: Colors.pink,
              size: 95,
            ),
            const SizedBox(height: 20),
            const Text(
              'Create Your Video',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Video upload will be connected in the next step.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.video_call),
              label: const Text('Choose Video'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Video upload service will be connected next.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

// INBOX PAGE

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  void sendMessage() {
    final message = controller.text.trim();

    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
      });
      controller.clear();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'Your Messages',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: messages.isEmpty
              ? const Center(
                  child: Text(
                    'No messages yet',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.account_circle,
                        color: Colors.pink,
                      ),
                      title: Text(messages[index]),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Write a message...',
                  ),
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.send, color: Colors.pink),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// PROFILE PAGE

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'Tili Tili User';

  Future<void> editProfile() async {
    final controller = TextEditingController(text: username);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, controller.text.trim());
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (result != null && result.isNotEmpty && mounted) {
      setState(() {
        username = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.pink,
            child: Icon(Icons.person, size: 65, color: Colors.white),
          ),
          const SizedBox(height: 18),
          Text(
            username,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text('0 Followers     0 Following'),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: editProfile,
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
