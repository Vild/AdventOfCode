import std.stdio;

int main(string[] args) {
	int level = 0;
	foreach (arg; args)
		foreach (ch; arg)
			if (ch == '(')
				level++;
			else if (ch == ')')
				level--;
	writeln("Result: ", level);
	return 0;
}