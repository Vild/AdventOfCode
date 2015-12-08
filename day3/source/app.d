import std.stdio;
import std.algorithm;
import std.range;
import std.conv;

alias Sort = sort; // XXX: Fix me

alias pos = int[2];

int main(string[] args) {
	assert(args.length == 2, "USAGE: day3 <NumberOfSantas>");
	ulong numberOfSantas = to!ulong(args[1]);
	run(numberOfSantas, stdin.byChunk(numberOfSantas)).writeln();
	return 0;
}

ulong run(T)(ulong numberOfSantas, T input) {
	pos[] santas = new pos[numberOfSantas];
	pos[] process(ubyte[] str) {
		assert(str.length == numberOfSantas);
		for (ulong i = 0; i < numberOfSantas; i++) {
			     if (str[i] == '<') santas[i][0]--;
			else if (str[i] == '>') santas[i][0]++;
			else if (str[i] == '^') santas[i][1]--;
			else if (str[i] == 'v') santas[i][1]++;
		}
		return santas;
	}
	auto posArrayArray = input.map!(process);
	// Flatten Array & Append [0, 0]
	pos[] posArray = [[0, 0]];

	posArrayArray.each!((lst) =>
		lst.each!((pos) => posArray ~= pos)
	);

	return posArray.Sort
		.uniq
		.walkLength;
}

unittest {
	assert(run(1, cast(ubyte[][])[['>']]) == 2);
	assert(run(1, cast(ubyte[][])[['^'], ['>'], ['v'], ['<']]) == 4);
	assert(run(1, cast(ubyte[][])[['^'], ['v'], ['^'], ['v'], ['^'], ['v'], ['^'], ['v'], ['^'], ['v']]) == 2);
}

unittest {
	assert(run(2, cast(ubyte[][])[['^', 'v']]) == 3);
	assert(run(2, cast(ubyte[][])[['^', '>'], ['v', '<']]) == 3);
	assert(run(2, cast(ubyte[][])[['^', 'v'], ['^', 'v'], ['^', 'v'], ['^', 'v'], ['^', 'v']]) == 11);
}