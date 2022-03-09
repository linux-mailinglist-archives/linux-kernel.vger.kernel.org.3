Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02C4D28F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiCIGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiCIGVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:21:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D6AD114
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646806857; x=1678342857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FEBjuhpSqst2rdbWycevjrz0R03BgDLLODcqjlpZYeI=;
  b=hOUSYe/6pU52mV9R0d7CcmXPdcQSagzHaRUJE+/hrU2vJLX2JWqPaIPH
   Ud0zbpBgPtdH6LCTVp1R1vn0V4EaDkkdmrkIVV4VA+FEXSG3HwRIRqUcD
   UdCwLs17oMb9bL1lPMDIJ1ubTrEkGI/uwKXacCZnGFhAVfCJOsqjqqNAO
   reTDO9iYcxHvAyoyBdDifaDCEYF3P8CdbZOttAcgEXN2jl+4r2w4Gef53
   OA1xd/JXXOeRO9XPq/bME3vZAO1Lh1JMGxCLpIVcbt3IEBAw6UUhsASQH
   rK2PHbFDMt9HeZCdfOdW9W4j7zSUSr0+6j+/VdaufHNgI529qIzGnZhRD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341328841"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="341328841"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="578277026"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 22:20:55 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRpgs-0002jI-IK; Wed, 09 Mar 2022 06:20:54 +0000
Date:   Wed, 9 Mar 2022 14:20:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 12/14]
 drivers/power/reset/macsmc-reboot.c:54:32: error: field 'sys_off' has
 incomplete type
Message-ID: <202203091434.JIIFkLz9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   fc585c48a7b76dfddc48b92c764b619a36435404
commit: 3cf205239c2cc567e68c927a11f08d5aebd6d08d [12/14] power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC
config: arm64-randconfig-r031-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091434.JIIFkLz9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/3cf205239c2cc567e68c927a11f08d5aebd6d08d
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 3cf205239c2cc567e68c927a11f08d5aebd6d08d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/input/misc/ drivers/power/reset/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/power/reset/macsmc-reboot.c:54:32: error: field 'sys_off' has incomplete type
      54 |         struct sys_off_handler sys_off;
         |                                ^~~~~~~
>> drivers/power/reset/macsmc-reboot.c:142:37: warning: 'struct power_off_data' declared inside parameter list will not be visible outside of this definition or declaration
     142 | static void macsmc_power_off(struct power_off_data *data)
         |                                     ^~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_power_off':
>> drivers/power/reset/macsmc-reboot.c:144:44: error: invalid use of undefined type 'struct power_off_data'
     144 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c: At top level:
>> drivers/power/reset/macsmc-reboot.c:152:35: warning: 'struct restart_data' declared inside parameter list will not be visible outside of this definition or declaration
     152 | static void macsmc_restart(struct restart_data *data)
         |                                   ^~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_restart':
>> drivers/power/reset/macsmc-reboot.c:154:44: error: invalid use of undefined type 'struct restart_data'
     154 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c: At top level:
>> drivers/power/reset/macsmc-reboot.c:166:42: warning: 'struct reboot_prep_data' declared inside parameter list will not be visible outside of this definition or declaration
     166 | static void macsmc_reboot_prepare(struct reboot_prep_data *data)
         |                                          ^~~~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_reboot_prepare':
>> drivers/power/reset/macsmc-reboot.c:168:44: error: invalid use of undefined type 'struct reboot_prep_data'
     168 |         struct macsmc_reboot *reboot = data->cb_data;
         |                                            ^~
   drivers/power/reset/macsmc-reboot.c:172:21: error: invalid use of undefined type 'struct reboot_prep_data'
     172 |         switch (data->mode) {
         |                     ^~
   drivers/power/reset/macsmc-reboot.c: In function 'macsmc_reboot_probe':
>> drivers/power/reset/macsmc-reboot.c:285:44: error: 'RESTART_PRIO_HIGH' undeclared (first use in this function)
     285 |         reboot->sys_off.restart_priority = RESTART_PRIO_HIGH;
         |                                            ^~~~~~~~~~~~~~~~~
   drivers/power/reset/macsmc-reboot.c:285:44: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/power/reset/macsmc-reboot.c:288:15: error: implicit declaration of function 'devm_register_sys_off_handler' [-Werror=implicit-function-declaration]
     288 |         ret = devm_register_sys_off_handler(&pdev->dev, &reboot->sys_off);
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
 > 142	static void macsmc_power_off(struct power_off_data *data)
   143	{
 > 144		struct macsmc_reboot *reboot = data->cb_data;
   145	
   146		dev_info(reboot->dev, "Issuing power off (off1)\n");
   147	
   148		if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(off1)) < 0)
   149			dev_err(reboot->dev, "Failed to issue MBSE = off1 (power_off)\n");
   150	}
   151	
 > 152	static void macsmc_restart(struct restart_data *data)
   153	{
 > 154		struct macsmc_reboot *reboot = data->cb_data;
   155	
   156		dev_info(reboot->dev, "Issuing restart (phra)\n");
   157	
   158		if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(phra)) < 0) {
   159			dev_err(reboot->dev, "Failed to issue MBSE = phra (restart)\n");
   160		} else {
   161			mdelay(100);
   162			WARN_ON(1);
   163		}
   164	}
   165	
 > 166	static void macsmc_reboot_prepare(struct reboot_prep_data *data)
   167	{
 > 168		struct macsmc_reboot *reboot = data->cb_data;
   169		u32 val;
   170		u8 shutdown_flag;
   171	
   172		switch (data->mode) {
   173			case SYS_RESTART:
   174				val = SMC_KEY(rest);
   175				shutdown_flag = 0;
   176				break;
   177			case SYS_POWER_OFF:
   178				val = SMC_KEY(offw);
   179				shutdown_flag = 1;
   180				break;
   181			default:
   182				return;
   183		}
   184	
   185		dev_info(reboot->dev, "Preparing for reboot (%p4ch)\n", &val);
   186	
   187		/* On the Mac Mini, this will turn off the LED for power off */
   188		if (apple_smc_write_u32(reboot->smc, SMC_KEY(MBSE), val) < 0)
   189			dev_err(reboot->dev, "Failed to issue MBSE = %p4ch (reboot_prepare)\n", &val);
   190	
   191		/* Set the boot_stage to 0, which means we're doing a clean shutdown/reboot. */
   192		if (reboot->nvm.boot_stage &&
   193		    nvmem_cell_set_u8(reboot->nvm.boot_stage, BOOT_STAGE_SHUTDOWN) < 0)
   194			dev_err(reboot->dev, "Failed to write boot_stage\n");
   195	
   196		/*
   197		 * Set the PMU flag to actually reboot into the off state.
   198		 * Without this, the device will just reboot. We make it optional in case it is no longer
   199		 * necessary on newer hardware.
   200		 */
   201		if (reboot->nvm.shutdown_flag &&
   202		    nvmem_cell_set_u8(reboot->nvm.shutdown_flag, shutdown_flag) < 0)
   203			dev_err(reboot->dev, "Failed to write shutdown_flag\n");
   204	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
