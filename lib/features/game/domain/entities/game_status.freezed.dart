// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameStatus()';
}


}

/// @nodoc
class $GameStatusCopyWith<$Res>  {
$GameStatusCopyWith(GameStatus _, $Res Function(GameStatus) __);
}


/// Adds pattern-matching-related methods to [GameStatus].
extension GameStatusPatterns on GameStatus {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Playing value)?  playing,TResult Function( _Victory value)?  victory,TResult Function( _Draw value)?  draw,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Playing() when playing != null:
return playing(_that);case _Victory() when victory != null:
return victory(_that);case _Draw() when draw != null:
return draw(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Playing value)  playing,required TResult Function( _Victory value)  victory,required TResult Function( _Draw value)  draw,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Playing():
return playing(_that);case _Victory():
return victory(_that);case _Draw():
return draw(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Playing value)?  playing,TResult? Function( _Victory value)?  victory,TResult? Function( _Draw value)?  draw,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Playing() when playing != null:
return playing(_that);case _Victory() when victory != null:
return victory(_that);case _Draw() when draw != null:
return draw(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( Player turn)?  playing,TResult Function( Player winner)?  victory,TResult Function()?  draw,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Playing() when playing != null:
return playing(_that.turn);case _Victory() when victory != null:
return victory(_that.winner);case _Draw() when draw != null:
return draw();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( Player turn)  playing,required TResult Function( Player winner)  victory,required TResult Function()  draw,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Playing():
return playing(_that.turn);case _Victory():
return victory(_that.winner);case _Draw():
return draw();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( Player turn)?  playing,TResult? Function( Player winner)?  victory,TResult? Function()?  draw,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Playing() when playing != null:
return playing(_that.turn);case _Victory() when victory != null:
return victory(_that.winner);case _Draw() when draw != null:
return draw();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements GameStatus {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameStatus.initial()';
}


}




/// @nodoc


class _Playing implements GameStatus {
  const _Playing(this.turn);
  

 final  Player turn;

/// Create a copy of GameStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayingCopyWith<_Playing> get copyWith => __$PlayingCopyWithImpl<_Playing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Playing&&(identical(other.turn, turn) || other.turn == turn));
}


@override
int get hashCode => Object.hash(runtimeType,turn);

@override
String toString() {
  return 'GameStatus.playing(turn: $turn)';
}


}

/// @nodoc
abstract mixin class _$PlayingCopyWith<$Res> implements $GameStatusCopyWith<$Res> {
  factory _$PlayingCopyWith(_Playing value, $Res Function(_Playing) _then) = __$PlayingCopyWithImpl;
@useResult
$Res call({
 Player turn
});




}
/// @nodoc
class __$PlayingCopyWithImpl<$Res>
    implements _$PlayingCopyWith<$Res> {
  __$PlayingCopyWithImpl(this._self, this._then);

  final _Playing _self;
  final $Res Function(_Playing) _then;

/// Create a copy of GameStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? turn = null,}) {
  return _then(_Playing(
null == turn ? _self.turn : turn // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}


}

/// @nodoc


class _Victory implements GameStatus {
  const _Victory(this.winner);
  

 final  Player winner;

/// Create a copy of GameStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VictoryCopyWith<_Victory> get copyWith => __$VictoryCopyWithImpl<_Victory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Victory&&(identical(other.winner, winner) || other.winner == winner));
}


@override
int get hashCode => Object.hash(runtimeType,winner);

@override
String toString() {
  return 'GameStatus.victory(winner: $winner)';
}


}

/// @nodoc
abstract mixin class _$VictoryCopyWith<$Res> implements $GameStatusCopyWith<$Res> {
  factory _$VictoryCopyWith(_Victory value, $Res Function(_Victory) _then) = __$VictoryCopyWithImpl;
@useResult
$Res call({
 Player winner
});




}
/// @nodoc
class __$VictoryCopyWithImpl<$Res>
    implements _$VictoryCopyWith<$Res> {
  __$VictoryCopyWithImpl(this._self, this._then);

  final _Victory _self;
  final $Res Function(_Victory) _then;

/// Create a copy of GameStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? winner = null,}) {
  return _then(_Victory(
null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}


}

/// @nodoc


class _Draw implements GameStatus {
  const _Draw();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Draw);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameStatus.draw()';
}


}




// dart format on
