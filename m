Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B345535D40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350260AbiE0JMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiE0JLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:11:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E10131F0C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653642478; x=1685178478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ck2VafFByK5EXWfhoLI8RD1NG0A5u4hzqkR51FAnD7k=;
  b=fDusdJwOQRlLaJgtythHuxiAKaNggwK5KgKvkMXFPh1gNOn2ugJaVZ1c
   qWa0ZnAE5J2WqwCzBdUYp9oJVjSQq8LX8rakMiWueT/j/5byttkmNa+gm
   hFI8qcNaoDeUctNEGc7L9bKz/eamrXJz5kgrRGEurKDUsMxL5mQQgmIkY
   pQ5oASY7GHRqJ3sHhhYESInVOQCixkwqwpfes0rvE+ruDNWBcbqkedZYS
   8Ca92w0MuiQ/UkRHLF8AbOUrzPKsu0Gh2OnXpDxpz/oG1lKdqexsg/gTy
   fgcW56f6id2wEBTuS5N82uaKg+MyyEM7cSVLvant3HISdO2xBd5L4aBkx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="273240459"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="273240459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="527978523"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2022 02:07:23 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuVwI-0004bc-CK;
        Fri, 27 May 2022 09:07:22 +0000
Date:   Fri, 27 May 2022 17:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51]
 drivers/tty/serial/8250/../serial_mctrl_gpio.h:166:1: error: version control
 conflict marker in file
Message-ID: <202205271630.xoFIVrUg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   84a43257f88e48b2a64c10e09d131ef1d3a74df0
commit: e27a96b5c1792e44763eedb238dab57df37bd6e2 [26/51] tty: serial_mctrl_gpio: add wakeup support for serial control gpios
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220527/202205271630.xoFIVrUg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout e27a96b5c1792e44763eedb238dab57df37bd6e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/8250/8250.h:15,
                    from drivers/tty/serial/8250/8250_core.c:43:
