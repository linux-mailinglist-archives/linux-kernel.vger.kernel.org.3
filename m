Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B54F8E93
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiDHDgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiDHDgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:36:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898301D97DB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649388859; x=1680924859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=abyGfDHtT+FNSDaPKtoGtMGPODo9n9BpTa4wybmsBzo=;
  b=nneDJbn+PmfNumr/wFQ4QQfjhT1rMr05fRN3EkQFtR5jgCxz4XmFpxrN
   v2llnBxqRj1H7l5Cqh8WVdK5ROQ1SQ2Pm9WMLHo4JdBceoTkcKbxOjaNc
   J18fBVoIU6uTUjZKddzW3MiWt9/mOiMeRAVsKI2jXH9iXKpD0+aXB6pVG
   Ia8ERclyrvhd56fQIh49QUuEbykED2OejeiCra0ZsemH+IoVszueUAaVW
   wDeoFXDbPblRjt9brmwvNDxMUl9G/nTl+fFr1lEWqOymbnFJ7zgQT2yzv
   39UIsB7/EzbLGKRSyP0iz11XuWp16d5cMe+yDNAiUBfrJ5WJaY4zyeKyM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347939985"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="347939985"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 20:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="525206623"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2022 20:34:17 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncfO4-00060R-W0;
        Fri, 08 Apr 2022 03:34:16 +0000
Date:   Fri, 8 Apr 2022 11:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/soc/codecs/tlv320adc3xxx.c:1209:28: error: implicit
 declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'?
Message-ID: <202204081135.5a7kyZH9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42e7a03d3badebd4e70aea5362d6914dfc7c220b
commit: 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f ASoC: simple-amplifier: Remove spurious gpiolib select
date:   8 weeks ago
config: microblaze-randconfig-r034-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081135.5a7kyZH9-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/regulator/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/tlv320adc3xxx.c: In function 'adc3xxx_i2c_probe':
>> sound/soc/codecs/tlv320adc3xxx.c:1209:28: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
    1209 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
         |                            ^~~~~~~~~~~~~~
         |                            devm_gpio_free
>> sound/soc/codecs/tlv320adc3xxx.c:1209:57: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
    1209 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
         |                                                         ^~~~~~~~~~~~~
         |                                                         GPIOF_INIT_LOW
   sound/soc/codecs/tlv320adc3xxx.c:1209:57: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/codecs/tlv320adc3xxx.c:1257:9: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
    1257 |         gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         gpio_set_value_cansleep
   cc1: some warnings being treated as errors


vim +1209 sound/soc/codecs/tlv320adc3xxx.c

e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1196  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1197  static int adc3xxx_i2c_probe(struct i2c_client *i2c,
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1198  			     const struct i2c_device_id *id)
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1199  {
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1200  	struct device *dev = &i2c->dev;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1201  	struct adc3xxx *adc3xxx = NULL;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1202  	int ret;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1203  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1204  	adc3xxx = devm_kzalloc(dev, sizeof(struct adc3xxx), GFP_KERNEL);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1205  	if (!adc3xxx)
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1206  		return -ENOMEM;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1207  	adc3xxx->dev = dev;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1208  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15 @1209  	adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1210  	if (IS_ERR(adc3xxx->rst_pin)) {
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1211  		return dev_err_probe(dev, PTR_ERR(adc3xxx->rst_pin),
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1212  				     "Failed to request rst_pin\n");
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1213  	}
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1214  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1215  	adc3xxx->mclk = devm_clk_get(dev, NULL);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1216  	if (IS_ERR(adc3xxx->mclk)) {
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1217  		/*
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1218  		 * The chip itself supports running off the BCLK either
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1219  		 * directly or via the PLL, but the driver does not (yet), so
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1220  		 * having a specified mclk is required. Otherwise, we could
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1221  		 * use the lack of a clocks property to indicate when BCLK is
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1222  		 * intended as the clock source.
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1223  		 */
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1224  		return dev_err_probe(dev, PTR_ERR(adc3xxx->mclk),
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1225  				     "Failed to acquire MCLK\n");
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1226  	} else if (adc3xxx->mclk) {
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1227  		ret = clk_prepare_enable(adc3xxx->mclk);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1228  		if (ret < 0)
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1229  			return ret;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1230  		dev_dbg(dev, "Enabled MCLK, freq %lu Hz\n", clk_get_rate(adc3xxx->mclk));
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1231  	}
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1232  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1233  	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmdin-gpio1", &adc3xxx->gpio_cfg[0]);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1234  	if (ret < 0)
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1235  		goto err_unprepare_mclk;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1236  	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmclk-gpio2", &adc3xxx->gpio_cfg[1]);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1237  	if (ret < 0)
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1238  		goto err_unprepare_mclk;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1239  	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias1-vg", &adc3xxx->micbias_vg[0]);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1240  	if (ret < 0)
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1241  		goto err_unprepare_mclk;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1242  	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias2-vg", &adc3xxx->micbias_vg[1]);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1243  	if (ret < 0)
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1244  		goto err_unprepare_mclk;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1245  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1246  	adc3xxx->regmap = devm_regmap_init_i2c(i2c, &adc3xxx_regmap);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1247  	if (IS_ERR(adc3xxx->regmap)) {
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1248  		ret = PTR_ERR(adc3xxx->regmap);
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1249  		goto err_unprepare_mclk;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1250  	}
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1251  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1252  	i2c_set_clientdata(i2c, adc3xxx);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1253  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1254  	adc3xxx->type = id->driver_data;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1255  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1256  	/* Reset codec chip */
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15 @1257  	gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1258  	usleep_range(2000, 100000); /* Requirement: > 10 ns (datasheet p13) */
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1259  	gpiod_set_value_cansleep(adc3xxx->rst_pin, 0);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1260  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1261  	/* Potentially set up pins used as GPIOs */
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1262  	adc3xxx_init_gpio(adc3xxx);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1263  
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1264  	ret = snd_soc_register_component(dev,
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1265  			&soc_component_dev_adc3xxx, &adc3xxx_dai, 1);
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1266  	if (ret < 0) {
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1267  		dev_err(dev, "Failed to register codec: %d\n", ret);
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1268  		goto err_unprepare_mclk;
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1269  	}
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1270  
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1271  	return 0;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1272  
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1273  err_unprepare_mclk:
8a2d8e4fed6d582 Yang Yingliang   2021-12-23  1274  	clk_disable_unprepare(adc3xxx->mclk);
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1275  	return ret;
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1276  }
e9a3b57efd28fe8 Ricard Wanderlof 2021-12-15  1277  

:::::: The code at line 1209 was first introduced by commit
:::::: e9a3b57efd28fe889a98171bdc1e9e0dd7eb9a50 ASoC: codec: tlv320adc3xxx: New codec driver

:::::: TO: Ricard Wanderlof <ricardw@axis.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
