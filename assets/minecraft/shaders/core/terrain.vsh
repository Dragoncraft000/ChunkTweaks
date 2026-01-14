#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:chunksection.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <utils.glsl>
#moj_import <minecraft:chunk_effects.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec3 vertexPosition;
out vec3 worldPosition;

vec4 minecraft_sample_lightmap(sampler2D lightMap, ivec2 uv) {
    return texture(lightMap, clamp((uv / 256.0) + 0.5 / 16.0, vec2(0.5 / 16.0), vec2(15.5 / 16.0)));
}

void main() {

    vec3 flyInOffset = vec3(0);
    if (chunksFlyIn) {
        flyInOffset = normalize(chunkFlyInDirection) * chunksFlyInFunction(1 - ChunkVisibility) * chunkFlyInDistane;
    }

    vec3 pos = Position + (ChunkPosition - CameraBlockPos) + CameraOffset + flyInOffset;

    if (useChunkScaleFadeIn) { 
        vec3 spreadOffset = Position * chunksScaleFunction(1 - ChunkVisibility) * chunkScaleAmount;
        pos -= spreadOffset;
    }

    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);

    sphericalVertexDistance = fog_spherical_distance(pos);
    cylindricalVertexDistance = fog_cylindrical_distance(pos);
    vertexColor = Color * minecraft_sample_lightmap(Sampler2, UV2);
    vertexPosition = pos;
    worldPosition = Position + ChunkPosition;
    texCoord0 = UV0;
}