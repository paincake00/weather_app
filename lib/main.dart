import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/screens/home.dart';
import 'package:weather_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await initializaDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoredLocationBloc>(
          create: (context) => sl<StoredLocationBloc>()
            ..add(
              GetCoordsEvent(),
            ),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => sl<LocationBloc>(),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => sl<WeatherBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
