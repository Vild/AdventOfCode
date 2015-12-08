import std.stdio;
import std.digest.md;
import std.parallelism;
import std.algorithm.searching;
import std.conv;
import std.range;
import std.algorithm : equal;

__gshared bool done = false;

struct HashGen {
	string key;
	ulong count;

	this(string key) {
		this.key = key;
		this.count = 0;
	}

	@property bool empty() const {
		return done;
	}

	@property string front() {
		import std.format;
		return format("%s%s", key, count);
	}

	void popFront() {
		count++;
	}
}

int main(string[] args) {
	assert(args.length == 3, "USAGE: day5 <KEY> <Number Of Zeros>");
	HashGen hashGen = HashGen(args[1]);
	ulong numberOfZeros = to!ulong(args[2]);
	string zeros = '0'.repeat(numberOfZeros).array;
	foreach(i, val; parallel(hashGen)) {
		char[32] hex = md5Of(val).toHexString();
		if (hex[0..numberOfZeros] == zeros) {
			done = true;
			writeln(i, " is the lowest one with: ", md5Of(val).toHexString());
		}
	}
	return 0;
}