import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_place/core/di/injector.dart';
import 'package:pixel_place/presentation/blocs/auth/auth_cubit.dart';
import 'package:pixel_place/presentation/blocs/pixel/pixel_bloc.dart';
import 'package:pixel_place/presentation/widgets/auth_button.dart';
import 'package:pixel_place/presentation/widgets/canvas_viewer.dart';
import 'package:pixel_place/presentation/widgets/color_picker.dart';
import 'package:pixel_place/presentation/widgets/history.dart';

import '../../../domain/entities/pixel.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "home-view";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Color color = Colors.black;

  final AuthCubit _authCubit = getIt.get()..login();
  final PixelBloc _pixelsBloc = getIt.get()
    ..add(PixelEventListen())
    ..add(PixelsHistoryEventListen());

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'duribreux/place',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 16,
            backgroundColor: const Color(0xAF0F0F0F),
            title: const Text('duribreux/place'),
            actions: [
              ColorPicker(
                color: color,
                onColorChanged: (color) => setState(() => this.color = color),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: _authCubit,
                listener: (context, state) => showAuthSnackBar(state, context),
                builder: (context, state) => AuthButton(
                  authCubit: _authCubit,
                  state: state,
                ),
              ),
            ],
            centerTitle: false,
          ),
          body: SafeArea(
            child: BlocListener<PixelBloc, PixelState>(
              bloc: _pixelsBloc,
              listener: (context, state) => showPixelSnackbar(state, context),
              child: Row(
                children: [
/*                   StreamBuilder<List<Pixel>>(
                    stream: _pixelsBloc.pixelsHistoryStream,
                    builder: (context, snapshot) => History(
                      pixels: snapshot.data ?? [],
                    ),
                  ), */
                  StreamBuilder<List<Pixel>>(
                    stream: _pixelsBloc.pixelsStream,
                    builder: (context, snapshot) => Expanded(
                      child: CanvasViewer(
                        pixelsBloc: _pixelsBloc,
                        color: color,
                        pixels: snapshot.data ?? [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void showPixelSnackbar(PixelState state, BuildContext context) {
    if (state is PixelsUnauthorized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must sign-in to draw')),
      );
    }
  }

  void showAuthSnackBar(AuthState state, BuildContext context) {
    if (state is AuthLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in anonymously'),
        ),
      );
    } else if (state is AuthLoggedOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out'),
        ),
      );
    }
  }
}
