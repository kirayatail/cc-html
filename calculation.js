// Build constants
var inductorDrag = 0.3; // Enderium
var coilSize = 36;
var bladeSurfaceArea = 80;
var length = 12

var rotorMass = 10 * (bladeSurfaceArea + length);
var inductionTorque = (coilSize * inductorDrag) / (bladeSurfaceArea * rotorMass);

// inductionTorque = 0;

/* HERE BE UNKNOWNS! */

var rotorSpeed = 1840;

var steamIn = (((rotorSpeed * (bladeSurfaceArea * rotorMass)) * (1 - (1 - inductionTorque - (1/(4000* rotorMass))))) + (rotorMass / 10)) / 10;

console.log("SteamIn: ", steamIn);
