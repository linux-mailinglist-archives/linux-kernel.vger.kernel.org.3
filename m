Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E648E868
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiANKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:40:40 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiANKkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:40:39 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MIxBc-1mtPWW0OOQ-00KQWV for <linux-kernel@vger.kernel.org>; Fri, 14 Jan
 2022 11:40:38 +0100
Received: by mail-wr1-f45.google.com with SMTP id s1so14863462wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:40:37 -0800 (PST)
X-Gm-Message-State: AOAM533U9DKvRr/6HV+1QGCO/4wmCQiW0kGzq9pxjePbUgJp0FVrV0CN
        hz8OlXwoC4PhYtkOkS8rIGF1dZxQPe3JKgc8n90=
X-Google-Smtp-Source: ABdhPJy2oNn4sy01u44f+JWtncmUysJDmX7n0cdFfaLoaUBfsdqbrQ49guJrHMZ4k/jtC73/duvZ4heSzZUWC991NOs=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr7819811wrs.192.1642156837652;
 Fri, 14 Jan 2022 02:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <YeD2q77KmaD8k87Q@mit.edu>
In-Reply-To: <YeD2q77KmaD8k87Q@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Jan 2022 11:40:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1R1=3LfHHDDjnNvwZWgrvMOaNpNO19L60ATxku6RCiSA@mail.gmail.com>
Message-ID: <CAK8P3a1R1=3LfHHDDjnNvwZWgrvMOaNpNO19L60ATxku6RCiSA@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YMZDZZoZHrqrz1+2+UO6X/M6D7J1oh4at27nWYRkfo/6wonWbKI
 us7Zal59xFj6S4qRmxTOW9h/5EAwzKk7uNqPL8SdNF5vncL67+pNJT7zcaoYC41O9rBPjRP
 XEjZAZhBBVbK4QSCOS/m/R18FlU1or9bxVyMVLxJOirh5o1LlKnSvqFa0F2TxpLYlGCkddU
 fH8VH6zf/IW+M9FI28Fbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgLceTiaAhE=:UjEjR8RDLjw0ScyHWCMlZT
 OE27RCr6i6q6l8DUVTFoFxRyOUmqee5EwSJASTmc6qN32HTF4LUooCTZ2hQcvGzSHbCwbP3+p
 E/K+LHvCUJGFBFEEiSt9dwkyVDpOggcwousqrrsF7sEtBllEUm4LGQsPLR+67qP7y0V7S9MEf
 Jes04u2Wxl6zNePYfNG97sronxgJuUe7s665rxGr9W6SW6U/PpcMLXIkqqTUt3Yh73ZF5q2y7
 X3CUB20hRUm9LX6psbUsBhC6TwSo6w6W4GEEazGHDFZtQVR3C7Xh6otP/0kBLrZkmzj4AIIWQ
 CtpULW6GwqopWxecyjjr5hGN0XJv+3j0iKY1+rOwGiiQr6XmXPCFEOTjsSQX0ZnL/BZAfReLK
 jQxMBLZWwR/axKaWYT01/1Th9AQv1AYyHNWtwHLO7cXSfm+o/eE64aR5127B1xqibnxHtzPL6
 apm6AOFi5GeF5BqXnLmVi090tALWrpxUJ2TKupFtDopWgK/rMGh2UdikbT4gstIqQryn8b/e4
 lwpqEA2HScbbSBU63MFfAofl2/SVweEvpZk1IUZqWehhGgSS3iH/W2zDQ91ix2QMLv3wq049D
 pBra9B4h/zuFbratS4LRYGM/g4fdG/MliSNtoFUqbJxAoQHTenQ/dmdWVpl3pdr4io/Sria+Z
 E52+pB4luCQr+t1mTLwohhD6wru9pd8M6jQzN6NeLwFDoSdqoCVksUwGClOHESLgyT4g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 5:06 AM Theodore Ts'o <tytso@mit.edu> wrote:
> On Thu, Jan 13, 2022 at 11:56:53PM +0100, Borislav Petkov wrote:
> >
> > But I'm open to suggestions on how to determine which are those obsolete
> > syscalls.
>
> Historically there were a couple of different C libraries
> which x86 binaries for Linux could use:
>
> A) minix's libc -- used by binaries compiled using the Minix 1 toolchain
> B) Libc 4 -- a fork of GNU Libc version 1, for a.out execuables
> C) Libc 5 -- a fork of GNU Libc version 1, for ELF execuables
> D) Libc 6 -- GNU Libc version 2, for ELF executables
>
> So I think what this would boil down to is finding those system calls
> that were used by (A) and (B), but not referenced in (C) and (D).  I
> guess we'd also have to check to make sure that some of these ancient
> system calls might still be used by some of the micro libc's, such as
> dietlibc, musl, etc.
>
> Is it worth doing?  Perhaps; perhaps not.  It probably wouldn't reduce
> the size of the kernel by all *that* much, but getting rid of cruft is
> kind of a good thing for its own sake.

For reference, these are the system calls that are implemented on i386
as of 5.16 but have been replaced on modern architectures, from
ooking only in the linux sources:

