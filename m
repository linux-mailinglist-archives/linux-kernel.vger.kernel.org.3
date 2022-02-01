Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9024A55EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 05:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiBAE2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 23:28:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:58773 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233454AbiBAE2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643689712; x=1675225712;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iCvCBXFwVh4rfU0ePz9WJ+8ysGL//LLmUCfDhbDs8IY=;
  b=ipjAsx9VJi+BCmf025rN5k89/Q/zIDnW/bmIFPSTNyEAwGDUjtRg6OPK
   WqIFk+NVyYK5P1LifTNB0OF4Q2EcTp2Qz6ZEqMBfpOT7nTWMhfe4IC365
   JwfgpX7uKttYyHNfVi/yWzTeT+rVFeL56KFrPAIwGCoRMbBs04/ok/MYL
   U2gtql7UY06s7DDcbwdCCHTW94gsyi8LnluHcGzS5iDYchte7v39EpCGi
   E8CPuwB4MLMfIvmktYIAio9vgrPQ/Dk7xgiM7OMgoLWY/llhOiP+93BSz
   nwJdaPJRk1trWPoXs2LHl7j8XcJ9oLOxAdDKq1Ccyup12HZHJH8GlrkOm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235010659"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="235010659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 20:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="537635941"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2022 20:28:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEkm8-000SmE-AS; Tue, 01 Feb 2022 04:28:16 +0000
Date:   Tue, 1 Feb 2022 12:27:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_sbi_hsm_suspend_v10 6/8]
 drivers/cpuidle/cpuidle-riscv-sbi.c:350:5: error: implicit declaration of
 function 'cpuid_to_hartid_map'
Message-ID: <202202011242.WZ5PCuUn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_sbi_hsm_suspend_v10
head:   3d5df67e3863058a28bd4abc35fa3a358ea51fea
commit: 3064fc6c122b51e6c7933fed24135d3e8ef8bf74 [6/8] cpuidle: Add RISC-V SBI CPU idle driver
config: riscv-randconfig-c006-20220201 (https://download.01.org/0day-ci/archive/20220201/202202011242.WZ5PCuUn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/3064fc6c122b51e6c7933fed24135d3e8ef8bf74
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_sbi_hsm_suspend_v10
        git checkout 3064fc6c122b51e6c7933fed24135d3e8ef8bf74
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/cpuidle/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/cpuidle/cpuidle-riscv-sbi.c:350:5: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror,-Wimplicit-function-declaration]
                            cpuid_to_hartid_map(cpu));
                            ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:350:5: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                            cpuid_to_hartid_map(cpu));
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:576:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:359:10: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror,-Wimplicit-function-declaration]
                          cpuid_to_hartid_map(cpu));
                          ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:359:10: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                          cpuid_to_hartid_map(cpu));
                          ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:567:6: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror,-Wimplicit-function-declaration]
                                    cpuid_to_hartid_map(cpu));
                                    ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:567:6: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                                    cpuid_to_hartid_map(cpu));
                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:576:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   3 warnings and 3 errors generated.


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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
