Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A947E56A59D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiGGOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiGGOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:38:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7D27179
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657204730; x=1688740730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZaAXyGMEyToLnNj56DzNgRJKuMZcMVgAaeCfXuBRmok=;
  b=KjqTk84nUKxLb7ZM7o8M8Pi4wpvLUNro3bEBJS0ohjAnQX2ISk1ftYBO
   Lb+5U3SAElg15I8/lmq9fkn4RvLBhaMTQhObuCR/yMmgBIJJjEKVA3gXS
   2Gsq0FRE9j3h430UeOLUQ1XfziGcVDGvsdVpJPbHTsCiHO5rik5QhFwt/
   WiA+fm64BbKk02Add4EHiB+veGIAtD04xjin18IUvFxJnd2n1M/xCVxUV
   OXhzdBcWwWKzlTjT5lISURInWz66LeTK9vu5VMMQAVG/rPzURNJDacfPM
   RynkxBGT3c7810sxevOlfCq6Vh4uYscmsLcyjqlMxUpvN4xjnWh1iWJr2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263822767"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263822767"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 07:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="920612479"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 07:38:48 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9SeV-000M7E-I6;
        Thu, 07 Jul 2022 14:38:47 +0000
Date:   Thu, 7 Jul 2022 22:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: Re: [PATCH v2 4/5] iio: max597x: Add support for max597x
Message-ID: <202207072254.zty3CXkg-lkp@intel.com>
References: <20220707134141.1172300-5-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707134141.1172300-5-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 9f09069cde34dcd86f5ecf3a3139fd752020812f]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/mfd-max597x-Add-support-for-max597x/20220707-214501
base:   9f09069cde34dcd86f5ecf3a3139fd752020812f
config: um-i386_defconfig
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/22ea6b6b3fde4f8c03be1f1d0345f3d1fcc295e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naresh-Solanki/mfd-max597x-Add-support-for-max597x/20220707-214501
        git checkout 22ea6b6b3fde4f8c03be1f1d0345f3d1fcc295e8
        make W=1 ARCH=um SUBARCH=i386 defconfig
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/regulator/Kconfig:554: syntax error
   drivers/regulator/Kconfig:553: invalid statement
   drivers/regulator/Kconfig:554: invalid statement
   drivers/regulator/Kconfig:555:warning: ignoring unsupported character '/'
   drivers/regulator/Kconfig:555:warning: ignoring unsupported character '.'
   drivers/regulator/Kconfig:555: unknown statement "This"
   drivers/regulator/Kconfig:556:warning: ignoring unsupported character '/'
   drivers/regulator/Kconfig:556:warning: ignoring unsupported character ','
   drivers/regulator/Kconfig:556: unknown statement "The"
   drivers/regulator/Kconfig:557:warning: ignoring unsupported character '.'
   drivers/regulator/Kconfig:557: unknown statement "fault"
