Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DA508388
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376765AbiDTIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376779AbiDTIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:38:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B91ADAE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650443716; x=1681979716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PV3OGKgks+9QiyKJ2luk3WWGfWC+5CsCewMPQZEHrFw=;
  b=BpJra7PSDLOe/wLeM5WlTsQpzEB8AGuTXYOdYoZUmeIcxYgWJNJeVR4c
   vYcBRWkUJ7LOHN6iESyRmiNiLRICmEqUTLmMbwKFuUXyFghSH8i9h02O1
   kXJf5xlBt8fLXj45KzZ3GgdkHPVpoA7ZMFtJoPKAPd3Rzzv2t/heLIfvu
   YSUrKCOjE70hFWxwPVZxuAO2RmHYoD/SRPID9bzgdhDtcdeSlkp+J8bRo
   cQQNnFBEivzD5mIq0L9egebUc0L7xUYQX7afzqYyz9J3H5IB+mOcXcvYm
   nRfb7k1sfiy/QX5p+x8yej4sILTkvAeUFI7hC9BInvBdIxOoWRuG06yrB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263438179"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="263438179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 01:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="529660603"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2022 01:35:13 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh5ns-0006m6-Qu;
        Wed, 20 Apr 2022 08:35:12 +0000
Date:   Wed, 20 Apr 2022 16:34:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2149/2579] kernel/up.c:15:5: warning: no
 previous prototype for 'smp_call_function_single'
Message-ID: <202204201625.mqL2ajMD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: fd8fff89ec8a3b5eb545b66dff7a4875b5b5c9ab [2149/2579] headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/hardirq.h>
config: mips-randconfig-r032-20220419 (https://download.01.org/0day-ci/archive/20220420/202204201625.mqL2ajMD-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fd8fff89ec8a3b5eb545b66dff7a4875b5b5c9ab
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout fd8fff89ec8a3b5eb545b66dff7a4875b5b5c9ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/interrupt.h:23,
                    from kernel/up.c:9:
   arch/mips/include/asm/irq.h:23:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'init_IRQ'
      23 | extern void __init init_IRQ(void);
         |                    ^~~~~~~~
>> kernel/up.c:15:5: warning: no previous prototype for 'smp_call_function_single' [-Wmissing-prototypes]
      15 | int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:31:5: warning: no previous prototype for 'smp_call_function_single_async' [-Wmissing-prototypes]
      31 | int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:46:6: warning: no previous prototype for 'on_each_cpu_cond_mask' [-Wmissing-prototypes]
      46 | void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
         |      ^~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:61:5: warning: no previous prototype for 'smp_call_on_cpu' [-Wmissing-prototypes]
      61 | int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
         |     ^~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SSB_EMBEDDED
   Depends on SSB && SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
   Selected by
   - BCM47XX_SSB && BCM47XX


vim +/smp_call_function_single +15 kernel/up.c

53ce3d95649087 Andrew Morton             2009-01-09  14  
53ce3d95649087 Andrew Morton             2009-01-09 @15  int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
53ce3d95649087 Andrew Morton             2009-01-09  16  				int wait)
53ce3d95649087 Andrew Morton             2009-01-09  17  {
081192b25c2d46 David Daney               2013-09-11  18  	unsigned long flags;
081192b25c2d46 David Daney               2013-09-11  19  
1e474b28e78897 Paul E. McKenney          2020-02-05  20  	if (cpu != 0)
1e474b28e78897 Paul E. McKenney          2020-02-05  21  		return -ENXIO;
93423b8665f43a Ingo Molnar               2009-01-11  22  
081192b25c2d46 David Daney               2013-09-11  23  	local_irq_save(flags);
081192b25c2d46 David Daney               2013-09-11  24  	func(info);
081192b25c2d46 David Daney               2013-09-11  25  	local_irq_restore(flags);
93423b8665f43a Ingo Molnar               2009-01-11  26  
53ce3d95649087 Andrew Morton             2009-01-09  27  	return 0;
53ce3d95649087 Andrew Morton             2009-01-09  28  }
53ce3d95649087 Andrew Morton             2009-01-09  29  EXPORT_SYMBOL(smp_call_function_single);
fa688207c9db48 David Daney               2013-09-11  30  
1139aeb1c521eb Arnd Bergmann             2021-05-05 @31  int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
40c01e8bd5575e Christoph Hellwig         2013-11-14  32  {
40c01e8bd5575e Christoph Hellwig         2013-11-14  33  	unsigned long flags;
40c01e8bd5575e Christoph Hellwig         2013-11-14  34  
40c01e8bd5575e Christoph Hellwig         2013-11-14  35  	local_irq_save(flags);
40c01e8bd5575e Christoph Hellwig         2013-11-14  36  	csd->func(csd->info);
40c01e8bd5575e Christoph Hellwig         2013-11-14  37  	local_irq_restore(flags);
08eed44c7249d3 Jan Kara                  2014-02-24  38  	return 0;
40c01e8bd5575e Christoph Hellwig         2013-11-14  39  }
c46fff2a3b2979 Frederic Weisbecker       2014-02-24  40  EXPORT_SYMBOL(smp_call_function_single_async);
40c01e8bd5575e Christoph Hellwig         2013-11-14  41  
fa688207c9db48 David Daney               2013-09-11  42  /*
fa688207c9db48 David Daney               2013-09-11  43   * Preemption is disabled here to make sure the cond_func is called under the
f0fffaff0b8960 Bhaskar Chowdhury         2021-05-06  44   * same conditions in UP and SMP.
fa688207c9db48 David Daney               2013-09-11  45   */
5671d814dbd204 Sebastian Andrzej Siewior 2020-01-17 @46  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
cb923159bbb8cc Sebastian Andrzej Siewior 2020-01-17  47  			   void *info, bool wait, const struct cpumask *mask)
fa688207c9db48 David Daney               2013-09-11  48  {
fa688207c9db48 David Daney               2013-09-11  49  	unsigned long flags;
fa688207c9db48 David Daney               2013-09-11  50  
fa688207c9db48 David Daney               2013-09-11  51  	preempt_disable();
a5aa5ce3005972 Nadav Amit                2021-02-20  52  	if ((!cond_func || cond_func(0, info)) && cpumask_test_cpu(0, mask)) {
fa688207c9db48 David Daney               2013-09-11  53  		local_irq_save(flags);
fa688207c9db48 David Daney               2013-09-11  54  		func(info);
fa688207c9db48 David Daney               2013-09-11  55  		local_irq_restore(flags);
fa688207c9db48 David Daney               2013-09-11  56  	}
fa688207c9db48 David Daney               2013-09-11  57  	preempt_enable();
fa688207c9db48 David Daney               2013-09-11  58  }
7d49b28a80b830 Rik van Riel              2018-09-25  59  EXPORT_SYMBOL(on_each_cpu_cond_mask);
7d49b28a80b830 Rik van Riel              2018-09-25  60  
df8ce9d78a4e7f Juergen Gross             2016-08-29 @61  int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)

:::::: The code at line 15 was first introduced by commit
:::::: 53ce3d9564908794ae7dd32969089b57df5fc098 smp_call_function_single(): be slightly less stupid

:::::: TO: Andrew Morton <akpm@linux-foundation.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
