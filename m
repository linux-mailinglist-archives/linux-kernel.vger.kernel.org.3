Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576B4E84C0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 01:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiC0ALX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 20:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiC0ALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 20:11:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DE124BF8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648339783; x=1679875783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7i7Cb9JNb8xr9edzi3UdRW67oXUMO3NPdGxGaiibGKw=;
  b=al2r0mCmaT5KrcWwAjQ1/gvytuUbw/UPdWA6390dyDTorW+/tw7EJb6H
   OurCQVS5jZME50RYWfxt8hdbtlVIyrVYKl+9nRojp4V/1/aSHKmpRCobl
   Y0puN4w9MMg+brquwa8q0sEQ66IIvFXFRWo0fCWtKDjD5CB05W7RA4L/9
   EY7H3YaK75ZcZuAUjBZ38Ax+WPwGoy6AM+frd+BM1Qt7Lf9Rjly/CDQN/
   rB+xHGV0VgLUTzaOETWhtUuCH78oZ54xdPvT1cwDVW/5HW6NcHzwe4a5K
   K7pyY7IZg6GFg0cHc+2bsg5bOATAHP2XzLfg9j/lqSsn1Hfj21gGBcxfB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="256385743"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="256385743"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 17:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="584815875"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2022 17:09:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYGTV-0000Xx-64; Sun, 27 Mar 2022 00:09:41 +0000
Date:   Sun, 27 Mar 2022 08:08:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next-2022-03-25 33/33]
 include/linux/of.h:857:28: error: initializer element is not constant
