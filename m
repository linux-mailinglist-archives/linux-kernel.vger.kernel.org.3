Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502D058951C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiHDAFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiHDAFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:05:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D5DF23
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659571533; x=1691107533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RHISAC1syUdst2HNEHzWwXw3AR5ZVxZibfWvpwG2P4Y=;
  b=XFbdEW6G7G8/VDVsQoi/ibnq25uq73YAaEfWS2S9qE1QFjUVtjhQtntg
   lKHsdtltDGFbtoWEkFMtCqJKwKWY6H/RkKljeELsrewtVwPSve7DeoCLT
   rhZawPs6gVmNdHGvj+p/ynkTt4lRdNo4gUt+JValDQy4yCHyp17odRDZ0
   Ga0A2FWeUVUVzoin6IgumRpRQh3aH5mHxPJ7AuVD3aNKGitopTTgxloBz
   ZxHaGA0XlWoght0qpxQO2ptpl2UVMIjs5NRHw/LR8FRlkbQsjTB3vxjgs
   rRi5qOh5Os+neezaM/Iibgc1iHdpZNDTnR45HvB3ESLcAgqmOAWqfDPb4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="269576593"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="269576593"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 17:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="553511928"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 17:05:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJOMi-000Hnq-1K;
        Thu, 04 Aug 2022 00:05:28 +0000
Date:   Thu, 4 Aug 2022 08:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51] arch/arc/include/asm/serial.h:15:1: warning:
 'cold' attribute ignored
