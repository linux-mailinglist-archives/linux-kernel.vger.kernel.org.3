Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4944F22E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiDEGNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDEGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:13:47 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FA62D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649139109; x=1680675109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KuLkyxprBDCNpxaHjqk9v2Q/qF8NcWihhcU942cTKVk=;
  b=EcAMJcZeaIC+1jv6iGON91OaIsvQ1s5sNfgecJtDXHGNi8RXvz6NEtaK
   zu5VL3qXP/Ju9LfDAmntgSRPR0tNayDVYFkLf3+oMMrqMn8Yu2cct08xR
   5LoLvgzWQsZPwDzKL91WJW3vtnAqTAPmf5THY9dp0jnPlo5741YX2riWT
   4nPIs6wAta5sJlSX+WE3P/QeVzn/nbV42ch/9bP0ra2FgItayAmGo0y9P
   LaBXBB18Z+rUlznnEeHBz1ejk7Q26pbhfMs/kxDGf6vUjcOS4uQQC3wHs
   PG//6tFnMoVCjpMe+qlNepz/ujq0DjNz9CBcHBsTYIyLA3TBIFYEMZM8W
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="321367884"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="321367884"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 23:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="657812943"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2022 23:11:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbcPq-0002hS-3Y;
        Tue, 05 Apr 2022 06:11:46 +0000
Date:   Tue, 5 Apr 2022 14:11:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: drivers/cpuidle/cpuidle-riscv-sbi.c:79:16: error: variable has
 incomplete type 'struct sbiret'
