Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAC5A0527
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 02:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiHYAZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 20:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYAZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:25:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E764457F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661387100; x=1692923100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lTR8Aua53Hrg1CIsD9Rc3773VnkmtC85xsQjT06tgf4=;
  b=A6MDgeqeXdqqI1p8ZAeMrsWicnpHkaao2njlpOLUar5vdgUoP/QqvAF9
   BB3bDXSZT7hECUuEPjQpy/P6LmilXP3CcIJCMzMrIKlwX8x0farp9d7s4
   Jus/HAiL8LcyXitzVR7Va4ZQxLnMKugSg90BLbONXt39kMPAkhH72RTd5
   rkJc/MOQ5xHM5MMHwje+s3KsBJrWrB15G7TBm4SDvmvZVyvqSsGw9s0iK
   PPD8UzZAMgBZf6unO9LfWzeZiI24Q56yeysDS74SmjGBIMQ8NqaHWxm5t
   OlCTR/TPDwnbyMgn8EX/8DaiBh9BA2WbuG3G0PdlWhRyIpCpFTdlQ806V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291675854"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="291675854"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 17:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="586643669"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2022 17:24:56 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR0g3-0001RD-37;
        Thu, 25 Aug 2022 00:24:55 +0000
Date:   Thu, 25 Aug 2022 08:24:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: sound/soc/codecs/tlv320adc3xxx.c:1209:50: error: use of undeclared
 identifier 'GPIOD_OUT_LOW'
Message-ID: <202208250802.7310sfQR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c40e8341e3b3bb27e3a65b06b5b454626234c4f0
commit: 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f ASoC: simple-amplifier: Remove spurious gpiolib select
date:   7 months ago
config: hexagon-randconfig-r045-20220825 (https://download.01.org/0day-ci/archive/20220825/202208250802.7310sfQR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project d00e97df0fe8c67f694c4d027297f4382ce72b38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/tlv320adc3xxx.c:1209:21: error: implicit declaration of function 'devm_gpiod_get' [-Werror,-Wimplicit-function-declaration]
           adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                              ^
   sound/soc/codecs/tlv320adc3xxx.c:1209:21: note: did you mean 'devm_gpio_free'?
   include/linux/gpio.h:243:20: note: 'devm_gpio_free' declared here
   static inline void devm_gpio_free(struct device *dev, unsigned int gpio)
                      ^
>> sound/soc/codecs/tlv320adc3xxx.c:1209:50: error: use of undeclared identifier 'GPIOD_OUT_LOW'
           adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                                                           ^
   sound/soc/codecs/tlv320adc3xxx.c:1257:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror,-Wimplicit-function-declaration]
           gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
           ^
   sound/soc/codecs/tlv320adc3xxx.c:1257:2: note: did you mean 'gpio_set_value_cansleep'?
   include/linux/gpio.h:188:20: note: 'gpio_set_value_cansleep' declared here
   static inline void gpio_set_value_cansleep(unsigned gpio, int value)
                      ^
   3 errors generated.


vim +/GPIOD_OUT_LOW +1209 sound/soc/codecs/tlv320adc3xxx.c

e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1196  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1197  static int adc3xxx_i2c_probe(struct i2c_client *i2c,
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1198  			     const struct i2c_device_id *id)
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1199  {
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1200  	struct device *dev = &i2c->dev;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1201  	struct adc3xxx *adc3xxx = NULL;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1202  	int ret;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1203  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1204  	adc3xxx = devm_kzalloc(dev, sizeof(struct adc3xxx), GFP_KERNEL);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1205  	if (!adc3xxx)
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1206  		return -ENOMEM;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1207  	adc3xxx->dev = dev;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1208  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15 @1209  	adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1210  	if (IS_ERR(adc3xxx->rst_pin)) {
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1211  		return dev_err_probe(dev, PTR_ERR(adc3xxx->rst_pin),
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1212  				     "Failed to request rst_pin\n");
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1213  	}
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1214  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1215  	adc3xxx->mclk = devm_clk_get(dev, NULL);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1216  	if (IS_ERR(adc3xxx->mclk)) {
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1217  		/*
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1218  		 * The chip itself supports running off the BCLK either
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1219  		 * directly or via the PLL, but the driver does not (yet), so
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1220  		 * having a specified mclk is required. Otherwise, we could
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1221  		 * use the lack of a clocks property to indicate when BCLK is
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1222  		 * intended as the clock source.
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1223  		 */
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1224  		return dev_err_probe(dev, PTR_ERR(adc3xxx->mclk),
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1225  				     "Failed to acquire MCLK\n");
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1226  	} else if (adc3xxx->mclk) {
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1227  		ret = clk_prepare_enable(adc3xxx->mclk);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1228  		if (ret < 0)
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1229  			return ret;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1230  		dev_dbg(dev, "Enabled MCLK, freq %lu Hz\n", clk_get_rate(adc3xxx->mclk));
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1231  	}
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1232  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1233  	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmdin-gpio1", &adc3xxx->gpio_cfg[0]);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1234  	if (ret < 0)
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1235  		goto err_unprepare_mclk;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1236  	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmclk-gpio2", &adc3xxx->gpio_cfg[1]);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1237  	if (ret < 0)
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1238  		goto err_unprepare_mclk;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1239  	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias1-vg", &adc3xxx->micbias_vg[0]);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1240  	if (ret < 0)
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1241  		goto err_unprepare_mclk;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1242  	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias2-vg", &adc3xxx->micbias_vg[1]);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1243  	if (ret < 0)
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1244  		goto err_unprepare_mclk;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1245  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1246  	adc3xxx->regmap = devm_regmap_init_i2c(i2c, &adc3xxx_regmap);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1247  	if (IS_ERR(adc3xxx->regmap)) {
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1248  		ret = PTR_ERR(adc3xxx->regmap);
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1249  		goto err_unprepare_mclk;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1250  	}
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1251  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1252  	i2c_set_clientdata(i2c, adc3xxx);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1253  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1254  	adc3xxx->type = id->driver_data;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1255  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1256  	/* Reset codec chip */
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1257  	gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1258  	usleep_range(2000, 100000); /* Requirement: > 10 ns (datasheet p13) */
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1259  	gpiod_set_value_cansleep(adc3xxx->rst_pin, 0);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1260  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1261  	/* Potentially set up pins used as GPIOs */
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1262  	adc3xxx_init_gpio(adc3xxx);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1263  
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1264  	ret = snd_soc_register_component(dev,
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1265  			&soc_component_dev_adc3xxx, &adc3xxx_dai, 1);
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1266  	if (ret < 0) {
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1267  		dev_err(dev, "Failed to register codec: %d\n", ret);
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1268  		goto err_unprepare_mclk;
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1269  	}
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1270  
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1271  	return 0;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1272  
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1273  err_unprepare_mclk:
8a2d8e4fed6d58 Yang Yingliang   2021-12-23  1274  	clk_disable_unprepare(adc3xxx->mclk);
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1275  	return ret;
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1276  }
e9a3b57efd28fe Ricard Wanderlof 2021-12-15  1277  

:::::: The code at line 1209 was first introduced by commit
:::::: e9a3b57efd28fe889a98171bdc1e9e0dd7eb9a50 ASoC: codec: tlv320adc3xxx: New codec driver

:::::: TO: Ricard Wanderlof <ricardw@axis.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
