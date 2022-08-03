Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC77058942A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiHCVxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCVx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:53:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214A5A3DA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659563606; x=1691099606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aZ7UOqMV84gfGoalB23TIJzDlQd7RRqx+JZwAIw2Hug=;
  b=bX22gPaujjI1qLhjHHpLrD8vn0+vXCziNjFVY6PkbtJ4b6kUfa2pDBf+
   WmGUoFv5gwXdQukD0wXcSyO1dd7DdUZzfvaPx/ks9UUrYkfT7WJf7IIL9
   ycqIkjr6onIwdoW3UTvGSZT9Hb+nG6kevWOOdGrQHy1XP/IYVgO5YJduc
   gw+zZyxnYTVfJ3infFImz/Gf0g/Kl4l0tvmtCEyRk/lI54QNvFeHfIEVS
   EO8kvnxo6mvJaapEzkbQ87MRfldsH7eF4teDZkenVzvKJgKx3TctUfipX
   Vfz8tOTY7eegcIipzUsO9Q8H8mo26Fr/d1QCbrXjaR2NYsBxsqFFWR4s7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="376085692"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="376085692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631313621"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 14:53:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJMIu-000Hh5-0k;
        Wed, 03 Aug 2022 21:53:24 +0000
Date:   Thu, 4 Aug 2022 05:52:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51] drivers/tty/serial/8250/8250.h:17:1: warning:
 empty declaration
Message-ID: <202208040543.kBYZS3BO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   2e73962c8797ccdf52841ea3065779839ac60e0e
commit: cbd9dc8cc7a7ad1790670c6652520fa866a9c72d [26/51] tty: serial_mctrl_gpio: add wakeup support for serial control gpios
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220804/202208040543.kBYZS3BO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout cbd9dc8cc7a7ad1790670c6652520fa866a9c72d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/serial/8250/8250.h:15,
                    from drivers/tty/serial/8250/8250_core.c:43:
   drivers/tty/serial/8250/../serial_mctrl_gpio.h:166:1: error: version control conflict marker in file
     166 | <<<<<<< HEAD
         | ^~~~~~~
   drivers/tty/serial/8250/../serial_mctrl_gpio.h: In function 'mctrl_gpio_disable_irq_wake':
   drivers/tty/serial/8250/../serial_mctrl_gpio.h:172:1: error: version control conflict marker in file
     172 | =======
         | ^~~~~~~
   drivers/tty/serial/8250/../serial_mctrl_gpio.h:181:1: error: version control conflict marker in file
     181 | >>>>>>> eef01d4b6b91 (tty: serial_mctrl_gpio: add wakeup support for serial control gpios)
         | ^~~~~~~
   In file included from drivers/tty/serial/8250/8250_core.c:43:
