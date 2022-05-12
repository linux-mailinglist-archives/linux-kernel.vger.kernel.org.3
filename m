Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8E5256CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358596AbiELVBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354595AbiELVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:00:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E320F4B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652389254; x=1683925254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e4jQKep7r8+EurMhXfxPV0jLfPxTV/UjYpAHlsYVU/8=;
  b=mV6pwltWUMUNwo471AxCRBhNjVd8hJlJQUi4gZLPirC9xvcrQ0aKtzGp
   F6XECBndumNl9jmNlP7Vfxyb7yE7SNm8K7H7DBRFWVAqYRXu0gqfq+N2v
   m/wxKPBS0n4Tx+WzKVx2r85p7+dl08PS1n6lQpg0oiaEQLGI72FVpi/eh
   Ai1RfwyvzW3JF6FJ5WRmxbLW0puqY+yCFsKArjkDxB+kzOELHnfTJH+8W
   f6CnBf3m8tg3NXK1YCVvAGTxVSkPRC796/KJxwYuPgkPnpNQCs6MlMo3X
   XWw16nopu8orhjsO+depSvOAaggmc/VMt0Txk5ewNaqgy5Dbs3X+UoFKG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250036969"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250036969"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="815087845"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2022 14:00:52 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npFvX-000Kw4-It;
        Thu, 12 May 2022 21:00:51 +0000
Date:   Fri, 13 May 2022 05:00:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:linux-5.10.y 5435/5609]
 drivers/usb/phy/phy-generic.c:271:19: error: implicit declaration of
 function 'devm_regulator_get_exclusive'
Message-ID: <202205130402.6UESZaCw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   e61686bb77c441d8e5f10dc063e2cea799e4aae6
commit: d22d92230ffbbfb696f3800bf53391bb2ef6a688 [5435/5609] usb: phy: generic: Get the vbus supply
config: arm64-buildonly-randconfig-r004-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130402.6UESZaCw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=d22d92230ffbbfb696f3800bf53391bb2ef6a688
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout d22d92230ffbbfb696f3800bf53391bb2ef6a688
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/usb/phy/phy-generic.c:271:19: error: implicit declaration of function 'devm_regulator_get_exclusive' [-Werror,-Wimplicit-function-declaration]
           nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
                            ^
   drivers/usb/phy/phy-generic.c:271:19: note: did you mean 'regulator_get_exclusive'?
   include/linux/regulator/consumer.h:329:1: note: 'regulator_get_exclusive' declared here
   regulator_get_exclusive(struct device *dev, const char *id)
   ^
>> drivers/usb/phy/phy-generic.c:271:17: warning: incompatible integer to pointer conversion assigning to 'struct regulator *' from 'int' [-Wint-conversion]
           nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
                          ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/devm_regulator_get_exclusive +271 drivers/usb/phy/phy-generic.c

   205	
   206	int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
   207	{
   208		enum usb_phy_type type = USB_PHY_TYPE_USB2;
   209		int err = 0;
   210	
   211		u32 clk_rate = 0;
   212		bool needs_vcc = false, needs_clk = false;
   213	
   214		if (dev->of_node) {
   215			struct device_node *node = dev->of_node;
   216	
   217			if (of_property_read_u32(node, "clock-frequency", &clk_rate))
   218				clk_rate = 0;
   219	
   220			needs_vcc = of_property_read_bool(node, "vcc-supply");
   221			needs_clk = of_property_read_bool(node, "clocks");
   222		}
   223		nop->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
   224							   GPIOD_ASIS);
   225		err = PTR_ERR_OR_ZERO(nop->gpiod_reset);
   226		if (!err) {
   227			nop->gpiod_vbus = devm_gpiod_get_optional(dev,
   228							 "vbus-detect",
   229							 GPIOD_ASIS);
   230			err = PTR_ERR_OR_ZERO(nop->gpiod_vbus);
   231		}
   232	
   233		if (err == -EPROBE_DEFER)
   234			return -EPROBE_DEFER;
   235		if (err) {
   236			dev_err(dev, "Error requesting RESET or VBUS GPIO\n");
   237			return err;
   238		}
   239		if (nop->gpiod_reset)
   240			gpiod_direction_output(nop->gpiod_reset, 1);
   241	
   242		nop->phy.otg = devm_kzalloc(dev, sizeof(*nop->phy.otg),
   243				GFP_KERNEL);
   244		if (!nop->phy.otg)
   245			return -ENOMEM;
   246	
   247		nop->clk = devm_clk_get(dev, "main_clk");
   248		if (IS_ERR(nop->clk)) {
   249			dev_dbg(dev, "Can't get phy clock: %ld\n",
   250						PTR_ERR(nop->clk));
   251			if (needs_clk)
   252				return PTR_ERR(nop->clk);
   253		}
   254	
   255		if (!IS_ERR(nop->clk) && clk_rate) {
   256			err = clk_set_rate(nop->clk, clk_rate);
   257			if (err) {
   258				dev_err(dev, "Error setting clock rate\n");
   259				return err;
   260			}
   261		}
   262	
   263		nop->vcc = devm_regulator_get(dev, "vcc");
   264		if (IS_ERR(nop->vcc)) {
   265			dev_dbg(dev, "Error getting vcc regulator: %ld\n",
   266						PTR_ERR(nop->vcc));
   267			if (needs_vcc)
   268				return -EPROBE_DEFER;
   269		}
   270	
 > 271		nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
   272		if (PTR_ERR(nop->vbus_draw) == -ENODEV)
   273			nop->vbus_draw = NULL;
   274		if (IS_ERR(nop->vbus_draw))
   275			return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
   276					     "could not get vbus regulator\n");
   277	
   278		nop->dev		= dev;
   279		nop->phy.dev		= nop->dev;
   280		nop->phy.label		= "nop-xceiv";
   281		nop->phy.set_suspend	= nop_set_suspend;
   282		nop->phy.type		= type;
   283	
   284		nop->phy.otg->state		= OTG_STATE_UNDEFINED;
   285		nop->phy.otg->usb_phy		= &nop->phy;
   286		nop->phy.otg->set_host		= nop_set_host;
   287		nop->phy.otg->set_peripheral	= nop_set_peripheral;
   288	
   289		return 0;
   290	}
   291	EXPORT_SYMBOL_GPL(usb_phy_gen_create_phy);
   292	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
