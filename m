Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706CC589763
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiHDFpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiHDFpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:45:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632CE632F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659591942; x=1691127942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D9Xggl4Q3oUk86c7rr85/U1knfF4IPhWXZjXvFVYXLU=;
  b=Rx8eyeVm2LV6Um1CJ6DwXu5SOxKa0hcc3PIZS8WMudcKvFB5JwGBIxrl
   i8K74exDKIiJURJGUuEJu0D/K/5LFV1+9hsiD+SjJN3W6MMXghKMRb3I9
   VayJl66o9PVVMozf20ctDO8JdAsJY2jdgZlX3lO/DgmpvljfHSkTy+86E
   gjKCULu4t0thctCiFUUdpjwV+Q7KXZkzP3J/VBcVRm/memkHq2hnN0iim
   Xjj4BeL/H9iE14Rz56qRHyoLraxINX4ciczL2JPRCEWxXEL3k6Q85sRee
   eTTdL7zIvE8q4CQMhFw738DT+Iiji8aeaSAymlJOVCGqE36zrvom6ntI3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="376145248"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="376145248"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="635961927"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2022 22:45:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJTfv-000I3z-1f;
        Thu, 04 Aug 2022 05:45:39 +0000
Date:   Thu, 4 Aug 2022 13:45:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 26/51] drivers/tty/serial/8250/8250_port.c:340:17:
 error: storage class specified for parameter 'au_io_in_map'
