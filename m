Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD77E558A79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiFWVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:07:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD72E9FA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656018463; x=1687554463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BRfmO2ISk50iT4TqePceG7hzZX70sV0J2KZgjpfyUpI=;
  b=mOCZEVnrlVggwA7zsBWtAY6kgmkEzz80efLIpJWWM+Q7AKLOmupkXQFc
   yM/IDUKXSpb52GcgrKK8uwRp/Ta2/MbLTdVZewsnFEQ5W2zyeuaKPrYSX
   XWqvpBfnZKvpXou4XAmUOqv3vQhxX6nofXwotGhmOaZsq/f+NJvMz1tUL
   XbkrVMCGXGeAHgwZUCdhbS4ft28QXSWU2g2+yasSVIxdG7pJpRsScVpn9
   GKkZThkKSjZ/GCI4KT4w8dMIfEzGfMVCpYrFwvtHGKT8RKn6UOOtUn5aV
   udjIPuDDKrwyfSOo2mORI9ghoxaMRSsxOMTZ0J265/6BByrigkA/v7msS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367160994"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="367160994"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 14:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="615729881"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2022 14:07:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4U3B-00039Q-05;
        Thu, 23 Jun 2022 21:07:41 +0000
Date:   Fri, 24 Jun 2022 05:07:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/130-cpufreq 3/4]
 drivers/cpufreq/apple-soc-cpufreq.c:67:19: error: implicit declaration of
 function 'readq_relaxed'; did you mean 'readl_relaxed'?
Message-ID: <202206240410.O3xJ4UZE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/130-cpufreq
head:   c1f94f72b7ae14d506b361283ef25624368b1a32
commit: 4b2ae5bd4433c2282e699dc54bd26b066ad28f85 [3/4] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220624/202206240410.O3xJ4UZE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/4b2ae5bd4433c2282e699dc54bd26b066ad28f85
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/130-cpufreq
        git checkout 4b2ae5bd4433c2282e699dc54bd26b066ad28f85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpufreq/apple-soc-cpufreq.c: In function 'apple_soc_cpufreq_get_rate':
>> drivers/cpufreq/apple-soc-cpufreq.c:67:19: error: implicit declaration of function 'readq_relaxed'; did you mean 'readl_relaxed'? [-Werror=implicit-function-declaration]
      67 |         u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
         |                   ^~~~~~~~~~~~~
         |                   readl_relaxed
   In file included from drivers/cpufreq/apple-soc-cpufreq.c:18:
   drivers/cpufreq/apple-soc-cpufreq.c: In function 'apple_soc_cpufreq_set_target':
>> include/linux/iopoll.h:165:35: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
     165 |         readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
         |                                   ^~~~~
   include/linux/iopoll.h:88:25: note: in definition of macro 'read_poll_timeout_atomic'
      88 |                 (val) = op(args); \
         |                         ^~
   include/linux/iopoll.h:165:9: note: in expansion of macro 'readx_poll_timeout_atomic'
     165 |         readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/apple-soc-cpufreq.c:87:13: note: in expansion of macro 'readq_poll_timeout_atomic'
      87 |         if (readq_poll_timeout_atomic(priv->reg_base + APPLE_DVFS_CMD, reg,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/apple-soc-cpufreq.c:98:9: error: implicit declaration of function 'writeq_relaxed'; did you mean 'writeb_relaxed'? [-Werror=implicit-function-declaration]
      98 |         writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
         |         ^~~~~~~~~~~~~~
         |         writeb_relaxed
   drivers/cpufreq/apple-soc-cpufreq.c: At top level:
   drivers/cpufreq/apple-soc-cpufreq.c:291:27: warning: initialized field overwritten [-Woverride-init]
     291 |         .attr           = apple_soc_cpufreq_hw_attr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/apple-soc-cpufreq.c:291:27: note: (near initialization for 'apple_soc_cpufreq_driver.attr')
   cc1: some warnings being treated as errors


vim +67 drivers/cpufreq/apple-soc-cpufreq.c

    62	
    63	static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
    64	{
    65		struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
    66		struct apple_cpu_priv *priv = policy->driver_data;
  > 67		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
    68		unsigned int pstate = FIELD_GET(APPLE_DVFS_STATUS_CUR_PS, reg);
    69		unsigned int i;
    70	
    71		for (i = 0; policy->freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
    72			if (policy->freq_table[i].driver_data == pstate)
    73				return policy->freq_table[i].frequency;
    74	
    75		dev_err(priv->cpu_dev, "could not find frequency for pstate %d\n",
    76			pstate);
    77		return 0;
    78	}
    79	
    80	static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
    81						unsigned int index)
    82	{
    83		struct apple_cpu_priv *priv = policy->driver_data;
    84		unsigned int pstate = policy->freq_table[index].driver_data;
    85		u64 reg;
    86	
    87		if (readq_poll_timeout_atomic(priv->reg_base + APPLE_DVFS_CMD, reg,
    88					      !(reg & APPLE_DVFS_CMD_BUSY), 2,
    89					      APPLE_DVFS_TRANSITION_TIMEOUT)) {
    90			return -EIO;
    91		}
    92	
    93		reg &= ~(APPLE_DVFS_CMD_PS1 | APPLE_DVFS_CMD_PS2);
    94		reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
    95		reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
    96		reg |= APPLE_DVFS_CMD_SET;
    97	
  > 98		writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
    99	
   100		return 0;
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
