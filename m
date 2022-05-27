Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D4535D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbiE0Jii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiE0Jia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:38:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75440A32
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653644306; x=1685180306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dc/HruJncvGIc/e2G85G1gk1L73Oa8eDUAwTEq+QGyw=;
  b=ilEpugJOTabfRHryBN2uhHV/JF0Ib/OQC4ZlBwZYVE8Nys1Pi8R0dv0q
   Txx2JMz9C0jzb1t61y7JSqvB5jiiH/QNKSQXsWlyUJBQipQvYQwNUujH5
   4PWlh5OEX1ByKsAEoQFH9SaSbAbzis48+f/xAEvR35eWETu0JOE1nqiBM
   u3OpdbDlKTsQC8zdVEhlCJqqCN1biFswGid1B75yQxT55KS1UE7OTkGJ8
   if9B6rKMsamUCf7YpegbIzAwgshQKPyAArKJIrux5C4Mnlzqk7vFS/jFB
   KD2rNI5U5FXvqByJ+T/a0sw9aYLETBQytaIHaf+IK7E0hA0DR7NDi2tdT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274440276"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="274440276"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="579523127"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 May 2022 02:38:24 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuWQJ-0004dy-Sg;
        Fri, 27 May 2022 09:38:23 +0000
Date:   Fri, 27 May 2022 17:38:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51] include/linux/init.h:198:17: error: storage
 class specified for parameter
 '__initcall__kmod_8250__232_682_univ8250_console_initcon'
