const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;

comptime {
    std.debug.assert(builtin.target.os.tag == .freebsd);
    std.debug.assert(@bitSizeOf(usize) == 64);
}

pub const errno = struct {
    pub const Error = error{
        Unexpected,
        EPERM,
        ENOENT,
        ESRCH,
        EINTR,
        EIO,
        ENXIO,
        E2BIG,
        ENOEXEC,
        EBADF,
        ECHILD,
        EDEADLK,
        ENOMEM,
        EACCES,
        EFAULT,
        ENOTBLK,
        EBUSY,
        EEXIST,
        EXDEV,
        ENODEV,
        ENOTDIR,
        EISDIR,
        EINVAL,
        ENFILE,
        EMFILE,
        ENOTTY,
        ETXTBSY,
        EFBIG,
        ENOSPC,
        ESPIPE,
        EROFS,
        EMLINK,
        EPIPE,
        EDOM,
        ERANGE,
        EAGAIN,
        EINPROGRESS,
        EALREADY,
        ENOTSOCK,
        EDESTADDRREQ,
        EMSGSIZE,
        EPROTOTYPE,
        ENOPROTOOPT,
        EPROTONOSUPPORT,
        ESOCKTNOSUPPORT,
        EOPNOTSUPP,
        EPFNOSUPPORT,
        EAFNOSUPPORT,
        EADDRINUSE,
        EADDRNOTAVAIL,
        ENETDOWN,
        ENETUNREACH,
        ENETRESET,
        ECONNABORTED,
        ECONNRESET,
        ENOBUFS,
        EISCONN,
        ENOTCONN,
        ESHUTDOWN,
        ETOOMANYREFS,
        ETIMEDOUT,
        ECONNREFUSED,
        ELOOP,
        ENAMETOOLONG,
        EHOSTDOWN,
        EHOSTUNREACH,
        ENOTEMPTY,
        EPROCLIM,
        EUSERS,
        EDQUOT,
        ESTALE,
        EREMOTE,
        EBADRPC,
        ERPCMISMATCH,
        EPROGUNAVAIL,
        EPROGMISMATCH,
        EPROCUNAVAIL,
        ENOLCK,
        ENOSYS,
        EFTYPE,
        EAUTH,
        ENEEDAUTH,
        EIDRM,
        ENOMSG,
        EOVERFLOW,
        ECANCELED,
        EILSEQ,
        ENOATTR,
        EDOOFUS,
        EBADMSG,
        EMULTIHOP,
        ENOLINK,
        EPROTO,
        ENOTCAPABLE,
        ECAPMODE,
        ENOTRECOVERABLE,
        EOWNERDEAD,
        EINTEGRITY,
    };

    pub const Enum = enum(c_ushort) {
        EPERM = 1,
        ENOENT = 2,
        ESRCH = 3,
        EINTR = 4,
        EIO = 5,
        ENXIO = 6,
        E2BIG = 7,
        ENOEXEC = 8,
        EBADF = 9,
        ECHILD = 10,
        EDEADLK = 11,
        ENOMEM = 12,
        EACCES = 13,
        EFAULT = 14,
        ENOTBLK = 15,
        EBUSY = 16,
        EEXIST = 17,
        EXDEV = 18,
        ENODEV = 19,
        ENOTDIR = 20,
        EISDIR = 21,
        EINVAL = 22,
        ENFILE = 23,
        EMFILE = 24,
        ENOTTY = 25,
        ETXTBSY = 26,
        EFBIG = 27,
        ENOSPC = 28,
        ESPIPE = 29,
        EROFS = 30,
        EMLINK = 31,
        EPIPE = 32,
        EDOM = 33,
        ERANGE = 34,
        EAGAIN = 35,
        EINPROGRESS = 36,
        EALREADY = 37,
        ENOTSOCK = 38,
        EDESTADDRREQ = 39,
        EMSGSIZE = 40,
        EPROTOTYPE = 41,
        ENOPROTOOPT = 42,
        EPROTONOSUPPORT = 43,
        ESOCKTNOSUPPORT = 44,
        EOPNOTSUPP = 45,
        EPFNOSUPPORT = 46,
        EAFNOSUPPORT = 47,
        EADDRINUSE = 48,
        EADDRNOTAVAIL = 49,
        ENETDOWN = 50,
        ENETUNREACH = 51,
        ENETRESET = 52,
        ECONNABORTED = 53,
        ECONNRESET = 54,
        ENOBUFS = 55,
        EISCONN = 56,
        ENOTCONN = 57,
        ESHUTDOWN = 58,
        ETOOMANYREFS = 59,
        ETIMEDOUT = 60,
        ECONNREFUSED = 61,
        ELOOP = 62,
        ENAMETOOLONG = 63,
        EHOSTDOWN = 64,
        EHOSTUNREACH = 65,
        ENOTEMPTY = 66,
        EPROCLIM = 67,
        EUSERS = 68,
        EDQUOT = 69,
        ESTALE = 70,
        EREMOTE = 71,
        EBADRPC = 72,
        ERPCMISMATCH = 73,
        EPROGUNAVAIL = 74,
        EPROGMISMATCH = 75,
        EPROCUNAVAIL = 76,
        ENOLCK = 77,
        ENOSYS = 78,
        EFTYPE = 79,
        EAUTH = 80,
        ENEEDAUTH = 81,
        EIDRM = 82,
        ENOMSG = 83,
        EOVERFLOW = 84,
        ECANCELED = 85,
        EILSEQ = 86,
        ENOATTR = 87,
        EDOOFUS = 88,
        EBADMSG = 89,
        EMULTIHOP = 90,
        ENOLINK = 91,
        EPROTO = 92,
        ENOTCAPABLE = 93,
        ECAPMODE = 94,
        ENOTRECOVERABLE = 95,
        EOWNERDEAD = 96,
        EINTEGRITY = 97,

        pub const EWOULDBLOCK: Enum = .EAGAIN;
        pub const ENOTSUP: Enum = .EOPNOTSUPP;
    };

    comptime {
        // assert Enum is sequential
        var value: c_ushort = 0; // SUCCESS
        for (std.enums.values(Enum)) |val| {
            std.debug.assert(@intFromEnum(val) > value);
            value = @intFromEnum(val);
        }
    }
    comptime {
        // sanity test
        std.debug.assert(@intFromEnum(Enum.EPERM) == 1);
    }
    const list = blk: {
        const values = std.enums.values(Enum);
        const len = @intFromEnum(values[values.len - 1]) + 1;
        var errors: [len]Error = @splat(error.Unexpected);
        for (values) |f| errors[@intFromEnum(f)] = @field(Error, @tagName(f));
        const final = errors;
        break :blk final;
    };
    pub fn fromInt(code: c_int) Error {
        @setRuntimeSafety(false);
        if (code >= list.len) return error.Unexpected;
        if (code <= 0) return error.Unexpected;
        return list[@intCast(code)];
    }
    pub fn fromLibC() c_int {
        return libc.__error().*;
    }
};

