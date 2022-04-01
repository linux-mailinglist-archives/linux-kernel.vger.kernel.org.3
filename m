Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F84EE5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiDABgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbiDABgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:36:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC251EFE05
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648776887; x=1680312887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xKoMUE8P90EXj7e0aBSDGOtBFreVHfFzlRwIybfTyBc=;
  b=AVtJ2ty3R9n/5Z4uq1aFtID/Es0et0YqgPrdzWq867B6l8iVHHVGPKDw
   7A6u32jbDhq9jp9RgOAdk9ClskWuV5jplvaj/5lAb0veVN2Av5qR2lAwI
   Ylrw696TPdWyTT7eJv0eiWHGgu4Ux1V8T3sd66CVDKq+3Ivu5KEJln5fP
   jjLnyZ6/kmO0ARG6v6jHdR3WsfZmLuPXUAGnxM2A1pzS6bwCDVC8bI8b1
   wy3Xt874yhrThPx6yiWUFCIxWgz1MQQI7xMlNbxMka85ZMN7nHwOx1ZAf
   6vvas7zOT+AbZvKcVwzO+cHvfYKK2zuqcf1rdKs9znhbtWem+9puXP8EN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="259721404"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259721404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 18:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720701523"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 18:34:44 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na6BY-0000oy-8e;
        Fri, 01 Apr 2022 01:34:44 +0000
Date:   Fri, 1 Apr 2022 09:33:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <willdeacon@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-01
 2099/9999] arch/arm64/kvm/perf.c:58:43: error: implicit declaration of
 function 'perf_num_counters'; did you mean 'dec_mm_counter'?
Message-ID: <202204010933.P6eBPa2u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-01
head:   17c6a0da4bb1ee0407e1e9f366517c4133cbbb72
commit: 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf [2099/9999] FROMGIT: KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
config: arm64-randconfig-r035-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010933.P6eBPa2u-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-01
        git checkout 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
