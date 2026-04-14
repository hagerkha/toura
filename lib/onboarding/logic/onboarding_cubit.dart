// lib/logic/onboarding_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/onboarding_item.dart';

class OnboardingState {
  final int currentPage;
  final List<OnboardingItem> items;

  OnboardingState({
    required this.currentPage,
    required this.items,
  });

  OnboardingState copyWith({int? currentPage, List<OnboardingItem>? items}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      items: items ?? this.items,
    );
  }
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
      : super(OnboardingState(
    currentPage: 0,
    items: [
      OnboardingItem(
        image: 'assets/images/onboarding1.jpg',
        title: 'الحياة لحظة... لا تتوقف',
        description: 'أطلق العنان لمغامرتك وابدأ رحلتك الخاصة بالفيوم',
      ),

    ],
  ));

  void nextPage() {
    if (state.currentPage < state.items.length - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void setPage(int page) {
    emit(state.copyWith(currentPage: page));
  }
}
