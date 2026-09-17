module dagm;

import std.stdio : writef, writeln;
import std.math : sqrt, PI;
import std.conv : to;
import agm : AGM;
import ellipticity : Ellipticity;
import jacobi : cd;
import palette : palette;
import vectrix : Vectrix, add;
import std.algorithm.comparison : clamp;
import linspace : linspace;

void main(string[] args)
{
	immutable double k = args.length > 1 ? to!double(args[1]) : sqrt(.5);
	const(double)[] x = linspace(0, 1, 64);

	auto α = Vectrix(
	     0.0,
	     0.179,
	     1.0
	);

	auto β = Vectrix(
	     0.703,
	     1.0,
	     0.963
	);

	auto γ = Vectrix(
	     0.098,
	     0.092,
	     0.167
	);

	auto δ = Vectrix(
	     0.768,
	     0.734,
	     0.478
	);

	Vectrix[] colors;

	if (k == 1.0)
	{
		colors = new Vectrix[x.length];
		colors[] = add(α, β);
	}
	else
	{
		auto ellipticity = Ellipticity(k);
		colors = palette(x, α, β, γ, δ, ellipticity);
	}
	foreach (color; colors)
	{
		immutable ubyte r = cast(ubyte)(clamp(color.r, 0.0, 1.0) * 255 + .5);
		immutable ubyte g = cast(ubyte)(clamp(color.g, 0.0, 1.0) * 255 + .5);
		immutable ubyte b = cast(ubyte)(clamp(color.b, 0.0, 1.0) * 255 + .5);
		writef(`<span style="color:rgb(%d,%d,%d)">█</span>`, r, g, b);
	}
	writeln();
}