Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA262515C34
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbiD3KUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 06:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiD3KUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 06:20:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB47C159;
        Sat, 30 Apr 2022 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651313824; x=1682849824;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=QJ1gLrUnpGTWRGeq6q2flfrwAvs4i/PZDFph8DaL3f0=;
  b=KURBxWdiCzmc7xtiZR7V+ohklGvajLuXy0qUY4G3ZWJSL33I2qXJUC0k
   SMe8RPtsc4QqOzFRWeGhSDySPmOvKAEspHpCqIn9DwqfXWLo5Hwax6ySG
   dQYzlXf42F0Px0KCppqKtj0pwjAAGmMUJ/L10nhbu1WnUMaSe1KNsggHO
   aD3nh8W0vJR9OCA8+OFpjwiPIXoJTFGnHGKikYf4f7EoYG9BAV+Xwj97b
   6Ckj/4cGJswGcAKBJRvZa/dtKiCShY0KBtlkLoUU5+Lb3VRO/s3DFJ7nO
   PP40ZglsrKs12YuCZF8GYwZi9omOSBQ82ae/5H5zGVpyabMgSbjsIK68u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="353293795"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="xz'?yaml'?scan'208";a="353293795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 03:17:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="xz'?yaml'?scan'208";a="560824576"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 03:16:52 -0700
Date:   Sat, 30 Apr 2022 18:16:48 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, glider@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: [x86]  d216de19c8: kernel-selftests.x86.ioperm_32.fail
Message-ID: <20220430101648.GC24415@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20220426164315.625149-6-glider@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: d216de19c8dd97fb6b0eac84fce4362489a61b2e ("[PATCH v3 05/46] x86: asm: instrument usercopy in get_user() and __put_user_size()")
url: https://github.com/intel-lab-lkp/linux/commits/Alexander-Potapenko/Add-KernelMemorySanitizer-infrastructure/20220427-004851
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 203d8919a9eda5d1bc68ac3cd7637588334c9dc1
patch link: https://lore.kernel.org/linux-mm/20220426164315.625149-6-glider@google.com

in testcase: kernel-selftests
version: kernel-selftests-x86_64-f6559bea-1_20220425
with following parameters:

	group: x86
	ucode: 0xec

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


actually we also observed other tests failed on this commit but pass on parent:

c30e163fc48e6944 d216de19c8dd97fb6b0eac84fce
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kmsg.segfault_at_ip_sp_error
           :6          100%           6:6     kernel-selftests.x86.fsgsbase_restore_32.fail
           :6          100%           6:6     kernel-selftests.x86.fsgsbase_restore_64.fail
           :6          100%           6:6     kernel-selftests.x86.ioperm_32.fail
           :6          100%           6:6     kernel-selftests.x86.iopl_32.fail
           :6          100%           6:6     kernel-selftests.x86.ptrace_syscall_32.fail
           :6          100%           6:6     kernel-selftests.x86.ptrace_syscall_64.fail
           :6          100%           6:6     kernel-selftests.x86.syscall_numbering_64.fail



# selftests: x86: iopl_32
# iopl_32: sched_setaffinity to CPU 0: Invalid argument
not ok 7 selftests: x86: iopl_32 # exit=1
# selftests: x86: ioperm_32
# ioperm_32: sched_setaffinity to CPU 0: Invalid argument
not ok 8 selftests: x86: ioperm_32 # exit=1

....

# selftests: x86: fsgsbase_restore_32
# fsgsbase_restore_32: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0xf7fb4000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child FS=0x7
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 12 selftests: x86: fsgsbase_restore_32 # exit=1

....

# selftests: x86: ptrace_syscall_32
# ptrace_syscall_32: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	Check AT_SYSINFO return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0xf7edb549)
not ok 22 selftests: x86: ptrace_syscall_32 # exit=1

....

# selftests: x86: fsgsbase_restore_64
# fsgsbase_restore_64: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0x4075c000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child GS=0x7, GSBASE=0x4075c000
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 34 selftests: x86: fsgsbase_restore_64 # exit=1

....

# selftests: x86: syscall_numbering_64
# [RUN]   Checking for x32 by calling x32 getpid()
# [INFO]      x32 is not supported
# [RUN]   Running tests without ptrace...
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: just stop, no data read
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: only getregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: getregs, unmodified setregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
#
not ok 38 selftests: x86: syscall_numbering_64 # TIMEOUT 300 seconds

....

# selftests: x86: ptrace_syscall_64
# ptrace_syscall_64: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0x7f424c815989)
not ok 42 selftests: x86: ptrace_syscall_64 # exit=1



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.18.0-rc1-00009-gd216de19c8dd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.18.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.2.0-20) 11.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_DP_HELPER=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
CONFIG_PROVE_NVDIMM_LOCKING=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='kernel-selftests-x86.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-kbl-d01'
	export tbox_group='lkp-kbl-d01'
	export submit_id='626c56eb3b130d0d2b08fe4d'
	export job_file='/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-x86-ucode=0xec-debian-10.4-x86_64-20200603.cgz-d216de19c8dd97fb6b0eac84fce4362489a61b2e-20220430-3371-obev7-5.yaml'
	export id='5046cfc8d3ae5ba4e33b011a93ef62f9d2ab9730'
	export queuer_version='/zday/lkp'
	export model='Kaby Lake'
	export nr_node=1
	export nr_cpu=8
	export memory='32G'
	export nr_sdd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part1'
	export brand='Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz'
	export commit='d216de19c8dd97fb6b0eac84fce4362489a61b2e'
	export ucode='0xec'
	export need_kconfig_hw='{"E1000E"=>"y"}
