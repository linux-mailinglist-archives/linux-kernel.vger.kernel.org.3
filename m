Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDD5899DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiHDJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHDJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:23:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF4D67159
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659605027; x=1691141027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hLiE/z/NOArgWys9rmumQXpnv5cIWCPRlRNLF96AAHo=;
  b=e7Spy92Vhiq3+S771kjN3F6UZ1YhD0A7GOOqfuWeFvSXi5hoR9nPlafR
   izUpIyH8/51Z+rPXMzs5Q9bQxdeowrPrr6POKG5DJvuP5cInUNYWY10lW
   JBROnOj2/aG3DshoTkMVLYBEa55VTd9okOUiUeLRa3bOr/doI9sRpA3Sd
   BK79GhmKHw/aUHEnmANXuRV+A3pCpO6H8J/IF8TQxSv+b/fjl2qx8URuF
   mnHvL2G2/Ypr2fTfYHKE8+mQZdslELVqjnkQqTuRljZBYhP0+msoQnioM
   gECeKu12qHAslnOMTWKeIq7dUJDVGjqO++inm8DBelZkikXkuLdjiLlWI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="289900115"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="289900115"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 02:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="692565683"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2022 02:23:46 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJX4z-000ICg-1V;
        Thu, 04 Aug 2022 09:23:45 +0000
Date:   Thu, 4 Aug 2022 17:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51]
 drivers/tty/serial/serial_mctrl_gpio.h:171:20: error: old-style parameter
 declarations in prototyped function definition
