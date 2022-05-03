Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC14518A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiECQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiECQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:45:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D12C10A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651596135; x=1683132135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q5xB2Ti1JF5WQlcBGNS3B5vKYkhIFpkXFQo0311Zv1Q=;
  b=OsIAbuzMPG/6P4K/pnDHgyt1P9kE3+1ep6xfektwM5Bi7kAOpt9dpVGb
   lIcrCTpzDc82Vnr7vpQiD8WEzaqrz489xx4hmam4GkOXsYq0TrtYWJkbi
   4hmN/RunooPf4mdQGeBT2rdHfi1PGbqn9+cNgaUYk60TOH5LvRFqZcWG+
   U7N+gzwC3ofEvniClUQpKQ95YsPFr5kLuf9lyxecdWUu1NJigsnFgX+EN
   nLpsm8dqdQvduyZQ8ANUBoFPTrRtfWOKzJjmyGJaG3958LwEJ90snwAEn
   JZqfn42OvPhCAfIFs8HhhFVDa+xVpxntW+Zp6zr41nd0rTgKQve7HoQsN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="292715694"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="292715694"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="653337177"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2022 09:42:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlvbJ-000AcZ-FI;
        Tue, 03 May 2022 16:42:13 +0000
Date:   Wed, 4 May 2022 00:41:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Lee <steve.lee.analog@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:file9GaKBm 70/120] sound/soc/codecs/max98390.c:1076:22:
 error: implicit declaration of function 'devm_gpiod_get_optional'; did you
 mean 'devm_regulator_get_optional'?
Message-ID: <202205040022.uwQ0WH3E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git file9GaKBm
head:   55d2a66cfec6a4196243940f754f5b34dd2106bf
commit: 397ff024960634962af93e9e2775fc0e4fe7de92 [70/120] ASoC: max98390: Add reset gpio control
config: m68k-randconfig-c024-20220501 (https://download.01.org/0day-ci/archive/20220504/202205040022.uwQ0WH3E-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=397ff024960634962af93e9e2775fc0e4fe7de92
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci file9GaKBm
        git checkout 397ff024960634962af93e9e2775fc0e4fe7de92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
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
