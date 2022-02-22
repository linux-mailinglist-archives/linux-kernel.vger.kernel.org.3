Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709A04BF458
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiBVJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiBVJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:06:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6413DE3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520735; x=1677056735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GmmogwoXW4eJyS9Y+lE4/P7NQEJwZAkNpVU4BDlSJiQ=;
  b=gje6Ts5x/GCtP8gdgUhzvu6imcmYtscW2Us7IXznuUj44msTft1vwbSg
   Nmf0rIcuse2dsSNZxcZpQUPEnHSUdgYYa/lZcy/m2Xhy58tis5wbEO0Tf
   gJooeZlOTGXETUYPkg5Gl3uD84drm7DTsh41XtFnHNzsNqfxAPInT6032
   CYLD74yM+7lfGfUH9+JpgwksS/1imuGlZtyvgGiHnkc/t8jbHGHdbG0f9
   Lb5irRENPINM9UL+7waPLiXVZOXZOHuYx6Ia2Jwj1yhadZkYCHvoFyHzS
   YSvTdKhtt2eu54QpwbNS3pIP6358HALZRgJBR4EgXM2VsppTgMeRWGyjw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251596655"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251596655"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:05:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="547653168"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Feb 2022 01:05:31 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMR6x-00003V-6J; Tue, 22 Feb 2022 09:05:31 +0000
Date:   Tue, 22 Feb 2022 17:04:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/phy/rockchip/phy-rockchip-inno-usb2.c:1086
 rockchip_usb2phy_probe() warn: inconsistent indenting
