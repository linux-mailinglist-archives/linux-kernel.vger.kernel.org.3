Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614BD492EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349072AbiARUEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:04:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:19432 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231417AbiARUEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642536249; x=1674072249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mFPND/Ud5ktDEhXhrONz1vQ8AVeVvRmT28NfeMdREgE=;
  b=nJDQ0p3B1duS68LP4VUjZ4U/RVAPnUI1BmNQjmgXyZpWObymyINBYErY
   Tm6zdfV7ut8aA/xVAqGHj+3T6Uh4vLaZn84ptpIr/vkUgu6Xwd+2bL/c0
   L/VzFZxtFnwMdJ01lr6b8yw/1vL71BOQcEeDcokrHjPlhcaa6W2HtBpX2
   mcIfEzO6Z/ZyYYk7VgGBK7qXWQ0oz0dO8OwzXKZdl8OBxHnXJalI4xvin
   zg3pT48XoQ23TMk4PCyx62hkv3o5j+0mQ52g37nvhI01SAlMnusHcfvR7
   vbtZVY3NpxL523lr2Ru+g8Y1HXvgSmIw3B266K1bxqBiQDPIoV0OXf7MA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269290117"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269290117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="474880500"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 12:04:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9ui6-000CuT-2t; Tue, 18 Jan 2022 20:04:06 +0000
Date:   Wed, 19 Jan 2022 04:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 36/78]
 drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_UART_RX'
 undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_RX'?
