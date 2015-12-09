import std.stdio;
import std.regex;
import std.array;
import std.algorithm;
import std.conv;

int main(string[] args) {
	assert(args.length == 2, "USAGE: day6 <Part>");
	ulong part = args[1].to!ulong;
	ubyte[1000][1000] lights;
	auto r = ctRegex!(`(?P<type>turn on|toggle|turn off) (?P<d1>\d+,\d+) through (?P<d2>\d+,\d+)`); //`

	if (part == 1)
		foreach (line; stdin.byLine.map!(line => line.matchFirst(r)))
			doItFirst(line, lights);
	else if (part == 2)
		foreach (line; stdin.byLine.map!(line => line.matchFirst(r)))
			doItSecond(line, lights);

	ulong count = 0;
	ulong amount = 0;

	for (ulong x = 0; x < lights.length; x++)
		for (ulong y = 0; y < lights[x].length; y++) {
			if (lights[x][y] == 255)
				count++;
			amount += lights[x][y];
		}

	if (part == 1)
		writeln(count, " Lights are on!");
	else if (part == 2)
		writeln(amount, " Combined!");

	File f = File("lights.pbm", "w");
	f.writeln("P2");
	f.writeln(lights.length, " ", lights[0].length);
	f.writeln("255");
	for (ulong x = 0; x < lights.length; x++) {
		for (ulong y = 0; y < lights[x].length; y++)
			f.write((lights[x][y]), " ");
		f.writeln();
	}
	f.close();

	return 0;
}

void doItFirst(T)(T line, ref ubyte[1000][1000] lights) {
	char[] type = line["type"];
	ulong[] d1 = line["d1"].split(",").map!(to!ulong).array;
	ulong[] d2 = line["d2"].split(",").map!(to!ulong).array;

	if (type == "turn on") {
		for (ulong x = d1[0]; x <= d2[0]; x++)
			for (ulong y = d1[1]; y <= d2[1]; y++)
				lights[x][y] = 255;
	} else if (type == "toggle") {
		for (ulong x = d1[0]; x <= d2[0]; x++)
			for (ulong y = d1[1]; y <= d2[1]; y++)
				lights[x][y] = (lights[x][y] == 255) ? 0 : 255;
	} else if (type == "turn off") {
		for (ulong x = d1[0]; x <= d2[0]; x++)
			for (ulong y = d1[1]; y <= d2[1]; y++)
				lights[x][y] = 0;
	} else
		assert(0, type);
}

void doItSecond(T)(T line, ref ubyte[1000][1000] lights) {
	char[] type = line["type"];
	ulong[] d1 = line["d1"].split(",").map!(to!ulong).array;
	ulong[] d2 = line["d2"].split(",").map!(to!ulong).array;

	if (type == "turn on") {
		for (ulong x = d1[0]; x <= d2[0]; x++)
			for (ulong y = d1[1]; y <= d2[1]; y++)
				lights[x][y]++;
	} else if (type == "toggle") {
		for (ulong x = d1[0]; x <= d2[0]; x++)
			for (ulong y = d1[1]; y <= d2[1]; y++)
				lights[x][y] += 2;
	} else if (type == "turn off") {
		for (ulong x = d1[0]; x <= d2[0]; x++)
			for (ulong y = d1[1]; y <= d2[1]; y++)
				lights[x][y] = cast(ubyte)max(0, lights[x][y] - 1);
	} else
		assert(0, type);
}
