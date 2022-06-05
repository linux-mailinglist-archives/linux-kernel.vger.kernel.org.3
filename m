Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0543953D9EF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 06:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiFEEge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiFEEgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 00:36:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012B5186C3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 21:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654403790; x=1685939790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vKYoFq+zPHon8HqW0p7Tr1Xq3IkjcWeV3Wnfo2YOlKY=;
  b=gF33cdRMXKLHAY+hL6CfwJSwn0k1+TFoF2tVb4qlIVDYlMMmIyGNZ8k+
   dp02kbRjKu7l8/xs+J4AtO7qf6/+NIztjajvmTNoif6rFhPaEmYRRKVFv
   xk5zp/Gpjvj0Xr5BdQDDcU3d+yLG/SJcLKYQRf1dN8DpqQNQoLu8kOnIk
   u28aDfelYjgCi6pD/Rw8se4JTFi0UPhQHRHEoUI4+HnNAa6Q8wWz9BwKG
   Wkov0oYGMtFgL6dkSqjhwtJcqV7KgRCvAbvlDTouSekhAVJwDyZVPq1Vw
   SZ7/kv7xYapoXUf8/JFMRee8Nzl2wA1NLA8Qd4VxmxF3gZG+AsOfLvvzT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="274082507"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="274082507"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 21:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="564369293"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2022 21:36:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxi03-000BUc-Bb;
        Sun, 05 Jun 2022 04:36:27 +0000
Date:   Sun, 5 Jun 2022 12:35:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Lee <steve.lee.analog@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/max98390.c:1076:22: error: implicit declaration of
 function 'devm_gpiod_get_optional'; did you mean
 'devm_regulator_get_optional'?
Message-ID: <202206051208.ehHGvHd0-lkp@intel.com>
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

Hi Steve,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   952923ddc01120190dcf671e7b354364ce1d1362
commit: 397ff024960634962af93e9e2775fc0e4fe7de92 ASoC: max98390: Add reset gpio control
date:   6 weeks ago
config: nios2-randconfig-c003-20220605 (https://download.01.org/0day-ci/archive/20220605/202206051208.ehHGvHd0-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=397ff024960634962af93e9e2775fc0e4fe7de92
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 397ff024960634962af93e9e2775fc0e4fe7de92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/max98390.c: In function 'max98390_i2c_probe':
>> sound/soc/codecs/max98390.c:1076:22: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
    1076 |         reset_gpio = devm_gpiod_get_optional(&i2c->dev,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
         |                      devm_regulator_get_optional
>> sound/soc/codecs/max98390.c:1077:55: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
    1077 |                                              "reset", GPIOD_OUT_HIGH);
         |                                                       ^~~~~~~~~~~~~~
         |                                                       GPIOF_INIT_HIGH
   sound/soc/codecs/max98390.c:1077:55: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/codecs/max98390.c:1083:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
    1083 |                 gpiod_set_value_cansleep(reset_gpio, 0);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 gpio_set_value_cansleep
   cc1: some warnings being treated as errors


vim +1076 sound/soc/codecs/max98390.c

  1016	
  1017	static int max98390_i2c_probe(struct i2c_client *i2c)
  1018	{
  1019		int ret = 0;
  1020		int reg = 0;
  1021	
  1022		struct max98390_priv *max98390 = NULL;
  1023		struct i2c_adapter *adapter = i2c->adapter;
  1024		struct gpio_desc *reset_gpio;
  1025	
  1026		ret = i2c_check_functionality(adapter,
  1027			I2C_FUNC_SMBUS_BYTE
  1028			| I2C_FUNC_SMBUS_BYTE_DATA);
  1029		if (!ret) {
  1030			dev_err(&i2c->dev, "I2C check functionality failed\n");
  1031			return -ENXIO;
  1032		}
  1033	
  1034		max98390 = devm_kzalloc(&i2c->dev, sizeof(*max98390), GFP_KERNEL);
  1035		if (!max98390) {
  1036			ret = -ENOMEM;
  1037			return ret;
  1038		}
  1039		i2c_set_clientdata(i2c, max98390);
  1040	
  1041		ret = device_property_read_u32(&i2c->dev, "maxim,temperature_calib",
  1042					       &max98390->ambient_temp_value);
  1043		if (ret) {
  1044			dev_info(&i2c->dev,
  1045				 "no optional property 'temperature_calib' found, default:\n");
  1046		}
  1047		ret = device_property_read_u32(&i2c->dev, "maxim,r0_calib",
  1048					       &max98390->ref_rdc_value);
  1049		if (ret) {
  1050			dev_info(&i2c->dev,
  1051				 "no optional property 'r0_calib' found, default:\n");
  1052		}
  1053	
  1054		dev_info(&i2c->dev,
  1055			"%s: r0_calib: 0x%x,temperature_calib: 0x%x",
  1056			__func__, max98390->ref_rdc_value,
  1057			max98390->ambient_temp_value);
  1058	
  1059		ret = device_property_read_string(&i2c->dev, "maxim,dsm_param_name",
  1060					       &max98390->dsm_param_name);
  1061		if (ret)
  1062			max98390->dsm_param_name = "default";
  1063	
  1064		/* voltage/current slot configuration */
  1065		max98390_slot_config(i2c, max98390);
  1066	
  1067		/* regmap initialization */
  1068		max98390->regmap = devm_regmap_init_i2c(i2c, &max98390_regmap);
  1069		if (IS_ERR(max98390->regmap)) {
  1070			ret = PTR_ERR(max98390->regmap);
  1071			dev_err(&i2c->dev,
  1072				"Failed to allocate regmap: %d\n", ret);
  1073			return ret;
  1074		}
  1075	
> 1076		reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> 1077						     "reset", GPIOD_OUT_HIGH);
  1078	
  1079		/* Power on device */
  1080		if (reset_gpio) {
  1081			usleep_range(1000, 2000);
  1082			/* bring out of reset */
> 1083			gpiod_set_value_cansleep(reset_gpio, 0);
  1084			usleep_range(1000, 2000);
  1085		}
  1086	
  1087		/* Check Revision ID */
  1088		ret = regmap_read(max98390->regmap,
  1089			MAX98390_R24FF_REV_ID, &reg);
  1090		if (ret) {
  1091			dev_err(&i2c->dev,
  1092				"ret=%d, Failed to read: 0x%02X\n",
  1093				ret, MAX98390_R24FF_REV_ID);
  1094			return ret;
  1095		}
  1096		dev_info(&i2c->dev, "MAX98390 revisionID: 0x%02X\n", reg);
  1097	
  1098		ret = devm_snd_soc_register_component(&i2c->dev,
  1099				&soc_codec_dev_max98390,
  1100				max98390_dai, ARRAY_SIZE(max98390_dai));
  1101	
  1102		return ret;
  1103	}
  1104	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
