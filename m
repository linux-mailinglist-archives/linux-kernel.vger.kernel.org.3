Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4738E580265
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiGYQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGYQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:05:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A06315
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658765142; x=1690301142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQQV9NpOEpwHsTQjnoCHgvN5PUSd3KSsWHxW8jC8EC4=;
  b=bE+FrX/g5WeONBOpzTprf1fI/71h/SVaGmYVa4P6QZVzs6kkPoiXquLO
   K45SDQmxcWLZlxaepdu0bZGIXwKeP8erP5JJ/fHO6LbPvmJdgVpRLrJMs
   vEqHsubKYQ3Yhd9m1F+UCTnYEBu2EMUXVLnjmcZ8vp5dr5s7ERpIN+5rp
   AuRjccIsL4nfnWg56sb9uRvcBC5pYA5wjqhnM1Qru4ZznnNuDCf+RdSzX
   XCFpkJY/Kie3aPtAXd/TwaqReXB0pqHMhoNChqTsM/aGJWOeOi5YQammS
   /vkVdicJU7+P3w/TbcG/yPRX8vdfVVBkljhUC8Gn1d4UnrOOkjlAb0n6J
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313486429"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313486429"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 09:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="632407362"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2022 09:05:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG0aR-0005H6-0K;
        Mon, 25 Jul 2022 16:05:39 +0000
Date:   Tue, 26 Jul 2022 00:04:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/dac/ltc2688.c:84:8: warning: Excessive padding in
 'struct ltc2688_state' (35 padding bytes, where 3 is optimal). Optimal
 fields order: tx_data, rx_data, spi, regmap, iio_chan, vref, lock,
 regulators, channels, consider reordering the fields or...
