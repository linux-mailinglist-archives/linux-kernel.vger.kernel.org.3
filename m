Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8BF564B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiGDCCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGDCB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:01:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FD2DD9;
        Sun,  3 Jul 2022 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656900117; x=1688436117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQw6pW9EmGvVYdueRO3MbRtsv+URwaPloyo35DtcE+k=;
  b=BQsT7KPalNxFxpkqBOGFhRPyBqTSnZuM5XO8MpsZJ7TY38nF3l5kdi6s
   VqQaRqJyq/HLOj+bp5RzpJ60SYGN+TWbdyRQK2vUtc7WD/Pqlv3heN6kC
   wse2FAtxi5gEDmhH3AEtjT3Ph37JslTv0dNZz5UMwmbrfIXybr8xN5GNp
   OdPi38Gk4lMfNZSeK4+gymuxjAjgYyf2eTi0MWWdOQnfNnWjZyRqzEtWX
   iJXt8w+LC2RibEbh5BzYHcW6OUKFF7jVtxYUNg/4W6i/SheY+dLUOmuNW
   p2cnBImppAJpEzbOyAgNRYaTIrHiHMMmphFueeRkTvpoCuMDSXeDzdNDJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281770640"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281770640"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 19:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="566984603"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2022 19:01:49 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8BPI-000HKF-JY;
        Mon, 04 Jul 2022 02:01:48 +0000
Date:   Mon, 4 Jul 2022 10:01:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     kbuild-all@lists.01.org, Dan Carpenter <error27@gmail.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <202207040924.TZR7AyQR-lkp@intel.com>
References: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 69cb6c6556ad89620547318439d6be8bb1629a5a]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220704-083456
base:   69cb6c6556ad89620547318439d6be8bb1629a5a
config: ia64-randconfig-r026-20220703 (https://download.01.org/0day-ci/archive/20220704/202207040924.TZR7AyQR-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3003e6a1c75431265ca5bc938166239ce722c2df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220704-083456
        git checkout 3003e6a1c75431265ca5bc938166239ce722c2df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/pressure/bmp280-core.c: In function 'bmp380_chip_config':
>> drivers/iio/pressure/bmp280-core.c:979:33: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     979 |                                 FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
         |                                 ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +979 drivers/iio/pressure/bmp280-core.c

   967	
   968	static int bmp380_chip_config(struct bmp280_data *data)
   969	{
   970		u8 osrs;
   971		unsigned int tmp;
   972		int ret;
   973	
   974		/* configure power control register */
   975		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
   976					BMP380_CTRL_SENSORS_MASK | BMP380_MODE_MASK,
   977					BMP380_CTRL_SENSORS_PRESS_EN |
   978					BMP380_CTRL_SENSORS_TEMP_EN |
 > 979					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
   980		if (ret < 0) {
   981			dev_err(data->dev,
   982				"failed to write operation control register\n");
   983			return ret;
   984		}
   985	
   986		/* configure oversampling */
   987		osrs = FIELD_PREP(BMP380_OSRS_TEMP_MASK, data->oversampling_temp) |
   988		       FIELD_PREP(BMP380_OSRS_PRESS_MASK, data->oversampling_press);
   989	
   990		ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
   991					BMP380_OSRS_TEMP_MASK | BMP380_OSRS_PRESS_MASK,
   992					osrs);
   993		if (ret < 0) {
   994			dev_err(data->dev, "failed to write oversampling register\n");
   995			return ret;
   996		}
   997	
   998		/* configure output data rate */
   999		ret = regmap_write_bits(data->regmap, BMP380_REG_ODR,
  1000					BMP380_ODRS_MASK, BMP380_ODRS_50HZ);
  1001		if (ret < 0) {
  1002			dev_err(data->dev, "failed to write ODR selection register\n");
  1003			return ret;
  1004		}
  1005	
  1006		/* set filter data */
  1007		ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG,
  1008					 BMP380_FILTER_MASK,
  1009					 FIELD_PREP(BMP380_FILTER_MASK, BMP380_FILTER_3X));
  1010		if (ret < 0) {
  1011			dev_err(data->dev, "failed to write config register\n");
  1012			return ret;
  1013		}
  1014	
  1015		/* wait startup_time before verifying config changes */
  1016		usleep_range(data->start_up_time, data->start_up_time + 100);
  1017	
  1018		/* check config error flag */
  1019		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
  1020		if (ret < 0) {
  1021			dev_err(data->dev,
  1022				"failed to read error register\n");
  1023			return ret;
  1024		}
  1025		if (tmp & BMP380_ERR_CONF_MASK) {
  1026			dev_warn(data->dev,
  1027				 "sensor flagged configuration as incompatible\n");
  1028			return -EINVAL;
  1029		}
  1030	
  1031		return 0;
  1032	}
  1033	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
