// Makes the edges of the render distance fade out using dithering to fake transparency
// Especially helps with Ocean chunks on the Render Distance Edge
bool useTransparentRenderDistanceFog = true;


// Makes chunks fade in using dithering when loaded
bool useTransparentFadeIn = false;

// Makes chunks fly in from a specified direction like the Smooth Chunks mod
bool chunksFlyIn = true;
// Here you can define a custom animation function to use for the 
float chunksFlyInFunction(float x) {
    return x * x * x;
}
// The direction and distance chunks fly in from
vec3 chunkFlyInDirection = vec3(0,-1,0);
float chunkFlyInDistane = 128;


// Makes chunks grow in size while fading in
bool useChunkScaleFadeIn = false;
// Same as for the fly in animation but for hte scaling instead
float chunksScaleFunction(float x) {
    return x;
}
// How much each chunk scales. Values higher than 1 can lead to unexpected results.
float chunkScaleAmount = 1;

