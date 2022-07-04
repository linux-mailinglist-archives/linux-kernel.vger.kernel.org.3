Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C7A564BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGDCcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGDCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:32:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E46382;
        Sun,  3 Jul 2022 19:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656901973; x=1688437973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gUXrEL+LxCvVxG3WsdvesscV7I7PWrPK+ypBJL0gTqk=;
  b=R4/0lUzp9Ka/9X1rYwgc89oBcx/uxhpHyYFwVVX3wjD1bs17bTDHkz6/
   zifCZ8Ek19+xdqDbZEp6evOWeZ7lVl6KEloPAH33YnT40lCdQWRKQ61gE
   2aG1/7eN7JEaB/jwDV6nwZfOH/ru2lr0V9dRhEcNvSECnPZs7vB12i9h+
   FPXmkkWMtx2IvIHfjo6aB6In7AEIJ6NOX8ETeHkp5flgZe0+g6wSBBotT
   xsj45Uj96UUKdxdkVgiOtv/+KZlEAJQpvYe2cGF1fSEBaHs+SbdVD50dD
   5iKQK2x79ggM0iuOqT+FUXdGXDAlSHb7KRrn8R9D7qeX1SpsUFhPHH+Iz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281775068"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281775068"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 19:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="734666235"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2022 19:32:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8BtK-000HMJ-5z;
        Mon, 04 Jul 2022 02:32:50 +0000
Date:   Mon, 4 Jul 2022 10:32:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
Message-ID: <202207041006.YJFp2Aj6-lkp@intel.com>
References: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 69cb6c6556ad89620547318439d6be8bb1629a5a]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220704-083456
base:   69cb6c6556ad89620547318439d6be8bb1629a5a
config: arm64-buildonly-randconfig-r001-20220703 (https://download.01.org/0day-ci/archive/20220704/202207041006.YJFp2Aj6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134363208b9272a967c911f7b56c255a72a6f0a0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b9905383fbc9858f211da589e86db6675f82f528
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220704-083456
        git checkout b9905383fbc9858f211da589e86db6675f82f528
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/pressure/bmp280-core.c:1230:11: warning: variable 'change' is uninitialized when used here [-Wuninitialized]
           change = change || aux;
                    ^~~~~~
   drivers/iio/pressure/bmp280-core.c:1205:13: note: initialize the variable 'change' to silence this warning
           bool change, aux;
                      ^
                       = 0
   1 warning generated.


vim +/change +1230 drivers/iio/pressure/bmp280-core.c

  1199	
  1200	static int bmp380_chip_config(struct bmp280_data *data)
  1201	{
  1202		u8 osrs;
  1203		unsigned int tmp;
  1204		int ret;
  1205		bool change, aux;
  1206	
  1207		/* configure power control register */
  1208		ret = regmap_update_bits(data->regmap, BMP380_REG_POWER_CONTROL,
  1209					 BMP380_CTRL_SENSORS_MASK,
  1210					 BMP380_CTRL_SENSORS_PRESS_EN |
  1211					 BMP380_CTRL_SENSORS_TEMP_EN);
  1212		if (ret < 0) {
  1213			dev_err(data->dev,
  1214				"failed to write operation control register\n");
  1215			return ret;
  1216		}
  1217	
  1218		/* configure oversampling */
  1219		osrs = FIELD_PREP(BMP380_OSRS_TEMP_MASK, data->oversampling_temp) |
  1220		       FIELD_PREP(BMP380_OSRS_PRESS_MASK, data->oversampling_press);
  1221	
  1222		ret = regmap_update_bits_check(data->regmap, BMP380_REG_OSR,
  1223					       BMP380_OSRS_TEMP_MASK |
  1224					       BMP380_OSRS_PRESS_MASK,
  1225					       osrs, &aux);
  1226		if (ret < 0) {
  1227			dev_err(data->dev, "failed to write oversampling register\n");
  1228			return ret;
  1229		}
> 1230		change = change || aux;
  1231	
  1232		/* configure output data rate */
  1233		ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
  1234					       BMP380_ODRS_MASK, data->sampling_freq,
  1235					       &aux);
  1236		if (ret < 0) {
  1237			dev_err(data->dev, "failed to write ODR selection register\n");
  1238			return ret;
  1239		}
  1240		change = change || aux;
  1241	
  1242		/* set filter data */
  1243		ret = regmap_update_bits_check(data->regmap, BMP380_REG_CONFIG,
  1244					BMP380_FILTER_MASK,
  1245					FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff),
  1246					&aux);
  1247		if (ret < 0) {
  1248			dev_err(data->dev, "failed to write config register\n");
  1249			return ret;
  1250		}
  1251		change = change || aux;
  1252	
  1253		if (change) {
  1254			/* cycle sensor state machine to reset any measurement in progress
  1255			 * configuration errors are detected in a measurment cycle.
  1256			 * If the sampling frequency is too low, it is faster to reset
  1257			 * measurement cycle and restart measurements
  1258			 */
  1259			ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
  1260						BMP380_MODE_MASK,
  1261						FIELD_PREP(BMP380_MODE_MASK,
  1262							   BMP380_MODE_SLEEP));
  1263			if (ret < 0) {
  1264				dev_err(data->dev, "failed to set sleep mode\n");
  1265				return ret;
  1266			}
  1267			usleep_range(2000, 2500);
  1268			ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
  1269						BMP380_MODE_MASK,
  1270						FIELD_PREP(BMP380_MODE_MASK,
  1271							   BMP380_MODE_NORMAL));
  1272			if (ret < 0) {
  1273				dev_err(data->dev, "failed to set normal mode\n");
  1274				return ret;
  1275			}
  1276			/* wait before checking the configuration error flag.
  1277			 * Worst case value for measure time indicated in the datashhet
  1278			 * in section 3.9.1 is used.
  1279			 */
  1280			msleep(80);
  1281	
  1282			/* check config error flag */
  1283			ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
  1284			if (ret < 0) {
  1285				dev_err(data->dev,
  1286					"failed to read error register\n");
  1287				return ret;
  1288			}
  1289			if (tmp & BMP380_ERR_CONF_MASK) {
  1290				dev_warn(data->dev,
  1291					"sensor flagged configuration as incompatible\n");
  1292				return -EINVAL;
  1293			}
  1294		}
  1295	
  1296		return 0;
  1297	}
  1298	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
