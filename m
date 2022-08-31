Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC73F5A7230
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiHaACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiHaACl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:02:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CF6BD54
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661904160; x=1693440160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jJ1BWo6XPK8ig3c3jJ3yCt4qLfhg71dMhi/vSfG6qek=;
  b=DnJTM9SnRn1QCaoFpk6tilRsyPS2/MViY5fLmGLPZ+SU2j25U1LpzFyx
   L/EP3DDIkhQuB5SZO9uOSTEeZNdAE48P9yKXsBn4DJZvd+1h2vQcjmuiO
   4pNfif9Wa6kNQP+NmqyUjel26KEikEQG2PH8wOgV1Vl45m/51C7Y9sxat
   qMJwADJwuM8TCHbCxPeumCkQ1unXFxHDRuBtRxl9psOJ8s24VHuGtq+m1
   AWhM2AnLP+kHROq6qF9FIfcxeK63vZaFt4PLVddPdaMMvjVj+bZDrGTbc
   EG9696y7M09uvkuoT/dHMlRXWZwSS3Qh3lYWK4r/aX4iD8qzDgpitzr1s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357051606"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357051606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="787699753"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Aug 2022 17:02:39 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTBBm-0000lP-1I;
        Wed, 31 Aug 2022 00:02:38 +0000
Date:   Wed, 31 Aug 2022 08:01:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 8/8] drivers/perf/arm_pmu.c:560:21:
 error: no member named 'filter_match' in 'struct arm_pmu'
Message-ID: <202208310808.k4LrRyk5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   1a76bb2b00e68728753191bdc81ce890db4dd783
commit: 1a76bb2b00e68728753191bdc81ce890db4dd783 [8/8] Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
config: arm64-randconfig-r025-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310808.k4LrRyk5-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=1a76bb2b00e68728753191bdc81ce890db4dd783
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout 1a76bb2b00e68728753191bdc81ce890db4dd783
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/

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
