import net

$if windows {
	#include <afunix.h>
}

struct C.sockaddr_in6 {
	sin6_addr [16]byte
}

struct C.sockaddr_in {
	sin_addr [4]byte
}

struct C.sockaddr_un {
	sun_path [104]byte
}

const aoffset = __offsetof(net.Addr, addr)

fn test_offsets() {
	assert __offsetof(C.sockaddr_in6, sin6_addr) == __offsetof(net.Ip6, addr) + aoffset
	assert __offsetof(C.sockaddr_in, sin_addr) == __offsetof(net.Ip, addr) + aoffset
	assert __offsetof(C.sockaddr_un, sun_path) == __offsetof(net.Unix, path) + aoffset
}

fn test_size() {
	assert sizeof(C.sockaddr_in) == sizeof(net.Ip)
	assert sizeof(C.sockaddr_in6) == sizeof(net.Ip6)
	assert sizeof(C.sockaddr_un) >= sizeof(net.Unix)
	// ^ the above fails for strict == on linux with:
	// > assert sizeof(Type(80)) == sizeof(Type(84))
	//       Left value: 110
	//      Right value: 104
}
