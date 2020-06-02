# dotted_decoration

Dotted line decoration is handly package to draw dotted divider, dotted border for rectangle, oval or circle.


### Installing

To use this package, add `dotted_decoration` as a dependency in your `pubspec.yaml` file.

### Usage

Create a `container` widget and assign  `DottedDecoration` as decoration

```dart
Container(
    decoration: DottedDecoration()
    child: Text('Dotted Decoration')
)
```


### Parameters

#### Shape
Kind of outline shape, default shape is `Shape.line`.

```shape: Shape.line```
```shape: Shape.box```
```shape: Shape.oval```


#### linePosition
Where line is located, default shape is `LinePosition.bottom`.

```linePosition: LinePosition.bottom```
```linePosition: LinePosition.left```
```linePosition: LinePosition.right```
```linePosition: LinePosition.top```

#### dash
Border line order, first in dash and second is space.

```dash: <int>[2, 5]```

#### strokeWidth
Line width.

```strokeWidth: 2```

#### color
Color of line, default shape is `Colors.grey`.

```color: Colors.red```

#### example image
![dotted_decoration image](assets/screen-shot.png?raw=true "Flutter Dotted Decoration screenshot" )