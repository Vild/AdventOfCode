import std.stdio;
import std.regex;
import std.array;
import std.algorithm;
import std.conv;

int main(string[] args) {
	bool[1000][1000] lights;
	auto r = ctRegex!(`(?P<type>turn on|toggle|turn off) (?P<d1>\d+,\d+) through (?P<d2>\d+,\d+)`); //`

	void doIt(T)(T line) {
		char[] type = line["type"];
		ulong[] d1 = line["d1"].split(",").map!(to!ulong).array;
		ulong[] d2 = line["d2"].split(",").map!(to!ulong).array;

		if (type == "turn on") {
			for (ulong x = d1[0]; x <= d2[0]; x++)
				for (ulong y = d1[1]; y <= d2[1]; y++)
					lights[x][y] = true;
		} else if (type == "toggle") {
			for (ulong x = d1[0]; x <= d2[0]; x++)
				for (ulong y = d1[1]; y <= d2[1]; y++)
					lights[x][y] = !lights[x][y];
		} else if (type == "turn off") {
			for (ulong x = d1[0]; x <= d2[0]; x++)
				for (ulong y = d1[1]; y <= d2[1]; y++)
					lights[x][y] = false;
		} else
			assert(0, type);
	}

	foreach (line; stdin
		.byLine
		.map!(line => line.matchFirst(r)))
		doIt(line);

	ulong count = 0;

	for (ulong x = 0; x < lights.length; x++)
		for (ulong y = 0; y < lights[x].length; y++)
			if (lights[x][y])
				count++;

	count.writeln(" Lights are on!");

	return 0;
}