Message-ID: <202203270815.J07XgGLC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: xtensa-randconfig-m031-20220327 (https://download.01.org/0day-ci/archive/20220327/202203270815.J07XgGLC-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/ac30f53240eb3296851f8d8d691ec36bfde92307
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next-2022-03-25
        git checkout ac30f53240eb3296851f8d8d691ec36bfde92307
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/char/tpm/ drivers/clk/ drivers/crypto/ drivers/dma/ drivers/gpio/ drivers/hwmon/ drivers/i2c/busses/ drivers/i2c/muxes/ drivers/iio/adc/ drivers/iio/imu/bmi160/ drivers/input/joystick/ drivers/input/misc/ drivers/input/serio/ drivers/input/touchscreen/ drivers/leds/ drivers/media/i2c/ drivers/mfd/ drivers/misc/lis3lv02d/ drivers/mtd/devices/ drivers/power/supply/ drivers/pwm/ drivers/uio/ drivers/video/backlight/ drivers/w1/masters/ sound/soc/codecs/ sound/soc/dwc/ sound/soc/xtensa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/clk-provider.h:9,
                    from drivers/clk/clk-cdce706.c:11:
>> drivers/clk/clk-cdce706.c:693:48: error: 'cdce706_dt_match' undeclared here (not in a function); did you mean 'cdce706_dev_data'?
     693 |                 .of_match_table = of_match_ptr(cdce706_dt_match),
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/clk/clk-cdce706.c:693:35: note: in expansion of macro 'of_match_ptr'
     693 |                 .of_match_table = of_match_ptr(cdce706_dt_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/clk/clk-cdce706.c:693:35: note: in expansion of macro 'of_match_ptr'
     693 |                 .of_match_table = of_match_ptr(cdce706_dt_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'cdce706_i2c_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/clk/clk-cdce706.c:693:35: note: in expansion of macro 'of_match_ptr'
     693 |                 .of_match_table = of_match_ptr(cdce706_dt_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/crypto/atmel-ecc.c:13:
>> drivers/crypto/atmel-ecc.c:385:48: error: 'atmel_ecc_dt_ids' undeclared here (not in a function); did you mean 'atmel_ecc_id'?
     385 |                 .of_match_table = of_match_ptr(atmel_ecc_dt_ids),
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/crypto/atmel-ecc.c:385:35: note: in expansion of macro 'of_match_ptr'
     385 |                 .of_match_table = of_match_ptr(atmel_ecc_dt_ids),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/crypto/atmel-ecc.c:385:35: note: in expansion of macro 'of_match_ptr'
     385 |                 .of_match_table = of_match_ptr(atmel_ecc_dt_ids),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'atmel_ecc_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/crypto/atmel-ecc.c:385:35: note: in expansion of macro 'of_match_ptr'
     385 |                 .of_match_table = of_match_ptr(atmel_ecc_dt_ids),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/of_dma.h:13,
                    from drivers/dma/altera-msgdma.c:22:
>> drivers/dma/altera-msgdma.c:954:48: error: 'msgdma_match' undeclared here (not in a function)
     954 |                 .of_match_table = of_match_ptr(msgdma_match),
         |                                                ^~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/dma/altera-msgdma.c:954:35: note: in expansion of macro 'of_match_ptr'
     954 |                 .of_match_table = of_match_ptr(msgdma_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/dma/altera-msgdma.c:954:35: note: in expansion of macro 'of_match_ptr'
     954 |                 .of_match_table = of_match_ptr(msgdma_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'msgdma_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/dma/altera-msgdma.c:954:35: note: in expansion of macro 'of_match_ptr'
     954 |                 .of_match_table = of_match_ptr(msgdma_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/gpio/driver.h:9,
                    from drivers/gpio/gpio-mmio.c:55:
>> drivers/gpio/gpio-mmio.c:810:48: error: 'bgpio_of_match' undeclared here (not in a function)
     810 |                 .of_match_table = of_match_ptr(bgpio_of_match),
         |                                                ^~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/gpio/gpio-mmio.c:810:35: note: in expansion of macro 'of_match_ptr'
     810 |                 .of_match_table = of_match_ptr(bgpio_of_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/gpio/gpio-mmio.c:810:35: note: in expansion of macro 'of_match_ptr'
     810 |                 .of_match_table = of_match_ptr(bgpio_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'bgpio_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/gpio/gpio-mmio.c:810:35: note: in expansion of macro 'of_match_ptr'
     810 |                 .of_match_table = of_match_ptr(bgpio_of_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/gpio/gpio-adp5588.c:13:
>> drivers/gpio/gpio-adp5588.c:460:48: error: 'adp5588_gpio_of_id' undeclared here (not in a function); did you mean 'adp5588_gpio_id'?
     460 |                 .of_match_table = of_match_ptr(adp5588_gpio_of_id),
         |                                                ^~~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/gpio/gpio-adp5588.c:460:35: note: in expansion of macro 'of_match_ptr'
     460 |                 .of_match_table = of_match_ptr(adp5588_gpio_of_id),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/gpio/gpio-adp5588.c:460:35: note: in expansion of macro 'of_match_ptr'
     460 |                 .of_match_table = of_match_ptr(adp5588_gpio_of_id),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'adp5588_gpio_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/gpio/gpio-adp5588.c:460:35: note: in expansion of macro 'of_match_ptr'
     460 |                 .of_match_table = of_match_ptr(adp5588_gpio_of_id),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/gpio/driver.h:9,
                    from drivers/gpio/gpio-max732x.c:17:
>> drivers/gpio/gpio-max732x.c:740:48: error: 'max732x_of_table' undeclared here (not in a function); did you mean 'max732x_probe'?
     740 |                 .of_match_table = of_match_ptr(max732x_of_table),
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/gpio/gpio-max732x.c:740:35: note: in expansion of macro 'of_match_ptr'
     740 |                 .of_match_table = of_match_ptr(max732x_of_table),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/gpio/gpio-max732x.c:740:35: note: in expansion of macro 'of_match_ptr'
     740 |                 .of_match_table = of_match_ptr(max732x_of_table),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'max732x_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/gpio/gpio-max732x.c:740:35: note: in expansion of macro 'of_match_ptr'
     740 |                 .of_match_table = of_match_ptr(max732x_of_table),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/char/tpm/tpm_tis_i2c_cr50.c:19:
>> drivers/char/tpm/tpm_tis_i2c_cr50.c:790:48: error: 'of_cr50_i2c_match' undeclared here (not in a function)
     790 |                 .of_match_table = of_match_ptr(of_cr50_i2c_match),
         |                                                ^~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/char/tpm/tpm_tis_i2c_cr50.c:790:35: note: in expansion of macro 'of_match_ptr'
     790 |                 .of_match_table = of_match_ptr(of_cr50_i2c_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/char/tpm/tpm_tis_i2c_cr50.c:790:35: note: in expansion of macro 'of_match_ptr'
     790 |                 .of_match_table = of_match_ptr(of_cr50_i2c_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'cr50_i2c_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/char/tpm/tpm_tis_i2c_cr50.c:790:35: note: in expansion of macro 'of_match_ptr'
     790 |                 .of_match_table = of_match_ptr(of_cr50_i2c_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/char/tpm/tpm_i2c_atmel.c:22:
>> drivers/char/tpm/tpm_i2c_atmel.c:213:48: error: 'i2c_atmel_of_match' undeclared here (not in a function)
     213 |                 .of_match_table = of_match_ptr(i2c_atmel_of_match),
         |                                                ^~~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/char/tpm/tpm_i2c_atmel.c:213:35: note: in expansion of macro 'of_match_ptr'
     213 |                 .of_match_table = of_match_ptr(i2c_atmel_of_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/char/tpm/tpm_i2c_atmel.c:213:35: note: in expansion of macro 'of_match_ptr'
     213 |                 .of_match_table = of_match_ptr(i2c_atmel_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'i2c_atmel_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/char/tpm/tpm_i2c_atmel.c:213:35: note: in expansion of macro 'of_match_ptr'
     213 |                 .of_match_table = of_match_ptr(i2c_atmel_of_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/char/tpm/tpm_i2c_infineon.c:18:
>> drivers/char/tpm/tpm_i2c_infineon.c:727:51: error: 'tpm_tis_i2c_of_match' undeclared here (not in a function); did you mean 'tpm_tis_i2c_status'?
     727 |                    .of_match_table = of_match_ptr(tpm_tis_i2c_of_match),
         |                                                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:857:30: note: in definition of macro 'of_match_ptr'
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                              ^~~~
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/char/tpm/tpm_i2c_infineon.c:727:38: note: in expansion of macro 'of_match_ptr'
     727 |                    .of_match_table = of_match_ptr(tpm_tis_i2c_of_match),
         |                                      ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/char/tpm/tpm_i2c_infineon.c:727:38: note: in expansion of macro 'of_match_ptr'
     727 |                    .of_match_table = of_match_ptr(tpm_tis_i2c_of_match),
         |                                      ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'tpm_tis_i2c_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/char/tpm/tpm_i2c_infineon.c:727:38: note: in expansion of macro 'of_match_ptr'
     727 |                    .of_match_table = of_match_ptr(tpm_tis_i2c_of_match),
         |                                      ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/hwmon/ad7414.c:20:
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/hwmon/ad7414.c:222:35: note: in expansion of macro 'of_match_ptr'
     222 |                 .of_match_table = of_match_ptr(ad7414_of_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/hwmon/ad7414.c:222:35: note: in expansion of macro 'of_match_ptr'
     222 |                 .of_match_table = of_match_ptr(ad7414_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'ad7414_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/hwmon/ad7414.c:222:35: note: in expansion of macro 'of_match_ptr'
     222 |                 .of_match_table = of_match_ptr(ad7414_of_match),
         |                                   ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/hwmon/adc128d818.c:15:
   include/linux/of.h:857:35: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                                   ^
   drivers/hwmon/adc128d818.c:524:35: note: in expansion of macro 'of_match_ptr'
     524 |                 .of_match_table = of_match_ptr(adc128_of_match),
         |                                   ^~~~~~~~~~~~
>> include/linux/of.h:857:28: error: initializer element is not constant
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/hwmon/adc128d818.c:524:35: note: in expansion of macro 'of_match_ptr'
     524 |                 .of_match_table = of_match_ptr(adc128_of_match),
         |                                   ^~~~~~~~~~~~
   include/linux/of.h:857:28: note: (near initialization for 'adc128_driver.driver.of_match_table')
     857 | #define of_match_ptr(_ptr) ((_ptr), NULL)
         |                            ^
   drivers/hwmon/adc128d818.c:524:35: note: in expansion of macro 'of_match_ptr'
     524 |                 .of_match_table = of_match_ptr(adc128_of_match),
         |                                   ^~~~~~~~~~~~
..


vim +857 include/linux/of.h

   856	
 > 857	#define of_match_ptr(_ptr) ((_ptr), NULL)
   858	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
