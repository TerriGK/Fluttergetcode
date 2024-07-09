import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

// Importar el modelo Evento y EventCard desde los archivos correspondientes
import 'package:ejemploget/eventos.dart';
import 'package:ejemploget/cards.dart';

class EventosPage extends StatefulWidget {
  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  Evento? evento;
  TextEditingController idController = TextEditingController();
  List<Evento> eventosPublicos = []; 
  List<Evento> eventosPrivados = []; 

  @override
  void initState() {
    super.initState();
    fetchEventos(); 
  }

  void fetchEventos() async {
    try {
      final responsePublicos =
          await http.get(Uri.parse('http://generar ipconfig:3007/api/eventos?tipo=publico'));

      if (responsePublicos.statusCode == 200) {
        var jsonResponse = jsonDecode(responsePublicos.body);
        List<Evento> eventos =
            jsonResponse.map<Evento>((data) => Evento.fromJson(data)).toList();

        setState(() {
          eventosPublicos = eventos;
        });
      } else {
        print('Error al cargar eventos públicos: ${responsePublicos.statusCode}');
      }

      final responsePrivados =
          await http.get(Uri.parse('http://generar ipconfig :3007/api/eventos?tipo=privado'));

      if (responsePrivados.statusCode == 200) {
        var jsonResponse = jsonDecode(responsePrivados.body);
        List<Evento> eventos =
            jsonResponse.map<Evento>((data) => Evento.fromJson(data)).toList();

        setState(() {
          eventosPrivados = eventos;
        });
      } else {
        print('Error al cargar eventos privados: ${responsePrivados.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  void fetchData(int eventId) async {
    try {
      final response =
          await http.get(Uri.parse('http://genearar ipconfig :3007/api/eventos/$eventId'));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          evento = Evento.fromJson(jsonResponse);
        });
      } else {
        print('Error al cargar el evento: ${response.statusCode}');
        setState(() {
          evento = null;
        });
      }
    } catch (e) {
      print('Error de conexión: $e');
      setState(() {
        evento = null;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepPurple,
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
          },
        ),
      ],
      title: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Colors.white,
        ),
        child: TextField(
          controller: idController,
          onChanged: (value) {
            int eventId = int.tryParse(value) ?? 0;
            fetchData(eventId);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            hintText: 'Buscar por ID',
          ),
        ),
      ),
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
            },
          ),
        ],
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (evento != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Evento Encontrado',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  EventCard(evento: evento!),
                  SizedBox(height: 20),
                  Divider(),
                ],
              ),
            SizedBox(height: 20),
            Text(
              'Eventos Públicos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            eventosPublicos.isNotEmpty
                ? SizedBox(
                    height: 200,
                    child: CarouselSlider.builder(
                      itemCount: eventosPublicos.length,
                      options: CarouselOptions(
                        height: 200,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        Evento evento = eventosPublicos[index];
                        return EventCard(evento: evento);
                      },
                    ),
                  )
                : Center(
                    child: Text('No hay eventos públicos disponibles'),
                  ),
            SizedBox(height: 20),
            Text(
              'Eventos Privados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            eventosPrivados.isNotEmpty
                ? SizedBox(
                    height: 200,
                    child: CarouselSlider.builder(
                      itemCount: eventosPrivados.length,
                      options: CarouselOptions(
                        height: 200,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        Evento evento = eventosPrivados[index];
                        return EventCard(evento: evento);
                      },
                    ),
                  )
                : Center(
                    child: Text('No hay eventos privados disponibles'),
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
}