2 i386 fork sys_fork
5 i386 open sys_open compat_sys_open
7 i386 waitpid sys_waitpid
8 i386 creat sys_creat
9 i386 link sys_link
10 i386 unlink sys_unlink
13 i386 time sys_time32
14 i386 mknod sys_mknod
15 i386 chmod sys_chmod
16 i386 lchown sys_lchown16
16 i386 lchown sys_lchown16
18 i386 oldstat sys_stat
22 i386 umount sys_oldumount
23 i386 setuid sys_setuid16
24 i386 getuid sys_getuid16
25 i386 stime sys_stime32
27 i386 alarm sys_alarm
28 i386 oldfstat sys_fstat
29 i386 pause sys_pause
30 i386 utime sys_utime32
33 i386 access sys_access
34 i386 nice sys_nice
38 i386 rename sys_rename
39 i386 mkdir sys_mkdir
40 i386 rmdir sys_rmdir
42 i386 pipe sys_pipe
46 i386 setgid sys_setgid16
47 i386 getgid sys_getgid16
48 i386 signal sys_signal
49 i386 geteuid sys_geteuid16
50 i386 getegid sys_getegid16
59 i386 oldolduname sys_olduname
62 i386 ustat sys_ustat compat_sys_ustat
63 i386 dup2 sys_dup2
65 i386 getpgrp sys_getpgrp
67 i386 sigaction sys_sigaction compat_sys_sigaction
68 i386 sgetmask sys_sgetmask
69 i386 ssetmask sys_ssetmask
70 i386 setreuid sys_setreuid16
71 i386 setregid sys_setregid16
72 i386 sigsuspend sys_sigsuspend
73 i386 sigpending sys_sigpending compat_sys_sigpending
80 i386 getgroups sys_getgroups16
81 i386 setgroups sys_setgroups16
82 i386 select sys_old_select compat_sys_old_select
83 i386 symlink sys_symlink
84 i386 oldlstat sys_lstat
85 i386 readlink sys_readlink
86 i386 uselib sys_uselib
89 i386 readdir sys_old_readdir compat_sys_old_readdir
95 i386 fchown sys_fchown16
101 i386 ioperm sys_ioperm
102 i386 socketcall sys_socketcall compat_sys_socketcall
109 i386 olduname sys_uname
110 i386 iopl sys_iopl
117 i386 ipc sys_ipc compat_sys_ipc
119 i386 sigreturn sys_sigreturn compat_sys_sigreturn
123 i386 modify_ldt sys_modify_ldt
126 i386 sigprocmask sys_sigprocmask compat_sys_sigprocmask
135 i386 sysfs sys_sysfs
138 i386 setfsuid sys_setfsuid16
139 i386 setfsgid sys_setfsgid16
141 i386 getdents sys_getdents compat_sys_getdents
142 i386 _newselect sys_select compat_sys_select
164 i386 setresuid sys_setresuid16
165 i386 getresuid sys_getresuid16
168 i386 poll sys_poll
170 i386 setresgid sys_setresgid16
171 i386 getresgid sys_getresgid
182 i386 chown sys_chown16
190 i386 vfork sys_vfork
243 i386 set_thread_area sys_set_thread_area
244 i386 get_thread_area sys_get_thread_area
254 i386 epoll_create sys_epoll_create
256 i386 epoll_wait sys_epoll_wait
271 i386 utimes sys_utimes_time32
291 i386 inotify_init sys_inotify_init
299 i386 futimesat sys_futimesat_time32
321 i386 signalfd sys_signalfd compat_sys_signalfd
323 i386 eventfd sys_eventfd
384 i386 arch_prctl sys_arch_prctl compat_sys_arch_prctl

Looking at libc-4.7.2 from Slackware-3.0, the highest syscall number
used there is 182 (chown16), anything later is presumably added
after the ELF transition was done. All of the syscalls referenced in
libc-4.7 are still referenced in libc-5.0, so nothing is obviously changed
between those.

Excluding the syscalls that are referenced in libc5 brings the
candidates down to

7       i386    waitpid                 sys_waitpid
16      i386    lchown                  sys_lchown16
18      i386    oldstat                 sys_stat
28      i386    oldfstat                sys_fstat
48      i386    signal                  sys_signal
59      i386    oldolduname             sys_olduname
68      i386    sgetmask                sys_sgetmask
69      i386    ssetmask                sys_ssetmask
84      i386    oldlstat                sys_lstat
109     i386    olduname                sys_uname
119     i386    sigreturn               sys_sigreturn
123     i386    modify_ldt              sys_modify_ldt
135     i386    sysfs                   sys_sysfs
141     i386    getdents                sys_getdents
142     i386    _newselect              sys_select
164     i386    setresuid               sys_setresuid16
165     i386    getresuid               sys_getresuid16
168     i386    poll                    sys_poll
170     i386    setresgid               sys_setresgid16
171     i386    getresgid               sys_getresgid16

This is probably a mix of some things that are too old
for libc5, some that are too new, and some that were never
part of libc but are called from other places.

Some may be misrepresented here because the macros got
renamed: libc5 calls 'uname' but expects it to be what the
kernel now calls '__NR_olduname'. I could not find out
which of the 'stat' family it expects because the headers
are incomplete in the slackware source package.

       Arnd