SATA_AHCI'
	export bisect_dmesg=true
	export need_kconfig=\{\"POSIX_TIMERS\"\=\>\"y,\ v4.10-rc1\"\}
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2022-04-30 05:21:47 +0800'
	export _id='626c56eb3b130d0d2b08fe51'
	export _rt='/result/kernel-selftests/x86-ucode=0xec/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='0ae1f1c5893c8eecea0fcc669a620cab08b41c23'
	export base_commit='af2d861d4cd2a4da5137f795ee3509e6f944a25b'
	export branch='linux-review/Alexander-Potapenko/Add-KernelMemorySanitizer-infrastructure/20220427-004851'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/x86-ucode=0xec/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/3'
	export scheduler_version='/lkp/lkp/.src-20220429-091100'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/x86-ucode=0xec/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/vmlinuz-5.18.0-rc1-00009-gd216de19c8dd
branch=linux-review/Alexander-Potapenko/Add-KernelMemorySanitizer-infrastructure/20220427-004851
job=/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-x86-ucode=0xec-debian-10.4-x86_64-20200603.cgz-d216de19c8dd97fb6b0eac84fce4362489a61b2e-20220430-3371-obev7-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=d216de19c8dd97fb6b0eac84fce4362489a61b2e
erst_disable
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20220425.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-f6559bea-1_20220425.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.17.0-13429-gd5fd43bac839'
	export repeat_to=6
	export schedule_notify_address=
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/vmlinuz-5.18.0-rc1-00009-gd216de19c8dd'
	export dequeue_time='2022-04-30 05:54:09 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-x86-ucode=0xec-debian-10.4-x86_64-20200603.cgz-d216de19c8dd97fb6b0eac84fce4362489a61b2e-20220430-3371-obev7-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='x86' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='x86' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--qjNfmADvan18RZcF
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e
2022-04-29 21:55:33 ln -sf /usr/bin/clang
2022-04-29 21:55:33 ln -sf /usr/bin/llc
2022-04-29 21:55:33 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2022-04-29 21:55:33 make -C x86
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86'
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/single_step_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sysret_ss_attrs_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/syscall_nt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_mremap_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/check_initial_reg_state_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sigreturn_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/iopl_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/ioperm_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_vsyscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/mov_ss_trap_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 mov_ss_trap.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/syscall_arg_fault_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_arg_fault.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/fsgsbase_restore_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase_restore.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sigaltstack_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigaltstack.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/entry_from_vm86_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 entry_from_vm86.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_syscall_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_syscall_vdso.c helpers.h thunks_32.S -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/unwind_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 unwind_vdso.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_FCMOV_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCMOV.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_FCOMI_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCOMI.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_FISTTP_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FISTTP.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/vdso_restorer_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 vdso_restorer.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/ldt_gdt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/ptrace_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c helpers.h raw_syscall_helper_32.S -lrt -ldl -lm
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/single_step_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sysret_ss_attrs_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c helpers.h thunks.S -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/syscall_nt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_mremap_vdso_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/check_initial_reg_state_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sigreturn_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/iopl_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/ioperm_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/test_vsyscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/mov_ss_trap_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 mov_ss_trap.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/syscall_arg_fault_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_arg_fault.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/fsgsbase_restore_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase_restore.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sigaltstack_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigaltstack.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/fsgsbase_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/sysret_rip_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_rip.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/syscall_numbering_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_numbering.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/corrupt_xstate_header_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 corrupt_xstate_header.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/amx_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 amx.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/ldt_gdt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86/ptrace_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c helpers.h -lrt -ldl
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86'
2022-04-29 21:55:43 make run_tests -C x86
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86'
TAP version 13
1..42
# selftests: x86: single_step_syscall_32
# [RUN]	Set TF and check nop
# [OK]	Survived with TF set and 15 traps
# [RUN]	Set TF and check int80
# [OK]	Survived with TF set and 14 traps
# [RUN]	Set TF and check a fast syscall
# [OK]	Survived with TF set and 45 traps
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
# [RUN]	Set TF and check SYSENTER
# 	Got SIGSEGV with RIP=f7f68549, TF=256
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
ok 1 selftests: x86: single_step_syscall_32
# selftests: x86: sysret_ss_attrs_32
# [WARN]	sched_setaffinity failed
# [RUN]	Syscalls followed by SS validation
# [OK]	We survived
ok 2 selftests: x86: sysret_ss_attrs_32
# selftests: x86: syscall_nt_32
# [RUN]	Set NT and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set DF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF|DF and issue a syscall
# [OK]	The syscall worked and flags are still set
ok 3 selftests: x86: syscall_nt_32
# selftests: x86: test_mremap_vdso_32
# 	AT_SYSINFO_EHDR is 0xf7ee2000
# [NOTE]	Moving vDSO: [0xf7ee2000, 0xf7ee3000] -> [0xf7f0b000, 0xf7f0c000]
# [NOTE]	vDSO partial move failed, will try with bigger size
# [NOTE]	Moving vDSO: [0xf7ee2000, 0xf7ee4000] -> [0xf7eda000, 0xf7edc000]
# [OK]
ok 4 selftests: x86: test_mremap_vdso_32
# selftests: x86: check_initial_reg_state_32
# [OK]	All GPRs except SP are 0
# [OK]	FLAGS is 0x202
ok 5 selftests: x86: check_initial_reg_state_32
# selftests: x86: sigreturn_32
# [OK]	set_thread_area refused 16-bit data
# [OK]	set_thread_area refused 16-bit data
# [RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	64-bit CS (33), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	64-bit CS (33), bogus SS (23)
# [OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (23)
# [OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (23)
# [OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
# [RUN]	32-bit CS (4f), bogus SS (2b)
# [OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
# [RUN]	32-bit CS (23), bogus SS (57)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
ok 6 selftests: x86: sigreturn_32
# selftests: x86: iopl_32
# iopl_32: sched_setaffinity to CPU 0: Invalid argument
not ok 7 selftests: x86: iopl_32 # exit=1
# selftests: x86: ioperm_32
# ioperm_32: sched_setaffinity to CPU 0: Invalid argument
not ok 8 selftests: x86: ioperm_32 # exit=1
# selftests: x86: test_vsyscall_32
# [NOTE]	failed to find getcpu in vDSO
# [RUN]	test gettimeofday()
# 	vDSO time offsets: 0.000011 0.000000
# [OK]	vDSO gettimeofday()'s timeval was okay
# [RUN]	test time()
# [OK]	vDSO time() is okay
# [RUN]	getcpu() on CPU 0
# [SKIP]	failed to force CPU 0
# [RUN]	getcpu() on CPU 1
# [SKIP]	failed to force CPU 1
ok 9 selftests: x86: test_vsyscall_32
# selftests: x86: mov_ss_trap_32
# 	SS = 0x2b, &SS = 0x0x804c11c
# 	PR_SET_PTRACER_ANY succeeded
# 	Set up a watchpoint
# 	DR0 = 804c11c, DR1 = 80493d6, DR7 = 7000a
# 	SS = 0x2b, &SS = 0x0x804c11c
# 	PR_SET_PTRACER_ANY succeeded
# 	Set up a watchpoint
# [RUN]	Read from watched memory (should get SIGTRAP)
# 	Got SIGTRAP with RIP=804922c, EFLAGS.RF=0
# [RUN]	MOV SS; INT3
# 	Got SIGTRAP with RIP=804923d, EFLAGS.RF=0
# [RUN]	MOV SS; INT 3
# 	Got SIGTRAP with RIP=804924f, EFLAGS.RF=0
# [RUN]	MOV SS; CS CS INT3
# 	Got SIGTRAP with RIP=8049262, EFLAGS.RF=0
# [RUN]	MOV SS; CSx14 INT3
# 	Got SIGTRAP with RIP=8049281, EFLAGS.RF=0
# [RUN]	MOV SS; INT 4
# 	Got SIGSEGV with RIP=80492ab
# [RUN]	MOV SS; INTO
# 	Got SIGTRAP with RIP=80492db, EFLAGS.RF=0
# [RUN]	MOV SS; ICEBP
# 	Got SIGTRAP with RIP=8049326, EFLAGS.RF=0
# [RUN]	MOV SS; CLI
# 	Got SIGSEGV with RIP=8049659
# [RUN]	MOV SS; #PF
# 	Got SIGSEGV with RIP=804961b
# [RUN]	MOV SS; INT 1
# 	Got SIGSEGV with RIP=80493b6
# [RUN]	MOV SS; breakpointed NOP
# 	Got SIGTRAP with RIP=80493d7, EFLAGS.RF=0
# [RUN]	MOV SS; SYSENTER
# 	Got SIGSEGV with RIP=f7f27549
# [RUN]	MOV SS; INT $0x80
# [OK]	I aten't dead
ok 10 selftests: x86: mov_ss_trap_32
# selftests: x86: syscall_arg_fault_32
# [RUN]	SYSENTER with invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with invalid state
# [SKIP]	Illegal instruction
# [RUN]	SYSENTER with TF and invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with TF and invalid state
# [SKIP]	Illegal instruction
ok 11 selftests: x86: syscall_arg_fault_32
# selftests: x86: fsgsbase_restore_32
# fsgsbase_restore_32: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0xf7fb4000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child FS=0x7
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 12 selftests: x86: fsgsbase_restore_32 # exit=1
# selftests: x86: sigaltstack_32
# [RUN]	Test an alternate signal stack of sufficient size.
# 	Raise SIGALRM. It is expected to be delivered.
# [OK]	SIGALRM signal delivered.
ok 13 selftests: x86: sigaltstack_32
# selftests: x86: entry_from_vm86_32
# [RUN]	#BR from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSENTER from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSCALL from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	STI with VIP set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP set and IF clear from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP clear and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	INT3 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	int80 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	UMIP tests from vm86 mode
# [SKIP]	vm86 not supported
# [INFO]	Result from SMSW:[0x0000]
# [INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
# [INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
# [PASS]	All the results from SMSW are identical.
# [PASS]	All the results from SGDT are identical.
# [PASS]	All the results from SIDT are identical.
# [RUN]	STR instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SLDT instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	Execute null pointer from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	#BR from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSENTER from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSCALL from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	STI with VIP set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP set and IF clear from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP clear and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	INT3 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	int80 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	UMIP tests from vm86 mode
# [SKIP]	vm86 not supported
# [INFO]	Result from SMSW:[0x0000]
# [INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
# [INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
# [PASS]	All the results from SMSW are identical.
# [PASS]	All the results from SGDT are identical.
# [PASS]	All the results from SIDT are identical.
# [RUN]	STR instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SLDT instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	Execute null pointer from vm86 mode
# [SKIP]	vm86 not supported
ok 14 selftests: x86: entry_from_vm86_32
# selftests: x86: test_syscall_vdso_32
# [RUN]	Executing 6-argument 32-bit syscall via VDSO
# [WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
# [WARN]	Flags  after=0000000000200686 id 0 00 d i s 0 0 p 1 
# [WARN]	Flags change=0000000000000851 0 00 o z 0 a 0 0 c
# [OK]	Arguments are preserved across syscall
# [NOTE]	R11 has changed:0000000000200686 - assuming clobbered by SYSRET insn
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Executing 6-argument 32-bit syscall via INT 80
# [OK]	Arguments are preserved across syscall
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Executing 6-argument 32-bit syscall via VDSO
# [WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
# [WARN]	Flags  after=0000000000200686 id 0 00 d i s 0 0 p 1 
# [WARN]	Flags change=0000000000000851 0 00 o z 0 a 0 0 c
# [OK]	Arguments are preserved across syscall
# [NOTE]	R11 has changed:0000000000200686 - assuming clobbered by SYSRET insn
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Executing 6-argument 32-bit syscall via INT 80
# [OK]	Arguments are preserved across syscall
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Running tests under ptrace
ok 15 selftests: x86: test_syscall_vdso_32
# selftests: x86: unwind_vdso_32
# 	AT_SYSINFO is 0xf7f0c540
# [OK]	AT_SYSINFO maps to linux-gate.so.1, loaded at 0x0xf7f0c000
# [RUN]	Set TF and check a fast syscall
# 	In vsyscall at 0xf7f0c540, returning to 0xf7cf50f7
# 	SIGTRAP at 0xf7f0c540
# 	  0xf7f0c540
# 	  0xf7cf50f7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c541
# 	  0xf7f0c541
# 	  0xf7cf50f7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c542
# 	  0xf7f0c542
# 	  0xf7cf50f7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c543
# 	  0xf7f0c543
# 	  0xf7cf50f7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c545
# 	  0xf7f0c545
# 	  0xf7cf50f7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c54a
# 	  0xf7f0c54a
# 	  0xf7cf50f7
# [OK]	  NR = 1926, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c54b
# 	  0xf7f0c54b
# 	  0xf7cf50f7
# [OK]	  NR = 1926, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f0c54c
# 	  0xf7f0c54c
# 	  0xf7cf50f7
# [OK]	  NR = 1926, args = 1, 2, 3, 4, 5, 6
# 	Vsyscall is done
# [OK]	All is well
ok 16 selftests: x86: unwind_vdso_32
# selftests: x86: test_FCMOV_32
# [RUN]	Testing fcmovCC instructions
# [OK]	fcmovCC
ok 17 selftests: x86: test_FCMOV_32
# selftests: x86: test_FCOMI_32
# [RUN]	Testing f[u]comi[p] instructions
# [OK]	f[u]comi[p]
ok 18 selftests: x86: test_FCOMI_32
# selftests: x86: test_FISTTP_32
# [RUN]	Testing fisttp instructions
# [OK]	fisttp
ok 19 selftests: x86: test_FISTTP_32
# selftests: x86: vdso_restorer_32
# [RUN]	Raise a signal, SA_SIGINFO, sa.restorer == NULL
# [OK]	SA_SIGINFO handler returned successfully
# [RUN]	Raise a signal, !SA_SIGINFO, sa.restorer == NULL
# [OK]	!SA_SIGINFO handler returned successfully
ok 20 selftests: x86: vdso_restorer_32
# selftests: x86: ldt_gdt_32
# [NOTE]	set_thread_area is available; will use GDT index 13
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 0 is invalid
# [NOTE]	set_thread_area is available; will use GDT index 13
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	Child succeeded
# [RUN]	Test size
# [DONE]	Size test
# [OK]	modify_ldt failure 22
# [OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
# [OK]	LDT entry 0 is invalid
# [OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
# [OK]	GDT entry 13 has AR 0x0040F300 and limit 0x000FFFFF
# [OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F300 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F100 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F700 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F500 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 is invalid
# [SKIP]	Cannot set affinity to CPU 1
# [RUN]	Test exec
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
# [OK]	Child succeeded
# [OK]	Invalidate DS with set_thread_area: new DS = 0x0
# [OK]	Invalidate ES with set_thread_area: new ES = 0x0
# [OK]	Invalidate FS with set_thread_area: new FS = 0x0
# [OK]	Invalidate GS with set_thread_area: new GS = 0x0
ok 21 selftests: x86: ldt_gdt_32
# selftests: x86: ptrace_syscall_32
# ptrace_syscall_32: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	Check AT_SYSINFO return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0xf7edb549)
not ok 22 selftests: x86: ptrace_syscall_32 # exit=1
# selftests: x86: single_step_syscall_64
# [RUN]	Set TF and check nop
# [OK]	Survived with TF set and 10 traps
# [RUN]	Set TF and check syscall-less opportunistic sysret
# [OK]	Survived with TF set and 12 traps
# [RUN]	Set TF and check int80
# [OK]	Survived with TF set and 9 traps
# [RUN]	Set TF and check a fast syscall
# [OK]	Survived with TF set and 22 traps
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
# [RUN]	Set TF and check SYSENTER
# 	Got SIGSEGV with RIP=a4951549, TF=256
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
ok 23 selftests: x86: single_step_syscall_64
# selftests: x86: sysret_ss_attrs_64
# [RUN]	Syscalls followed by SS validation
# [OK]	We survived
ok 24 selftests: x86: sysret_ss_attrs_64
# selftests: x86: syscall_nt_64
# [RUN]	Set NT and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set DF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF|DF and issue a syscall
# [OK]	The syscall worked and flags are still set
ok 25 selftests: x86: syscall_nt_64
# selftests: x86: test_mremap_vdso_64
# 	AT_SYSINFO_EHDR is 0x7fff0c230000
# [NOTE]	Moving vDSO: [0x7fff0c230000, 0x7fff0c231000] -> [0x7f686176b000, 0x7f686176c000]
# [NOTE]	vDSO partial move failed, will try with bigger size
# [NOTE]	Moving vDSO: [0x7fff0c230000, 0x7fff0c232000] -> [0x7f686176a000, 0x7f686176c000]
# [OK]
ok 26 selftests: x86: test_mremap_vdso_64
# selftests: x86: check_initial_reg_state_64
# [OK]	All GPRs except SP are 0
# [OK]	FLAGS is 0x202
ok 27 selftests: x86: check_initial_reg_state_64
# selftests: x86: sigreturn_64
# [OK]	set_thread_area refused 16-bit data
# [OK]	set_thread_area refused 16-bit data
# [RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
# 	Corrupting SS on return to 64-bit mode
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
# 	Corrupting SS on return to 64-bit mode
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	64-bit CS (33), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	64-bit CS (33), bogus SS (33)
# [OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (33)
# [OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (33)
# [OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
# [RUN]	32-bit CS (4f), bogus SS (2b)
# [OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
# [RUN]	32-bit CS (23), bogus SS (57)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	Clear UC_STRICT_RESTORE_SS and corrupt SS
# [OK]	It worked
ok 28 selftests: x86: sigreturn_64
# selftests: x86: iopl_64
# [OK]	CLI NOPped
# [OK]	STI NOPped
# [OK]	outb to 0x80 worked
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# 	child: set IOPL to 3
# [RUN]	child: write to 0x80
# [OK]	CLI NOPped
# [OK]	STI NOPped
# [OK]	outb to 0x80 worked
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [OK]	Child succeeded
# [RUN]	parent: write to 0x80 (should fail)
# [OK]	outb to 0x80 failed
# [OK]	CLI faulted
# [OK]	STI faulted
# 	iopl(3)
# 	Drop privileges
# [RUN]	iopl(3) unprivileged but with IOPL==3
# [RUN]	iopl(0) unprivileged
# [RUN]	iopl(3) unprivileged
# [OK]	Failed as expected
ok 29 selftests: x86: iopl_64
# selftests: x86: ioperm_64
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [RUN]	enable 0x80
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [RUN]	disable 0x80
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [RUN]	child: check that we inherited permissions
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [RUN]	child: Extend permissions to 0x81
# [RUN]	child: Drop permissions to 0x80
# [OK]	outb to 0x80 failed
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [RUN]	enable 0x80
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [RUN]	disable 0x80
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [OK]	Child succeeded
# 	Verify that unsharing the bitmap worked
# [OK]	outb to 0x80 worked
# 	Drop privileges
# [RUN]	disable 0x80
# [OK]	it worked
# [RUN]	enable 0x80 again
# [OK]	it failed
ok 30 selftests: x86: ioperm_64
# selftests: x86: test_vsyscall_64
# 	vsyscall map: ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
# 	vsyscall permissions are r-x
# [RUN]	test gettimeofday()
# 	vDSO time offsets: 0.000011 0.000003
# [OK]	vDSO gettimeofday()'s timeval was okay
# 	vsyscall time offsets: 0.000013 0.000001
# [OK]	vsyscall gettimeofday()'s timeval was okay
# [RUN]	test time()
# [OK]	vDSO time() is okay
# [OK]	vsyscall time() is okay
# [RUN]	getcpu() on CPU 0
# [OK]	vDSO reported correct CPU
# [OK]	vDSO reported correct node
# [OK]	vsyscall reported correct CPU
# [OK]	vsyscall reported correct node
# [RUN]	getcpu() on CPU 1
# [OK]	vDSO reported correct CPU
# [OK]	vDSO reported correct node
# [OK]	vsyscall reported correct CPU
# [OK]	vsyscall reported correct node
# [RUN]	Checking read access to the vsyscall page
# [OK]	We have read access
# [RUN]	process_vm_readv() from vsyscall page
# [OK]	It worked and read correct data
# [RUN]	checking that vsyscalls are emulated
# [OK]	vsyscalls are emulated (1 instructions in vsyscall page)
ok 31 selftests: x86: test_vsyscall_64
# selftests: x86: mov_ss_trap_64
# 	SS = 0x2b, &SS = 0x0x4041a8
# 	PR_SET_PTRACER_ANY succeeded
# 	Set up a watchpoint
# 	DR0 = 4041a8, DR1 = 401358, DR7 = 7000a
# 	SS = 0x2b, &SS = 0x0x4041a8
# 	PR_SET_PTRACER_ANY succeeded
# 	Set up a watchpoint
# [RUN]	Read from watched memory (should get SIGTRAP)
# 	Got SIGTRAP with RIP=4011e8, EFLAGS.RF=0
# [RUN]	MOV SS; INT3
# 	Got SIGTRAP with RIP=4011fb, EFLAGS.RF=0
# [RUN]	MOV SS; INT 3
# 	Got SIGTRAP with RIP=40120f, EFLAGS.RF=0
# [RUN]	MOV SS; CS CS INT3
# 	Got SIGTRAP with RIP=401224, EFLAGS.RF=0
# [RUN]	MOV SS; CSx14 INT3
# 	Got SIGTRAP with RIP=401245, EFLAGS.RF=0
# [RUN]	MOV SS; INT 4
# 	Got SIGSEGV with RIP=40126f
# [RUN]	MOV SS; ICEBP
# 	Got SIGTRAP with RIP=4012ad, EFLAGS.RF=0
# [RUN]	MOV SS; CLI
# 	Got SIGSEGV with RIP=4015b9
# [RUN]	MOV SS; #PF
# 	Got SIGSEGV with RIP=401584
# [RUN]	MOV SS; INT 1
# 	Got SIGSEGV with RIP=401555
# [RUN]	MOV SS; SYSCALL
# [RUN]	MOV SS; breakpointed NOP
# 	Got SIGTRAP with RIP=401359, EFLAGS.RF=0
# [RUN]	MOV SS; SYSENTER
# 	Got SIGSEGV with RIP=e4b89549
# [RUN]	MOV SS; INT $0x80
# [OK]	I aten't dead
ok 32 selftests: x86: mov_ss_trap_64
# selftests: x86: syscall_arg_fault_64
# [RUN]	SYSENTER with invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with invalid state
# [OK]	SYSCALL returned normally
# [RUN]	SYSENTER with TF and invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with TF and invalid state
# [OK]	SYSCALL returned normally
# [RUN]	SYSENTER with TF, invalid state, and GSBASE < 0
# [OK]	Seems okay
ok 33 selftests: x86: syscall_arg_fault_64
# selftests: x86: fsgsbase_restore_64
# fsgsbase_restore_64: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0x4075c000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child GS=0x7, GSBASE=0x4075c000
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 34 selftests: x86: fsgsbase_restore_64 # exit=1
# selftests: x86: sigaltstack_64
# [RUN]	Test an alternate signal stack of sufficient size.
# 	Raise SIGALRM. It is expected to be delivered.
# [OK]	SIGALRM signal delivered.
ok 35 selftests: x86: sigaltstack_64
# selftests: x86: fsgsbase_64
# [OK]	GSBASE started at 1
# [RUN]	Set GS = 0x7, read GSBASE
# [OK]	GSBASE reads as 0x1 with invalid GS
# 	FSGSBASE instructions are enabled
# [RUN]	ARCH_SET_GS to 0x0
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x1
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x200000000
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x0
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x200000000
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x1
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs and schedule 
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs and schedule 
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs and schedule 
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread
# 	using LDT slot 0
# [OK]	GSBASE remained 0
# [RUN]	GS = 0x0, GSBASE = 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x0, GSBASE = 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x0, GSBASE = 0x200000000
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x0, GSBASE = 0xffffffffffffffff
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x2b, GSBASE = 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x2b, GSBASE = 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x2b, GSBASE = 0x200000000
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [RUN]	GS = 0x2b, GSBASE = 0xffffffffffffffff
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	Index and base were preserved
# [OK]	GS remained 0x7 and GSBASE changed to 0xFF
ok 36 selftests: x86: fsgsbase_64
# selftests: x86: sysret_rip_64
# [RUN]	sigreturn to 0x800000000000
# [OK]	Got SIGSEGV at RIP=0x800000000000
# [RUN]	sigreturn to 0x1000000000000
# [OK]	Got SIGSEGV at RIP=0x1000000000000
# [RUN]	sigreturn to 0x2000000000000
# [OK]	Got SIGSEGV at RIP=0x2000000000000
# [RUN]	sigreturn to 0x4000000000000
# [OK]	Got SIGSEGV at RIP=0x4000000000000
# [RUN]	sigreturn to 0x8000000000000
# [OK]	Got SIGSEGV at RIP=0x8000000000000
# [RUN]	sigreturn to 0x10000000000000
# [OK]	Got SIGSEGV at RIP=0x10000000000000
# [RUN]	sigreturn to 0x20000000000000
# [OK]	Got SIGSEGV at RIP=0x20000000000000
# [RUN]	sigreturn to 0x40000000000000
# [OK]	Got SIGSEGV at RIP=0x40000000000000
# [RUN]	sigreturn to 0x80000000000000
# [OK]	Got SIGSEGV at RIP=0x80000000000000
# [RUN]	sigreturn to 0x100000000000000
# [OK]	Got SIGSEGV at RIP=0x100000000000000
# [RUN]	sigreturn to 0x200000000000000
# [OK]	Got SIGSEGV at RIP=0x200000000000000
# [RUN]	sigreturn to 0x400000000000000
# [OK]	Got SIGSEGV at RIP=0x400000000000000
# [RUN]	sigreturn to 0x800000000000000
# [OK]	Got SIGSEGV at RIP=0x800000000000000
# [RUN]	sigreturn to 0x1000000000000000
# [OK]	Got SIGSEGV at RIP=0x1000000000000000
# [RUN]	sigreturn to 0x2000000000000000
# [OK]	Got SIGSEGV at RIP=0x2000000000000000
# [RUN]	sigreturn to 0x4000000000000000
# [OK]	Got SIGSEGV at RIP=0x4000000000000000
# [RUN]	sigreturn to 0x8000000000000000
# [OK]	Got SIGSEGV at RIP=0x8000000000000000
# [RUN]	Trying a SYSCALL that falls through to 0x7fffffffe000
# [OK]	We survived
# [RUN]	Trying a SYSCALL that falls through to 0x7ffffffff000
# [OK]	We survived
# [RUN]	Trying a SYSCALL that falls through to 0x800000000000
# [OK]	mremap to 0x7ffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xfffffffff000
# [OK]	mremap to 0xffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1000000000000
# [OK]	mremap to 0xfffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1fffffffff000
# [OK]	mremap to 0x1ffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x2000000000000
# [OK]	mremap to 0x1fffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3fffffffff000
# [OK]	mremap to 0x3ffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x4000000000000
# [OK]	mremap to 0x3fffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7fffffffff000
# [OK]	mremap to 0x7ffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x8000000000000
# [OK]	mremap to 0x7fffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xffffffffff000
# [OK]	mremap to 0xfffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x10000000000000
# [OK]	mremap to 0xffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1ffffffffff000
# [OK]	mremap to 0x1fffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x20000000000000
# [OK]	mremap to 0x1ffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3ffffffffff000
# [OK]	mremap to 0x3fffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x40000000000000
# [OK]	mremap to 0x3ffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7ffffffffff000
# [OK]	mremap to 0x7fffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x80000000000000
# [OK]	mremap to 0x7ffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xfffffffffff000
# [OK]	mremap to 0xffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x100000000000000
# [OK]	mremap to 0xfffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1fffffffffff000
# [OK]	mremap to 0x1ffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x200000000000000
# [OK]	mremap to 0x1fffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3fffffffffff000
# [OK]	mremap to 0x3ffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x400000000000000
# [OK]	mremap to 0x3fffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7fffffffffff000
# [OK]	mremap to 0x7ffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x800000000000000
# [OK]	mremap to 0x7fffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xffffffffffff000
# [OK]	mremap to 0xfffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1000000000000000
# [OK]	mremap to 0xffffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1ffffffffffff000
# [OK]	mremap to 0x1fffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x2000000000000000
# [OK]	mremap to 0x1ffffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3ffffffffffff000
# [OK]	mremap to 0x3fffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x4000000000000000
# [OK]	mremap to 0x3ffffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7ffffffffffff000
# [OK]	mremap to 0x7fffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x8000000000000000
# [OK]	mremap to 0x7ffffffffffff000 failed
ok 37 selftests: x86: sysret_rip_64
# selftests: x86: syscall_numbering_64
# [RUN]   Checking for x32 by calling x32 getpid()
# [INFO]      x32 is not supported
# [RUN]   Running tests without ptrace...
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: just stop, no data read
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: only getregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: getregs, unmodified setregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
#
not ok 38 selftests: x86: syscall_numbering_64 # TIMEOUT 300 seconds
# selftests: x86: corrupt_xstate_header_64
# [RUN]	Send ourselves a signal
# 	Wreck XSTATE header
# 	Got SIGSEGV
# [OK]	Back from the signal.  Now schedule.
# [RUN]	Send ourselves a signal
# 	Wreck XSTATE header
# 	Got SIGSEGV
# [OK]	Back from the signal.  Now schedule.
# [OK]	Back in the main thread.
ok 39 selftests: x86: corrupt_xstate_header_64
# selftests: x86: amx_64
# amx_64: [FAIL]	xstate cpuid: invalid tile data size/offset: 0/0: Success
not ok 40 selftests: x86: amx_64 # exit=1
# selftests: x86: ldt_gdt_64
# [NOTE]	set_thread_area is available; will use GDT index 12
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 0 is invalid
# [NOTE]	set_thread_area is available; will use GDT index 12
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	Child succeeded
# [RUN]	Test size
# [DONE]	Size test
# [OK]	modify_ldt failure 22
# [OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
# [OK]	LDT entry 0 is invalid
# [OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
# [OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 is invalid
# [RUN]	Cross-CPU LDT invalidation
# [OK]	All 5 iterations succeeded
# [RUN]	Test exec
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
# [OK]	Child succeeded
# [OK]	Invalidate DS with set_thread_area: new DS = 0x0
# [OK]	Invalidate ES with set_thread_area: new ES = 0x0
# [OK]	Invalidate FS with set_thread_area: new FS = 0x0
# [OK]	New FSBASE was zero
# [OK]	Invalidate GS with set_thread_area: new GS = 0x0
# [OK]	New GSBASE was zero
ok 41 selftests: x86: ldt_gdt_64
# selftests: x86: ptrace_syscall_64
# ptrace_syscall_64: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0x7f424c815989)
not ok 42 selftests: x86: ptrace_syscall_64 # exit=1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d216de19c8dd97fb6b0eac84fce4362489a61b2e/tools/testing/selftests/x86'

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/kernel-selftests-x86.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: x86
kernel_cmdline: erst_disable
job_origin: kernel-selftests-x86.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-kbl-d01
tbox_group: lkp-kbl-d01
submit_id: 626c3eea3b130d094b0febc3
job_file: "/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-x86-ucode=0xec-debian-10.4-x86_64-20200603.cgz-d216de19c8dd97fb6b0eac84fce4362489a61b2e-20220430-2379-116narc-0.yaml"
id: a3ffdbe4ec321fe7575832799f6228f8f95f3e0c
queuer_version: "/zday/lkp"
:#! hosts/lkp-kbl-d01:
model: Kaby Lake
nr_node: 1
nr_cpu: 8
memory: 32G
nr_sdd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part1"
brand: Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/queue/cyclic:
commit: d216de19c8dd97fb6b0eac84fce4362489a61b2e
:#! include/testbox/lkp-kbl-d01:
ucode: '0xec'
need_kconfig_hw:
- E1000E: y
- SATA_AHCI
bisect_dmesg: true
:#! include/kernel-selftests:
need_kconfig:
- POSIX_TIMERS: y, v4.10-rc1
initrds:
- linux_headers
- linux_selftests
enqueue_time: 2022-04-30 03:39:22.671235331 +08:00
_id: 626c3eea3b130d094b0febc3
_rt: "/result/kernel-selftests/x86-ucode=0xec/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 0ae1f1c5893c8eecea0fcc669a620cab08b41c23
base_commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
branch: linux-devel/devel-hourly-20220426-221600
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/x86-ucode=0xec/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/0"
scheduler_version: "/lkp/lkp/.src-20220429-091100"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/x86-ucode=0xec/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/vmlinuz-5.18.0-rc1-00009-gd216de19c8dd
- branch=linux-devel/devel-hourly-20220426-221600
- job=/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-x86-ucode=0xec-debian-10.4-x86_64-20200603.cgz-d216de19c8dd97fb6b0eac84fce4362489a61b2e-20220430-2379-116narc-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=d216de19c8dd97fb6b0eac84fce4362489a61b2e
- erst_disable
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20220425.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-f6559bea-1_20220425.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220427173243/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.17.0-12882-g1930a6e739c4
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/d216de19c8dd97fb6b0eac84fce4362489a61b2e/vmlinuz-5.18.0-rc1-00009-gd216de19c8dd"
dequeue_time: 2022-04-30 05:07:51.621749667 +08:00
:#! /cephfs/db/releases/20220429090705/lkp-src/include/site/inn:
job_state: finished
loadavg: 1.44 1.11 0.55 1/160 3433
start_time: '1651266564'
end_time: '1651266879'
version: "/lkp/lkp/.src-20220429-091139:9065bbd9:99fe93bc4"

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C x86
make run_tests -C x86

--qjNfmADvan18RZcF--
