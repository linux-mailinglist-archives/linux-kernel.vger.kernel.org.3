Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9E496536
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382180AbiAUSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:41:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:29686 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbiAUSlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642790463; x=1674326463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cDrSv14IJsKfbLzS3nOUwW7kmJA5KzzZfgsJttiEtlI=;
  b=D5CtUI/3qFst8pefuBpaxxePNm89cc5IJdVA2fboxXRUD4lONHxXB/FZ
   YJ5WJ8f8vMcNhwhPd9oQYj4M2VfQpnbN4wqglZ1mruCWSFj3vSRETTRqD
   xCZDeZ7NQ58YWHJB8ea6dI9yO4/f2CY0u7lay8kBpWC9zaOrQg8/ecq+T
   oaYSYVgPYk7saCXHECYPI4C+069IEG2V718nlfH4UktXwUxRUEnSgPI4+
   8xIwGiZ02kG+WAtA1wWw31HykkgTBHml1h8meivgsIeQ9t6CfKvUVuShq
   zlg6S4MtzUHbOr//Z1qENBVwUYb9V3YJf3au2NeugRng0Au9dJHALGlFm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244544496"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="244544496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="596213119"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2022 10:41:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAyqK-000FZX-5r; Fri, 21 Jan 2022 18:41:00 +0000
Date:   Sat, 22 Jan 2022 02:40:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ashish Mhetre <amhetre@nvidia.com>, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Snikam@nvidia.com, vdumpa@nvidia.com,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [Patch V3] memory: tegra: Add MC error logging on tegra186 onward
Message-ID: <202201220256.pOvahFTK-lkp@intel.com>
References: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashish,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on next-20220121]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ashish-Mhetre/memory-tegra-Add-MC-error-logging-on-tegra186-onward/20220121-192115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arc-randconfig-r043-20220121 (https://download.01.org/0day-ci/archive/20220122/202201220256.pOvahFTK-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c76ed3ccfbb800c6a32b27d87b2d5464ebdf1918
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ashish-Mhetre/memory-tegra-Add-MC-error-logging-on-tegra186-onward/20220121-192115
        git checkout c76ed3ccfbb800c6a32b27d87b2d5464ebdf1918
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/memory/tegra/mc.c: In function 'tegra30_mc_handle_irq':
>> drivers/memory/tegra/mc.c:530:21: warning: variable 'addr_hi_reg' set but not used [-Wunused-but-set-variable]
     530 |                 u32 addr_hi_reg = 0, status_reg, addr_reg;
         |                     ^~~~~~~~~~~


vim +/addr_hi_reg +530 drivers/memory/tegra/mc.c

   516	
   517	irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
   518	{
   519		struct tegra_mc *mc = data;
   520		unsigned long status;
   521		unsigned int bit;
   522	
   523		/* mask all interrupts to avoid flooding */
   524		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
   525		if (!status)
   526			return IRQ_NONE;
   527	
   528		for_each_set_bit(bit, &status, 32) {
   529			const char *error = tegra_mc_status_names[bit] ?: "unknown";
 > 530			u32 addr_hi_reg = 0, status_reg, addr_reg;
   531			const char *client = "unknown", *desc;
   532			const char *direction, *secure;
   533			phys_addr_t addr = 0;
   534			unsigned int i;
   535			char perm[7];
   536			u8 id, type;
   537			u32 value;
   538	
   539			switch (bit) {
   540			case MC_INT_DECERR_VPR:
   541				status_reg = MC_ERR_VPR_STATUS;
   542				addr_reg = MC_ERR_VPR_ADR;
   543				break;
   544			case MC_INT_SECERR_SEC:
   545				status_reg = MC_ERR_SEC_STATUS;
   546				addr_reg = MC_ERR_SEC_ADR;
   547				break;
   548			case MC_INT_DECERR_MTS:
   549				status_reg = MC_ERR_MTS_STATUS;
   550				addr_reg = MC_ERR_MTS_ADR;
   551				break;
   552			case MC_INT_DECERR_GENERALIZED_CARVEOUT:
   553				status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS;
   554				addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR;
   555				break;
   556			case MC_INT_DECERR_ROUTE_SANITY:
   557				status_reg = MC_ERR_ROUTE_SANITY_STATUS;
   558				addr_reg = MC_ERR_ROUTE_SANITY_ADR;
   559				break;
   560			default:
   561				status_reg = MC_ERR_STATUS;
   562				addr_reg = MC_ERR_ADR;
   563				if (mc->soc->has_addr_hi_reg)
   564					addr_hi_reg = MC_ERR_ADR_HI;
   565				break;
   566			}
   567	
   568			value = mc_readl(mc, status_reg);
   569	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
