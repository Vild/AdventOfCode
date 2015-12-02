import std.stdio;

int main(string[] args) {
	if (args.length != 2) {
		writeln("Usage: ", args[0], " <DATA>");
		return -1;
	}
	int level = 0;
	ulong firstEnteredBasement = 0;
	foreach (idx, ch; args[1]) {
		if (ch == '(')
			level++;
		else if (ch == ')')
			level--;
		if (!firstEnteredBasement && level < 0)
			firstEnteredBasement = idx + 1;
	}
	writeln("Result: ", level);
	writeln("First entered basement: ", firstEnteredBasement);
	return 0;
}
