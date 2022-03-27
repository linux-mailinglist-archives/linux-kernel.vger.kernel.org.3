Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF324E8928
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiC0SAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiC0R75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:59:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC82DD5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648403898; x=1679939898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/NNXenqLNixW/cbZ0QFlQUJZoB/bisBRV3IUzRk89RY=;
  b=ZBcA2r15ZnXBffqjEFzNO5DFanlKvxDhQHSo6b7htH9Z9TLMI2WIn3r9
   /H1PUZqwfnQM6n5rzla7KLDLpJta3vgnwdHket/4buow7A8YWM2+dKVpw
   bm4pU56QY221VcxpnGTtNLeErk7FUjMGBPAZRn2jFg5C4jD+YVUb0XWiO
   KBjme/u26i3EpHv9nTWKK6SfI+DGkcBfMjsRD4bNt+3dlfr98g+3GcVVS
   TH7rOA+FQgQ1qWConjHrM9HeiC5MD3gjcHQ8YIf4rVOnvvhO9lXHWmehO
   5Bzd+ylK9dLSqMHq5SmjC1QU50HHZhqlO83IU2zLaJtmwblEWyhdyGqo+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="322055657"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="322055657"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 10:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="545684972"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2022 10:58:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYX9c-0001IN-7x; Sun, 27 Mar 2022 17:58:16 +0000
Date:   Mon, 28 Mar 2022 01:57:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/22 112/189]
 drivers/cpufreq/apple-soc-cpufreq.c:53:19: error: implicit declaration of
 function 'readq_relaxed'; did you mean 'readw_relaxed'?
Message-ID: <202203280127.gqfnFfId-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: 97012c133dff8f4ad7de4c8d34cf327567c8e3d8 [112/189] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220328/202203280127.gqfnFfId-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/97012c133dff8f4ad7de4c8d34cf327567c8e3d8
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout 97012c133dff8f4ad7de4c8d34cf327567c8e3d8
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
>> include/linux/iopoll.h:165:35: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
     165 |         readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
         |                                   ^~~~~
   include/linux/iopoll.h:88:25: note: in definition of macro 'read_poll_timeout_atomic'
      88 |                 (val) = op(args); \
         |                         ^~
   include/linux/iopoll.h:165:9: note: in expansion of macro 'readx_poll_timeout_atomic'
     165 |         readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/apple-soc-cpufreq.c:71:13: note: in expansion of macro 'readq_poll_timeout_atomic'
      71 |         if (readq_poll_timeout_atomic(priv->reg_base + APPLE_CLUSTER_PSTATE, reg,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
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
    71		if (readq_poll_timeout_atomic(priv->reg_base + APPLE_CLUSTER_PSTATE, reg,
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
