Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA94574912
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiGNJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiGNJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:31:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFE4A800
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657791083; x=1689327083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=STQRNUIY8SmSePbPiAzgY7UJQEqu/K3AxLZRnk3A8rg=;
  b=Lh/lAqPC/Z/SR3ADIav6yRPpe35bA1fLQB7zfcgBVIpGyKeV62EtkJnI
   wtA0vjUganRGTDqAzOYt1+eFJCRDHFeQEW4KdFdPSPsTKG5C7rcQyMrCG
   SyMgjxOO609VfyEZ2w+tx5g9ix7TiSSIW+N3xvXUbHJVqZVu28waQzyL7
   S1NJs4mXxKp4ycMojHBDwQDPNySZH2HZ7AjcS+ZPnGygy2AYSxpAmic/+
   7kFfKkFwSrDYFeI1G7b3SuaaMpSBcQesykvE1NTk75DuHWkXZVsnlVNNE
   zi9foyqt8Ye1yyQN02suq1/tl4f6JNc1/6tgRN5DORVbsuMisozzD2boF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="284222341"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="284222341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 02:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="623345675"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 02:31:06 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBvBa-0000Nm-5I;
        Thu, 14 Jul 2022 09:31:06 +0000
Date:   Thu, 14 Jul 2022 17:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [sre-misc:rk3588 39/42] drivers/mfd/rk8xx-core.c:654:40: warning:
 operator '?:' has lower precedence than '|'; '|' will be evaluated first
Message-ID: <202207141718.NA620oNa-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git rk3588
head:   720bd5858aced5b400d963fd155c40adb98c47b4
commit: 18650ce6630a3f066680e3affab33a11b9f3d14d [39/42] mfd: rk8xx: add rk806 support
config: arm64-randconfig-r005-20220714 (https://download.01.org/0day-ci/archive/20220714/202207141718.NA620oNa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/commit/?id=18650ce6630a3f066680e3affab33a11b9f3d14d
        git remote add sre-misc https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git
        git fetch --no-tags sre-misc rk3588
        git checkout 18650ce6630a3f066680e3affab33a11b9f3d14d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/rk8xx-core.c:654:40: warning: operator '?:' has lower precedence than '|'; '|' will be evaluated first [-Wbitwise-conditional-parentheses]
                                          IRQF_ONESHOT | dual_support ? IRQF_SHARED : 0, -1,
                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/mfd/rk8xx-core.c:654:40: note: place parentheses around the '|' expression to silence this warning
                                          IRQF_ONESHOT | dual_support ? IRQF_SHARED : 0, -1,
                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/mfd/rk8xx-core.c:654:40: note: place parentheses around the '?:' expression to evaluate it first
                                          IRQF_ONESHOT | dual_support ? IRQF_SHARED : 0, -1,
                                                                      ^
                                                         (                             )
   1 warning generated.


vim +654 drivers/mfd/rk8xx-core.c

   585	
   586	int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap)
   587	{
   588		struct rk808 *rk808;
   589		const struct rk808_reg_data *pre_init_reg;
   590		const struct mfd_cell *cells;
   591		bool dual_support = false;
   592		int nr_pre_init_regs;
   593		int nr_cells;
   594		int ret;
   595		int i;
   596	
   597		rk808 = devm_kzalloc(dev, sizeof(*rk808), GFP_KERNEL);
   598		if (!rk808)
   599			return -ENOMEM;
   600		rk808->dev = dev;
   601		rk808->variant = variant;
   602		rk808->regmap = regmap;
   603		dev_set_drvdata(dev, rk808);
   604	
   605		switch (rk808->variant) {
   606		case RK805_ID:
   607			rk808->regmap_irq_chip = &rk805_irq_chip;
   608			pre_init_reg = rk805_pre_init_reg;
   609			nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
   610			cells = rk805s;
   611			nr_cells = ARRAY_SIZE(rk805s);
   612			break;
   613		case RK806_ID:
   614			rk808->regmap_irq_chip = &rk806_irq_chip;
   615			pre_init_reg = rk806_pre_init_reg;
   616			nr_pre_init_regs = ARRAY_SIZE(rk806_pre_init_reg);
   617			cells = rk806s;
   618			nr_cells = ARRAY_SIZE(rk806s);
   619			dual_support = true;
   620			break;
   621		case RK808_ID:
   622			rk808->regmap_irq_chip = &rk808_irq_chip;
   623			pre_init_reg = rk808_pre_init_reg;
   624			nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
   625			cells = rk808s;
   626			nr_cells = ARRAY_SIZE(rk808s);
   627			break;
   628		case RK818_ID:
   629			rk808->regmap_irq_chip = &rk818_irq_chip;
   630			pre_init_reg = rk818_pre_init_reg;
   631			nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
   632			cells = rk818s;
   633			nr_cells = ARRAY_SIZE(rk818s);
   634			break;
   635		case RK809_ID:
   636		case RK817_ID:
   637			rk808->regmap_irq_chip = &rk817_irq_chip;
   638			pre_init_reg = rk817_pre_init_reg;
   639			nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
   640			cells = rk817s;
   641			nr_cells = ARRAY_SIZE(rk817s);
   642			break;
   643		default:
   644			dev_err(dev, "Unsupported RK8XX ID %lu\n", rk808->variant);
   645			return -EINVAL;
   646		}
   647	
   648		dev_info(dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
   649	
   650		if (!irq)
   651			return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
   652	
   653		ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
 > 654					       IRQF_ONESHOT | dual_support ? IRQF_SHARED : 0, -1,
   655					       rk808->regmap_irq_chip, &rk808->irq_data);
   656		if (ret)
   657			return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
   658	
   659		for (i = 0; i < nr_pre_init_regs; i++) {
   660			ret = regmap_update_bits(rk808->regmap,
   661						pre_init_reg[i].addr,
   662						pre_init_reg[i].mask,
   663						pre_init_reg[i].value);
   664			if (ret)
   665				return dev_err_probe(dev, ret, "0x%x write err\n",
   666						     pre_init_reg[i].addr);
   667		}
   668	
   669		ret = devm_mfd_add_devices(dev, dual_support ? PLATFORM_DEVID_AUTO : PLATFORM_DEVID_NONE,
   670				      cells, nr_cells, NULL, 0,
   671				      regmap_irq_get_domain(rk808->irq_data));
   672		if (ret)
   673			return dev_err_probe(dev, ret, "failed to add MFD devices\n");
   674	
   675		if (device_property_read_bool(dev, "rockchip,system-power-controller")) {
   676			ret = devm_register_sys_off_handler(dev,
   677					    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
   678					    &rk808_power_off, rk808);
   679			if (ret)
   680				return dev_err_probe(dev, ret,
   681						     "failed to register poweroff handler\n");
   682	
   683			switch (rk808->variant) {
   684			case RK809_ID:
   685			case RK817_ID:
   686				ret = devm_register_sys_off_handler(dev,
   687								    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
   688								    &rk808_restart, rk808);
   689				if (ret)
   690					dev_warn(dev, "failed to register rst handler, %d\n", ret);
   691				break;
   692			default:
   693				dev_dbg(dev, "pmic controlled board reset not supported\n");
   694				break;
   695			}
   696		}
   697	
   698		return 0;
   699	}
   700	EXPORT_SYMBOL_GPL(rk8xx_probe);
   701	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
