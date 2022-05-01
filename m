Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F55168D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355793AbiEAXOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiEAXOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 19:14:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE4B13DCF
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651446638; x=1682982638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/DZPnu3qWTnjcI5kjvGTh6U1aOqyj+PIPSCIJz9I/NA=;
  b=VGhAAwCuMkPY7bbutOay/fOP4kWY4F+KtlFyXwj2gt+dCLLnrCi8wbWQ
   LNl1/hqHzZQru0Y1Z3HnFJpFmFtqoEsv426KJb7CWdswk9jUh42fkZ5JS
   DINWpG7srvGv3t7yXnxyVq+Q7mMORVmOcP03ShfdlDbTcYtkfEp9bdYIE
   PfdCPmp1xXrBPCymQJ956l4HzmtfdPza9OqZh8l2XqaYJd1i7KUG+tCcU
   BZSteLLQC+RiiRLcIXF9hJMIrsUcxnZkIbYu6Dv7JM4yLRRZWyOlihoKn
   MKSBgGxVVHHRqnkvCvBvmz5fnOluYdCFg0puY4smv+cLHeDJIBWeI0D7g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="330056632"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="330056632"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 16:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="545420140"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 16:10:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlIi4-000979-10;
        Sun, 01 May 2022 23:10:36 +0000
Date:   Mon, 2 May 2022 07:10:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.10 27/37]
 drivers/usb/phy/phy-generic.c:271:26: error: implicit declaration of
 function 'devm_regulator_get_exclusive'; did you mean
 'regulator_get_exclusive'?
Message-ID: <202205020745.gMHqXUci-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.10
head:   621e7ad202a1a0bbf09ed57a662d0c7d28e1ef2c
commit: 174e6e3900cea13f0c01c5e6f874f98440ce210d [27/37] usb: phy: generic: Get the vbus supply
config: mips-randconfig-s032-20220501 (https://download.01.org/0day-ci/archive/20220502/202205020745.gMHqXUci-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/174e6e3900cea13f0c01c5e6f874f98440ce210d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.10
        git checkout 174e6e3900cea13f0c01c5e6f874f98440ce210d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/usb/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/usb/phy/phy-generic.c: In function 'usb_phy_gen_create_phy':
>> drivers/usb/phy/phy-generic.c:271:26: error: implicit declaration of function 'devm_regulator_get_exclusive'; did you mean 'regulator_get_exclusive'? [-Werror=implicit-function-declaration]
     271 |         nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          regulator_get_exclusive
>> drivers/usb/phy/phy-generic.c:271:24: warning: assignment to 'struct regulator *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     271 |         nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
         |                        ^
   cc1: some warnings being treated as errors


vim +271 drivers/usb/phy/phy-generic.c

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