pub const eai = struct {
    pub const Error = error{
        EAI_ADDRFAMILY,
        EAI_AGAIN,
        EAI_BADFLAGS,
        EAI_FAIL,
        EAI_FAMILY,
        EAI_MEMORY,
        EAI_NODATA,
        EAI_NONAME,
        EAI_SERVICE,
        EAI_SOCKTYPE,
        EAI_SYSTEM,
        EAI_BADHINTS,
        EAI_PROTOCOL,
        EAI_OVERFLOW,
    };

    pub const Enum = enum(c_int) {
        EAI_ADDRFAMILY = 1,
        EAI_AGAIN = 2,
        EAI_BADFLAGS = 3,
        EAI_FAIL = 4,
        EAI_FAMILY = 5,
        EAI_MEMORY = 6,
        EAI_NODATA = 7,
        EAI_NONAME = 8,
        EAI_SERVICE = 9,
        EAI_SOCKTYPE = 10,
        EAI_SYSTEM = 11,
        EAI_BADHINTS = 12,
        EAI_PROTOCOL = 13,
        EAI_OVERFLOW = 14,
    };

    pub fn fromInt(code: c_int) Error {
        return switch (@as(Enum, @enumFromInt(code))) {
            .EAI_ADDRFAMILY => error.EAI_ADDRFAMILY,
            .EAI_AGAIN => error.EAI_AGAIN,
            .EAI_BADFLAGS => error.EAI_BADFLAGS,
            .EAI_FAIL => error.EAI_FAIL,
            .EAI_FAMILY => error.EAI_FAMILY,
            .EAI_MEMORY => error.EAI_MEMORY,
            .EAI_NODATA => error.EAI_NODATA,
            .EAI_NONAME => error.EAI_NONAME,
            .EAI_SERVICE => error.EAI_SERVICE,
            .EAI_SOCKTYPE => error.EAI_SOCKTYPE,
            .EAI_SYSTEM => error.EAI_SYSTEM,
            .EAI_BADHINTS => error.EAI_BADHINTS,
            .EAI_PROTOCOL => error.EAI_PROTOCOL,
            .EAI_OVERFLOW => error.EAI_OVERFLOW,
        };
    }
};

