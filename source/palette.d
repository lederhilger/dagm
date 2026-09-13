module palette;

import ellipticity : Ellipticity;
import jacobi : cd;
import vectrix : Vectrix;

Vectrix palette(double x, Vectrix α, Vectrix β, Vectrix γ, Vectrix δ, ref const Ellipticity ellipticity) @safe @nogc pure nothrow
{
	pragma(inline, true);

	immutable double period = 4.0 * ellipticity.K;
	immutable double ξ = period * (γ.r * x + δ.r);
	immutable double η = period * (γ.g * x + δ.g);
	immutable double ζ = period * (γ.b * x + δ.b);

	return Vectrix(
	       α.r + β.r * cd(ellipticity, ξ),
	       α.g + β.g * cd(ellipticity, η),
	       α.b + β.b * cd(ellipticity, ζ)
	);
}

void palette(const(double)[] x, Vectrix α, Vectrix β, Vectrix γ, Vectrix δ, ref const Ellipticity ellipticity, Vectrix[] spectrum) @safe @nogc pure nothrow
in (x.length == spectrum.length)
{
	immutable double period = 4.0 * ellipticity.K;
	immutable double γR = γ.r * period, γG = γ.g * period, γB = γ.b * period;
	immutable double δR = δ.r * period, δG = δ.g * period, δB = δ.b * period;

	foreach (i, X; x)
	{
		immutable double ξ = γR * X + δR;
		immutable double η = γG * X + δG;
		immutable double ζ = γB * X + δB;

		spectrum[i] = Vectrix(
			    α.r + β.r * cd(ellipticity, ξ),
			    α.g + β.g * cd(ellipticity, η),
			    α.b + β.b * cd(ellipticity, ζ)
		);
	}
}

Vectrix[] palette(const(double)[] x, Vectrix α, Vectrix β, Vectrix γ, Vectrix δ, ref const Ellipticity ellipticity) @safe
{
	auto spectrum = new Vectrix[x.length];
	palette(x, α, β, γ, δ, ellipticity, spectrum);
	return spectrum;
}