Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5051776B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387127AbiEBT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387115AbiEBT3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:29:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5EE9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651519563; x=1683055563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TLQwYvUh2emZcG1QiacxyOQw0imsql/KvQt4WJgss64=;
  b=KBapwNOpj+0advABIVjXZDOcZxljIkZLEOYKbd6JCqKqsJ2yfQcBgS6V
   DO4m6wGQrzy+SCThBOvEutkkWNNxhpyBQ1unJEQnLzr1YaOZailRXkqEw
   3b//XyMOtak42WQkUnktiqVrCJLGqgfMpKFAJco7IrQhhb8tspf3lx4vU
   3KRQbBGWHIvsaPprn2EOZl2Ly6QQTIFsFejPfxJxm0vbG0gDEr3RdnGws
   Vua/OTCAQFRx1zh0V6Mg6biLfbK8Kd4n1CadnDp9GcPV9YkD42OaXbz65
   iUcgX7TOG4Iun09nFI7U1HORLJsuVvm0wvm9cesQmeFBAw2QGV30sm6sY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330301656"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="330301656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 12:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="652957378"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2022 12:26:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlbgF-0009oF-CP;
        Mon, 02 May 2022 19:25:59 +0000
Date:   Tue, 3 May 2022 03:25:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Hackmann <ghackmann@android.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tri Vo <trong@android.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>, Sean Paul <seanpaul@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 9206/9999]
 kernel/gcov/gcc_4_7.c:162:16: error: implicit declaration of function
 'within_module'; did you mean 'init_module'?
