Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB057CB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiGUNGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiGUNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:06:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DAE764E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658408718; x=1689944718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VOpAWSHgO32roLjayCYOn6W8eVPRd/m40uVjLWgGaoo=;
  b=AJ1sVuEoYvizK5lAjpJBfxeGDeMT0sWTDun6pb8WUJHikLWDakmR++rD
   gDdlZ1m+QqHCIFI2qnswTbSeDOFdE/zMvBVPkZhi4xl3JMmmWaoMm7jmo
   CUPjEe+sWyIR6h+G9nzzF7W4o/7DNnPKxQstl4265q8r17CcLvH4Jf3kT
   RW2UX8QhrNSGhFNc+Xof7AVoyfrmpD1FQlzvEqcdFbFsBsA6YssY9dPEz
   ZBpedXRRHr12mF5yz5dqA6oxQc7+9WtCGnmLXNh2onEoJPLNhwQ35HdkF
   qVBAgo6ECqMjvKUiZ4gTnbbMQAxwiWI+NJy7OT6jC5BtmezGQ72USC70x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287046135"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="287046135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="548759484"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 06:04:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEVqv-00008Q-1k;
        Thu, 21 Jul 2022 13:04:29 +0000
Date:   Thu, 21 Jul 2022 21:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/temperature/max31865.c:51:8: warning: Excessive padding
 in 'struct max31865_data' (56 padding bytes, where 24 is optimal). Optimal
 fields order: buf, filter_50hz, three_wire, spi, lock, consider reordering
 the fields or adding explicit padding...