>> drivers/iio/adc/Kconfig:691: syntax error
   drivers/iio/adc/Kconfig:690: invalid statement
   drivers/iio/adc/Kconfig:691: invalid statement
   drivers/iio/adc/Kconfig:692:warning: ignoring unsupported character '/'
   drivers/iio/adc/Kconfig:692:warning: ignoring unsupported character '/'
   drivers/iio/adc/Kconfig:692: unknown statement "This"
   drivers/iio/adc/Kconfig:693:warning: ignoring unsupported character '.'
   drivers/iio/adc/Kconfig:693: unknown statement "interface"
   make[2]: *** [scripts/kconfig/Makefile:87: defconfig] Error 1
   make[1]: *** [Makefile:629: defconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'defconfig' not remade because of errors.
--
   drivers/regulator/Kconfig:554: syntax error
   drivers/regulator/Kconfig:553: invalid statement
   drivers/regulator/Kconfig:554: invalid statement
   drivers/regulator/Kconfig:555:warning: ignoring unsupported character '/'
   drivers/regulator/Kconfig:555:warning: ignoring unsupported character '.'
   drivers/regulator/Kconfig:555: unknown statement "This"
   drivers/regulator/Kconfig:556:warning: ignoring unsupported character '/'
   drivers/regulator/Kconfig:556:warning: ignoring unsupported character ','
   drivers/regulator/Kconfig:556: unknown statement "The"
   drivers/regulator/Kconfig:557:warning: ignoring unsupported character '.'
   drivers/regulator/Kconfig:557: unknown statement "fault"
>> drivers/iio/adc/Kconfig:691: syntax error
   drivers/iio/adc/Kconfig:690: invalid statement
   drivers/iio/adc/Kconfig:691: invalid statement
   drivers/iio/adc/Kconfig:692:warning: ignoring unsupported character '/'
   drivers/iio/adc/Kconfig:692:warning: ignoring unsupported character '/'
   drivers/iio/adc/Kconfig:692: unknown statement "This"
   drivers/iio/adc/Kconfig:693:warning: ignoring unsupported character '.'
   drivers/iio/adc/Kconfig:693: unknown statement "interface"
   make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[1]: *** [Makefile:629: oldconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
   drivers/regulator/Kconfig:554: syntax error
   drivers/regulator/Kconfig:553: invalid statement
   drivers/regulator/Kconfig:554: invalid statement
   drivers/regulator/Kconfig:555:warning: ignoring unsupported character '/'
   drivers/regulator/Kconfig:555:warning: ignoring unsupported character '.'
   drivers/regulator/Kconfig:555: unknown statement "This"
   drivers/regulator/Kconfig:556:warning: ignoring unsupported character '/'
   drivers/regulator/Kconfig:556:warning: ignoring unsupported character ','
   drivers/regulator/Kconfig:556: unknown statement "The"
   drivers/regulator/Kconfig:557:warning: ignoring unsupported character '.'
   drivers/regulator/Kconfig:557: unknown statement "fault"
>> drivers/iio/adc/Kconfig:691: syntax error
   drivers/iio/adc/Kconfig:690: invalid statement
   drivers/iio/adc/Kconfig:691: invalid statement
   drivers/iio/adc/Kconfig:692:warning: ignoring unsupported character '/'
   drivers/iio/adc/Kconfig:692:warning: ignoring unsupported character '/'
   drivers/iio/adc/Kconfig:692: unknown statement "This"
   drivers/iio/adc/Kconfig:693:warning: ignoring unsupported character '.'
   drivers/iio/adc/Kconfig:693: unknown statement "interface"
   make[2]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[1]: *** [Makefile:629: olddefconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +691 drivers/iio/adc/Kconfig

     8	
     9	config AB8500_GPADC
    10		bool "ST-Ericsson AB8500 GPADC driver"
    11		depends on AB8500_CORE && REGULATOR_AB8500
    12		default y
    13		help
    14		  AB8500 Analog Baseband, mixed signal integrated circuit GPADC
    15		  (General Purpose Analog to Digital Converter) driver used to monitor
    16		  internal voltages, convert accessory and battery, AC (charger, mains)
    17		  and USB voltages integral to the U8500 platform.
    18	
    19	config AD_SIGMA_DELTA
    20		tristate
    21		select IIO_BUFFER
    22		select IIO_TRIGGERED_BUFFER
    23	
    24	config AD7091R5
    25		tristate "Analog Devices AD7091R5 ADC Driver"
    26		depends on I2C
    27		select REGMAP_I2C
    28		help
    29		  Say yes here to build support for Analog Devices AD7091R-5 ADC.
    30	
    31	config AD7124
    32		tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
    33		depends on SPI_MASTER
    34		select AD_SIGMA_DELTA
    35		help
    36		  Say yes here to build support for Analog Devices AD7124-4 and AD7124-8
    37		  SPI analog to digital converters (ADC).
    38	
    39		  To compile this driver as a module, choose M here: the module will be
    40		  called ad7124.
    41	
    42	config AD7192
    43		tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
    44		depends on SPI
    45		select AD_SIGMA_DELTA
    46		help
    47		  Say yes here to build support for Analog Devices AD7190,
    48		  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
    49		  If unsure, say N (but it's safe to say "Y").
    50	
    51		  To compile this driver as a module, choose M here: the
    52		  module will be called ad7192.
    53	
    54	config AD7266
    55		tristate "Analog Devices AD7265/AD7266 ADC driver"
    56		depends on SPI_MASTER
    57		select IIO_BUFFER
    58		select IIO_TRIGGER
    59		select IIO_TRIGGERED_BUFFER
    60		help
    61		  Say yes here to build support for Analog Devices AD7265 and AD7266
    62		  ADCs.
    63	
    64		  To compile this driver as a module, choose M here: the module will be
    65		  called ad7266.
    66	
    67	config AD7280
    68		tristate "Analog Devices AD7280A Lithium Ion Battery Monitoring System"
    69		depends on SPI
    70		select CRC8
    71		help
    72		  Say yes here to build support for Analog Devices AD7280A
    73		  Lithium Ion Battery Monitoring System.
    74	
    75		  To compile this driver as a module, choose M here: the
    76		  module will be called ad7280a
    77	
    78	config AD7291
    79		tristate "Analog Devices AD7291 ADC driver"
    80		depends on I2C
    81		help
    82		  Say yes here to build support for Analog Devices AD7291
    83		  8 Channel ADC with temperature sensor.
    84	
    85		  To compile this driver as a module, choose M here: the
    86		  module will be called ad7291.
    87	
    88	config AD7292
    89		tristate "Analog Devices AD7292 ADC driver"
    90		depends on SPI
    91		help
    92		  Say yes here to build support for Analog Devices AD7292
    93		  8 Channel ADC with temperature sensor.
    94	
    95		  To compile this driver as a module, choose M here: the
    96		  module will be called ad7292.
    97	
    98	config AD7298
    99		tristate "Analog Devices AD7298 ADC driver"
   100		depends on SPI
   101		select IIO_BUFFER
   102		select IIO_TRIGGERED_BUFFER
   103		help
   104		  Say yes here to build support for Analog Devices AD7298
   105		  8 Channel ADC with temperature sensor.
   106	
   107		  To compile this driver as a module, choose M here: the
   108		  module will be called ad7298.
   109	
   110	config AD7476
   111		tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
   112		depends on SPI
   113		select IIO_BUFFER
   114		select IIO_TRIGGERED_BUFFER
   115		help
   116		  Say yes here to build support for the following SPI analog to
   117		  digital converters (ADCs):
   118		  Analog Devices: AD7273, AD7274, AD7276, AD7277, AD7278, AD7475,
   119		  AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495, AD7910,
   120		  AD7920.
   121		  Texas Instruments: ADS7866, ADS7867, ADS7868.
   122	
   123		  To compile this driver as a module, choose M here: the
   124		  module will be called ad7476.
   125	
   126	config AD7606
   127		tristate
   128		select IIO_BUFFER
   129		select IIO_TRIGGERED_BUFFER
   130	
   131	config AD7606_IFACE_PARALLEL
   132		tristate "Analog Devices AD7606 ADC driver with parallel interface support"
   133		depends on HAS_IOMEM
   134		select AD7606
   135		help
   136		  Say yes here to build parallel interface support for Analog Devices:
   137		  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
   138	
   139		  To compile this driver as a module, choose M here: the
   140		  module will be called ad7606_parallel.
   141	
   142	config AD7606_IFACE_SPI
   143		tristate "Analog Devices AD7606 ADC driver with spi interface support"
   144		depends on SPI
   145		select AD7606
   146		help
   147		  Say yes here to build spi interface support for Analog Devices:
   148		  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
   149	
   150		  To compile this driver as a module, choose M here: the
   151		  module will be called ad7606_spi.
   152	
   153	config AD7766
   154		tristate "Analog Devices AD7766/AD7767 ADC driver"
   155		depends on SPI_MASTER
   156		select IIO_BUFFER
   157		select IIO_TRIGGERED_BUFFER
   158		help
   159		  Say yes here to build support for Analog Devices AD7766, AD7766-1,
   160		  AD7766-2, AD7767, AD7767-1, AD7767-2 SPI analog to digital converters.
   161	
   162		  To compile this driver as a module, choose M here: the module will be
   163		  called ad7766.
   164	
   165	config AD7768_1
   166		tristate "Analog Devices AD7768-1 ADC driver"
   167		depends on SPI
   168		select IIO_BUFFER
   169		select IIO_TRIGGER
   170		select IIO_TRIGGERED_BUFFER
   171		help
   172		  Say yes here to build support for Analog Devices AD7768-1 SPI
   173		  simultaneously sampling sigma-delta analog to digital converter (ADC).
   174	
   175		  To compile this driver as a module, choose M here: the module will be
   176		  called ad7768-1.
   177	
   178	config AD7780
   179		tristate "Analog Devices AD7780 and similar ADCs driver"
   180		depends on SPI
   181		depends on GPIOLIB || COMPILE_TEST
   182		select AD_SIGMA_DELTA
   183		help
   184		  Say yes here to build support for Analog Devices AD7170, AD7171,
   185		  AD7780 and AD7781 SPI analog to digital converters (ADC).
   186	
   187		  To compile this driver as a module, choose M here: the
   188		  module will be called ad7780.
   189	
   190	config AD7791
   191		tristate "Analog Devices AD7791 ADC driver"
   192		depends on SPI
   193		select AD_SIGMA_DELTA
   194		help
   195		  Say yes here to build support for Analog Devices AD7787, AD7788, AD7789,
   196		  AD7790 and AD7791 SPI analog to digital converters (ADC).
   197	
   198		  To compile this driver as a module, choose M here: the module will be
   199		  called ad7791.
   200	
   201	config AD7793
   202		tristate "Analog Devices AD7793 and similar ADCs driver"
   203		depends on SPI
   204		select AD_SIGMA_DELTA
   205		help
   206		  Say yes here to build support for Analog Devices AD7785, AD7792, AD7793,
   207		  AD7794 and AD7795 SPI analog to digital converters (ADC).
   208	
   209		  To compile this driver as a module, choose M here: the
   210		  module will be called AD7793.
   211	
   212	config AD7887
   213		tristate "Analog Devices AD7887 ADC driver"
   214		depends on SPI
   215		select IIO_BUFFER
   216		select IIO_TRIGGERED_BUFFER
   217		help
   218		  Say yes here to build support for Analog Devices
   219		  AD7887 SPI analog to digital converter (ADC).
   220	
   221		  To compile this driver as a module, choose M here: the
   222		  module will be called ad7887.
   223	
   224	config AD7923
   225		tristate "Analog Devices AD7923 and similar ADCs driver"
   226		depends on SPI
   227		select IIO_BUFFER
   228		select IIO_TRIGGERED_BUFFER
   229		help
   230		  Say yes here to build support for Analog Devices
   231		  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
   232	
   233		  To compile this driver as a module, choose M here: the
   234		  module will be called ad7923.
   235	
   236	config AD7949
   237		tristate "Analog Devices AD7949 and similar ADCs driver"
   238		depends on SPI
   239		help
   240		  Say yes here to build support for Analog Devices
   241		  AD7949, AD7682, AD7689 8 Channel ADCs.
   242	
   243		  To compile this driver as a module, choose M here: the
   244		  module will be called ad7949.
   245	
   246	config AD799X
   247		tristate "Analog Devices AD799x ADC driver"
   248		depends on I2C
   249		select IIO_BUFFER
   250		select IIO_TRIGGERED_BUFFER
   251		help
   252		  Say yes here to build support for Analog Devices:
   253		  ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997, ad7998
   254		  i2c analog to digital converters (ADC). Provides direct access
   255		  via sysfs.
   256	
   257		  To compile this driver as a module, choose M here: the module will be
   258		  called ad799x.
   259	
   260	config AD9467
   261		tristate "Analog Devices AD9467 High Speed ADC driver"
   262		depends on SPI
   263		depends on ADI_AXI_ADC
   264		help
   265		  Say yes here to build support for Analog Devices:
   266		  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
   267	
   268		  The driver requires the assistance of the AXI ADC IP core to operate,
   269		  since SPI is used for configuration only, while data has to be
   270		  streamed into memory via DMA.
   271	
   272		  To compile this driver as a module, choose M here: the module will be
   273		  called ad9467.
   274	
   275	config ADI_AXI_ADC
   276		tristate "Analog Devices Generic AXI ADC IP core driver"
   277		select IIO_BUFFER
   278		select IIO_BUFFER_HW_CONSUMER
   279		select IIO_BUFFER_DMAENGINE
   280		depends on HAS_IOMEM
   281		depends on OF
   282		help
   283		  Say yes here to build support for Analog Devices Generic
   284		  AXI ADC IP core. The IP core is used for interfacing with
   285		  analog-to-digital (ADC) converters that require either a high-speed
   286		  serial interface (JESD204B/C) or a source synchronous parallel
   287		  interface (LVDS/CMOS).
   288		  Typically (for such devices) SPI will be used for configuration only,
   289		  while this IP core handles the streaming of data into memory via DMA.
   290	
   291		  Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
   292		  If unsure, say N (but it's safe to say "Y").
   293	
   294		  To compile this driver as a module, choose M here: the
   295		  module will be called adi-axi-adc.
   296	
   297	config ASPEED_ADC
   298		tristate "Aspeed ADC"
   299		depends on ARCH_ASPEED || COMPILE_TEST
   300		depends on COMMON_CLK
   301		help
   302		  If you say yes here you get support for the ADC included in Aspeed
   303		  BMC SoCs.
   304	
   305		  To compile this driver as a module, choose M here: the module will be
   306		  called aspeed_adc.
   307	
   308	config AT91_ADC
   309		tristate "Atmel AT91 ADC"
   310		depends on ARCH_AT91 || COMPILE_TEST
   311		depends on INPUT && SYSFS && OF
   312		select IIO_BUFFER
   313		select IIO_TRIGGERED_BUFFER
   314		help
   315		  Say yes here to build support for Atmel AT91 ADC.
   316	
   317		  To compile this driver as a module, choose M here: the module will be
   318		  called at91_adc.
   319	
   320	config AT91_SAMA5D2_ADC
   321		tristate "Atmel AT91 SAMA5D2 ADC"
   322		depends on ARCH_AT91 || COMPILE_TEST
   323		depends on HAS_IOMEM
   324		select IIO_BUFFER
   325		select IIO_TRIGGERED_BUFFER
   326		help
   327		  Say yes here to build support for Atmel SAMA5D2 ADC which is
   328		  available on SAMA5D2 SoC family.
   329	
   330		  To compile this driver as a module, choose M here: the module will be
   331		  called at91-sama5d2_adc.
   332	
   333	config AXP20X_ADC
   334		tristate "X-Powers AXP20X and AXP22X ADC driver"
   335		depends on MFD_AXP20X
   336		help
   337		  Say yes here to have support for X-Powers power management IC (PMIC)
   338		  AXP20X and AXP22X ADC devices.
   339	
   340		  To compile this driver as a module, choose M here: the module will be
   341		  called axp20x_adc.
   342	
   343	config AXP288_ADC
   344		tristate "X-Powers AXP288 ADC driver"
   345		depends on MFD_AXP20X
   346		help
   347		  Say yes here to have support for X-Powers power management IC (PMIC) ADC
   348		  device. Depending on platform configuration, this general purpose ADC can
   349		  be used for sampling sensors such as thermal resistors.
   350	
   351		  To compile this driver as a module, choose M here: the module will be
   352		  called axp288_adc.
   353	
   354	config BCM_IPROC_ADC
   355		tristate "Broadcom IPROC ADC driver"
   356		depends on (ARCH_BCM_IPROC && OF) || COMPILE_TEST
   357		depends on MFD_SYSCON
   358		default ARCH_BCM_CYGNUS
   359		help
   360		  Say Y here if you want to add support for the Broadcom static
   361		  ADC driver.
   362	
   363		  Broadcom iProc ADC driver. Broadcom iProc ADC controller has 8
   364		  channels. The driver allows the user to read voltage values.
   365	
   366	config BERLIN2_ADC
   367		tristate "Marvell Berlin2 ADC driver"
   368		depends on ARCH_BERLIN || COMPILE_TEST
   369		help
   370		  Marvell Berlin2 ADC driver. This ADC has 8 channels, with one used for
   371		  temperature measurement.
   372	
   373	config CC10001_ADC
   374		tristate "Cosmic Circuits 10001 ADC driver"
   375		depends on HAS_IOMEM && HAVE_CLK && REGULATOR
   376		select IIO_BUFFER
   377		select IIO_TRIGGERED_BUFFER
   378		help
   379		  Say yes here to build support for Cosmic Circuits 10001 ADC.
   380	
   381		  This driver can also be built as a module. If so, the module will be
   382		  called cc10001_adc.
   383	
   384	config CPCAP_ADC
   385		tristate "Motorola CPCAP PMIC ADC driver"
   386		depends on MFD_CPCAP
   387		select IIO_BUFFER
   388		select IIO_TRIGGERED_BUFFER
   389		help
   390		  Say yes here to build support for Motorola CPCAP PMIC ADC.
   391	
   392		  This driver can also be built as a module. If so, the module will be
   393		  called cpcap-adc.
   394	
   395	config DA9150_GPADC
   396		tristate "Dialog DA9150 GPADC driver support"
   397		depends on MFD_DA9150
   398		help
   399		  Say yes here to build support for Dialog DA9150 GPADC.
   400	
   401		  This driver can also be built as a module. If chosen, the module name
   402		  will be da9150-gpadc.
   403	
   404		  To compile this driver as a module, choose M here: the module will be
   405		  called berlin2-adc.
   406	
   407	config DLN2_ADC
   408		tristate "Diolan DLN-2 ADC driver support"
   409		depends on MFD_DLN2
   410		select IIO_BUFFER
   411		select IIO_TRIGGERED_BUFFER
   412		help
   413		  Say yes here to build support for Diolan DLN-2 ADC.
   414	
   415		  This driver can also be built as a module. If so, the module will be
   416		  called adc_dln2.
   417	
   418	config ENVELOPE_DETECTOR
   419		tristate "Envelope detector using a DAC and a comparator"
   420		depends on OF
   421		help
   422		  Say yes here to build support for an envelope detector using a DAC
   423		  and a comparator.
   424	
   425		  To compile this driver as a module, choose M here: the module will be
   426		  called envelope-detector.
   427	
   428	config EP93XX_ADC
   429		tristate "Cirrus Logic EP93XX ADC driver"
   430		depends on ARCH_EP93XX
   431		help
   432		  Driver for the ADC module on the EP93XX series of SoC from Cirrus Logic.
   433		  It's recommended to switch on CONFIG_HIGH_RES_TIMERS option, in this
   434		  case driver will reduce its CPU usage by 90% in some use cases.
   435	
   436		  To compile this driver as a module, choose M here: the module will be
   437		  called ep93xx_adc.
   438	
   439	config EXYNOS_ADC
   440		tristate "Exynos ADC driver support"
   441		depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || (OF && COMPILE_TEST)
   442		depends on HAS_IOMEM
   443		help
   444		  Driver for the ADC block found in the Samsung S3C (S3C2410, S3C2416,
   445		  S3C2440, S3C2443, S3C6410), S5Pv210 and Exynos SoCs.
   446		  Choose Y here only if you build for such Samsung SoC.
   447	
   448		  To compile this driver as a module, choose M here: the module will be
   449		  called exynos_adc.
   450	
   451	config MXS_LRADC_ADC
   452		tristate "Freescale i.MX23/i.MX28 LRADC ADC"
   453		depends on MFD_MXS_LRADC
   454		select IIO_BUFFER
   455		select IIO_TRIGGERED_BUFFER
   456		help
   457		  Say yes here to build support for the ADC functions of the
   458		  i.MX23/i.MX28 LRADC. This includes general-purpose ADC readings,
   459		  battery voltage measurement, and die temperature measurement.
   460	
   461		  This driver can also be built as a module. If so, the module will be
   462		  called mxs-lradc-adc.
   463	
   464	config FSL_MX25_ADC
   465		tristate "Freescale MX25 ADC driver"
   466		depends on MFD_MX25_TSADC
   467		help
   468		  Generic Conversion Queue driver used for general purpose ADC in the
   469		  MX25. This driver supports single measurements using the MX25 ADC.
   470	
   471	config HI8435
   472		tristate "Holt Integrated Circuits HI-8435 threshold detector"
   473		select IIO_TRIGGERED_EVENT
   474		depends on SPI
   475		help
   476		  If you say yes here you get support for Holt Integrated Circuits
   477		  HI-8435 chip.
   478	
   479		  This driver can also be built as a module. If so, the module will be
   480		  called hi8435.
   481	
   482	config HX711
   483		tristate "AVIA HX711 ADC for weight cells"
   484		depends on GPIOLIB
   485		select IIO_BUFFER
   486		select IIO_TRIGGERED_BUFFER
   487		help
   488		  If you say yes here you get support for AVIA HX711 ADC which is used
   489		  for weigh cells
   490	
   491		  This driver uses two GPIOs, one acts as the clock and controls the
   492		  channel selection and gain, the other one is used for the measurement
   493		  data
   494	
   495		  Currently the raw value is read from the chip and delivered.
   496		  To get an actual weight one needs to subtract the
   497		  zero offset and multiply by a scale factor.
   498		  This should be done in userspace.
   499	
   500		  This driver can also be built as a module. If so, the module will be
   501		  called hx711.
   502	
   503	config INA2XX_ADC
   504		tristate "Texas Instruments INA2xx Power Monitors IIO driver"
   505		depends on I2C && !SENSORS_INA2XX
   506		select REGMAP_I2C
   507		select IIO_BUFFER
   508		select IIO_KFIFO_BUF
   509		help
   510		  Say yes here to build support for TI INA2xx family of Power Monitors.
   511		  This driver is mutually exclusive with the HWMON version.
   512	
   513	config INGENIC_ADC
   514		tristate "Ingenic JZ47xx SoCs ADC driver"
   515		depends on MIPS || COMPILE_TEST
   516		select IIO_BUFFER
   517		help
   518		  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
   519	
   520		  This driver can also be built as a module. If so, the module will be
   521		  called ingenic_adc.
   522	
   523	config INTEL_MRFLD_ADC
   524		tristate "Intel Merrifield Basin Cove ADC driver"
   525		depends on INTEL_SOC_PMIC_MRFLD
   526		help
   527		  Say yes here to have support for Basin Cove power management IC (PMIC) ADC
   528		  device. Depending on platform configuration, this general purpose ADC can
   529		  be used for sampling sensors such as thermal resistors.
   530	
   531		  To compile this driver as a module, choose M here: the module will be
   532		  called intel_mrfld_adc.
   533	
   534	config IMX7D_ADC
   535		tristate "Freescale IMX7D ADC driver"
   536		depends on ARCH_MXC || COMPILE_TEST
   537		depends on HAS_IOMEM
   538		help
   539		  Say yes here to build support for IMX7D ADC.
   540	
   541		  This driver can also be built as a module. If so, the module will be
   542		  called imx7d_adc.
   543	
   544	config IMX8QXP_ADC
   545		tristate "NXP IMX8QXP ADC driver"
   546		depends on ARCH_MXC || COMPILE_TEST
   547		depends on HAS_IOMEM
   548		help
   549		  Say yes here to build support for IMX8QXP ADC.
   550	
   551		  This driver can also be built as a module. If so, the module will be
   552		  called imx8qxp-adc.
   553	
   554	config LP8788_ADC
   555		tristate "LP8788 ADC driver"
   556		depends on MFD_LP8788
   557		help
   558		  Say yes here to build support for TI LP8788 ADC.
   559	
   560		  To compile this driver as a module, choose M here: the module will be
   561		  called lp8788_adc.
   562	
   563	config LPC18XX_ADC
   564		tristate "NXP LPC18xx ADC driver"
   565		depends on ARCH_LPC18XX || COMPILE_TEST
   566		depends on OF && HAS_IOMEM
   567		help
   568		  Say yes here to build support for NXP LPC18XX ADC.
   569	
   570		  To compile this driver as a module, choose M here: the module will be
   571		  called lpc18xx_adc.
   572	
   573	config LPC32XX_ADC
   574		tristate "NXP LPC32XX ADC"
   575		depends on ARCH_LPC32XX || COMPILE_TEST
   576		depends on HAS_IOMEM
   577		help
   578		  Say yes here to build support for the integrated ADC inside the
   579		  LPC32XX SoC. Note that this feature uses the same hardware as the
   580		  touchscreen driver, so you should either select only one of the two
   581		  drivers (lpc32xx_adc or lpc32xx_ts) or, in the OpenFirmware case,
   582		  activate only one via device tree selection.  Provides direct access
   583		  via sysfs.
   584	
   585	config LTC2471
   586		tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
   587		depends on I2C
   588		help
   589		  Say yes here to build support for Linear Technology LTC2471 and
   590		  LTC2473 16-bit I2C ADC.
   591	
   592		  This driver can also be built as a module. If so, the module will
   593		  be called ltc2471.
   594	
   595	config LTC2485
   596		tristate "Linear Technology LTC2485 ADC driver"
   597		depends on I2C
   598		help
   599		  Say yes here to build support for Linear Technology LTC2485 ADC.
   600	
   601		  To compile this driver as a module, choose M here: the module will be
   602		  called ltc2485.
   603	
   604	config LTC2496
   605		tristate "Linear Technology LTC2496 ADC driver"
   606		depends on SPI
   607		help
   608		  Say yes here to build support for Linear Technology LTC2496
   609		  16-Bit 8-/16-Channel Delta Sigma ADC.
   610	
   611		  To compile this driver as a module, choose M here: the module will be
   612		  called ltc2496.
   613	
   614	config LTC2497
   615		tristate "Linear Technology LTC2497 ADC driver"
   616		depends on I2C
   617		help
   618		  Say yes here to build support for Linear Technology LTC2497
   619		  16-Bit 8-/16-Channel Delta Sigma ADC.
   620	
   621		  To compile this driver as a module, choose M here: the module will be
   622		  called ltc2497.
   623	
   624	config MAX1027
   625		tristate "Maxim max1027 ADC driver"
   626		depends on SPI
   627		select IIO_BUFFER
   628		select IIO_TRIGGERED_BUFFER
   629		help
   630		  Say yes here to build support for Maxim SPI {10,12}-bit ADC models:
   631		  max1027, max1029, max1031, max1227, max1229 and max1231.
   632	
   633		  To compile this driver as a module, choose M here: the module will be
   634		  called max1027.
   635	
   636	config MAX11100
   637		tristate "Maxim max11100 ADC driver"
   638		depends on SPI_MASTER
   639		help
   640		  Say yes here to build support for Maxim max11100 SPI ADC
   641	
   642		  To compile this driver as a module, choose M here: the module will be
   643		  called max11100.
   644	
   645	config MAX1118
   646		tristate "Maxim max1117/max1118/max1119 ADCs driver"
   647		depends on SPI
   648		select IIO_BUFFER
   649		select IIO_TRIGGERED_BUFFER
   650		help
   651		  Say yes here to build support for Maxim max1117/max1118/max1119
   652		  8-bit, dual-channel ADCs.
   653	
   654		  To compile this driver as a module, choose M here: the module will be
   655		  called max1118.
   656	
   657	config MAX1241
   658		tristate "Maxim max1241 ADC driver"
   659		depends on SPI_MASTER
   660		help
   661		  Say yes here to build support for Maxim max1241 12-bit, single-channel
   662		  ADC.
   663	
   664		  To compile this driver as a module, choose M here: the module will be
   665		  called max1241.
   666	
   667	config MAX1363
   668		tristate "Maxim max1363 ADC driver"
   669		depends on I2C
   670		select IIO_BUFFER
   671		select IIO_TRIGGERED_BUFFER
   672		help
   673		  Say yes here to build support for many Maxim i2c analog to digital
   674		  converters (ADC). (max1361, max1362, max1363, max1364, max1036,
   675		  max1037, max1038, max1039, max1136, max1136, max1137, max1138,
   676		  max1139, max1236, max1237, max11238, max1239, max11600, max11601,
   677		  max11602, max11603, max11604, max11605, max11606, max11607,
   678		  max11608, max11609, max11610, max11611, max11612, max11613,
   679		  max11614, max11615, max11616, max11617, max11644, max11645,
   680		  max11646, max11647) Provides direct access via sysfs and buffered
   681		  data via the iio dev interface.
   682	
   683		  To compile this driver as a module, choose M here: the module will be
   684		  called max1363.
   685	
   686	config MAX597X_IIO
   687		tristate "Maxim 597x power switch and monitor"
   688		depends on I2C
   689		depends on OF
   690		depends MFD_MAX597X
 > 691		help
   692		  This driver exposes Maxim 5970/5978 voltage/current monitoring
   693		  interface using iio framework.
   694	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
