// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Compose multiple validators into a single function.
///
/// If at least one validator returns 'null' then the compose validator
/// returns 'null', otherwise returns the union of the individual error
/// maps returned by each validator.
class ComposeOrValidator extends Validator {
  final List<ValidatorFunction> validators;

  /// Constructs an instance of the validator.
  ///
  /// The argument [validators] must not be null.
  ComposeOrValidator(this.validators) : assert(validators != null);

  @override
  Map<String, dynamic> validate(AbstractControl<dynamic> control) {
    final composedError = Map<String, dynamic>();

    for (final validator in this.validators) {
      final error = validator(control);
      if (error != null) {
        composedError.addAll(error);
      } else {
        return null;
      }
    }

    return composedError.isEmpty ? null : composedError;
  }
}
