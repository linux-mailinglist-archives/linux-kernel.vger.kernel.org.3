Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6757AE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiGTCot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiGTCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:44:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3C6EEB0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658285085; x=1689821085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cVDfvDBPD3yp1WqAbOcc7kbEOeXmpI/yis/3fjXS9qw=;
  b=RGEu0uN4CiSlJlj1l8Fdjs8cAWcTQbsXXf48f6skhPASoMLk0it2jr3h
   FJfxLWDKEM+PhlmswrZyHG9ASjUXF8A5rwm3z5AKxWS0oHT0d6Qbgkcnx
   UmNTNFoDXAgqt8fk+KB68y6Gr1PEBH3pTM8khv0nUi7Y7YeordBMg/w/0
   NCiq6y2gAuHPP48wrxt5WAWJxUbhbg2sSPFwg4sXZSUcWcx8zzkoo2MQu
   ActrHc66uCNOxO8LQzATBobcOB3gmziC1vqn5GvaIvOHlK0wEiQsVMJ52
   6MQXXEzFEsQWRhxrw8JDyrbWQQH1SlFN43jSoa0x1rdil8AMGQRwVxsw/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="348356658"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="348356658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 19:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="597908114"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2022 19:44:43 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDzhb-0006NS-5k;
        Wed, 20 Jul 2022 02:44:43 +0000
Date:   Wed, 20 Jul 2022 10:44:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <lvb@xiphos.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/adc/ad7949.c:80:8: warning: Excessive padding in 'struct
 ad7949_adc_chip' (37 padding bytes, where 5 is optimal). Optimal fields
 order: buffer, cfg, vref, indio_dev, spi, refsel, current_channel, lock,
 buf8b, resolution, consider reordering th...
