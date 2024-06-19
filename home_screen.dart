import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:prueba_demo/src/app_data.dart';
import 'package:prueba_demo/src/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppData>(context);

    // @override
    // Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),

      //aqui comienza el contenido del home

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://nl.medical.canon/wp-content/uploads/sites/7/2022/08/Standaard-avatar-150x150-1.jpg'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hello Emma!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: [
                  'https://via.placeholder.com/400',
                  'https://via.placeholder.com/400',
                  'https://via.placeholder.com/400',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              //child: Column(
              child: Consumer<AppData>(builder: (context, appData, child) {
                return Column(
                  children: [
                    Card(
                      color: Colors.black,
                      child: ListTile(
                        title: Text(
                          //'Gs 995.000',
                          'Gs ${appData.availableBalance.toStringAsFixed(1)}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        subtitle: const Text(
                          '**** 5693\nEMMA VEGA',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Expence'),
                            Text(
                              'Gs 0',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Income'),
                            Text(
                              'Gs 300.000',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Card(
                      color: Color.fromARGB(255, 165, 139, 213),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://via.placeholder.com/150'),
                        ),
                        title: Text('Gs 560.000'),
                        subtitle: Text('From Analia'),
                        trailing: Text(
                          'On Hold',
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 248, 248)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Transaction',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: Image.network('https://via.placeholder.com/40'),
                      title: const Text('Netflix'),
                      subtitle: const Text('Next 30 May'),
                      trailing: const Text(
                        '- 70.000',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                      ),
                      title: Text('Analia Aguilera'),
                      subtitle: Text('**** 5684'),
                      trailing: Text(
                        '+ 100.000',
                        style:
                            TextStyle(color: Color.fromARGB(255, 21, 160, 93)),
                      ),
                    ),
                    ListTile(
                      leading: Image.network('https://via.placeholder.com/40'),
                      title: const Text('Starbucks'),
                      subtitle: const Text('Food'),
                      trailing: const Text(
                        '- 85.000',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: const Color.fromARGB(255, 70, 55, 96),
              onPressed: () {
                // Add your navigation logic for home here
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: const Icon(Icons.send),
              color: const Color.fromARGB(255, 70, 55, 96),
              onPressed: () {
                // Add your navigation logic for cards here
                Navigator.pushNamed(context, '/send');
              },
            ),
            IconButton(
              icon: const Icon(Icons.contacts),
              color: const Color.fromARGB(255, 70, 55, 96),
              onPressed: () {
                // Add your navigation logic for activity here
                Navigator.pushNamed(context, '/contacts');
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              color: const Color.fromARGB(255, 70, 55, 96),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat),
              color: const Color.fromARGB(255, 70, 55, 96),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            onTap: () {
              // Navegar a la cuenta
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Navegar hacia las notificaciones
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy'),
            onTap: () {
              // Navegar hacia privacidad
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Appearance'),
            onTap: () {
              // Navegar hacia la apariencia
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            onTap: () {
              // Navegar hacia el idioma
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // Navegar hacia ayuda y soporte
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // Navegar hacia "about"
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            value: true,
            onChanged: (bool value) {
              // dark mode
            },
          ),
        ],
      ),
    );
  }
}
