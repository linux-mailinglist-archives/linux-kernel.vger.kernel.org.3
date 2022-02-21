Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E14BE908
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358871AbiBUNTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:19:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347708AbiBUNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:19:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E0B1EEDF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645449558; x=1676985558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XHf7vacCOjqjspJj9G/kxmSULYKIEHDDy6GKS4fU+u8=;
  b=Dy7vpzgTCxHPC9JLjo8qOQhyp9ZJ/Te4+vmTQkdQWFrjyMYDj5zMCjza
   s1pleoOzCVXrTAqrQbw3J0NLLmcexj/cqYwWpqdPSCkSXFc+OJ+UUrNsv
   QYxwxH4jldriMZen+ns8vXObeUcQMqVcEW81I3L9QvxndR8qR/IcbgjDA
   +eUWthp3zbl1VpZeaSMMPDMoCo9wE2AfazYfuPt0CBiK4bC9mLRDO3kS+
   hbqs3/rLCr5n6QeM9F3udzEOh6TqHKo4s6aCjVu2wk+ZbnwQHah6RtNSD
   4eRMqSr/v6Q9FlK/D6Q4xT9u2oj46U4nWgo/HqzWp//u8tIsou4p+ktxf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314769091"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="314769091"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="627371367"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 05:19:16 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM8ax-0001dh-AB; Mon, 21 Feb 2022 13:19:15 +0000
Date:   Mon, 21 Feb 2022 21:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 119/2575]
 arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202202212129.CrbfLJmZ-lkp@intel.com>
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
head:   21149ca19c21f6b5593d5146690ec83f8f633976
commit: c3ed1822feb47b47a7efdaac15349fab91de0ece [119/2575] headers/deps: per_task, arm64, x86: Convert task_struct::thread to a per_task() field
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20220221/202202212129.CrbfLJmZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c3ed1822feb47b47a7efdaac15349fab91de0ece
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c3ed1822feb47b47a7efdaac15349fab91de0ece
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:29:
>> arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
--
   In file included from arch/arm64/kernel/asm-offsets.c:29:
>> arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: no previous prototype for '__kernel_clock_gettime' [-Wmissing-prototypes]
       9 | int __kernel_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: no previous prototype for '__kernel_gettimeofday' [-Wmissing-prototypes]
      15 | int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: no previous prototype for '__kernel_clock_getres' [-Wmissing-prototypes]
      21 | int __kernel_clock_getres(clockid_t clock_id,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/per_task_common +13 arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h

dae7a695f3f100 Ingo Molnar 2021-09-05  11  
dae7a695f3f100 Ingo Molnar 2021-09-05  12  
8327799a692062 Ingo Molnar 2022-01-04 @13  void __used per_task_common(void)
8327799a692062 Ingo Molnar 2022-01-04  14  {
8327799a692062 Ingo Molnar 2022-01-04  15  #include "per_task_area_struct_template.h"
8327799a692062 Ingo Molnar 2022-01-04  16  }
dae7a695f3f100 Ingo Molnar 2021-09-05  17  

:::::: The code at line 13 was first introduced by commit
:::::: 8327799a692062c3eb7fa4327584d1b4ca7da0be headers/deps: per_task: Implement single template to define 'struct task_struct_per_task' fields and offsets

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