Message-ID: <202205271731.xKXSMgo7-lkp@intel.com>
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
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20220527/202205271731.xKXSMgo7-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout e27a96b5c1792e44763eedb238dab57df37bd6e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
   drivers/tty/serial/8250/8250_core.c:405:39: error: expected declaration specifiers before ';' token
     405 | EXPORT_SYMBOL_GPL(serial8250_get_port);
         |                                       ^
   drivers/tty/serial/8250/8250_core.c:407:15: error: storage class specified for parameter 'serial8250_isa_config'
     407 | static void (*serial8250_isa_config)(int port, struct uart_port *up,
         |               ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:412:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     412 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:415:47: error: expected declaration specifiers before ';' token
     415 | EXPORT_SYMBOL(serial8250_set_isa_configurator);
         |                                               ^
   drivers/tty/serial/8250/8250_core.c:481:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     481 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:486:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     486 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:549:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     549 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:572:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     572 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:579:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     579 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:601:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     601 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:628:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     628 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:661:23: error: storage class specified for parameter 'univ8250_console'
     661 | static struct console univ8250_console = {
         |                       ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:661:15: error: parameter 'univ8250_console' is initialized
     661 | static struct console univ8250_console = {
         |               ^~~~~~~
   drivers/tty/serial/8250/8250_core.c:663:27: error: 'univ8250_console_write' undeclared (first use in this function); did you mean 'serial8250_console_write'?
     663 |         .write          = univ8250_console_write,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
         |                           serial8250_console_write
   drivers/tty/serial/8250/8250_core.c:665:27: error: 'univ8250_console_setup' undeclared (first use in this function); did you mean 'serial8250_console_setup'?
     665 |         .setup          = univ8250_console_setup,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
         |                           serial8250_console_setup
   drivers/tty/serial/8250/8250_core.c:666:27: error: 'univ8250_console_exit' undeclared (first use in this function); did you mean 'univ8250_console'?
     666 |         .exit           = univ8250_console_exit,
         |                           ^~~~~~~~~~~~~~~~~~~~~
         |                           univ8250_console
   drivers/tty/serial/8250/8250_core.c:667:27: error: 'univ8250_console_match' undeclared (first use in this function); did you mean 'univ8250_console'?
     667 |         .match          = univ8250_console_match,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
         |                           univ8250_console
   drivers/tty/serial/8250/8250_core.c:674:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     674 | {
         | ^
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
>> include/linux/init.h:198:17: error: storage class specified for parameter '__initcall__kmod_8250__232_682_univ8250_console_initcon'
     198 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:249:27: note: in definition of macro '____define_initcall'
     249 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:198:9: note: in expansion of macro '__PASTE'
     198 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:256:17: note: in expansion of macro '__initcall_name'
     256 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:301:33: note: in expansion of macro '___define_initcall'
     301 | #define console_initcall(fn)    ___define_initcall(fn, con, .con_initcall)
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:682:1: note: in expansion of macro 'console_initcall'
     682 | console_initcall(univ8250_console_init);
         | ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:682:1: error: parameter '__initcall__kmod_8250__232_682_univ8250_console_initcon' is initialized
   drivers/tty/serial/8250/8250_core.c:682:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
>> include/linux/init.h:198:17: error: section attribute not allowed for '__initcall__kmod_8250__232_682_univ8250_console_initcon'
     198 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:249:27: note: in definition of macro '____define_initcall'
     249 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:198:9: note: in expansion of macro '__PASTE'
     198 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:256:17: note: in expansion of macro '__initcall_name'
     256 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:301:33: note: in expansion of macro '___define_initcall'
     301 | #define console_initcall(fn)    ___define_initcall(fn, con, .con_initcall)
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:682:1: note: in expansion of macro 'console_initcall'
     682 | console_initcall(univ8250_console_init);
         | ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:682:18: error: 'univ8250_console_init' undeclared (first use in this function); did you mean 'univ8250_console'?
     682 | console_initcall(univ8250_console_init);
         |                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:301:33: note: in expansion of macro '___define_initcall'
     301 | #define console_initcall(fn)    ___define_initcall(fn, con, .con_initcall)
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:682:1: note: in expansion of macro 'console_initcall'
     682 | console_initcall(univ8250_console_init);
         | ^~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:682:40: error: expected declaration specifiers before ';' token
     682 | console_initcall(univ8250_console_init);
         |                                        ^
   drivers/tty/serial/8250/8250_core.c:689:27: error: storage class specified for parameter 'serial8250_reg'
     689 | static struct uart_driver serial8250_reg = {
         |                           ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:689:15: error: parameter 'serial8250_reg' is initialized
     689 | static struct uart_driver serial8250_reg = {
         |               ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:689:27: error: redefinition of parameter 'serial8250_reg'
     689 | static struct uart_driver serial8250_reg = {
         |                           ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:54:27: note: previous definition of 'serial8250_reg' with type 'struct uart_driver'
      54 | static struct uart_driver serial8250_reg;
         |                           ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:705:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     705 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:747:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     747 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:762:39: error: expected declaration specifiers before ';' token
     762 | EXPORT_SYMBOL(serial8250_suspend_port);
         |                                       ^
   drivers/tty/serial/8250/8250_core.c:771:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     771 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:788:38: error: expected declaration specifiers before ';' token
     788 | EXPORT_SYMBOL(serial8250_resume_port);
         |                                      ^
   drivers/tty/serial/8250/8250_core.c:796:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     796 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:845:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     845 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:858:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     858 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:872:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     872 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:885:31: error: storage class specified for parameter 'serial8250_isa_driver'
     885 | static struct platform_driver serial8250_isa_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:885:15: error: parameter 'serial8250_isa_driver' is initialized
     885 | static struct platform_driver serial8250_isa_driver = {
         |               ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:886:27: error: 'serial8250_probe' undeclared (first use in this function); did you mean 'serial8250_ports'?
     886 |         .probe          = serial8250_probe,
         |                           ^~~~~~~~~~~~~~~~
         |                           serial8250_ports
   drivers/tty/serial/8250/8250_core.c:887:27: error: 'serial8250_remove' undeclared (first use in this function); did you mean 'serial8250_reg'?
     887 |         .remove         = serial8250_remove,
         |                           ^~~~~~~~~~~~~~~~~
         |                           serial8250_reg
   drivers/tty/serial/8250/8250_core.c:888:27: error: 'serial8250_suspend' undeclared (first use in this function); did you mean 'serial8250_suspend_port'?
     888 |         .suspend        = serial8250_suspend,
         |                           ^~~~~~~~~~~~~~~~~~
         |                           serial8250_suspend_port
   drivers/tty/serial/8250/8250_core.c:889:27: error: 'serial8250_resume' undeclared (first use in this function); did you mean 'serial8250_reg'?
     889 |         .resume         = serial8250_resume,
         |                           ^~~~~~~~~~~~~~~~~
         |                           serial8250_reg
   drivers/tty/serial/8250/8250_core.c:899:32: error: storage class specified for parameter 'serial8250_isa_devs'
     899 | static struct platform_device *serial8250_isa_devs;
         |                                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
   drivers/tty/serial/8250/8250_core.c:906:21: error: storage class specified for parameter 'serial_mutex'
     906 | static DEFINE_MUTEX(serial_mutex);
         |                     ^~~~~~~~~~~~
   include/linux/mutex.h:116:22: note: in definition of macro 'DEFINE_MUTEX'
     116 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~
   include/linux/mutex.h:116:16: error: parameter 'serial_mutex' is initialized
     116 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                ^~~~~
   drivers/tty/serial/8250/8250_core.c:906:8: note: in expansion of macro 'DEFINE_MUTEX'
     906 | static DEFINE_MUTEX(serial_mutex);
         |        ^~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:909:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     909 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:946:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     946 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:974:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     974 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:1118:45: error: expected declaration specifiers before ';' token
    1118 | EXPORT_SYMBOL(serial8250_register_8250_port);
         |                                             ^
   drivers/tty/serial/8250/8250_core.c:1128:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1128 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:1154:42: error: expected declaration specifiers before ';' token
    1154 | EXPORT_SYMBOL(serial8250_unregister_port);
         |                                          ^
   drivers/tty/serial/8250/8250_core.c:1157:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1157 | {
         | ^
   drivers/tty/serial/8250/8250_core.c:1214:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1214 | {
         | ^
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
>> include/linux/init.h:198:17: error: storage class specified for parameter '__initcall__kmod_8250__233_1236_serial8250_init6'
     198 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:249:27: note: in definition of macro '____define_initcall'
     249 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:198:9: note: in expansion of macro '__PASTE'
     198 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:256:17: note: in expansion of macro '__initcall_name'
     256 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1236:1: note: in expansion of macro 'module_init'
    1236 | module_init(serial8250_init);
         | ^~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:1236:1: error: parameter '__initcall__kmod_8250__233_1236_serial8250_init6' is initialized
   drivers/tty/serial/8250/8250_core.c:1236:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
>> include/linux/init.h:198:17: error: section attribute not allowed for '__initcall__kmod_8250__233_1236_serial8250_init6'
     198 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:249:27: note: in definition of macro '____define_initcall'
     249 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:198:9: note: in expansion of macro '__PASTE'
     198 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:256:17: note: in expansion of macro '__initcall_name'
     256 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1236:1: note: in expansion of macro 'module_init'
    1236 | module_init(serial8250_init);
         | ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1236:13: error: 'serial8250_init' undeclared (first use in this function); did you mean 'serial8250_reg'?
    1236 | module_init(serial8250_init);
         |             ^~~~~~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1236:1: note: in expansion of macro 'module_init'
    1236 | module_init(serial8250_init);
         | ^~~~~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from drivers/tty/serial/8250/8250_core.c:17:
   include/linux/module.h:88:38: error: expected declaration specifiers before ';' token
      88 | #define module_init(x)  __initcall(x);
         |                                      ^
   drivers/tty/serial/8250/8250_core.c:1236:1: note: in expansion of macro 'module_init'
    1236 | module_init(serial8250_init);
         | ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1236:29: error: expected declaration specifiers before ';' token
    1236 | module_init(serial8250_init);
         |                             ^
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
   include/linux/init.h:299:27: error: storage class specified for parameter '__exitcall_serial8250_exit'
     299 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                           ^~~~~~~~~~~
   include/linux/module.h:100:25: note: in expansion of macro '__exitcall'
     100 | #define module_exit(x)  __exitcall(x);
         |                         ^~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1237:1: note: in expansion of macro 'module_exit'
    1237 | module_exit(serial8250_exit);
         | ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1237:1: error: parameter '__exitcall_serial8250_exit' is initialized
   drivers/tty/serial/8250/8250_core.c:1237:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/tty/serial/8250/8250_core.c:17:
   include/linux/init.h:299:27: error: section attribute not allowed for '__exitcall_serial8250_exit'
     299 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                           ^~~~~~~~~~~
   include/linux/module.h:100:25: note: in expansion of macro '__exitcall'
     100 | #define module_exit(x)  __exitcall(x);
         |                         ^~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1237:1: note: in expansion of macro 'module_exit'
    1237 | module_exit(serial8250_exit);
         | ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1237:13: error: 'serial8250_exit' undeclared (first use in this function); did you mean 'serial8250_reg'?
    1237 | module_exit(serial8250_exit);
         |             ^~~~~~~~~~~~~~~
   include/linux/init.h:299:57: note: in definition of macro '__exitcall'
     299 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                                                         ^~
   drivers/tty/serial/8250/8250_core.c:1237:1: note: in expansion of macro 'module_exit'
    1237 | module_exit(serial8250_exit);
         | ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1237:29: error: expected declaration specifiers before ';' token
    1237 | module_exit(serial8250_exit);
         |                             ^
   In file included from <command-line>:
>> include/linux/compiler-gcc.h:42:45: error: storage class specified for parameter '__UNIQUE_ID_file234'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:183:25: note: in expansion of macro 'MODULE_INFO'
     183 | #define MODULE_FILE     MODULE_INFO(file, KBUILD_MODFILE);
         |                         ^~~~~~~~~~~
   include/linux/module.h:230:34: note: in expansion of macro 'MODULE_FILE'
     230 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                  ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1239:1: note: in expansion of macro 'MODULE_LICENSE'
    1239 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:1239:1: error: parameter '__UNIQUE_ID_file234' is initialized
   drivers/tty/serial/8250/8250_core.c:1239:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from <command-line>:
>> include/linux/compiler-gcc.h:42:45: error: section attribute not allowed for '__UNIQUE_ID_file234'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:183:25: note: in expansion of macro 'MODULE_INFO'
     183 | #define MODULE_FILE     MODULE_INFO(file, KBUILD_MODFILE);
         |                         ^~~~~~~~~~~
   include/linux/module.h:230:34: note: in expansion of macro 'MODULE_FILE'
     230 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                  ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1239:1: note: in expansion of macro 'MODULE_LICENSE'
    1239 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:42:45: error: alignment may not be specified for '__UNIQUE_ID_file234'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:183:25: note: in expansion of macro 'MODULE_INFO'
     183 | #define MODULE_FILE     MODULE_INFO(file, KBUILD_MODFILE);
         |                         ^~~~~~~~~~~
   include/linux/module.h:230:34: note: in expansion of macro 'MODULE_FILE'
     230 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                  ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1239:1: note: in expansion of macro 'MODULE_LICENSE'
    1239 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:42:45: error: storage class specified for parameter '__UNIQUE_ID_license235'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:230:46: note: in expansion of macro 'MODULE_INFO'
     230 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                              ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1239:1: note: in expansion of macro 'MODULE_LICENSE'
    1239 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:1239:1: error: parameter '__UNIQUE_ID_license235' is initialized
   drivers/tty/serial/8250/8250_core.c:1239:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from <command-line>:
>> include/linux/compiler-gcc.h:42:45: error: section attribute not allowed for '__UNIQUE_ID_license235'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:230:46: note: in expansion of macro 'MODULE_INFO'
     230 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                              ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1239:1: note: in expansion of macro 'MODULE_LICENSE'
    1239 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:42:45: error: alignment may not be specified for '__UNIQUE_ID_license235'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:230:46: note: in expansion of macro 'MODULE_INFO'
     230 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                              ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1239:1: note: in expansion of macro 'MODULE_LICENSE'
    1239 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:42:45: error: storage class specified for parameter '__UNIQUE_ID_description236'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:239:42: note: in expansion of macro 'MODULE_INFO'
     239 | #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
         |                                          ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1240:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    1240 | MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
         | ^~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_core.c:1240:1: error: parameter '__UNIQUE_ID_description236' is initialized
   drivers/tty/serial/8250/8250_core.c:1240:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from <command-line>:
>> include/linux/compiler-gcc.h:42:45: error: section attribute not allowed for '__UNIQUE_ID_description236'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:239:42: note: in expansion of macro 'MODULE_INFO'
     239 | #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
         |                                          ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1240:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    1240 | MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:42:45: error: alignment may not be specified for '__UNIQUE_ID_description236'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
     166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:239:42: note: in expansion of macro 'MODULE_INFO'
     239 | #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
         |                                          ^~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1240:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    1240 | MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
         | ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/module.h:22,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from drivers/tty/serial/8250/8250_core.c:17:
   include/linux/moduleparam.h:409:66: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                                                  ^
   include/linux/moduleparam.h:436:35: note: in expansion of macro '__param_check'
     436 | #define param_check_uint(name, p) __param_check(name, p, unsigned int)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:549:9: note: in expansion of macro 'param_check_uint'
     549 |         param_check_##type(name, &(value));                             \
         |         ^~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:549:43: error: expected declaration specifiers before ';' token
     549 |         param_check_##type(name, &(value));                             \
         |                                           ^
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:27: error: storage class specified for parameter '__param_str_share_irqs'
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |                           ^~~~~~~~~~~~
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:549:43: error: parameter '__param_str_share_irqs' is initialized
     549 |         param_check_##type(name, &(value));                             \
         |                                           ^
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:290:56: error: storage class specified for parameter '__param_share_irqs'
     290 |         static struct kernel_param __moduleparam_const __param_##name   \
         |                                                        ^~~~~~~~
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:73,
                    from <command-line>:
   include/linux/moduleparam.h:292:38: error: parameter '__param_share_irqs' is initialized
     292 |         __aligned(__alignof__(struct kernel_param))                     \
         |                                      ^~~~~~~~~~~~
   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:292:38: warning: 'used' attribute ignored [-Wattributes]
     292 |         __aligned(__alignof__(struct kernel_param))                     \
         |                                      ^~~~~~~~~~~~
   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/module.h:22,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from drivers/tty/serial/8250/8250_core.c:17:
   include/linux/moduleparam.h:290:56: error: section attribute not allowed for '__param_share_irqs'
     290 |         static struct kernel_param __moduleparam_const __param_##name   \
         |                                                        ^~~~~~~~
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:290:56: error: alignment may not be specified for '__param_share_irqs'
     290 |         static struct kernel_param __moduleparam_const __param_##name   \
         |                                                        ^~~~~~~~
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/compiler-gcc.h:42:45: error: storage class specified for parameter '__UNIQUE_ID_share_irqstype237'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/moduleparam.h:29:9: note: in expansion of macro '__MODULE_INFO'
      29 |         __MODULE_INFO(parmtype, name##type, #name ":" _type)
         |         ^~~~~~~~~~~~~
   include/linux/moduleparam.h:554:9: note: in expansion of macro '__MODULE_PARM_TYPE'
     554 |         __MODULE_PARM_TYPE(name, #type)
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/tty/serial/8250/8250_core.c:17:
>> include/linux/build_bug.h:16:51: error: parameter '__UNIQUE_ID_share_irqstype237' is initialized
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/kernel.h:509:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     509 |          BUILD_BUG_ON_ZERO((perms) & 2) +                                       \
         |          ^~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:294:13: note: in expansion of macro 'VERIFY_OCTAL_PERMISSIONS'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: warning: 'used' attribute ignored [-Wattributes]
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/kernel.h:509:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     509 |          BUILD_BUG_ON_ZERO((perms) & 2) +                                       \
         |          ^~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:294:13: note: in expansion of macro 'VERIFY_OCTAL_PERMISSIONS'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:550:9: note: in expansion of macro '__module_param_call'
     550 |         __module_param_call(MODULE_PARAM_PREFIX, name,                  \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/compiler-gcc.h:42:45: error: section attribute not allowed for '__UNIQUE_ID_share_irqstype237'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/moduleparam.h:29:9: note: in expansion of macro '__MODULE_INFO'
      29 |         __MODULE_INFO(parmtype, name##type, #name ":" _type)
         |         ^~~~~~~~~~~~~
   include/linux/moduleparam.h:554:9: note: in expansion of macro '__MODULE_PARM_TYPE'
     554 |         __MODULE_PARM_TYPE(name, #type)
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:42:45: error: alignment may not be specified for '__UNIQUE_ID_share_irqstype237'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
      67 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler-gcc.h:42:29: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:68:22: note: in expansion of macro '___PASTE'
      68 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:42:37: note: in expansion of macro '__PASTE'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/moduleparam.h:24:27: note: in expansion of macro '__UNIQUE_ID'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |                           ^~~~~~~~~~~
   include/linux/moduleparam.h:29:9: note: in expansion of macro '__MODULE_INFO'
      29 |         __MODULE_INFO(parmtype, name##type, #name ":" _type)
         |         ^~~~~~~~~~~~~
   include/linux/moduleparam.h:554:9: note: in expansion of macro '__MODULE_PARM_TYPE'
     554 |         __MODULE_PARM_TYPE(name, #type)
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:557:9: note: in expansion of macro 'module_param_hw_named'
     557 |         module_param_hw_named(name, name, type, hwtype, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:1242:1: note: in expansion of macro 'module_param_hw'
    1242 | module_param_hw(share_irqs, uint, other, 0644);
         | ^~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:42:45: error: storage class specified for parameter '__UNIQUE_ID_share_irqs238'
      42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:67:23: note: in definition of macro '___PASTE'
..


vim +/__initcall__kmod_8250__232_682_univ8250_console_initcon +198 include/linux/init.h

^1da177e4c3f41 Linus Torvalds  2005-04-16  170  
b67067f1176df6 Nicholas Piggin 2016-08-24  171  /*
b67067f1176df6 Nicholas Piggin 2016-08-24  172   * initcalls are now grouped by functionality into separate
^1da177e4c3f41 Linus Torvalds  2005-04-16  173   * subsections. Ordering inside the subsections is determined
^1da177e4c3f41 Linus Torvalds  2005-04-16  174   * by link order. 
^1da177e4c3f41 Linus Torvalds  2005-04-16  175   * For backwards compatibility, initcall() puts the call in 
^1da177e4c3f41 Linus Torvalds  2005-04-16  176   * the device init subsection.
735a7ffb739b6e Andrew Morton   2006-10-27  177   *
735a7ffb739b6e Andrew Morton   2006-10-27  178   * The `id' arg to __define_initcall() is needed so that multiple initcalls
735a7ffb739b6e Andrew Morton   2006-10-27  179   * can point at the same handler without causing duplicate-symbol build errors.
b67067f1176df6 Nicholas Piggin 2016-08-24  180   *
b67067f1176df6 Nicholas Piggin 2016-08-24  181   * Initcalls are run by placing pointers in initcall sections that the
b67067f1176df6 Nicholas Piggin 2016-08-24  182   * kernel iterates at runtime. The linker can do dead code / data elimination
b67067f1176df6 Nicholas Piggin 2016-08-24  183   * and remove that completely, so the initcall sections have to be marked
b67067f1176df6 Nicholas Piggin 2016-08-24  184   * as KEEP() in the linker script.
^1da177e4c3f41 Linus Torvalds  2005-04-16  185   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  186  
a8cccdd954732a Sami Tolvanen   2020-12-11  187  /* Format: <modname>__<counter>_<line>_<fn> */
a8cccdd954732a Sami Tolvanen   2020-12-11  188  #define __initcall_id(fn)					\
a8cccdd954732a Sami Tolvanen   2020-12-11  189  	__PASTE(__KBUILD_MODNAME,				\
a8cccdd954732a Sami Tolvanen   2020-12-11  190  	__PASTE(__,						\
a8cccdd954732a Sami Tolvanen   2020-12-11  191  	__PASTE(__COUNTER__,					\
a8cccdd954732a Sami Tolvanen   2020-12-11  192  	__PASTE(_,						\
a8cccdd954732a Sami Tolvanen   2020-12-11  193  	__PASTE(__LINE__,					\
a8cccdd954732a Sami Tolvanen   2020-12-11  194  	__PASTE(_, fn))))))
a8cccdd954732a Sami Tolvanen   2020-12-11  195  
a8cccdd954732a Sami Tolvanen   2020-12-11  196  /* Format: __<prefix>__<iid><id> */
a8cccdd954732a Sami Tolvanen   2020-12-11  197  #define __initcall_name(prefix, __iid, id)			\
a8cccdd954732a Sami Tolvanen   2020-12-11 @198  	__PASTE(__,						\
a8cccdd954732a Sami Tolvanen   2020-12-11  199  	__PASTE(prefix,						\
a8cccdd954732a Sami Tolvanen   2020-12-11  200  	__PASTE(__,						\
a8cccdd954732a Sami Tolvanen   2020-12-11  201  	__PASTE(__iid, id))))
a8cccdd954732a Sami Tolvanen   2020-12-11  202  

:::::: The code at line 198 was first introduced by commit
:::::: a8cccdd954732a558d481407ab7c3106b89c34ae init: lto: ensure initcall ordering

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
