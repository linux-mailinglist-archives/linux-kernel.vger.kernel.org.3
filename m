Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECBD581CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbiG0Aop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiG0Aoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:44:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13C3A4A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658882676; x=1690418676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oTITUALBuyF6BSzCo8DyW4ffhk3U+KWEHzlesDpDEm0=;
  b=OwEAfxLt5SOZEGfEjc+kPJTvMFVe+NEpuwXmCWdNVz3gVTvO9Sut0qsN
   Pd84a1DqxOQO3+xOGcyL/uOaYfHjGWAErNBoE6IMwbJHcwnnxuM7MX2uS
   n+vUsSTuTzJ6bK8Tn3CGcBtTTuAfVspdWModZFTON5TPwGYR26UJK4HcD
   fVGcQN8XeJxYgMHmM9QyxVouDI2kHX2rkxr4X4nxhn+gd1okvgtPNBuD4
   WdcSFr3byPZqPJBhK8VA+0w4RGr/7n9FNr5BBeo6nmtSbbXqsHkkEd56p
   SMEC9ZvlKS99uSvA4/u8y5YglRnGHhYQFvmm2VY5/rEV6Sl/nTBv4bnkz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="352105187"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="352105187"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 17:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="742450115"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2022 17:44:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGVA7-00086l-1X;
        Wed, 27 Jul 2022 00:44:31 +0000
Date:   Wed, 27 Jul 2022 08:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in
 'struct bcm2835_spidev' (48 padding bytes, where 16 is optimal). Optimal
 fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr,
 consider reordering the fields or adding explicit ...
