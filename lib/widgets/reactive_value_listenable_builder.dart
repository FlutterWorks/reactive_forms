import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A widget whose content stays synced with a [ValueListenable].
///
/// This widget is a wrapper around [ValueListenableBuilder] widget
/// that binds to a [FormControl] and stay synced with changes
/// in the control. The form control is specified with the [formControlName]
/// constructor argument.
///
/// See [ValueListenableBuilder] documentation for more information
///
class ReactiveValueListenableBuilder<T> extends StatelessWidget {
  final String formControlName;
  final Widget child;
  final ValueWidgetBuilder<T> builder;

  /// Create an instance of a [ReactiveValueListenableBuilder].
  ///
  /// The [formControlName] and [builder] arguments must not be null.
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [FormControl] that is bind
  /// with this widget.
  const ReactiveValueListenableBuilder({
    Key key,
    @required this.formControlName,
    @required this.builder,
    this.child,
  })  : assert(formControlName != null),
        assert(builder != null);

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context, listen: false);
    final formControl = form.formControl(this.formControlName);
    return ValueListenableBuilder<T>(
      valueListenable: formControl.onValueChanged,
      builder: this.builder,
    );
  }
}