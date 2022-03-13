Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC724D71EB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiCMAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiCMAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:40:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D371081B4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647131986; x=1678667986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aa4BYLPM3e9s7FJoeqDIy7N9D7IHonFABafzltXUnvQ=;
  b=MpRc2D4hlAXME8P40nbpJNa+1ahRKkFmPKNkLZPb9zj4ODiUY/ww78zw
   KKpVbXTV8EPS7evfA8k8+Kzp1OxBC3zJG1bmtPRbXXUk9UJAnOyU/85xN
   hi5UeGloc7mgAPHE6i31+9M9erBIkekKx11XsBgxPyu8LYWoCK2hVLW9o
   TI58sDd4HHTZvmRTleQKv1Sdn5HNJ3zCv1htdovutBtu7TADN9UipU/WO
   dWaGEYJ+uzq7o8ZLU/5aWQ3Zd+1DIcCBS5VaiYl8xzypIZHaysTT2pB1M
   0t2d3BV+IqtISKPHAHwuwpzFaV99ZQ1wctNXcHZfLRTq7PxhwTP/nS50W
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="280581717"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="280581717"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 16:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="713291570"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2022 16:39:44 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTCGt-0008Q8-R2; Sun, 13 Mar 2022 00:39:43 +0000
Date:   Sun, 13 Mar 2022 08:38:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:audio/testing 112/167]
 drivers/cpufreq/apple-soc-cpufreq.c:53:12: error: implicit declaration of
 function 'readq_relaxed' is invalid in C99
Message-ID: <202203130855.uw6cQQRl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux audio/testing
head:   878d09efcd811ce17adb15d9ee32a5b7130320b5
commit: 97012c133dff8f4ad7de4c8d34cf327567c8e3d8 [112/167] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-buildonly-randconfig-r001-20220313 (https://download.01.org/0day-ci/archive/20220313/202203130855.uw6cQQRl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 43f668b98e8d87290fc6bbf5ed13c3ab542e3497)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/AsahiLinux/linux/commit/97012c133dff8f4ad7de4c8d34cf327567c8e3d8
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux audio/testing
        git checkout 97012c133dff8f4ad7de4c8d34cf327567c8e3d8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cpufreq/apple-soc-cpufreq.c:53:12: error: implicit declaration of function 'readq_relaxed' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           u64 reg = readq_relaxed(priv->reg_base + APPLE_CLUSTER_PSTATE);
                     ^
>> drivers/cpufreq/apple-soc-cpufreq.c:71:6: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (readq_poll_timeout_atomic(priv->reg_base + APPLE_CLUSTER_PSTATE, reg,
               ^
   include/linux/iopoll.h:165:28: note: expanded from macro 'readq_poll_timeout_atomic'
           readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
                                     ^
>> drivers/cpufreq/apple-soc-cpufreq.c:82:2: error: implicit declaration of function 'writeq_relaxed' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           writeq_relaxed(reg, priv->reg_base + APPLE_CLUSTER_PSTATE);
           ^
   3 errors generated.


vim +/readq_relaxed +53 drivers/cpufreq/apple-soc-cpufreq.c

    48	
    49	static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
    50	{
    51		struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
    52		struct apple_cpu_priv *priv = policy->driver_data;
  > 53		u64 reg = readq_relaxed(priv->reg_base + APPLE_CLUSTER_PSTATE);
    54		unsigned int pstate = FIELD_GET(APPLE_CLUSTER_PSTATE_DESIRED1, reg);
    55		unsigned int i;
    56	
    57		for (i = 0; policy->freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
    58			if (policy->freq_table[i].driver_data == pstate)
    59				return policy->freq_table[i].frequency;
    60	
    61		dev_err(priv->cpu_dev, "could not find frequency for pstate %d\n", pstate);
    62		return 0;
    63	}
    64	
    65	static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
    66	{
    67		struct apple_cpu_priv *priv = policy->driver_data;
    68		unsigned int pstate = policy->freq_table[index].driver_data;
    69		u64 reg;
    70	
  > 71		if (readq_poll_timeout_atomic(priv->reg_base + APPLE_CLUSTER_PSTATE, reg,
    72					      !(reg & APPLE_CLUSTER_PSTATE_BUSY), 2,
    73					      APPLE_CLUSTER_SWITCH_TIMEOUT)) {
    74			return -EIO;
    75		}
    76	
    77		reg &= ~(APPLE_CLUSTER_PSTATE_DESIRED1 | APPLE_CLUSTER_PSTATE_DESIRED2);
    78		reg |= FIELD_PREP(APPLE_CLUSTER_PSTATE_DESIRED1, pstate);
    79		reg |= FIELD_PREP(APPLE_CLUSTER_PSTATE_DESIRED2, pstate);
    80		reg |= APPLE_CLUSTER_PSTATE_SET;
    81	
  > 82		writeq_relaxed(reg, priv->reg_base + APPLE_CLUSTER_PSTATE);
    83	
    84		return 0;
    85	}
    86	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
