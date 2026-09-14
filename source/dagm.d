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
		grid[i] = start + i * space;
	}
	return grid;
}

void main(string[] args)
{
	immutable double k = args.length > 1 ? to!double(args[1]) : sqrt(.5);
	const(double)[] x = linspace(0, 1, 64);
	auto α = Vectrix(1.0, 0.213, 0.325);
	auto β = Vectrix(1.0, 0.379, 0.31);
	auto γ = Vectrix(0.09, 0.305, 0.574);
	auto δ = Vectrix(0.618, 0.67, 0.516);
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