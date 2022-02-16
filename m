Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8094B86F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiBPLp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:45:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiBPLpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:45:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA6238
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645011941; x=1676547941;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jkHKsbRrnER7Jh3gZVcV7yPW/87kIYtKfnj8ILxIspA=;
  b=XDc7Ejb48QPN85qLA9HLVGzP5lUnhvXUbxU4m66OsrDGs326IF8vGg03
   9RbBJS7ni1Y+9v0EH580CIdYQZerZNjVWjmdO3Xdp4QFsjPRiT4Z4AvyQ
   tfMm+kawb2fAQMVLj112tQuC6tkEc9VxBvgH/2zO9oKFBBTRxxqtlS7kT
   oNJQSRMnqi/LZdr8Ry7+Mm2U7UXbB25Yk7pRPeYYt+n0HYbDI9VFhOlLf
   Xa2HImbiOQrsIxdshLg9sTxRGiDoLfGY3B/xdlgksgXIjv7N/l8P2qqcH
   E60V+xGMi/SibqMjbchpPa6M4VSEa6QupuaIGj3UfycUwN2h1naUposIx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275166278"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="275166278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:45:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636450890"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 03:45:37 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKIkZ-000Ald-9V; Wed, 16 Feb 2022 11:45:35 +0000
Date:   Wed, 16 Feb 2022 19:44:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 364/382]
 drivers/cpufreq/apple-soc-cpufreq.c:53:19: error: implicit declaration of
 function 'readq_relaxed'; did you mean 'readl_relaxed'?
Message-ID: <202202161958.nj2B98CG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test
head:   5adfbb595194191bad98c47447ddbee7d3b60b8f
commit: d2b69a6992028350d06be95501463259969d22d2 [364/382] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220216/202202161958.nj2B98CG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d2b69a6992028350d06be95501463259969d22d2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout d2b69a6992028350d06be95501463259969d22d2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpufreq/apple-soc-cpufreq.c: In function 'apple_soc_cpufreq_get_rate':
>> drivers/cpufreq/apple-soc-cpufreq.c:53:19: error: implicit declaration of function 'readq_relaxed'; did you mean 'readl_relaxed'? [-Werror=implicit-function-declaration]
      53 |         u64 reg = readq_relaxed(priv->reg_base + APPLE_CLUSTER_PSTATE);
         |                   ^~~~~~~~~~~~~
         |                   readl_relaxed
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
>> drivers/cpufreq/apple-soc-cpufreq.c:82:9: error: implicit declaration of function 'writeq_relaxed'; did you mean 'writeb_relaxed'? [-Werror=implicit-function-declaration]
      82 |         writeq_relaxed(reg, priv->reg_base + APPLE_CLUSTER_PSTATE);
         |         ^~~~~~~~~~~~~~
         |         writeb_relaxed
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
