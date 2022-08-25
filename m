Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769145A1D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiHYXyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbiHYXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:54:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF9C59EA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661471644; x=1693007644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YUtcZHJ7ojap9hkLRd86QK/XgC47Wnac7regS6SVDlM=;
  b=cp4goS+lptYvf7Wc8Fm3WhXbBxJaX3tfX2AZv5xre1iU4JoWHKiXeXTZ
   Bbg7/nn+JayPpTsrzE1+0HQ/9nqXmSm24czFWjynNnJdwlMvbrB5H27Do
   emBlviIrf/8vtiHzG6CawwjsZQmGNslc9x4Pmok40GEb4mpwXR0Onc9va
   uAFO7EEODZkdepqtoxYSHA9cdTlg+nl5RGlBap6rJBCHmQRYcQGqDe7ZG
   KrUFN/UhyIJsHSS2PziDDcU8UeyiK0+LaM0lft2ofDVDJ5bIVzonbmsqg
   N3FhWCYqjKVc0q+eOf7gB6hsA2+XO8K4vo6L9YzSWdKlyQ5LbNcBXjvHR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320475188"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="320475188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 16:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587091109"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 16:54:00 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRMfg-00035a-0K;
        Thu, 25 Aug 2022 23:54:00 +0000
Date:   Fri, 26 Aug 2022 07:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 8/8] drivers/perf/arm_pmu.c:560:26:
 error: 'struct arm_pmu' has no member named 'filter_match'
Message-ID: <202208260705.BOEvaIqD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   b149fd14e2fb487c8d8b07d353421101c33bbf2b
commit: b149fd14e2fb487c8d8b07d353421101c33bbf2b [8/8] Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
config: arm-randconfig-r016-20220823 (https://download.01.org/0day-ci/archive/20220826/202208260705.BOEvaIqD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b149fd14e2fb487c8d8b07d353421101c33bbf2b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout b149fd14e2fb487c8d8b07d353421101c33bbf2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/perf/arm_pmu.c: In function 'armpmu_filter_match':
>> drivers/perf/arm_pmu.c:560:26: error: 'struct arm_pmu' has no member named 'filter_match'
     560 |         if (ret && armpmu->filter_match)
         |                          ^~
   drivers/perf/arm_pmu.c:561:30: error: 'struct arm_pmu' has no member named 'filter_match'
     561 |                 return armpmu->filter_match(event);
         |                              ^~
   drivers/perf/arm_pmu.c: In function '__armpmu_alloc':
>> drivers/perf/arm_pmu.c:888:18: error: 'struct pmu' has no member named 'filter_match'
     888 |                 .filter_match   = armpmu_filter_match,
         |                  ^~~~~~~~~~~~
>> drivers/perf/arm_pmu.c:888:35: error: initialization of 'void (*)(struct pmu *, unsigned int)' from incompatible pointer type 'int (*)(struct perf_event *)' [-Werror=incompatible-pointer-types]
     888 |                 .filter_match   = armpmu_filter_match,
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmu.c:888:35: note: (near initialization for '(anonymous).start_txn')
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
   Selected by [y]:
   - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]


vim +560 drivers/perf/arm_pmu.c

1b8873a0c6ec51 arch/arm/kernel/perf_event.c Jamie Iles   2010-02-02  547  
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  548  /*
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  549   * In heterogeneous systems, events are specific to a particular
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  550   * microarchitecture, and aren't suitable for another. Thus, only match CPUs of
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  551   * the same microarchitecture.
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  552   */
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  553  static int armpmu_filter_match(struct perf_event *event)
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  554  {
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  555  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  556  	unsigned int cpu = smp_processor_id();
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05  557  	int ret;
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05  558  
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05  559  	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05 @560  	if (ret && armpmu->filter_match)
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05  561  		return armpmu->filter_match(event);
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05  562  
ca2b497253ad01 drivers/perf/arm_pmu.c       Will Deacon  2018-10-05  563  	return ret;
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  564  }
c904e32a69b7c7 arch/arm/kernel/perf_event.c Mark Rutland 2015-05-13  565  

:::::: The code at line 560 was first introduced by commit
:::::: ca2b497253ad01c80061a1f3ee9eb91b5d54a849 arm64: perf: Reject stand-alone CHAIN events for PMUv3

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