>> drivers/tty/serial/8250/../serial_mctrl_gpio.h:166:1: error: version control conflict marker in file
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
   drivers/tty/serial/8250/8250.h:17:1: warning: empty declaration
      17 | struct uart_8250_dma {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:54:1: warning: empty declaration
      54 | struct old_serial_port {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:65:1: warning: empty declaration
      65 | struct serial8250_config {
         | ^~~~~~
>> drivers/tty/serial/8250/8250.h:114:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     114 | {
         | ^
   drivers/tty/serial/8250/8250.h:119:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     119 | {
         | ^
   drivers/tty/serial/8250/8250.h:126:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     126 | {
         | ^
   drivers/tty/serial/8250/8250.h:131:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     131 | {
         | ^
   drivers/tty/serial/8250/8250.h:136:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     136 | {
         | ^
   drivers/tty/serial/8250/8250.h:145:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     145 | {
         | ^
   drivers/tty/serial/8250/8250.h:168:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     168 | {
         | ^
   drivers/tty/serial/8250/8250.h:186:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     186 | {
         | ^
   drivers/tty/serial/8250/8250.h:205:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     205 | {
         | ^
   drivers/tty/serial/8250/8250.h:221:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     221 | {
         | ^
   drivers/tty/serial/8250/8250.h:229:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     229 | {
         | ^
   drivers/tty/serial/8250/8250.h:258:66: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     258 | static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
         |                                                                  ^
   drivers/tty/serial/8250/8250.h:289:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     289 | {
         | ^
   drivers/tty/serial/8250/8250.h:293:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     293 | {
         | ^
>> drivers/tty/serial/8250/8250.h:299:12: error: storage class specified for parameter 'serial8250_tx_dma'
     299 | extern int serial8250_tx_dma(struct uart_8250_port *);
         |            ^~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250.h:300:12: error: storage class specified for parameter 'serial8250_rx_dma'
     300 | extern int serial8250_rx_dma(struct uart_8250_port *);
         |            ^~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250.h:301:13: error: storage class specified for parameter 'serial8250_rx_dma_flush'
     301 | extern void serial8250_rx_dma_flush(struct uart_8250_port *);
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250.h:302:12: error: storage class specified for parameter 'serial8250_request_dma'
     302 | extern int serial8250_request_dma(struct uart_8250_port *);
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250.h:303:13: error: storage class specified for parameter 'serial8250_release_dma'
     303 | extern void serial8250_release_dma(struct uart_8250_port *);
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250.h:322:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     322 | {
         | ^
   drivers/tty/serial/8250/8250.h:339:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     339 | {
         | ^
>> drivers/tty/serial/8250/8250_core.c:50:21: error: storage class specified for parameter 'share_irqs'
      50 | static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
         |                     ^~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:50:1: error: parameter 'share_irqs' is initialized
      50 | static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
         | ^~~~~~
>> drivers/tty/serial/8250/8250_core.c:52:21: error: storage class specified for parameter 'nr_uarts'
      52 | static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
         |                     ^~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:52:1: error: parameter 'nr_uarts' is initialized
      52 | static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
         | ^~~~~~
>> drivers/tty/serial/8250/8250_core.c:54:27: error: storage class specified for parameter 'serial8250_reg'
      54 | static struct uart_driver serial8250_reg;
         |                           ^~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:56:21: error: storage class specified for parameter 'skip_txen_test'
      56 | static unsigned int skip_txen_test; /* force skip of txen test at init time */
         |                     ^~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:70:37: error: storage class specified for parameter 'old_serial_port'
      70 | static const struct old_serial_port old_serial_port[] = {
         |                                     ^~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:70:21: error: parameter 'old_serial_port' is initialized
      70 | static const struct old_serial_port old_serial_port[] = {
         |                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
      71 |         SERIAL_PORT_DFNS /* defined in asm/serial.h */
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:71:9: note: (near initialization for 'old_serial_port')
   In file included from drivers/tty/serial/8250/8250_core.c:60:
>> arch/x86/include/asm/serial.h:25:11: error: field name not in record or union initializer
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
   arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
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
   drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
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
   arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
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
--
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
   drivers/tty/serial/8250/8250_core.c:71:9: warning: braces around scalar initializer
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
   arch/x86/include/asm/serial.h:12:19: warning: excess elements in scalar initializer
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
>> drivers/tty/serial/8250/8250_core.c:79:22: error: storage class specified for parameter 'probe_rsa'
      79 | static unsigned long probe_rsa[PORT_RSA_MAX];
         |                      ^~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:80:21: error: storage class specified for parameter 'probe_rsa_count'
      80 | static unsigned int probe_rsa_count;
         |                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:83:1: warning: empty declaration
      83 | struct irq_info {
         | ^~~~~~
>> drivers/tty/serial/8250/8250_core.c:91:26: error: storage class specified for parameter 'irq_lists'
      91 | static struct hlist_head irq_lists[NR_IRQ_HASH];
         |                          ^~~~~~~~~
   In file included from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
>> drivers/tty/serial/8250/8250_core.c:92:21: error: storage class specified for parameter 'hash_mutex'
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
   include/linux/export.h:98:28: note: in definition of macro '___EXPORT_SYMBOL'
      98 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:160:41: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:164:41: note: in expansion of macro '_EXPORT_SYMBOL'
     164 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "_gpl")
         |                                         ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:405:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     405 | EXPORT_SYMBOL_GPL(serial8250_get_port);
         | ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:405:19: error: redefinition of parameter 'serial8250_get_port'
     405 | EXPORT_SYMBOL_GPL(serial8250_get_port);
         |                   ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:28: note: in definition of macro '___EXPORT_SYMBOL'
      98 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
..


vim +166 drivers/tty/serial/8250/../serial_mctrl_gpio.h

   165	
 > 166	<<<<<<< HEAD
   167	static inline void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
   168	{
   169	}
   170	
 > 171	static inline void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
   172	=======
   173	static inline int mctrl_gpio_enable_wake(struct mctrl_gpios *gpios,
   174						 enum mctrl_gpio_idx gidx)
   175	{
   176		return 0;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
