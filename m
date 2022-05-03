Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB6517F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiECIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiECIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:12:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FEE22B2A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651565316; x=1683101316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V5iy/pmbsgE83uxZtTIgP9o2pAS7H/HgWQCDUkuX3CM=;
  b=MH0k5o7CqfcdKTy7ESiiWgLaF6YT8vOj6zZARRsXGe0yVmbxRXre/f6P
   /Moa+74L4A/pC1tao1WySKcfG8osQGEPnMkt1QWdd60pOBY2TA0gMv8qJ
   bWf3nBAlwVSzlHboK9aNDGXiaiLP7ChVuZmXxapcaGeyCC5VhMW7WnQQ0
   V6II1GirKIreBmW16Wp+mIKK6rl77hDJpUgU5vSsx2Aill9mYoLx+JZCr
   Ywcfm2bSpwgXJNtcmV9tQGhA4SamgQhj63az805BIC9z/gryPxVonSVo+
   DRNaHjNfv6l57/E3OuX4DQN53s++EKET0H07W/lJqB7VxxqCtGCKlnpEa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267016994"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267016994"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 01:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="691623942"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2022 01:08:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlna7-000AGh-MX;
        Tue, 03 May 2022 08:08:27 +0000
Date:   Tue, 3 May 2022 16:07:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v2 13/21]
 drivers/cpuidle/cpuidle-riscv-sbi.c:118:9: error: implicit declaration of
 function 'rcu_irq_enter_irqson'; did you mean 'ct_irq_enter_irqson'?
Message-ID: <202205031636.PVdam5cD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v2
head:   2be9784d1c23f2654f1817ca18c5c07f6699a8fd
commit: 4f3661b7f8682fbfc88ad23003e413062b5c4b5e [13/21] rcu/context-tracking: Remove rcu_irq_enter/exit()
config: riscv-randconfig-r042-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031636.PVdam5cD-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=4f3661b7f8682fbfc88ad23003e413062b5c4b5e
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v2
        git checkout 4f3661b7f8682fbfc88ad23003e413062b5c4b5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpuidle/cpuidle-riscv-sbi.c: In function '__sbi_enter_domain_idle_state':
>> drivers/cpuidle/cpuidle-riscv-sbi.c:118:9: error: implicit declaration of function 'rcu_irq_enter_irqson'; did you mean 'ct_irq_enter_irqson'? [-Werror=implicit-function-declaration]
     118 |         rcu_irq_enter_irqson();
         |         ^~~~~~~~~~~~~~~~~~~~
         |         ct_irq_enter_irqson
>> drivers/cpuidle/cpuidle-riscv-sbi.c:123:9: error: implicit declaration of function 'rcu_irq_exit_irqson'; did you mean 'ct_irq_exit_irqson'? [-Werror=implicit-function-declaration]
     123 |         rcu_irq_exit_irqson();
         |         ^~~~~~~~~~~~~~~~~~~
         |         ct_irq_exit_irqson
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/percpu.h:5,
                    from include/linux/cpuidle.h:14,
                    from drivers/cpuidle/cpuidle-riscv-sbi.c:11:
   drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_init_cpu':
   drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror=implicit-function-declaration]
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
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
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
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
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
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
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


vim +118 drivers/cpuidle/cpuidle-riscv-sbi.c