Message-ID: <202208040746.RXdu2KnK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   2e73962c8797ccdf52841ea3065779839ac60e0e
commit: cbd9dc8cc7a7ad1790670c6652520fa866a9c72d [26/51] tty: serial_mctrl_gpio: add wakeup support for serial control gpios
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220804/202208040746.RXdu2KnK-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout cbd9dc8cc7a7ad1790670c6652520fa866a9c72d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   drivers/tty/serial/8250/8250.h:276:45: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     276 | static inline int serial8250_pnp_init(void) { return 0; }
         |                                             ^
   drivers/tty/serial/8250/8250.h:277:46: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     277 | static inline void serial8250_pnp_exit(void) { }
         |                                              ^
   drivers/tty/serial/8250/8250.h:283:66: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     283 | static inline int fintek_8250_probe(struct uart_8250_port *uart) { return 0; }
         |                                                                  ^
   drivers/tty/serial/8250/8250.h:315:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     315 | {
         | ^
   drivers/tty/serial/8250/8250.h:319:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     319 | {
         | ^
   drivers/tty/serial/8250/8250.h:348:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     348 | {
         | ^
   drivers/tty/serial/8250/8250.h:352:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     352 | {
         | ^
   drivers/tty/serial/8250/8250.h:355:70: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     355 | static inline void serial8250_rx_dma_flush(struct uart_8250_port *p) { }
         |                                                                      ^
   drivers/tty/serial/8250/8250.h:357:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     357 | {
         | ^
   drivers/tty/serial/8250/8250.h:360:69: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     360 | static inline void serial8250_release_dma(struct uart_8250_port *p) { }
         |                                                                     ^
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
                    from include/linux/mutex.h:17:
   drivers/tty/serial/8250/8250_core.c:405:19: error: storage class specified for parameter 'serial8250_get_port'
     405 | EXPORT_SYMBOL_GPL(serial8250_get_port);
         |                   ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:87:28: note: in definition of macro '___EXPORT_SYMBOL'
      87 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
     147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
--
         | ^
   drivers/tty/serial/8250/8250_dw.c:210:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     210 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:217:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     217 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:227:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     227 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:235:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     235 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:287:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     287 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:303:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     303 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:328:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     328 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:340:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     340 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:363:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     363 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:387:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     387 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:392:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     392 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:397:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     397 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:407:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     407 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:420:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     420 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:433:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     433 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:488:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     488 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:493:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     493 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:498:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     498 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:671:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     671 | {
         | ^
   drivers/tty/serial/8250/8250_dw.c:735:32: error: storage class specified for parameter 'dw8250_pm_ops'
     735 | static const struct dev_pm_ops dw8250_pm_ops = {
         |                                ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:735:21: error: parameter 'dw8250_pm_ops' is initialized
     735 | static const struct dev_pm_ops dw8250_pm_ops = {
         |                     ^~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:740:42: error: storage class specified for parameter 'dw8250_dw_apb'
     740 | static const struct dw8250_platform_data dw8250_dw_apb = {
         |                                          ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:740:21: error: parameter 'dw8250_dw_apb' is initialized
     740 | static const struct dw8250_platform_data dw8250_dw_apb = {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:744:42: error: storage class specified for parameter 'dw8250_octeon_3860_data'
     744 | static const struct dw8250_platform_data dw8250_octeon_3860_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:744:21: error: parameter 'dw8250_octeon_3860_data' is initialized
     744 | static const struct dw8250_platform_data dw8250_octeon_3860_data = {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:749:42: error: storage class specified for parameter 'dw8250_armada_38x_data'
     749 | static const struct dw8250_platform_data dw8250_armada_38x_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:749:21: error: parameter 'dw8250_armada_38x_data' is initialized
     749 | static const struct dw8250_platform_data dw8250_armada_38x_data = {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:754:42: error: storage class specified for parameter 'dw8250_renesas_rzn1_data'
     754 | static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:754:21: error: parameter 'dw8250_renesas_rzn1_data' is initialized
     754 | static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:760:42: error: storage class specified for parameter 'dw8250_starfive_jh7100_data'
     760 | static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:760:21: error: parameter 'dw8250_starfive_jh7100_data' is initialized
     760 | static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:765:34: error: storage class specified for parameter 'dw8250_of_match'
     765 | static const struct of_device_id dw8250_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:765:21: error: parameter 'dw8250_of_match' is initialized
     765 | static const struct of_device_id dw8250_of_match[] = {
         |                     ^~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_dw.c:766:9: warning: braces around scalar initializer
     766 |         { .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:766:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:766:11: error: field name not in record or union initializer
     766 |         { .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:766:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:766:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     766 |         { .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
         |                         ^~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:766:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:766:45: error: field name not in record or union initializer
     766 |         { .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
         |                                             ^
   drivers/tty/serial/8250/8250_dw.c:766:45: note: (near initialization for 'dw8250_of_match')
>> drivers/tty/serial/8250/8250_dw.c:766:53: warning: excess elements in scalar initializer
     766 |         { .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
         |                                                     ^
   drivers/tty/serial/8250/8250_dw.c:766:53: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:767:9: warning: braces around scalar initializer
     767 |         { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:767:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:767:11: error: field name not in record or union initializer
     767 |         { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:767:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:767:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     767 |         { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:767:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:767:52: error: field name not in record or union initializer
     767 |         { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
         |                                                    ^
   drivers/tty/serial/8250/8250_dw.c:767:52: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:767:60: warning: excess elements in scalar initializer
     767 |         { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
         |                                                            ^
   drivers/tty/serial/8250/8250_dw.c:767:60: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:767:9: warning: excess elements in scalar initializer
     767 |         { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:767:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:768:9: warning: braces around scalar initializer
     768 |         { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:768:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:768:11: error: field name not in record or union initializer
     768 |         { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:768:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:768:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     768 |         { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:768:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:768:52: error: field name not in record or union initializer
     768 |         { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
         |                                                    ^
   drivers/tty/serial/8250/8250_dw.c:768:52: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:768:60: warning: excess elements in scalar initializer
     768 |         { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
         |                                                            ^
   drivers/tty/serial/8250/8250_dw.c:768:60: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:768:9: warning: excess elements in scalar initializer
     768 |         { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:768:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:769:9: warning: braces around scalar initializer
     769 |         { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:769:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:769:11: error: field name not in record or union initializer
     769 |         { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:769:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:769:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     769 |         { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:769:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:769:46: error: field name not in record or union initializer
     769 |         { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
         |                                              ^
   drivers/tty/serial/8250/8250_dw.c:769:46: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:769:54: warning: excess elements in scalar initializer
     769 |         { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
         |                                                      ^
   drivers/tty/serial/8250/8250_dw.c:769:54: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:769:9: warning: excess elements in scalar initializer
     769 |         { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:769:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:770:9: warning: braces around scalar initializer
     770 |         { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:770:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:770:11: error: field name not in record or union initializer
     770 |         { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
         |           ^
   drivers/tty/serial/8250/8250_dw.c:770:11: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:770:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     770 |         { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_dw.c:770:25: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:770:49: error: field name not in record or union initializer
     770 |         { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
         |                                                 ^
   drivers/tty/serial/8250/8250_dw.c:770:49: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:770:57: warning: excess elements in scalar initializer
     770 |         { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
         |                                                         ^
   drivers/tty/serial/8250/8250_dw.c:770:57: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:770:9: warning: excess elements in scalar initializer
     770 |         { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
         |         ^
   drivers/tty/serial/8250/8250_dw.c:770:9: note: (near initialization for 'dw8250_of_match')
   drivers/tty/serial/8250/8250_dw.c:771:9: warning: braces around scalar initializer
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