>> drivers/tty/serial/8250/8250.h:17:1: warning: empty declaration
      17 | struct uart_8250_dma {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:56:1: warning: empty declaration
      56 | struct old_serial_port {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:67:1: warning: empty declaration
      67 | struct serial8250_config {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:117:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     117 | {
         | ^
   drivers/tty/serial/8250/8250.h:122:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     122 | {
         | ^
   drivers/tty/serial/8250/8250.h:130:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     130 | {
         | ^
   drivers/tty/serial/8250/8250.h:137:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     137 | {
         | ^
   drivers/tty/serial/8250/8250.h:151:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     151 | {
         | ^
   drivers/tty/serial/8250/8250.h:156:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     156 | {
         | ^
   drivers/tty/serial/8250/8250.h:161:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     161 | {
         | ^
   drivers/tty/serial/8250/8250.h:170:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     170 | {
         | ^
   drivers/tty/serial/8250/8250.h:193:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     193 | {
         | ^
   drivers/tty/serial/8250/8250.h:211:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     211 | {
         | ^
   drivers/tty/serial/8250/8250.h:230:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     230 | {
         | ^
   drivers/tty/serial/8250/8250.h:246:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     246 | {
         | ^
   drivers/tty/serial/8250/8250.h:254:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     254 | {
         | ^
   drivers/tty/serial/8250/8250.h:283:66: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     283 | static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
         |                                                                  ^
   drivers/tty/serial/8250/8250.h:315:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     315 | {
         | ^
   drivers/tty/serial/8250/8250.h:319:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     319 | {
         | ^
   drivers/tty/serial/8250/8250.h:325:12: error: storage class specified for parameter 'serial8250_tx_dma'
     325 | extern int serial8250_tx_dma(struct uart_8250_port *);
         |            ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250.h:326:12: error: storage class specified for parameter 'serial8250_rx_dma'
     326 | extern int serial8250_rx_dma(struct uart_8250_port *);
         |            ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250.h:327:13: error: storage class specified for parameter 'serial8250_rx_dma_flush'
     327 | extern void serial8250_rx_dma_flush(struct uart_8250_port *);
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250.h:328:12: error: storage class specified for parameter 'serial8250_request_dma'
     328 | extern int serial8250_request_dma(struct uart_8250_port *);
         |            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250.h:329:13: error: storage class specified for parameter 'serial8250_release_dma'
     329 | extern void serial8250_release_dma(struct uart_8250_port *);
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250.h:332:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     332 | {
         | ^
   drivers/tty/serial/8250/8250.h:340:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     340 | {
         | ^
   drivers/tty/serial/8250/8250.h:364:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     364 | {
         | ^
   drivers/tty/serial/8250/8250.h:381:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     381 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:50:21: error: storage class specified for parameter 'share_irqs'
      50 | static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
         |                     ^~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:50:1: error: parameter 'share_irqs' is initialized
      50 | static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
         | ^~~~~~
   drivers/tty/serial/8250/8250_core.c:52:21: error: storage class specified for parameter 'nr_uarts'
      52 | static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
         |                     ^~~~~~~~
   drivers/tty/serial/8250/8250_core.c:52:1: error: parameter 'nr_uarts' is initialized
      52 | static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
         | ^~~~~~
   drivers/tty/serial/8250/8250_core.c:54:27: error: storage class specified for parameter 'serial8250_reg'
      54 | static struct uart_driver serial8250_reg;
         |                           ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:56:21: error: storage class specified for parameter 'skip_txen_test'
      56 | static unsigned int skip_txen_test; /* force skip of txen test at init time */
         |                     ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:70:37: error: storage class specified for parameter 'old_serial_port'
      70 | static const struct old_serial_port old_serial_port[] = {
         |                                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:70:21: error: parameter 'old_serial_port' is initialized
      70 | static const struct old_serial_port old_serial_port[] = {
         |                     ^~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: (near initialization for 'old_serial_port')
   In file included from drivers/tty/serial/8250/8250_core.c:60:
   arch/x86/include/asm/serial.h:25:11: error: field name not in record or union initializer
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:25:11: note: (near initialization for 'old_serial_port')
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:25:25: note: in expansion of macro 'BASE_BAUD'
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:12:19: note: (near initialization for 'old_serial_port')
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:25:25: note: in expansion of macro 'BASE_BAUD'
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:25:41: warning: excess elements in scalar initializer
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:25:41: note: (near initialization for 'old_serial_port')
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:25:49: warning: excess elements in scalar initializer
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:25:49: note: (near initialization for 'old_serial_port')
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:16:25: warning: excess elements in scalar initializer
      16 | # define STD_COMX_FLAGS (UPF_BOOT_AUTOCONF |    UPF_SKIP_TEST   | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:25:57: note: in expansion of macro 'STD_COMX_FLAGS'
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:16:25: note: (near initialization for 'old_serial_port')
      16 | # define STD_COMX_FLAGS (UPF_BOOT_AUTOCONF |    UPF_SKIP_TEST   | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:25:57: note: in expansion of macro 'STD_COMX_FLAGS'
      25 |         { .uart = 0,    BASE_BAUD,      0x3F8,  4,      STD_COMX_FLAGS  }, /* ttyS0 */  \
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
   drivers/tty/serial/8250/8250_core.c:71:9: note: (near initialization for 'old_serial_port')
   In file included from drivers/tty/serial/8250/8250_core.c:60:
   arch/x86/include/asm/serial.h:26:11: error: field name not in record or union initializer
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:11: note: (near initialization for 'old_serial_port')
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:26:25: note: in expansion of macro 'BASE_BAUD'
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:12:19: note: (near initialization for 'old_serial_port')
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:26:25: note: in expansion of macro 'BASE_BAUD'
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:41: warning: excess elements in scalar initializer
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:41: note: (near initialization for 'old_serial_port')
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:49: warning: excess elements in scalar initializer
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:49: note: (near initialization for 'old_serial_port')
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:16:25: warning: excess elements in scalar initializer
      16 | # define STD_COMX_FLAGS (UPF_BOOT_AUTOCONF |    UPF_SKIP_TEST   | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:26:57: note: in expansion of macro 'STD_COMX_FLAGS'
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:16:25: note: (near initialization for 'old_serial_port')
      16 | # define STD_COMX_FLAGS (UPF_BOOT_AUTOCONF |    UPF_SKIP_TEST   | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:26:57: note: in expansion of macro 'STD_COMX_FLAGS'
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:9: warning: excess elements in scalar initializer
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |         ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:26:9: note: (near initialization for 'old_serial_port')
      26 |         { .uart = 0,    BASE_BAUD,      0x2F8,  3,      STD_COMX_FLAGS  }, /* ttyS1 */  \
         |         ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
   drivers/tty/serial/8250/8250_core.c:71:9: note: (near initialization for 'old_serial_port')
   In file included from drivers/tty/serial/8250/8250_core.c:60:
   arch/x86/include/asm/serial.h:27:11: error: field name not in record or union initializer
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:11: note: (near initialization for 'old_serial_port')
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:27:25: note: in expansion of macro 'BASE_BAUD'
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:12:19: note: (near initialization for 'old_serial_port')
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:27:25: note: in expansion of macro 'BASE_BAUD'
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:41: warning: excess elements in scalar initializer
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:41: note: (near initialization for 'old_serial_port')
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:49: warning: excess elements in scalar initializer
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:49: note: (near initialization for 'old_serial_port')
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:16:25: warning: excess elements in scalar initializer
      16 | # define STD_COMX_FLAGS (UPF_BOOT_AUTOCONF |    UPF_SKIP_TEST   | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:27:57: note: in expansion of macro 'STD_COMX_FLAGS'
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:16:25: note: (near initialization for 'old_serial_port')
      16 | # define STD_COMX_FLAGS (UPF_BOOT_AUTOCONF |    UPF_SKIP_TEST   | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:27:57: note: in expansion of macro 'STD_COMX_FLAGS'
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:9: warning: excess elements in scalar initializer
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |         ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:27:9: note: (near initialization for 'old_serial_port')
      27 |         { .uart = 0,    BASE_BAUD,      0x3E8,  4,      STD_COMX_FLAGS  }, /* ttyS2 */  \
         |         ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
   drivers/tty/serial/8250/8250_core.c:71:9: note: (near initialization for 'old_serial_port')
   In file included from drivers/tty/serial/8250/8250_core.c:60:
   arch/x86/include/asm/serial.h:28:11: error: field name not in record or union initializer
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:11: note: (near initialization for 'old_serial_port')
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |           ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
>> arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:28:25: note: in expansion of macro 'BASE_BAUD'
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:12:19: note: (near initialization for 'old_serial_port')
      12 | #define BASE_BAUD (1843200/16)
         |                   ^
   arch/x86/include/asm/serial.h:28:25: note: in expansion of macro 'BASE_BAUD'
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                         ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:41: warning: excess elements in scalar initializer
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:41: note: (near initialization for 'old_serial_port')
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                                         ^~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:49: warning: excess elements in scalar initializer
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:49: note: (near initialization for 'old_serial_port')
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                                                 ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:17:25: warning: excess elements in scalar initializer
      17 | # define STD_COM4_FLAGS (UPF_BOOT_AUTOCONF |    0               | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:28:57: note: in expansion of macro 'STD_COM4_FLAGS'
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:17:25: note: (near initialization for 'old_serial_port')
      17 | # define STD_COM4_FLAGS (UPF_BOOT_AUTOCONF |    0               | UPF_AUTO_IRQ)
         |                         ^
   arch/x86/include/asm/serial.h:28:57: note: in expansion of macro 'STD_COM4_FLAGS'
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |                                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:9: warning: excess elements in scalar initializer
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |         ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/serial.h:28:9: note: (near initialization for 'old_serial_port')
      28 |         { .uart = 0,    BASE_BAUD,      0x2E8,  3,      STD_COM4_FLAGS  }, /* ttyS3 */
         |         ^
   drivers/tty/serial/8250/8250_core.c:71:9: note: in expansion of macro 'SERIAL_PORT_DFNS'
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:79:22: error: storage class specified for parameter 'probe_rsa'
      79 | static unsigned long probe_rsa[PORT_RSA_MAX];
         |                      ^~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:80:21: error: storage class specified for parameter 'probe_rsa_count'
      80 | static unsigned int probe_rsa_count;
         |                     ^~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:83:1: warning: empty declaration
      83 | struct irq_info {
         | ^~~~~~
   drivers/tty/serial/8250/8250_core.c:91:26: error: storage class specified for parameter 'irq_lists'
      91 | static struct hlist_head irq_lists[NR_IRQ_HASH];
         |                          ^~~~~~~~~
   In file included from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
   drivers/tty/serial/8250/8250_core.c:92:21: error: storage class specified for parameter 'hash_mutex'
      92 | static DEFINE_MUTEX(hash_mutex);        /* Used to walk the hash */
         |                     ^~~~~~~~~~
   include/linux/mutex.h:116:22: note: in definition of macro 'DEFINE_MUTEX'
     116 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~
   include/linux/mutex.h:116:16: error: parameter 'hash_mutex' is initialized
     116 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                ^~~~~
   drivers/tty/serial/8250/8250_core.c:92:8: note: in expansion of macro 'DEFINE_MUTEX'
      92 | static DEFINE_MUTEX(hash_mutex);        /* Used to walk the hash */
         |        ^~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:109:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     109 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:153:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     153 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:173:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     173 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:219:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     219 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:248:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     248 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:256:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     256 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:303:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     303 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:333:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     333 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:344:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     344 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:365:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     365 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:379:31: error: storage class specified for parameter 'base_ops'
     379 | static const struct uart_ops *base_ops;
         |                               ^~~~~~~~
   drivers/tty/serial/8250/8250_core.c:380:24: error: storage class specified for parameter 'univ8250_port_ops'
     380 | static struct uart_ops univ8250_port_ops;
         |                        ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:382:35: error: storage class specified for parameter 'univ8250_driver_ops'
     382 | static const struct uart_8250_ops univ8250_driver_ops = {
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:382:21: error: parameter 'univ8250_driver_ops' is initialized
     382 | static const struct uart_8250_ops univ8250_driver_ops = {
         |                     ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:383:27: error: 'univ8250_setup_irq' undeclared (first use in this function)
     383 |         .setup_irq      = univ8250_setup_irq,
         |                           ^~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:383:27: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/8250/8250_core.c:384:27: error: 'univ8250_release_irq' undeclared (first use in this function); did you mean 'serial8250_release_dma'?
     384 |         .release_irq    = univ8250_release_irq,
         |                           ^~~~~~~~~~~~~~~~~~~~
         |                           serial8250_release_dma
   drivers/tty/serial/8250/8250_core.c:387:30: error: storage class specified for parameter 'serial8250_ports'
     387 | static struct uart_8250_port serial8250_ports[UART_NR];
         |                              ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:402:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     402 | {
         | ^
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
   drivers/tty/serial/8250/8250_core.c:405:19: error: storage class specified for parameter 'serial8250_get_port'
     405 | EXPORT_SYMBOL_GPL(serial8250_get_port);
         |                   ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:87:28: note: in definition of macro '___EXPORT_SYMBOL'
      87 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
     147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
..


vim +17 drivers/tty/serial/8250/8250.h

4a96895f74c963 drivers/tty/serial/8250/8250.h Yegor Yefremov            2019-06-20  16  
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10 @17  struct uart_8250_dma {
f1a297bb044265 drivers/tty/serial/8250/8250.h Sebastian Andrzej Siewior 2014-09-29  18  	int (*tx_dma)(struct uart_8250_port *p);
33d9b8b23a73d5 drivers/tty/serial/8250/8250.h Peter Hurley              2016-04-09  19  	int (*rx_dma)(struct uart_8250_port *p);
e4fb03fe10c5e7 drivers/tty/serial/8250/8250.h Miquel Raynal             2022-04-22  20  	void (*prepare_tx_dma)(struct uart_8250_port *p);
e4fb03fe10c5e7 drivers/tty/serial/8250/8250.h Miquel Raynal             2022-04-22  21  	void (*prepare_rx_dma)(struct uart_8250_port *p);
f1a297bb044265 drivers/tty/serial/8250/8250.h Sebastian Andrzej Siewior 2014-09-29  22  
9a1870ce812e13 drivers/tty/serial/8250/8250.h Andy Shevchenko           2014-08-19  23  	/* Filter function */
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  24  	dma_filter_fn		fn;
9a1870ce812e13 drivers/tty/serial/8250/8250.h Andy Shevchenko           2014-08-19  25  	/* Parameter to the filter function */
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  26  	void			*rx_param;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  27  	void			*tx_param;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  28  
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  29  	struct dma_slave_config	rxconf;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  30  	struct dma_slave_config	txconf;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  31  
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  32  	struct dma_chan		*rxchan;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  33  	struct dma_chan		*txchan;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  34  
d1834babe42246 drivers/tty/serial/8250/8250.h Andy Shevchenko           2016-08-17  35  	/* Device address base for DMA operations */
d1834babe42246 drivers/tty/serial/8250/8250.h Andy Shevchenko           2016-08-17  36  	phys_addr_t		rx_dma_addr;
d1834babe42246 drivers/tty/serial/8250/8250.h Andy Shevchenko           2016-08-17  37  	phys_addr_t		tx_dma_addr;
d1834babe42246 drivers/tty/serial/8250/8250.h Andy Shevchenko           2016-08-17  38  
d1834babe42246 drivers/tty/serial/8250/8250.h Andy Shevchenko           2016-08-17  39  	/* DMA address of the buffer in memory */
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  40  	dma_addr_t		rx_addr;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  41  	dma_addr_t		tx_addr;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  42  
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  43  	dma_cookie_t		rx_cookie;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  44  	dma_cookie_t		tx_cookie;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  45  
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  46  	void			*rx_buf;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  47  
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  48  	size_t			rx_size;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  49  	size_t			tx_size;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  50  
eafb9eea7622d7 drivers/tty/serial/8250/8250.h John Ogness               2015-08-14  51  	unsigned char		tx_running;
eafb9eea7622d7 drivers/tty/serial/8250/8250.h John Ogness               2015-08-14  52  	unsigned char		tx_err;
eafb9eea7622d7 drivers/tty/serial/8250/8250.h John Ogness               2015-08-14  53  	unsigned char		rx_running;
9ee4b83e51f741 drivers/tty/serial/8250/8250.h Heikki Krogerus           2013-01-10  54  };
^1da177e4c3f41 drivers/serial/8250.h          Linus Torvalds            2005-04-16  55  

:::::: The code at line 17 was first introduced by commit
:::::: 9ee4b83e51f741a645c43e61b9f3f8075ca0fdf4 serial: 8250: Add support for dmaengine

:::::: TO: Heikki Krogerus <heikki.krogerus@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
