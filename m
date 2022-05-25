Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9505339E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiEYJ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiEYJ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:26:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517D13D7B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653470811; x=1685006811;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3Mk+HiCXsIdJlN/601miG3cWBd1r5Ku/CieJhcF/R7Q=;
  b=gw+NUaE7vS39pZ1RcDKsOGIucBgfaQf9/hLmvhuB93jdgS1L6R8yZFK0
   +gKamC32/yETuWj0IsQNO1tXNU+EofkZ2TrfqWC8K3A+IwS7A0T08Ww/S
   0DBpTvnHGPxIe9Bo4hkYbouHJxUXvAaL602NEnokqvPYSloFdJH0VOrza
   zpikPQvVk1AHeLD5Mfr3mzppTmcNqiZW5YNwipW9qpRvQYs+CjyBsYdbL
   iuiAieh5/34qFdDWpXc/r636Og3NOnoaBiUOhIbv+rOLKzg8pL5mrIwsS
   jxENK7iuVFShA/nSpP3DPVeN6wCpcXSkDdH0OKrHydIvx5lq1933MQk2o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273493778"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273493778"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 02:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745602525"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2022 02:26:49 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntnI0-0002us-U3;
        Wed, 25 May 2022 09:26:48 +0000
Date:   Wed, 25 May 2022 17:26:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 11/15]
 drivers/power/reset/macsmc-reboot.c:142:37: warning: declaration of 'struct
 power_off_data' will not be visible outside of this function
Message-ID: <202205251716.7SXNfLsY-lkp@intel.com>
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
config: arm64-randconfig-r034-20220524 (https://download.01.org/0day-ci/archive/20220525/202205251716.7SXNfLsY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/233aeafea99e125604d8d5afa06a37c38cd0b93e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 233aeafea99e125604d8d5afa06a37c38cd0b93e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/power/reset/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/reset/macsmc-reboot.c:54:25: error: field has incomplete type 'struct sys_off_handler'
           struct sys_off_handler sys_off;
                                  ^
   drivers/power/reset/macsmc-reboot.c:54:9: note: forward declaration of 'struct sys_off_handler'
           struct sys_off_handler sys_off;
                  ^
>> drivers/power/reset/macsmc-reboot.c:142:37: warning: declaration of 'struct power_off_data' will not be visible outside of this function [-Wvisibility]
   static void macsmc_power_off(struct power_off_data *data)
                                       ^
   drivers/power/reset/macsmc-reboot.c:144:37: error: incomplete definition of type 'struct power_off_data'
           struct macsmc_reboot *reboot = data->cb_data;
                                          ~~~~^
   drivers/power/reset/macsmc-reboot.c:142:37: note: forward declaration of 'struct power_off_data'
   static void macsmc_power_off(struct power_off_data *data)
                                       ^
>> drivers/power/reset/macsmc-reboot.c:156:35: warning: declaration of 'struct restart_data' will not be visible outside of this function [-Wvisibility]
   static void macsmc_restart(struct restart_data *data)
                                     ^
   drivers/power/reset/macsmc-reboot.c:158:37: error: incomplete definition of type 'struct restart_data'
           struct macsmc_reboot *reboot = data->cb_data;
                                          ~~~~^
   drivers/power/reset/macsmc-reboot.c:156:35: note: forward declaration of 'struct restart_data'
   static void macsmc_restart(struct restart_data *data)
                                     ^
>> drivers/power/reset/macsmc-reboot.c:170:42: warning: declaration of 'struct reboot_prep_data' will not be visible outside of this function [-Wvisibility]
   static void macsmc_reboot_prepare(struct reboot_prep_data *data)
                                            ^
   drivers/power/reset/macsmc-reboot.c:172:37: error: incomplete definition of type 'struct reboot_prep_data'
           struct macsmc_reboot *reboot = data->cb_data;
                                          ~~~~^
   drivers/power/reset/macsmc-reboot.c:170:42: note: forward declaration of 'struct reboot_prep_data'
   static void macsmc_reboot_prepare(struct reboot_prep_data *data)
                                            ^
   drivers/power/reset/macsmc-reboot.c:176:14: error: incomplete definition of type 'struct reboot_prep_data'
           switch (data->mode) {
                   ~~~~^
   drivers/power/reset/macsmc-reboot.c:170:42: note: forward declaration of 'struct reboot_prep_data'
   static void macsmc_reboot_prepare(struct reboot_prep_data *data)
                                            ^
   drivers/power/reset/macsmc-reboot.c:289:37: error: use of undeclared identifier 'RESTART_PRIO_HIGH'
           reboot->sys_off.restart_priority = RESTART_PRIO_HIGH;
                                              ^
   drivers/power/reset/macsmc-reboot.c:292:8: error: call to undeclared function 'devm_register_sys_off_handler'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ret = devm_register_sys_off_handler(&pdev->dev, &reboot->sys_off);
                 ^
   3 warnings and 7 errors generated.


vim +142 drivers/power/reset/macsmc-reboot.c

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
