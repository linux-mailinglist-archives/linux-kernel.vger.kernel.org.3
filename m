Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228D4EFF2E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiDBGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 02:32:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07702F3B9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 23:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648881041; x=1680417041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=odvBG0LW7rL0CGKEf46igdKlQi9grIbl5o33MYuxeiE=;
  b=WyCTB9oRGd3tAeOPP1OjCegPJBH6MAXO5yDYY3HvUh041/EJhCQpsBus
   inc9IqjLfGKGpKcI98UEB87Kc0ARufz3Ksjpz7ioOwdPhvMzZh3SWyGDZ
   c6rvhLIU2n4KKc0VG2LezHGCWB9XzplYKYk4OId9M11XRYBF1TLvzkmFz
   6HyVEk2TjN3RMIt/k52AI5NZ38RzdRmqv9Jpwe07MYBaPMTdCzxNEePA9
   HLDygSek5okYcF6ovwV18dSCw7WvHa4Sh8fFCivT+w3TGrAaws1vXJzXa
   vSnWI+t1nnS9U8bWnCEKVMvelQHuGxWIrxRgt8mvXVgOZGYD6UJe06PfL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240869313"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="240869313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 23:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504403158"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2022 23:30:39 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naXHS-0001nl-DO;
        Sat, 02 Apr 2022 06:30:38 +0000
Date:   Sat, 2 Apr 2022 14:29:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit
 declaration of function 'cpuid_to_hartid_map'
Message-ID: <202204021409.IwExY1Pb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b cpuidle: Add RISC-V SBI CPU idle driver
date:   3 weeks ago
config: riscv-randconfig-r015-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021409.IwExY1Pb-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6abf32f1d9c5009dcccded2c1e7ca899a4ab587b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/cpuidle/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/percpu.h:5,
                    from include/linux/cpuidle.h:14,
                    from drivers/cpuidle/cpuidle-riscv-sbi.c:11:
   drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_init_cpu':
>> drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror=implicit-function-declaration]
     350 |                          cpuid_to_hartid_map(cpu));
         |                          ^~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:349:17: note: in expansion of macro 'pr_debug'
     349 |                 pr_debug("HART%ld: failed to parse DT idle states\n",
         |                 ^~~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:576:19: note: in expansion of macro 'KERN_DEBUG'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:349:17: note: in expansion of macro 'pr_debug'
     349 |                 pr_debug("HART%ld: failed to parse DT idle states\n",
         |                 ^~~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'printk'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:358:17: note: in expansion of macro 'pr_err'
     358 |                 pr_err("HART%ld: failed to init idle states\n",
         |                 ^~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_probe':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:576:19: note: in expansion of macro 'KERN_DEBUG'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:566:25: note: in expansion of macro 'pr_debug'
     566 |                         pr_debug("HART%ld: idle driver init failed\n",
         |                         ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/cpuid_to_hartid_map +350 drivers/cpuidle/cpuidle-riscv-sbi.c

   317	
   318	static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
   319	{
   320		struct cpuidle_driver *drv;
   321		unsigned int state_count = 0;
   322		int ret = 0;
   323	
   324		drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
   325		if (!drv)
   326			return -ENOMEM;
   327	
   328		drv->name = "sbi_cpuidle";
   329		drv->owner = THIS_MODULE;
   330		drv->cpumask = (struct cpumask *)cpumask_of(cpu);
   331	
   332		/* RISC-V architectural WFI to be represented as state index 0. */
   333		drv->states[0].enter = sbi_cpuidle_enter_state;
   334		drv->states[0].exit_latency = 1;
   335		drv->states[0].target_residency = 1;
   336		drv->states[0].power_usage = UINT_MAX;
   337		strcpy(drv->states[0].name, "WFI");
   338		strcpy(drv->states[0].desc, "RISC-V WFI");
   339	
   340		/*
   341		 * If no DT idle states are detected (ret == 0) let the driver
   342		 * initialization fail accordingly since there is no reason to
   343		 * initialize the idle driver if only wfi is supported, the
   344		 * default archictectural back-end already executes wfi
   345		 * on idle entry.
   346		 */
   347		ret = dt_init_idle_driver(drv, sbi_cpuidle_state_match, 1);
   348		if (ret <= 0) {
   349			pr_debug("HART%ld: failed to parse DT idle states\n",
 > 350				 cpuid_to_hartid_map(cpu));
   351			return ret ? : -ENODEV;
   352		}
   353		state_count = ret + 1; /* Include WFI state as well */
   354	
   355		/* Initialize idle states from DT. */
   356		ret = sbi_cpuidle_dt_init_states(dev, drv, cpu, state_count);
   357		if (ret) {
   358			pr_err("HART%ld: failed to init idle states\n",
   359			       cpuid_to_hartid_map(cpu));
   360			return ret;
   361		}
   362	
   363		ret = cpuidle_register(drv, NULL);
   364		if (ret)
   365			goto deinit;
   366	
   367		cpuidle_cooling_register(drv);
   368	
   369		return 0;
   370	deinit:
   371		sbi_cpuidle_deinit_cpu(cpu);
   372		return ret;
   373	}
   374	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
