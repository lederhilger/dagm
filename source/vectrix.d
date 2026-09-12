module vectrix;

struct Vectrix
{
	double r = 0.0;
	double g = 0.0;
	double b = 0.0;

	this(double red, double green, double blue) pure nothrow @nogc
	{
		r = red;
		g = green;
		b = blue;
	}
}

Vectrix add(Vectrix a, Vectrix b) pure nothrow @nogc
{
	return Vectrix(a.r + b.r, a.g + b.g, a.b + b.b);
}

Vectrix sub(Vectrix a, Vectrix b) pure nothrow @nogc
{
	return Vectrix(a.r - b.r, a.g - b.g, a.b - b.b);
}

Vectrix scale(Vectrix a, double value) pure nothrow @nogc
{
	return Vectrix(a.r * value, a.g * value, a.b * value);
}

Vectrix wedge(Vectrix a, Vectrix b) pure nothrow @nogc
{
	return Vectrix(
	       a.g * b.b - a.b * b.g,
	       a.b * b.r - a.r * b.b,
	       a.r * b.g - a.g * b.r
	);
}

double dot(Vectrix a, Vectrix b) pure nothrow @nogc
{
	return a.r * b.r + a.g * b.g + a.b * b.b;
}

double normSquared(Vectrix value) pure nothrow @nogc
{
	return dot(value, value);
}

double norm(Vectrix value) pure nothrow @nogc
{
	return sqrt(normSquared(value));
}

bool finite(Vectrix value) pure nothrow @nogc
{
	return isFinite(value.r) && isFinite(value.g) && isFinite(value.b);
}