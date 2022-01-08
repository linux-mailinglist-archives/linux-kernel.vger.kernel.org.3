Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCDA4882EC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiAHJww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:52:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:15242 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbiAHJwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641635571; x=1673171571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BYtot3Rmo4hIxDM1F/uaADjmWPWCcmYYAi9MeFlLntI=;
  b=LflP8k68VyOKZLZSK4dwjgFyw1mfh3kAoPBmQAHZZ8rSUo8RNBYC0asT
   TkY2k9us99/oESEbCeB+5Gb7r/PhbmKNA8YYhVUC1PLncN3DWu4UQPvum
   kAC/YD+ciIJSSqctA1yuvcSkRpU43UEwoEMEjadr3Vi/swT4itDW8YgAS
   LQ2h6eym2edv/EgdYygnVzOL8LRBIb1FwN6kNydVDJuY8X7u1ks/tB462
   U5q2Byghfvo1n2eWehVuZtlxMP6Yz1Nnn3UnLLdyghXI54iw7lD/Mglf9
   yodKuEQEUuP11YmJw1IBY4z79hpVxqlorYe4KXgHd4dIBWC5UQdH0HE/L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240554398"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240554398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 01:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="514110760"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 01:52:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n68P3-0000Tf-LS; Sat, 08 Jan 2022 09:52:49 +0000
Date:   Sat, 8 Jan 2022 17:52:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2047/2372] kernel/up.c:14:5: warning: no
 previous prototype for 'smp_call_function_single'
Message-ID: <202201081719.ylImExJG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: 0587f672d6bfb2f51b421ca8a508a242c9969143 [2047/2372] headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/hardirq.h>
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220108/202201081719.ylImExJG-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=0587f672d6bfb2f51b421ca8a508a242c9969143
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 0587f672d6bfb2f51b421ca8a508a242c9969143
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/up.c:14:5: warning: no previous prototype for 'smp_call_function_single' [-Wmissing-prototypes]
      14 | int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:30:5: warning: no previous prototype for 'smp_call_function_single_async' [-Wmissing-prototypes]
      30 | int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:45:6: warning: no previous prototype for 'on_each_cpu_cond_mask' [-Wmissing-prototypes]
      45 | void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
         |      ^~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:60:5: warning: no previous prototype for 'smp_call_on_cpu' [-Wmissing-prototypes]
      60 | int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
         |     ^~~~~~~~~~~~~~~


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
