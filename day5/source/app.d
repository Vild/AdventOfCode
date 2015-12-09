import std.stdio;
import std.algorithm;

int main(string[] args) {
	int count = 0;
	foreach (x; stdin
		.byLine
		.map!(isNice))
		if (x)
			count++;

	count.writeln(" strings are nice");

	return 0;
}

bool isNice(inout(char[]) line) {
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
	assert(isNice("ugknbfddgicrmopn"));
	assert(isNice("aaa"));
	assert(!isNice("jchzalrnumimnmhp"));
	assert(!isNice("haegwjzuvuyypxyu"));
	assert(!isNice("dvszwmarrgswjxmb"));
}