Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94486535A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbiE0Hff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244513AbiE0Hf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:35:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CAF7495
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653636925; x=1685172925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uFtgI0/GwB8wmQL1j8Ff8SJH1eOpKHJ8v4h0mimjyP4=;
  b=SQRueQ9rTWpAyWFmQXDdekTo9CLE14ASmDimH6g6KRyWIEyDhLmzibw2
   WiH5FwLgo4794VNtlEmyLxovwJFjhwH7qiW/rIdrANT1rnZfJbwE5Wtv0
   jWMj2trgwZaP0YCWKMDUTIy6OPrg6W84Au5SxG95zkA9oLOnD4/s1BKqM
   lf/7nkpUeDd25bncatDeA8JtMQO53Ud+DscwlBMB6mG7OCaH5sVbszi7E
   RLpQpJ3iUygxMKx/BlQKCDyZkN1rkt+jwLxAJD5UFyDHo4FCg2GekMPbc
   Wotir/k2AYWTay7cOKwhepiFPY+vBNVzOhIcMkSPmPGmlRgoCvjspgryf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335059198"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335059198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 00:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="550032969"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2022 00:35:19 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuUVC-0004WQ-Et;
        Fri, 27 May 2022 07:35:18 +0000
Date:   Fri, 27 May 2022 15:34:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51] arch/arc/include/asm/serial.h:15:1: warning:
 'cold' attribute ignored
