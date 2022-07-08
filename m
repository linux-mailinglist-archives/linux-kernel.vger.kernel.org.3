Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1356BFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiGHQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiGHQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:16:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CC576EB8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657296998; x=1688832998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OPCFuffq4rP/hg3BpO52TtcI13/lCd18i6iB9CMLVzw=;
  b=BBcSZfRulyhtXEx7c27xXsb3WtDKiPEscmAd9uxZGPtkt5ISudaDdV8W
   hYCD+ea+5bszcLL2t0Ba7ONeoSuVoptOdT3Bfrb91ne3TmXzrSSKJW3zW
   bPsngU70GxM15nzA48ZWJDyvx94ClvCikU9Q3WVPcRvd9h0oRm/i4ajrV
   P7VRX+agl4IvuI5Uxo5yIRRZefdnAjKgCbD1mDPJOJSL4MEnmVhiqQQfq
   CIc3Lzcxl9iXLhZqY/SKYwOvTShqTn51jVjThvluIuJK+DL6KYO3c/fPF
   jyfu0xvJMoXkk143IALOGAw4cFexJuwBiZLgPdeF/pPVv3vyxP1Dpb3M3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285443098"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285443098"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736391449"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 09:15:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9qe5-000NgY-SE;
        Fri, 08 Jul 2022 16:15:57 +0000
Date:   Sat, 9 Jul 2022 00:15:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: drivers/iio/adc/ad7476.c:29:8: warning: Excessive padding in 'struct
 ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal fields
 order: reset, channel, convst_channel, int_vref_uv, has_vref, has_vdrive,
 consider reordering the fields or addin...
