Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3B585460
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiG2RXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiG2RXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:23:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43717FE54
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659115394; x=1690651394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PLCAarZGI7hpr9r7eHrgAdxDGDJ/3HldmTRROgaVA9g=;
  b=COVLw49He54UGqQkava4qA3hr1WnuHiHxQnH6lfZD9oayN7Rknx//+07
   iXbVgqXZSBaXIR2nfkx+6kdXG6DaW2zDrLtKsFFJdWyvrNuuAC9U2OlzR
   9fLNN/KDq1AZ0KTv0w9CJOH9Rr8ongB1axCFkwQEiVQ10NzNFSIzM1Hhc
   GhN/5aMq4vasA8YIas7G6AKNBHkTKFe1XFTOtqgzd4dxnXyI/BlblD8Gm
   Leq7PXL01vhX/ZNsPce1fkeMhN3XaoXK2KpwBJQHm8UB1NVSaknE2HH3K
   ZbrcOfHs0yjo93AR2xVlrBtiT/6UTWWqvD6y6bK1JSkuUSpZs26dcmSgo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289579951"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="289579951"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 10:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="928811697"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2022 10:23:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHThg-000Bup-0d;
        Fri, 29 Jul 2022 17:23:12 +0000
Date:   Sat, 30 Jul 2022 01:22:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 arch/x86/include/asm/vdso/gettimeofday.h:248:34: error: 'VDSO_CLOCKMODE_TSC'
 undeclared; did you mean 'VDSO_CLOCKMODE_MAX'?
Message-ID: <202207300138.IedUdmKn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   02d56061c924adece19bdfad05ea4add32de4b63
commit: 02d56061c924adece19bdfad05ea4add32de4b63 [8/8] random: implement getrandom() in vDSO
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220730/202207300138.IedUdmKn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/02d56061c924adece19bdfad05ea4add32de4b63
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 02d56061c924adece19bdfad05ea4add32de4b63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/vdso/processor.h:10,
                    from include/vdso/datapage.h:17,
                    from drivers/char/random.c:62:
>> arch/x86/include/asm/vdso/processor.h:11:29: error: redefinition of 'rep_nop'
      11 | static __always_inline void rep_nop(void)
         |                             ^~~~~~~
   In file included from include/linux/rcupdate.h:30,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/utsname.h:6,
                    from drivers/char/random.c:28:
   arch/x86/um/asm/processor.h:25:29: note: previous definition of 'rep_nop' with type 'void(void)'
      25 | static __always_inline void rep_nop(void)
         |                             ^~~~~~~
   In file included from include/vdso/processor.h:10,
                    from include/vdso/datapage.h:17,
                    from drivers/char/random.c:62:
>> arch/x86/include/asm/vdso/processor.h:16:29: error: redefinition of 'cpu_relax'
      16 | static __always_inline void cpu_relax(void)
         |                             ^~~~~~~~~
   In file included from include/linux/rcupdate.h:30,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/utsname.h:6,
                    from drivers/char/random.c:28:
   arch/x86/um/asm/processor.h:30:29: note: previous definition of 'cpu_relax' with type 'void(void)'
      30 | static __always_inline void cpu_relax(void)
         |                             ^~~~~~~~~
   In file included from arch/x86/include/asm/mshyperv.h:10,
                    from include/clocksource/hyperv_timer.h:18,
                    from arch/x86/include/asm/vdso/gettimeofday.h:21,
                    from include/vdso/datapage.h:143,
                    from drivers/char/random.c:62:
   arch/x86/include/asm/nospec-branch.h: In function 'mds_clear_cpu_buffers':
>> arch/x86/include/asm/nospec-branch.h:332:31: error: '__KERNEL_DS' undeclared (first use in this function)
     332 |         static const u16 ds = __KERNEL_DS;
         |                               ^~~~~~~~~~~
   arch/x86/include/asm/nospec-branch.h:332:31: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/asm-generic/bug.h:5,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/utsname.h:6,
                    from drivers/char/random.c:28:
   arch/x86/include/asm/vdso/gettimeofday.h: In function '__arch_get_hw_counter':
>> arch/x86/include/asm/vdso/gettimeofday.h:248:34: error: 'VDSO_CLOCKMODE_TSC' undeclared (first use in this function); did you mean 'VDSO_CLOCKMODE_MAX'?
     248 |         if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^


vim +248 arch/x86/include/asm/vdso/gettimeofday.h

7ac8707479886c7 Vincenzo Frascino 2019-06-21  244  
4c5a116ada953b8 Thomas Gleixner   2020-08-04  245  static inline u64 __arch_get_hw_counter(s32 clock_mode,
4c5a116ada953b8 Thomas Gleixner   2020-08-04  246  					const struct vdso_data *vd)
7ac8707479886c7 Vincenzo Frascino 2019-06-21  247  {
b95a8a27c300d1a Thomas Gleixner   2020-02-07 @248  	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
7ac8707479886c7 Vincenzo Frascino 2019-06-21  249  		return (u64)rdtsc_ordered();
7ac8707479886c7 Vincenzo Frascino 2019-06-21  250  	/*
7ac8707479886c7 Vincenzo Frascino 2019-06-21  251  	 * For any memory-mapped vclock type, we need to make sure that gcc
7ac8707479886c7 Vincenzo Frascino 2019-06-21  252  	 * doesn't cleverly hoist a load before the mode check.  Otherwise we
7ac8707479886c7 Vincenzo Frascino 2019-06-21  253  	 * might end up touching the memory-mapped page even if the vclock in
7ac8707479886c7 Vincenzo Frascino 2019-06-21  254  	 * question isn't enabled, which will segfault.  Hence the barriers.
7ac8707479886c7 Vincenzo Frascino 2019-06-21  255  	 */
7ac8707479886c7 Vincenzo Frascino 2019-06-21  256  #ifdef CONFIG_PARAVIRT_CLOCK
b95a8a27c300d1a Thomas Gleixner   2020-02-07  257  	if (clock_mode == VDSO_CLOCKMODE_PVCLOCK) {
7ac8707479886c7 Vincenzo Frascino 2019-06-21  258  		barrier();
7ac8707479886c7 Vincenzo Frascino 2019-06-21  259  		return vread_pvclock();
7ac8707479886c7 Vincenzo Frascino 2019-06-21  260  	}
7ac8707479886c7 Vincenzo Frascino 2019-06-21  261  #endif
3e2d94535adb2df Vitaly Kuznetsov  2019-08-22  262  #ifdef CONFIG_HYPERV_TIMER
b95a8a27c300d1a Thomas Gleixner   2020-02-07  263  	if (clock_mode == VDSO_CLOCKMODE_HVCLOCK) {
7ac8707479886c7 Vincenzo Frascino 2019-06-21  264  		barrier();
7ac8707479886c7 Vincenzo Frascino 2019-06-21  265  		return vread_hvclock();
7ac8707479886c7 Vincenzo Frascino 2019-06-21  266  	}
7ac8707479886c7 Vincenzo Frascino 2019-06-21  267  #endif
7ac8707479886c7 Vincenzo Frascino 2019-06-21  268  	return U64_MAX;
7ac8707479886c7 Vincenzo Frascino 2019-06-21  269  }
7ac8707479886c7 Vincenzo Frascino 2019-06-21  270  

:::::: The code at line 248 was first introduced by commit
:::::: b95a8a27c300d1a39a4e36f63a518ef36e4b966c x86/vdso: Use generic VDSO clock mode storage

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
