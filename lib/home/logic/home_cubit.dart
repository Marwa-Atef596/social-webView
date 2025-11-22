import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(url: ''));

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrl = prefs.getString('saved_url') ?? '';
    emit(HomeState(url: savedUrl));
  }

  String formatUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  Future<void> setUrl(String url) async {
    final formattedUrl = formatUrl(url);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_url', url);
    emit(HomeState(url: formattedUrl));
  }
}
