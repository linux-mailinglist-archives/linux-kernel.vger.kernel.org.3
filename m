Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB44483C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiADHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:21:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:34344 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbiADHVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641280902; x=1672816902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5FIn506eHFKpCF5uJ02hmJgCQSKXvEEwXs8p8LQOBzQ=;
  b=PXtDK6OdOWUQFpJ1/tYTQ9Cnc2F0yWrJAW3S0VqDP5DAE2unlZLxULUs
   W1PrWpc0ccKzHD2HI0/tngMppAlgzjNrJ2hzOH/F8GH4KnEksU9CDl4pU
   Ho3Nf4pEWDuuF56AAS8FVZTdOvbH6w8n0HoclVfZa94ONUXM9B7Zh0k+L
   2i95Rgu7rX5qBA4TNax/J04cAzhpKCsvB2jb3fnxcrVRvbsxpXw2nTMbv
   TAO41R9RCn9FTF8CbgQ+bNrny4JsQnLj2GZ3VVxD9O18q8aGce86XNpmw
   QWY1Qv2UvKN1t3Zbn2+CbZlP0+NJ40COoSNVVuKAxosyOgMMQg/b6Fmks
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222165722"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="222165722"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 23:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="610985212"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2022 23:21:36 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4e8V-000EzU-Ds; Tue, 04 Jan 2022 07:21:35 +0000
Date:   Tue, 4 Jan 2022 15:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 4/14] include/linux/kprobes.h:77:21: error:
 field 'ops' has incomplete type
Message-ID: <202201041521.a4yJyq96-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   27d253a29de023f664387fcc049edeeaadf23c8e
commit: fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d [4/14] kprobe: Add support to register multiple ftrace kprobes
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220104/202201041521.a4yJyq96-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/nmi_backtrace.c:18:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
--
   In file included from arch/x86/kernel/kprobes/core.c:29:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   arch/x86/kernel/kprobes/core.c:1081:23: warning: no previous prototype for 'trampoline_handler' [-Wmissing-prototypes]
    1081 | __used __visible void trampoline_handler(struct pt_regs *regs)
         |                       ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kgdb.h:19,
                    from include/linux/fb.h:6,
                    from include/linux/backlight.h:13,
                    from drivers/acpi/acpi_video.c:19:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   drivers/acpi/acpi_video.c:2259:6: warning: no previous prototype for 'acpi_video_unregister_backlight' [-Wmissing-prototypes]
    2259 | void acpi_video_unregister_backlight(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kgdb.h:19,
                    from include/linux/fb.h:6,
                    from include/linux/backlight.h:13,
                    from drivers/acpi/video_detect.c:30:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   drivers/acpi/video_detect.c:532:13: warning: no previous prototype for 'acpi_video_detect_exit' [-Wmissing-prototypes]
     532 | void __exit acpi_video_detect_exit(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from init/main.c:36:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   init/main.c:780:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     780 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
--
   In file included from arch/x86/include/asm/traps.h:6,
                    from arch/x86/entry/common.c:29:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   arch/x86/entry/common.c:119:24: warning: no previous prototype for 'do_int80_syscall_32' [-Wmissing-prototypes]
     119 | __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:186:24: warning: no previous prototype for 'do_fast_syscall_32' [-Wmissing-prototypes]
     186 | __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:238:24: warning: no previous prototype for 'do_SYSENTER_32' [-Wmissing-prototypes]
     238 | __visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~
--
   In file included from arch/x86/include/asm/traps.h:6,
                    from arch/x86/kernel/doublefault_32.c:11:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   arch/x86/kernel/doublefault_32.c:23:36: warning: no previous prototype for 'doublefault_shim' [-Wmissing-prototypes]
      23 | asmlinkage noinstr void __noreturn doublefault_shim(void)
         |                                    ^~~~~~~~~~~~~~~~
   arch/x86/kernel/doublefault_32.c:114:6: warning: no previous prototype for 'doublefault_init_cpu_tss' [-Wmissing-prototypes]
     114 | void doublefault_init_cpu_tss(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/kallsyms.c:27:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   kernel/kallsyms.c:586:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     586 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
--
   In file included from kernel/kprobes.c:23:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   kernel/kprobes.c: In function 'check_addr':
>> kernel/kprobes.c:1721:10: error: implicit declaration of function 'check_ftrace_multi'; did you mean 'check_ftrace_location'? [-Werror=implicit-function-declaration]
    1721 |   return check_ftrace_multi(p);
         |          ^~~~~~~~~~~~~~~~~~
         |          check_ftrace_location
   kernel/kprobes.c: In function '__unregister_kprobe_top':
>> kernel/kprobes.c:1916:3: error: implicit declaration of function 'free_ftrace_multi'; did you mean 'kprobe_ftrace_multi'? [-Werror=implicit-function-declaration]
    1916 |   free_ftrace_multi(ap);
         |   ^~~~~~~~~~~~~~~~~
         |   kprobe_ftrace_multi
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:588:3: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     588 |   vprintk(args->fmt, args->args);
         |   ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:682:24: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     682 | __visible noinstr void __stack_chk_fail(void)
         |                        ^~~~~~~~~~~~~~~~
--
   In file included from kernel/exit.c:66:
>> include/linux/kprobes.h:77:21: error: field 'ops' has incomplete type
      77 |   struct ftrace_ops ops;
         |                     ^~~
   kernel/exit.c:1817:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1817 | __weak void abort(void)
         |             ^~~~~
..


vim +/ops +77 include/linux/kprobes.h

    48	
    49	struct kprobe;
    50	struct pt_regs;
    51	struct kretprobe;
    52	struct kretprobe_instance;
    53	typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
    54	typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
    55					       unsigned long flags);
    56	typedef int (*kretprobe_handler_t) (struct kretprobe_instance *,
    57					    struct pt_regs *);
    58	
    59	struct kprobe {
    60		struct hlist_node hlist;
    61	
    62		/* list of kprobes for multi-handler support */
    63		struct list_head list;
    64	
    65		/*count the number of times this probe was temporarily disarmed */
    66		unsigned long nmissed;
    67	
    68		/* location of the probe point */
    69		kprobe_opcode_t *addr;
    70	
    71	#ifdef CONFIG_HAVE_KPROBES_MULTI_ON_FTRACE
    72		/* location of the multi probe points */
    73		struct {
    74			const char **symbols;
    75			kprobe_opcode_t **addrs;
    76			unsigned int cnt;
  > 77			struct ftrace_ops ops;
    78		} multi;
    79	#endif
    80	
    81		/* Allow user to indicate symbol name of the probe point */
    82		const char *symbol_name;
    83	
    84		/* Offset into the symbol */
    85		unsigned int offset;
    86	
    87		/* traced function address */
    88		unsigned long func_addr;
    89	
    90		/* Called before addr is executed. */
    91		kprobe_pre_handler_t pre_handler;
    92	
    93		/* Called after addr is executed, unless... */
    94		kprobe_post_handler_t post_handler;
    95	
    96		/* Saved opcode (which has been replaced with breakpoint) */
    97		kprobe_opcode_t opcode;
    98	
    99		/* copy of the original instruction */
   100		struct arch_specific_insn ainsn;
   101	
   102		/*
   103		 * Indicates various status flags.
   104		 * Protected by kprobe_mutex after this kprobe is registered.
   105		 */
   106		u32 flags;
   107	};
   108	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
