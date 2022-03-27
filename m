Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834BD4E84C5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 01:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiC0AVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 20:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiC0AVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 20:21:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F343B60FF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648340383; x=1679876383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ec/uuBgKA4RuQbJjQgXdxfGMI7SA6TLPhBjhKXguaho=;
  b=OR47BQLTYoPLLpqluhRlRksnoYlcy+o1zK7F/8PpNoZtV8Olgi72IRrP
   WGT+qW5XhZNH8p1wVubhMOJI5t23hAiAGa3Pp0wpRgJi8Fv+H/aPK//5c
   1LhBppKBe/b81wExXBPjZhHwacQDtpE4Y95gyQcQ3iEB1APDyVa2fczMV
   iP2t/k1tGpf9X24VYq8FE5+tNtE+N9t1utljf24tyPRsk8nCH1znYqg0u
   yKBn1bVGCuIFLLjq5WvlyQqTfzSC/ghSov+ML8GKksRK3CJkw2eWjA8KO
   R+6ROK5Ruc1c357t2vMAhIGLLQoyWhA8EBplDqqqtNgd6cxh44WbTC9DB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="258779243"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="258779243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 17:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="516897899"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2022 17:19:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYGdB-0000YH-8Y; Sun, 27 Mar 2022 00:19:41 +0000
Date:   Sun, 27 Mar 2022 08:19:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next-2022-03-25 33/33]
 drivers/mfd/arizona-spi.c:241:48: error: 'arizona_spi_of_match' undeclared
 here (not in a function); did you mean 'arizona_spi_remove'?
