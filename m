Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6E484F93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiAEIvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:51:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:12209 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238664AbiAEIvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641372693; x=1672908693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4GB6rsCxcMyvreo+aau3rw2RYLpWk7Xrh9vvKs1x03w=;
  b=Iwb2m189qgmvt4WQLGWObWsxUbf8o4lNmAJns1Pome+tMXU6Uscwq2fT
   jt6WCKOID7BVJR1Tccj3dVyGqn/T2BGS0wiEPu6oG844pH7zovNnutp9m
   TqqBqTbk1WmxGwZRDK4rpraWBf/Aam8qd0AVcHiVZesJ5bB8Abzfmeins
   euwmPB4H0WlZTXfbWw3eRgWypLjwYMm95iAufnTGHwRwsMYr9V5TulgQ7
   9Xzfw2lHGqhZ4SzZTL4LPRBp/mx3rlZ8zqVvr1KXySb7xvlsGF8r30VKQ
   b1OjMeLfy+kvWSp6Oyrs8Y3QBnPy8tHlRWVWNhc/CDvyBeNiRaQFflPnY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242198488"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="242198488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 00:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="470472751"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2022 00:51:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5214-000GR3-8G; Wed, 05 Jan 2022 08:51:30 +0000
Date:   Wed, 5 Jan 2022 16:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-de:upstream/remove_feec_energy_margin_rework 1/11]
 drivers/powercap/dtpm_cpu.c:85:49: error: expected ')'
Message-ID: <202201051643.2xpTOg7E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.gitlab.arm.com/linux-arm/linux-de.git upstream/remove_feec_energy_margin_rework
head:   8a0bdb78ce1cbb8e5e6768965874226b92b07b0e
commit: 150e753e861285e82e9d7c593f1f26075c34e124 [1/11] sched, drivers: Remove max param from effective_cpu_util()/sched_cpu_util()
config: i386-randconfig-a012-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051643.2xpTOg7E-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add arm-de https://git.gitlab.arm.com/linux-arm/linux-de.git
        git fetch --no-tags arm-de upstream/remove_feec_energy_margin_rework
        git checkout 150e753e861285e82e9d7c593f1f26075c34e124
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/powercap/dtpm_cpu.c:85:49: error: expected ')'
           return (power * ((sum_util << 10) / max) >> 10 : 0;
                                                          ^
   drivers/powercap/dtpm_cpu.c:85:9: note: to match this '('
           return (power * ((sum_util << 10) / max) >> 10 : 0;
                  ^
   1 error generated.


vim +85 drivers/powercap/dtpm_cpu.c

    70	
    71	static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
    72	{
    73		unsigned long max, sum_util = 0;
    74		int cpu;
    75	
    76		/*
    77		 * The capacity is the same for all CPUs belonging to
    78		 * the same perf domain.
    79		 */
    80		max = arch_scale_cpu_capacity(cpumask_first(pd_mask));
    81	
    82		for_each_cpu_and(cpu, pd_mask, cpu_online_mask)
    83			sum_util += sched_cpu_util(cpu);
    84	
  > 85		return (power * ((sum_util << 10) / max) >> 10 : 0;
    86	}
    87	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