Message-ID: <202207270819.2m20mks4-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5de64d44968e4ae66ebdb0a2d08b443f189d3651
commit: ec679bda639fe84b78d473526ae27c74dea383fb spi: bcm2835: Allow arbitrary number of slaves
date:   1 year, 2 months ago
config: arm-randconfig-c002-20220722 (https://download.01.org/0day-ci/archive/20220727/202207270819.2m20mks4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
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
               ^~~~~~~
   drivers/clocksource/sh_mtu2.c:417:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/clocksource/sh_mtu2.c:420:22: note: Assuming '__UNIQUE_ID___x183' is >= '__UNIQUE_ID___y184'
           mtu->num_channels = min_t(unsigned int, ret,
                               ^
   include/linux/minmax.h:110:27: note: expanded from macro 'min_t'
   #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:44:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:39:3: note: expanded from macro '__cmp_once'
                   __cmp(unique_x, unique_y, op); })
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:34:26: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ^~~~~~~~~~
   drivers/clocksource/sh_mtu2.c:420:22: note: '?' condition is false
           mtu->num_channels = min_t(unsigned int, ret,
                               ^
   include/linux/minmax.h:110:27: note: expanded from macro 'min_t'
   #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
                                   ^
   include/linux/minmax.h:44:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^
   include/linux/minmax.h:39:3: note: expanded from macro '__cmp_once'
                   __cmp(unique_x, unique_y, op); })
                   ^
   include/linux/minmax.h:34:26: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ^
   drivers/clocksource/sh_mtu2.c:425:6: note: Assuming field 'channels' is not equal to NULL
           if (mtu->channels == NULL) {
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/sh_mtu2.c:425:2: note: Taking false branch
           if (mtu->channels == NULL) {
           ^
   drivers/clocksource/sh_mtu2.c:430:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < mtu->num_channels; ++i) {
           ^
   drivers/clocksource/sh_mtu2.c:432:7: note: 'ret' is >= 0
                   if (ret < 0)
                       ^~~
   drivers/clocksource/sh_mtu2.c:432:3: note: Taking false branch
                   if (ret < 0)
                   ^
   drivers/clocksource/sh_mtu2.c:430:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < mtu->num_channels; ++i) {
           ^
   drivers/clocksource/sh_mtu2.c:432:7: note: 'ret' is >= 0
                   if (ret < 0)
                       ^~~
   drivers/clocksource/sh_mtu2.c:432:3: note: Taking false branch
                   if (ret < 0)
                   ^
   drivers/clocksource/sh_mtu2.c:430:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < mtu->num_channels; ++i) {
           ^
   drivers/clocksource/sh_mtu2.c:432:7: note: Assuming 'ret' is >= 0
                   if (ret < 0)
                       ^~~~~~~
   drivers/clocksource/sh_mtu2.c:432:3: note: Taking false branch
                   if (ret < 0)
                   ^
   drivers/clocksource/sh_mtu2.c:430:37: note: The value 3 is assigned to 'i'
           for (i = 0; i < mtu->num_channels; ++i) {
                                              ^~~
   drivers/clocksource/sh_mtu2.c:430:14: note: Assuming 'i' is < field 'num_channels'
           for (i = 0; i < mtu->num_channels; ++i) {
                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/sh_mtu2.c:430:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < mtu->num_channels; ++i) {
           ^
   drivers/clocksource/sh_mtu2.c:431:50: note: Passing the value 3 via 2nd parameter 'index'
                   ret = sh_mtu2_setup_channel(&mtu->channels[i], i, mtu);
                                                                  ^
   drivers/clocksource/sh_mtu2.c:431:9: note: Calling 'sh_mtu2_setup_channel'
                   ret = sh_mtu2_setup_channel(&mtu->channels[i], i, mtu);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/sh_mtu2.c:350:6: note: Assuming 'irq' is >= 0
           if (irq < 0) {
               ^~~~~~~
   drivers/clocksource/sh_mtu2.c:350:2: note: Taking false branch
           if (irq < 0) {
           ^
   drivers/clocksource/sh_mtu2.c:358:6: note: Assuming 'ret' is 0
           if (ret) {
               ^~~
   drivers/clocksource/sh_mtu2.c:358:2: note: Taking false branch
           if (ret) {
           ^
   drivers/clocksource/sh_mtu2.c:364:26: note: The right operand of '+' is a garbage value due to array index out of bounds
           ch->base = mtu->mapbase + sh_mtu2_channel_offsets[index];
                                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
>> drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in 'struct bcm2835_spidev' (48 padding bytes, where 16 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:153:8: note: Excessive padding in 'struct bcm2835_spidev' (48 padding bytes, where 16 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members
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
   2 warnings generated.
   drivers/leds/leds-pca955x.c:402:11: warning: Access to field 'name' results in a dereference of a null pointer [clang-analyzer-core.NullDereference]
                           name = to_of_node(child)->name;
                                  ^
   include/linux/of.h:161:2: note: expanded from macro 'to_of_node'
           ({                                                              \
           ^
   drivers/leds/leds-pca955x.c:442:6: note: Assuming 'pdata' is null
--
                   ^
   security/apparmor/domain.c:1407:9: note: Assuming 'i' is >= field 'size'
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/apparmor/include/lib.h:228:7: note: expanded from macro 'fn_label_build'
                   if (vec_setup(label, __lvec, (L)->size, (GFP))) {       \
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/apparmor/include/label.h:33:15: note: expanded from macro 'vec_setup'
                   for (i = 0; i < (N); i++)                               \
                               ^~~~~~~
   security/apparmor/domain.c:1407:9: note: Loop condition is false. Execution continues on line 1407
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^
   security/apparmor/include/lib.h:228:7: note: expanded from macro 'fn_label_build'
                   if (vec_setup(label, __lvec, (L)->size, (GFP))) {       \
                       ^
   security/apparmor/include/label.h:33:3: note: expanded from macro 'vec_setup'
                   for (i = 0; i < (N); i++)                               \
                   ^
   security/apparmor/domain.c:1407:9: note: '__lvec' is non-null
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/apparmor/include/lib.h:228:24: note: expanded from macro 'fn_label_build'
                   if (vec_setup(label, __lvec, (L)->size, (GFP))) {       \
                                        ^~~~~~
   security/apparmor/include/label.h:37:3: note: expanded from macro 'vec_setup'
           (V) ? 0 : -ENOMEM;                                              \
            ^
   security/apparmor/domain.c:1407:9: note: '?' condition is true
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^
   security/apparmor/include/lib.h:228:7: note: expanded from macro 'fn_label_build'
                   if (vec_setup(label, __lvec, (L)->size, (GFP))) {       \
                       ^
   security/apparmor/include/label.h:37:2: note: expanded from macro 'vec_setup'
           (V) ? 0 : -ENOMEM;                                              \
           ^
   security/apparmor/domain.c:1407:9: note: Taking false branch
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^
   security/apparmor/include/lib.h:228:3: note: expanded from macro 'fn_label_build'
                   if (vec_setup(label, __lvec, (L)->size, (GFP))) {       \
                   ^
   security/apparmor/domain.c:1407:9: note: Loop condition is false. Execution continues on line 1407
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^
   security/apparmor/include/lib.h:233:3: note: expanded from macro 'fn_label_build'
                   label_for_each(__i, (L), (P)) {                         \
                   ^
   security/apparmor/include/label.h:158:2: note: expanded from macro 'label_for_each'
           for ((I).i = 0; ((P) = (L)->vec[(I).i]); ++((I).i))
           ^
   security/apparmor/domain.c:1407:9: note: The value 0 is assigned to '__j'
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/apparmor/include/lib.h:240:8: note: expanded from macro 'fn_label_build'
                   for (__j = __count = 0; __j < (L)->size; __j++)         \
                        ^~~~~~~~~~~~~~~~~
   security/apparmor/domain.c:1407:9: note: Loop condition is true.  Entering loop body
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^
   security/apparmor/include/lib.h:240:3: note: expanded from macro 'fn_label_build'
                   for (__j = __count = 0; __j < (L)->size; __j++)         \
                   ^
   security/apparmor/domain.c:1407:9: note: Access to field 'size' results in a dereference of a null pointer
                   new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
                         ^
   security/apparmor/include/lib.h:284:2: note: expanded from macro 'fn_label_build_in_ns'
           fn_label_build((L), (P), (GFP),                                 \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/apparmor/include/lib.h:241:15: note: expanded from macro 'fn_label_build'
                           __count += __lvec[__j]->size;                   \
                                      ^~~~~~~~~~~~~~~~~
   Suppressed 2 warnings (1 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
>> drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in 'struct bcm2835_spidev' (48 padding bytes, where 16 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:153:8: note: Excessive padding in 'struct bcm2835_spidev' (48 padding bytes, where 16 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members
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
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).

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
