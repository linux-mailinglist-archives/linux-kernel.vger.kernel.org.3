Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED450E4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiDYPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiDYPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:46:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2044091B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650901402; x=1682437402;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B9xdmkCFan9QX8u0ZKiJ85elK2ua+19ObcVwnrm8I4c=;
  b=Xx4Wjg3b/WOOKHABEzb8vlwmzAbWupwdH5BWz8QqTe7whme0fxsU/soD
   t3MsCKnAmHz6akpKqsMGhj3OiCrndBxZIprTZyc8pCKUysnhg+6OPcYQ+
   srPJTnepRRTtBXKEvB/ak88NvS4X/WJSFnLMt7+LJ8UfwK+pYHEZcahL0
   iPMyFLdmCk+qMdcwF+Yq0vdKv4oiJk5fbhs6hd+2pPllckz0r3MDqCEtV
   XYpdS90MCeBwfiwQNUVVKzVbTr03eKeUwoZ28DS/qmMjqihcCitjDkIrq
   cloY2E6ee97TwEczHyC3isf7nij7DJDZVusDtfJJyN+agMRVmMNq1xytY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325770924"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="325770924"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="677273352"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2022 08:43:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj0rt-0002dN-32;
        Mon, 25 Apr 2022 15:43:17 +0000
Date:   Mon, 25 Apr 2022 23:42:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve Lee <steve.lee.analog@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:v2_20220425_rf_asoc_add_macros_for_signed_tlv_controls_with_callbacks
 70/84] sound/soc/codecs/max98390.c:1076:22: error: implicit declaration of
 function 'devm_gpiod_get_optional'; did you mean
 'devm_regulator_get_optional'?
Message-ID: <202204252359.tBUr22QD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git v2_20220425_rf_asoc_add_macros_for_signed_tlv_controls_with_callbacks
head:   5349c0c93d15dff27d99fec12fc82040fab340bd
commit: 397ff024960634962af93e9e2775fc0e4fe7de92 [70/84] ASoC: max98390: Add reset gpio control
config: sh-randconfig-r032-20220425 (https://download.01.org/0day-ci/archive/20220425/202204252359.tBUr22QD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=397ff024960634962af93e9e2775fc0e4fe7de92
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci v2_20220425_rf_asoc_add_macros_for_signed_tlv_controls_with_callbacks
        git checkout 397ff024960634962af93e9e2775fc0e4fe7de92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash sound/soc/codecs/

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