Message-ID: <202202221635.KNbRPDub-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
commit: e6915e1acca57bc4fdb61dccd5cc2e49f72ef743 phy: phy-rockchip-inno-usb2: support standalone phy nodes
date:   9 weeks ago
config: riscv-randconfig-m031-20220222 (https://download.01.org/0day-ci/archive/20220222/202202221635.KNbRPDub-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/phy/rockchip/phy-rockchip-inno-usb2.c:1086 rockchip_usb2phy_probe() warn: inconsistent indenting

vim +1086 drivers/phy/rockchip/phy-rockchip-inno-usb2.c

98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1053  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1054  static int rockchip_usb2phy_probe(struct platform_device *pdev)
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1055  {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1056  	struct device *dev = &pdev->dev;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1057  	struct device_node *np = dev->of_node;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1058  	struct device_node *child_np;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1059  	struct phy_provider *provider;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1060  	struct rockchip_usb2phy *rphy;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1061  	const struct rockchip_usb2phy_cfg *phy_cfgs;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1062  	const struct of_device_id *match;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1063  	unsigned int reg;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1064  	int index, ret;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1065  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1066  	rphy = devm_kzalloc(dev, sizeof(*rphy), GFP_KERNEL);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1067  	if (!rphy)
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1068  		return -ENOMEM;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1069  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1070  	match = of_match_device(dev->driver->of_match_table, dev);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1071  	if (!match || !match->data) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1072  		dev_err(dev, "phy configs are not assigned!\n");
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1073  		return -EINVAL;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1074  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1075  
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1076  	if (!dev->parent || !dev->parent->of_node) {
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1077  		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1078  		if (IS_ERR(rphy->grf)) {
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1079  			dev_err(dev, "failed to locate usbgrf\n");
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1080  			return PTR_ERR(rphy->grf);
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1081  		}
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1082  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1083  
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1084  	else {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1085  		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22 @1086  			if (IS_ERR(rphy->grf))
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1087  				return PTR_ERR(rphy->grf);
e6915e1acca57b drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1088  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1089  
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1090  	if (of_device_is_compatible(np, "rockchip,rv1108-usb2phy")) {
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1091  		rphy->usbgrf =
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1092  			syscon_regmap_lookup_by_phandle(dev->of_node,
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1093  							"rockchip,usbgrf");
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1094  		if (IS_ERR(rphy->usbgrf))
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1095  			return PTR_ERR(rphy->usbgrf);
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1096  	} else {
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1097  		rphy->usbgrf = NULL;
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1098  	}
1543645c3119da drivers/phy/rockchip/phy-rockchip-inno-usb2.c Frank Wang        2017-08-11  1099  
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1100  	if (of_property_read_u32_index(np, "reg", 0, &reg)) {
ac9ba7dc861377 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-08-27  1101  		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
ac9ba7dc861377 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-08-27  1102  			np);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1103  		return -EINVAL;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1104  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1105  
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1106  	/* support address_cells=2 */
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1107  	if (reg == 0) {
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1108  		if (of_property_read_u32_index(np, "reg", 1, &reg)) {
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1109  			dev_err(dev, "the reg property is not assigned in %pOFn node\n",
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1110  				np);
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1111  			return -EINVAL;
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1112  		}
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1113  	}
9c19c531dc98d7 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Peter Geis        2021-12-15  1114  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1115  	rphy->dev = dev;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1116  	phy_cfgs = match->data;
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1117  	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1118  	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1119  	platform_set_drvdata(pdev, rphy);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1120  
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1121  	ret = rockchip_usb2phy_extcon_register(rphy);
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1122  	if (ret)
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1123  		return ret;
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1124  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1125  	/* find out a proper config which can be matched with dt. */
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1126  	index = 0;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1127  	while (phy_cfgs[index].reg) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1128  		if (phy_cfgs[index].reg == reg) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1129  			rphy->phy_cfg = &phy_cfgs[index];
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1130  			break;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1131  		}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1132  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1133  		++index;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1134  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1135  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1136  	if (!rphy->phy_cfg) {
ac9ba7dc861377 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-08-27  1137  		dev_err(dev, "no phy-config can be matched with %pOFn node\n",
ac9ba7dc861377 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-08-27  1138  			np);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1139  		return -EINVAL;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1140  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1141  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1142  	rphy->clk = of_clk_get_by_name(np, "phyclk");
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1143  	if (!IS_ERR(rphy->clk)) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1144  		clk_prepare_enable(rphy->clk);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1145  	} else {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1146  		dev_info(&pdev->dev, "no phyclk specified\n");
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1147  		rphy->clk = NULL;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1148  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1149  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1150  	ret = rockchip_usb2phy_clk480m_register(rphy);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1151  	if (ret) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1152  		dev_err(dev, "failed to register 480m output clock\n");
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1153  		goto disable_clks;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1154  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1155  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1156  	index = 0;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1157  	for_each_available_child_of_node(np, child_np) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1158  		struct rockchip_usb2phy_port *rport = &rphy->ports[index];
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1159  		struct phy *phy;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1160  
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1161  		/* This driver aims to support both otg-port and host-port */
03e7d002526dc4 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-12-05  1162  		if (!of_node_name_eq(child_np, "host-port") &&
03e7d002526dc4 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-12-05  1163  		    !of_node_name_eq(child_np, "otg-port"))
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1164  			goto next_child;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1165  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1166  		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1167  		if (IS_ERR(phy)) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1168  			dev_err(dev, "failed to create phy\n");
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1169  			ret = PTR_ERR(phy);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1170  			goto put_child;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1171  		}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1172  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1173  		rport->phy = phy;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1174  		phy_set_drvdata(rport->phy, rport);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1175  
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1176  		/* initialize otg/host port separately */
03e7d002526dc4 drivers/phy/rockchip/phy-rockchip-inno-usb2.c Rob Herring       2018-12-05  1177  		if (of_node_name_eq(child_np, "host-port")) {
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1178  			ret = rockchip_usb2phy_host_port_init(rphy, rport,
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1179  							      child_np);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1180  			if (ret)
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1181  				goto put_child;
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1182  		} else {
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1183  			ret = rockchip_usb2phy_otg_port_init(rphy, rport,
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1184  							     child_np);
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1185  			if (ret)
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1186  				goto put_child;
98898f3bc83c8a drivers/phy/phy-rockchip-inno-usb2.c          William Wu        2016-11-07  1187  		}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1188  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1189  next_child:
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1190  		/* to prevent out of boundary */
1716e49eb8b447 drivers/phy/rockchip/phy-rockchip-inno-usb2.c kernel test robot 2021-06-23  1191  		if (++index >= rphy->phy_cfg->num_ports) {
1716e49eb8b447 drivers/phy/rockchip/phy-rockchip-inno-usb2.c kernel test robot 2021-06-23  1192  			of_node_put(child_np);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1193  			break;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1194  		}
1716e49eb8b447 drivers/phy/rockchip/phy-rockchip-inno-usb2.c kernel test robot 2021-06-23  1195  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1196  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1197  	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1198  	return PTR_ERR_OR_ZERO(provider);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1199  
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1200  put_child:
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1201  	of_node_put(child_np);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1202  disable_clks:
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1203  	if (rphy->clk) {
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1204  		clk_disable_unprepare(rphy->clk);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1205  		clk_put(rphy->clk);
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1206  	}
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1207  	return ret;
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1208  }
0e08d2a727e68b drivers/phy/phy-rockchip-inno-usb2.c          Frank Wang        2016-07-22  1209  

:::::: The code at line 1086 was first introduced by commit
:::::: 0e08d2a727e68bbe426457dc61ec11a5c6a76ed6 phy: rockchip-inno-usb2: add a new driver for Rockchip usb2phy

:::::: TO: Frank Wang <frank.wang@rock-chips.com>
:::::: CC: Kishon Vijay Abraham I <kishon@ti.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
