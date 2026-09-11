module jacobi;

import std.math : cos;
import ellipticity : Ellipticity;

double cd(ref const Ellipticity ellipticity, double x) @safe @nogc pure nothrow
{
	if (ellipticity.k == 0) {return cos(x);}
	double ϕ0, ϕ1;
	ellipticity.ϕ(x, ϕ0, ϕ1);
	return cos(ϕ1 - ϕ0);
}

void cd(ref const Ellipticity ellipticity, const(double)[] x, double[] codinus) @safe @nogc pure nothrow
in (x.length == codinus.length)
{
	if (ellipticity.k == 0.0)
	{
		foreach (i, X; x)
		{
			codinus[i] = cos(X);
		}
		return;
	}

	foreach (i, X; x)
	{
		double ϕ0, ϕ1;
		ellipticity.ϕ(X, ϕ0, ϕ1);
		codinus[i] = cos(ϕ1 - ϕ0);
	}
}

double[] cd(ref const Ellipticity ellipticity, const(double)[] x) @safe
{
	auto codinus = new double[x.length];
	cd(ellipticity, x, codinus);
	return codinus;
}