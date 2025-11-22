class HomeState {
  final String url;
  final bool isLoading;

  HomeState({required this.url, this.isLoading = false});

  HomeState copyWith({String? url, bool? isLoading}) {
    return HomeState(
      url: url ?? this.url,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
