Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BBB50A185
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387245AbiDUOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352341AbiDUOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:08:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E731A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650549921; x=1682085921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TPLlX1hLyaBL/85N/cht9zrt8EVIARY1Bri5cNE0gTI=;
  b=kaHNo78R4lBIf7wm0yDdzTyKk7cFVDJy+OvPYAZgWoizSGDWUM0jzgFf
   8ihtS440duuuPqkjTmGdgKYfHPYfFw0AjAZQqr5doKcA+AnwXHozRmVke
   9Je8ThBq8gRA+orbkXrD/b7K633WvYIGDJE4g/dogyGA6D3g5CxwuOQNS
   AroofSGJSGizcY3Wjs//kafIoYj9kAkd0Z81jT9uYCBquzrpsDU6vZcbd
   Al3h2LYnpQqjnJjPCy8tnJLAhtrId3hi4o9iqBoYo6G+mbbthmS+3Xwzi
   p/tpoG1vWuDNGvZJOh+TRTi38/me2V0xxw495+JUr6EW6hJtndx1SPeMF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263206659"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263206659"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="593666935"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 07:05:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhXQs-0008SL-LT;
        Thu, 21 Apr 2022 14:05:18 +0000
Date:   Thu, 21 Apr 2022 22:05:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2444/2579]
 arch/mips/kernel/traps.c:2369:13: warning: no previous prototype for
 function 'trap_init'