Message-ID: <202204051441.dQ4w35Ga-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: c5179ef1ca0c39dab6955be6b0e3c034cc4164c8 RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
date:   4 weeks ago
config: riscv-randconfig-r022-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051441.dQ4w35Ga-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c5179ef1ca0c39dab6955be6b0e3c034cc4164c8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c5179ef1ca0c39dab6955be6b0e3c034cc4164c8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cpuidle/cpuidle-riscv-sbi.c:79:16: error: variable has incomplete type 'struct sbiret'
           struct sbiret ret;
                         ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:79:9: note: forward declaration of 'struct sbiret'
           struct sbiret ret;
                  ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:81:8: error: implicit declaration of function 'sbi_ecall' [-Werror,-Wimplicit-function-declaration]
           ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
                 ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:81:18: error: use of undeclared identifier 'SBI_EXT_HSM'
           ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
                           ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:81:31: error: use of undeclared identifier 'SBI_EXT_HSM_HART_SUSPEND'
           ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
                                        ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:84:23: error: implicit declaration of function 'sbi_err_map_linux_errno' [-Werror,-Wimplicit-function-declaration]
           return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
                                ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:89:14: error: use of undeclared identifier 'SBI_HSM_SUSP_NON_RET_BIT'
           if (state & SBI_HSM_SUSP_NON_RET_BIT)
                       ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:205:14: error: use of undeclared identifier 'SBI_HSM_SUSPEND_RET_DEFAULT'
           if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
                       ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:206:14: error: use of undeclared identifier 'SBI_HSM_SUSPEND_RET_PLATFORM'
               state < SBI_HSM_SUSPEND_RET_PLATFORM)
                       ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:208:14: error: use of undeclared identifier 'SBI_HSM_SUSPEND_NON_RET_DEFAULT'
           if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
                       ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:209:14: error: use of undeclared identifier 'SBI_HSM_SUSPEND_NON_RET_PLATFORM'
               state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
                       ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:350:5: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror,-Wimplicit-function-declaration]
                            cpuid_to_hartid_map(cpu));
                            ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:350:5: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                            cpuid_to_hartid_map(cpu));
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:570:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
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
   include/linux/printk.h:570:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/cpuidle/cpuidle-riscv-sbi.c:608:26: error: implicit declaration of function 'sbi_mk_version' [-Werror,-Wimplicit-function-declaration]
           if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
                                   ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:608:7: error: use of undeclared identifier 'sbi_spec_version'
           if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
                ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:609:6: error: implicit declaration of function 'sbi_probe_extension' [-Werror,-Wimplicit-function-declaration]
               sbi_probe_extension(SBI_EXT_HSM) <= 0) {
               ^
   drivers/cpuidle/cpuidle-riscv-sbi.c:609:26: error: use of undeclared identifier 'SBI_EXT_HSM'
               sbi_probe_extension(SBI_EXT_HSM) <= 0) {
                                   ^
   3 warnings and 17 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
   Depends on CPU_IDLE && RISCV && RISCV_SBI
   Selected by
   - SOC_VIRT && CPU_IDLE


vim +79 drivers/cpuidle/cpuidle-riscv-sbi.c

6abf32f1d9c500 Anup Patel 2022-02-10   74  
6abf32f1d9c500 Anup Patel 2022-02-10   75  static int sbi_suspend_finisher(unsigned long suspend_type,
6abf32f1d9c500 Anup Patel 2022-02-10   76  				unsigned long resume_addr,
6abf32f1d9c500 Anup Patel 2022-02-10   77  				unsigned long opaque)
6abf32f1d9c500 Anup Patel 2022-02-10   78  {
6abf32f1d9c500 Anup Patel 2022-02-10  @79  	struct sbiret ret;
6abf32f1d9c500 Anup Patel 2022-02-10   80  
6abf32f1d9c500 Anup Patel 2022-02-10  @81  	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
6abf32f1d9c500 Anup Patel 2022-02-10   82  			suspend_type, resume_addr, opaque, 0, 0, 0);
6abf32f1d9c500 Anup Patel 2022-02-10   83  
6abf32f1d9c500 Anup Patel 2022-02-10   84  	return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
6abf32f1d9c500 Anup Patel 2022-02-10   85  }
6abf32f1d9c500 Anup Patel 2022-02-10   86  
6abf32f1d9c500 Anup Patel 2022-02-10   87  static int sbi_suspend(u32 state)
6abf32f1d9c500 Anup Patel 2022-02-10   88  {
6abf32f1d9c500 Anup Patel 2022-02-10  @89  	if (state & SBI_HSM_SUSP_NON_RET_BIT)
6abf32f1d9c500 Anup Patel 2022-02-10   90  		return cpu_suspend(state, sbi_suspend_finisher);
6abf32f1d9c500 Anup Patel 2022-02-10   91  	else
6abf32f1d9c500 Anup Patel 2022-02-10   92  		return sbi_suspend_finisher(state, 0, 0);
6abf32f1d9c500 Anup Patel 2022-02-10   93  }
6abf32f1d9c500 Anup Patel 2022-02-10   94  
6abf32f1d9c500 Anup Patel 2022-02-10   95  static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
6abf32f1d9c500 Anup Patel 2022-02-10   96  				   struct cpuidle_driver *drv, int idx)
6abf32f1d9c500 Anup Patel 2022-02-10   97  {
6abf32f1d9c500 Anup Patel 2022-02-10   98  	u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
6abf32f1d9c500 Anup Patel 2022-02-10   99  
6abf32f1d9c500 Anup Patel 2022-02-10  100  	return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
6abf32f1d9c500 Anup Patel 2022-02-10  101  }
6abf32f1d9c500 Anup Patel 2022-02-10  102  
6abf32f1d9c500 Anup Patel 2022-02-10  103  static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
6abf32f1d9c500 Anup Patel 2022-02-10  104  					  struct cpuidle_driver *drv, int idx,
6abf32f1d9c500 Anup Patel 2022-02-10  105  					  bool s2idle)
6abf32f1d9c500 Anup Patel 2022-02-10  106  {
6abf32f1d9c500 Anup Patel 2022-02-10  107  	struct sbi_cpuidle_data *data = this_cpu_ptr(&sbi_cpuidle_data);
6abf32f1d9c500 Anup Patel 2022-02-10  108  	u32 *states = data->states;
6abf32f1d9c500 Anup Patel 2022-02-10  109  	struct device *pd_dev = data->dev;
6abf32f1d9c500 Anup Patel 2022-02-10  110  	u32 state;
6abf32f1d9c500 Anup Patel 2022-02-10  111  	int ret;
6abf32f1d9c500 Anup Patel 2022-02-10  112  
6abf32f1d9c500 Anup Patel 2022-02-10  113  	ret = cpu_pm_enter();
6abf32f1d9c500 Anup Patel 2022-02-10  114  	if (ret)
6abf32f1d9c500 Anup Patel 2022-02-10  115  		return -1;
6abf32f1d9c500 Anup Patel 2022-02-10  116  
6abf32f1d9c500 Anup Patel 2022-02-10  117  	/* Do runtime PM to manage a hierarchical CPU toplogy. */
6abf32f1d9c500 Anup Patel 2022-02-10  118  	rcu_irq_enter_irqson();
6abf32f1d9c500 Anup Patel 2022-02-10  119  	if (s2idle)
6abf32f1d9c500 Anup Patel 2022-02-10  120  		dev_pm_genpd_suspend(pd_dev);
6abf32f1d9c500 Anup Patel 2022-02-10  121  	else
6abf32f1d9c500 Anup Patel 2022-02-10  122  		pm_runtime_put_sync_suspend(pd_dev);
6abf32f1d9c500 Anup Patel 2022-02-10  123  	rcu_irq_exit_irqson();
6abf32f1d9c500 Anup Patel 2022-02-10  124  
6abf32f1d9c500 Anup Patel 2022-02-10  125  	if (sbi_is_domain_state_available())
6abf32f1d9c500 Anup Patel 2022-02-10  126  		state = sbi_get_domain_state();
6abf32f1d9c500 Anup Patel 2022-02-10  127  	else
6abf32f1d9c500 Anup Patel 2022-02-10  128  		state = states[idx];
6abf32f1d9c500 Anup Patel 2022-02-10  129  
6abf32f1d9c500 Anup Patel 2022-02-10  130  	ret = sbi_suspend(state) ? -1 : idx;
6abf32f1d9c500 Anup Patel 2022-02-10  131  
6abf32f1d9c500 Anup Patel 2022-02-10  132  	rcu_irq_enter_irqson();
6abf32f1d9c500 Anup Patel 2022-02-10  133  	if (s2idle)
6abf32f1d9c500 Anup Patel 2022-02-10  134  		dev_pm_genpd_resume(pd_dev);
6abf32f1d9c500 Anup Patel 2022-02-10  135  	else
6abf32f1d9c500 Anup Patel 2022-02-10  136  		pm_runtime_get_sync(pd_dev);
6abf32f1d9c500 Anup Patel 2022-02-10  137  	rcu_irq_exit_irqson();
6abf32f1d9c500 Anup Patel 2022-02-10  138  
6abf32f1d9c500 Anup Patel 2022-02-10  139  	cpu_pm_exit();
6abf32f1d9c500 Anup Patel 2022-02-10  140  
6abf32f1d9c500 Anup Patel 2022-02-10  141  	/* Clear the domain state to start fresh when back from idle. */
6abf32f1d9c500 Anup Patel 2022-02-10  142  	sbi_clear_domain_state();
6abf32f1d9c500 Anup Patel 2022-02-10  143  	return ret;
6abf32f1d9c500 Anup Patel 2022-02-10  144  }
6abf32f1d9c500 Anup Patel 2022-02-10  145  
6abf32f1d9c500 Anup Patel 2022-02-10  146  static int sbi_enter_domain_idle_state(struct cpuidle_device *dev,
6abf32f1d9c500 Anup Patel 2022-02-10  147  				       struct cpuidle_driver *drv, int idx)
6abf32f1d9c500 Anup Patel 2022-02-10  148  {
6abf32f1d9c500 Anup Patel 2022-02-10  149  	return __sbi_enter_domain_idle_state(dev, drv, idx, false);
6abf32f1d9c500 Anup Patel 2022-02-10  150  }
6abf32f1d9c500 Anup Patel 2022-02-10  151  
6abf32f1d9c500 Anup Patel 2022-02-10  152  static int sbi_enter_s2idle_domain_idle_state(struct cpuidle_device *dev,
6abf32f1d9c500 Anup Patel 2022-02-10  153  					      struct cpuidle_driver *drv,
6abf32f1d9c500 Anup Patel 2022-02-10  154  					      int idx)
6abf32f1d9c500 Anup Patel 2022-02-10  155  {
6abf32f1d9c500 Anup Patel 2022-02-10  156  	return __sbi_enter_domain_idle_state(dev, drv, idx, true);
6abf32f1d9c500 Anup Patel 2022-02-10  157  }
6abf32f1d9c500 Anup Patel 2022-02-10  158  
6abf32f1d9c500 Anup Patel 2022-02-10  159  static int sbi_cpuidle_cpuhp_up(unsigned int cpu)
6abf32f1d9c500 Anup Patel 2022-02-10  160  {
6abf32f1d9c500 Anup Patel 2022-02-10  161  	struct device *pd_dev = __this_cpu_read(sbi_cpuidle_data.dev);
6abf32f1d9c500 Anup Patel 2022-02-10  162  
6abf32f1d9c500 Anup Patel 2022-02-10  163  	if (pd_dev)
6abf32f1d9c500 Anup Patel 2022-02-10  164  		pm_runtime_get_sync(pd_dev);
6abf32f1d9c500 Anup Patel 2022-02-10  165  
6abf32f1d9c500 Anup Patel 2022-02-10  166  	return 0;
6abf32f1d9c500 Anup Patel 2022-02-10  167  }
6abf32f1d9c500 Anup Patel 2022-02-10  168  
6abf32f1d9c500 Anup Patel 2022-02-10  169  static int sbi_cpuidle_cpuhp_down(unsigned int cpu)
6abf32f1d9c500 Anup Patel 2022-02-10  170  {
6abf32f1d9c500 Anup Patel 2022-02-10  171  	struct device *pd_dev = __this_cpu_read(sbi_cpuidle_data.dev);
6abf32f1d9c500 Anup Patel 2022-02-10  172  
6abf32f1d9c500 Anup Patel 2022-02-10  173  	if (pd_dev) {
6abf32f1d9c500 Anup Patel 2022-02-10  174  		pm_runtime_put_sync(pd_dev);
6abf32f1d9c500 Anup Patel 2022-02-10  175  		/* Clear domain state to start fresh at next online. */
6abf32f1d9c500 Anup Patel 2022-02-10  176  		sbi_clear_domain_state();
6abf32f1d9c500 Anup Patel 2022-02-10  177  	}
6abf32f1d9c500 Anup Patel 2022-02-10  178  
6abf32f1d9c500 Anup Patel 2022-02-10  179  	return 0;
6abf32f1d9c500 Anup Patel 2022-02-10  180  }
6abf32f1d9c500 Anup Patel 2022-02-10  181  
6abf32f1d9c500 Anup Patel 2022-02-10  182  static void sbi_idle_init_cpuhp(void)
6abf32f1d9c500 Anup Patel 2022-02-10  183  {
6abf32f1d9c500 Anup Patel 2022-02-10  184  	int err;
6abf32f1d9c500 Anup Patel 2022-02-10  185  
6abf32f1d9c500 Anup Patel 2022-02-10  186  	if (!sbi_cpuidle_use_cpuhp)
6abf32f1d9c500 Anup Patel 2022-02-10  187  		return;
6abf32f1d9c500 Anup Patel 2022-02-10  188  
6abf32f1d9c500 Anup Patel 2022-02-10  189  	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
6abf32f1d9c500 Anup Patel 2022-02-10  190  					"cpuidle/sbi:online",
6abf32f1d9c500 Anup Patel 2022-02-10  191  					sbi_cpuidle_cpuhp_up,
6abf32f1d9c500 Anup Patel 2022-02-10  192  					sbi_cpuidle_cpuhp_down);
6abf32f1d9c500 Anup Patel 2022-02-10  193  	if (err)
6abf32f1d9c500 Anup Patel 2022-02-10  194  		pr_warn("Failed %d while setup cpuhp state\n", err);
6abf32f1d9c500 Anup Patel 2022-02-10  195  }
6abf32f1d9c500 Anup Patel 2022-02-10  196  
6abf32f1d9c500 Anup Patel 2022-02-10  197  static const struct of_device_id sbi_cpuidle_state_match[] = {
6abf32f1d9c500 Anup Patel 2022-02-10  198  	{ .compatible = "riscv,idle-state",
6abf32f1d9c500 Anup Patel 2022-02-10  199  	  .data = sbi_cpuidle_enter_state },
6abf32f1d9c500 Anup Patel 2022-02-10  200  	{ },
6abf32f1d9c500 Anup Patel 2022-02-10  201  };
6abf32f1d9c500 Anup Patel 2022-02-10  202  
6abf32f1d9c500 Anup Patel 2022-02-10  203  static bool sbi_suspend_state_is_valid(u32 state)
6abf32f1d9c500 Anup Patel 2022-02-10  204  {
6abf32f1d9c500 Anup Patel 2022-02-10 @205  	if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
6abf32f1d9c500 Anup Patel 2022-02-10 @206  	    state < SBI_HSM_SUSPEND_RET_PLATFORM)
6abf32f1d9c500 Anup Patel 2022-02-10  207  		return false;
6abf32f1d9c500 Anup Patel 2022-02-10 @208  	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
6abf32f1d9c500 Anup Patel 2022-02-10 @209  	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
6abf32f1d9c500 Anup Patel 2022-02-10  210  		return false;
6abf32f1d9c500 Anup Patel 2022-02-10  211  	return true;
6abf32f1d9c500 Anup Patel 2022-02-10  212  }
6abf32f1d9c500 Anup Patel 2022-02-10  213  

:::::: The code at line 79 was first introduced by commit
:::::: 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b cpuidle: Add RISC-V SBI CPU idle driver

:::::: TO: Anup Patel <anup.patel@wdc.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