Message-ID: <202208041344.sS9BSIaI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="raa+JQ7iFO3IWhg4"
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raa+JQ7iFO3IWhg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   2e73962c8797ccdf52841ea3065779839ac60e0e
commit: cbd9dc8cc7a7ad1790670c6652520fa866a9c72d [26/51] tty: serial_mctrl_gpio: add wakeup support for serial control gpios
config: mips-vocore2_defconfig
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout cbd9dc8cc7a7ad1790670c6652520fa866a9c72d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

         |         ^
   drivers/tty/serial/8250/8250_port.c:310:9: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:311:17: error: field name not in record or union initializer
     311 |                 .name           = "ASPEED VUART",
         |                 ^
   drivers/tty/serial/8250/8250_port.c:311:17: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:311:35: error: initialization of 'const struct serial8250_config *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
     311 |                 .name           = "ASPEED VUART",
         |                                   ^~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:311:35: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:312:17: error: field name not in record or union initializer
     312 |                 .fifo_size      = 16,
         |                 ^
   drivers/tty/serial/8250/8250_port.c:312:17: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:312:35: warning: excess elements in scalar initializer
     312 |                 .fifo_size      = 16,
         |                                   ^~
   drivers/tty/serial/8250/8250_port.c:312:35: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:313:17: error: field name not in record or union initializer
     313 |                 .tx_loadsz      = 16,
         |                 ^
   drivers/tty/serial/8250/8250_port.c:313:17: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:313:35: warning: excess elements in scalar initializer
     313 |                 .tx_loadsz      = 16,
         |                                   ^~
   drivers/tty/serial/8250/8250_port.c:313:35: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:314:17: error: field name not in record or union initializer
     314 |                 .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
         |                 ^
   drivers/tty/serial/8250/8250_port.c:314:17: note: (near initialization for 'uart_config')
   include/uapi/linux/serial_reg.h:49:33: warning: excess elements in scalar initializer
      49 | #define UART_FCR_ENABLE_FIFO    0x01 /* Enable the FIFO */
         |                                 ^~~~
   drivers/tty/serial/8250/8250_port.c:314:35: note: in expansion of macro 'UART_FCR_ENABLE_FIFO'
     314 |                 .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
         |                                   ^~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/serial_reg.h:49:33: note: (near initialization for 'uart_config')
      49 | #define UART_FCR_ENABLE_FIFO    0x01 /* Enable the FIFO */
         |                                 ^~~~
   drivers/tty/serial/8250/8250_port.c:314:35: note: in expansion of macro 'UART_FCR_ENABLE_FIFO'
     314 |                 .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
         |                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:315:17: error: field name not in record or union initializer
     315 |                 .rxtrig_bytes   = {1, 4, 8, 14},
         |                 ^
   drivers/tty/serial/8250/8250_port.c:315:17: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:315:17: warning: braces around scalar initializer
   drivers/tty/serial/8250/8250_port.c:315:17: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:315:36: warning: initialization of 'const struct serial8250_config *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     315 |                 .rxtrig_bytes   = {1, 4, 8, 14},
         |                                    ^
   drivers/tty/serial/8250/8250_port.c:315:36: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:315:39: warning: excess elements in scalar initializer
     315 |                 .rxtrig_bytes   = {1, 4, 8, 14},
         |                                       ^
   drivers/tty/serial/8250/8250_port.c:315:39: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:315:42: warning: excess elements in scalar initializer
     315 |                 .rxtrig_bytes   = {1, 4, 8, 14},
         |                                          ^
   drivers/tty/serial/8250/8250_port.c:315:42: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:315:45: warning: excess elements in scalar initializer
     315 |                 .rxtrig_bytes   = {1, 4, 8, 14},
         |                                             ^~
   drivers/tty/serial/8250/8250_port.c:315:45: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:315:35: warning: excess elements in scalar initializer
     315 |                 .rxtrig_bytes   = {1, 4, 8, 14},
         |                                   ^
   drivers/tty/serial/8250/8250_port.c:315:35: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:316:17: error: field name not in record or union initializer
     316 |                 .flags          = UART_CAP_FIFO,
         |                 ^
   drivers/tty/serial/8250/8250_port.c:316:17: note: (near initialization for 'uart_config')
   include/vdso/bits.h:7:33: warning: excess elements in scalar initializer
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                 ^
   drivers/tty/serial/8250/8250.h:76:25: note: in expansion of macro 'BIT'
      76 | #define UART_CAP_FIFO   BIT(8)  /* UART has FIFO */
         |                         ^~~
   drivers/tty/serial/8250/8250_port.c:316:35: note: in expansion of macro 'UART_CAP_FIFO'
     316 |                 .flags          = UART_CAP_FIFO,
         |                                   ^~~~~~~~~~~~~
   include/vdso/bits.h:7:33: note: (near initialization for 'uart_config')
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                 ^
   drivers/tty/serial/8250/8250.h:76:25: note: in expansion of macro 'BIT'
      76 | #define UART_CAP_FIFO   BIT(8)  /* UART has FIFO */
         |                         ^~~
   drivers/tty/serial/8250/8250_port.c:316:35: note: in expansion of macro 'UART_CAP_FIFO'
     316 |                 .flags          = UART_CAP_FIFO,
         |                                   ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:310:31: warning: excess elements in scalar initializer
     310 |         [PORT_ASPEED_VUART] = {
         |                               ^
   drivers/tty/serial/8250/8250_port.c:310:31: note: (near initialization for 'uart_config')
   drivers/tty/serial/8250/8250_port.c:322:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     322 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:332:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     332 | {
         | ^
>> drivers/tty/serial/8250/8250_port.c:340:17: error: storage class specified for parameter 'au_io_in_map'
     340 | static const s8 au_io_in_map[8] = {
         |                 ^~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_port.c:340:1: error: parameter 'au_io_in_map' is initialized
     340 | static const s8 au_io_in_map[8] = {
         | ^~~~~~
   drivers/tty/serial/8250/8250_port.c:342:10: warning: excess elements in scalar initializer
     342 |          2,     /* UART_IER */
         |          ^
   drivers/tty/serial/8250/8250_port.c:342:10: note: (near initialization for 'au_io_in_map')
   drivers/tty/serial/8250/8250_port.c:343:10: warning: excess elements in scalar initializer
     343 |          3,     /* UART_IIR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:343:10: note: (near initialization for 'au_io_in_map')
   drivers/tty/serial/8250/8250_port.c:344:10: warning: excess elements in scalar initializer
     344 |          5,     /* UART_LCR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:344:10: note: (near initialization for 'au_io_in_map')
   drivers/tty/serial/8250/8250_port.c:345:10: warning: excess elements in scalar initializer
     345 |          6,     /* UART_MCR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:345:10: note: (near initialization for 'au_io_in_map')
   drivers/tty/serial/8250/8250_port.c:346:10: warning: excess elements in scalar initializer
     346 |          7,     /* UART_LSR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:346:10: note: (near initialization for 'au_io_in_map')
   drivers/tty/serial/8250/8250_port.c:347:10: warning: excess elements in scalar initializer
     347 |          8,     /* UART_MSR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:347:10: note: (near initialization for 'au_io_in_map')
   drivers/tty/serial/8250/8250_port.c:348:9: warning: excess elements in scalar initializer
     348 |         -1,     /* UART_SCR (unmapped) */
         |         ^
   drivers/tty/serial/8250/8250_port.c:348:9: note: (near initialization for 'au_io_in_map')
>> drivers/tty/serial/8250/8250_port.c:351:17: error: storage class specified for parameter 'au_io_out_map'
     351 | static const s8 au_io_out_map[8] = {
         |                 ^~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_port.c:351:1: error: parameter 'au_io_out_map' is initialized
     351 | static const s8 au_io_out_map[8] = {
         | ^~~~~~
>> drivers/tty/serial/8250/8250_port.c:352:10: warning: initialization of 'const s8 *' {aka 'const signed char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     352 |          1,     /* UART_TX  */
         |          ^
   drivers/tty/serial/8250/8250_port.c:352:10: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:353:10: warning: excess elements in scalar initializer
     353 |          2,     /* UART_IER */
         |          ^
   drivers/tty/serial/8250/8250_port.c:353:10: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:354:10: warning: excess elements in scalar initializer
     354 |          4,     /* UART_FCR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:354:10: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:355:10: warning: excess elements in scalar initializer
     355 |          5,     /* UART_LCR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:355:10: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:356:10: warning: excess elements in scalar initializer
     356 |          6,     /* UART_MCR */
         |          ^
   drivers/tty/serial/8250/8250_port.c:356:10: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:357:9: warning: excess elements in scalar initializer
     357 |         -1,     /* UART_LSR (unmapped) */
         |         ^
   drivers/tty/serial/8250/8250_port.c:357:9: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:358:9: warning: excess elements in scalar initializer
     358 |         -1,     /* UART_MSR (unmapped) */
         |         ^
   drivers/tty/serial/8250/8250_port.c:358:9: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:359:9: warning: excess elements in scalar initializer
     359 |         -1,     /* UART_SCR (unmapped) */
         |         ^
   drivers/tty/serial/8250/8250_port.c:359:9: note: (near initialization for 'au_io_out_map')
   drivers/tty/serial/8250/8250_port.c:363:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     363 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:373:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     373 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:384:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     384 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:389:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     389 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:396:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     396 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:403:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     403 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:410:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     410 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:416:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     416 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:422:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     422 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:428:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     428 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:434:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     434 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:440:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     440 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:446:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     446 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:452:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     452 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:458:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     458 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:464:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     464 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:469:12: error: storage class specified for parameter 'serial8250_default_handle_irq'
     469 | static int serial8250_default_handle_irq(struct uart_port *port);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:472:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     472 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:525:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     525 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:544:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     544 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:553:29: error: storage class specified for parameter 'serial8250_em485_handle_start_tx'
     553 | static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:554:29: error: storage class specified for parameter 'serial8250_em485_handle_stop_tx'
     554 | static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:557:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     557 | {
         | ^
>> drivers/tty/serial/8250/8250_port.c:561:53: error: expected declaration specifiers before ';' token
     561 | EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
         |                                                     ^
   drivers/tty/serial/8250/8250_port.c:564:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     564 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:569:38: error: expected declaration specifiers before ';' token
     569 | EXPORT_SYMBOL_GPL(serial8250_rpm_get);
         |                                      ^
   drivers/tty/serial/8250/8250_port.c:572:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     572 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:578:38: error: expected declaration specifiers before ';' token
     578 | EXPORT_SYMBOL_GPL(serial8250_rpm_put);
         |                                      ^
   drivers/tty/serial/8250/8250_port.c:601:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     601 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:638:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     638 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:648:44: error: expected declaration specifiers before ';' token
     648 | EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
         |                                            ^
   drivers/tty/serial/8250/8250_port.c:660:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     660 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:697:43: error: expected declaration specifiers before ';' token
     697 | EXPORT_SYMBOL_GPL(serial8250_em485_config);
         |                                           ^
   drivers/tty/serial/8250/8250_port.c:705:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     705 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:716:41: error: expected declaration specifiers before ';' token
     716 | EXPORT_SYMBOL_GPL(serial8250_rpm_get_tx);
         |                                         ^
   drivers/tty/serial/8250/8250_port.c:719:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     719 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:731:41: error: expected declaration specifiers before ';' token
     731 | EXPORT_SYMBOL_GPL(serial8250_rpm_put_tx);
         |                                         ^
   drivers/tty/serial/8250/8250_port.c:739:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     739 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:837:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     837 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:874:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     874 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:901:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     901 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:989:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     989 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1006:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1006 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1025:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1025 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1191:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1191 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1364:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1364 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1419:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1419 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1438:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1438 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1459:44: error: expected declaration specifiers before ';' token
    1459 | EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
         |                                            ^
   drivers/tty/serial/8250/8250_port.c:1462:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1462 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1482:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1482 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1487:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1487 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1507:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1507 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1513:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1513 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1551:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1551 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1568:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1568 | {
         | ^
   drivers/tty/serial/8250/8250_port.c:1605:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1605 | {


vim +/au_io_in_map +340 drivers/tty/serial/8250/8250_port.c

b6830f6df8914f Peter Hurley 2015-06-27  338  
b6830f6df8914f Peter Hurley 2015-06-27  339  /* Au1x00/RT288x UART hardware has a weird register layout */
b6830f6df8914f Peter Hurley 2015-06-27 @340  static const s8 au_io_in_map[8] = {
b6830f6df8914f Peter Hurley 2015-06-27  341  	 0,	/* UART_RX  */
b6830f6df8914f Peter Hurley 2015-06-27  342  	 2,	/* UART_IER */
b6830f6df8914f Peter Hurley 2015-06-27  343  	 3,	/* UART_IIR */
b6830f6df8914f Peter Hurley 2015-06-27  344  	 5,	/* UART_LCR */
b6830f6df8914f Peter Hurley 2015-06-27  345  	 6,	/* UART_MCR */
b6830f6df8914f Peter Hurley 2015-06-27  346  	 7,	/* UART_LSR */
b6830f6df8914f Peter Hurley 2015-06-27  347  	 8,	/* UART_MSR */
b6830f6df8914f Peter Hurley 2015-06-27  348  	-1,	/* UART_SCR (unmapped) */
b6830f6df8914f Peter Hurley 2015-06-27  349  };
b6830f6df8914f Peter Hurley 2015-06-27  350  
b6830f6df8914f Peter Hurley 2015-06-27 @351  static const s8 au_io_out_map[8] = {
b6830f6df8914f Peter Hurley 2015-06-27 @352  	 1,	/* UART_TX  */
b6830f6df8914f Peter Hurley 2015-06-27  353  	 2,	/* UART_IER */
b6830f6df8914f Peter Hurley 2015-06-27  354  	 4,	/* UART_FCR */
b6830f6df8914f Peter Hurley 2015-06-27  355  	 5,	/* UART_LCR */
b6830f6df8914f Peter Hurley 2015-06-27  356  	 6,	/* UART_MCR */
b6830f6df8914f Peter Hurley 2015-06-27  357  	-1,	/* UART_LSR (unmapped) */
b6830f6df8914f Peter Hurley 2015-06-27  358  	-1,	/* UART_MSR (unmapped) */
b6830f6df8914f Peter Hurley 2015-06-27  359  	-1,	/* UART_SCR (unmapped) */
b6830f6df8914f Peter Hurley 2015-06-27  360  };
b6830f6df8914f Peter Hurley 2015-06-27  361  

:::::: The code at line 340 was first introduced by commit
:::::: b6830f6df8914faae9561bb245860c21af9b9e9b serial: 8250: Split base port operations from universal driver

:::::: TO: Peter Hurley <peter@hurleysoftware.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--raa+JQ7iFO3IWhg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/mips 5.19.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="mipsel-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
# CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_KCMP is not set
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
# end of General setup

CONFIG_MIPS=y

#
# Machine selection
#
# CONFIG_MIPS_GENERIC_KERNEL is not set
# CONFIG_MIPS_ALCHEMY is not set
# CONFIG_AR7 is not set
# CONFIG_ATH25 is not set
# CONFIG_ATH79 is not set
# CONFIG_BMIPS_GENERIC is not set
# CONFIG_BCM47XX is not set
# CONFIG_BCM63XX is not set
# CONFIG_MIPS_COBALT is not set
# CONFIG_MACH_DECSTATION is not set
# CONFIG_MACH_JAZZ is not set
# CONFIG_MACH_INGENIC_SOC is not set
# CONFIG_LANTIQ is not set
# CONFIG_MACH_LOONGSON32 is not set
# CONFIG_MACH_LOONGSON2EF is not set
# CONFIG_MACH_LOONGSON64 is not set
# CONFIG_MIPS_MALTA is not set
# CONFIG_MACH_PIC32 is not set
# CONFIG_MACH_VR41XX is not set
# CONFIG_MACH_NINTENDO64 is not set
CONFIG_RALINK=y
# CONFIG_MACH_REALTEK_RTL is not set
# CONFIG_SGI_IP22 is not set
# CONFIG_SGI_IP27 is not set
# CONFIG_SGI_IP28 is not set
# CONFIG_SGI_IP30 is not set
# CONFIG_SGI_IP32 is not set
# CONFIG_SIBYTE_CRHINE is not set
# CONFIG_SIBYTE_CARMEL is not set
# CONFIG_SIBYTE_CRHONE is not set
# CONFIG_SIBYTE_RHONE is not set
# CONFIG_SIBYTE_SWARM is not set
# CONFIG_SIBYTE_LITTLESUR is not set
# CONFIG_SIBYTE_SENTOSA is not set
# CONFIG_SIBYTE_BIGSUR is not set
# CONFIG_SNI_RM is not set
# CONFIG_MACH_TX49XX is not set
# CONFIG_MIKROTIK_RB532 is not set
# CONFIG_CAVIUM_OCTEON_SOC is not set
CONFIG_CLKEVT_RT3352=y
CONFIG_IRQ_INTC=y
# CONFIG_SOC_RT288X is not set
# CONFIG_SOC_RT305X is not set
# CONFIG_SOC_RT3883 is not set
CONFIG_SOC_MT7620=y
# CONFIG_SOC_MT7621 is not set
# CONFIG_DTB_RT_NONE is not set
# CONFIG_DTB_MT7620A_EVAL is not set
# CONFIG_DTB_OMEGA2P is not set
CONFIG_DTB_VOCORE2=y
# end of Machine selection

CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_BOOT_RAW=y
CONFIG_CEVT_R4K=y
CONFIG_CSRC_R4K=y
CONFIG_MIPS_CLOCK_VSYSCALL=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_DMA_NONCOHERENT=y
CONFIG_SYS_HAS_EARLY_PRINTK=y
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
CONFIG_MIPS_SPRAM=y
CONFIG_MIPS_L1_CACHE_SHIFT=5

#
# CPU selection
#
# CONFIG_CPU_MIPS32_R1 is not set
CONFIG_CPU_MIPS32_R2=y
CONFIG_SYS_SUPPORTS_ZBOOT=y
CONFIG_SYS_HAS_CPU_MIPS32_R1=y
CONFIG_SYS_HAS_CPU_MIPS32_R2=y
# end of CPU selection

CONFIG_CPU_MIPS32=y
CONFIG_CPU_MIPSR2=y
CONFIG_TARGET_ISA_REV=2
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
CONFIG_HARDWARE_WATCHPOINTS=y

#
# Kernel type
#
CONFIG_32BIT=y
CONFIG_ZBOOT_LOAD_ADDRESS=0x0
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_CPU_GENERIC_DUMP_TLB=y
CONFIG_MIPS_FP_SUPPORT=y
CONFIG_CPU_R4K_FPU=y
CONFIG_CPU_R4K_CACHE_TLB=y
CONFIG_CPU_NEEDS_NO_SMARTMIPS_OR_MICROMIPS=y
CONFIG_CPU_HAS_DIEI=y
CONFIG_CPU_HAS_RIXI=y
CONFIG_CPU_MIPSR2_IRQ_VI=y
CONFIG_CPU_HAS_SYNC=y
CONFIG_MIPS_ASID_SHIFT=0
CONFIG_MIPS_ASID_BITS=8
CONFIG_CPU_SUPPORTS_HIGHMEM=y
CONFIG_SYS_SUPPORTS_MIPS16=y
CONFIG_CPU_SUPPORTS_MSA=y
CONFIG_ARCH_FLATMEM_ENABLE=y
# CONFIG_HZ_24 is not set
# CONFIG_HZ_48 is not set
CONFIG_HZ_100=y
# CONFIG_HZ_128 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_256 is not set
# CONFIG_HZ_1000 is not set
# CONFIG_HZ_1024 is not set
CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_MIPS_O32_FP64_SUPPORT is not set
CONFIG_USE_OF=y
CONFIG_BUILTIN_DTB=y
CONFIG_MIPS_NO_APPENDED_DTB=y
# CONFIG_MIPS_ELF_APPENDED_DTB is not set
# CONFIG_MIPS_RAW_APPENDED_DTB is not set
# CONFIG_MIPS_CMDLINE_FROM_DTB is not set
# CONFIG_MIPS_CMDLINE_DTB_EXTEND is not set
CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
# end of Kernel type

CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_PGTABLE_LEVELS=2

#
# Bus options (PCI, PCMCIA, EISA, ISA, TC)
#
CONFIG_PCI_DRIVERS_LEGACY=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=15
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=15
# end of Bus options (PCI, PCMCIA, EISA, ISA, TC)

CONFIG_TRAD_SIGNALS=y
CONFIG_CC_HAS_MNO_BRANCH_LIKELY=y

#
# Power management options
#
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
# end of Power management options

#
# CPU Power Management
#

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of CPU Power Management

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_MIPS_LD_CAN_LINK_VDSO=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
# CONFIG_JUMP_LABEL is not set
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_DMA_SET_UNCACHED=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_TIF_NOHZ=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_COMPILER_H=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_HAVE_SPARSE_SYSCALL_NR=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ARCH_BINFMT_ELF_STATE=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_FLATMEM=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CMA is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
CONFIG_MPTCP=y
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
# CONFIG_WIRELESS is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
# CONFIG_PCI is not set
# CONFIG_PCCARD is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
# CONFIG_FW_LOADER is not set
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_MMIO=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_BRCMSTB_GISB_ARB is not set
# CONFIG_MIPS_CDMM is not set
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_RBD is not set

#
# NVME Support
#
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_SRAM is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ETHERNET is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=2
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=3
CONFIG_SERIAL_8250_RUNTIME_UARTS=3
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_INGENIC is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NULL_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
CONFIG_DEVMEM=y
# CONFIG_TCG_TPM is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
# CONFIG_I2C is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TQMX86 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_DW is not set
# CONFIG_MMC_JZ4740 is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_MIPS_PLATFORM_DEVICES=y
# CONFIG_GOLDFISH is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_COMMON_CLK_BOSTON is not set

#
# Ingenic SoCs drivers
#
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_INGENIC_TIMER is not set
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
CONFIG_MEMORY=y
# CONFIG_JZ4780_NEMC is not set
# CONFIG_IIO is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_IRQ_MIPS_CPU=y
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_ARCH_HAS_RESET_CONTROLLER=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_INGENIC_USB is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_MT7621_PCI is not set
CONFIG_PHY_RALINK_USB=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set
# CONFIG_RAS is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_DAX is not set
# CONFIG_NVMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_MIPS is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA_MIPS is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_JITTERENTROPY is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set

#
# Certificates for signature checking
#
# end of Certificates for signature checking

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_ARCH_HAS_STRNCPY_FROM_USER=y
CONFIG_ARCH_HAS_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_NO_GENERIC_PCI_IOPORT_MAP=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=2
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC64_ROCKSOFT is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_HAS_DMA_WRITE_COMBINE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
CONFIG_DMA_NONCOHERENT_MMAP=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
# CONFIG_IRQ_POLL is not set
CONFIG_LIBFDT=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=10
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# mips Debugging
#
CONFIG_EARLY_PRINTK=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_DEBUG_ZBOOT is not set
# CONFIG_SPINLOCK_TEST is not set
# CONFIG_SCACHE_DEBUGFS is not set
# end of mips Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--raa+JQ7iFO3IWhg4--
