Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2950B469
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446261AbiDVJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446242AbiDVJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:51:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC639BB0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650620924; x=1682156924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=44DrBQRKTssUaQ1dZy+Z4yxVX5+KjOKMpeIn4OUUbv0=;
  b=Zp/+EQgVdbQ6cGCZccWfyHNYNuKYw063oBZ5iAtPKsSuqOmaZCqv4bQ8
   Vk4JvMRz9lMp2t59sQNu/ued1GNRavSnw4X+TH7x4qUE5KDZ8jszziXJd
   /wPEtbKUxMuwjefSIHIckqc/tcHYHdxYPzy1304Jwva5RaGYPNI/dyjb3
   qrvGZfo7yHE4MvZm+VkjiVrtASjvZlpkEvl44+gz3/OKxwxJA7y7RJtKQ
   rrB8tKRPW2QOxyeuxUAGKzVXwM9gG7w01x0bytbNhCUbj93dcucEDtOKV
   kMQX6aXGQRAzdNnjwOCrpLlvtYAAX39+cFXouEBt6029OCs0GfbZYKmLK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264802810"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264802810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="658950806"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2022 02:48:42 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhpu5-0009zm-DK;
        Fri, 22 Apr 2022 09:48:41 +0000
Date:   Fri, 22 Apr 2022 17:48:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudius Heine <ch@denx.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/tlv320aic32x4.c:1202:18: warning: cast to smaller
 integer type 'enum aic32x4_type' from 'void *'
Message-ID: <202204221755.TGtPhn6i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudius,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d569e86915b7f2f9795588591c8d5ea0b66481cb
commit: 688d47cdd9344b1485eb28c2a7aa99743ed529a3 ASoC: tlv320aic32x4: add type to device private data struct
date:   10 months ago
config: arm64-buildonly-randconfig-r002-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221755.TGtPhn6i-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=688d47cdd9344b1485eb28c2a7aa99743ed529a3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 688d47cdd9344b1485eb28c2a7aa99743ed529a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tlv320aic32x4.c:1202:18: warning: cast to smaller integer type 'enum aic32x4_type' from 'void *' [-Wvoid-pointer-to-enum-cast]
           aic32x4->type = (enum aic32x4_type)dev_get_drvdata(dev);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1202 sound/soc/codecs/tlv320aic32x4.c

  1185	
  1186	int aic32x4_probe(struct device *dev, struct regmap *regmap)
  1187	{
  1188		struct aic32x4_priv *aic32x4;
  1189		struct aic32x4_pdata *pdata = dev->platform_data;
  1190		struct device_node *np = dev->of_node;
  1191		int ret;
  1192	
  1193		if (IS_ERR(regmap))
  1194			return PTR_ERR(regmap);
  1195	
  1196		aic32x4 = devm_kzalloc(dev, sizeof(struct aic32x4_priv),
  1197					   GFP_KERNEL);
  1198		if (aic32x4 == NULL)
  1199			return -ENOMEM;
  1200	
  1201		aic32x4->dev = dev;
> 1202		aic32x4->type = (enum aic32x4_type)dev_get_drvdata(dev);
  1203	
  1204		dev_set_drvdata(dev, aic32x4);
  1205	
  1206		if (pdata) {
  1207			aic32x4->power_cfg = pdata->power_cfg;
  1208			aic32x4->swapdacs = pdata->swapdacs;
  1209			aic32x4->micpga_routing = pdata->micpga_routing;
  1210			aic32x4->rstn_gpio = pdata->rstn_gpio;
  1211			aic32x4->mclk_name = "mclk";
  1212		} else if (np) {
  1213			ret = aic32x4_parse_dt(aic32x4, np);
  1214			if (ret) {
  1215				dev_err(dev, "Failed to parse DT node\n");
  1216				return ret;
  1217			}
  1218		} else {
  1219			aic32x4->power_cfg = 0;
  1220			aic32x4->swapdacs = false;
  1221			aic32x4->micpga_routing = 0;
  1222			aic32x4->rstn_gpio = -1;
  1223			aic32x4->mclk_name = "mclk";
  1224		}
  1225	
  1226		if (gpio_is_valid(aic32x4->rstn_gpio)) {
  1227			ret = devm_gpio_request_one(dev, aic32x4->rstn_gpio,
  1228					GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
  1229			if (ret != 0)
  1230				return ret;
  1231		}
  1232	
  1233		ret = aic32x4_setup_regulators(dev, aic32x4);
  1234		if (ret) {
  1235			dev_err(dev, "Failed to setup regulators\n");
  1236			return ret;
  1237		}
  1238	
  1239		if (gpio_is_valid(aic32x4->rstn_gpio)) {
  1240			ndelay(10);
  1241			gpio_set_value_cansleep(aic32x4->rstn_gpio, 1);
  1242			mdelay(1);
  1243		}
  1244	
  1245		ret = regmap_write(regmap, AIC32X4_RESET, 0x01);
  1246		if (ret)
  1247			goto err_disable_regulators;
  1248	
  1249		ret = aic32x4_register_clocks(dev, aic32x4->mclk_name);
  1250		if (ret)
  1251			goto err_disable_regulators;
  1252	
  1253		ret = devm_snd_soc_register_component(dev,
  1254				&soc_component_dev_aic32x4, &aic32x4_dai, 1);
  1255		if (ret) {
  1256			dev_err(dev, "Failed to register component\n");
  1257			goto err_disable_regulators;
  1258		}
  1259	
  1260		return 0;
  1261	
  1262	err_disable_regulators:
  1263		aic32x4_disable_regulators(aic32x4);
  1264	
  1265		return ret;
  1266	}
  1267	EXPORT_SYMBOL(aic32x4_probe);
  1268	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
