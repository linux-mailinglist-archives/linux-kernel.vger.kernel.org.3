Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C74EFE46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiDBDtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiDBDtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:49:21 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A517667D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648871249; x=1680407249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A+GukEuzxsNgXQg5OiqZVWnBj8YCzhgWRSUf1ag8iRk=;
  b=L5xJskTPA0ggLSvZ9QR042f3w1wbLEH318dl5fgf0Z2AkX+BFK00LBC7
   8Jo4RYTPjHkFsYJa3l9eDdg/lFCFvIIBIdi/94dmZVCRi1HV2svKzi0In
   V4XDVUkRSF0wpO2PjCgEMgiEMZaRh3TXMMdfbwRdmFCYGQus1llRkO2fT
   47ljBFw2xvQ7p8nnK932ac0mhZn8Ok4sNeceoRc3VH9pJfaAvMLUeHwR1
   vvfYOkI54v7fIcdOvHGorjAkTjm2s6MouRYbq40BI3KRTqm6stg/sMYOD
   OwmEGe47Nv0rkqMm4jrwmG0dO7LnBk3ov4waz5C8f8EW4cmpHuDOOVpZc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320973192"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="320973192"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 20:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="721097660"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2022 20:47:26 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naUjW-0001im-3P;
        Sat, 02 Apr 2022 03:47:26 +0000
Date:   Sat, 2 Apr 2022 11:47:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <willdeacon@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-03
 199/9999] arch/arm64/kvm/perf.c:58:36: error: implicit declaration of
 function 'perf_num_counters'
Message-ID: <202204021112.ErKMELRr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-03
head:   64099431c232d4a95f621411747a3972cc1c8061
commit: 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf [199/9999] FROMGIT: KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
config: arm64-randconfig-r024-20220331 (https://download.01.org/0day-ci/archive/20220402/202204021112.ErKMELRr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project cc2e2b80a1f36a28fa7c96c38c2674b10868f09f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-03
        git checkout 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kvm/perf.c:58:36: error: implicit declaration of function 'perf_num_counters' [-Werror,-Wimplicit-function-declaration]
           if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
                                             ^
   1 error generated.


vim +/perf_num_counters +58 arch/arm64/kvm/perf.c

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
