# What is this?
This content plugin for Unreal Engine 5.3 adds an infinity mirror-style parallax base material and several example material instances. The base material has two primary features:
## 1) Parallax (fake depth) effect

The camera's position is used to calculate the world-space offset of each parallax layer plane, which is then converted into texture UV coordinates. This gives the illusion of depth, regardless of the angle that the material is viewed from. Associated parameters:
  - `Texture`: Base texture (with alpha) for each parallax step.
  - `Colorize`: Color vector applied to the base texture.
  - `ParallaxStepCount`: Number of parallax layers (counting the base layer). *Note that the number of pixel shader texture samples increases linearly with this value, so use sparingly.*
  - `ParallaxStepDepth`: World space distance between each parallax layer.
  - `ParallaxAlphaExponent`: Exponent used to determine how faded each consecutive parallax layer is. Formula is `1.0 - (layerIndex / layerTotalCount) ^ x` where `x` is this parameter.

## 2) Automatic texture border stretching
The texture for each face is divided into nine sections: corners, edges, and the center. The edges and center are automatically stretched based on the actor scale, which allows the corner pieces to retain their original scale regardless of the size of the applied face.

*For example: in order to create a rectangular face where the corners and edges retain their original scale (and this adaptive feature is utilized), create a square face with a scale that matches the desired corner scale, then apply actor width/height scaling after the face has been created.*

Associated parameter:
- `BorderStretchOffset`: Texture coordinate scalar that specifies how far from the texture borders corners stop and edges/centers begin.

*For example: a value of `0.2` will create the following face arrangement:*
| Corner 0.2x0.2 | *Edge 0.6x0.2 | Corner 0.2x0.2 |
| :--- | :--- | :--- |
| *Edge 0.2x0.6 | *Center 0.6x0.6 | *Edge 0.2x0.6 |
| Corner 0.2x0.2 | *Edge 0.6x0.2 | Corner 0.2x0.2 |

\*Indicates that the section will be stretched (either horizontally or vertically) based on the actor scale.

# Usage
Copy the `Plugins` folder (the entire folder, not just the contents) from this repository into the base directory of your Unreal Engine project. The materials and assets should now be available in the content browser under `Plugins/ParallaxMaterials Content`.

# Examples
<p align="center">
  <img src="https://github.com/osreboot/Parallax-Materials/blob/master/Sample1.jpg" alt="">
</p>
<p align="center">
  <img src="https://github.com/osreboot/Parallax-Materials/blob/master/Sample2.jpg" alt="">
</p>
