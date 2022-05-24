Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8840532FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiEXRnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEXRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:43:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D65AA58
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653414196; x=1684950196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sQ21hZ3NqO9CD0q8g7zCgOtuND/EpE6kaxWviayFF8Q=;
  b=Ls/9Zs877y6uwzPSOcUonfL4UeZqAqm9mHyTayN1mC46PnrrR47j3zJ4
   P9dmd/KzlwIrivysDtdaa2tnxwFCN8iEetZo2e0FmDrmf1JVxfEHzxTdA
   QfB9yvGKJ5iSTM9SyYa2h97KX9OnMjAo0VLsJbWb4vcFYBYrw5T+lRjuA
   65ozKF3Uq0yXiJLe41qS/+uVKaPp1mE+GTGn+O8xOgL6YqHNF7TV7DZmk
   UOetEEUV8Em8d7fvCsFp1d/WB1CBJL9sVupeG09RZTBeGPLAXThlIRV5x
   Ne1Ss/NvF073c+mo/oP5BtNd4STuYiSVIEPVpguBrSUxfzuJX6Vtx/CmK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261213429"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="261213429"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 10:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="703564143"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2022 10:36:02 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntYRu-0002Ic-8d;
        Tue, 24 May 2022 17:36:02 +0000
Date:   Wed, 25 May 2022 01:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 11/15]
 drivers/power/reset/macsmc-reboot.c:142:37: warning: 'struct power_off_data'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202205250137.Na53MUGN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   0a0b49938a3205cb2b05078117b87673c37ed319
commit: 233aeafea99e125604d8d5afa06a37c38cd0b93e [11/15] power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205250137.Na53MUGN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/233aeafea99e125604d8d5afa06a37c38cd0b93e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 233aeafea99e125604d8d5afa06a37c38cd0b93e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/input/misc/ drivers/power/reset/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/reset/macsmc-reboot.c:54:32: error: field 'sys_off' has incomplete type
      54 |         struct sys_off_handler sys_off;
         |                                ^~~~~~~
>> drivers/power/reset/macsmc-reboot.c:142:37: warning: 'struct power_off_data' declared inside parameter list will not be visible outside of this definition or declaration
     142 | static void macsmc_power_off(struct power_off_data *data)
         |                                     ^~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_power_off':
   drivers/power/reset/macsmc-reboot.c:144:44: error: invalid use of undefined type 'struct power_off_data'
     144 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c: At top level:
>> drivers/power/reset/macsmc-reboot.c:156:35: warning: 'struct restart_data' declared inside parameter list will not be visible outside of this definition or declaration
     156 | static void macsmc_restart(struct restart_data *data)
         |                                   ^~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_restart':
   drivers/power/reset/macsmc-reboot.c:158:44: error: invalid use of undefined type 'struct restart_data'
     158 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c: At top level:
