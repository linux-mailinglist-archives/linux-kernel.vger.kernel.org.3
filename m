Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19B48FEE7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 21:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiAPUyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 15:54:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:63161 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbiAPUyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 15:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642366457; x=1673902457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C6EpDHjiGIBLsUjAHJB1rdJXRWp1XJ6oH5Fltf1X5kI=;
  b=P+/akEIqjkJnD00x89x+npXfhA5YW2wGmPYqTdSDXwuzQ/Ro1L6Acp9p
   wnhA1HzY18saLAAZUEkmAoS1US//c4IHZJ7qjs4bJyEpele5qk1rjyUMs
   x4Zn8AzaY+qPXVWiKZ/+yyBRWL924p+Q7JuqntpbxQxdNMh33AJmQnSMZ
   c7Z5FJKyQK9bk5HVIHl6KxKUA949TDS0F1Q19zbaX6DhbZhtO9/NVi5rU
   vnybZXoeGEguxgFBpYI9zVdqlLWE8/g1YCJJEnXeic5Bg8XgxSCiU2T4G
   zvpdM9J3vp57fkZ9miMytgtF9dd1TOc1c1jNMIDYvkB/8pA+C7L44pOGW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224495331"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="224495331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 12:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="531083864"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2022 12:54:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9CXW-000Ayw-BZ; Sun, 16 Jan 2022 20:54:14 +0000
Date:   Mon, 17 Jan 2022 04:53:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2346/2384]
 arch/mips/kernel/traps.c:2368:13: warning: no previous prototype for
 function 'trap_init'
