module linspace;

double[] linspace(double start, double end, size_t N) @safe pure
{
	auto grid = new doube[N];
	if (N==1)
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