Message-ID: <202203270844.GrL295JQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next-2022-03-25
head:   ac30f53240eb3296851f8d8d691ec36bfde92307
commit: ac30f53240eb3296851f8d8d691ec36bfde92307 [33/33] of.h: Improve of_match_node()
config: sh-randconfig-r016-20220327 (https://download.01.org/0day-ci/archive/20220327/202203270844.GrL295JQ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/ac30f53240eb3296851f8d8d691ec36bfde92307
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next-2022-03-25
        git checkout ac30f53240eb3296851f8d8d691ec36bfde92307
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/common/ssp_sensors/ drivers/iio/imu/bmi160/ drivers/mfd/ drivers/mtd/devices/ drivers/mtd/nand/raw/ drivers/mtd/nand/spi/ drivers/power/supply/ drivers/rtc/ drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/mfd/arizona-spi.c:10:
>> drivers/mfd/arizona-spi.c:241:48: error: 'arizona_spi_of_match' undeclared here (not in a function); did you mean 'arizona_spi_remove'?
     241 |                 .of_match_table = of_match_ptr(arizona_spi_of_match),
         |                                                ^~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/mfd/arizona-spi.c:241:35: note: in expansion of macro 'of_match_ptr'
     241 |                 .of_match_table = of_match_ptr(arizona_spi_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mfd/arizona-spi.c:241:35: note: in expansion of macro 'of_match_ptr'
     241 |                 .of_match_table = of_match_ptr(arizona_spi_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'arizona_spi_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mfd/arizona-spi.c:241:35: note: in expansion of macro 'of_match_ptr'
     241 |                 .of_match_table = of_match_ptr(arizona_spi_of_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from drivers/rtc/rtc-ds1302.c:14:
>> drivers/rtc/rtc-ds1302.c:209:47: error: 'ds1302_dt_ids' undeclared here (not in a function); did you mean 'ds1302_spi_ids'?
     209 |         .driver.of_match_table = of_match_ptr(ds1302_dt_ids),
         |                                               ^~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/rtc/rtc-ds1302.c:209:34: note: in expansion of macro 'of_match_ptr'
     209 |         .driver.of_match_table = of_match_ptr(ds1302_dt_ids),
         |                                  ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/rtc/rtc-ds1302.c:209:34: note: in expansion of macro 'of_match_ptr'
     209 |         .driver.of_match_table = of_match_ptr(ds1302_dt_ids),
         |                                  ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'ds1302_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/rtc/rtc-ds1302.c:209:34: note: in expansion of macro 'of_match_ptr'
     209 |         .driver.of_match_table = of_match_ptr(ds1302_dt_ids),
         |                                  ^~~~~~~~~~~~
--
   In file included from drivers/rtc/rtc-pcf2123.c:37:
>> drivers/rtc/rtc-pcf2123.c:465:56: error: 'pcf2123_dt_ids' undeclared here (not in a function); did you mean 'pcf2123_spi_ids'?
     465 |                         .of_match_table = of_match_ptr(pcf2123_dt_ids),
         |                                                        ^~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/rtc/rtc-pcf2123.c:465:43: note: in expansion of macro 'of_match_ptr'
     465 |                         .of_match_table = of_match_ptr(pcf2123_dt_ids),
         |                                           ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/rtc/rtc-pcf2123.c:465:43: note: in expansion of macro 'of_match_ptr'
     465 |                         .of_match_table = of_match_ptr(pcf2123_dt_ids),
         |                                           ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'pcf2123_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/rtc/rtc-pcf2123.c:465:43: note: in expansion of macro 'of_match_ptr'
     465 |                         .of_match_table = of_match_ptr(pcf2123_dt_ids),
         |                                           ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/spi/spi.h:19,
                    from include/linux/spi/altera.h:10,
                    from drivers/spi/spi-altera-platform.c:17:
>> drivers/spi/spi-altera-platform.c:163:48: error: 'altera_spi_match' undeclared here (not in a function); did you mean 'altera_spi_ids'?
     163 |                 .of_match_table = of_match_ptr(altera_spi_match),
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/spi/spi-altera-platform.c:163:35: note: in expansion of macro 'of_match_ptr'
     163 |                 .of_match_table = of_match_ptr(altera_spi_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/spi/spi-altera-platform.c:163:35: note: in expansion of macro 'of_match_ptr'
     163 |                 .of_match_table = of_match_ptr(altera_spi_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'altera_spi_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/spi/spi-altera-platform.c:163:35: note: in expansion of macro 'of_match_ptr'
     163 |                 .of_match_table = of_match_ptr(altera_spi_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from drivers/spi/spi-gpio.c:12:
>> drivers/spi/spi-gpio.c:456:48: error: 'spi_gpio_dt_ids' undeclared here (not in a function); did you mean 'spi_gpio_driver'?
     456 |                 .of_match_table = of_match_ptr(spi_gpio_dt_ids),
         |                                                ^~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/spi/spi-gpio.c:456:35: note: in expansion of macro 'of_match_ptr'
     456 |                 .of_match_table = of_match_ptr(spi_gpio_dt_ids),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/spi/spi-gpio.c:456:35: note: in expansion of macro 'of_match_ptr'
     456 |                 .of_match_table = of_match_ptr(spi_gpio_dt_ids),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'spi_gpio_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/spi/spi-gpio.c:456:35: note: in expansion of macro 'of_match_ptr'
     456 |                 .of_match_table = of_match_ptr(spi_gpio_dt_ids),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/spi/spi.h:19,
                    from drivers/spi/spi-oc-tiny.c:19:
>> drivers/spi/spi-oc-tiny.c:298:48: error: 'tiny_spi_match' undeclared here (not in a function); did you mean 'tiny_spi_setup'?
     298 |                 .of_match_table = of_match_ptr(tiny_spi_match),
         |                                                ^~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/spi/spi-oc-tiny.c:298:35: note: in expansion of macro 'of_match_ptr'
     298 |                 .of_match_table = of_match_ptr(tiny_spi_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/spi/spi-oc-tiny.c:298:35: note: in expansion of macro 'of_match_ptr'
     298 |                 .of_match_table = of_match_ptr(tiny_spi_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'tiny_spi_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/spi/spi-oc-tiny.c:298:35: note: in expansion of macro 'of_match_ptr'
     298 |                 .of_match_table = of_match_ptr(tiny_spi_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/power/supply/bq27xxx_battery_i2c.c:9:
>> drivers/power/supply/bq27xxx_battery_i2c.c:298:48: error: 'bq27xxx_battery_i2c_of_match_table' undeclared here (not in a function); did you mean 'bq27xxx_battery_i2c_remove'?
     298 |                 .of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/power/supply/bq27xxx_battery_i2c.c:298:35: note: in expansion of macro 'of_match_ptr'
     298 |                 .of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/power/supply/bq27xxx_battery_i2c.c:298:35: note: in expansion of macro 'of_match_ptr'
     298 |                 .of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'bq27xxx_battery_i2c_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/power/supply/bq27xxx_battery_i2c.c:298:35: note: in expansion of macro 'of_match_ptr'
     298 |                 .of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
         |                                   ^~~~~~~~~~~~
--
   In file included from drivers/mtd/devices/mtd_dataflash.c:15:
>> drivers/mtd/devices/mtd_dataflash.c:933:48: error: 'dataflash_dt_ids' undeclared here (not in a function); did you mean 'dataflash_dev_ids'?
     933 |                 .of_match_table = of_match_ptr(dataflash_dt_ids),
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/mtd/devices/mtd_dataflash.c:933:35: note: in expansion of macro 'of_match_ptr'
     933 |                 .of_match_table = of_match_ptr(dataflash_dt_ids),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mtd/devices/mtd_dataflash.c:933:35: note: in expansion of macro 'of_match_ptr'
     933 |                 .of_match_table = of_match_ptr(dataflash_dt_ids),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'dataflash_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mtd/devices/mtd_dataflash.c:933:35: note: in expansion of macro 'of_match_ptr'
     933 |                 .of_match_table = of_match_ptr(dataflash_dt_ids),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/mtd/mtd.h:14,
                    from drivers/mtd/nand/raw/ams-delta.c:21:
>> drivers/mtd/nand/raw/ams-delta.c:441:48: error: 'gpio_nand_of_id_table' undeclared here (not in a function); did you mean 'gpio_nand_plat_id_table'?
     441 |                 .of_match_table = of_match_ptr(gpio_nand_of_id_table),
         |                                                ^~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/mtd/nand/raw/ams-delta.c:441:35: note: in expansion of macro 'of_match_ptr'
     441 |                 .of_match_table = of_match_ptr(gpio_nand_of_id_table),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mtd/nand/raw/ams-delta.c:441:35: note: in expansion of macro 'of_match_ptr'
     441 |                 .of_match_table = of_match_ptr(gpio_nand_of_id_table),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'gpio_nand_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mtd/nand/raw/ams-delta.c:441:35: note: in expansion of macro 'of_match_ptr'
     441 |                 .of_match_table = of_match_ptr(gpio_nand_of_id_table),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/iio/iio.h:13,
                    from drivers/iio/common/ssp_sensors/ssp_dev.c:6:
>> drivers/iio/common/ssp_sensors/ssp_dev.c:673:48: error: 'ssp_of_match' undeclared here (not in a function)
     673 |                 .of_match_table = of_match_ptr(ssp_of_match),
         |                                                ^~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/iio/common/ssp_sensors/ssp_dev.c:673:35: note: in expansion of macro 'of_match_ptr'
     673 |                 .of_match_table = of_match_ptr(ssp_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/iio/common/ssp_sensors/ssp_dev.c:673:35: note: in expansion of macro 'of_match_ptr'
     673 |                 .of_match_table = of_match_ptr(ssp_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'ssp_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/iio/common/ssp_sensors/ssp_dev.c:673:35: note: in expansion of macro 'of_match_ptr'
     673 |                 .of_match_table = of_match_ptr(ssp_of_match),
         |                                   ^~~~~~~~~~~~
   drivers/iio/common/ssp_sensors/ssp_dev.c:44:40: warning: 'ssp_thermostat_info' defined but not used [-Wunused-const-variable=]
      44 | static const struct ssp_sensorhub_info ssp_thermostat_info = {
         |                                        ^~~~~~~~~~~~~~~~~~~
   drivers/iio/common/ssp_sensors/ssp_dev.c:36:40: warning: 'ssp_rinato_info' defined but not used [-Wunused-const-variable=]
      36 | static const struct ssp_sensorhub_info ssp_rinato_info = {
         |                                        ^~~~~~~~~~~~~~~
--
   In file included from include/linux/mtd/mtd.h:14,
                    from include/linux/mtd/spinand.h:14,
                    from drivers/mtd/nand/spi/core.c:16:
>> drivers/mtd/nand/spi/core.c:1351:56: error: 'spinand_of_ids' undeclared here (not in a function); did you mean 'spinand_ids'?
    1351 |                         .of_match_table = of_match_ptr(spinand_of_ids),
         |                                                        ^~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/mtd/nand/spi/core.c:1351:43: note: in expansion of macro 'of_match_ptr'
    1351 |                         .of_match_table = of_match_ptr(spinand_of_ids),
         |                                           ^~~~~~~~~~~~
   include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mtd/nand/spi/core.c:1351:43: note: in expansion of macro 'of_match_ptr'
    1351 |                         .of_match_table = of_match_ptr(spinand_of_ids),
         |                                           ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'spinand_drv.spidrv.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/mtd/nand/spi/core.c:1351:43: note: in expansion of macro 'of_match_ptr'
    1351 |                         .of_match_table = of_match_ptr(spinand_of_ids),
         |                                           ^~~~~~~~~~~~
..


vim +241 drivers/mfd/arizona-spi.c

3f65555c417c9c Charles Keepax 2021-09-28  236  
a15123c708a364 Mark Brown     2012-06-19  237  static struct spi_driver arizona_spi_driver = {
a15123c708a364 Mark Brown     2012-06-19  238  	.driver = {
a15123c708a364 Mark Brown     2012-06-19  239  		.name	= "arizona",
a15123c708a364 Mark Brown     2012-06-19  240  		.pm	= &arizona_pm_ops,
3f65555c417c9c Charles Keepax 2021-09-28 @241  		.of_match_table	= of_match_ptr(arizona_spi_of_match),
e933836744a260 Hans de Goede  2021-01-20  242  		.acpi_match_table = ACPI_PTR(arizona_acpi_match),
a15123c708a364 Mark Brown     2012-06-19  243  	},
a15123c708a364 Mark Brown     2012-06-19  244  	.probe		= arizona_spi_probe,
84449216b01f9c Bill Pemberton 2012-11-19  245  	.remove		= arizona_spi_remove,
a15123c708a364 Mark Brown     2012-06-19  246  	.id_table	= arizona_spi_ids,
a15123c708a364 Mark Brown     2012-06-19  247  };
a15123c708a364 Mark Brown     2012-06-19  248  

:::::: The code at line 241 was first introduced by commit
:::::: 3f65555c417c9c2eee235a137b5e5088a65439e4 mfd: arizona: Split of_match table into I2C and SPI versions

:::::: TO: Charles Keepax <ckeepax@opensource.cirrus.com>
:::::: CC: Lee Jones <lee.jones@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