>> drivers/power/reset/macsmc-reboot.c:170:42: warning: 'struct reboot_prep_data' declared inside parameter list will not be visible outside of this definition or declaration
     170 | static void macsmc_reboot_prepare(struct reboot_prep_data *data)
         |                                          ^~~~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_reboot_prepare':
   drivers/power/reset/macsmc-reboot.c:172:44: error: invalid use of undefined type 'struct reboot_prep_data'
     172 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c:176:21: error: invalid use of undefined type 'struct reboot_prep_data'
     176 |         switch (data->mode) {
         |                     ^~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_reboot_probe':
   drivers/power/reset/macsmc-reboot.c:289:44: error: 'RESTART_PRIO_HIGH' undeclared (first use in this function)
     289 |         reboot->sys_off.restart_priority = RESTART_PRIO_HIGH;
         |                                            ^~~~~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c:289:44: note: each undeclared identifier is reported only once for each function it appears in
   drivers/power/reset/macsmc-reboot.c:292:15: error: implicit declaration of function 'devm_register_sys_off_handler' [-Werror=implicit-function-declaration]
     292 |         ret = devm_register_sys_off_handler(&pdev->dev, &reboot->sys_off);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +142 drivers/power/reset/macsmc-reboot.c

   104	
   105	static ssize_t macsmc_ac_power_mode_show(struct device *dev,
   106						 struct device_attribute *attr, char *buf)
   107	{
   108		struct macsmc_reboot *reboot = dev_get_drvdata(dev);
   109		int len = 0;
   110		int i;
   111		int mode = nvmem_cell_get_u8(reboot->nvm.pm_setting);
   112	
   113		if (mode < 0)
   114			return mode;
   115	
   116		for (i = 0; i < ARRAY_SIZE(ac_power_mode_map); i++)
   117			if (mode == ac_power_mode_map[i])
   118				len += scnprintf(buf+len, PAGE_SIZE-len,
   119						 "[%s] ", ac_power_modes[i]);
   120			else
   121				len += scnprintf(buf+len, PAGE_SIZE-len,
   122						 "%s ", ac_power_modes[i]);
   123		buf[len-1] = '\n';
   124		return len;
   125	}
   126	static DEVICE_ATTR(ac_power_mode, 0644, macsmc_ac_power_mode_show,
   127			   macsmc_ac_power_mode_store);
   128	
   129	/*
   130	 * SMC 'MBSE' key actions:
   131	 *
   132	 * 'offw' - shutdown warning
   133	 * 'slpw' - sleep warning
   134	 * 'rest' - restart warning
   135	 * 'off1' - shutdown (needs PMU bit set to stay on)
   136	 * 'susp' - suspend
   137	 * 'phra' - restart ("PE Halt Restart Action"?)
   138	 * 'panb' - panic beginning
   139	 * 'pane' - panic end
   140	 */
   141	
 > 142	static void macsmc_power_off(struct power_off_data *data)
   143	{
   144		struct macsmc_reboot *reboot = data->cb_data;
   145	
   146		dev_info(reboot->dev, "Issuing power off (off1)\n");
   147	
   148		if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(off1)) < 0) {
   149			dev_err(reboot->dev, "Failed to issue MBSE = off1 (power_off)\n");
   150		} else {
   151			mdelay(100);
   152			WARN_ON(1);
   153		}
   154	}
   155	
 > 156	static void macsmc_restart(struct restart_data *data)
   157	{
   158		struct macsmc_reboot *reboot = data->cb_data;
   159	
   160		dev_info(reboot->dev, "Issuing restart (phra)\n");
   161	
   162		if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(phra)) < 0) {
   163			dev_err(reboot->dev, "Failed to issue MBSE = phra (restart)\n");
   164		} else {
   165			mdelay(100);
   166			WARN_ON(1);
   167		}
   168	}
   169	
 > 170	static void macsmc_reboot_prepare(struct reboot_prep_data *data)
   171	{
   172		struct macsmc_reboot *reboot = data->cb_data;
   173		u32 val;
   174		u8 shutdown_flag;
   175	
   176		switch (data->mode) {
   177			case SYS_RESTART:
   178				val = SMC_KEY(rest);
   179				shutdown_flag = 0;
   180				break;
   181			case SYS_POWER_OFF:
   182				val = SMC_KEY(offw);
   183				shutdown_flag = 1;
   184				break;
   185			default:
   186				return;
   187		}
   188	
   189		dev_info(reboot->dev, "Preparing for reboot (%p4ch)\n", &val);
   190	
   191		/* On the Mac Mini, this will turn off the LED for power off */
   192		if (apple_smc_write_u32(reboot->smc, SMC_KEY(MBSE), val) < 0)
   193			dev_err(reboot->dev, "Failed to issue MBSE = %p4ch (reboot_prepare)\n", &val);
   194	
   195		/* Set the boot_stage to 0, which means we're doing a clean shutdown/reboot. */
   196		if (reboot->nvm.boot_stage &&
   197		    nvmem_cell_set_u8(reboot->nvm.boot_stage, BOOT_STAGE_SHUTDOWN) < 0)
   198			dev_err(reboot->dev, "Failed to write boot_stage\n");
   199	
   200		/*
   201		 * Set the PMU flag to actually reboot into the off state.
   202		 * Without this, the device will just reboot. We make it optional in case it is no longer
   203		 * necessary on newer hardware.
   204		 */
   205		if (reboot->nvm.shutdown_flag &&
   206		    nvmem_cell_set_u8(reboot->nvm.shutdown_flag, shutdown_flag) < 0)
   207			dev_err(reboot->dev, "Failed to write shutdown_flag\n");
   208	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
