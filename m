Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8956BB49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiGHNz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiGHNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:55:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5960B2A701
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657288554; x=1688824554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7vfL1tkg9GNLi/FrDF86Q196uqR6/WOkcm3m0Uop1KU=;
  b=IRLuWIshdAC3W7foqMwqoYGnhbAhHErXahMvG+mT+9UIa2uRkW4qW8bx
   3CsK3byAaF60s39MBb9nYJKJA4m4CxsJJ33bpwfy5WrRIeqPmplAbTLBo
   2ycbQKC4KgmR8PQgiU6aB03LQtSuyI/g8pZF4XOfqM4G+s8gteOXe3Qjy
   QtysqNtUhbW8e4NQ4kFhzJxNyaadJZIIcycPsneuZZEDfTcivSmpJuCFy
   EZAp0K06gBIbirMpnVV/GlxVGihooT/LKTRH86/aM31vmaUR7wsC9KW0S
   aUNe3whQAq53HFlaDkjjI+aLOdfBCPkc1QEnrH6oJvmvT6MAEokKQZWqs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284306221"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="284306221"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 06:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="921002610"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 06:55:52 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9oSV-000NYI-Du;
        Fri, 08 Jul 2022 13:55:51 +0000
Date:   Fri, 8 Jul 2022 21:55:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in
 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal
 fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr,
 consider reordering the fields or adding explicit...