Message-ID: <202204212108.M0rnsBrl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: e1ff1eaa1c1de2d870ec5a9a49a5538c38701dca [2444/2579] headers/deps: perf_event: Optimize <linux/perf_event_types.h> dependencies
config: mips-randconfig-r026-20220419 (https://download.01.org/0day-ci/archive/20220421/202204212108.M0rnsBrl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e1ff1eaa1c1de2d870ec5a9a49a5538c38701dca
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e1ff1eaa1c1de2d870ec5a9a49a5538c38701dca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ drivers/media/tuners/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   asmlinkage void do_cpu(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1419:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_cpu(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1524:17: warning: no previous prototype for function 'do_msa_fpe' [-Wmissing-prototypes]
   asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
                   ^
   arch/mips/kernel/traps.c:1524:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
              ^
              static 
   arch/mips/kernel/traps.c:1544:17: warning: no previous prototype for function 'do_msa' [-Wmissing-prototypes]
   asmlinkage void do_msa(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1544:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_msa(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1565:17: warning: no previous prototype for function 'do_mdmx' [-Wmissing-prototypes]
   asmlinkage void do_mdmx(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1565:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_mdmx(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1577:17: warning: no previous prototype for function 'do_watch' [-Wmissing-prototypes]
   asmlinkage void do_watch(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1577:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_watch(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1607:17: warning: variable 'prev_state' set but not used [-Wunused-but-set-variable]
           enum ctx_state prev_state;
                          ^
   arch/mips/kernel/traps.c:1604:17: warning: no previous prototype for function 'do_mcheck' [-Wmissing-prototypes]
   asmlinkage void do_mcheck(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1604:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_mcheck(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1629:17: warning: no previous prototype for function 'do_mt' [-Wmissing-prototypes]
   asmlinkage void do_mt(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1629:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_mt(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1665:17: warning: no previous prototype for function 'do_dsp' [-Wmissing-prototypes]
   asmlinkage void do_dsp(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1665:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_dsp(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1673:17: warning: no previous prototype for function 'do_reserved' [-Wmissing-prototypes]
   asmlinkage void do_reserved(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:1673:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_reserved(struct pt_regs *regs)
              ^
              static 
   arch/mips/kernel/traps.c:1849:17: warning: no previous prototype for function 'cache_parity_error' [-Wmissing-prototypes]
   asmlinkage void cache_parity_error(void)
                   ^
   arch/mips/kernel/traps.c:1849:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void cache_parity_error(void)
              ^
              static 
   arch/mips/kernel/traps.c:1897:17: warning: no previous prototype for function 'do_ftlb' [-Wmissing-prototypes]
   asmlinkage void do_ftlb(void)
                   ^
   arch/mips/kernel/traps.c:1897:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_ftlb(void)
              ^
              static 
   arch/mips/kernel/traps.c:1926:17: warning: no previous prototype for function 'do_gsexc' [-Wmissing-prototypes]
   asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
                   ^
   arch/mips/kernel/traps.c:1926:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
              ^
              static 
   arch/mips/kernel/traps.c:1961:6: warning: no previous prototype for function 'ejtag_exception_handler' [-Wmissing-prototypes]
   void ejtag_exception_handler(struct pt_regs *regs)
        ^
   arch/mips/kernel/traps.c:1961:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ejtag_exception_handler(struct pt_regs *regs)
   ^
   static 
   arch/mips/kernel/traps.c:2006:17: warning: no previous prototype for function 'nmi_exception_handler' [-Wmissing-prototypes]
   void __noreturn nmi_exception_handler(struct pt_regs *regs)
                   ^
   arch/mips/kernel/traps.c:2006:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __noreturn nmi_exception_handler(struct pt_regs *regs)
   ^
   static 
>> arch/mips/kernel/traps.c:2369:13: warning: no previous prototype for function 'trap_init' [-Wmissing-prototypes]
   void __init trap_init(void)
               ^
   arch/mips/kernel/traps.c:2369:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init trap_init(void)
   ^
   static 
   22 warnings generated.


vim +/trap_init +2369 arch/mips/kernel/traps.c

5b10496b6e6577 Atsushi Nemoto      2006-09-11  2368  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @2369  void __init trap_init(void)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2370  {
2a0b24f56c2492 Steven J. Hill      2013-03-25  2371  	extern char except_vec3_generic;
^1da177e4c3f41 Linus Torvalds      2005-04-16  2372  	extern char except_vec4;
2a0b24f56c2492 Steven J. Hill      2013-03-25  2373  	extern char except_vec3_r4000;
172dcd935c34b0 Paul Burton         2019-04-30  2374  	unsigned long i, vec_size;
172dcd935c34b0 Paul Burton         2019-04-30  2375  	phys_addr_t ebase_pa;
c65a5480ff2919 Atsushi Nemoto      2007-11-12  2376  
c65a5480ff2919 Atsushi Nemoto      2007-11-12  2377  	check_wait();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2378  
172dcd935c34b0 Paul Burton         2019-04-30  2379  	if (!cpu_has_mips_r2_r6) {
172dcd935c34b0 Paul Burton         2019-04-30  2380  		ebase = CAC_BASE;
172dcd935c34b0 Paul Burton         2019-04-30  2381  		vec_size = 0x400;
172dcd935c34b0 Paul Burton         2019-04-30  2382  	} else {
172dcd935c34b0 Paul Burton         2019-04-30  2383  		if (cpu_has_veic || cpu_has_vint)
172dcd935c34b0 Paul Burton         2019-04-30  2384  			vec_size = 0x200 + VECTORSPACING*64;
172dcd935c34b0 Paul Burton         2019-04-30  2385  		else
172dcd935c34b0 Paul Burton         2019-04-30  2386  			vec_size = PAGE_SIZE;
172dcd935c34b0 Paul Burton         2019-04-30  2387  
172dcd935c34b0 Paul Burton         2019-04-30  2388  		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
f995adb0ac5bcf Paul Burton         2019-04-30  2389  		if (!ebase_pa)
8a7f97b902f4fb Mike Rapoport       2019-03-11  2390  			panic("%s: Failed to allocate %lu bytes align=0x%x\n",
172dcd935c34b0 Paul Burton         2019-04-30  2391  			      __func__, vec_size, 1 << fls(vec_size));
c195e079e9dd00 James Hogan         2016-09-01  2392  
c195e079e9dd00 James Hogan         2016-09-01  2393  		/*
c195e079e9dd00 James Hogan         2016-09-01  2394  		 * Try to ensure ebase resides in KSeg0 if possible.
c195e079e9dd00 James Hogan         2016-09-01  2395  		 *
c195e079e9dd00 James Hogan         2016-09-01  2396  		 * It shouldn't generally be in XKPhys on MIPS64 to avoid
c195e079e9dd00 James Hogan         2016-09-01  2397  		 * hitting a poorly defined exception base for Cache Errors.
c195e079e9dd00 James Hogan         2016-09-01  2398  		 * The allocation is likely to be in the low 512MB of physical,
c195e079e9dd00 James Hogan         2016-09-01  2399  		 * in which case we should be able to convert to KSeg0.
c195e079e9dd00 James Hogan         2016-09-01  2400  		 *
c195e079e9dd00 James Hogan         2016-09-01  2401  		 * EVA is special though as it allows segments to be rearranged
c195e079e9dd00 James Hogan         2016-09-01  2402  		 * and to become uncached during cache error handling.
c195e079e9dd00 James Hogan         2016-09-01  2403  		 */
c195e079e9dd00 James Hogan         2016-09-01  2404  		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
c195e079e9dd00 James Hogan         2016-09-01  2405  			ebase = CKSEG0ADDR(ebase_pa);
f995adb0ac5bcf Paul Burton         2019-04-30  2406  		else
f995adb0ac5bcf Paul Burton         2019-04-30  2407  			ebase = (unsigned long)phys_to_virt(ebase_pa);
18022894eca131 James Hogan         2016-09-01  2408  	}
e01402b115cccb Ralf Baechle        2005-07-14  2409  
c6213c6c9c189a Steven J. Hill      2013-06-05  2410  	if (cpu_has_mmips) {
c6213c6c9c189a Steven J. Hill      2013-06-05  2411  		unsigned int config3 = read_c0_config3();
c6213c6c9c189a Steven J. Hill      2013-06-05  2412  
c6213c6c9c189a Steven J. Hill      2013-06-05  2413  		if (IS_ENABLED(CONFIG_CPU_MICROMIPS))
c6213c6c9c189a Steven J. Hill      2013-06-05  2414  			write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
c6213c6c9c189a Steven J. Hill      2013-06-05  2415  		else
c6213c6c9c189a Steven J. Hill      2013-06-05  2416  			write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
c6213c6c9c189a Steven J. Hill      2013-06-05  2417  	}
c6213c6c9c189a Steven J. Hill      2013-06-05  2418  
6fb97effee5374 Kevin Cernekee      2011-11-16  2419  	if (board_ebase_setup)
6fb97effee5374 Kevin Cernekee      2011-11-16  2420  		board_ebase_setup();
6650df3c380e0d David Daney         2012-05-15  2421  	per_cpu_trap_init(true);
25517ed4e99b3b Huacai Chen         2018-11-10  2422  	memblock_set_bottom_up(false);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2423  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2424  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2425  	 * Copy the generic exception handlers to their final destination.
92a76f6d8545ef Adam Buchbinder     2016-02-25  2426  	 * This will be overridden later as suitable for a particular
^1da177e4c3f41 Linus Torvalds      2005-04-16  2427  	 * configuration.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2428  	 */
e01402b115cccb Ralf Baechle        2005-07-14  2429  	set_handler(0x180, &except_vec3_generic, 0x80);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2430  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2431  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2432  	 * Setup default vectors
^1da177e4c3f41 Linus Torvalds      2005-04-16  2433  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2434  	for (i = 0; i <= 31; i++)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2435  		set_except_vector(i, handle_reserved);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2436  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2437  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2438  	 * Copy the EJTAG debug exception vector handler code to it's final
^1da177e4c3f41 Linus Torvalds      2005-04-16  2439  	 * destination.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2440  	 */
e01402b115cccb Ralf Baechle        2005-07-14  2441  	if (cpu_has_ejtag && board_ejtag_handler_setup)
e01402b115cccb Ralf Baechle        2005-07-14  2442  		board_ejtag_handler_setup();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2443  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2444  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2445  	 * Only some CPUs have the watch exceptions.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2446  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2447  	if (cpu_has_watch)
1b505defe05174 James Hogan         2015-12-16  2448  		set_except_vector(EXCCODE_WATCH, handle_watch);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2449  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2450  	/*
e01402b115cccb Ralf Baechle        2005-07-14  2451  	 * Initialise interrupt handlers
^1da177e4c3f41 Linus Torvalds      2005-04-16  2452  	 */
e01402b115cccb Ralf Baechle        2005-07-14  2453  	if (cpu_has_veic || cpu_has_vint) {
e01402b115cccb Ralf Baechle        2005-07-14  2454  		int nvec = cpu_has_veic ? 64 : 8;
e01402b115cccb Ralf Baechle        2005-07-14  2455  		for (i = 0; i < nvec; i++)
e01402b115cccb Ralf Baechle        2005-07-14  2456  			set_vi_handler(i, NULL);
e01402b115cccb Ralf Baechle        2005-07-14  2457  	}
e01402b115cccb Ralf Baechle        2005-07-14  2458  	else if (cpu_has_divec)
e01402b115cccb Ralf Baechle        2005-07-14  2459  		set_handler(0x200, &except_vec4, 0x8);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2460  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2461  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2462  	 * Some CPUs can enable/disable for cache parity detection, but does
^1da177e4c3f41 Linus Torvalds      2005-04-16  2463  	 * it different ways.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2464  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2465  	parity_protection_init();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2466  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2467  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  2468  	 * The Data Bus Errors / Instruction Bus Errors are signaled
^1da177e4c3f41 Linus Torvalds      2005-04-16  2469  	 * by external hardware.  Therefore these two exceptions
^1da177e4c3f41 Linus Torvalds      2005-04-16  2470  	 * may have board specific handlers.
^1da177e4c3f41 Linus Torvalds      2005-04-16  2471  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2472  	if (board_be_init)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2473  		board_be_init();
^1da177e4c3f41 Linus Torvalds      2005-04-16  2474  
1b505defe05174 James Hogan         2015-12-16  2475  	set_except_vector(EXCCODE_INT, using_rollback_handler() ?
1b505defe05174 James Hogan         2015-12-16  2476  					rollback_handle_int : handle_int);
1b505defe05174 James Hogan         2015-12-16  2477  	set_except_vector(EXCCODE_MOD, handle_tlbm);
1b505defe05174 James Hogan         2015-12-16  2478  	set_except_vector(EXCCODE_TLBL, handle_tlbl);
1b505defe05174 James Hogan         2015-12-16  2479  	set_except_vector(EXCCODE_TLBS, handle_tlbs);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2480  
1b505defe05174 James Hogan         2015-12-16  2481  	set_except_vector(EXCCODE_ADEL, handle_adel);
1b505defe05174 James Hogan         2015-12-16  2482  	set_except_vector(EXCCODE_ADES, handle_ades);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2483  
1b505defe05174 James Hogan         2015-12-16  2484  	set_except_vector(EXCCODE_IBE, handle_ibe);
1b505defe05174 James Hogan         2015-12-16  2485  	set_except_vector(EXCCODE_DBE, handle_dbe);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2486  
1b505defe05174 James Hogan         2015-12-16  2487  	set_except_vector(EXCCODE_SYS, handle_sys);
1b505defe05174 James Hogan         2015-12-16  2488  	set_except_vector(EXCCODE_BP, handle_bp);
5a34133167dce3 Huacai Chen         2017-03-16  2489  
5a34133167dce3 Huacai Chen         2017-03-16  2490  	if (rdhwr_noopt)
5a34133167dce3 Huacai Chen         2017-03-16  2491  		set_except_vector(EXCCODE_RI, handle_ri);
5a34133167dce3 Huacai Chen         2017-03-16  2492  	else {
5a34133167dce3 Huacai Chen         2017-03-16  2493  		if (cpu_has_vtag_icache)
5a34133167dce3 Huacai Chen         2017-03-16  2494  			set_except_vector(EXCCODE_RI, handle_ri_rdhwr_tlbp);
268a2d60013049 Jiaxun Yang         2019-10-20  2495  		else if (current_cpu_type() == CPU_LOONGSON64)
5a34133167dce3 Huacai Chen         2017-03-16  2496  			set_except_vector(EXCCODE_RI, handle_ri_rdhwr_tlbp);
5a34133167dce3 Huacai Chen         2017-03-16  2497  		else
5a34133167dce3 Huacai Chen         2017-03-16  2498  			set_except_vector(EXCCODE_RI, handle_ri_rdhwr);
5a34133167dce3 Huacai Chen         2017-03-16  2499  	}
5a34133167dce3 Huacai Chen         2017-03-16  2500  
1b505defe05174 James Hogan         2015-12-16  2501  	set_except_vector(EXCCODE_CPU, handle_cpu);
1b505defe05174 James Hogan         2015-12-16  2502  	set_except_vector(EXCCODE_OV, handle_ov);
1b505defe05174 James Hogan         2015-12-16  2503  	set_except_vector(EXCCODE_TR, handle_tr);
1b505defe05174 James Hogan         2015-12-16  2504  	set_except_vector(EXCCODE_MSAFPE, handle_msa_fpe);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2505  
e01402b115cccb Ralf Baechle        2005-07-14  2506  	if (board_nmi_handler_setup)
e01402b115cccb Ralf Baechle        2005-07-14  2507  		board_nmi_handler_setup();
e01402b115cccb Ralf Baechle        2005-07-14  2508  
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2509  	if (cpu_has_fpu && !cpu_has_nofpuex)
1b505defe05174 James Hogan         2015-12-16  2510  		set_except_vector(EXCCODE_FPE, handle_fpe);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2511  
efd1b4ad3d5178 WANG Xuerui         2020-07-29  2512  	if (cpu_has_ftlbparex)
1b505defe05174 James Hogan         2015-12-16  2513  		set_except_vector(MIPS_EXCCODE_TLBPAR, handle_ftlb);
5890f70f15c52d Leonid Yegoshin     2014-07-15  2514  
bc6e8dc112133a WANG Xuerui         2020-07-29  2515  	if (cpu_has_gsexcex)
bc6e8dc112133a WANG Xuerui         2020-07-29  2516  		set_except_vector(LOONGSON_EXCCODE_GSEXC, handle_gsexc);
bc6e8dc112133a WANG Xuerui         2020-07-29  2517  
5890f70f15c52d Leonid Yegoshin     2014-07-15  2518  	if (cpu_has_rixiex) {
1b505defe05174 James Hogan         2015-12-16  2519  		set_except_vector(EXCCODE_TLBRI, tlb_do_page_fault_0);
1b505defe05174 James Hogan         2015-12-16  2520  		set_except_vector(EXCCODE_TLBXI, tlb_do_page_fault_0);
5890f70f15c52d Leonid Yegoshin     2014-07-15  2521  	}
5890f70f15c52d Leonid Yegoshin     2014-07-15  2522  
1b505defe05174 James Hogan         2015-12-16  2523  	set_except_vector(EXCCODE_MSADIS, handle_msa);
1b505defe05174 James Hogan         2015-12-16  2524  	set_except_vector(EXCCODE_MDMX, handle_mdmx);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2525  
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2526  	if (cpu_has_mcheck)
1b505defe05174 James Hogan         2015-12-16  2527  		set_except_vector(EXCCODE_MCHECK, handle_mcheck);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2528  
340ee4b98c0543 Ralf Baechle        2005-08-17  2529  	if (cpu_has_mipsmt)
1b505defe05174 James Hogan         2015-12-16  2530  		set_except_vector(EXCCODE_THREAD, handle_mt);
340ee4b98c0543 Ralf Baechle        2005-08-17  2531  
1b505defe05174 James Hogan         2015-12-16  2532  	set_except_vector(EXCCODE_DSPDIS, handle_dsp);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2533  
fcbf1dfde3da72 David Daney         2012-05-15  2534  	if (board_cache_error_setup)
fcbf1dfde3da72 David Daney         2012-05-15  2535  		board_cache_error_setup();
fcbf1dfde3da72 David Daney         2012-05-15  2536  
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2537  	if (cpu_has_vce)
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2538  		/* Special exception: R4[04]00 uses also the divec space. */
2a0b24f56c2492 Steven J. Hill      2013-03-25  2539  		set_handler(0x180, &except_vec3_r4000, 0x100);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2540  	else if (cpu_has_4kex)
2a0b24f56c2492 Steven J. Hill      2013-03-25  2541  		set_handler(0x180, &except_vec3_generic, 0x80);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2542  	else
2a0b24f56c2492 Steven J. Hill      2013-03-25  2543  		set_handler(0x080, &except_vec3_generic, 0x80);
e50c0a8fa60da9 Ralf Baechle        2005-05-31  2544  
783454e2bc7ce4 Paul Burton         2019-04-30  2545  	local_flush_icache_range(ebase, ebase + vec_size);
0510617b85758b Thomas Bogendoerfer 2008-08-04  2546  
0510617b85758b Thomas Bogendoerfer 2008-08-04  2547  	sort_extable(__start___dbe_table, __stop___dbe_table);
69f3a7de1f1ec9 Ralf Baechle        2009-11-24  2548  
4483b159168d3d Ralf Baechle        2010-08-05  2549  	cu2_notifier(default_cu2_call, 0x80000000);	/* Run last  */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2550  }
ae4ce45419f908 James Hogan         2014-03-04  2551  

:::::: The code at line 2369 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
