Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D5E50B1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444926AbiDVHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444917AbiDVHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:41:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8655517C5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650613100; x=1682149100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eijWZD7LJaEboDx12Q6KLW7MA0IObAmM5VxqQPJaGoY=;
  b=BNoJNXaoMWWT/wKp3Q0Wcm3W/WnXe4b48e9spziofpF12JvqKnU8byEV
   CK9vqwHoSIT6YhuiBbm1CwVzthoel+6ScjE9yRTDFWhbLSIk0B6YruPNW
   FsjFdnkL0OxsjCDj/nFrX4CCvSC+IXGPChy/3B1ICnUB5ToTJ3JBjGJUx
   YN9JVNn+Ipb2OK5qemGen+X2pNzc0HQlTuq2iyUlAU+yS/6CxJvqqAdge
   HzxWR278lkFdkCtfVEQqBfSZMo6a+3OkVQ6dgqTc6VgSfQaipYdK0lpSa
   jpl4k1/jL1neOdJTW82JNkRHfk/f0Sh7SbhLj68/gWsED3BtBo20MxcBF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325058467"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="325058467"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 00:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="626890028"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2022 00:38:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhnru-0009tq-3E;
        Fri, 22 Apr 2022 07:38:18 +0000
Date:   Fri, 22 Apr 2022 15:38:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/4] include/linux/kallsyms.h:108:1: error:
 expected identifier or '(' before '{' token
Message-ID: <202204221518.ImffIvWW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   8662f5dbc769bcb2fa646ceaaf6f6878ef569c64
commit: 6f0f4c96dd360f51da70699617458f21f33f8cbb [1/4] fprobe: Add ftrace_lookup_symbols function
config: h8300-randconfig-r032-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221518.ImffIvWW-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=6f0f4c96dd360f51da70699617458f21f33f8cbb
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 6f0f4c96dd360f51da70699617458f21f33f8cbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/linux/fb.h:6,
                    from include/drm/drm_crtc.h:31,
                    from include/drm/drm_atomic.h:31,
                    from drivers/gpu/drm/tidss/tidss_crtc.c:7:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from init/main.c:21:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from init/main.c:21:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/h8300/kernel/signal.c:32:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   arch/h8300/kernel/signal.c:105:16: warning: no previous prototype for 'sys_rt_sigreturn' [-Wmissing-prototypes]
     105 | asmlinkage int sys_rt_sigreturn(void)
         |                ^~~~~~~~~~~~~~~~
   arch/h8300/kernel/signal.c:280:17: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     280 | asmlinkage void do_notify_resume(struct pt_regs *regs, u32 thread_info_flags)
         |                 ^~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/h8300/kernel/signal.c:32:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/fork.c:55:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     163 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:853:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     853 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:948:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     948 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/fork.c:55:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   kernel/panic.c:577:6: warning: no previous prototype for '__warn' [-Wmissing-prototypes]
     577 | void __warn(const char *file, int line, void *caller, unsigned taint,
         |      ^~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:591:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     591 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:614:6: warning: no previous prototype for 'warn_slowpath_fmt' [-Wmissing-prototypes]
     614 | void warn_slowpath_fmt(const char *file, int line, unsigned taint,
         |      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   kernel/exit.c:1814:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1814 | __weak void abort(void)
         |             ^~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/audit.c:44:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   kernel/audit.c:1815:14: warning: no previous prototype for 'audit_serial' [-Wmissing-prototypes]
    1815 | unsigned int audit_serial(void)
         |              ^~~~~~~~~~~~
   kernel/audit.c: In function 'audit_log_vformat':
   kernel/audit.c:1965:9: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1965 |         len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
         |         ^~~
   kernel/audit.c:1974:17: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1974 |                 len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
         |                 ^~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/audit.c:44:
   kernel/audit.c: At top level:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from mm/nommu.c:35:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   In file included from arch/h8300/include/asm/page.h:5,
                    from arch/h8300/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/h8300/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from mm/nommu.c:20:
   mm/nommu.c: In function 'kobjsize':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   mm/nommu.c:80:23: note: in expansion of macro 'virt_addr_valid'
      80 |         if (!objp || !virt_addr_valid(objp))
         |                       ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from mm/nommu.c:35:
   mm/nommu.c: At top level:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from mm/page_alloc.c:70:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   In file included from include/linux/bits.h:22,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:10,
                    from include/asm-generic/bug.h:22,
                    from arch/h8300/include/asm/bug.h:8,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/page_alloc.c:19:
   mm/page_alloc.c: In function 'free_pages':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
      30 | #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
         |                                                               ^
   mm/page_alloc.c:5503:17: note: in expansion of macro 'VM_BUG_ON'
    5503 |                 VM_BUG_ON(!virt_addr_valid((void *)addr));
         |                 ^~~~~~~~~
   mm/page_alloc.c:5503:28: note: in expansion of macro 'virt_addr_valid'
    5503 |                 VM_BUG_ON(!virt_addr_valid((void *)addr));
         |                            ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from mm/page_alloc.c:70:
   mm/page_alloc.c: At top level:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/slab.c:102:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   In file included from arch/h8300/include/asm/page.h:5,
                    from arch/h8300/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/h8300/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from mm/slab.c:90:
   mm/slab.c: In function 'kfree_debugcheck':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   mm/slab.c:2670:14: note: in expansion of macro 'virt_addr_valid'
    2670 |         if (!virt_addr_valid(objp)) {
         |              ^~~~~~~~~~~~~~~
   In file included from mm/slab.c:102:
   mm/slab.c: At top level:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/d_path.c:2:
>> include/linux/kallsyms.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
   fs/d_path.c:318:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/d_path.c:2:
   include/linux/kallsyms.h:107:19: warning: 'ftrace_lookup_symbols' declared 'static' but never defined [-Wunused-function]
     107 | static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
         |                   ^~~~~~~~~~~~~~~~~~~~~
..


vim +108 include/linux/kallsyms.h

   106	
   107	static inline int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs);
 > 108	{
   109		return -ERANGE;
   110	}
   111	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
