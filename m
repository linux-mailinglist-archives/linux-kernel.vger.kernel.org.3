Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AABE4C0C92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiBWGc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiBWGcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:32:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7160CED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645597946; x=1677133946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BJKKHGzT8sd85iftXcDNzClCea0ssKINnhWdOpD6gxg=;
  b=lS4GHo174TaeRhT8pH1xVSOa0tMeYBg4rSDDRkR9jV/OaKm5aAUIth1i
   s6b275Bp+R69Z8Ej2VXPzZsU5wiyMhBLkQPFqp28QG88AqYKRddIJBWdu
   v+1TV4eH/BS+r4AUeBhV3JWopLGg5LELWm+1ENRor4CbEuSAsTkSY9eOM
   mlK5vvF035xfm+5jI4n2LZj0PcbC7ZsF+9D4jZcoVKHeSc0Xutv+EKoTW
   1n2goKehyZTuLGjGgflgOvQ9B0pE0uzyZfinVHLsJNL0qfLNMIt+tVmqk
   e37Ou7V4uU/rJh9a6VGL3NEq5louIEN9BwkyNaLkULz8efbTS2Xl+nJWQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338332289"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="338332289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 22:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="508309092"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 22:32:23 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMlCD-00014S-RS; Wed, 23 Feb 2022 06:32:17 +0000
Date:   Wed, 23 Feb 2022 14:31:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2000/2324] kernel/up.c:14:5: warning: no
 previous prototype for function 'smp_call_function_single'
Message-ID: <202202231421.ToPGledC-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   7d9efc989eceed6a8fa475a186880ec4a1ad54a3
commit: 59438ff3251170bd7d1c9795532bd3dcc127e3f2 [2000/2324] headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/hardirq.h>
config: mips-ath25_defconfig (https://download.01.org/0day-ci/archive/20220223/202202231421.ToPGledC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=59438ff3251170bd7d1c9795532bd3dcc127e3f2
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 59438ff3251170bd7d1c9795532bd3dcc127e3f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/up.c:8:
   In file included from include/linux/interrupt.h:23:
   arch/mips/include/asm/irq.h:23:19: error: expected ';' after top level declarator
   extern void __init init_IRQ(void);
                     ^
                     ;
>> kernel/up.c:14:5: warning: no previous prototype for function 'smp_call_function_single' [-Wmissing-prototypes]
   int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
       ^
   kernel/up.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
   ^
   static 
>> kernel/up.c:30:5: warning: no previous prototype for function 'smp_call_function_single_async' [-Wmissing-prototypes]
   int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
       ^
   kernel/up.c:30:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
   ^
   static 
>> kernel/up.c:45:6: warning: no previous prototype for function 'on_each_cpu_cond_mask' [-Wmissing-prototypes]
   void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
        ^
   kernel/up.c:45:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
   ^
   static 
>> kernel/up.c:60:5: warning: no previous prototype for function 'smp_call_on_cpu' [-Wmissing-prototypes]
   int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
       ^
   kernel/up.c:60:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
   ^
   static 
   4 warnings and 1 error generated.


vim +/smp_call_function_single +14 kernel/up.c

53ce3d95649087 Andrew Morton             2009-01-09  13  
53ce3d95649087 Andrew Morton             2009-01-09 @14  int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
53ce3d95649087 Andrew Morton             2009-01-09  15  				int wait)
53ce3d95649087 Andrew Morton             2009-01-09  16  {
081192b25c2d46 David Daney               2013-09-11  17  	unsigned long flags;
081192b25c2d46 David Daney               2013-09-11  18  
1e474b28e78897 Paul E. McKenney          2020-02-05  19  	if (cpu != 0)
1e474b28e78897 Paul E. McKenney          2020-02-05  20  		return -ENXIO;
93423b8665f43a Ingo Molnar               2009-01-11  21  
081192b25c2d46 David Daney               2013-09-11  22  	local_irq_save(flags);
081192b25c2d46 David Daney               2013-09-11  23  	func(info);
081192b25c2d46 David Daney               2013-09-11  24  	local_irq_restore(flags);
93423b8665f43a Ingo Molnar               2009-01-11  25  
53ce3d95649087 Andrew Morton             2009-01-09  26  	return 0;
53ce3d95649087 Andrew Morton             2009-01-09  27  }
53ce3d95649087 Andrew Morton             2009-01-09  28  EXPORT_SYMBOL(smp_call_function_single);
fa688207c9db48 David Daney               2013-09-11  29  
1139aeb1c521eb Arnd Bergmann             2021-05-05 @30  int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
40c01e8bd5575e Christoph Hellwig         2013-11-14  31  {
40c01e8bd5575e Christoph Hellwig         2013-11-14  32  	unsigned long flags;
40c01e8bd5575e Christoph Hellwig         2013-11-14  33  
40c01e8bd5575e Christoph Hellwig         2013-11-14  34  	local_irq_save(flags);
40c01e8bd5575e Christoph Hellwig         2013-11-14  35  	csd->func(csd->info);
40c01e8bd5575e Christoph Hellwig         2013-11-14  36  	local_irq_restore(flags);
08eed44c7249d3 Jan Kara                  2014-02-24  37  	return 0;
40c01e8bd5575e Christoph Hellwig         2013-11-14  38  }
c46fff2a3b2979 Frederic Weisbecker       2014-02-24  39  EXPORT_SYMBOL(smp_call_function_single_async);
40c01e8bd5575e Christoph Hellwig         2013-11-14  40  
fa688207c9db48 David Daney               2013-09-11  41  /*
fa688207c9db48 David Daney               2013-09-11  42   * Preemption is disabled here to make sure the cond_func is called under the
f0fffaff0b8960 Bhaskar Chowdhury         2021-05-06  43   * same conditions in UP and SMP.
fa688207c9db48 David Daney               2013-09-11  44   */
5671d814dbd204 Sebastian Andrzej Siewior 2020-01-17 @45  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
cb923159bbb8cc Sebastian Andrzej Siewior 2020-01-17  46  			   void *info, bool wait, const struct cpumask *mask)
fa688207c9db48 David Daney               2013-09-11  47  {
fa688207c9db48 David Daney               2013-09-11  48  	unsigned long flags;
fa688207c9db48 David Daney               2013-09-11  49  
fa688207c9db48 David Daney               2013-09-11  50  	preempt_disable();
a5aa5ce3005972 Nadav Amit                2021-02-20  51  	if ((!cond_func || cond_func(0, info)) && cpumask_test_cpu(0, mask)) {
fa688207c9db48 David Daney               2013-09-11  52  		local_irq_save(flags);
fa688207c9db48 David Daney               2013-09-11  53  		func(info);
fa688207c9db48 David Daney               2013-09-11  54  		local_irq_restore(flags);
fa688207c9db48 David Daney               2013-09-11  55  	}
fa688207c9db48 David Daney               2013-09-11  56  	preempt_enable();
fa688207c9db48 David Daney               2013-09-11  57  }
7d49b28a80b830 Rik van Riel              2018-09-25  58  EXPORT_SYMBOL(on_each_cpu_cond_mask);
7d49b28a80b830 Rik van Riel              2018-09-25  59  
df8ce9d78a4e7f Juergen Gross             2016-08-29 @60  int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)

:::::: The code at line 14 was first introduced by commit
:::::: 53ce3d9564908794ae7dd32969089b57df5fc098 smp_call_function_single(): be slightly less stupid

:::::: TO: Andrew Morton <akpm@linux-foundation.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