Message-ID: <202207201005.LeQJCGFE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 37930650604982930c4f516447f0fb3a61cb647f iio: adc: ad7949: add vref selection support
date:   10 months ago
config: arm-randconfig-c002-20220717 (https://download.01.org/0day-ci/archive/20220720/202207201005.LeQJCGFE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 45067f8fbf61284839c739807c2da2e2505661eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=37930650604982930c4f516447f0fb3a61cb647f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 37930650604982930c4f516447f0fb3a61cb647f
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/iio/frequency/adf4350.c:33:8: warning: Excessive padding in 'struct adf4350_state' (48 padding bytes, where 16 is optimal). Optimal fields order: val, spi, freq_req, reg, lock_detect_gpiod, pdata, clk, clkin, chspc, fpfd, min_out_freq, r0_fract, r0_int, r1_mod, r4_rf_div_sel, regs, regs_hw, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adf4350_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/frequency/adf4350.c:33:8: note: Excessive padding in 'struct adf4350_state' (48 padding bytes, where 16 is optimal). Optimal fields order: val, spi, freq_req, reg, lock_detect_gpiod, pdata, clk, clkin, chspc, fpfd, min_out_freq, r0_fract, r0_int, r1_mod, r4_rf_div_sel, regs, regs_hw, lock, consider reordering the fields or adding explicit padding members
   struct adf4350_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   drivers/iio/frequency/adf4371.c:157:8: warning: Excessive padding in 'struct adf4371_state' (38 padding bytes, where 6 is optimal). Optimal fields order: buf, spi, regmap, clkin, chip_info, clkin_freq, fpfd, integer, fract1, fract2, mod2, rf_div_sel, ref_div_factor, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adf4371_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/frequency/adf4371.c:157:8: note: Excessive padding in 'struct adf4371_state' (38 padding bytes, where 6 is optimal). Optimal fields order: buf, spi, regmap, clkin, chip_info, clkin_freq, fpfd, integer, fract1, fract2, mod2, rf_div_sel, ref_div_factor, lock, consider reordering the fields or adding explicit padding members
   struct adf4371_state {
   ~~~~~~~^~~~~~~~~~~~~~~
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
   2 warnings generated.
>> drivers/iio/adc/ad7949.c:80:8: warning: Excessive padding in 'struct ad7949_adc_chip' (37 padding bytes, where 5 is optimal). Optimal fields order: buffer, cfg, vref, indio_dev, spi, refsel, current_channel, lock, buf8b, resolution, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7949_adc_chip {
   ~~~~~~~^~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7949.c:80:8: note: Excessive padding in 'struct ad7949_adc_chip' (37 padding bytes, where 5 is optimal). Optimal fields order: buffer, cfg, vref, indio_dev, spi, refsel, current_channel, lock, buf8b, resolution, consider reordering the fields or adding explicit padding members
   struct ad7949_adc_chip {
   ~~~~~~~^~~~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   drivers/iio/adc/at91-sama5d2_adc.c:1290:3: warning: Value stored to 'status' is never read [clang-analyzer-deadcode.DeadStores]
                   status = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
                   ^
   drivers/iio/adc/at91-sama5d2_adc.c:1290:3: note: Value stored to 'status' is never read
   drivers/iio/adc/at91-sama5d2_adc.c:1291:3: warning: Value stored to 'status' is never read [clang-analyzer-deadcode.DeadStores]
                   status = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
                   ^
   drivers/iio/adc/at91-sama5d2_adc.c:1291:3: note: Value stored to 'status' is never read
   drivers/iio/adc/at91-sama5d2_adc.c:1292:3: warning: Value stored to 'status' is never read [clang-analyzer-deadcode.DeadStores]
                   status = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
                   ^
   drivers/iio/adc/at91-sama5d2_adc.c:1292:3: note: Value stored to 'status' is never read
   drivers/iio/adc/at91-sama5d2_adc.c:1329:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                   ret = at91_adc_read_position(st, chan->channel,
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:1329:3: note: Value stored to 'ret' is never read
                   ret = at91_adc_read_position(st, chan->channel,
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:1343:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                   ret = at91_adc_read_pressure(st, chan->channel,
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:1343:3: note: Value stored to 'ret' is never read
                   ret = at91_adc_read_pressure(st, chan->channel,
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:727:4: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                           ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:727:4: note: Value stored to 'ret' is never read
                           ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:733:4: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                           ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:733:4: note: Value stored to 'ret' is never read
                           ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
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
   drivers/iio/potentiometer/mcp41010.c:58:8: warning: Excessive padding in 'struct mcp41010_data' (46 padding bytes, where 14 is optimal). Optimal fields order: buf, spi, cfg, value, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct mcp41010_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/potentiometer/mcp41010.c:58:8: note: Excessive padding in 'struct mcp41010_data' (46 padding bytes, where 14 is optimal). Optimal fields order: buf, spi, cfg, value, lock, consider reordering the fields or adding explicit padding members
   struct mcp41010_data {
   ~~~~~~~^~~~~~~~~~~~~~~
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

vim +80 drivers/iio/adc/ad7949.c

7f40e0614317f2 Charles-Antoine Couret 2018-10-22  66  
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  67  /**
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  68   * struct ad7949_adc_chip - AD ADC chip
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  69   * @lock: protects write sequences
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  70   * @vref: regulator generating Vref
c5e6c649b4c4ed Lee Jones              2020-07-16  71   * @indio_dev: reference to iio structure
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  72   * @spi: reference to spi structure
37930650604982 Liam Beguin            2021-08-15  73   * @refsel: reference selection
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  74   * @resolution: resolution of the chip
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  75   * @cfg: copy of the configuration register
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  76   * @current_channel: current channel in use
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  77   * @buffer: buffer to send / receive data to / from device
0b2a740b424e68 Liam Beguin            2021-08-15  78   * @buf8b: be16 buffer to exchange data with the device in 8-bit transfers
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  79   */
7f40e0614317f2 Charles-Antoine Couret 2018-10-22 @80  struct ad7949_adc_chip {
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  81  	struct mutex lock;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  82  	struct regulator *vref;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  83  	struct iio_dev *indio_dev;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  84  	struct spi_device *spi;
37930650604982 Liam Beguin            2021-08-15  85  	u32 refsel;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  86  	u8 resolution;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  87  	u16 cfg;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  88  	unsigned int current_channel;
348eb0b2c4f0f9 Andrea Merello         2019-09-12  89  	u16 buffer ____cacheline_aligned;
0b2a740b424e68 Liam Beguin            2021-08-15  90  	__be16 buf8b;
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  91  };
7f40e0614317f2 Charles-Antoine Couret 2018-10-22  92  

:::::: The code at line 80 was first introduced by commit
:::::: 7f40e0614317f20ac07b5aa5cec2eb43737e28d6 iio:adc:ad7949: Add AD7949 ADC driver family

:::::: TO: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
:::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