6abf32f1d9c5009 Anup Patel 2022-02-10  102  
6abf32f1d9c5009 Anup Patel 2022-02-10  103  static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
6abf32f1d9c5009 Anup Patel 2022-02-10  104  					  struct cpuidle_driver *drv, int idx,
6abf32f1d9c5009 Anup Patel 2022-02-10  105  					  bool s2idle)
6abf32f1d9c5009 Anup Patel 2022-02-10  106  {
6abf32f1d9c5009 Anup Patel 2022-02-10  107  	struct sbi_cpuidle_data *data = this_cpu_ptr(&sbi_cpuidle_data);
6abf32f1d9c5009 Anup Patel 2022-02-10  108  	u32 *states = data->states;
6abf32f1d9c5009 Anup Patel 2022-02-10  109  	struct device *pd_dev = data->dev;
6abf32f1d9c5009 Anup Patel 2022-02-10  110  	u32 state;
6abf32f1d9c5009 Anup Patel 2022-02-10  111  	int ret;
6abf32f1d9c5009 Anup Patel 2022-02-10  112  
6abf32f1d9c5009 Anup Patel 2022-02-10  113  	ret = cpu_pm_enter();
6abf32f1d9c5009 Anup Patel 2022-02-10  114  	if (ret)
6abf32f1d9c5009 Anup Patel 2022-02-10  115  		return -1;
6abf32f1d9c5009 Anup Patel 2022-02-10  116  
6abf32f1d9c5009 Anup Patel 2022-02-10  117  	/* Do runtime PM to manage a hierarchical CPU toplogy. */
6abf32f1d9c5009 Anup Patel 2022-02-10 @118  	rcu_irq_enter_irqson();
6abf32f1d9c5009 Anup Patel 2022-02-10  119  	if (s2idle)
6abf32f1d9c5009 Anup Patel 2022-02-10  120  		dev_pm_genpd_suspend(pd_dev);
6abf32f1d9c5009 Anup Patel 2022-02-10  121  	else
6abf32f1d9c5009 Anup Patel 2022-02-10  122  		pm_runtime_put_sync_suspend(pd_dev);
6abf32f1d9c5009 Anup Patel 2022-02-10 @123  	rcu_irq_exit_irqson();
6abf32f1d9c5009 Anup Patel 2022-02-10  124  
6abf32f1d9c5009 Anup Patel 2022-02-10  125  	if (sbi_is_domain_state_available())
6abf32f1d9c5009 Anup Patel 2022-02-10  126  		state = sbi_get_domain_state();
6abf32f1d9c5009 Anup Patel 2022-02-10  127  	else
6abf32f1d9c5009 Anup Patel 2022-02-10  128  		state = states[idx];
6abf32f1d9c5009 Anup Patel 2022-02-10  129  
6abf32f1d9c5009 Anup Patel 2022-02-10  130  	ret = sbi_suspend(state) ? -1 : idx;
6abf32f1d9c5009 Anup Patel 2022-02-10  131  
6abf32f1d9c5009 Anup Patel 2022-02-10  132  	rcu_irq_enter_irqson();
6abf32f1d9c5009 Anup Patel 2022-02-10  133  	if (s2idle)
6abf32f1d9c5009 Anup Patel 2022-02-10  134  		dev_pm_genpd_resume(pd_dev);
6abf32f1d9c5009 Anup Patel 2022-02-10  135  	else
6abf32f1d9c5009 Anup Patel 2022-02-10  136  		pm_runtime_get_sync(pd_dev);
6abf32f1d9c5009 Anup Patel 2022-02-10  137  	rcu_irq_exit_irqson();
6abf32f1d9c5009 Anup Patel 2022-02-10  138  
6abf32f1d9c5009 Anup Patel 2022-02-10  139  	cpu_pm_exit();
6abf32f1d9c5009 Anup Patel 2022-02-10  140  
6abf32f1d9c5009 Anup Patel 2022-02-10  141  	/* Clear the domain state to start fresh when back from idle. */
6abf32f1d9c5009 Anup Patel 2022-02-10  142  	sbi_clear_domain_state();
6abf32f1d9c5009 Anup Patel 2022-02-10  143  	return ret;
6abf32f1d9c5009 Anup Patel 2022-02-10  144  }
6abf32f1d9c5009 Anup Patel 2022-02-10  145  

:::::: The code at line 118 was first introduced by commit
:::::: 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b cpuidle: Add RISC-V SBI CPU idle driver

:::::: TO: Anup Patel <anup.patel@wdc.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
