Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB025A256E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbiHZKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbiHZKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:06:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17FDAB91
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661508330; x=1693044330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RT2l6I70dS2D1qFm0X2jCIsJzv3TAYMiItWXNDSgPu8=;
  b=n2/INwmnm8T+tbfEDtAfogp4ADgAhtF/miqmhLrXnVbzA+dGgn8wFxwG
   U5pFFIpqaF/jsiFY9wNCM0JH438F7P369tHRQDD/thhowZ0ujwDg86RFv
   uJ7ELm95Uk0dmrvDJHdonQwFbKQbx4DC3ljKTfIPy/xdDqcNAxaEoMj7M
   eTeKWMZS3pGsDDv6AI2MmxkIuEfKDIe3xXnlVhJWkuljFbptR3PZdZdWf
   KTd1qUsMcbBr8Lk2KNoImR1YSa8fpn/Nj3b06iGJo0r6Huv2kACEVbzlr
   mFRxjdA3za/CnFLMnS0vSi+csUaL6u3ufNTyP1m4x0K/YzoRJ2HcD8yuR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274224176"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="274224176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 03:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="587247174"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2022 03:05:26 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRWDN-0003tW-2J;
        Fri, 26 Aug 2022 10:05:25 +0000
Date:   Fri, 26 Aug 2022 18:04:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 8/8] drivers/perf/arm_pmu.c:560:21:
 error: no member named 'filter_match' in 'struct arm_pmu'
Message-ID: <202208261745.ErnwTbzL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   b149fd14e2fb487c8d8b07d353421101c33bbf2b
commit: b149fd14e2fb487c8d8b07d353421101c33bbf2b [8/8] Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
config: arm64-randconfig-r021-20220823 (https://download.01.org/0day-ci/archive/20220826/202208261745.ErnwTbzL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5364f4940711561b8c0a549c39c654413b704c28)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b149fd14e2fb487c8d8b07d353421101c33bbf2b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout b149fd14e2fb487c8d8b07d353421101c33bbf2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/perf/arm_pmu.c:560:21: error: no member named 'filter_match' in 'struct arm_pmu'
           if (ret && armpmu->filter_match)
                      ~~~~~~  ^
   drivers/perf/arm_pmu.c:561:18: error: no member named 'filter_match' in 'struct arm_pmu'
                   return armpmu->filter_match(event);
                          ~~~~~~  ^
>> drivers/perf/arm_pmu.c:888:4: error: field designator 'filter_match' does not refer to any field in type 'struct pmu'
                   .filter_match   = armpmu_filter_match,
                    ^
   3 errors generated.


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
