import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_to_cart_event_bloc.dart';
import 'add_to_cart_state_bloc.dart';

StreamSubscription? item;

class AddToCartBloc extends Bloc<UpdateCartEvent, UpdateCartState> {
  AddToCartBloc(UpdateCartState initialState) : super(initialState) {
    on<InsertItemEvent>((event, emit) => emit(InsertItemState()));

    on<RemoveFromCartEvent>((event, emit) => emit(RemoveFromCartState()));
    item!.onData((data) {
      if (data == true) {
        add(InsertItemEvent());
      } else {
        add(RemoveFromCartEvent());
      }
    });
  }
}