Message-ID: <202201170448.skJnFOLk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 24008668691ae54c991f8b1e65607d4065e14b7d [2346/2384] headers/deps: perf_event: Optimize <linux/perf_event_types.h> dependencies
config: mips-randconfig-c004-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170448.skJnFOLk-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=24008668691ae54c991f8b1e65607d4065e14b7d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 24008668691ae54c991f8b1e65607d4065e14b7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/alchemy/common/ arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   asmlinkage void do_cpu(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1418:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_cpu(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1523:17: warning: no previous prototype for function 'do_msa_fpe' [-Wmissing-prototypes]
   asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
                   ^
   arch/mips/kernel/traps.c:1523:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
              ^
              static 
   arch/mips/kernel/traps.c:1543:17: warning: no previous prototype for function 'do_msa' [-Wmissing-prototypes]
   asmlinkage void do_msa(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1543:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_msa(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1564:17: warning: no previous prototype for function 'do_mdmx' [-Wmissing-prototypes]
   asmlinkage void do_mdmx(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1564:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_mdmx(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1576:17: warning: no previous prototype for function 'do_watch' [-Wmissing-prototypes]
   asmlinkage void do_watch(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1576:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_watch(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1606:17: warning: variable 'prev_state' set but not used [-Wunused-but-set-variable]
           enum ctx_state prev_state;
                          ^
   arch/mips/kernel/traps.c:1603:17: warning: no previous prototype for function 'do_mcheck' [-Wmissing-prototypes]
   asmlinkage void do_mcheck(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1603:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_mcheck(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1628:17: warning: no previous prototype for function 'do_mt' [-Wmissing-prototypes]
   asmlinkage void do_mt(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1628:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_mt(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1664:17: warning: no previous prototype for function 'do_dsp' [-Wmissing-prototypes]
   asmlinkage void do_dsp(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1664:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_dsp(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1672:17: warning: no previous prototype for function 'do_reserved' [-Wmissing-prototypes]
   asmlinkage void do_reserved(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1672:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_reserved(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1848:17: warning: no previous prototype for function 'cache_parity_error' [-Wmissing-prototypes]
   asmlinkage void cache_parity_error(void)
                   ^
   arch/mips/kernel/traps.c:1848:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void cache_parity_error(void)
              ^
              static 
   arch/mips/kernel/traps.c:1896:17: warning: no previous prototype for function 'do_ftlb' [-Wmissing-prototypes]
   asmlinkage void do_ftlb(void)
                   ^
   arch/mips/kernel/traps.c:1896:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_ftlb(void)
              ^
              static 
   arch/mips/kernel/traps.c:1925:17: warning: no previous prototype for function 'do_gsexc' [-Wmissing-prototypes]
   asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
                   ^
   arch/mips/kernel/traps.c:1925:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
              ^
              static 
   arch/mips/kernel/traps.c:1960:6: warning: no previous prototype for function 'ejtag_exception_handler' [-Wmissing-prototypes]
   void ejtag_exception_handler(struct pt_regs *regs)
        ^
   arch/mips/kernel/traps.c:1960:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ejtag_exception_handler(struct pt_regs *regs)
   ^
   static 
   arch/mips/kernel/traps.c:2005:17: warning: no previous prototype for function 'nmi_exception_handler' [-Wmissing-prototypes]
   void __noreturn nmi_exception_handler(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:2005:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __noreturn nmi_exception_handler(struct pt_regs *regs)
   ^
   static 
>> arch/mips/kernel/traps.c:2368:13: warning: no previous prototype for function 'trap_init' [-Wmissing-prototypes]
   void __init trap_init(void)
               ^
   arch/mips/kernel/traps.c:2368:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init trap_init(void)
   ^
   static 
   22 warnings generated.


vim +/trap_init +2368 arch/mips/kernel/traps.c

5b10496b6e6577 Atsushi Nemoto      2006-09-11  2367  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @2368  void __init trap_init(void)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2369  {
2a0b24f56c2492 Steven J. Hill      2013-03-25  2370  	extern char except_vec3_generic;
^1da177e4c3f41 Linus Torvalds      2005-04-16  2371  	extern char except_vec4;
2a0b24f56c2492 Steven J. Hill      2013-03-25  2372  	extern char except_vec3_r4000;
172dcd935c34b0 Paul Burton         2019-04-30  2373  	unsigned long i, vec_size;
172dcd935c34b0 Paul Burton         2019-04-30  2374  	phys_addr_t ebase_pa;
c65a5480ff2919 Atsushi Nemoto      2007-11-12  2375  
c65a5480ff2919 Atsushi Nemoto      2007-11-12  2376  	check_wait();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2377  
172dcd935c34b0 Paul Burton         2019-04-30  2378  	if (!cpu_has_mips_r2_r6) {
172dcd935c34b0 Paul Burton         2019-04-30  2379  		ebase = CAC_BASE;
172dcd935c34b0 Paul Burton         2019-04-30  2380  		vec_size = 0x400;
172dcd935c34b0 Paul Burton         2019-04-30  2381  	} else {
172dcd935c34b0 Paul Burton         2019-04-30  2382  		if (cpu_has_veic || cpu_has_vint)
172dcd935c34b0 Paul Burton         2019-04-30  2383  			vec_size = 0x200 + VECTORSPACING*64;
172dcd935c34b0 Paul Burton         2019-04-30  2384  		else
172dcd935c34b0 Paul Burton         2019-04-30  2385  			vec_size = PAGE_SIZE;
172dcd935c34b0 Paul Burton         2019-04-30  2386  
172dcd935c34b0 Paul Burton         2019-04-30  2387  		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
f995adb0ac5bcf Paul Burton         2019-04-30  2388  		if (!ebase_pa)
8a7f97b902f4fb Mike Rapoport       2019-03-11  2389  			panic("%s: Failed to allocate %lu bytes align=0x%x\n",
172dcd935c34b0 Paul Burton         2019-04-30  2390  			      __func__, vec_size, 1 << fls(vec_size));
c195e079e9dd00 James Hogan         2016-09-01  2391  
c195e079e9dd00 James Hogan         2016-09-01  2392  		/*
c195e079e9dd00 James Hogan         2016-09-01  2393  		 * Try to ensure ebase resides in KSeg0 if possible.
c195e079e9dd00 James Hogan         2016-09-01  2394  		 *
c195e079e9dd00 James Hogan         2016-09-01  2395  		 * It shouldn't generally be in XKPhys on MIPS64 to avoid
c195e079e9dd00 James Hogan         2016-09-01  2396  		 * hitting a poorly defined exception base for Cache Errors.
c195e079e9dd00 James Hogan         2016-09-01  2397  		 * The allocation is likely to be in the low 512MB of physical,
c195e079e9dd00 James Hogan         2016-09-01  2398  		 * in which case we should be able to convert to KSeg0.
c195e079e9dd00 James Hogan         2016-09-01  2399  		 *
c195e079e9dd00 James Hogan         2016-09-01  2400  		 * EVA is special though as it allows segments to be rearranged
c195e079e9dd00 James Hogan         2016-09-01  2401  		 * and to become uncached during cache error handling.
c195e079e9dd00 James Hogan         2016-09-01  2402  		 */
c195e079e9dd00 James Hogan         2016-09-01  2403  		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
c195e079e9dd00 James Hogan         2016-09-01  2404  			ebase = CKSEG0ADDR(ebase_pa);
f995adb0ac5bcf Paul Burton         2019-04-30  2405  		else
f995adb0ac5bcf Paul Burton         2019-04-30  2406  			ebase = (unsigned long)phys_to_virt(ebase_pa);
18022894eca131 James Hogan         2016-09-01  2407  	}
e01402b115cccb Ralf Baechle        2005-07-14  2408  
c6213c6c9c189a Steven J. Hill      2013-06-05  2409  	if (cpu_has_mmips) {
c6213c6c9c189a Steven J. Hill      2013-06-05  2410  		unsigned int config3 = read_c0_config3();
c6213c6c9c189a Steven J. Hill      2013-06-05  2411  
c6213c6c9c189a Steven J. Hill      2013-06-05  2412  		if (IS_ENABLED(CONFIG_CPU_MICROMIPS))
c6213c6c9c189a Steven J. Hill      2013-06-05  2413  			write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
c6213c6c9c189a Steven J. Hill      2013-06-05  2414  		else
c6213c6c9c189a Steven J. Hill      2013-06-05  2415  			write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
c6213c6c9c189a Steven J. Hill      2013-06-05  2416  	}
c6213c6c9c189a Steven J. Hill      2013-06-05  2417  
6fb97effee5374 Kevin Cernekee      2011-11-16  2418  	if (board_ebase_setup)
6fb97effee5374 Kevin Cernekee      2011-11-16  2419  		board_ebase_setup();
6650df3c380e0d David Daney         2012-05-15  2420  	per_cpu_trap_init(true);
25517ed4e99b3b Huacai Chen         2018-11-10  2421  	memblock_set_bottom_up(false);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2422  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2423  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2424  	 * Copy the generic exception handlers to their final destination.
92a76f6d8545ef Adam Buchbinder     2016-02-25  2425  	 * This will be overridden later as suitable for a particular
^1da177e4c3f41 Linus Torvalds      2005-04-16  2426  	 * configuration.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2427  	 */
e01402b115cccb Ralf Baechle        2005-07-14  2428  	set_handler(0x180, &except_vec3_generic, 0x80);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2429  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2430  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2431  	 * Setup default vectors
^1da177e4c3f41 Linus Torvalds      2005-04-16  2432  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2433  	for (i = 0; i <= 31; i++)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2434  		set_except_vector(i, handle_reserved);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2435  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2436  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2437  	 * Copy the EJTAG debug exception vector handler code to it's final
^1da177e4c3f41 Linus Torvalds      2005-04-16  2438  	 * destination.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2439  	 */
e01402b115cccb Ralf Baechle        2005-07-14  2440  	if (cpu_has_ejtag && board_ejtag_handler_setup)
e01402b115cccb Ralf Baechle        2005-07-14  2441  		board_ejtag_handler_setup();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2442  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2443  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2444  	 * Only some CPUs have the watch exceptions.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2445  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2446  	if (cpu_has_watch)
1b505defe05174 James Hogan         2015-12-16  2447  		set_except_vector(EXCCODE_WATCH, handle_watch);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2448  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2449  	/*
e01402b115cccb Ralf Baechle        2005-07-14  2450  	 * Initialise interrupt handlers
^1da177e4c3f41 Linus Torvalds      2005-04-16  2451  	 */
e01402b115cccb Ralf Baechle        2005-07-14  2452  	if (cpu_has_veic || cpu_has_vint) {
e01402b115cccb Ralf Baechle        2005-07-14  2453  		int nvec = cpu_has_veic ? 64 : 8;
e01402b115cccb Ralf Baechle        2005-07-14  2454  		for (i = 0; i < nvec; i++)
e01402b115cccb Ralf Baechle        2005-07-14  2455  			set_vi_handler(i, NULL);
e01402b115cccb Ralf Baechle        2005-07-14  2456  	}
e01402b115cccb Ralf Baechle        2005-07-14  2457  	else if (cpu_has_divec)
e01402b115cccb Ralf Baechle        2005-07-14  2458  		set_handler(0x200, &except_vec4, 0x8);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2459  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2460  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2461  	 * Some CPUs can enable/disable for cache parity detection, but does
^1da177e4c3f41 Linus Torvalds      2005-04-16  2462  	 * it different ways.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2463  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2464  	parity_protection_init();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2465  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2466  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2467  	 * The Data Bus Errors / Instruction Bus Errors are signaled
^1da177e4c3f41 Linus Torvalds      2005-04-16  2468  	 * by external hardware.  Therefore these two exceptions
^1da177e4c3f41 Linus Torvalds      2005-04-16  2469  	 * may have board specific handlers.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2470  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2471  	if (board_be_init)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2472  		board_be_init();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2473  
1b505defe05174 James Hogan         2015-12-16  2474  	set_except_vector(EXCCODE_INT, using_rollback_handler() ?
1b505defe05174 James Hogan         2015-12-16  2475  					rollback_handle_int : handle_int);
1b505defe05174 James Hogan         2015-12-16  2476  	set_except_vector(EXCCODE_MOD, handle_tlbm);
1b505defe05174 James Hogan         2015-12-16  2477  	set_except_vector(EXCCODE_TLBL, handle_tlbl);
1b505defe05174 James Hogan         2015-12-16  2478  	set_except_vector(EXCCODE_TLBS, handle_tlbs);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2479  
1b505defe05174 James Hogan         2015-12-16  2480  	set_except_vector(EXCCODE_ADEL, handle_adel);
1b505defe05174 James Hogan         2015-12-16  2481  	set_except_vector(EXCCODE_ADES, handle_ades);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2482  
1b505defe05174 James Hogan         2015-12-16  2483  	set_except_vector(EXCCODE_IBE, handle_ibe);
1b505defe05174 James Hogan         2015-12-16  2484  	set_except_vector(EXCCODE_DBE, handle_dbe);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2485  
1b505defe05174 James Hogan         2015-12-16  2486  	set_except_vector(EXCCODE_SYS, handle_sys);
1b505defe05174 James Hogan         2015-12-16  2487  	set_except_vector(EXCCODE_BP, handle_bp);
5a34133167dce3 Huacai Chen         2017-03-16  2488  
5a34133167dce3 Huacai Chen         2017-03-16  2489  	if (rdhwr_noopt)
5a34133167dce3 Huacai Chen         2017-03-16  2490  		set_except_vector(EXCCODE_RI, handle_ri);
5a34133167dce3 Huacai Chen         2017-03-16  2491  	else {
5a34133167dce3 Huacai Chen         2017-03-16  2492  		if (cpu_has_vtag_icache)
5a34133167dce3 Huacai Chen         2017-03-16  2493  			set_except_vector(EXCCODE_RI, handle_ri_rdhwr_tlbp);
268a2d60013049 Jiaxun Yang         2019-10-20  2494  		else if (current_cpu_type() == CPU_LOONGSON64)
5a34133167dce3 Huacai Chen         2017-03-16  2495  			set_except_vector(EXCCODE_RI, handle_ri_rdhwr_tlbp);
5a34133167dce3 Huacai Chen         2017-03-16  2496  		else
5a34133167dce3 Huacai Chen         2017-03-16  2497  			set_except_vector(EXCCODE_RI, handle_ri_rdhwr);
5a34133167dce3 Huacai Chen         2017-03-16  2498  	}
5a34133167dce3 Huacai Chen         2017-03-16  2499  
1b505defe05174 James Hogan         2015-12-16  2500  	set_except_vector(EXCCODE_CPU, handle_cpu);
1b505defe05174 James Hogan         2015-12-16  2501  	set_except_vector(EXCCODE_OV, handle_ov);
1b505defe05174 James Hogan         2015-12-16  2502  	set_except_vector(EXCCODE_TR, handle_tr);
1b505defe05174 James Hogan         2015-12-16  2503  	set_except_vector(EXCCODE_MSAFPE, handle_msa_fpe);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2504  
e01402b115cccb Ralf Baechle        2005-07-14  2505  	if (board_nmi_handler_setup)
e01402b115cccb Ralf Baechle        2005-07-14  2506  		board_nmi_handler_setup();
e01402b115cccb Ralf Baechle        2005-07-14  2507  
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2508  	if (cpu_has_fpu && !cpu_has_nofpuex)
1b505defe05174 James Hogan         2015-12-16  2509  		set_except_vector(EXCCODE_FPE, handle_fpe);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2510  
efd1b4ad3d5178 WANG Xuerui         2020-07-29  2511  	if (cpu_has_ftlbparex)
1b505defe05174 James Hogan         2015-12-16  2512  		set_except_vector(MIPS_EXCCODE_TLBPAR, handle_ftlb);
5890f70f15c52d Leonid Yegoshin     2014-07-15  2513  
bc6e8dc112133a WANG Xuerui         2020-07-29  2514  	if (cpu_has_gsexcex)
bc6e8dc112133a WANG Xuerui         2020-07-29  2515  		set_except_vector(LOONGSON_EXCCODE_GSEXC, handle_gsexc);
bc6e8dc112133a WANG Xuerui         2020-07-29  2516  
5890f70f15c52d Leonid Yegoshin     2014-07-15  2517  	if (cpu_has_rixiex) {
1b505defe05174 James Hogan         2015-12-16  2518  		set_except_vector(EXCCODE_TLBRI, tlb_do_page_fault_0);
1b505defe05174 James Hogan         2015-12-16  2519  		set_except_vector(EXCCODE_TLBXI, tlb_do_page_fault_0);
5890f70f15c52d Leonid Yegoshin     2014-07-15  2520  	}
5890f70f15c52d Leonid Yegoshin     2014-07-15  2521  
1b505defe05174 James Hogan         2015-12-16  2522  	set_except_vector(EXCCODE_MSADIS, handle_msa);
1b505defe05174 James Hogan         2015-12-16  2523  	set_except_vector(EXCCODE_MDMX, handle_mdmx);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2524  
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2525  	if (cpu_has_mcheck)
1b505defe05174 James Hogan         2015-12-16  2526  		set_except_vector(EXCCODE_MCHECK, handle_mcheck);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2527  
340ee4b98c0543 Ralf Baechle        2005-08-17  2528  	if (cpu_has_mipsmt)
1b505defe05174 James Hogan         2015-12-16  2529  		set_except_vector(EXCCODE_THREAD, handle_mt);
340ee4b98c0543 Ralf Baechle        2005-08-17  2530  
1b505defe05174 James Hogan         2015-12-16  2531  	set_except_vector(EXCCODE_DSPDIS, handle_dsp);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2532  
fcbf1dfde3da72 David Daney         2012-05-15  2533  	if (board_cache_error_setup)
fcbf1dfde3da72 David Daney         2012-05-15  2534  		board_cache_error_setup();
fcbf1dfde3da72 David Daney         2012-05-15  2535  
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2536  	if (cpu_has_vce)
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2537  		/* Special exception: R4[04]00 uses also the divec space. */
2a0b24f56c2492 Steven J. Hill      2013-03-25  2538  		set_handler(0x180, &except_vec3_r4000, 0x100);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2539  	else if (cpu_has_4kex)
2a0b24f56c2492 Steven J. Hill      2013-03-25  2540  		set_handler(0x180, &except_vec3_generic, 0x80);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2541  	else
2a0b24f56c2492 Steven J. Hill      2013-03-25  2542  		set_handler(0x080, &except_vec3_generic, 0x80);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2543  
783454e2bc7ce4 Paul Burton         2019-04-30  2544  	local_flush_icache_range(ebase, ebase + vec_size);
0510617b85758b Thomas Bogendoerfer 2008-08-04  2545  
0510617b85758b Thomas Bogendoerfer 2008-08-04  2546  	sort_extable(__start___dbe_table, __stop___dbe_table);
69f3a7de1f1ec9 Ralf Baechle        2009-11-24  2547  
4483b159168d3d Ralf Baechle        2010-08-05  2548  	cu2_notifier(default_cu2_call, 0x80000000);	/* Run last  */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2549  }
ae4ce45419f908 James Hogan         2014-03-04  2550  

:::::: The code at line 2368 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