Message-ID: <202207082123.mUdLb6eW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: ec679bda639fe84b78d473526ae27c74dea383fb spi: bcm2835: Allow arbitrary number of slaves
date:   1 year, 1 month ago
config: arm-randconfig-c002-20220702 (https://download.01.org/0day-ci/archive/20220708/202207082123.mUdLb6eW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec679bda639fe84b78d473526ae27c74dea383fb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ec679bda639fe84b78d473526ae27c74dea383fb
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
                                       ^
   include/linux/i2c.h:344:26: note: expanded from macro 'to_i2c_client'
   #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
                            ^
   include/linux/kernel.h:704:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:308:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   drivers/iio/chemical/scd30_i2c.c:41:30: note: Loop condition is false.  Exiting loop
           struct i2c_client *client = to_i2c_client(state->dev);
                                       ^
   include/linux/i2c.h:344:26: note: expanded from macro 'to_i2c_client'
   #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
                            ^
   include/linux/kernel.h:704:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:306:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   drivers/iio/chemical/scd30_i2c.c:49:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   drivers/iio/chemical/scd30_i2c.c:49:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/iio/chemical/scd30_i2c.c:51:6: note: Assuming 'ret' is equal to 'txsize'
           if (ret != txsize)
               ^~~~~~~~~~~~~
   drivers/iio/chemical/scd30_i2c.c:51:2: note: Taking false branch
           if (ret != txsize)
           ^
   drivers/iio/chemical/scd30_i2c.c:54:7: note: 'rxbuf' is non-null
           if (!rxbuf)
                ^~~~~
   drivers/iio/chemical/scd30_i2c.c:54:2: note: Taking false branch
           if (!rxbuf)
           ^
   drivers/iio/chemical/scd30_i2c.c:58:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   drivers/iio/chemical/scd30_i2c.c:58:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/iio/chemical/scd30_i2c.c:60:6: note: Assuming 'ret' is equal to 'rxsize'
           if (ret != rxsize)
               ^~~~~~~~~~~~~
   drivers/iio/chemical/scd30_i2c.c:60:2: note: Taking false branch
           if (ret != rxsize)
           ^
   drivers/iio/chemical/scd30_i2c.c:63:2: note: Returning zero, which participates in a condition later
           return 0;
           ^~~~~~~~
   drivers/iio/chemical/scd30_i2c.c:92:8: note: Returning from 'scd30_i2c_xfer'
           ret = scd30_i2c_xfer(state, buf, i, buf, size);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/chemical/scd30_i2c.c:93:6: note: 'ret' is 0
           if (ret)
               ^~~
   drivers/iio/chemical/scd30_i2c.c:93:2: note: Taking false branch
           if (ret)
           ^
   drivers/iio/chemical/scd30_i2c.c:97:14: note: Assuming 'i' is < 'size'
           for (i = 0; i < size; i += 3) {
                       ^~~~~~~~
   drivers/iio/chemical/scd30_i2c.c:97:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < size; i += 3) {
           ^
   drivers/iio/chemical/scd30_i2c.c:99:7: note: Assuming the condition is false
                   if (crc != buf[i + 2]) {
                       ^~~~~~~~~~~~~~~~~
   drivers/iio/chemical/scd30_i2c.c:99:3: note: Taking false branch
                   if (crc != buf[i + 2]) {
                   ^
   drivers/iio/chemical/scd30_i2c.c:104:10: note: Dereference of null pointer
                   *rsp++ = buf[i];
                   ~~~~~~~^~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:153:8: note: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1164:20: warning: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx') [clang-analyzer-core.NullDereference]
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Calling 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:675:2: note: Returning without writing to 'ctlr->dma_rx'
           return dev_get_drvdata(&ctlr->dev);
           ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Returning from 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1219:6: note: Assuming 'slv' is non-null
           if (!slv) {
               ^~~~
   drivers/spi/spi-bcm2835.c:1219:2: note: Taking false branch
           if (!slv) {
           ^
   drivers/spi/spi-bcm2835.c:1239:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPOL)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1239:2: note: Taking false branch
           if (spi->mode & SPI_CPOL)
           ^
   drivers/spi/spi-bcm2835.c:1241:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPHA)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1241:2: note: Taking false branch
           if (spi->mode & SPI_CPHA)
           ^
   drivers/spi/spi-bcm2835.c:1249:6: note: Assuming field 'dma_rx' is null
           if (ctlr->dma_rx) {
               ^~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1249:2: note: Taking false branch
           if (ctlr->dma_rx) {
           ^
   drivers/spi/spi-bcm2835.c:1262:6: note: Assuming the condition is false
           if (spi->mode & SPI_NO_CS)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1262:2: note: Taking false branch
           if (spi->mode & SPI_NO_CS)
           ^
   drivers/spi/spi-bcm2835.c:1268:6: note: Assuming field 'cs_gpiod' is null
           if (spi->cs_gpiod)
               ^~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1268:2: note: Taking false branch
           if (spi->cs_gpiod)
           ^
   drivers/spi/spi-bcm2835.c:1270:6: note: Assuming field 'chip_select' is <= 1
           if (spi->chip_select > 1) {
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1270:2: note: Taking false branch
           if (spi->chip_select > 1) {
           ^
   drivers/spi/spi-bcm2835.c:1292:6: note: Assuming 'chip' is non-null
           if (!chip)
               ^~~~~
   drivers/spi/spi-bcm2835.c:1292:2: note: Taking false branch
           if (!chip)
           ^
   drivers/spi/spi-bcm2835.c:1299:2: note: Taking true branch
           if (IS_ERR(spi->cs_gpiod)) {
           ^
   drivers/spi/spi-bcm2835.c:1301:3: note: Control jumps to line 1311
                   goto err_cleanup;
                   ^
   drivers/spi/spi-bcm2835.c:1311:2: note: Calling 'bcm2835_spi_cleanup'
           bcm2835_spi_cleanup(spi);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:6: note: Assuming field 'clear_rx_desc' is null
           if (slv->clear_rx_desc)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:2: note: Taking false branch
           if (slv->clear_rx_desc)
           ^
   drivers/spi/spi-bcm2835.c:1163:6: note: Assuming field 'clear_rx_addr' is not equal to 0
           if (slv->clear_rx_addr)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1163:2: note: Taking true branch
           if (slv->clear_rx_addr)
           ^
   drivers/spi/spi-bcm2835.c:1164:20: note: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx')
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   include/linux/dma-mapping.h:427:61: note: expanded from macro 'dma_unmap_single'
   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
                                                               ^
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
--
               ^~~~~~~
   drivers/iio/light/veml6030.c:347:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/iio/light/veml6030.c:350:6: note: Assuming 'val' is not equal to 0
           if (!val) {
               ^~~~
   drivers/iio/light/veml6030.c:350:2: note: Taking false branch
           if (!val) {
           ^
   drivers/iio/light/veml6030.c:353:8: note: Assuming 'val' is not equal to 1
                   if ((val == 1) && (val2 == 600000))
                        ^~~~~~~~
   drivers/iio/light/veml6030.c:353:18: note: Left side of '&&' is false
                   if ((val == 1) && (val2 == 600000))
                                  ^
   drivers/iio/light/veml6030.c:355:13: note: Assuming 'val' is equal to 3
                   else if ((val == 3) && (val2 == 200000))
                             ^~~~~~~~
   drivers/iio/light/veml6030.c:355:12: note: Left side of '&&' is true
                   else if ((val == 3) && (val2 == 200000))
                            ^
   drivers/iio/light/veml6030.c:355:27: note: Assuming 'val2' is equal to 200000
                   else if ((val == 3) && (val2 == 200000))
                                           ^~~~~~~~~~~~~~
   drivers/iio/light/veml6030.c:355:8: note: Taking true branch
                   else if ((val == 3) && (val2 == 200000))
                        ^
   drivers/iio/light/veml6030.c:356:21: note: The right operand of '/' is a garbage value
                           period = 3200000 / y;
                                            ^ ~
   drivers/iio/light/veml6030.c:358:21: warning: The right operand of '/' is a garbage value [clang-analyzer-core.UndefinedBinaryOperatorResult]
                           period = 6400000 / y;
                                            ^
   drivers/iio/light/veml6030.c:611:2: note: Control jumps to 'case IIO_EV_INFO_PERIOD:'  at line 614
           switch (info) {
           ^
   drivers/iio/light/veml6030.c:615:10: note: Calling 'veml6030_write_persistence'
                   return veml6030_write_persistence(indio_dev, val, val2);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/veml6030.c:343:22: note: 'y' declared without an initial value
           int ret, period, x, y;
                               ^
   drivers/iio/light/veml6030.c:346:8: note: Calling 'veml6030_get_intgrn_tm'
           ret = veml6030_get_intgrn_tm(indio_dev, &x, &y);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/veml6030.c:221:6: note: Assuming 'ret' is not equal to 0
           if (ret) {
               ^~~
   drivers/iio/light/veml6030.c:221:2: note: Taking true branch
           if (ret) {
           ^
   drivers/iio/light/veml6030.c:224:3: note: Returning without writing to '*val2'
                   return ret;
                   ^
   drivers/iio/light/veml6030.c:346:8: note: Returning from 'veml6030_get_intgrn_tm'
           ret = veml6030_get_intgrn_tm(indio_dev, &x, &y);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/veml6030.c:347:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   drivers/iio/light/veml6030.c:347:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/iio/light/veml6030.c:350:6: note: Assuming 'val' is not equal to 0
           if (!val) {
               ^~~~
   drivers/iio/light/veml6030.c:350:2: note: Taking false branch
           if (!val) {
           ^
   drivers/iio/light/veml6030.c:353:8: note: Assuming 'val' is not equal to 1
                   if ((val == 1) && (val2 == 600000))
                        ^~~~~~~~
   drivers/iio/light/veml6030.c:353:18: note: Left side of '&&' is false
                   if ((val == 1) && (val2 == 600000))
                                  ^
   drivers/iio/light/veml6030.c:355:13: note: Assuming 'val' is not equal to 3
                   else if ((val == 3) && (val2 == 200000))
                             ^~~~~~~~
   drivers/iio/light/veml6030.c:355:23: note: Left side of '&&' is false
                   else if ((val == 3) && (val2 == 200000))
                                       ^
   drivers/iio/light/veml6030.c:357:13: note: Assuming 'val' is equal to 6
                   else if ((val == 6) && (val2 == 400000))
                             ^~~~~~~~
   drivers/iio/light/veml6030.c:357:12: note: Left side of '&&' is true
                   else if ((val == 6) && (val2 == 400000))
                            ^
   drivers/iio/light/veml6030.c:357:27: note: Assuming 'val2' is equal to 400000
                   else if ((val == 6) && (val2 == 400000))
                                           ^~~~~~~~~~~~~~
   drivers/iio/light/veml6030.c:357:8: note: Taking true branch
                   else if ((val == 6) && (val2 == 400000))
                        ^
   drivers/iio/light/veml6030.c:358:21: note: The right operand of '/' is a garbage value
                           period = 6400000 / y;
                                            ^ ~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:153:8: note: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1164:20: warning: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx') [clang-analyzer-core.NullDereference]
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Calling 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:675:2: note: Returning without writing to 'ctlr->dma_rx'
           return dev_get_drvdata(&ctlr->dev);
           ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Returning from 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1219:6: note: Assuming 'slv' is non-null
           if (!slv) {
               ^~~~
   drivers/spi/spi-bcm2835.c:1219:2: note: Taking false branch
           if (!slv) {
           ^
   drivers/spi/spi-bcm2835.c:1239:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPOL)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1239:2: note: Taking false branch
           if (spi->mode & SPI_CPOL)
           ^
   drivers/spi/spi-bcm2835.c:1241:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPHA)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1241:2: note: Taking false branch
           if (spi->mode & SPI_CPHA)
           ^
   drivers/spi/spi-bcm2835.c:1249:6: note: Assuming field 'dma_rx' is null
           if (ctlr->dma_rx) {
               ^~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1249:2: note: Taking false branch
           if (ctlr->dma_rx) {
           ^
   drivers/spi/spi-bcm2835.c:1262:6: note: Assuming the condition is false
           if (spi->mode & SPI_NO_CS)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1262:2: note: Taking false branch
           if (spi->mode & SPI_NO_CS)
           ^
   drivers/spi/spi-bcm2835.c:1268:6: note: Assuming field 'cs_gpiod' is null
           if (spi->cs_gpiod)
               ^~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1268:2: note: Taking false branch
           if (spi->cs_gpiod)
           ^
   drivers/spi/spi-bcm2835.c:1270:6: note: Assuming field 'chip_select' is <= 1
           if (spi->chip_select > 1) {
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1270:2: note: Taking false branch
           if (spi->chip_select > 1) {
           ^
   drivers/spi/spi-bcm2835.c:1292:6: note: Assuming 'chip' is non-null
           if (!chip)
               ^~~~~
   drivers/spi/spi-bcm2835.c:1292:2: note: Taking false branch
           if (!chip)
           ^
   drivers/spi/spi-bcm2835.c:1299:2: note: Taking true branch
           if (IS_ERR(spi->cs_gpiod)) {
           ^
   drivers/spi/spi-bcm2835.c:1301:3: note: Control jumps to line 1311
                   goto err_cleanup;
                   ^
   drivers/spi/spi-bcm2835.c:1311:2: note: Calling 'bcm2835_spi_cleanup'
           bcm2835_spi_cleanup(spi);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:6: note: Assuming field 'clear_rx_desc' is null
           if (slv->clear_rx_desc)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:2: note: Taking false branch
           if (slv->clear_rx_desc)
           ^
   drivers/spi/spi-bcm2835.c:1163:6: note: Assuming field 'clear_rx_addr' is not equal to 0
           if (slv->clear_rx_addr)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1163:2: note: Taking true branch
           if (slv->clear_rx_addr)
           ^
   drivers/spi/spi-bcm2835.c:1164:20: note: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx')
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   include/linux/dma-mapping.h:427:61: note: expanded from macro 'dma_unmap_single'
   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
                                                               ^
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   fs/locks.c:2589:3: warning: Value stored to 'cmd' is never read [clang-analyzer-deadcode.DeadStores]
                   cmd = F_GETLK64;
                   ^
   fs/locks.c:2589:3: note: Value stored to 'cmd' is never read
   Suppressed 16 warnings (16 in non-user code).

vim +153 drivers/spi/spi-bcm2835.c

   142	
   143	/**
   144	 * struct bcm2835_spidev - BCM2835 SPI slave
   145	 * @prepare_cs: precalculated CS register value for ->prepare_message()
   146	 *	(uses slave-specific clock polarity and phase settings)
   147	 * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
   148	 *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
   149	 * @clear_rx_addr: bus address of @clear_rx_cs
   150	 * @clear_rx_cs: precalculated CS register value to clear RX FIFO
   151	 *	(uses slave-specific clock polarity and phase settings)
   152	 */
 > 153	struct bcm2835_spidev {
   154		u32 prepare_cs;
   155		struct dma_async_tx_descriptor *clear_rx_desc;
   156		dma_addr_t clear_rx_addr;
   157		u32 clear_rx_cs ____cacheline_aligned;
   158	};
   159	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
