Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99274DDD56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbiCRP4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiCRP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:56:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D5BE27
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647618886; x=1679154886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KEFTSAv8xg+WfbM6W9D5jDk3+j1vb2HrT+K7eU3BdAs=;
  b=YhFe6MCWUZjt9+EKdtywhXhvXtUCJl/G+cutZXjEJd7I6yUPmpXk1hZy
   gScxHnu5EA/7cepHp7oCelc8ktxIzbXB821JiXzvB0FUuLnBVeXqL//ts
   ZB+bdjkAX7hAjLZlPvndg4s/UT2CNXQ39XjFTatBtyY9v8YcKPOT/4V47
   0yCoPxdf3P8Dbueje/dXfLTsTFQn7kL1QXJo4w+09wAspJgbnHj5/gQyC
   vnmJBPB6JTkivwHDPLid8OMcwcVTEeFLvy2O7uBtHHJnHYqc/TL1Ylabf
   jUFtQraa5ywp+RuY/2AzVAsC1lpC/v7FJ7EYkZdiJ6//lPVdRGdtuPfPC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256886965"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256886965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="635799920"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2022 08:54:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVEw6-000Ew5-TM; Fri, 18 Mar 2022 15:54:42 +0000
Date:   Fri, 18 Mar 2022 23:54:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <willdeacon@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-03
 233/9999] arch/arm64/kvm/perf.c:58:43: error: implicit declaration of
 function 'perf_num_counters'; did you mean 'dec_mm_counter'?
Message-ID: <202203182338.1SRPwggO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-03
head:   306d827cfbb9633f5be11438b2fc8922bf4d2b3c
commit: 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf [233/9999] FROMGIT: KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
config: arm64-randconfig-c004-20220318 (https://download.01.org/0day-ci/archive/20220318/202203182338.1SRPwggO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-03
        git checkout 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kvm/perf.c: In function 'kvm_perf_init':
>> arch/arm64/kvm/perf.c:58:43: error: implicit declaration of function 'perf_num_counters'; did you mean 'dec_mm_counter'? [-Werror=implicit-function-declaration]
      58 |         if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
         |                                           ^~~~~~~~~~~~~~~~~
         |                                           dec_mm_counter
   cc1: some warnings being treated as errors


vim +58 arch/arm64/kvm/perf.c

    50	
    51	int kvm_perf_init(void)
    52	{
    53		/*
    54		 * Check if HW_PERF_EVENTS are supported by checking the number of
    55		 * hardware performance counters. This could ensure the presence of
    56		 * a physical PMU and CONFIG_PERF_EVENT is selected.
    57		 */
  > 58		if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
    59			static_branch_enable(&kvm_arm_pmu_available);
    60	
    61		return perf_register_guest_info_callbacks(&kvm_guest_cbs);
    62	}
    63	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
