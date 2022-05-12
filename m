Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738552516A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356037AbiELPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356031AbiELPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:39:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82A263DBD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652369987; x=1683905987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2saI8IgRMycblyJNCpsHdvMC042GvBJTUaY8NeCPVqQ=;
  b=iRJxzf823qKHB5mDCjDmX1yKgQ7w+2Q3knQ/SaOfHOMcf15/Q/pV3AM7
   SgxKhfnYoEQkpuIiQANP+gxu3Hk3m+qpt3uhmWMJEgvYgeDziwEnj+X4s
   wYqdSGmGiE+nRedcp2h4jSCsEYK2ru3uGQoNhgFCuEtPgeEkZsPqWRfKX
   1Z1tyORC2+Qh34PnV5Q4JNcrTETcUPOtgXQFOB36Cg/fJps99PhMLO+xu
   +twKgH8X/x7b7VriU0Ce8TW+95GFtmFZOoe88HRAXwm8oDsb2VFgG48xM
   EJlGN2Mll7PufVMGYZZqgND/gosSULcjugpDuBaEd9d0h9qoa9Fh+YNn+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267621033"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="267621033"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="636888898"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2022 08:39:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npAua-000Kd8-U6;
        Thu, 12 May 2022 15:39:32 +0000
Date:   Thu, 12 May 2022 23:38:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Lee <ryan.lee.analog@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:filegSObUR 100/158] sound/soc/codecs/max98396.c:1555:32:
 error: implicit declaration of function 'devm_gpiod_get_optional'; did you
 mean 'devm_regulator_get_optional'?
Message-ID: <202205122316.V7tcZqcZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git filegSObUR
head:   0b7f644f52e81e2a653a353966933b47d01df9bb
commit: b58581136770569d2ee4300b10c7c0d76bb86250 [100/158] ASoC: max98396: add amplifier driver
config: sparc-buildonly-randconfig-r003-20220512 (https://download.01.org/0day-ci/archive/20220512/202205122316.V7tcZqcZ-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=b58581136770569d2ee4300b10c7c0d76bb86250
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci filegSObUR
        git checkout b58581136770569d2ee4300b10c7c0d76bb86250
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the broonie-ci/filegSObUR HEAD 0b7f644f52e81e2a653a353966933b47d01df9bb builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   sound/soc/codecs/max98396.c: In function 'max98396_i2c_probe':
>> sound/soc/codecs/max98396.c:1555:32: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
    1555 |         max98396->reset_gpio = devm_gpiod_get_optional(&i2c->dev,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~
         |                                devm_regulator_get_optional
>> sound/soc/codecs/max98396.c:1556:65: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
    1556 |                                                        "reset", GPIOD_OUT_HIGH);
         |                                                                 ^~~~~~~~~~~~~~
         |                                                                 GPIOF_INIT_HIGH
   sound/soc/codecs/max98396.c:1556:65: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/codecs/max98396.c:1565:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
    1565 |                 gpiod_set_value_cansleep(max98396->reset_gpio, 0);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 gpio_set_value_cansleep
   cc1: some warnings being treated as errors


vim +1555 sound/soc/codecs/max98396.c

  1514	
  1515	static int max98396_i2c_probe(struct i2c_client *i2c,
  1516				      const struct i2c_device_id *id)
  1517	{
  1518		struct max98396_priv *max98396 = NULL;
  1519		int ret, reg;
  1520	
  1521		max98396 = devm_kzalloc(&i2c->dev, sizeof(*max98396), GFP_KERNEL);
  1522	
  1523		if (!max98396) {
  1524			ret = -ENOMEM;
  1525			return ret;
  1526		}
  1527		i2c_set_clientdata(i2c, max98396);
  1528	
  1529		max98396->device_id =  id->driver_data;
  1530	
  1531		/* regmap initialization */
  1532		if (max98396->device_id == CODEC_TYPE_MAX98396)
  1533			max98396->regmap = devm_regmap_init_i2c(i2c, &max98396_regmap);
  1534	
  1535		else
  1536			max98396->regmap = devm_regmap_init_i2c(i2c, &max98397_regmap);
  1537	
  1538		if (IS_ERR(max98396->regmap)) {
  1539			ret = PTR_ERR(max98396->regmap);
  1540			dev_err(&i2c->dev,
  1541				"Failed to allocate regmap: %d\n", ret);
  1542			return ret;
  1543		}
  1544	
  1545		/* update interleave mode info */
  1546		if (device_property_read_bool(&i2c->dev, "adi,interleave_mode"))
  1547			max98396->interleave_mode = true;
  1548		else
  1549			max98396->interleave_mode = false;
  1550	
  1551		/* voltage/current slot & gpio configuration */
  1552		max98396_read_device_property(&i2c->dev, max98396);
  1553	
  1554		/* Reset the Device */
> 1555		max98396->reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> 1556							       "reset", GPIOD_OUT_HIGH);
  1557		if (IS_ERR(max98396->reset_gpio)) {
  1558			ret = PTR_ERR(max98396->reset_gpio);
  1559			dev_err(&i2c->dev, "Unable to request GPIO pin: %d.\n", ret);
  1560			return ret;
  1561		}
  1562	
  1563		if (max98396->reset_gpio) {
  1564			usleep_range(5000, 6000);
> 1565			gpiod_set_value_cansleep(max98396->reset_gpio, 0);
  1566			/* Wait for the hw reset done */
  1567			usleep_range(5000, 6000);
  1568		}
  1569	
  1570		ret = regmap_read(max98396->regmap,
  1571				  GET_REG_ADDR_REV_ID(max98396->device_id), &reg);
  1572		if (ret < 0) {
  1573			dev_err(&i2c->dev, "%s: failed to read revision of the device.\n",  id->name);
  1574			return ret;
  1575		}
  1576		dev_info(&i2c->dev, "%s revision ID: 0x%02X\n", id->name, reg);
  1577	
  1578		/* codec registration */
  1579		if (max98396->device_id == CODEC_TYPE_MAX98396)
  1580			ret = devm_snd_soc_register_component(&i2c->dev,
  1581							      &soc_codec_dev_max98396,
  1582							      max98396_dai,
  1583							      ARRAY_SIZE(max98396_dai));
  1584		else
  1585			ret = devm_snd_soc_register_component(&i2c->dev,
  1586							      &soc_codec_dev_max98397,
  1587							      max98397_dai,
  1588							      ARRAY_SIZE(max98397_dai));
  1589		if (ret < 0)
  1590			dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
  1591	
  1592		return ret;
  1593	}
  1594	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