Message-ID: <202207212132.9hoo6bQY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   353f7988dd8413c47718f7ca79c030b6fb62cfe5
commit: e112dc4e18eafc5ee9d5700e3c059ac9897ae2a1 iio: temperature: Add MAX31865 RTD Support
date:   10 months ago
config: arm-randconfig-c002-20220717 (https://download.01.org/0day-ci/archive/20220721/202207212132.9hoo6bQY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 45067f8fbf61284839c739807c2da2e2505661eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e112dc4e18eafc5ee9d5700e3c059ac9897ae2a1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e112dc4e18eafc5ee9d5700e3c059ac9897ae2a1
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   drivers/iio/gyro/adxrs450.c:73:8: warning: Excessive padding in 'struct adxrs450_state' (52 padding bytes, where 20 is optimal). Optimal fields order: tx, us, rx, buf_lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adxrs450_state {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/iio/gyro/adxrs450.c:73:8: note: Excessive padding in 'struct adxrs450_state' (52 padding bytes, where 20 is optimal). Optimal fields order: tx, us, rx, buf_lock, consider reordering the fields or adding explicit padding members
   struct adxrs450_state {
   ~~~~~~~^~~~~~~~~~~~~~~~
   2 warnings generated.
   Suppressed 2 warnings (1 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/net/usb/rndis_host.c:152:4: warning: Value stored to 'msg_len' is never read [clang-analyzer-deadcode.DeadStores]
                           msg_len = le32_to_cpu(buf->msg_len);
                           ^
   drivers/net/usb/rndis_host.c:152:4: note: Value stored to 'msg_len' is never read
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/net/usb/usbnet.c:800:2: warning: Value stored to 'temp' is never read [clang-analyzer-deadcode.DeadStores]
           temp = unlink_urbs(dev, &dev->txq) +
           ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/usbnet.c:800:2: note: Value stored to 'temp' is never read
           temp = unlink_urbs(dev, &dev->txq) +
           ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/usbnet.c:1386:13: warning: Access to field 'urb' results in a dereference of a null pointer (loaded from variable 'entry') [clang-analyzer-core.NullDereference]
           entry->urb = urb;
           ~~~~~      ^
   drivers/net/usb/usbnet.c:1364:6: note: Assuming 'skb' is null
           if (skb)
               ^~~
   drivers/net/usb/usbnet.c:1364:2: note: Taking false branch
           if (skb)
           ^
   drivers/net/usb/usbnet.c:1369:6: note: Assuming field 'tx_fixup' is null
           if (info->tx_fixup) {
               ^~~~~~~~~~~~~~
   drivers/net/usb/usbnet.c:1369:2: note: Taking false branch
           if (info->tx_fixup) {
           ^
   drivers/net/usb/usbnet.c:1380:8: note: Assuming 'urb' is non-null
           if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
                 ^~~
   drivers/net/usb/usbnet.c:1380:2: note: Taking false branch
           if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
           ^
   drivers/net/usb/usbnet.c:1385:2: note: Null pointer value stored to 'entry'
           entry = (struct skb_data *) skb->cb;
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/usbnet.c:1386:13: note: Access to field 'urb' results in a dereference of a null pointer (loaded from variable 'entry')
           entry->urb = urb;
           ~~~~~      ^
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/iio/proximity/vcnl3020.c:76:8: warning: Excessive padding in 'struct vcnl3020_data' (53 padding bytes, where 21 is optimal). Optimal fields order: buf, rev, regmap, dev, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct vcnl3020_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/proximity/vcnl3020.c:76:8: note: Excessive padding in 'struct vcnl3020_data' (53 padding bytes, where 21 is optimal). Optimal fields order: buf, rev, regmap, dev, lock, consider reordering the fields or adding explicit padding members
   struct vcnl3020_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   drivers/iio/resolver/ad2s90.c:24:8: warning: Excessive padding in 'struct ad2s90_state' (58 padding bytes, where 26 is optimal). Optimal fields order: rx, sdev, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad2s90_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/resolver/ad2s90.c:24:8: note: Excessive padding in 'struct ad2s90_state' (58 padding bytes, where 26 is optimal). Optimal fields order: rx, sdev, lock, consider reordering the fields or adding explicit padding members
   struct ad2s90_state {
   ~~~~~~~^~~~~~~~~~~~~~
   1 warning generated.
   drivers/iio/resolver/ad2s1200.c:39:8: warning: Excessive padding in 'struct ad2s1200_state' (50 padding bytes, where 18 is optimal). Optimal fields order: rx, sdev, sample, rdvel, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad2s1200_state {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/iio/resolver/ad2s1200.c:39:8: note: Excessive padding in 'struct ad2s1200_state' (50 padding bytes, where 18 is optimal). Optimal fields order: rx, sdev, sample, rdvel, lock, consider reordering the fields or adding explicit padding members
   struct ad2s1200_state {
   ~~~~~~~^~~~~~~~~~~~~~~~
   1 warning generated.
>> drivers/iio/temperature/max31865.c:51:8: warning: Excessive padding in 'struct max31865_data' (56 padding bytes, where 24 is optimal). Optimal fields order: buf, filter_50hz, three_wire, spi, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct max31865_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/temperature/max31865.c:51:8: note: Excessive padding in 'struct max31865_data' (56 padding bytes, where 24 is optimal). Optimal fields order: buf, filter_50hz, three_wire, spi, lock, consider reordering the fields or adding explicit padding members
   struct max31865_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   net/ipv4/udp.c:741:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/ipv4/udp.c:741:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   Suppressed 2 warnings (1 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (1 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   drivers/iio/accel/sca3300.c:111:8: warning: Excessive padding in 'struct sca3300_data' (36 padding bytes, where 4 is optimal). Optimal fields order: txbuf, spi, scan, lock, rxbuf, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct sca3300_data {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/accel/sca3300.c:111:8: note: Excessive padding in 'struct sca3300_data' (36 padding bytes, where 4 is optimal). Optimal fields order: txbuf, spi, scan, lock, rxbuf, consider reordering the fields or adding explicit padding members
   struct sca3300_data {
   ~~~~~~~^~~~~~~~~~~~~~
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/iio/dac/ad5064.c:105:8: warning: Excessive padding in 'struct ad5064_state' (47 padding bytes, where 15 is optimal). Optimal fields order: data, dev, chip_info, write, dac_cache, lock, vref_reg, use_internal_vref, pwr_down, pwr_down_mode, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad5064_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/dac/ad5064.c:105:8: note: Excessive padding in 'struct ad5064_state' (47 padding bytes, where 15 is optimal). Optimal fields order: data, dev, chip_info, write, dac_cache, lock, vref_reg, use_internal_vref, pwr_down, pwr_down_mode, consider reordering the fields or adding explicit padding members
   struct ad5064_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/iio/dac/ad5504.c:50:8: warning: Excessive padding in 'struct ad5504_state' (42 padding bytes, where 10 is optimal). Optimal fields order: data, spi, reg, pwr_down_mask, pwr_down_mode, vref_mv, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad5504_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/dac/ad5504.c:50:8: note: Excessive padding in 'struct ad5504_state' (42 padding bytes, where 10 is optimal). Optimal fields order: data, spi, reg, pwr_down_mask, pwr_down_mode, vref_mv, consider reordering the fields or adding explicit padding members
   struct ad5504_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/iio/adc/palmas_gpadc.c:32:8: warning: Excessive padding in 'struct palmas_gpadc_info' (5 padding bytes, where 1 is optimal). Optimal fields order: x1, x2, v1, v2, gain, offset, gain_error, trim1_reg, trim2_reg, is_uncalibrated, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct palmas_gpadc_info {
   ~~~~~~~^~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/palmas_gpadc.c:32:8: note: Excessive padding in 'struct palmas_gpadc_info' (5 padding bytes, where 1 is optimal). Optimal fields order: x1, x2, v1, v2, gain, offset, gain_error, trim1_reg, trim2_reg, is_uncalibrated, consider reordering the fields or adding explicit padding members
   struct palmas_gpadc_info {
   ~~~~~~~^~~~~~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   drivers/iio/adc/qcom-spmi-vadc.c:326:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                   ret = vadc_poll_wait_eoc(vadc, timeout);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/qcom-spmi-vadc.c:326:3: note: Value stored to 'ret' is never read
                   ret = vadc_poll_wait_eoc(vadc, timeout);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.

vim +51 drivers/iio/temperature/max31865.c

    50	
  > 51	struct max31865_data {
    52		struct spi_device *spi;
    53		struct mutex lock;
    54		bool filter_50hz;
    55		bool three_wire;
    56		u8 buf[2] ____cacheline_aligned;
    57	};
    58	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
