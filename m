Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C564563EB0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 07:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiGBFtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 01:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBFtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 01:49:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395D14D03
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 22:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656740978; x=1688276978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eXYYhqn24UsX2+4HZR/pQzEbmFZDF9NSYrwQExyhUbs=;
  b=TVBFd+6MW53h5HeoOMJVo4arXPdbIyM3NDCbZOFYfhB6L5HdDEYOaNpc
   6cVvjPiublL/mOCD1z+qEc1hUhqL5EGiAjOzXXUdqGKbEowfh5SoS+ErB
   KJBk9oO7CW7m3Tn/J1x84m8UdCcOaG5KE2M235zLTic3F8Q3SuMMSAX7l
   2cenpG4j6YbFTXqzliGEJW2lxzCgAYzWD4Lvm8pK9BudPl72t4GZiZ54A
   rJTMeI4gEG2Xdj4jB5KGtjiFMOWc3PYzaJem55lF4MFXiUiwANw7Q/P6A
   dWfVQqoFYMkU+tgd+3kEII70PJhq72a+s46Ku3xFlzTAKolovzXWrpW+f
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281558296"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="281558296"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 22:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="838289925"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2022 22:49:36 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7W0e-000EsG-2i;
        Sat, 02 Jul 2022 05:49:36 +0000
Date:   Sat, 2 Jul 2022 13:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 11/18]
 drivers/power/reset/macsmc-reboot.c:54:32: error: field 'sys_off' has
 incomplete type
Message-ID: <202207021349.iWcinYX2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

FYI, the error/warning still remains.

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   7134ed1436e4c0b4863232587a333a544f9e871a
commit: 233aeafea99e125604d8d5afa06a37c38cd0b93e [11/18] power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220702/202207021349.iWcinYX2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/233aeafea99e125604d8d5afa06a37c38cd0b93e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 233aeafea99e125604d8d5afa06a37c38cd0b93e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/power/reset/macsmc-reboot.c:54:32: error: field 'sys_off' has incomplete type
      54 |         struct sys_off_handler sys_off;
         |                                ^~~~~~~
   drivers/power/reset/macsmc-reboot.c:142:37: warning: 'struct power_off_data' declared inside parameter list will not be visible outside of this definition or declaration
     142 | static void macsmc_power_off(struct power_off_data *data)
         |                                     ^~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_power_off':
>> drivers/power/reset/macsmc-reboot.c:144:44: error: invalid use of undefined type 'struct power_off_data'
     144 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c: At top level:
   drivers/power/reset/macsmc-reboot.c:156:35: warning: 'struct restart_data' declared inside parameter list will not be visible outside of this definition or declaration
     156 | static void macsmc_restart(struct restart_data *data)
         |                                   ^~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_restart':
>> drivers/power/reset/macsmc-reboot.c:158:44: error: invalid use of undefined type 'struct restart_data'
     158 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c: At top level:
   drivers/power/reset/macsmc-reboot.c:170:42: warning: 'struct reboot_prep_data' declared inside parameter list will not be visible outside of this definition or declaration
     170 | static void macsmc_reboot_prepare(struct reboot_prep_data *data)
         |                                          ^~~~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_reboot_prepare':
>> drivers/power/reset/macsmc-reboot.c:172:44: error: invalid use of undefined type 'struct reboot_prep_data'
     172 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c:176:21: error: invalid use of undefined type 'struct reboot_prep_data'
     176 |         switch (data->mode) {
         |                     ^~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_reboot_probe':
>> drivers/power/reset/macsmc-reboot.c:289:44: error: 'RESTART_PRIO_HIGH' undeclared (first use in this function)
     289 |         reboot->sys_off.restart_priority = RESTART_PRIO_HIGH;
         |                                            ^~~~~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c:289:44: note: each undeclared identifier is reported only once for each function it appears in
   drivers/power/reset/macsmc-reboot.c:292:15: error: implicit declaration of function 'devm_register_sys_off_handler' [-Werror=implicit-function-declaration]
     292 |         ret = devm_register_sys_off_handler(&pdev->dev, &reboot->sys_off);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sys_off +54 drivers/power/reset/macsmc-reboot.c

    50	
    51	struct macsmc_reboot {
    52		struct device *dev;
    53		struct apple_smc *smc;
  > 54		struct sys_off_handler sys_off;
    55	
    56		union {
    57			struct macsmc_reboot_nvmem nvm;
    58			struct nvmem_cell *nvm_cells[ARRAY_SIZE(nvmem_names)];
    59		};
    60	};
    61	
    62	/* Helpers to read/write a u8 given a struct nvmem_cell */
    63	static int nvmem_cell_get_u8(struct nvmem_cell *cell)
    64	{
    65		size_t len;
    66		u8 val;
    67		void *ret = nvmem_cell_read(cell, &len);
    68	
    69		if (IS_ERR(ret))
    70			return PTR_ERR(ret);
    71	
    72		if (len < 1) {
    73			kfree(ret);
    74			return -EINVAL;
    75		}
    76	
    77		val = *(u8 *)ret;
    78		kfree(ret);
    79		return val;
    80	}
    81	
    82	static int nvmem_cell_set_u8(struct nvmem_cell *cell, u8 val)
    83	{
    84		return nvmem_cell_write(cell, &val, sizeof(val));
    85	}
    86	
    87	static ssize_t macsmc_ac_power_mode_store(struct device *dev, struct device_attribute *attr,
    88						  const char *buf, size_t n)
    89	{
    90		struct macsmc_reboot *reboot = dev_get_drvdata(dev);
    91		int mode;
    92		int ret;
    93	
    94		mode = sysfs_match_string(ac_power_modes, buf);
    95		if (mode < 0)
    96			return mode;
    97	
    98		ret = nvmem_cell_set_u8(reboot->nvm.pm_setting, ac_power_mode_map[mode]);
    99		if (ret < 0)
   100			return ret;
   101	
   102		return n;
   103	}
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
   142	static void macsmc_power_off(struct power_off_data *data)
   143	{
 > 144		struct macsmc_reboot *reboot = data->cb_data;
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
   156	static void macsmc_restart(struct restart_data *data)
   157	{
 > 158		struct macsmc_reboot *reboot = data->cb_data;
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
   170	static void macsmc_reboot_prepare(struct reboot_prep_data *data)
   171	{
 > 172		struct macsmc_reboot *reboot = data->cb_data;
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
