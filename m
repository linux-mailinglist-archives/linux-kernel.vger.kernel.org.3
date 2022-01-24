Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4E497A90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiAXIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:46:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:62956 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbiAXIq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013986; x=1674549986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BJE/v2RjN9UX/OUs2Tt37y6GPxwSugB2TtLpx05JknQ=;
  b=kIPYJOGicJPOD6NX4JH6asJ3ArbXgPEK6N0GKfCHlnUUwYwbRiojAvwH
   c/2j/x6cRylnDZS1SY+qNX4WG1ljHWZ8Jm5eoYVDIXZ5fnwFcLcur7PLF
   6qVkz1BB0U9i6sGsty5NsI4Y2/d6um2Gn4DoRXuVAL47m3gya/dnQE34m
   IW/OvHXyy3S15dg+oDfB/ScBCml8hdfJ+xjECaBvFI1K8p09q/UIt9nWH
   9hMKI1j8BAIrH7xbmkbP3vYm2eAJKB5tJQWUT4zFsBXppe/MkM0by7v/h
   LbZ8Eqdp+HIcD+ys0GQ5MDPdymH58aeQOZjktLIn898zWY/bug3VrkJ7d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245779129"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245779129"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="478994652"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 00:46:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBuzY-000I2n-0k; Mon, 24 Jan 2022 08:46:24 +0000
Date:   Mon, 24 Jan 2022 16:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/max98927.c:902:19: error: implicit declaration of
 function 'devm_gpiod_get_optional'; did you mean
 'devm_regulator_get_optional'?
Message-ID: <202201241652.HcxYQUSR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alejandro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 4d67dc1998f1890a9d22d03208037075ea9f2562 ASoC: max98927: Handle reset gpio when probing i2c
date:   4 months ago
config: alpha-randconfig-r034-20220123 (https://download.01.org/0day-ci/archive/20220124/202201241652.HcxYQUSR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d67dc1998f1890a9d22d03208037075ea9f2562
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4d67dc1998f1890a9d22d03208037075ea9f2562
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/max98927.c: In function 'max98927_i2c_probe':
>> sound/soc/codecs/max98927.c:902:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
     902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
         |                   devm_regulator_get_optional
>> sound/soc/codecs/max98927.c:902:63: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
     902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
         |                                                               ^~~~~~~~~~~~~~
         |                                                               GPIOF_INIT_HIGH
   sound/soc/codecs/max98927.c:902:63: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/codecs/max98927.c:909:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
     909 |                 gpiod_set_value_cansleep(max98927->reset_gpio, 0);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 gpio_set_value_cansleep
   cc1: some warnings being treated as errors


vim +902 sound/soc/codecs/max98927.c

   867	
   868		int ret = 0, value;
   869		int reg = 0;
   870		struct max98927_priv *max98927 = NULL;
   871	
   872		max98927 = devm_kzalloc(&i2c->dev,
   873			sizeof(*max98927), GFP_KERNEL);
   874	
   875		if (!max98927) {
   876			ret = -ENOMEM;
   877			return ret;
   878		}
   879		i2c_set_clientdata(i2c, max98927);
   880	
   881		/* update interleave mode info */
   882		if (!of_property_read_u32(i2c->dev.of_node,
   883			"interleave_mode", &value)) {
   884			if (value > 0)
   885				max98927->interleave_mode = true;
   886			else
   887				max98927->interleave_mode = false;
   888		} else
   889			max98927->interleave_mode = false;
   890	
   891		/* regmap initialization */
   892		max98927->regmap
   893			= devm_regmap_init_i2c(i2c, &max98927_regmap);
   894		if (IS_ERR(max98927->regmap)) {
   895			ret = PTR_ERR(max98927->regmap);
   896			dev_err(&i2c->dev,
   897				"Failed to allocate regmap: %d\n", ret);
   898			return ret;
   899		}
   900		
   901		max98927->reset_gpio 
 > 902			= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
   903		if (IS_ERR(max98927->reset_gpio)) {
   904			ret = PTR_ERR(max98927->reset_gpio);
   905			return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");
   906		}
   907	
   908		if (max98927->reset_gpio) {
 > 909			gpiod_set_value_cansleep(max98927->reset_gpio, 0);
   910			/* Wait for i2c port to be ready */
   911			usleep_range(5000, 6000);
   912		}
   913	
   914		/* Check Revision ID */
   915		ret = regmap_read(max98927->regmap,
   916			MAX98927_R01FF_REV_ID, &reg);
   917		if (ret < 0) {
   918			dev_err(&i2c->dev,
   919				"Failed to read: 0x%02X\n", MAX98927_R01FF_REV_ID);
   920			return ret;
   921		}
   922		dev_info(&i2c->dev, "MAX98927 revisionID: 0x%02X\n", reg);
   923	
   924		/* voltage/current slot configuration */
   925		max98927_slot_config(i2c, max98927);
   926	
   927		/* codec registeration */
   928		ret = devm_snd_soc_register_component(&i2c->dev,
   929			&soc_component_dev_max98927,
   930			max98927_dai, ARRAY_SIZE(max98927_dai));
   931		if (ret < 0)
   932			dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
   933	
   934		return ret;
   935	}
   936	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
