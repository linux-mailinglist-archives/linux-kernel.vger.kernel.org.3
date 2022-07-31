Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C333585EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiGaLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiGaLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:47:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F810562
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659268028; x=1690804028;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SRzCrz8m3EasE34Y3R1C/gn/8QB4gdMfmAwlqIY73XE=;
  b=IsZtB/CIahct8rNOIrX1yH3Djn5ZSeqDeLtfn95f7nR/B9OAa502cSZr
   /z+ck0Ku1mri2PbnR8sSok/mFmgPZoOcM86BUKBj23yh9CUiDuRU8B0gQ
   6xCvwR7Qq2Hndo5TTBSesh9J3hZtPo2pSXhJvw1TKDlAxzuE3ufM9BXF3
   zSGnO82OQLlnLEuuyjxQlils8nfhqvv5p16x7lXMFVazFK4NvD4nAGvCZ
   dJVLzM9WI2ABN4JEc91hYAerxYJUd7612DwfCuRifduTWa+Ol5+8ueMLT
   NbDflE9UElLd99AAXKfHWw1C6JkC076H0WY0U/eHGyNy7fQIM8wxASc4K
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="375292579"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375292579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 04:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629912346"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2022 04:47:06 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI7PV-000E5D-2o;
        Sun, 31 Jul 2022 11:47:05 +0000
Date:   Sun, 31 Jul 2022 19:46:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/130-cpufreq 3/5]
 drivers/cpufreq/apple-soc-cpufreq.c:67:19: error: implicit declaration of
 function 'readq_relaxed'; did you mean 'readl_relaxed'?
Message-ID: <202207311938.bhk4la4x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/130-cpufreq
head:   ed275ce5bf2d4348378a6e8ed0cba08439ae1ef4
commit: 09036df18fff78a214cfb8a5cac10d74968d28b1 [3/5] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220731/202207311938.bhk4la4x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/09036df18fff78a214cfb8a5cac10d74968d28b1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/130-cpufreq
        git checkout 09036df18fff78a214cfb8a5cac10d74968d28b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

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
  > 87		if (readq_poll_timeout_atomic(priv->reg_base + APPLE_DVFS_CMD, reg,
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
