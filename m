Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B160564B69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGDCBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDCBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:01:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872EC2DCF;
        Sun,  3 Jul 2022 19:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656900112; x=1688436112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/TMS7XNA0yhB+IfbHBEwUp2g2vEsD03w9WFWtyG1M00=;
  b=iVnOcobtVfLYWQv5SAFq/Gn97hnZMwMHVe/1M4XKmSSGvumOyN+wGGeS
   QsQiUKBfP0zoyrwPKJvJdI0iQ/srGOqIBYkc+gXn/7QBx5mOx0zafsjd1
   vhCMKd+VjpGlA+wd6f9stJyZuer58MqDNw0KXw2ehPBZ8f/QMt6DH3KvJ
   KCynTm5m9U+iDYFwMtDj3QB4jLVdpEnw/AQjmN1BrAF6GO03p6iZTt2Zm
   xSBMqvkcCkrzpjkJ0MEej/JV8ZPrdEQqZIuuvmhtU+qcvP7qZrtUj51KO
   VIve7g+sEdvMlqPje18S+BU/nMao+jx0fXUFf3r2U38d2j92LavJBf+OT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="266036296"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266036296"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 19:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660031141"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2022 19:01:49 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8BPI-000HKJ-Kv;
        Mon, 04 Jul 2022 02:01:48 +0000
Date:   Mon, 4 Jul 2022 10:01:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dan Carpenter <error27@gmail.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <202207040948.hfArdbs2-lkp@intel.com>
References: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: s390-randconfig-r031-20220703 (https://download.01.org/0day-ci/archive/20220704/202207040948.hfArdbs2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134363208b9272a967c911f7b56c255a72a6f0a0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3003e6a1c75431265ca5bc938166239ce722c2df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220704-083456
        git checkout 3003e6a1c75431265ca5bc938166239ce722c2df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/iio/pressure/bmp280-core.c:23:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/iio/pressure/bmp280-core.c:23:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/iio/pressure/bmp280-core.c:23:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/iio/pressure/bmp280-core.c:979:5: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                   FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
                                   ^
   12 warnings and 1 error generated.


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
