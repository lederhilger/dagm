module dagm;

import std.stdio : writef;
import std.math : sqrt;
import agm : AGM;
import ellipticity : Ellipticity;
import jacobi : cd;
import palette : palette;
import vectrix : Vectrix;

double[] linspace(double start, double end, size_t N) @safe pure
{
	auto grid = new double[N];
	if (N == 1)
	{
		grid[0] = start;
		return grid;
	}
	immutable double space = (end - start) / (N - 1);
	foreach (i; 0 .. N)
	{
		grid[i] = start + i * end;
	}
	return grid;
}

void main()
{
	const(double)[64] x = linspace(0, 1, 64);
	auto α = Vectrix(.5, .5, .5);
	auto β = Vectrix(.5, .5, .5);
	auto γ = Vectrix(1, 1, 1);
	auto δ = Vectrix(0, .1, .2);
	auto ellipticity = Ellipticity(sqrt(.5));
	auto colors = palette(x, α, β, γ, δ, ellipticity);
	foreach (color; colors)
	{
		immutable ubyte r = cast(ubyte)(color.r * 255 + .5);
		immutable ubyte g = cast(ubyte)(color.g * 255 + .5);
		immutable ubyte b = cast(ubyte)(color.b * 255 + .5);
		writef(`<span style="color:rgb(%d,%d,%d)">█</span>`, r, g, b);
	}
}