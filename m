Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC4518958
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiECQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiECQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:12:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F43191E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651594145; x=1683130145;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8wxgvauVYuf841d+tdRlrdA6sWSp7DMEF+fhN9R82Qw=;
  b=PPfyR1tghkzhuIF05arIlUweSVfwsun29GUu8ahdNuBAbxVhaPN+9uJI
   fiULeobXYxitlEduqRXLsSVxUFjwScXANAU92W5FihbA0Hl50cOiOwF27
   TktPs8pa0li6SfIzot1V+gSJ2OMbtqVrPmvFng7yUOTAngQInrz2b9UbX
   A0zmGXpmEoe0vudvoA9knhM6MOVV7Rb9awZwN3Zur+heXmox3ptX/Biju
   swr753IMoiRW/dpMdKrbGwsbUJ2NrlhH9KQCszunA5Ho51U6zv+8ZHSoL
   OrLCUFpBIlC5hIPyV4KkkvQv8sLSDffqJfnDQdLUljhRamkWc1CdaXZvW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267671918"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267671918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="631565347"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2022 09:09:04 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlv5D-000AbJ-NM;
        Tue, 03 May 2022 16:09:03 +0000
Date:   Wed, 4 May 2022 00:08:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/130-cpufreq 3/4]
 drivers/cpufreq/apple-soc-cpufreq.c:67:19: error: implicit declaration of
 function 'readq_relaxed'; did you mean 'readl_relaxed'?
Message-ID: <202205040029.C0d0tIsn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/130-cpufreq
head:   b7105141d60ddab11c03955ae5389fc7f2a369da
commit: 3580ed2b7ae9f66539990a47a90aa71308dab079 [3/4] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205040029.C0d0tIsn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/3580ed2b7ae9f66539990a47a90aa71308dab079
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/130-cpufreq
        git checkout 3580ed2b7ae9f66539990a47a90aa71308dab079
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
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
