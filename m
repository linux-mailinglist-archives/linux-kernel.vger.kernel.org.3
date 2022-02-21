Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEBE4BEEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiBUXmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:42:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiBUXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:42:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73C2700
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486906; x=1677022906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fYeu5Jctw/mYAHLIcTQAFrxw8LR0mpOIN715Fnx9AQk=;
  b=fpYlyCJJO4aOCNFDxqimBr8+ScsqhTcic2PzwXwFED8up3+/ttfRHAbb
   FPBONqChhNbZEePFGCPIcLNBjGxD+I1rPx0WV2l9Js8T0vGrowKgfI6ud
   rYzT1tWJRalvL/c2/SCjut65cA3VQIMbPxSG7Tlqo6nc4gyY9FCb+xvPv
   i23SI++QNaZpWNWlnusuZIN/2LvyRt5ih17CrRCEAHw+71BUDbriUkXk2
   N8aKoKX7P3SwU49+Yf6T/B+/bB95VjkrRwj4BLEtW34G3ccWNn6qqyZdN
   YgjwYBp3MHeBhN4SiedVHJevYRMgpErBIzWMWNpP6O4IQFd6Qs57/HPOH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231548615"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="231548615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="591103563"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 15:41:45 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMIJN-00025V-2T; Mon, 21 Feb 2022 23:41:45 +0000
Date:   Tue, 22 Feb 2022 07:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/130-cpufreq 1/1]
 drivers/cpufreq/apple-soc-cpufreq.c:53:19: error: implicit declaration of
 function 'readq_relaxed'; did you mean 'readw_relaxed'?
Message-ID: <202202220731.UuKFmflY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/130-cpufreq
head:   d82b98403e6be88a172c566acc46f582ebd92420
commit: d82b98403e6be88a172c566acc46f582ebd92420 [1/1] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220222/202202220731.UuKFmflY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/d82b98403e6be88a172c566acc46f582ebd92420
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/130-cpufreq
        git checkout d82b98403e6be88a172c566acc46f582ebd92420
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpufreq/apple-soc-cpufreq.c: In function 'apple_soc_cpufreq_get_rate':
>> drivers/cpufreq/apple-soc-cpufreq.c:53:19: error: implicit declaration of function 'readq_relaxed'; did you mean 'readw_relaxed'? [-Werror=implicit-function-declaration]
      53 |         u64 reg = readq_relaxed(priv->reg_base + APPLE_CLUSTER_PSTATE);
         |                   ^~~~~~~~~~~~~
         |                   readw_relaxed
   In file included from drivers/cpufreq/apple-soc-cpufreq.c:20:
   drivers/cpufreq/apple-soc-cpufreq.c: In function 'apple_soc_cpufreq_set_target':
>> include/linux/iopoll.h:162:28: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
     162 |         readx_poll_timeout(readq, addr, val, cond, delay_us, timeout_us)
         |                            ^~~~~
   include/linux/iopoll.h:46:25: note: in definition of macro 'read_poll_timeout'
      46 |                 (val) = op(args); \
         |                         ^~
   include/linux/iopoll.h:162:9: note: in expansion of macro 'readx_poll_timeout'
     162 |         readx_poll_timeout(readq, addr, val, cond, delay_us, timeout_us)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/cpufreq/apple-soc-cpufreq.c:71:13: note: in expansion of macro 'readq_poll_timeout'
      71 |         if (readq_poll_timeout(priv->reg_base + APPLE_CLUSTER_PSTATE, reg,
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/apple-soc-cpufreq.c:82:9: error: implicit declaration of function 'writeq_relaxed'; did you mean 'writel_relaxed'? [-Werror=implicit-function-declaration]
      82 |         writeq_relaxed(reg, priv->reg_base + APPLE_CLUSTER_PSTATE);
         |         ^~~~~~~~~~~~~~
         |         writel_relaxed
   cc1: some warnings being treated as errors


vim +53 drivers/cpufreq/apple-soc-cpufreq.c

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
    71		if (readq_poll_timeout(priv->reg_base + APPLE_CLUSTER_PSTATE, reg,
    72				       !(reg & APPLE_CLUSTER_PSTATE_BUSY), 2,
    73				       APPLE_CLUSTER_SWITCH_TIMEOUT)) {
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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
