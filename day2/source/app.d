import std.stdio;
import std.algorithm;
import std.range;
import std.algorithm.iteration;
import std.conv;
int main(string[] args) {
	 stdin
	 	.byLine
		.map!(line => line.split("x"))
		.filter!(arr => arr.length > 1)
		.map!(to!(int[]))
		.map!(sort)
		.map!(v =>
			2*v[0]*v[1] + 2*v[1]*v[2] + 2*v[2]*v[0] + v[0] * v[1]
		)
		.sum
		.writeln;
	return 0;
}