Message-ID: <202205271528.NvJATULb-lkp@intel.com>
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
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220527/202205271528.NvJATULb-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout e27a96b5c1792e44763eedb238dab57df37bd6e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

      17 | struct uart_8250_dma {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:54:1: warning: empty declaration
      54 | struct old_serial_port {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:65:1: warning: empty declaration
      65 | struct serial8250_config {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:114:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
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
   drivers/tty/serial/8250/8250.h:251:45: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     251 | static inline int serial8250_pnp_init(void) { return 0; }
         |                                             ^
   drivers/tty/serial/8250/8250.h:252:46: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     252 | static inline void serial8250_pnp_exit(void) { }
         |                                              ^
   drivers/tty/serial/8250/8250.h:258:66: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     258 | static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
         |                                                                  ^
   drivers/tty/serial/8250/8250.h:289:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     289 | {
         | ^
   drivers/tty/serial/8250/8250.h:293:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     293 | {
         | ^
   drivers/tty/serial/8250/8250.h:306:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     306 | {
         | ^
   drivers/tty/serial/8250/8250.h:310:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     310 | {
         | ^
   drivers/tty/serial/8250/8250.h:313:70: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     313 | static inline void serial8250_rx_dma_flush(struct uart_8250_port *p) { }
         |                                                                      ^
   drivers/tty/serial/8250/8250.h:315:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     315 | {
         | ^
   drivers/tty/serial/8250/8250.h:318:69: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     318 | static inline void serial8250_release_dma(struct uart_8250_port *p) { }
         |                                                                     ^
   drivers/tty/serial/8250/8250.h:322:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     322 | {
         | ^
   drivers/tty/serial/8250/8250.h:339:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     339 | {
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
   In file included from drivers/tty/serial/8250/8250_core.c:60:
   arch/arc/include/asm/serial.h:15:28: error: storage class specified for parameter 'arc_early_base_baud'
      15 | extern unsigned int __init arc_early_base_baud(void);
         |                            ^~~~~~~~~~~~~~~~~~~
   arch/arc/include/asm/serial.h:15:28: error: section attribute not allowed for 'arc_early_base_baud'
>> arch/arc/include/asm/serial.h:15:1: warning: 'cold' attribute ignored [-Wattributes]
      15 | extern unsigned int __init arc_early_base_baud(void);
         | ^~~~~~
   drivers/tty/serial/8250/8250_core.c:70:37: error: storage class specified for parameter 'old_serial_port'
      70 | static const struct old_serial_port old_serial_port[] = {
         |                                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:70:21: error: parameter 'old_serial_port' is initialized
      70 | static const struct old_serial_port old_serial_port[] = {
         |                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:70:57: error: empty scalar initializer
      70 | static const struct old_serial_port old_serial_port[] = {
         |                                                         ^
   drivers/tty/serial/8250/8250_core.c:70:57: note: (near initialization for 'old_serial_port')
   drivers/tty/serial/8250/8250_core.c:83:1: warning: empty declaration
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
   drivers/tty/serial/8250/8250_core.c:384:27: error: 'univ8250_release_irq' undeclared (first use in this function)
     384 |         .release_irq    = univ8250_release_irq,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:387:30: error: storage class specified for parameter 'serial8250_ports'
     387 | static struct uart_8250_port serial8250_ports[UART_NR];
         |                              ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:402:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     402 | {
         | ^
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
   drivers/tty/serial/8250/8250_core.c:405:19: error: storage class specified for parameter 'serial8250_get_port'
--
   In file included from drivers/tty/serial/8250/8250.h:15,
                    from drivers/tty/serial/8250/8250_dwlib.h:6,
                    from drivers/tty/serial/8250/8250_dw.c:32:
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
   In file included from drivers/tty/serial/8250/8250_dwlib.h:6,
                    from drivers/tty/serial/8250/8250_dw.c:32:
   drivers/tty/serial/8250/8250.h:17:1: warning: empty declaration
      17 | struct uart_8250_dma {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:54:1: warning: empty declaration
      54 | struct old_serial_port {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:65:1: warning: empty declaration
      65 | struct serial8250_config {
         | ^~~~~~
   drivers/tty/serial/8250/8250.h:114:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
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
   drivers/tty/serial/8250/8250.h:251:45: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     251 | static inline int serial8250_pnp_init(void) { return 0; }
         |                                             ^
   drivers/tty/serial/8250/8250.h:252:46: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     252 | static inline void serial8250_pnp_exit(void) { }
         |                                              ^
   drivers/tty/serial/8250/8250.h:258:66: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     258 | static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
         |                                                                  ^
   drivers/tty/serial/8250/8250.h:289:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     289 | {
         | ^
   drivers/tty/serial/8250/8250.h:293:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     293 | {
         | ^
   drivers/tty/serial/8250/8250.h:306:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     306 | {
         | ^
   drivers/tty/serial/8250/8250.h:310:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     310 | {
         | ^
   drivers/tty/serial/8250/8250.h:313:70: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     313 | static inline void serial8250_rx_dma_flush(struct uart_8250_port *p) { }
         |                                                                      ^
   drivers/tty/serial/8250/8250.h:315:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     315 | {
         | ^
   drivers/tty/serial/8250/8250.h:318:69: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     318 | static inline void serial8250_release_dma(struct uart_8250_port *p) { }
         |                                                                     ^
   drivers/tty/serial/8250/8250.h:322:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     322 | {
         | ^
   drivers/tty/serial/8250/8250.h:339:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     339 | {
         | ^
   In file included from drivers/tty/serial/8250/8250_dw.c:32:
   drivers/tty/serial/8250/8250_dwlib.h:8:1: warning: empty declaration
       8 | struct dw8250_port_data {
         | ^~~~~~
>> drivers/tty/serial/8250/8250_dw.c:40:1: warning: empty declaration
      40 | struct dw8250_data {
         | ^~~~~~
   drivers/tty/serial/8250/8250_dw.c:57:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      57 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:62:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      62 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:67:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      67 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:72:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      72 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:85:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      85 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:93:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      93 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:126:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     126 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:146:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     146 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:161:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     161 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:171:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     171 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:202:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     202 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:212:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     212 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:219:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     219 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:229:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     229 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:237:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     237 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:278:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     278 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:294:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     294 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:319:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     319 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:331:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     331 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:354:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     354 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:378:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     378 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:383:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     383 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:388:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     388 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:437:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     437 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:621:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     621 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:691:32: error: storage class specified for parameter 'dw8250_pm_ops'
     691 | static const struct dev_pm_ops dw8250_pm_ops = {
         |                                ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:691:21: error: parameter 'dw8250_pm_ops' is initialized
     691 | static const struct dev_pm_ops dw8250_pm_ops = {
         |                     ^~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:696:34: error: storage class specified for parameter 'dw8250_of_match'
     696 | static const struct of_device_id dw8250_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:696:21: error: parameter 'dw8250_of_match' is initialized
     696 | static const struct of_device_id dw8250_of_match[] = {
         |                     ^~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_dw.c:697:9: warning: braces around scalar initializer
     697 |         { .compatible = "snps,dw-apb-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:697:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:697:11: error: field name not in record or union initializer
     697 |         { .compatible = "snps,dw-apb-uart" },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:697:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:697:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     697 |         { .compatible = "snps,dw-apb-uart" },
         |                         ^~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:697:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:698:9: warning: braces around scalar initializer
     698 |         { .compatible = "cavium,octeon-3860-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:698:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:698:11: error: field name not in record or union initializer
     698 |         { .compatible = "cavium,octeon-3860-uart" },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:698:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:698:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     698 |         { .compatible = "cavium,octeon-3860-uart" },
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:698:25: note: (near initialization for 'dw8250_of_match')
>> drivers/tty/serial/8250/8250_dw.c:698:9: warning: excess elements in scalar initializer
     698 |         { .compatible = "cavium,octeon-3860-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:698:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:699:9: warning: braces around scalar initializer
     699 |         { .compatible = "marvell,armada-38x-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:699:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:699:11: error: field name not in record or union initializer
     699 |         { .compatible = "marvell,armada-38x-uart" },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:699:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:699:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     699 |         { .compatible = "marvell,armada-38x-uart" },
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:699:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:699:9: warning: excess elements in scalar initializer
     699 |         { .compatible = "marvell,armada-38x-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:699:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:700:9: warning: braces around scalar initializer
     700 |         { .compatible = "renesas,rzn1-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:700:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:700:11: error: field name not in record or union initializer
     700 |         { .compatible = "renesas,rzn1-uart" },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:700:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:700:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     700 |         { .compatible = "renesas,rzn1-uart" },
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:700:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:700:9: warning: excess elements in scalar initializer
     700 |         { .compatible = "renesas,rzn1-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:700:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:701:9: warning: braces around scalar initializer
     701 |         { .compatible = "starfive,jh7100-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:701:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:701:11: error: field name not in record or union initializer
     701 |         { .compatible = "starfive,jh7100-uart" },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:701:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:701:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     701 |         { .compatible = "starfive,jh7100-uart" },
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:701:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:701:9: warning: excess elements in scalar initializer
     701 |         { .compatible = "starfive,jh7100-uart" },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:701:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:702:9: warning: braces around scalar initializer
     702 |         { /* Sentinel */ }
         |         ^
   drivers/tty/serial/8250/8250_dw.c:702:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:702:9: error: empty scalar initializer
   drivers/tty/serial/8250/8250_dw.c:702:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:702:9: warning: excess elements in scalar initializer
   drivers/tty/serial/8250/8250_dw.c:702:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:704:41: error: expected declaration specifiers before ';' token
     704 | MODULE_DEVICE_TABLE(of, dw8250_of_match);
         |                                         ^
   drivers/tty/serial/8250/8250_dw.c:706:36: error: storage class specified for parameter 'dw8250_acpi_match'
     706 | static const struct acpi_device_id dw8250_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:706:21: error: parameter 'dw8250_acpi_match' is initialized
     706 | static const struct acpi_device_id dw8250_acpi_match[] = {
         |                     ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:707:9: warning: braces around scalar initializer
     707 |         { "INT33C4", 0 },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:707:9: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:707:11: error: initialization of 'const struct acpi_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     707 |         { "INT33C4", 0 },
         |           ^~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:707:11: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:707:22: warning: excess elements in scalar initializer
     707 |         { "INT33C4", 0 },
         |                      ^
   drivers/tty/serial/8250/8250_dw.c:707:22: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:708:9: warning: braces around scalar initializer
     708 |         { "INT33C5", 0 },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:708:9: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:708:11: error: initialization of 'const struct acpi_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     708 |         { "INT33C5", 0 },
         |           ^~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:708:11: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:708:22: warning: excess elements in scalar initializer
     708 |         { "INT33C5", 0 },
         |                      ^
   drivers/tty/serial/8250/8250_dw.c:708:22: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:708:9: warning: excess elements in scalar initializer
     708 |         { "INT33C5", 0 },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:708:9: note: (near initialization for 'dw8250_acpi_match')
   drivers/tty/serial/8250/8250_dw.c:709:9: warning: braces around scalar initializer
     709 |         { "INT3434", 0 },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:709:9: note: (near initialization for 'dw8250_acpi_match')
..


vim +/cold +15 arch/arc/include/asm/serial.h

0208c96a9df989 Vineet Gupta 2013-01-23   8  
0208c96a9df989 Vineet Gupta 2013-01-23   9  /*
ffb7fcd66f14bc Vineet Gupta 2014-10-28  10   * early 8250 (now earlycon) requires BASE_BAUD to be defined in this header.
ffb7fcd66f14bc Vineet Gupta 2014-10-28  11   * However to still determine it dynamically (for multi-platform images)
ffb7fcd66f14bc Vineet Gupta 2014-10-28  12   * we do this in a helper by parsing the FDT early
0208c96a9df989 Vineet Gupta 2013-01-23  13   */
0208c96a9df989 Vineet Gupta 2013-01-23  14  
ffb7fcd66f14bc Vineet Gupta 2014-10-28 @15  extern unsigned int __init arc_early_base_baud(void);
0208c96a9df989 Vineet Gupta 2013-01-23  16  

:::::: The code at line 15 was first introduced by commit
:::::: ffb7fcd66f14bc716b9fdf559e71909131fef39b ARC: Dynamically determine BASE_BAUD from DeviceTree

:::::: TO: Vineet Gupta <vgupta@synopsys.com>
:::::: CC: Vineet Gupta <vgupta@synopsys.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
