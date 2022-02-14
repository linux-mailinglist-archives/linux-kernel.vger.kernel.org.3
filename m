Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF914B5D00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiBNVer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:34:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiBNVdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:33:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7E9BC8F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644874293; x=1676410293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J5mln19qbuqfaHQ0jXWsL4yEbZM1avMpygpdtMRDsME=;
  b=CLRYH8DYXlLZuPPBkeMuBmMtYCaRVfFKPzvHdLOEAXZk3Qos1ATKfEMG
   I6UZcwDACKKsYcelbMkKmGYpq2ryhyps4bSENXzGPMUhwraLaRwdA08MM
   F1OyocpP8vsr8RKBEuDyky2/rbxlIn22kleM9Sattbh7lLw933YVO90Oc
   ggQ9mB2nxNedBU77Obdl2jMD+tzj6ayv8pzjcFNq8Q1SjouSH5YaRAfK6
   vExbPo2mpmoeSiOXIlz+aNN2jEj4gSntbP/mlFW7rIN/sZbYq9/KgVEj2
   1vjvxm7MON32nGAn6np/d/cPY6n/6viO+kDfsb45bhMD0T0ywLgQJRsO/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274742722"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="274742722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="485668028"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 11:44:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJhGi-0008sb-IM; Mon, 14 Feb 2022 19:44:16 +0000
Date:   Tue, 15 Feb 2022 03:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c:96:50:
 sparse: sparse: cast removes address space '__iomem' of expression
Message-ID: <202202150359.0tDKN8pA-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: a5923b6c3137b9d4fc2ea1c997f6e4d51ac5d774 thermal: int340x: processor_thermal: Refactor MMIO interface
date:   1 year, 2 months ago
config: x86_64-randconfig-s022-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150359.0tDKN8pA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5923b6c3137b9d4fc2ea1c997f6e4d51ac5d774
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a5923b6c3137b9d4fc2ea1c997f6e4d51ac5d774
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/platform/pvh/ drivers/gpio/ drivers/mailbox/ drivers/media/cec/platform/meson/ drivers/media/cec/platform/tegra/ drivers/media/rc/ drivers/pwm/ drivers/regulator/ drivers/spi/ drivers/thermal/intel/int340x_thermal/ drivers/usb/gadget/udc/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c:96:50: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c:100:36: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +96 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c

    81	
    82	int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
    83	{
    84		const struct rapl_mmio_regs *rapl_regs = &rapl_mmio_default;
    85		enum rapl_domain_reg_id reg;
    86		enum rapl_domain_type domain;
    87		int ret;
    88	
    89		if (!rapl_regs)
    90			return 0;
    91	
    92		for (domain = RAPL_DOMAIN_PACKAGE; domain < RAPL_DOMAIN_MAX; domain++) {
    93			for (reg = RAPL_DOMAIN_REG_LIMIT; reg < RAPL_DOMAIN_REG_MAX; reg++)
    94				if (rapl_regs->regs[domain][reg])
    95					rapl_mmio_priv.regs[domain][reg] =
  > 96							(u64)proc_priv->mmio_base +
    97							rapl_regs->regs[domain][reg];
    98			rapl_mmio_priv.limits[domain] = rapl_regs->limits[domain];
    99		}
   100		rapl_mmio_priv.reg_unit = (u64)proc_priv->mmio_base + rapl_regs->reg_unit;
   101	
   102		rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
   103		rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
   104	
   105		rapl_mmio_priv.control_type = powercap_register_control_type(NULL, "intel-rapl-mmio", NULL);
   106		if (IS_ERR(rapl_mmio_priv.control_type)) {
   107			pr_debug("failed to register powercap control_type.\n");
   108			return PTR_ERR(rapl_mmio_priv.control_type);
   109		}
   110	
   111		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
   112					rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
   113		if (ret < 0) {
   114			powercap_unregister_control_type(rapl_mmio_priv.control_type);
   115			rapl_mmio_priv.control_type = NULL;
   116			return ret;
   117		}
   118		rapl_mmio_priv.pcap_rapl_online = ret;
   119	
   120		return 0;
   121	}
   122	EXPORT_SYMBOL_GPL(proc_thermal_rapl_add);
   123	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
