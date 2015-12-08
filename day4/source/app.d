import std.stdio;
import std.digest.md;
import std.parallelism;
import std.algorithm.searching;

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
	assert(args.length == 2, "USAGE: day5 <KEY>");
	HashGen hashGen = HashGen(args[1]);
	foreach(i, val; parallel(hashGen)) {
		if (md5Of(val).toHexString()[0..5] == "00000") {
			done = true;
			writeln(i, " is the lowest one with: ", md5Of(val).toHexString());
		}
	}
	return 0;
}