import std.stdio;
import std.algorithm;
import std.range;
import std.conv;

alias Sort = sort; // XXX: Fix me

alias pos = int[2];

int main(string[] args) {
	pos p;
	pos process(ubyte[] chunk) {
		foreach(ubyte ch; chunk) {
			switch(ch) {
			case '<':
				p[0]--;
				break;
			case '>':
				p[0]++;
				break;
			case '^':
				p[1]--;
				break;
			case 'v':
				p[1]++;
				break;
			default:
				break;
			}
		}
		return p;
	}

	auto posArray = stdin
		.byChunk(1)
		.map!(process)
		.array~[0, 0];
	posArray.Sort
		.uniq
		.walkLength
		.writeln();

	return 0;
}