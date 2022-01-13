Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ADA48D21B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiAMFwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 00:52:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:30119 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbiAMFwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 00:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642053156; x=1673589156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8Os+lEkokSOONG155uMKagRpkO8z6Q0iLK2V1ry4lEA=;
  b=IEgvpGzOZLKpwD6S6nEcBcP0f6kGGQadPRCvE4jUy+P2T46+aldkMCC4
   kWN3VBg96xRaRxjX9FdR5QFmBIUoQKZAjbfJmHUnJGb6JKBmAZGYEwbBG
   mXgkPGxHbg96QoILsFFO4J+TShi6WbaVrHO798rk0+vD72o3cY/0paRE3
   bw9KY4L/YGT0HIXTY27CQ96ruz4x+EEFW2TsIx1lZDp1NikhHp9bgTxdX
   jvVRHkcxt8LVz64gB6JLCj4lk7T1npLQbastSIJk8Vk0PE2n9iMrewl+B
   uWU8gzUKsabdB2bIJNrlYm6ePvygd1mQa5J2yjzVtIdpM71iAsRDqa0w8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304673577"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="304673577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 21:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="691681128"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2022 21:52:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7t2H-0006t4-AV; Thu, 13 Jan 2022 05:52:33 +0000
Date:   Thu, 13 Jan 2022 13:51:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Watson Chow <watson.chow@avnet.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/regulator/max20086-regulator.c:217:26: error: storage size
 of 'flags' isn't known
Message-ID: <202201131324.vmxL1PCz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: bfff546aae50ae68ed395bf0e0848188d27b0ba3 regulator: Add MAX20086-MAX20089 driver
date:   6 days ago
config: m68k-randconfig-r024-20220113 (https://download.01.org/0day-ci/archive/20220113/202201131324.vmxL1PCz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfff546aae50ae68ed395bf0e0848188d27b0ba3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bfff546aae50ae68ed395bf0e0848188d27b0ba3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/regulator/max20086-regulator.c: In function 'max20086_i2c_probe':
>> drivers/regulator/max20086-regulator.c:217:26: error: storage size of 'flags' isn't known
     217 |         enum gpiod_flags flags;
         |                          ^~~~~
>> drivers/regulator/max20086-regulator.c:261:27: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
     261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
         |                           ^~~~~~~~~~~~~~
         |                           GPIOF_INIT_HIGH
   drivers/regulator/max20086-regulator.c:261:27: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/regulator/max20086-regulator.c:261:44: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
     261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
         |                                            ^~~~~~~~~~~~~
         |                                            GPIOF_INIT_LOW
>> drivers/regulator/max20086-regulator.c:262:27: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
     262 |         chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
         |                           ^~~~~~~~~~~~~~
         |                           devm_gpio_free
   drivers/regulator/max20086-regulator.c:217:26: warning: unused variable 'flags' [-Wunused-variable]
     217 |         enum gpiod_flags flags;
         |                          ^~~~~
   cc1: some warnings being treated as errors


vim +217 drivers/regulator/max20086-regulator.c

   213	
   214	static int max20086_i2c_probe(struct i2c_client *i2c)
   215	{
   216		struct max20086 *chip;
 > 217		enum gpiod_flags flags;
   218		bool boot_on;
   219		int ret;
   220	
   221		chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
   222		if (!chip)
   223			return -ENOMEM;
   224	
   225		chip->dev = &i2c->dev;
   226		chip->info = device_get_match_data(chip->dev);
   227	
   228		i2c_set_clientdata(i2c, chip);
   229	
   230		chip->regmap = devm_regmap_init_i2c(i2c, &max20086_regmap_config);
   231		if (IS_ERR(chip->regmap)) {
   232			ret = PTR_ERR(chip->regmap);
   233			dev_err(chip->dev, "Failed to allocate register map: %d\n", ret);
   234			return ret;
   235		}
   236	
   237		ret = max20086_parse_regulators_dt(chip, &boot_on);
   238		if (ret < 0)
   239			return ret;
   240	
   241		ret = max20086_detect(chip);
   242		if (ret < 0)
   243			return ret;
   244	
   245		/* Until IRQ support is added, just disable all interrupts. */
   246		ret = regmap_update_bits(chip->regmap, MAX20086_REG_MASK,
   247					 MAX20086_INT_DISABLE_ALL,
   248					 MAX20086_INT_DISABLE_ALL);
   249		if (ret < 0) {
   250			dev_err(chip->dev, "Failed to disable interrupts: %d\n", ret);
   251			return ret;
   252		}
   253	
   254		/*
   255		 * Get the enable GPIO. If any of the outputs is marked as being
   256		 * enabled at boot, request the GPIO with an initial high state to
   257		 * avoid disabling outputs that may have been turned on by the boot
   258		 * loader. Otherwise, request it with a low state to enter lower-power
   259		 * shutdown.
   260		 */
 > 261		flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 > 262		chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
   263		if (IS_ERR(chip->ena_gpiod)) {
   264			ret = PTR_ERR(chip->ena_gpiod);
   265			dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
   266			return ret;
   267		}
   268	
   269		ret = max20086_regulators_register(chip);
   270		if (ret < 0) {
   271			dev_err(chip->dev, "Failed to register regulators: %d\n", ret);
   272			return ret;
   273		}
   274	
   275		return 0;
   276	}
   277	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
