Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A24849B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiADVKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:10:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:38875 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232036AbiADVKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641330614; x=1672866614;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G36aykXQQrpfW0MXKdS8YAGr7r/cA/Ikf7GfLLebR6Q=;
  b=GtpXaZ8RSWBcWNON2VDJK+D96aDuCcPUheWXqNkO3jCBhHaSlly8Oj7+
   sPCHhUsCi114cPVfxTlfX9W6XZIP/IBBJ+Ans09nA/AaIqlhrWZCqY56T
   4Qa0CeEiJ1AYA0PvLul3SSSgscHKe3b9HUhXRVRzOrYF6/PdnAREGYe45
   zzYNplCl97wL0kqNLl6GwbdkyX3N7LzY55aIcUWc2kI1Jw/rJh08kt8iE
   TQhROpQfuHpEhVujN1LtUXubhD9ATmYKOxZfx7XX4ynFYkqBJF8YFHzif
   Cf+amN/CsRyxXUN9d8/wCGtLVzC5Boc3WVQt5qfEEKgABVWeYO9Chjyt+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229616708"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="229616708"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 13:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="472205156"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 13:10:13 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4r4O-000Fro-PA; Tue, 04 Jan 2022 21:10:12 +0000
Date:   Wed, 5 Jan 2022 05:09:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-de:upstream/remove_feec_energy_margin_rework 1/11]
 drivers/powercap/dtpm_cpu.c:85:48: error: expected ')' before ':' token
Message-ID: <202201050536.YWxpqIkn-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220105/202201050536.YWxpqIkn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add arm-de https://git.gitlab.arm.com/linux-arm/linux-de.git
        git fetch --no-tags arm-de upstream/remove_feec_energy_margin_rework
        git checkout 150e753e861285e82e9d7c593f1f26075c34e124
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/powercap/dtpm_cpu.c: In function 'scale_pd_power_uw':
>> drivers/powercap/dtpm_cpu.c:85:48: error: expected ')' before ':' token
      85 |  return (power * ((sum_util << 10) / max) >> 10 : 0;
         |         ~                                      ^~
         |                                                )
>> drivers/powercap/dtpm_cpu.c:85:53: error: expected ';' before '}' token
      85 |  return (power * ((sum_util << 10) / max) >> 10 : 0;
         |                                                     ^
         |                                                     ;
      86 | }
         | ~                                                    


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
