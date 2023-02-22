# suggestion_text_editing_controller_flutter
An extended text editing controller that supports different inline styles for custom regex.
###### a text editing controller that can display suggestion text after input, and style input and suggestion ( can be configured to look like a like a code editor )
## Getting Started


### 1.Depend on it

```
$ flutter pub add suggestion_text_editing_controller

```

[//]: # (#### or add to yaml file manually)

[//]: # (```yaml)

[//]: # (  suggestion_text_editing_controller:)

[//]: # (    git:)

[//]: # (      url: https://github.com/monki1/suggestion_text_editing_controller_flutter)

[//]: # (      ref: 71a61c1)

[//]: # (```)
### 2. Install it
```commandline
flutter pub get
```

### 3. Import it

```dart
import'suggestion_text_editing_controller/suggestion_text_editing_controller.dart';
```

[//]: # (## Usage)

[//]: # (```dart)

[//]: # (TextSpan styler&#40;String text, TextStyle? defaultStyle&#41; {)

[//]: # (  List<TextSpan> children = [];)

[//]: # (  for &#40;int i = 0; i < text.length; i++&#41; {)

[//]: # (    i % 2 == 0)

[//]: # (        ? children.add&#40;TextSpan&#40;)

[//]: # (        text: text.substring&#40;i, i + 1&#41;,)

[//]: # (        ///red for even, )

[//]: # (        style: TextStyle&#40;color: Colors.red&#41;&#41;&#41;)

[//]: # (        : children.add&#40;TextSpan&#40;)

[//]: # (        text: text.substring&#40;i, i + 1&#41;,)

[//]: # (        ///blue for odd)

[//]: # (        style: TextStyle&#40;color: Colors.blue&#41;&#41;&#41;;)

[//]: # (  })

[//]: # (  return TextSpan&#40;style: defaultStyle, children: children&#41;;)

[//]: # (})

[//]: # (suggestionTextEditingController controller = suggestionTextEditingController&#40;styler: styler&#41;;)

[//]: # ()
[//]: # (//TextFormField&#40;controller: controller&#41;;)

[//]: # (```)

## Versioning

- **V1.0.0** - First Release.

## Authors

**monki1** - [Github](https://github.com/monki1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
# suggestion_text_editing_controller_flutter
