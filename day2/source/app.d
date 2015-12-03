import std.stdio;
import std.algorithm;
import std.range;
import std.conv;

int main(string[] args) {
	//dfmt off
	auto data = stdin
		.byLine
		.map!(line => line.split("x"))
		.filter!(arr => arr.length > 1)
		.map!(to!(int[]))
		.map!(sort).array;

	data
		.map!(v =>
			2*v[0]*v[1] + 2*v[1]*v[2] + 2*v[2]*v[0] + v[0] * v[1]
		)
		.sum
		.writeln("ft² of papper is needed!");
	data
		.map!(v =>
			2*v[0] + 2*v[1] +
			v[0]*v[1]*v[2]
		)
		.sum
		.writeln("ft of ribbon is needed!");
	//dfmt on
	return 0;
}
