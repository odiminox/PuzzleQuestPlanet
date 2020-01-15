attribute vec3 Position;
attribute vec4 SourceColor;
attribute vec2 TexCoordIn;


varying vec4 DestinationColor;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 MVP;

uniform float red;
uniform float green;
uniform float blue;
uniform float alpha;

varying vec2 TexCoordOut;

void main(void) {
    DestinationColor = SourceColor;
    DestinationColor.x = red;
    DestinationColor.y = green;
    DestinationColor.z = blue;
    DestinationColor.w = alpha;
    gl_Position = MVP * vec4(Position,1.0);
    TexCoordOut = TexCoordIn;
}