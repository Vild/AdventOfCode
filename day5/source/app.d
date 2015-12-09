import std.stdio;
import std.algorithm;
import std.regex;
import std.conv;

int main(string[] args) {
	assert(args.length == 2, "USAGE: day5 <Part>");
	ulong count = 0;
	ulong part = args[1].to!ulong;

	if (part == 1) {
		foreach (x; stdin
			.byLine
			.map!(isNiceFirst))
			if (x)
				count++;
	} else if (part == 2) {
		foreach (x; stdin
			.byLine
			.map!(isNiceSecond))
			if (x)
				count++;
	}
	count.writeln(" strings are nice");

	return 0;
}

bool isNiceFirst(inout(char[]) line) {
	immutable VOWELS = "aeiou";

	int vowels = 0;
	int doubleLetter = 0;
	char old = '\0';
	foreach (ch; line) {
		if (VOWELS.canFind(ch))
			vowels++;

		if (old == ch)
			doubleLetter++;

		if ((old == 'a' && ch == 'b') ||
			(old == 'c' && ch == 'd') ||
			(old == 'p' && ch == 'q') ||
			(old == 'x' && ch == 'y'))
			return false;

		old = ch;
	}
	return vowels >= 3 && doubleLetter > 0;
}

unittest {
	assert(isNiceFirst("ugknbfddgicrmopn"));
	assert(isNiceFirst("aaa"));
	assert(!isNiceFirst("jchzalrnumimnmhp"));
	assert(!isNiceFirst("haegwjzuvuyypxyu"));
	assert(!isNiceFirst("dvszwmarrgswjxmb"));
}

bool isNiceSecond(inout(char[]) lines) {
	char[] line = lines.dup;
	auto pair = ctRegex!(`(..).*?\1`); //`
	auto repeat = ctRegex!(`(.).\1`); //`

	auto a = line.matchFirst(pair);
	auto b = line.matchFirst(repeat);

	return !a.empty && !b.empty;
}

unittest {
	assert(isNiceSecond("qjhvhtzxzqqjkmpb"));
	assert(isNiceSecond("xxyxx"));
	assert(!isNiceSecond("uurcxstgmygtbstg"));
	assert(!isNiceSecond("ieodomkazucvgmuy"));
}