Message-ID: <202207090025.tVBfb94P-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: 7bf50a968a1cd02728e9120ad0216dc80f7a6fb0 iio:adc:ad7476: Handle the different regulators used by various parts.
date:   1 year, 2 months ago
config: s390-randconfig-c005-20220703 (https://download.01.org/0day-ci/archive/20220709/202207090025.tVBfb94P-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bf50a968a1cd02728e9120ad0216dc80f7a6fb0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7bf50a968a1cd02728e9120ad0216dc80f7a6fb0
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
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
   drivers/message/fusion/mptspi.c:1259:3: note: Loop condition is false.  Exiting loop
                   container_of(work, struct work_queue_wrapper, work);
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
   drivers/message/fusion/mptspi.c:1269:6: note: Assuming field 'spi_pending' is 0
           if (hd->spi_pending) {
               ^~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:1269:2: note: Taking false branch
           if (hd->spi_pending) {
           ^
   drivers/message/fusion/mptspi.c:1281:3: note: Loop condition is true.  Entering loop body
                   shost_for_each_device(sdev, ioc->sh)
                   ^
   include/scsi/scsi_device.h:380:2: note: expanded from macro 'shost_for_each_device'
           for ((sdev) = __scsi_iterate_devices((shost), NULL); \
           ^
   drivers/message/fusion/mptspi.c:1282:4: note: Calling 'mptspi_dv_device'
                           mptspi_dv_device(hd, sdev);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:690:6: note: Assuming field 'channel' is not equal to 0
           if (sdev->channel == 0 &&
               ^~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:690:25: note: Left side of '&&' is false
           if (sdev->channel == 0 &&
                                  ^
   drivers/message/fusion/mptspi.c:695:6: note: Assuming field 'channel' is not equal to 1
           if (sdev->channel == 1 &&
               ^~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:695:25: note: Left side of '&&' is false
           if (sdev->channel == 1 &&
                                  ^
   drivers/message/fusion/mptspi.c:706:6: note: Assuming field 'channel' is not equal to 1
           if (sdev->channel == 1 &&
               ^~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:706:25: note: Left side of '&&' is false
           if (sdev->channel == 1 &&
                                  ^
   drivers/message/fusion/mptspi.c:711:2: note: Calling 'mptspi_read_parameters'
           mptspi_read_parameters(sdev->sdev_target);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:600:2: note: Calling 'mptspi_read_spi_device_pg0'
           mptspi_read_spi_device_pg0(starget, &spi_dev_pg0);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:527:6: note: Assuming field 'channel' is equal to 0
           if (starget->channel == 0 &&
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:527:6: note: Left side of '&&' is true
   drivers/message/fusion/mptspi.c:528:6: note: Assuming the condition is true
               mptspi_is_raid(hd, starget->id))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:527:2: note: Taking true branch
           if (starget->channel == 0 &&
           ^
   drivers/message/fusion/mptspi.c:529:3: note: Returning without writing to 'pass_pg0->NegotiatedParameters'
                   return -1;
                   ^
   drivers/message/fusion/mptspi.c:600:2: note: Returning from 'mptspi_read_spi_device_pg0'
           mptspi_read_spi_device_pg0(starget, &spi_dev_pg0);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/message/fusion/mptspi.c:602:9: note: 1st function call argument is an uninitialized value
           nego = le32_to_cpu(spi_dev_pg0.NegotiatedParameters);
                  ^
   include/linux/byteorder/generic.h:89:21: note: expanded from macro 'le32_to_cpu'
   #define le32_to_cpu __le32_to_cpu
                       ^
   include/uapi/linux/byteorder/big_endian.h:34:26: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:115:28: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                              ^                 ~~~~~~~~~~
   Suppressed 19 warnings (7 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   21 warnings generated.
>> drivers/iio/adc/ad7476.c:29:8: warning: Excessive padding in 'struct ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal fields order: reset, channel, convst_channel, int_vref_uv, has_vref, has_vdrive, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7476_chip_info {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7476.c:29:8: note: Excessive padding in 'struct ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal fields order: reset, channel, convst_channel, int_vref_uv, has_vref, has_vdrive, consider reordering the fields or adding explicit padding members
   struct ad7476_chip_info {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct ad7476_state' (472 padding bytes, where 216 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7476.c:39:8: note: Excessive padding in 'struct ad7476_state' (472 padding bytes, where 216 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 19 warnings (7 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   20 warnings generated.
   drivers/iio/adc/ad7766.c:35:8: warning: Excessive padding in 'struct ad7766' (392 padding bytes, where 136 is optimal). Optimal fields order: data, chip_info, spi, mclk, pd_gpio, trig, reg, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7766 {
   ~~~~~~~^~~~~~~~
   drivers/iio/adc/ad7766.c:35:8: note: Excessive padding in 'struct ad7766' (392 padding bytes, where 136 is optimal). Optimal fields order: data, chip_info, spi, mclk, pd_gpio, trig, reg, msg, xfer, consider reordering the fields or adding explicit padding members
   struct ad7766 {
   ~~~~~~~^~~~~~~~
   Suppressed 19 warnings (7 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   20 warnings generated.
   drivers/iio/adc/ad7768-1.c:154:8: warning: Excessive padding in 'struct ad7768_state' (388 padding bytes, where 132 is optimal). Optimal fields order: data, mclk_freq, spi, vref, mclk, trig, gpio_sync_in, labels, lock, completion, samp_freq, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7768_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7768-1.c:154:8: note: Excessive padding in 'struct ad7768_state' (388 padding bytes, where 132 is optimal). Optimal fields order: data, mclk_freq, spi, vref, mclk, trig, gpio_sync_in, labels, lock, completion, samp_freq, consider reordering the fields or adding explicit padding members
   struct ad7768_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 19 warnings (7 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   20 warnings generated.
   Suppressed 20 warnings (8 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   20 warnings generated.
   Suppressed 20 warnings (8 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   include/linux/hid.h:1004:9: warning: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'input') [clang-analyzer-core.NullDereference]
                                       input->name, c, type);
                                       ^
   drivers/hid/hid-twinhan.c:65:6: note: Assuming the condition is false
           if ((usage->hid & HID_USAGE_PAGE) != HID_UP_KEYBOARD)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-twinhan.c:65:2: note: Taking false branch
           if ((usage->hid & HID_USAGE_PAGE) != HID_UP_KEYBOARD)
           ^
   drivers/hid/hid-twinhan.c:68:2: note: Control jumps to 'case 31:'  at line 83
           switch (usage->hid & HID_USAGE) {
           ^
   drivers/hid/hid-twinhan.c:83:14: note: Calling 'hid_map_usage_clear'
           case 0x01f: th_map_key_clear(KEY_NUMERIC_2);    break;
                       ^
   drivers/hid/hid-twinhan.c:59:29: note: expanded from macro 'th_map_key_clear'
   #define th_map_key_clear(c)     hid_map_usage_clear(hi, usage, bit, max, \
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1032:2: note: Calling 'hid_map_usage'
           hid_map_usage(hidinput, usage, bit, max, type, c);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:979:2: note: 'input' initialized here
           struct input_dev *input = hidinput->input;
           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:983:2: note: Control jumps to 'case 1:'  at line 992
           switch (type) {
           ^
   include/linux/hid.h:995:3: note:  Execution continues on line 1002
                   break;
                   ^
   include/linux/hid.h:1002:15: note: 'c' is <= 'limit'
           if (unlikely(c > limit || !bmap)) {
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   include/linux/hid.h:1002:15: note: Left side of '||' is false
           if (unlikely(c > limit || !bmap)) {
                        ^
   include/linux/hid.h:1002:28: note: Assuming 'bmap' is null
           if (unlikely(c > limit || !bmap)) {
                                     ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   include/linux/hid.h:1002:28: note: Assuming pointer value is null
           if (unlikely(c > limit || !bmap)) {
                                     ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   include/linux/hid.h:1002:2: note: Taking true branch
           if (unlikely(c > limit || !bmap)) {
           ^
   include/linux/hid.h:1003:3: note: Assuming the condition is true
                   pr_warn_ratelimited("%s: Invalid code %d type %d\n",
                   ^
   include/linux/printk.h:528:2: note: expanded from macro 'pr_warn_ratelimited'
           printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:511:6: note: expanded from macro 'printk_ratelimited'
           if (__ratelimit(&_rs))                                          \
               ^~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:41:28: note: expanded from macro '__ratelimit'
   #define __ratelimit(state) ___ratelimit(state, __func__)
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1003:3: note: Taking true branch
                   pr_warn_ratelimited("%s: Invalid code %d type %d\n",

vim +29 drivers/iio/adc/ad7476.c

87c5b10fd97937 drivers/iio/adc/ad7476.c         Lars-Peter Clausen 2012-09-17  28  
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10 @29  struct ad7476_chip_info {
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  30  	unsigned int			int_vref_uv;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  31  	struct iio_chan_spec		channel[2];
3a6af93dd66eba drivers/iio/adc/ad7476.c         Dragos Bogdan      2020-03-11  32  	/* channels used when convst gpio is defined */
3a6af93dd66eba drivers/iio/adc/ad7476.c         Dragos Bogdan      2020-03-11  33  	struct iio_chan_spec		convst_channel[2];
87c5b10fd97937 drivers/iio/adc/ad7476.c         Lars-Peter Clausen 2012-09-17  34  	void (*reset)(struct ad7476_state *);
7bf50a968a1cd0 drivers/iio/adc/ad7476.c         Jonathan Cameron   2021-04-25  35  	bool				has_vref;
7bf50a968a1cd0 drivers/iio/adc/ad7476.c         Jonathan Cameron   2021-04-25  36  	bool				has_vdrive;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  37  };
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  38  
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10 @39  struct ad7476_state {
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  40  	struct spi_device		*spi;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  41  	const struct ad7476_chip_info	*chip_info;
7bf50a968a1cd0 drivers/iio/adc/ad7476.c         Jonathan Cameron   2021-04-25  42  	struct regulator		*ref_reg;
af37e4703d00ce drivers/iio/adc/ad7476.c         Dragos Bogdan      2020-03-11  43  	struct gpio_desc		*convst_gpio;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  44  	struct spi_transfer		xfer;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  45  	struct spi_message		msg;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  46  	/*
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  47  	 * DMA (thus cache coherency maintenance) requires the
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  48  	 * transfer buffers to live in their own cache lines.
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  49  	 * Make the buffer large enough for one 16 bit sample and one 64 bit
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  50  	 * aligned 64 bit timestamp.
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  51  	 */
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  52  	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)]
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  53  			____cacheline_aligned;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  54  };
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  55  

:::::: The code at line 29 was first introduced by commit
:::::: 7a28fe3c93d6cd920c84678a1bf45af8b4248577 staging:iio:ad7476: Squash driver into a single file.

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