Message-ID: <202207260027.9tiGgEqR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 832cb9eeb9312dd2e14133681d3920b773ef1eac iio: dac: add support for ltc2688
date:   5 months ago
config: arm-randconfig-c002-20220718 (https://download.01.org/0day-ci/archive/20220726/202207260027.9tiGgEqR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=832cb9eeb9312dd2e14133681d3920b773ef1eac
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 832cb9eeb9312dd2e14133681d3920b773ef1eac
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)
   drivers/media/usb/em28xx/em28xx-core.c:636:6: note: Assuming field 'chip_id' is not equal to CHIP_ID_EM2874
           if (dev->chip_id == CHIP_ID_EM2874 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:636:6: note: Left side of '||' is false
   drivers/media/usb/em28xx/em28xx-core.c:637:6: note: Assuming field 'chip_id' is not equal to CHIP_ID_EM2884
               dev->chip_id == CHIP_ID_EM2884 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:636:6: note: Left side of '||' is false
           if (dev->chip_id == CHIP_ID_EM2874 ||
               ^
   drivers/media/usb/em28xx/em28xx-core.c:638:6: note: Assuming field 'chip_id' is not equal to CHIP_ID_EM28174
               dev->chip_id == CHIP_ID_EM28174 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:636:6: note: Left side of '||' is false
           if (dev->chip_id == CHIP_ID_EM2874 ||
               ^
   drivers/media/usb/em28xx/em28xx-core.c:639:6: note: Assuming field 'chip_id' is not equal to CHIP_ID_EM28178
               dev->chip_id == CHIP_ID_EM28178) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:636:2: note: Taking false branch
           if (dev->chip_id == CHIP_ID_EM2874 ||
           ^
   drivers/media/usb/em28xx/em28xx-core.c:668:9: note: 'start' is 1
                                              start ? 0x10 : 0x00, 0x10);
                                              ^~~~~
   drivers/media/usb/em28xx/em28xx-core.c:668:9: note: '?' condition is true
   drivers/media/usb/em28xx/em28xx-core.c:667:8: note: Calling 'em28xx_write_reg_bits'
                   rc = em28xx_write_reg_bits(dev, EM28XX_R0C_USBSUSP,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:211:11: note: Calling 'em28xx_read_reg'
           oldval = em28xx_read_reg(dev, reg);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:136:9: note: Calling 'em28xx_read_reg_req'
           return em28xx_read_reg_req(dev, USB_REQ_GET_STATUS, reg);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:125:2: note: 'val' declared without an initial value
           u8 val;
           ^~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:127:8: note: Calling 'em28xx_read_reg_req_len'
           ret = em28xx_read_reg_req_len(dev, req, reg, &val, 1);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:83:6: note: Assuming field 'disconnected' is 0
           if (dev->disconnected)
               ^~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:83:2: note: Taking false branch
           if (dev->disconnected)
           ^
   drivers/media/usb/em28xx/em28xx-core.c:86:6: note: 'len' is <= URB_MAX_CTRL_SIZE
           if (len > URB_MAX_CTRL_SIZE)
               ^~~
   drivers/media/usb/em28xx/em28xx-core.c:86:2: note: Taking false branch
           if (len > URB_MAX_CTRL_SIZE)
           ^
   drivers/media/usb/em28xx/em28xx-core.c:93:6: note: Assuming 'ret' is < 0
           if (ret < 0) {
               ^~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:93:2: note: Taking true branch
           if (ret < 0) {
           ^
   drivers/media/usb/em28xx/em28xx-core.c:94:3: note: Assuming 'reg_debug' is 0
                   em28xx_regdbg("(pipe 0x%08x): IN:  %02x %02x %02x %02x %02x %02x %02x %02x  failed with error %i\n",
                   ^
   drivers/media/usb/em28xx/em28xx-core.c:60:6: note: expanded from macro 'em28xx_regdbg'
           if (reg_debug)                                                  \
               ^~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:94:3: note: Taking false branch
                   em28xx_regdbg("(pipe 0x%08x): IN:  %02x %02x %02x %02x %02x %02x %02x %02x  failed with error %i\n",
                   ^
   drivers/media/usb/em28xx/em28xx-core.c:60:2: note: expanded from macro 'em28xx_regdbg'
           if (reg_debug)                                                  \
           ^
   drivers/media/usb/em28xx/em28xx-core.c:94:3: note: Loop condition is false.  Exiting loop
                   em28xx_regdbg("(pipe 0x%08x): IN:  %02x %02x %02x %02x %02x %02x %02x %02x  failed with error %i\n",
                   ^
   drivers/media/usb/em28xx/em28xx-core.c:59:36: note: expanded from macro 'em28xx_regdbg'
   #define em28xx_regdbg(fmt, arg...) do {                         \
                                      ^
   drivers/media/usb/em28xx/em28xx-core.c:127:8: note: Returning from 'em28xx_read_reg_req_len'
           ret = em28xx_read_reg_req_len(dev, req, reg, &val, 1);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:128:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:128:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/media/usb/em28xx/em28xx-core.c:131:2: note: Undefined or garbage value returned to caller
           return val;
           ^      ~~~
   drivers/media/usb/em28xx/em28xx-core.c:674:5: warning: Value stored to 'rc' is never read [clang-analyzer-deadcode.DeadStores]
                                   rc = em28xx_write_reg(dev, 0x13, 0x0c);
                                   ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/em28xx/em28xx-core.c:674:5: note: Value stored to 'rc' is never read
                                   rc = em28xx_write_reg(dev, 0x13, 0x0c);
                                   ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 2 warnings (2 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
>> drivers/iio/dac/ltc2688.c:84:8: warning: Excessive padding in 'struct ltc2688_state' (35 padding bytes, where 3 is optimal). Optimal fields order: tx_data, rx_data, spi, regmap, iio_chan, vref, lock, regulators, channels, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ltc2688_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:84:8: note: Excessive padding in 'struct ltc2688_state' (35 padding bytes, where 3 is optimal). Optimal fields order: tx_data, rx_data, spi, regmap, iio_chan, vref, lock, regulators, channels, consider reordering the fields or adding explicit padding members
   struct ltc2688_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:253:11: warning: The left operand of '&' is a garbage value [clang-analyzer-core.UndefinedBinaryOperatorResult]
                   *code = FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);
                           ^
   include/linux/bitfield.h:126:27: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                           ^
   drivers/iio/dac/ltc2688.c:498:2: note: 'val' declared without an initial value
           u32 val;
           ^~~~~~~
   drivers/iio/dac/ltc2688.c:500:6: note: Assuming 'private' is not equal to LTC2688_INPUT_B_AVAIL
           if (private == LTC2688_INPUT_B_AVAIL)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:500:2: note: Taking false branch
           if (private == LTC2688_INPUT_B_AVAIL)
           ^
   drivers/iio/dac/ltc2688.c:505:6: note: Assuming 'private' is not equal to LTC2688_DITHER_OFF
           if (private == LTC2688_DITHER_OFF)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:505:2: note: Taking false branch
           if (private == LTC2688_DITHER_OFF)
           ^
   drivers/iio/dac/ltc2688.c:508:8: note: Calling 'ltc2688_dac_code_read'
           ret = ltc2688_dac_code_read(st, chan->channel, private, &val);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:245:6: note: Assuming 'ret' is not equal to 0
           if (ret)
               ^~~
   drivers/iio/dac/ltc2688.c:245:2: note: Taking true branch
           if (ret)
           ^
   drivers/iio/dac/ltc2688.c:246:3: note: Control jumps to line 250
                   goto out_unlock;
                   ^
   drivers/iio/dac/ltc2688.c:252:6: note: Assuming field 'toggle_chan' is false
           if (!c->toggle_chan && input == LTC2688_INPUT_B)
               ^~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:252:6: note: Left side of '&&' is true
   drivers/iio/dac/ltc2688.c:252:25: note: Assuming 'input' is equal to LTC2688_INPUT_B
           if (!c->toggle_chan && input == LTC2688_INPUT_B)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:252:2: note: Taking true branch
           if (!c->toggle_chan && input == LTC2688_INPUT_B)
           ^
   drivers/iio/dac/ltc2688.c:253:11: note: Taking false branch
                   *code = FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);
                           ^
   include/linux/bitfield.h:125:3: note: expanded from macro 'FIELD_GET'
                   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
                   ^
   include/linux/bitfield.h:62:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:346:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:334:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:326:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   drivers/iio/dac/ltc2688.c:253:11: note: Loop condition is false.  Exiting loop
                   *code = FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);
                           ^
   include/linux/bitfield.h:125:3: note: expanded from macro 'FIELD_GET'
                   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
                   ^
   include/linux/bitfield.h:62:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:346:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:334:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:318:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   drivers/iio/dac/ltc2688.c:253:11: note: Taking false branch
                   *code = FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);
                           ^
   include/linux/bitfield.h:125:3: note: expanded from macro 'FIELD_GET'
                   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
                   ^
   include/linux/bitfield.h:64:3: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
                   ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'

vim +84 drivers/iio/dac/ltc2688.c

    83	
  > 84	struct ltc2688_state {
    85		struct spi_device *spi;
    86		struct regmap *regmap;
    87		struct regulator_bulk_data regulators[2];
    88		struct ltc2688_chan channels[LTC2688_DAC_CHANNELS];
    89		struct iio_chan_spec *iio_chan;
    90		/* lock to protect against multiple access to the device and shared data */
    91		struct mutex lock;
    92		int vref;
    93		/*
    94		 * DMA (thus cache coherency maintenance) requires the
    95		 * transfer buffers to live in their own cache lines.
    96		 */
    97		u8 tx_data[6] ____cacheline_aligned;
    98		u8 rx_data[3];
    99	};
   100	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