Message-ID: <202208041734.GGnGQt8q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   2e73962c8797ccdf52841ea3065779839ac60e0e
commit: cbd9dc8cc7a7ad1790670c6652520fa866a9c72d [26/51] tty: serial_mctrl_gpio: add wakeup support for serial control gpios
config: sh-polaris_defconfig (https://download.01.org/0day-ci/archive/20220804/202208041734.GGnGQt8q-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout cbd9dc8cc7a7ad1790670c6652520fa866a9c72d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/sh-sci.c:57:
   drivers/tty/serial/serial_mctrl_gpio.h:166:1: error: version control conflict marker in file
     166 | <<<<<<< HEAD
         | ^~~~~~~
   drivers/tty/serial/serial_mctrl_gpio.h: In function 'mctrl_gpio_disable_irq_wake':
   drivers/tty/serial/serial_mctrl_gpio.h:172:1: error: version control conflict marker in file
     172 | =======
         | ^~~~~~~
   drivers/tty/serial/serial_mctrl_gpio.h:181:1: error: version control conflict marker in file
     181 | >>>>>>> eef01d4b6b91 (tty: serial_mctrl_gpio: add wakeup support for serial control gpios)
         | ^~~~~~~
   In file included from drivers/tty/serial/sh-sci.c:58:
   drivers/tty/serial/sh-sci.h:14:1: warning: empty declaration
      14 | enum {
         | ^~~~
   drivers/tty/serial/sh-sci.c:61:1: warning: empty declaration
      61 | enum {
         | ^~~~
   drivers/tty/serial/sh-sci.c:79:1: warning: empty declaration
      79 | enum SCI_CLKS {
         | ^~~~
   drivers/tty/serial/sh-sci.c:103:1: warning: empty declaration
     103 | struct plat_sci_reg {
         | ^~~~~~
   drivers/tty/serial/sh-sci.c:107:1: warning: empty declaration
     107 | struct sci_port_params {
         | ^~~~~~
   drivers/tty/serial/sh-sci.c:117:1: warning: empty declaration
     117 | struct sci_port {
         | ^~~~~~
>> drivers/tty/serial/sh-sci.c:164:24: error: storage class specified for parameter 'sci_ports'
     164 | static struct sci_port sci_ports[SCI_NPORTS];
         |                        ^~~~~~~~~
>> drivers/tty/serial/sh-sci.c:165:22: error: storage class specified for parameter 'sci_ports_in_use'
     165 | static unsigned long sci_ports_in_use;
         |                      ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:166:27: error: storage class specified for parameter 'sci_uart_driver'
     166 | static struct uart_driver sci_uart_driver;
         |                           ^~~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:170:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     170 | {
         | ^
>> drivers/tty/serial/sh-sci.c:174:37: error: storage class specified for parameter 'sci_port_params'
     174 | static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
         |                                     ^~~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:174:21: error: parameter 'sci_port_params' is initialized
     174 | static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
         |                     ^~~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:179:10: error: array index in non-array initializer
     179 |         [SCIx_SCI_REGTYPE] = {
         |          ^~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:179:10: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:179:9: warning: braces around scalar initializer
     179 |         [SCIx_SCI_REGTYPE] = {
         |         ^
   drivers/tty/serial/sh-sci.c:179:9: note: (near initialization for 'sci_port_params')
>> drivers/tty/serial/sh-sci.c:180:17: error: field name not in record or union initializer
     180 |                 .regs = {
         |                 ^
   drivers/tty/serial/sh-sci.c:180:17: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:180:17: warning: braces around scalar initializer
   drivers/tty/serial/sh-sci.c:180:17: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:181:26: error: array index in non-array initializer
     181 |                         [SCSMR]         = { 0x00,  8 },
         |                          ^~~~~
   drivers/tty/serial/sh-sci.c:181:26: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:181:25: warning: braces around scalar initializer
     181 |                         [SCSMR]         = { 0x00,  8 },
         |                         ^
   drivers/tty/serial/sh-sci.c:181:25: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:181:52: warning: excess elements in scalar initializer
     181 |                         [SCSMR]         = { 0x00,  8 },
         |                                                    ^
   drivers/tty/serial/sh-sci.c:181:52: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:182:26: error: array index in non-array initializer
     182 |                         [SCBRR]         = { 0x01,  8 },
         |                          ^~~~~
   drivers/tty/serial/sh-sci.c:182:26: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:182:25: warning: braces around scalar initializer
     182 |                         [SCBRR]         = { 0x01,  8 },
         |                         ^
   drivers/tty/serial/sh-sci.c:182:25: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:182:45: warning: initialization of 'const struct sci_port_params *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     182 |                         [SCBRR]         = { 0x01,  8 },
         |                                             ^~~~
   drivers/tty/serial/sh-sci.c:182:45: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:182:52: warning: excess elements in scalar initializer
     182 |                         [SCBRR]         = { 0x01,  8 },
         |                                                    ^
   drivers/tty/serial/sh-sci.c:182:52: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:182:43: warning: excess elements in scalar initializer
     182 |                         [SCBRR]         = { 0x01,  8 },
         |                                           ^
   drivers/tty/serial/sh-sci.c:182:43: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:183:26: error: array index in non-array initializer
     183 |                         [SCSCR]         = { 0x02,  8 },
         |                          ^~~~~
   drivers/tty/serial/sh-sci.c:183:26: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:183:25: warning: braces around scalar initializer
     183 |                         [SCSCR]         = { 0x02,  8 },
         |                         ^
   drivers/tty/serial/sh-sci.c:183:25: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:183:45: warning: initialization of 'const struct sci_port_params *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     183 |                         [SCSCR]         = { 0x02,  8 },
         |                                             ^~~~
   drivers/tty/serial/sh-sci.c:183:45: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:183:52: warning: excess elements in scalar initializer
     183 |                         [SCSCR]         = { 0x02,  8 },
         |                                                    ^
   drivers/tty/serial/sh-sci.c:183:52: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:183:43: warning: excess elements in scalar initializer
     183 |                         [SCSCR]         = { 0x02,  8 },
         |                                           ^
   drivers/tty/serial/sh-sci.c:183:43: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:184:26: error: array index in non-array initializer
     184 |                         [SCxTDR]        = { 0x03,  8 },
         |                          ^~~~~~
   drivers/tty/serial/sh-sci.c:184:26: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:184:25: warning: braces around scalar initializer
     184 |                         [SCxTDR]        = { 0x03,  8 },
         |                         ^
   drivers/tty/serial/sh-sci.c:184:25: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:184:45: warning: initialization of 'const struct sci_port_params *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     184 |                         [SCxTDR]        = { 0x03,  8 },
         |                                             ^~~~
   drivers/tty/serial/sh-sci.c:184:45: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:184:52: warning: excess elements in scalar initializer
     184 |                         [SCxTDR]        = { 0x03,  8 },
         |                                                    ^
   drivers/tty/serial/sh-sci.c:184:52: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:184:43: warning: excess elements in scalar initializer
     184 |                         [SCxTDR]        = { 0x03,  8 },
         |                                           ^
   drivers/tty/serial/sh-sci.c:184:43: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:185:26: error: array index in non-array initializer
     185 |                         [SCxSR]         = { 0x04,  8 },
         |                          ^~~~~
   drivers/tty/serial/sh-sci.c:185:26: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:185:25: warning: braces around scalar initializer
     185 |                         [SCxSR]         = { 0x04,  8 },
         |                         ^
   drivers/tty/serial/sh-sci.c:185:25: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:185:45: warning: initialization of 'const struct sci_port_params *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     185 |                         [SCxSR]         = { 0x04,  8 },
         |                                             ^~~~
   drivers/tty/serial/sh-sci.c:185:45: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:185:52: warning: excess elements in scalar initializer
     185 |                         [SCxSR]         = { 0x04,  8 },
         |                                                    ^
   drivers/tty/serial/sh-sci.c:185:52: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:185:43: warning: excess elements in scalar initializer
     185 |                         [SCxSR]         = { 0x04,  8 },
         |                                           ^
   drivers/tty/serial/sh-sci.c:185:43: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:186:26: error: array index in non-array initializer
     186 |                         [SCxRDR]        = { 0x05,  8 },
         |                          ^~~~~~
--
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:493:17: error: field name not in record or union initializer
     493 |                 .error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
         |                 ^
   drivers/tty/serial/sh-sci.c:493:17: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.h:103:33: warning: excess elements in scalar initializer
     103 | #define SCIF_ERROR_CLEAR        (u32)(~(SCIF_PER | SCIF_FER | SCIF_ER))
         |                                 ^
   drivers/tty/serial/sh-sci.c:493:32: note: in expansion of macro 'SCIF_ERROR_CLEAR'
     493 |                 .error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
         |                                ^~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.h:103:33: note: (near initialization for 'sci_port_params')
     103 | #define SCIF_ERROR_CLEAR        (u32)(~(SCIF_PER | SCIF_FER | SCIF_ER))
         |                                 ^
   drivers/tty/serial/sh-sci.c:493:32: note: in expansion of macro 'SCIF_ERROR_CLEAR'
     493 |                 .error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
         |                                ^~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:477:38: warning: excess elements in scalar initializer
     477 |         [SCIx_SH7705_SCIF_REGTYPE] = {
         |                                      ^
   drivers/tty/serial/sh-sci.c:477:38: note: (near initialization for 'sci_port_params')
   drivers/tty/serial/sh-sci.c:506:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     506 | {
         | ^
   drivers/tty/serial/sh-sci.c:520:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     520 | {
         | ^
   drivers/tty/serial/sh-sci.c:532:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     532 | {
         | ^
   drivers/tty/serial/sh-sci.c:548:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     548 | {
         | ^
   drivers/tty/serial/sh-sci.c:561:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     561 | {
         | ^
   drivers/tty/serial/sh-sci.c:573:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     573 | {
         | ^
   drivers/tty/serial/sh-sci.c:603:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     603 | {
         | ^
   drivers/tty/serial/sh-sci.c:626:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     626 | {
         | ^
   drivers/tty/serial/sh-sci.c:638:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     638 | {
         | ^
   drivers/tty/serial/sh-sci.c:652:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     652 | {
         | ^
   drivers/tty/serial/sh-sci.c:699:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     699 | {
         | ^
   drivers/tty/serial/sh-sci.c:713:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     713 | {
         | ^
   drivers/tty/serial/sh-sci.c:763:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     763 | {
         | ^
   drivers/tty/serial/sh-sci.c:780:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     780 | {
         | ^
   drivers/tty/serial/sh-sci.c:785:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     785 | {
         | ^
   drivers/tty/serial/sh-sci.c:806:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     806 | {
         | ^
   drivers/tty/serial/sh-sci.c:854:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     854 | {
         | ^
   drivers/tty/serial/sh-sci.c:928:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     928 | {
         | ^
   drivers/tty/serial/sh-sci.c:966:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     966 | {
         | ^
   drivers/tty/serial/sh-sci.c:993:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     993 | {
         | ^
   drivers/tty/serial/sh-sci.c:1018:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1018 | {
         | ^
   drivers/tty/serial/sh-sci.c:1077:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1077 | {
         | ^
   drivers/tty/serial/sh-sci.c:1086:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1086 | {
         | ^
   drivers/tty/serial/sh-sci.c:1096:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1096 | {
         | ^
   drivers/tty/serial/sh-sci.c:1106:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1106 | {
         | ^
   In file included from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/cpufreq.h:12,
                    from drivers/tty/serial/sh-sci.c:23:
>> include/linux/device.h:132:33: error: storage class specified for parameter 'dev_attr_rx_fifo_trigger'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                 ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1123:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |        ^~~~~~~~~~~~~~
>> include/linux/device.h:132:16: error: parameter 'dev_attr_rx_fifo_trigger' is initialized
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                ^~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1123:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |        ^~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16:
>> drivers/tty/serial/sh-sci.c:1123:23: error: 'rx_fifo_trigger_show' undeclared (first use in this function)
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |                       ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1123:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |        ^~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1123:23: note: each undeclared identifier is reported only once for each function it appears in
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |                       ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1123:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |        ^~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:1123:23: error: 'rx_fifo_trigger_store' undeclared (first use in this function)
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |                       ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1123:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1123 | static DEVICE_ATTR_RW(rx_fifo_trigger);
         |        ^~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1128:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1128 | {
         | ^
   drivers/tty/serial/sh-sci.c:1145:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1145 | {
         | ^
>> include/linux/device.h:132:33: error: storage class specified for parameter 'dev_attr_rx_fifo_timeout'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                 ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1169:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1169 | static DEVICE_ATTR_RW(rx_fifo_timeout);
         |        ^~~~~~~~~~~~~~
>> include/linux/device.h:132:16: error: parameter 'dev_attr_rx_fifo_timeout' is initialized
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                ^~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1169:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1169 | static DEVICE_ATTR_RW(rx_fifo_timeout);
         |        ^~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:1169:23: error: 'rx_fifo_timeout_show' undeclared (first use in this function)
    1169 | static DEVICE_ATTR_RW(rx_fifo_timeout);
         |                       ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1169:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1169 | static DEVICE_ATTR_RW(rx_fifo_timeout);
         |        ^~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:1169:23: error: 'rx_fifo_timeout_store' undeclared (first use in this function)
    1169 | static DEVICE_ATTR_RW(rx_fifo_timeout);
         |                       ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1169:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1169 | static DEVICE_ATTR_RW(rx_fifo_timeout);
         |        ^~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1671:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1671 | {
         | ^
   drivers/tty/serial/sh-sci.c:1675:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1675 | {
         | ^
   drivers/tty/serial/sh-sci.c:1682:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1682 | {
         | ^
   drivers/tty/serial/sh-sci.c:1733:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1733 | {
         | ^
   drivers/tty/serial/sh-sci.c:1745:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1745 | {
         | ^
   drivers/tty/serial/sh-sci.c:1760:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1760 | {
         | ^
   drivers/tty/serial/sh-sci.c:1800:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1800 | {
         | ^
>> drivers/tty/serial/sh-sci.c:1849:3: error: storage class specified for parameter 'sci_irq_desc'
    1849 | } sci_irq_desc[] = {
         |   ^~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:1849:1: error: parameter 'sci_irq_desc' is initialized
    1849 | } sci_irq_desc[] = {
         | ^
   drivers/tty/serial/sh-sci.c:1853:10: error: array index in non-array initializer
    1853 |         [SCIx_ERI_IRQ] = {
         |          ^~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1853:10: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1853:9: warning: braces around scalar initializer
    1853 |         [SCIx_ERI_IRQ] = {
         |         ^
   drivers/tty/serial/sh-sci.c:1853:9: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1854:17: error: field name not in record or union initializer
    1854 |                 .desc = "rx err",
         |                 ^
   drivers/tty/serial/sh-sci.c:1854:17: note: (near initialization for 'sci_irq_desc')
>> drivers/tty/serial/sh-sci.c:1854:25: error: initialization of 'const struct sci_irq_desc *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
    1854 |                 .desc = "rx err",
         |                         ^~~~~~~~
   drivers/tty/serial/sh-sci.c:1854:25: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1855:17: error: field name not in record or union initializer
    1855 |                 .handler = sci_er_interrupt,
         |                 ^
   drivers/tty/serial/sh-sci.c:1855:17: note: (near initialization for 'sci_irq_desc')
>> drivers/tty/serial/sh-sci.c:1855:28: error: 'sci_er_interrupt' undeclared (first use in this function); did you mean 'hrtimer_interrupt'?
    1855 |                 .handler = sci_er_interrupt,
         |                            ^~~~~~~~~~~~~~~~
         |                            hrtimer_interrupt
   drivers/tty/serial/sh-sci.c:1855:28: warning: excess elements in scalar initializer
   drivers/tty/serial/sh-sci.c:1855:28: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1858:10: error: array index in non-array initializer
    1858 |         [SCIx_RXI_IRQ] = {
         |          ^~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1858:10: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1858:9: warning: braces around scalar initializer
    1858 |         [SCIx_RXI_IRQ] = {
         |         ^
   drivers/tty/serial/sh-sci.c:1858:9: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1859:17: error: field name not in record or union initializer
    1859 |                 .desc = "rx full",
         |                 ^
   drivers/tty/serial/sh-sci.c:1859:17: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1859:25: error: initialization of 'const struct sci_irq_desc *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
    1859 |                 .desc = "rx full",
         |                         ^~~~~~~~~
   drivers/tty/serial/sh-sci.c:1859:25: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1860:17: error: field name not in record or union initializer
    1860 |                 .handler = sci_rx_interrupt,
         |                 ^
   drivers/tty/serial/sh-sci.c:1860:17: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1860:28: error: 'sci_rx_interrupt' undeclared (first use in this function); did you mean 'in_interrupt'?
    1860 |                 .handler = sci_rx_interrupt,
         |                            ^~~~~~~~~~~~~~~~
         |                            in_interrupt
   drivers/tty/serial/sh-sci.c:1860:28: warning: excess elements in scalar initializer
   drivers/tty/serial/sh-sci.c:1860:28: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1858:26: warning: excess elements in scalar initializer
    1858 |         [SCIx_RXI_IRQ] = {
         |                          ^
   drivers/tty/serial/sh-sci.c:1858:26: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1863:10: error: array index in non-array initializer
    1863 |         [SCIx_TXI_IRQ] = {
         |          ^~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1863:10: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1863:9: warning: braces around scalar initializer
    1863 |         [SCIx_TXI_IRQ] = {
         |         ^
   drivers/tty/serial/sh-sci.c:1863:9: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1864:17: error: field name not in record or union initializer
    1864 |                 .desc = "tx empty",
         |                 ^
   drivers/tty/serial/sh-sci.c:1864:17: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1864:25: error: initialization of 'const struct sci_irq_desc *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
    1864 |                 .desc = "tx empty",
         |                         ^~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1864:25: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1865:17: error: field name not in record or union initializer
    1865 |                 .handler = sci_tx_interrupt,
         |                 ^
   drivers/tty/serial/sh-sci.c:1865:17: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1865:28: error: 'sci_tx_interrupt' undeclared (first use in this function); did you mean 'note_interrupt'?
    1865 |                 .handler = sci_tx_interrupt,
         |                            ^~~~~~~~~~~~~~~~
         |                            note_interrupt
   drivers/tty/serial/sh-sci.c:1865:28: warning: excess elements in scalar initializer
   drivers/tty/serial/sh-sci.c:1865:28: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1863:26: warning: excess elements in scalar initializer
    1863 |         [SCIx_TXI_IRQ] = {
         |                          ^
   drivers/tty/serial/sh-sci.c:1863:26: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1868:10: error: array index in non-array initializer
    1868 |         [SCIx_BRI_IRQ] = {
         |          ^~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1868:10: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1868:9: warning: braces around scalar initializer
    1868 |         [SCIx_BRI_IRQ] = {
         |         ^
   drivers/tty/serial/sh-sci.c:1868:9: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1869:17: error: field name not in record or union initializer
    1869 |                 .desc = "break",
         |                 ^
   drivers/tty/serial/sh-sci.c:1869:17: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1869:25: error: initialization of 'const struct sci_irq_desc *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
    1869 |                 .desc = "break",
         |                         ^~~~~~~
   drivers/tty/serial/sh-sci.c:1869:25: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1870:17: error: field name not in record or union initializer
    1870 |                 .handler = sci_br_interrupt,
         |                 ^
   drivers/tty/serial/sh-sci.c:1870:17: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1870:28: error: 'sci_br_interrupt' undeclared (first use in this function); did you mean 'hrtimer_interrupt'?
    1870 |                 .handler = sci_br_interrupt,
         |                            ^~~~~~~~~~~~~~~~
         |                            hrtimer_interrupt
   drivers/tty/serial/sh-sci.c:1870:28: warning: excess elements in scalar initializer
   drivers/tty/serial/sh-sci.c:1870:28: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1868:26: warning: excess elements in scalar initializer
    1868 |         [SCIx_BRI_IRQ] = {
         |                          ^
   drivers/tty/serial/sh-sci.c:1868:26: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1873:10: error: array index in non-array initializer
    1873 |         [SCIx_DRI_IRQ] = {
         |          ^~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1873:10: note: (near initialization for 'sci_irq_desc')
   drivers/tty/serial/sh-sci.c:1873:9: warning: braces around scalar initializer


vim +171 drivers/tty/serial/serial_mctrl_gpio.h

9978c2f14f20a1a Erwan Le Ray 2022-02-03  170  
9978c2f14f20a1a Erwan Le Ray 2022-02-03 @171  static inline void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
cbd9dc8cc7a7ad1 Russell King 2016-09-24  172  =======
cbd9dc8cc7a7ad1 Russell King 2016-09-24  173  static inline int mctrl_gpio_enable_wake(struct mctrl_gpios *gpios,
cbd9dc8cc7a7ad1 Russell King 2016-09-24  174  					 enum mctrl_gpio_idx gidx)
cbd9dc8cc7a7ad1 Russell King 2016-09-24  175  {
cbd9dc8cc7a7ad1 Russell King 2016-09-24  176  	return 0;
cbd9dc8cc7a7ad1 Russell King 2016-09-24  177  }
cbd9dc8cc7a7ad1 Russell King 2016-09-24  178  

:::::: The code at line 171 was first introduced by commit
:::::: 9978c2f14f20a1aaea3840c16220ef64e4ad1872 serial: mctrl_gpio: add a new API to enable / disable wake_irq

:::::: TO: Erwan Le Ray <erwan.leray@foss.st.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