Message-ID: <202201190414.wOMX1rDG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   8da238492817fbbcbff77f105a752f98e7fb6df9
commit: 6381f39190c40848e9838f4f811ed464e0a45ddd [36/78] pinctrl: mstar: msc313 pinctrl driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201190414.wOMX1rDG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/6381f39190c40848e9838f4f811ed464e0a45ddd
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 6381f39190c40848e9838f4f811ed464e0a45ddd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the chenxing/msc313_mainlining HEAD 8da238492817fbbcbff77f105a752f98e7fb6df9 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/mstar/pinctrl-msc313-pm.c:8:
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_UART_RX' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_RX'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:58:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      58 |         MSC313_COMMON_PIN(PM_UART_RX),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_UART_TX' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_TX'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:59:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      59 |         MSC313_COMMON_PIN(PM_UART_TX),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_CZ' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_SPI_CZ'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:60:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      60 |         MSC313_COMMON_PIN(PM_SPI_CZ),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_DI' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_SPI_DI'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:61:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      61 |         MSC313_COMMON_PIN(PM_SPI_DI),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_WPZ' undeclared here (not in a function); did you mean 'PIN_SSD210_PM_SPI_WPZ'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:62:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      62 |         MSC313_COMMON_PIN(PM_SPI_WPZ),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_DO' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_SPI_DO'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:63:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      63 |         MSC313_COMMON_PIN(PM_SPI_DO),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_CK' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_SPI_CK'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:64:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      64 |         MSC313_COMMON_PIN(PM_SPI_CK),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_IRIN' undeclared here (not in a function); did you mean 'GROUPNAME_PM_IRIN'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:65:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      65 |         MSC313_COMMON_PIN(PM_IRIN),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SD_CDZ' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_SD_CDZ'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:66:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      66 |         MSC313_COMMON_PIN(PM_SD_CDZ),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_GPIO4' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:54:37: note: in expansion of macro 'COMMON_PIN'
      54 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:67:9: note: in expansion of macro 'MSC313_COMMON_PIN'
      67 |         MSC313_COMMON_PIN(PM_GPIO4),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_HLD' undeclared here (not in a function); did you mean 'PIN_SSD212_PM_SPI_HOLD'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:429:38: note: in expansion of macro 'COMMON_PIN'
     429 | #define SSD20XD_COMMON_PIN(_pinname) COMMON_PIN(SSD20XD, _pinname)
         |                                      ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:111:9: note: in expansion of macro 'SSD20XD_COMMON_PIN'
     111 |         SSD20XD_COMMON_PIN(PM_SPI_HLD),
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_LED0' undeclared here (not in a function); did you mean 'FUNCTIONNAME_PM_LED'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:429:38: note: in expansion of macro 'COMMON_PIN'
     429 | #define SSD20XD_COMMON_PIN(_pinname) COMMON_PIN(SSD20XD, _pinname)
         |                                      ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:113:9: note: in expansion of macro 'SSD20XD_COMMON_PIN'
     113 |         SSD20XD_COMMON_PIN(PM_LED0),
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_LED1' undeclared here (not in a function); did you mean 'FUNCTIONNAME_PM_LED'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:429:38: note: in expansion of macro 'COMMON_PIN'
     429 | #define SSD20XD_COMMON_PIN(_pinname) COMMON_PIN(SSD20XD, _pinname)
         |                                      ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:114:9: note: in expansion of macro 'SSD20XD_COMMON_PIN'
     114 |         SSD20XD_COMMON_PIN(PM_LED1),
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_SPI_HOLD' undeclared here (not in a function); did you mean 'PIN_SSD212_PM_SPI_HOLD'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:176:39: note: in expansion of macro 'COMMON_PIN'
     176 | #define SSC8336N_COMMON_PIN(_pinname) COMMON_PIN(SSC8336N, _pinname)
         |                                       ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:187:9: note: in expansion of macro 'SSC8336N_COMMON_PIN'
     187 |         SSC8336N_COMMON_PIN(PM_SPI_HOLD),
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_GPIO8' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:176:39: note: in expansion of macro 'COMMON_PIN'
     176 | #define SSC8336N_COMMON_PIN(_pinname) COMMON_PIN(SSC8336N, _pinname)
         |                                       ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:189:9: note: in expansion of macro 'SSC8336N_COMMON_PIN'
     189 |         SSC8336N_COMMON_PIN(PM_GPIO8),
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_GPIO6' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:176:39: note: in expansion of macro 'COMMON_PIN'
     176 | #define SSC8336N_COMMON_PIN(_pinname) COMMON_PIN(SSC8336N, _pinname)
         |                                       ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:190:9: note: in expansion of macro 'SSC8336N_COMMON_PIN'
     190 |         SSC8336N_COMMON_PIN(PM_GPIO6),
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_GPIO5' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:176:39: note: in expansion of macro 'COMMON_PIN'
     176 | #define SSC8336N_COMMON_PIN(_pinname) COMMON_PIN(SSC8336N, _pinname)
         |                                       ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:191:9: note: in expansion of macro 'SSC8336N_COMMON_PIN'
     191 |         SSC8336N_COMMON_PIN(PM_GPIO5),
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_GPIO2' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:176:39: note: in expansion of macro 'COMMON_PIN'
     176 | #define SSC8336N_COMMON_PIN(_pinname) COMMON_PIN(SSC8336N, _pinname)
         |                                       ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:193:9: note: in expansion of macro 'SSC8336N_COMMON_PIN'
     193 |         SSC8336N_COMMON_PIN(PM_GPIO2),
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_PM_GPIO0' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:176:39: note: in expansion of macro 'COMMON_PIN'
     176 | #define SSC8336N_COMMON_PIN(_pinname) COMMON_PIN(SSC8336N, _pinname)
         |                                       ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313-pm.c:194:9: note: in expansion of macro 'SSC8336N_COMMON_PIN'
     194 |         SSC8336N_COMMON_PIN(PM_GPIO0),
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/gpio/driver.h:11,
                    from drivers/pinctrl/mstar/pinctrl-msc313.c:7:
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_ETH_RN' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:260:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     260 |         MSC313_COMMON_PIN(ETH_RN),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_ETH_RN' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:260:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     260 |         MSC313_COMMON_PIN(ETH_RN),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_ETH_RP' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:261:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     261 |         MSC313_COMMON_PIN(ETH_RP),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_ETH_RP' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:261:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     261 |         MSC313_COMMON_PIN(ETH_RP),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_ETH_TN' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:262:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     262 |         MSC313_COMMON_PIN(ETH_TN),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_ETH_TN' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:262:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     262 |         MSC313_COMMON_PIN(ETH_TN),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_ETH_TP' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:263:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     263 |         MSC313_COMMON_PIN(ETH_TP),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_ETH_TP' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:263:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     263 |         MSC313_COMMON_PIN(ETH_TP),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_FUART_RX' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_RX'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:264:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     264 |         MSC313_COMMON_PIN(FUART_RX),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_FUART_RX' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:264:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     264 |         MSC313_COMMON_PIN(FUART_RX),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_FUART_TX' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_TX'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:265:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     265 |         MSC313_COMMON_PIN(FUART_TX),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_FUART_TX' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:265:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     265 |         MSC313_COMMON_PIN(FUART_TX),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_FUART_CTS' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_TX'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:266:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     266 |         MSC313_COMMON_PIN(FUART_CTS),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_FUART_CTS' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:266:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     266 |         MSC313_COMMON_PIN(FUART_CTS),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_FUART_RTS' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_UART_TX'?
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:267:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     267 |         MSC313_COMMON_PIN(FUART_RTS),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_FUART_RTS' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:267:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     267 |         MSC313_COMMON_PIN(FUART_RTS),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_I2C1_SCL' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:268:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     268 |         MSC313_COMMON_PIN(I2C1_SCL),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_I2C1_SCL' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:268:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     268 |         MSC313_COMMON_PIN(I2C1_SCL),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:21: error: 'PIN_MSC313_I2C1_SDA' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                     ^~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:269:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     269 |         MSC313_COMMON_PIN(I2C1_SDA),
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/mstar/pinctrl-mstar.h:414:48: error: 'PINNAME_I2C1_SDA' undeclared here (not in a function)
     414 |         PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
         |                                                ^~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:50: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                                  ^
   drivers/pinctrl/mstar/pinctrl-mstar.h:424:37: note: in expansion of macro 'COMMON_PIN'
     424 | #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
         |                                     ^~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:269:9: note: in expansion of macro 'MSC313_COMMON_PIN'
     269 |         MSC313_COMMON_PIN(I2C1_SDA),
         |         ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/mstar/pinctrl-msc313.c:270:21: error: 'PIN_MSC313_SR_IO2' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     270 |         PINCTRL_PIN(PIN_MSC313_SR_IO2,  "sr_io2"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:271:21: error: 'PIN_MSC313_SR_IO3' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     271 |         PINCTRL_PIN(PIN_MSC313_SR_IO3,  "sr_io3"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:272:21: error: 'PIN_MSC313_SR_IO4' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     272 |         PINCTRL_PIN(PIN_MSC313_SR_IO4,  "sr_io4"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:273:21: error: 'PIN_MSC313_SR_IO5' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     273 |         PINCTRL_PIN(PIN_MSC313_SR_IO5,  "sr_io5"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:274:21: error: 'PIN_MSC313_SR_IO6' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     274 |         PINCTRL_PIN(PIN_MSC313_SR_IO6,  "sr_io6"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:275:21: error: 'PIN_MSC313_SR_IO7' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     275 |         PINCTRL_PIN(PIN_MSC313_SR_IO7,  "sr_io7"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:276:21: error: 'PIN_MSC313_SR_IO8' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     276 |         PINCTRL_PIN(PIN_MSC313_SR_IO8,  "sr_io8"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:277:21: error: 'PIN_MSC313_SR_IO9' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     277 |         PINCTRL_PIN(PIN_MSC313_SR_IO9,  "sr_io9"),
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:278:21: error: 'PIN_MSC313_SR_IO10' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     278 |         PINCTRL_PIN(PIN_MSC313_SR_IO10, "sr_io10"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:279:21: error: 'PIN_MSC313_SR_IO11' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     279 |         PINCTRL_PIN(PIN_MSC313_SR_IO11, "sr_io11"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:280:21: error: 'PIN_MSC313_SR_IO12' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     280 |         PINCTRL_PIN(PIN_MSC313_SR_IO12, "sr_io12"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:281:21: error: 'PIN_MSC313_SR_IO13' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     281 |         PINCTRL_PIN(PIN_MSC313_SR_IO13, "sr_io13"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:282:21: error: 'PIN_MSC313_SR_IO14' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_GPIO4'?
     282 |         PINCTRL_PIN(PIN_MSC313_SR_IO14, "sr_io14"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:283:21: error: 'PIN_MSC313_SR_IO15' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     283 |         PINCTRL_PIN(PIN_MSC313_SR_IO15, "sr_io15"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }
         |                                       ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:284:21: error: 'PIN_MSC313_SR_IO16' undeclared here (not in a function); did you mean 'PIN_MSC313_PM_IRIN'?
     284 |         PINCTRL_PIN(PIN_MSC313_SR_IO16, "sr_io16"),
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:39: note: in definition of macro 'PINCTRL_PIN'
      43 | #define PINCTRL_PIN(a, b) { .number = a, .name = b }


vim +414 drivers/pinctrl/mstar/pinctrl-mstar.h

b4d3b8b1212c4d Daniel Palmer 2021-09-18  411  
b4d3b8b1212c4d Daniel Palmer 2021-09-18  412  /* Helpers for pins that have the same on the different chips */
b4d3b8b1212c4d Daniel Palmer 2021-09-18  413  #define COMMON_PIN(_model, _pinname) \
b4d3b8b1212c4d Daniel Palmer 2021-09-18 @414  	PINCTRL_PIN(PIN_##_model##_##_pinname, PINNAME_##_pinname)
b4d3b8b1212c4d Daniel Palmer 2021-09-18  415  
b4d3b8b1212c4d Daniel Palmer 2021-09-18  416  #define COMMON_FIXED_FUNCTION(_NAME, _name) \
b4d3b8b1212c4d Daniel Palmer 2021-09-18  417  	MSTAR_PINCTRL_FUNCTION(FUNCTIONNAME_##_NAME, -1, 0, _name##_groups, NULL)
b4d3b8b1212c4d Daniel Palmer 2021-09-18  418  #define COMMON_FUNCTION(_NAME, _name) \
b4d3b8b1212c4d Daniel Palmer 2021-09-18  419  	MSTAR_PINCTRL_FUNCTION(FUNCTIONNAME_##_NAME, REG_##_NAME, MASK_##_NAME, _name##_groups, _name##_values)
b4d3b8b1212c4d Daniel Palmer 2021-09-18  420  #define COMMON_FUNCTION_NULLVALUES(_NAME, _name) \
b4d3b8b1212c4d Daniel Palmer 2021-09-18  421  	MSTAR_PINCTRL_FUNCTION(FUNCTIONNAME_##_NAME, REG_##_NAME, MASK_##_NAME, _name##_groups, NULL)
b4d3b8b1212c4d Daniel Palmer 2021-09-18  422  
b4d3b8b1212c4d Daniel Palmer 2021-09-18  423  /* Helpers for msc313/msc313e pins and groups */
b4d3b8b1212c4d Daniel Palmer 2021-09-18 @424  #define MSC313_COMMON_PIN(_pinname) COMMON_PIN(MSC313, _pinname)
b4d3b8b1212c4d Daniel Palmer 2021-09-18  425  #define MSC313_PINCTRL_GROUP(_NAME, _name) \
b4d3b8b1212c4d Daniel Palmer 2021-09-18  426  	MSTAR_PINCTRL_GROUP(GROUPNAME_##_NAME, msc313_##_name##_pins)
b4d3b8b1212c4d Daniel Palmer 2021-09-18  427  

:::::: The code at line 414 was first introduced by commit
:::::: b4d3b8b1212c4d66caeb8836034568674450fa48 pinctrl: mstar: Add common code

:::::: TO: Daniel Palmer <daniel@0x0f.com>
:::::: CC: Daniel Palmer <daniel@0x0f.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
