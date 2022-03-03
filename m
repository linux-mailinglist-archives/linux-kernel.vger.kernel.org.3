Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B104CB559
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiCCDOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiCCDOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:14:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9164C403
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646277225; x=1677813225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HySuEy7Jo+w2PG75FfH3DwQOEvk0CvlZqxEfkJYOWrQ=;
  b=WuRogw+6vcprKZ4rYNCqpmb0suX/j/QxY6VlWrwS8c5heAPY++M8IHWr
   irTydFiE4cKGv6U9LhPgEjctZovHVAWbx2CB0G1VREg4zTDFa5REtfIUm
   VL0j8T6xt1eZEm/zoaOIG0uW0/R92x3wSVJX9leMh88YYkAGU5YZK77fa
   ytSgZZhcQE7AIRP8SvMpeB0g/Cio51tW1M7DFLs2FU+iXbO3xFLz/XDkO
   1gviEAcWZL2jBvS4/c7ciyAJldNM1vOVaKAArvZRQW+Td+C0Zg2e/Po+D
   W6IrmJd6rNLfgVrvNW6MIrLQ83W1pTU25eqqOAvXNlTI4m5cflm0/HP16
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316782933"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="316782933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 19:13:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="709755187"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 19:13:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPbuQ-00005K-8u; Thu, 03 Mar 2022 03:13:42 +0000
Date:   Thu, 3 Mar 2022 11:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinath Sridharan <srinathsr@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@arm.com>,
        martin_liu <martin_liu@htc.com>,
        Andres Oportus <andresoportus@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.14-p-release
 319/6167] kernel/sched/fair.c:5461:15: warning: no previous declaration for
 'capacity_curr_of'
Message-ID: <202203031041.POPBDV5c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinath,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.14-p-release
head:   0ca5d5ac9152d01b3494fb2efb5390319eb9904a
commit: 7f6fb825d6bc1e980181ca19adb2ef090001c882 [319/6167] ANDROID: sched: EAS: take cstate into account when selecting idle core
config: i386-randconfig-r024-20211019 (https://download.01.org/0day-ci/archive/20220303/202203031041.POPBDV5c-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/7f6fb825d6bc1e980181ca19adb2ef090001c882
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.14-p-release
        git checkout 7f6fb825d6bc1e980181ca19adb2ef090001c882
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:25:0:
   include/linux/sched/topology.h:196:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   In file included from kernel/sched/fair.c:39:0:
   kernel/sched/sched.h:1094:34: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
     const struct sched_group_energy const *sge;
                                     ^~~~~
   kernel/sched/fair.c:3407:5: warning: no previous declaration for 'update_rt_rq_load_avg' [-Wmissing-declarations]
    int update_rt_rq_load_avg(u64 now, int cpu, struct rt_rq *rt_rq, int running)
        ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:3545:6: warning: no previous declaration for 'sync_entity_load_avg' [-Wmissing-declarations]
    void sync_entity_load_avg(struct sched_entity *se)
         ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:3558:6: warning: no previous declaration for 'remove_entity_load_avg' [-Wmissing-declarations]
    void remove_entity_load_avg(struct sched_entity *se)
         ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:5461:15: warning: no previous declaration for 'capacity_curr_of' [-Wmissing-declarations]
    unsigned long capacity_curr_of(int cpu)
                  ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5558:34: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
     const struct sched_group_energy const *sge)
                                     ^~~~~
   kernel/sched/fair.c: In function 'select_idle_sibling_cstate_aware':
   kernel/sched/fair.c:6339:17: error: implicit declaration of function 'boosted_task_util'; did you mean 'task_util'? [-Werror=implicit-function-declaration]
        new_usage = boosted_task_util(p);
                    ^~~~~~~~~~~~~~~~~
                    task_util
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:225: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   cc1: some warnings being treated as errors


vim +/capacity_curr_of +5461 kernel/sched/fair.c

  5456	
  5457	/*
  5458	 * Returns the current capacity of cpu after applying both
  5459	 * cpu and freq scaling.
  5460	 */
> 5461	unsigned long capacity_curr_of(int cpu)
  5462	{
  5463		unsigned long max_cap = cpu_rq(cpu)->cpu_capacity_orig;
  5464		unsigned long scale_freq = arch_scale_freq_capacity(NULL, cpu);
  5465	
  5466		return cap_scale(max_cap, scale_freq);
  5467	}
  5468	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