Message-ID: <202205030344.m2V8BrTm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 35be48648a6552869bd5d6c9a0d278102d23d46c [9206/9999] UPSTREAM: gcov: clang support
config: powerpc64-randconfig-m031-20220501 (https://download.01.org/0day-ci/archive/20220503/202205030344.m2V8BrTm-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/35be48648a6552869bd5d6c9a0d278102d23d46c
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 35be48648a6552869bd5d6c9a0d278102d23d46c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash M=kernel/gcov

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/hw_irq.h:64,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/linux/spinlock.h:54,
                    from arch/powerpc/kernel/prom.c:23:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
   arch/powerpc/kernel/prom.c: In function 'early_reserve_mem':
>> arch/powerpc/kernel/prom.c:615:17: error: variable 'reserve_map' set but not used [-Werror=unused-but-set-variable]
     615 |         __be64 *reserve_map;
         |                 ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from arch/powerpc/kernel/setup_64.c:15:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
>> arch/powerpc/kernel/setup_64.c:266:13: error: no previous prototype for 'record_spr_defaults' [-Werror=missing-prototypes]
     266 | void __init record_spr_defaults(void)
         |             ^~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/setup_64.c:291:13: error: no previous prototype for 'early_setup' [-Werror=missing-prototypes]
     291 | void __init early_setup(unsigned long dt_ptr)
         |             ^~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:379:6: error: no previous prototype for 'early_setup_secondary' [-Werror=missing-prototypes]
     379 | void early_setup_secondary(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:397:6: error: no previous prototype for 'panic_smp_self_stop' [-Werror=missing-prototypes]
     397 | void panic_smp_self_stop(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
   arch/powerpc/kernel/setup_64.c:574:70: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
     574 |                         DBG("Argh, can't find dcache properties !\n");
         |                                                                      ^
   arch/powerpc/kernel/setup_64.c:577:70: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
     577 |                         DBG("Argh, can't find icache properties !\n");
         |                                                                      ^
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from arch/powerpc/kernel/sys_ppc32.c:18:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
>> arch/powerpc/kernel/sys_ppc32.c:55:15: error: no previous prototype for 'compat_sys_mmap2' [-Werror=missing-prototypes]
      55 | unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
         |               ^~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:68:16: error: no previous prototype for 'compat_sys_pread64' [-Werror=missing-prototypes]
      68 | compat_ssize_t compat_sys_pread64(unsigned int fd, char __user *ubuf, compat_size_t count,
         |                ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:74:16: error: no previous prototype for 'compat_sys_pwrite64' [-Werror=missing-prototypes]
      74 | compat_ssize_t compat_sys_pwrite64(unsigned int fd, const char __user *ubuf, compat_size_t count,
         |                ^~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:80:16: error: no previous prototype for 'compat_sys_readahead' [-Werror=missing-prototypes]
      80 | compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 count)
         |                ^~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:85:16: error: no previous prototype for 'compat_sys_truncate64' [-Werror=missing-prototypes]
      85 | asmlinkage int compat_sys_truncate64(const char __user * path, u32 reg4,
         |                ^~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:91:17: error: no previous prototype for 'compat_sys_fallocate' [-Werror=missing-prototypes]
      91 | asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:98:16: error: no previous prototype for 'compat_sys_ftruncate64' [-Werror=missing-prototypes]
      98 | asmlinkage int compat_sys_ftruncate64(unsigned int fd, u32 reg4, unsigned long high,
         |                ^~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:104:6: error: no previous prototype for 'ppc32_fadvise64' [-Werror=missing-prototypes]
     104 | long ppc32_fadvise64(int fd, u32 unused, u32 offset_high, u32 offset_low,
         |      ^~~~~~~~~~~~~~~
>> arch/powerpc/kernel/sys_ppc32.c:111:17: error: no previous prototype for 'compat_sys_sync_file_range2' [-Werror=missing-prototypes]
     111 | asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/smp.h:28,
                    from include/linux/smp.h:64,
                    from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/vtime.h:5,
                    from include/linux/hardirq.h:8,
                    from arch/powerpc/kernel/mce.c:25:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
   arch/powerpc/kernel/mce.c: In function 'machine_process_ue_event':
   arch/powerpc/kernel/mce.c:260:37: error: variable 'evt' set but not used [-Werror=unused-but-set-variable]
     260 |         struct machine_check_event *evt;
         |                                     ^~~
   arch/powerpc/kernel/mce.c: At top level:
>> arch/powerpc/kernel/mce.c:487:6: error: no previous prototype for 'machine_check_early' [-Werror=missing-prototypes]
     487 | long machine_check_early(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/mce.c:606:6: error: no previous prototype for 'hmi_exception_realmode' [-Werror=missing-prototypes]
     606 | long hmi_exception_realmode(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/sched/mm.h:7,
                    from arch/powerpc/kernel/smp.c:22:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
   arch/powerpc/kernel/smp.c:445:5: error: no previous prototype for '__smp_send_nmi_ipi' [-Werror=missing-prototypes]
     445 | int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool safe)
         |     ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/smp.c:521:6: error: no previous prototype for 'tick_broadcast' [-Werror=missing-prototypes]
     521 | void tick_broadcast(const struct cpumask *mask)
         |      ^~~~~~~~~~~~~~
>> arch/powerpc/kernel/smp.c:531:6: error: no previous prototype for 'debugger_ipi_callback' [-Werror=missing-prototypes]
     531 | void debugger_ipi_callback(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/smp.c:1062:5: error: no previous prototype for 'setup_profiling_timer' [-Werror=missing-prototypes]
    1062 | int setup_profiling_timer(unsigned int multiplier)
         |     ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/hw_irq.h:64,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/linux/rcupdate.h:39,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from arch/powerpc/xmon/xmon.c:16:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
   In file included from arch/powerpc/xmon/xmon.c:67:
   arch/powerpc/xmon/dis-asm.h: In function 'print_insn_powerpc':
   arch/powerpc/xmon/dis-asm.h:20:20: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
      20 |         printf("%.8x", insn);
         |                 ~~~^   ~~~~
         |                    |   |
         |                    |   long unsigned int
         |                    unsigned int
         |                 %.8lx
   arch/powerpc/xmon/dis-asm.h: In function 'print_insn_spu':
   arch/powerpc/xmon/dis-asm.h:26:20: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
      26 |         printf("%.8x", insn);
         |                 ~~~^   ~~~~
         |                    |   |
         |                    |   long unsigned int
         |                    unsigned int
         |                 %.8lx
   arch/powerpc/xmon/xmon.c: At top level:
   arch/powerpc/xmon/xmon.c:2993:6: error: no previous prototype for 'format_pte' [-Werror=missing-prototypes]
    2993 | void format_pte(void *ptep, unsigned long pte)
         |      ^~~~~~~~~~
   arch/powerpc/xmon/xmon.c:3968:1: error: no previous prototype for 'spu_inst_dump' [-Werror=missing-prototypes]
    3968 | spu_inst_dump(unsigned long adr, long count, int praddr)
         | ^~~~~~~~~~~~~
   arch/powerpc/xmon/xmon.c: In function 'do_spu_cmd':
   arch/powerpc/xmon/xmon.c:4030:38: error: this statement may fall through [-Werror=implicit-fallthrough=]
    4030 |                 if (isxdigit(subcmd) || subcmd == '\n')
   arch/powerpc/xmon/xmon.c:4032:9: note: here
    4032 |         case 'f':
         |         ^~~~
   arch/powerpc/xmon/xmon.c: In function 'xmon_print_symbol':
   arch/powerpc/xmon/xmon.c:3423:21: error: variable 'name' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    3423 |         const char *name = NULL;
         |                     ^~~~
   arch/powerpc/xmon/xmon.c: In function 'stop_spus':
>> arch/powerpc/xmon/xmon.c:3836:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    3836 |         int i;
         |             ^
   arch/powerpc/xmon/xmon.c: In function 'restart_spus':
   arch/powerpc/xmon/xmon.c:3877:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    3877 |         int i;
         |             ^
   arch/powerpc/xmon/xmon.c: In function 'show_pte':
   arch/powerpc/xmon/xmon.c:3009:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    3009 |         struct task_struct *tsk = NULL;
         |                             ^~~
   arch/powerpc/xmon/xmon.c: In function 'show_tasks':
   arch/powerpc/xmon/xmon.c:3105:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    3105 |         struct task_struct *tsk = NULL;
         |                             ^~~
   arch/powerpc/xmon/xmon.c: In function 'xmon_core':
   arch/powerpc/xmon/xmon.c:800:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
     800 |         struct bpt *bp;
         |                     ^~
   arch/powerpc/xmon/xmon.c:800:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
   arch/powerpc/xmon/xmon.c:454:48: error: argument 'fromipi' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
     454 | static int xmon_core(struct pt_regs *regs, int fromipi)
         |                                            ~~~~^~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:30,
                    from arch/powerpc/include/asm/mmu.h:313,
                    from arch/powerpc/include/asm/lppaca.h:36,
                    from arch/powerpc/include/asm/paca.h:21,
                    from arch/powerpc/include/asm/hw_irq.h:64,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/linux/spinlock.h:54,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from kernel/gcov/gcc_4_7.c:16:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1275:15: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    1275 | static inline const int pud_pfn(pud_t pud)
         |               ^~~~~
   kernel/gcov/gcc_4_7.c: In function 'gcov_info_within_module':
>> kernel/gcov/gcc_4_7.c:162:16: error: implicit declaration of function 'within_module'; did you mean 'init_module'? [-Werror=implicit-function-declaration]
     162 |         return within_module((unsigned long)info, mod);
         |                ^~~~~~~~~~~~~
         |                init_module
   cc1: some warnings being treated as errors


vim +162 kernel/gcov/gcc_4_7.c

   152	
   153	/**
   154	 * gcov_info_within_module - check if a profiling data set belongs to a module
   155	 * @info: profiling data set
   156	 * @mod: module
   157	 *
   158	 * Returns true if profiling data belongs module, false otherwise.
   159	 */
   160	bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
   161	{
 > 162		return within_module((unsigned long)info, mod);
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
