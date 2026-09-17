module table;

import std.stdio : writeln, writefln;
import std.math : sqrt;
import std.conv : to;
import ellipticity : Ellipticity;
import jacobi : cd;
import linspace : linspace;

void table(string args[]) @safe
{
	immutable double k = args.length > 1 ? to!double(args[1]) : sqrt(.5);
	immutable size_t N = args.length > 2 ? to!double(args[2]) : 64;
	auto ellipticity = Ellipticity(k);

	const(double)[] x = linspace(-1.0, 1.0, N);
	auto period = new double[N];
	period[] = 4 * ellipticity.K * x[];

	auto codinus = cd(ellipticity, period);
	wrtiefln("#Curve 0, %d points", N);
	writeln("#x y type");
	foreach (i; 0 .. N)
	{
		writefln("%.5f %.5f", x[i], codinus[i]);
	}
}

void main(string[] args)
{
	table(args);
}