pub const libc = struct {
    pub extern fn __error() *c_int;
    pub extern fn pipe2(pipefd: *[2]c_int, flag: c_int) c_int;
    pub extern fn openat(fd: c_int, file: [*:0]const u8, oflag: c_int, ...) c_int;
    pub extern fn close(fildes: c_int) c_int;
    pub extern fn fork() pid_t;
    pub extern fn dup2(fildes: c_int, fildes2: c_int) c_int;
    pub extern fn _exit(status: c_int) noreturn;
    pub extern fn fchdir(fildes: c_int) c_int;
    pub extern fn execvp(file: [*:0]const u8, argv: [*:null]const ?[*:0]const u8) c_int;
    pub extern fn kill(pid: pid_t, sig: c_int) c_int;
    pub extern fn poll(fds: [*]struct_pollfd, nfds: nfds_t, timeout: c_int) c_int;
    pub extern fn read(fd: c_int, buf: [*]u8, count: usize) isize;
    pub extern fn write(fd: c_int, buf: *const anyopaque, n: usize) isize;
    pub extern fn waitpid(pid: pid_t, stat_loc: ?*c_int, options: c_int) pid_t;
    pub extern fn getenv(name: [*:0]const u8) ?[*:0]u8;
    pub extern fn exit(status: c_int) noreturn;
    pub extern fn mkdirat(fd: c_int, path: [*:0]const u8, mode: mode_t) c_int;
    pub extern fn fstatat(fd: c_int, noalias path: [*:0]const u8, noalias buf: *struct_stat, flag: c_int) c_int;
    pub extern fn getaddrinfo(noalias nodename: ?[*:0]const u8, noalias servname: ?[*:0]const u8, noalias hints: ?*const struct_addrinfo, noalias res: **const struct_addrinfo) c_int;
    pub extern fn freeaddrinfo(ai: *const struct_addrinfo) void;
    pub extern fn socket(domain: c_int, type: c_int, protocol: c_int) c_int;
    pub extern fn connect(socket: c_int, address: *const struct_sockaddr, address_len: socklen_t) c_int;
    pub extern fn getrandom(buf: [*]u8, size: usize, flags: c_uint) isize;
    pub extern fn arc4random_buf(buf: [*]u8, n: usize) void;
    pub extern fn pthread_mutex_init(mutex: *pthread_mutex_t, attr: ?*const pthread_mutexattr_t) c_int;
    pub extern fn pthread_mutex_destroy(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_mutex_lock(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_mutex_trylock(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_mutex_unlock(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_cond_init(noalias cond: *pthread_cond_t, noalias attr: ?*const pthread_condattr_t) c_int;
    pub extern fn pthread_cond_destroy(cond: *pthread_cond_t) c_int;
    pub extern fn pthread_cond_wait(noalias cond: *pthread_cond_t, noalias mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_cond_timedwait(noalias cond: *pthread_cond_t, noalias mutex: *pthread_mutex_t, noalias abstime: *const struct_timespec) c_int;
    pub extern fn pthread_cond_signal(cond: *pthread_cond_t) c_int;
    pub extern fn pthread_cond_broadcast(cond: *pthread_cond_t) c_int;
    pub extern fn pthread_rwlock_init(noalias rwlock: *pthread_rwlock_t, noalias attr: ?*const pthread_rwlockattr_t) c_int;
    pub extern fn pthread_rwlock_destroy(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_rdlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_tryrdlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_wrlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_trywrlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_unlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn clock_gettime(clock_id: clockid_t, tp: *struct_timespec) c_int;
    pub extern fn renameat(oldfd: c_int, old: [*:0]const u8, newfd: c_int, new: [*:0]const u8) c_int;
    pub extern fn send(fd: c_int, buffer: [*]const u8, length: usize, flags: c_int) isize;
    pub extern fn recv(fd: c_int, buffer: [*]u8, length: usize, flags: c_int) isize;
    pub extern fn fstat(fd: c_int, buf: *struct_stat) c_int;
    pub extern fn mmap(addr: ?*anyopaque, len: usize, prot: c_int, flags: c_int, fd: c_int, offset: off_t) *allowzero anyopaque;
    pub extern fn writev(fd: c_int, iovec: [*]const struct_iovec, count: c_int) isize;
    pub extern fn faccessat(fd: c_int, path: [*:0]const u8, amode: c_int, flag: c_int) c_int;
    pub extern fn readlinkat(fd: c_int, noalias path: [*:0]const u8, noalias buf: [*]u8, len: usize) isize;
    pub extern fn futimens(fd: c_int, times: *const [2]struct_timespec) c_int;
    pub extern fn setsockopt(fd: c_int, level: c_int, optname: c_int, optval: *const anyopaque, optlen: socklen_t) c_int;
    pub extern fn bind(socket: c_int, address: *const struct_sockaddr, address_len: socklen_t) c_int;
    pub extern fn listen(socket: c_int, backlog: c_int) c_int;
    pub extern fn getsockname(fd: c_int, noalias addr: *struct_sockaddr, noalias len: *socklen_t) c_int;
    pub extern fn pthread_attr_init(attr: *pthread_attr_t) c_int;
    pub extern fn pthread_attr_destroy(attr: *pthread_attr_t) c_int;
    pub extern fn pthread_attr_setguardsize(attr: *pthread_attr_t, guardsize: usize) c_int;
    pub extern fn pthread_attr_setstacksize(attr: *pthread_attr_t, stacksize: usize) c_int;
    pub extern fn pthread_create(noalias newthread: *pthread_t, noalias attr: *const pthread_attr_t, start_routine: *const fn (*anyopaque) callconv(.c) ?*anyopaque, noalias arg: *anyopaque) c_int;
    pub extern fn pthread_detach(thread: pthread_t) c_int;
    pub extern fn pthread_join(thread: pthread_t, retval: ?*?*anyopaque) c_int;
    pub extern fn munmap(addr: *const anyopaque, len: usize) c_int;
    pub extern fn getdents(dirfd: c_int, buf: [*]u8, nbytes: usize) isize;
    pub extern fn accept4(socket: c_int, noalias address: ?*struct_sockaddr, noalias address_len: *socklen_t, flags: c_int) c_int;
    pub extern fn shutdown(socket: c_int, how: c_int) c_int;
    pub extern fn unlinkat(fd: c_int, name: [*:0]const u8, flag: c_int) c_int;
};

pub const blksize_t = i32;
pub const blkcnt_t = i64;
pub const clockid_t = i32;
pub const fflags_t = u32;
pub const fsblkcnt_t = u64;
pub const fsfilcnt_t = u64;
pub const gid_t = u32;
pub const id_t = i64;
pub const ino_t = u64;
pub const key_t = c_long;
pub const lwpid_t = i32;
pub const mode_t = u16;
pub const accmode_t = c_int;
pub const nl_item = c_int;
pub const nlink_t = u64;
pub const off_t = i64;
pub const off64_t = i64;
pub const pid_t = i32;
pub const sbintime_t = i64;
pub const rlim_t = i64;
pub const sa_family_t = u8;
pub const socklen_t = u32;
pub const suseconds_t = c_long;
pub const uid_t = u32;
pub const useconds_t = c_uint;
pub const cpuwhich_t = c_int;
pub const cpulevel_t = c_int;
pub const cpusetid_t = c_int;
pub const daddr_t = i64;
pub const struct_pollfd = extern struct { fd: c_int, events: c_short, revents: c_short };
pub const nfds_t = c_uint;
pub const struct_stat = extern struct { dev: dev_t, ino: ino_t, nlink: nlink_t, mode: mode_t, bsdflags: i16, uid: uid_t, gid: gid_t, padding1: i32, rdev: dev_t, atim: struct_timespec, mtim: struct_timespec, ctim: struct_timespec, birthtim: struct_timespec, size: off_t, blocks: blkcnt_t, blksize: blksize_t, flags: fflags_t, gen: u64, filerev: u64, spare: [9]u64 };
pub const dev_t = u64;
pub const struct_timespec = extern struct { sec: time_t, nsec: c_long };
pub const time_t = i64;
pub const struct_iovec = extern struct { base: [*]u8, len: usize };
pub const in_addr_t = u32;
pub const in_port_t = u16;
pub const struct_in_addr = extern struct { addr: in_addr_t };
pub const struct_in6_addr = extern struct { addr: extern union { a8: [16]u8, a16: [8]u16, a32: [4]u32 } };
pub const struct_sockaddr = extern struct { len: u8 = 6, family: AF, data: [14]u8 };
pub const struct_sockaddr_in = extern struct { len: u8 = 16, family: AF = .INET, port: in_port_t, addr: struct_in_addr, zero: [8]u8 = @splat(0) };
pub const struct_sockaddr_in6 = extern struct { len: u8 = 28, family: AF = .INET6, port: in_port_t, flowinfo: u32, addr: struct_in6_addr, scope_id: u32 };
pub const struct_sockaddr_un = extern struct { len: u8 = 106, family: AF = .UNIX, path: [104]u8 };
comptime {
    std.debug.assert(@sizeOf(struct_sockaddr_in) == 16);
    std.debug.assert(@sizeOf(struct_sockaddr_in6) == 28);
    std.debug.assert(@sizeOf(struct_sockaddr_un) == 106);
}
pub const struct_addrinfo = extern struct { flags: c_int, family: c_int, socktype: c_int, protocol: c_int, addrlen: socklen_t, canonname: ?[*:0]u8, addr: ?*struct_sockaddr, next: ?*struct_addrinfo };
pub const struct_dirent = extern struct { fileno: ino_t, off: off_t, reclen: u16, type: DT, pad0: u8, namlen: u16, pad1: u16, name: [NAME_MAX + 1]u8 };
pub const struct_timeval = extern struct { sec: time_t, usec: suseconds_t };

const impdef = @cImport({
    @cInclude("pthread.h");
});
pub const pthread_t = impdef.pthread_t;
pub const pthread_attr_t = impdef.pthread_attr_t;
pub const pthread_mutexattr_t = impdef.pthread_mutexattr_t;
pub const pthread_mutex_t = impdef.pthread_mutex_t;
pub const pthread_condattr_t = impdef.pthread_condattr_t;
pub const pthread_cond_t = impdef.pthread_cond_t;
pub const pthread_rwlockattr_t = impdef.pthread_rwlockattr_t;
pub const pthread_rwlock_t = impdef.pthread_rwlock_t;

pub const ARG_MAX = (256 * 1024);
pub const CHILD_MAX = 40;
pub const MAX_CANON = 255;
pub const MAX_INPUT = 255;
pub const NAME_MAX = 255;
pub const NGROUPS_MAX = 1023;
pub const OPEN_MAX = 64;
pub const PATH_MAX = 1024;
pub const PIPE_BUF = 512;
pub const IOV_MAX = 1024;

pub const O = struct {
    pub const RDONLY = 0x0000;
    pub const WRONLY = 0x0001;
    pub const RDWR = 0x0002;
    pub const ACCMODE = 0x0003;
    pub const NONBLOCK = 0x0004;
    pub const APPEND = 0x0008;
    pub const SHLOCK = 0x0010;
    pub const EXLOCK = 0x0020;
    pub const ASYNC = 0x0040;
    pub const FSYNC = 0x0080;
    pub const SYNC = 0x0080;
    pub const NOFOLLOW = 0x0100;
    pub const CREAT = 0x0200;
    pub const TRUNC = 0x0400;
    pub const EXCL = 0x0800;
    pub const NOCTTY = 0x8000;
    pub const DIRECT = 0x00010000;
    pub const DIRECTORY = 0x00020000;
    pub const EXEC = 0x00040000;
    pub const SEARCH = EXEC;
    pub const TTY_INIT = 0x00080000;
    pub const CLOEXEC = 0x00100000;
    pub const VERIFY = 0x00200000;
    pub const PATH = 0x00400000;
    pub const RESOLVE_BENEATH = 0x00800000;
    pub const DSYNC = 0x01000000;
    pub const EMPTY_PATH = 0x02000000;
    pub const NAMEDATTR = 0x04000000;
    pub const XATTR = NAMEDATTR;
    pub const SYMLINK = (PATH | NOFOLLOW);
    pub const CLOFORK = 0x08000000;
};

pub const AT = struct {
    pub const FDCWD = -100;
    pub const EACCESS = 0x0100;
    pub const SYMLINK_NOFOLLOW = 0x0200;
    pub const SYMLINK_FOLLOW = 0x0400;
    pub const REMOVEDIR = 0x0800;
    pub const BENEATH = 0x1000;
    pub const RESOLVE_BENEATH = 0x2000;
    pub const EMPTY_PATH = 0x4000;
    pub const RENAME_NOREPLACE = 0x0001;
    pub const RENAME_EXCHANGE = 0x0002;
};

pub const SIG = struct {
    pub const HUP = 1;
    pub const INT = 2;
    pub const QUIT = 3;
    pub const ILL = 4;
    pub const TRAP = 5;
    pub const ABRT = 6;
    pub const IOT = ABRT;
    pub const EMT = 7;
    pub const FPE = 8;
    pub const KILL = 9;
    pub const BUS = 10;
    pub const SEGV = 11;
    pub const SYS = 12;
    pub const PIPE = 13;
    pub const ALRM = 14;
    pub const TERM = 15;
    pub const URG = 16;
    pub const STOP = 17;
    pub const TSTP = 18;
    pub const CONT = 19;
    pub const CHLD = 20;
    pub const TTIN = 21;
    pub const TTOU = 22;
    pub const IO = 23;
    pub const XCPU = 24;
    pub const XFSZ = 25;
    pub const VTALRM = 26;
    pub const PROF = 27;
    pub const WINCH = 28;
    pub const INFO = 29;
    pub const USR1 = 30;
    pub const USR2 = 31;
    pub const THR = 32;
    pub const LWP = THR;
    pub const LIBRT = 33;
};

pub const POLL = struct {
    pub const IN = 0x0001;
    pub const PRI = 0x0002;
    pub const OUT = 0x0004;
    pub const RDNORM = 0x0040;
    pub const WRNORM = OUT;
    pub const RDBAND = 0x0080;
    pub const WRBAND = 0x0100;
    pub const INIGNEOF = 0x2000;
    pub const RDHUP = 0x4000;
    pub const ERR = 0x0008;
    pub const HUP = 0x0010;
    pub const NVAL = 0x0020;
};

pub const W = struct {
    pub const COREFLAG = 0o200;
    pub const _STOPPED = 0o177;
    pub const NOHANG = 1;
    pub const UNTRACED = 2;
    pub const STOPPED = UNTRACED;
    pub const CONTINUED = 4;
    pub const NOWAIT = 8;
    pub const EXITED = 16;
    pub const TRAPPED = 32;
    pub const LINUXCLONE = 0x80000000;

    pub fn _INT(s: c_int) c_int {
        return s;
    }
    pub fn _STATUS(s: c_int) u8 {
        return @intCast(_INT(s) & 0o177);
    }
    pub fn IFSTOPPED(s: c_int) bool {
        return _STATUS(s) == _STOPPED;
    }
    pub fn STOPSIG(s: c_int) u8 {
        return @intCast(_INT(s) >> 8);
    }
    pub fn IFSIGNALED(s: c_int) bool {
        return _STATUS(s) != _STOPPED and _STATUS(s) != 0 and s != 0x13;
    }
    pub fn TERMSIG(s: c_int) u8 {
        return _STATUS(s);
    }
    pub fn IFEXITED(s: c_int) bool {
        return _STATUS(s) == 0;
    }
    pub fn EXITSTATUS(s: c_int) u8 {
        return @intCast(_INT(s) >> 8);
    }
    pub fn IFCONTINUED(s: c_int) bool {
        return s == SIG.CONT;
    }
    pub fn COREDUMP(s: c_int) bool {
        return s == SIG.CONT;
    }
    pub fn _EXITCODE(r: c_int, s: c_int) c_int {
        return r << 8 | s;
    }
    pub fn _STOPCODE(s: c_int) c_int {
        return s << 8 | _STOPPED;
    }
};

pub const S = struct {
    pub const ISUID = 0o004000;
    pub const ISGID = 0o002000;
    pub const ISTXT = 0o001000;
    pub const IRWXU = 0o000700;
    pub const IRUSR = 0o000400;
    pub const IWUSR = 0o000200;
    pub const IXUSR = 0o000100;
    pub const IREAD = IRUSR;
    pub const IWRITE = IWUSR;
    pub const IEXEC = IXUSR;
    pub const IRWXG = 0o000070;
    pub const IRGRP = 0o000040;
    pub const IWGRP = 0o000020;
    pub const IXGRP = 0o000010;
    pub const IRWXO = 0o000007;
    pub const IROTH = 0o000004;
    pub const IWOTH = 0o000002;
    pub const IXOTH = 0o000001;
    pub const IFMT = 0o170000;
    pub const IFIFO = 0o010000;
    pub const IFCHR = 0o020000;
    pub const IFDIR = 0o040000;
    pub const IFBLK = 0o060000;
    pub const IFREG = 0o100000;
    pub const IFLNK = 0o120000;
    pub const IFSOCK = 0o140000;
    pub const ISVTX = 0o001000;
    pub const IFWHT = 0o160000;
};

pub const AF = enum(sa_family_t) {
    UNSPEC = 0,
    UNIX = 1,
    INET = 2,
    IMPLINK = 3,
    PUP = 4,
    CHAOS = 5,
    NETBIOS = 6,
    ISO = 7,
    ECMA = 8,
    DATAKIT = 9,
    CCITT = 10,
    SNA = 11,
    DECnet = 12,
    DLI = 13,
    LAT = 14,
    HYLINK = 15,
    APPLETALK = 16,
    ROUTE = 17,
    LINK = 18,
    XTP = 19,
    COIP = 20,
    CNT = 21,
    RTIP = 22,
    IPX = 23,
    SIP = 24,
    PIP = 25,
    ISDN = 26,
    KEY = 27,
    INET6 = 28,
    NATM = 29,
    ATM = 30,
    HDRCMPLT = 31,
    NETGRAPH = 32,
    SLOW = 33,
    SCLUSTER = 34,
    ARP = 35,
    BLUETOOTH = 36,
    IEEE80211 = 37,
    NETLINK = 38,
    INET_SDP = 40,
    INET6_SDP = 42,
    HYPERV = 43,
    DIVERT = 44,
    IPFWLOG = 46,

    pub const LOCAL: AF = .UNIX;
    pub const OSI: AF = .ISO;
    pub const E164: AF = .ISDN;
};

pub const SOCK = struct {
    pub const STREAM = 1;
    pub const DGRAM = 2;
    pub const RAW = 3;
    pub const RDM = 4;
    pub const SEQPACKET = 5;
    pub const CLOEXEC = 0x10000000;
    pub const NONBLOCK = 0x20000000;
    pub const CLOFORK = 0x40000000;
};

pub const IPPROTO = struct {
    pub const IP = 0;
    pub const ICMP = 1;
    pub const TCP = 6;
    pub const UDP = 17;
    pub const IPV6 = 41;
    pub const RAW = 255;
    pub const HOPOPTS = 0;
    pub const IGMP = 2;
    pub const GGP = 3;
    pub const IPV4 = 4;
    pub const IPIP = IPV4;
    pub const ST = 7;
    pub const EGP = 8;
    pub const PIGP = 9;
    pub const RCCMON = 10;
    pub const NVPII = 11;
    pub const PUP = 12;
    pub const ARGUS = 13;
    pub const EMCON = 14;
    pub const XNET = 15;
    pub const CHAOS = 16;
    pub const MUX = 18;
    pub const MEAS = 19;
    pub const HMP = 20;
    pub const PRM = 21;
    pub const IDP = 22;
    pub const TRUNK1 = 23;
    pub const TRUNK2 = 24;
    pub const LEAF1 = 25;
    pub const LEAF2 = 26;
    pub const RDP = 27;
    pub const IRTP = 28;
    pub const TP = 29;
    pub const BLT = 30;
    pub const NSP = 31;
    pub const INP = 32;
    pub const DCCP = 33;
    pub const @"3PC" = 34;
    pub const IDPR = 35;
    pub const XTP = 36;
    pub const DDP = 37;
    pub const CMTP = 38;
    pub const TPXX = 39;
    pub const IL = 40;
    pub const SDRP = 42;
    pub const ROUTING = 43;
    pub const FRAGMENT = 44;
    pub const IDRP = 45;
    pub const RSVP = 46;
    pub const GRE = 47;
    pub const MHRP = 48;
    pub const BHA = 49;
    pub const ESP = 50;
    pub const AH = 51;
    pub const INLSP = 52;
    pub const SWIPE = 53;
    pub const NHRP = 54;
    pub const MOBILE = 55;
    pub const TLSP = 56;
    pub const SKIP = 57;
    pub const ICMPV6 = 58;
    pub const NONE = 59;
    pub const DSTOPTS = 60;
    pub const AHIP = 61;
    pub const CFTP = 62;
    pub const HELLO = 63;
    pub const SATEXPAK = 64;
    pub const KRYPTOLAN = 65;
    pub const RVD = 66;
    pub const IPPC = 67;
    pub const ADFS = 68;
    pub const SATMON = 69;
    pub const VISA = 70;
    pub const IPCV = 71;
    pub const CPNX = 72;
    pub const CPHB = 73;
    pub const WSN = 74;
    pub const PVP = 75;
    pub const BRSATMON = 76;
    pub const ND = 77;
    pub const WBMON = 78;
    pub const WBEXPAK = 79;
    pub const EON = 80;
    pub const VMTP = 81;
    pub const SVMTP = 82;
    pub const VINES = 83;
    pub const TTP = 84;
    pub const IGP = 85;
    pub const DGP = 86;
    pub const TCF = 87;
    pub const IGRP = 88;
    pub const OSPFIGP = 89;
    pub const SRPC = 90;
    pub const LARP = 91;
    pub const MTP = 92;
    pub const AX25 = 93;
    pub const IPEIP = 94;
    pub const MICP = 95;
    pub const SCCSP = 96;
    pub const ETHERIP = 97;
    pub const ENCAP = 98;
    pub const APES = 99;
    pub const GMTP = 100;
    pub const IPCOMP = 108;
    pub const SCTP = 132;
    pub const MH = 135;
    pub const UDPLITE = 136;
    pub const HIP = 139;
    pub const SHIM6 = 140;
    pub const PIM = 103;
    pub const CARP = 112;
    pub const PGM = 113;
    pub const MPLS = 137;
    pub const PFSYNC = 240;
};

pub const CLOCK = enum(clockid_t) {
    REALTIME = 0,
    VIRTUAL = 1,
    PROF = 2,
    MONOTONIC = 4,
    UPTIME_FAST = 8,
    UPTIME = 5,
    UPTIME_PRECISE = 7,
    REALTIME_PRECISE = 9,
    REALTIME_FAST = 10,
    MONOTONIC_PRECISE = 11,
    MONOTONIC_FAST = 12,
    SECOND = 13,
    THREAD_CPUTIME_ID = 14,
    PROCESS_CPUTIME_ID = 15,
    TAI = 16,
    _,

    pub const BOOTTIME: CLOCK = .MONOTONIC;
    pub const REALTIME_COARSE: CLOCK = .REALTIME_FAST;
    pub const MONOTONIC_COARSE: CLOCK = .MONOTONIC_FAST;
};

pub const SOL = struct {
    pub const SOCKET = 0xffff;
};

pub const SO = struct {
    pub const DEBUG = 0x00000001;
    pub const ACCEPTCONN = 0x00000002;
    pub const REUSEADDR = 0x00000004;
    pub const KEEPALIVE = 0x00000008;
    pub const DONTROUTE = 0x00000010;
    pub const BROADCAST = 0x00000020;
    pub const USELOOPBACK = 0x00000040;
    pub const LINGER = 0x00000080;
    pub const OOBINLINE = 0x00000100;
    pub const REUSEPORT = 0x00000200;
    pub const TIMESTAMP = 0x00000400;
    pub const NOSIGPIPE = 0x00000800;
    pub const ACCEPTFILTER = 0x00001000;
    pub const BINTIME = 0x00002000;
    pub const NO_OFFLOAD = 0x00004000;
    pub const NO_DDP = 0x00008000;
    pub const REUSEPORT_LB = 0x00010000;
    pub const RERROR = 0x00020000;
    pub const PASSRIGHTS = 0x00040000;
    pub const SNDBUF = 0x1001;
    pub const RCVBUF = 0x1002;
    pub const SNDLOWAT = 0x1003;
    pub const RCVLOWAT = 0x1004;
    pub const SNDTIMEO = 0x1005;
    pub const RCVTIMEO = 0x1006;
    pub const ERROR = 0x1007;
    pub const TYPE = 0x1008;
    pub const LABEL = 0x1009;
    pub const PEERLABEL = 0x1010;
    pub const LISTENQLIMIT = 0x1011;
    pub const LISTENQLEN = 0x1012;
    pub const LISTENINCQLEN = 0x1013;
    pub const FIB = 0x1014;
    pub const SETFIB = FIB;
    pub const USER_COOKIE = 0x1015;
    pub const PROTOCOL = 0x1016;
    pub const PROTOTYPE = PROTOCOL;
    pub const TS_CLOCK = 0x1017;
    pub const MAX_PACING_RATE = 0x1018;
    pub const DOMAIN = 0x1019;
    pub const SPLICE = 0x1023;
    pub const TS_REALTIME_MICRO = 0;
    pub const TS_BINTIME = 1;
    pub const TS_REALTIME = 2;
    pub const TS_MONOTONIC = 3;
    pub const TS_DEFAULT = TS_REALTIME_MICRO;
    pub const TS_CLOCK_MAX = TS_MONOTONIC;
};

pub const DT = enum(u8) {
    UNKNOWN = 0,
    FIFO = 1,
    CHR = 2,
    DIR = 4,
    BLK = 6,
    REG = 8,
    LNK = 10,
    SOCK = 12,
    WHT = 14,
};

pub const SHUT = enum(c_int) {
    RD = 0,
    WR = 1,
    RDWR = 2,
};

pub const MAP = struct {
    pub const SHARED = 0x0001;
    pub const PRIVATE = 0x0002;
    pub const FIXED = 0x0010;
    pub const FILE = 0x0000;
    pub const ANON = 0x1000;
    pub const ANONYMOUS = ANON;
    pub const GUARD = 0x00002000;
    pub const EXCL = 0x00004000;
    pub const NOCORE = 0x00020000;
    pub const PREFAULT_READ = 0x00040000;
    pub const _32BIT = 0x00080000;
    pub const FAILED = -1;
};

pub const PROT = struct {
    pub const NONE = 0x00;
    pub const READ = 0x01;
    pub const WRITE = 0x02;
    pub const EXEC = 0x04;
    pub const CHERI0 = 0x08;
    pub const CHERI1 = 0x10;
};

pub fn pipe2(flag: c_int) ![2]c_int {
    var fildes: [2]c_int = @splat(-1);
    const rc = libc.pipe2(&fildes, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return fildes;
}
pub fn openat(fd: c_int, file: [*:0]const u8, oflag: c_int) errno.Error!c_int {
    const rc = libc.openat(fd, file, oflag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return rc;
}
pub fn openat4(fd: c_int, file: [*:0]const u8, oflag: c_int, mode: mode_t) errno.Error!c_int {
    const rc = libc.openat(fd, file, oflag, mode);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    return rc;
}
pub fn close(fd: c_int) errno.Error!void {
    const rc = libc.close(fd);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn fork() !pid_t {
    const rc = libc.fork();
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return rc;
}
pub fn dup2(fildes: c_int, fildes2: c_int) !void {
    const rc = libc.dup2(fildes, fildes2);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
}
pub fn fchdir(fildes: c_int) !void {
    const rc = libc.fchdir(fildes);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn execvp(file: [*:0]const u8, argv: [*:null]const ?[*:0]const u8) !noreturn {
    const rc = libc.execvp(file, argv);
    std.debug.assert(rc == -1);
    return errno.fromInt(errno.fromLibC());
}
pub fn kill(pid: pid_t, sig: c_int) !void {
    const rc = libc.kill(pid, sig);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn poll(fds: []struct_pollfd, timeout_ms: c_int) !c_int {
    const rc = libc.poll(fds.ptr, @intCast(fds.len), timeout_ms);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return rc;
}
pub fn read(fd: c_int, buf: []u8) errno.Error!usize {
    const rc = libc.read(fd, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn write(fd: c_int, buf: []const u8) !usize {
    const rc = libc.write(fd, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn waitpid(pid: pid_t, options: c_int) !struct { pid_t, c_int } {
    var status: c_int = 0;
    const rc = libc.waitpid(pid, &status, options);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return .{ rc, status };
}
pub fn getenv(name: [:0]const u8) ?[:0]u8 {
    return std.mem.sliceTo(libc.getenv(name.ptr) orelse return null, 0);
}
pub fn exit(status: c_int) noreturn {
    return libc.exit(status);
}
pub fn mkdirat(fd: c_int, path: [*:0]const u8, mode: mode_t) errno.Error!void {
    const rc = libc.mkdirat(fd, path, mode);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn fstatat(fd: c_int, path: [*:0]const u8, flag: c_int) errno.Error!struct_stat {
    var buf: struct_stat = undefined;
    const rc = libc.fstatat(fd, path, &buf, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return buf;
}
pub fn getaddrinfo(noalias nodename: ?[*:0]const u8, noalias servname: ?[*:0]const u8, noalias req: ?*const struct_addrinfo) eai.Error!*const struct_addrinfo {
    var pai: *const struct_addrinfo = undefined;
    var hints = std.mem.zeroes(struct_addrinfo);
    const rc = libc.getaddrinfo(nodename, servname, req orelse &hints, &pai);
    if (rc > 0) return eai.fromInt(rc);
    std.debug.assert(rc == 0);
    return pai;
}
pub fn freeaddrinfo(ai: *const struct_addrinfo) void {
    return libc.freeaddrinfo(ai);
}
pub fn socket(domain: AF, ty: c_int, protocol: c_int) errno.Error!c_uint {
    const rc = libc.socket(@intFromEnum(domain), ty, protocol);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc > 0);
    return @intCast(rc);
}
pub fn connect(socketfd: c_uint, address: *const struct_sockaddr, address_len: socklen_t) errno.Error!void {
    const rc = libc.connect(@intCast(socketfd), address, address_len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn getrandom(buf: []u8, flags: c_uint) ![]u8 {
    const rc = libc.getrandom(buf.ptr, buf.len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return buf[0..@intCast(rc)];
}
pub fn clock_gettime(clock_id: CLOCK) !struct_timespec {
    var tp: struct_timespec = undefined;
    const rc = libc.clock_gettime(@intFromEnum(clock_id), &tp);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return tp;
}
pub fn renameat(oldfd: c_int, old: [*:0]const u8, newfd: c_int, new: [*:0]const u8) !void {
    const rc = libc.renameat(oldfd, old, newfd, new);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn send(socketfd: c_uint, buffer: []const u8, flags: c_int) errno.Error!usize {
    const rc = libc.send(@intCast(socketfd), buffer.ptr, buffer.len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}

pub fn recv(socketfd: c_uint, buffer: []u8, flags: c_int) errno.Error!usize {
    const rc = libc.recv(@intCast(socketfd), buffer.ptr, buffer.len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn fstat(fd: c_int) errno.Error!struct_stat {
    var buf: struct_stat = undefined;
    const rc = libc.fstat(fd, &buf);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return buf;
}
pub fn mmap(addr: ?*anyopaque, len: usize, prot: c_int, flags: c_int, fd: c_int, offset: off_t) errno.Error![]u8 {
    const rc = libc.mmap(addr, len, prot, flags, fd, offset);
    if (@intFromPtr(rc) == MAP.FAILED) return errno.fromInt(errno.fromLibC());
    const ptr: [*]u8 = @ptrCast(rc);
    return ptr[0..len];
}
pub fn writev(fd: c_int, iovec: []const struct_iovec) !usize {
    const rc = libc.writev(fd, iovec.ptr, @intCast(iovec.len));
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn faccessat(fd: c_int, path: [*:0]const u8, amode: c_int, flag: c_int) !void {
    const rc = libc.faccessat(fd, path, amode, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn readlinkat(dirfd: c_int, noalias path: [*:0]const u8, noalias buf: []u8) ![:0]u8 {
    const rc = libc.readlinkat(dirfd, path, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    buf[@intCast(rc)] = 0;
    return buf[0..@intCast(rc) :0];
}
pub fn futimens(fd: c_int, times: [2]struct_timespec) !void {
    const rc = libc.futimens(fd, &times);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn setsockopt(socketfd: c_uint, level: c_int, optname: c_int, opaque_opt: []const u8) errno.Error!void {
    const rc = libc.setsockopt(@intCast(socketfd), level, optname, opaque_opt.ptr, @intCast(opaque_opt.len));
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn bind(socketfd: c_uint, address: *const struct_sockaddr, address_len: socklen_t) errno.Error!void {
    const rc = libc.bind(@intCast(socketfd), address, address_len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn listen(socketfd: c_uint, backlog: c_int) errno.Error!void {
    const rc = libc.listen(@intCast(socketfd), backlog);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn getsockname(socketfd: c_uint, noalias address: *struct_sockaddr, noalias address_len: *socklen_t) errno.Error!void {
    const rc = libc.getsockname(@intCast(socketfd), address, address_len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn munmap(addr: *const anyopaque, len: usize) errno.Error!void {
    const rc = libc.munmap(addr, len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn getdents(dirfd: c_int, buf: []u8) errno.Error!usize {
    const rc = libc.getdents(dirfd, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn accept4(socketfd: c_uint, noalias address: ?*struct_sockaddr, noalias address_len: *socklen_t, flags: c_int) errno.Error!c_uint {
    const rc = libc.accept4(@intCast(socketfd), address, address_len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc > 0);
    return @intCast(rc);
}
pub fn shutdown(socketfd: c_uint, how: SHUT) errno.Error!void {
    const rc = libc.shutdown(@intCast(socketfd), @intFromEnum(how));
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn unlinkat(fd: c_int, name: [*:0]const u8, flag: c_int) !void {
    const rc = libc.unlinkat(fd, name, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
