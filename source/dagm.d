module dagm;

import std.stdio : writefln;
import std.math : sqrt;
import agm : AGM;
import ellipticity : Ellipticity;
import jacobi : cd;

void main()
{
	auto ellipticity = Ellipticity(sqrt(.5));
	writefln("K = %.15f", ellipticity.K);
	writefln("cd(2K) = %.15f", cd(ellipticity, 2 * ellipticity.K));

	auto agm = AGM(1.0, sqrt(.5), sqrt(.5), 1e-16);
	foreach (i; 0 .. agm.length)
	{
		writefln("i=%d  A=%.15f  C=%.15f", i, agm.A[i], agm.C[i]);
	}
	writefln("length = %d", agm.length);
}