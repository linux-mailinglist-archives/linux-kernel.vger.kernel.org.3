Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E457F57C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiGXOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiGXOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:18:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259013CFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658672285; x=1690208285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QMSKEQPsaX6sUd1evy/RzmlHTG4UJe5r/V6xSrnkUkE=;
  b=SCfiieHrkDKwfHgc2vPQ1WKanKaF/9gf8KwKfCnKwl2A3yobltJgk4HZ
   tKxY2mUgMa6HSWqSjhiQvwLKv8CgFjB4uzXpuTnSiZw70EXf18YhaQ2gj
   m46mh3Eo00EWgDNdpnL+4CPq30M7adeB0x2UAE7VBE/VnATWDNnYbohjf
   yLHKsdwVavPD+0aNtF9dUj3u/Lk1fOBMcK9xqnEsUCpZ2I3SGMEWkKy3D
   bnh+Ww7EpAcyvtr8U9++bcg/Z3E1RfjRy9YY5l9VPWJUmMKfre39QXuo2
   ZcaeB2Mug6he+aykbgqKHmpPiPi6Df1V/yhvcCBENQmKm25rDpYSVOBl3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="349245894"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="349245894"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="599336545"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2022 07:18:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFcQk-0003ul-0X;
        Sun, 24 Jul 2022 14:18:02 +0000
Date:   Sun, 24 Jul 2022 22:17:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: drivers/iio/imu/adis16480.c:169:8: warning: Excessive padding in
 'struct adis16480' (40 padding bytes, where 8 is optimal). Optimal fields
 order: adis, data, chip_info, ext_clk, clk_mode, clk_freq, consider
 reordering the fields or adding explicit padding...
Message-ID: <202207242232.7eNzaZhG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 941f130881fa9073a32944e69c26cdc15a554d96 iio: adis16480: support burst read function
date:   1 year, 2 months ago
config: arm-randconfig-c002-20220717 (https://download.01.org/0day-ci/archive/20220724/202207242232.7eNzaZhG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 45067f8fbf61284839c739807c2da2e2505661eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=941f130881fa9073a32944e69c26cdc15a554d96
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 941f130881fa9073a32944e69c26cdc15a554d96
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)
   #define to_si4713_device(sd)    container_of(sd, struct si4713_device, sd)
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
   drivers/media/radio/si4713/si4713.c:1351:6: note: Assuming field 'tuner' is 0
           if (f->tuner)
               ^~~~~~~~
   drivers/media/radio/si4713/si4713.c:1351:2: note: Taking false branch
           if (f->tuner)
           ^
   drivers/media/radio/si4713/si4713.c:1354:6: note: Assuming field 'power_state' is not equal to 0
           if (sdev->power_state) {
               ^~~~~~~~~~~~~~~~~
   drivers/media/radio/si4713/si4713.c:1354:2: note: Taking true branch
           if (sdev->power_state) {
           ^
   drivers/media/radio/si4713/si4713.c:1355:3: note: 'freq' declared without an initial value
                   u16 freq;
                   ^~~~~~~~
   drivers/media/radio/si4713/si4713.c:1358:10: note: Calling 'si4713_tx_tune_status'
                   rval = si4713_tx_tune_status(sdev, 0x00, &freq, &p, &a, &n);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/radio/si4713/si4713.c:698:6: note: Assuming 'err' is not equal to 0
           if (!err) {
               ^~~~
   drivers/media/radio/si4713/si4713.c:698:2: note: Taking false branch
           if (!err) {
           ^
   drivers/media/radio/si4713/si4713.c:711:2: note: Returning without writing to '*frequency'
           return err;
           ^
   drivers/media/radio/si4713/si4713.c:1358:10: note: Returning from 'si4713_tx_tune_status'
                   rval = si4713_tx_tune_status(sdev, 0x00, &freq, &p, &a, &n);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/radio/si4713/si4713.c:1359:7: note: Assuming 'rval' is >= 0
                   if (rval < 0)
                       ^~~~~~~~
   drivers/media/radio/si4713/si4713.c:1359:3: note: Taking false branch
                   if (rval < 0)
                   ^
   drivers/media/radio/si4713/si4713.c:1362:19: note: Assigned value is garbage or undefined
                   sdev->frequency = freq;
                                   ^ ~~~~
   Suppressed 2 warnings (1 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
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
   drivers/iio/imu/adis16400.c:179:8: warning: Excessive padding in 'struct adis16400_state' (48 padding bytes, where 16 is optimal). Optimal fields order: adis, variant, filt_int, avail_scan_mask, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adis16400_state {
   ~~~~~~~^~~~~~~~~~~~~~~~~
   drivers/iio/imu/adis16400.c:179:8: note: Excessive padding in 'struct adis16400_state' (48 padding bytes, where 16 is optimal). Optimal fields order: adis, variant, filt_int, avail_scan_mask, consider reordering the fields or adding explicit padding members
   struct adis16400_state {
   ~~~~~~~^~~~~~~~~~~~~~~~~
   1 warning generated.
   drivers/iio/imu/adis16475.c:100:8: warning: Excessive padding in 'struct adis16475' (41 padding bytes, where 9 is optimal). Optimal fields order: adis, data, info, clk_freq, lsb_flag, sync_mode, burst32, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adis16475 {
   ~~~~~~~^~~~~~~~~~~
   drivers/iio/imu/adis16475.c:100:8: note: Excessive padding in 'struct adis16475' (41 padding bytes, where 9 is optimal). Optimal fields order: adis, data, info, clk_freq, lsb_flag, sync_mode, burst32, consider reordering the fields or adding explicit padding members
   struct adis16475 {
   ~~~~~~~^~~~~~~~~~~
   1 warning generated.
>> drivers/iio/imu/adis16480.c:169:8: warning: Excessive padding in 'struct adis16480' (40 padding bytes, where 8 is optimal). Optimal fields order: adis, data, chip_info, ext_clk, clk_mode, clk_freq, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adis16480 {
   ~~~~~~~^~~~~~~~~~~
   drivers/iio/imu/adis16480.c:169:8: note: Excessive padding in 'struct adis16480' (40 padding bytes, where 8 is optimal). Optimal fields order: adis, data, chip_info, ext_clk, clk_mode, clk_freq, consider reordering the fields or adding explicit padding members
   struct adis16480 {
   ~~~~~~~^~~~~~~~~~~
   1 warning generated.
   drivers/hid/hid-kye.c:684:6: warning: Access to field 'maxfield' results in a dereference of an undefined pointer value (loaded from variable 'report') [clang-analyzer-core.NullDereference]
           if (report->maxfield < 1 || report->field[0]->report_count < 7) {
               ^
   drivers/hid/hid-kye.c:708:6: note: Assuming 'ret' is 0
           if (ret) {
               ^~~
   drivers/hid/hid-kye.c:708:2: note: Taking false branch
           if (ret) {
           ^
   drivers/hid/hid-kye.c:714:6: note: Assuming 'ret' is 0
           if (ret) {
               ^~~
   drivers/hid/hid-kye.c:714:2: note: Taking false branch
           if (ret) {
           ^
   drivers/hid/hid-kye.c:719:2: note: Control jumps to 'case 20501:'  at line 725
           switch (id->product) {
           ^
   drivers/hid/hid-kye.c:726:9: note: Calling 'kye_tablet_enable'
                   ret = kye_tablet_enable(hdev);
                         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-kye.c:669:2: note: 'report' declared without an initial value
           struct hid_report *report;
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-kye.c:673:2: note: Loop condition is false. Execution continues on line 679
           list_for_each(head, list) {
           ^
   include/linux/list.h:571:2: note: expanded from macro 'list_for_each'
           for (pos = (head)->next; pos != (head); pos = pos->next)
           ^
   drivers/hid/hid-kye.c:679:6: note: Assuming 'head' is not equal to 'list'
           if (head == list) {
               ^~~~~~~~~~~~
   drivers/hid/hid-kye.c:679:2: note: Taking false branch
           if (head == list) {
           ^
   drivers/hid/hid-kye.c:684:6: note: Access to field 'maxfield' results in a dereference of an undefined pointer value (loaded from variable 'report')
           if (report->maxfield < 1 || report->field[0]->report_count < 7) {
               ^~~~~~
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/iio/proximity/sx9310.c:630:17: warning: The left operand of '>>' is a garbage value [clang-analyzer-core.UndefinedBinaryOperatorResult]
           *val = pthresh >> (5 - regval);
                          ^
   drivers/iio/proximity/sx9310.c:679:6: note: Assuming field 'type' is equal to IIO_PROXIMITY
           if (chan->type != IIO_PROXIMITY)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/proximity/sx9310.c:679:2: note: Taking false branch
           if (chan->type != IIO_PROXIMITY)
           ^
   drivers/iio/proximity/sx9310.c:682:2: note: Control jumps to 'case IIO_EV_INFO_HYSTERESIS:'  at line 694
           switch (info) {
           ^
   drivers/iio/proximity/sx9310.c:695:10: note: Calling 'sx9310_read_hysteresis'
                   return sx9310_read_hysteresis(data, chan, val);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/proximity/sx9310.c:614:23: note: 'pthresh' declared without an initial value
           unsigned int regval, pthresh;
                                ^~~~~~~
   drivers/iio/proximity/sx9310.c:617:8: note: Calling 'sx9310_read_thresh'
           ret = sx9310_read_thresh(data, chan, &pthresh);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/proximity/sx9310.c:596:6: note: 'ret' is >= 0
           if (ret < 0)
               ^~~
   drivers/iio/proximity/sx9310.c:596:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/iio/proximity/sx9310.c:600:6: note: Assuming 'ret' is not equal to 0
           if (ret)
               ^~~
   drivers/iio/proximity/sx9310.c:600:2: note: Taking true branch
           if (ret)
           ^
   drivers/iio/proximity/sx9310.c:617:8: note: Returning from 'sx9310_read_thresh'
           ret = sx9310_read_thresh(data, chan, &pthresh);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/proximity/sx9310.c:618:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   drivers/iio/proximity/sx9310.c:618:2: note: Taking false branch
           if (ret < 0)
           ^
   drivers/iio/proximity/sx9310.c:622:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/iio/proximity/sx9310.c:622:2: note: Taking false branch
           if (ret)
           ^
   drivers/iio/proximity/sx9310.c:625:11: note: Taking false branch
           regval = FIELD_GET(SX9310_REG_PROX_CTRL10_HYST_MASK, regval);
                    ^
--
   net/caif/cfutill.c:84:2: note: Taking false branch
           caif_assert(layr != NULL);
           ^
   include/net/caif/caif_layer.h:29:2: note: expanded from macro 'caif_assert'
           if (!(assert)) {                                        \
           ^
   net/caif/cfutill.c:84:2: note: Loop condition is false.  Exiting loop
           caif_assert(layr != NULL);
           ^
   include/net/caif/caif_layer.h:27:33: note: expanded from macro 'caif_assert'
   #define caif_assert(assert)                                     \
                                                                   ^
   net/caif/cfutill.c:85:14: note: Assuming field 'dn' is equal to null
           caif_assert(layr->dn != NULL);
                       ^
   include/net/caif/caif_layer.h:29:8: note: expanded from macro 'caif_assert'
           if (!(assert)) {                                        \
                 ^~~~~~
   net/caif/cfutill.c:85:20: note: Field 'dn' is equal to null
           caif_assert(layr->dn != NULL);
                             ^
   net/caif/cfutill.c:85:2: note: Taking true branch
           caif_assert(layr->dn != NULL);
           ^
   include/net/caif/caif_layer.h:29:2: note: expanded from macro 'caif_assert'
           if (!(assert)) {                                        \
           ^
   net/caif/cfutill.c:85:2: note: Taking true branch
           caif_assert(layr->dn != NULL);
           ^
   include/net/caif/caif_layer.h:31:3: note: expanded from macro 'caif_assert'
                   WARN_ON(!(assert));                             \
                   ^
   include/asm-generic/bug.h:120:2: note: expanded from macro 'WARN_ON'
           if (unlikely(__ret_warn_on))                                    \
           ^
   net/caif/cfutill.c:85:2: note: Loop condition is false.  Exiting loop
           caif_assert(layr->dn != NULL);
           ^
   include/net/caif/caif_layer.h:31:3: note: expanded from macro 'caif_assert'
                   WARN_ON(!(assert));                             \
                   ^
   include/asm-generic/bug.h:121:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:86:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_printf(TAINT_WARN, NULL)
                                   ^
   include/asm-generic/bug.h:88:3: note: expanded from macro '__WARN_printf'
                   instrumentation_begin();                                \
                   ^
   include/linux/instrumentation.h:53:34: note: expanded from macro 'instrumentation_begin'
   # define instrumentation_begin()        do { } while(0)
                                           ^
   net/caif/cfutill.c:85:2: note: Loop condition is false.  Exiting loop
           caif_assert(layr->dn != NULL);
           ^
   include/net/caif/caif_layer.h:31:3: note: expanded from macro 'caif_assert'
                   WARN_ON(!(assert));                             \
                   ^
   include/asm-generic/bug.h:121:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:86:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_printf(TAINT_WARN, NULL)
                                   ^
   include/asm-generic/bug.h:90:3: note: expanded from macro '__WARN_printf'
                   instrumentation_end();                                  \
                   ^
   include/linux/instrumentation.h:54:33: note: expanded from macro 'instrumentation_end'
   # define instrumentation_end()          do { } while(0)
                                           ^
   net/caif/cfutill.c:85:2: note: Loop condition is false.  Exiting loop
           caif_assert(layr->dn != NULL);
           ^
   include/net/caif/caif_layer.h:31:3: note: expanded from macro 'caif_assert'
                   WARN_ON(!(assert));                             \
                   ^
   include/asm-generic/bug.h:121:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:86:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_printf(TAINT_WARN, NULL)
                                   ^
   include/asm-generic/bug.h:87:38: note: expanded from macro '__WARN_printf'
   #define __WARN_printf(taint, arg...) do {                               \
                                        ^
   net/caif/cfutill.c:85:2: note: Loop condition is false.  Exiting loop
           caif_assert(layr->dn != NULL);
           ^
   include/net/caif/caif_layer.h:27:33: note: expanded from macro 'caif_assert'
   #define caif_assert(assert)                                     \
                                                                   ^
   net/caif/cfutill.c:86:14: note: Access to field 'transmit' results in a dereference of a null pointer (loaded from field 'dn')
           caif_assert(layr->dn->transmit != NULL);
                       ^
   include/net/caif/caif_layer.h:29:8: note: expanded from macro 'caif_assert'
           if (!(assert)) {                                        \
                 ^~~~~~
   1 warning generated.
>> drivers/iio/imu/adis16480.c:169:8: warning: Excessive padding in 'struct adis16480' (40 padding bytes, where 8 is optimal). Optimal fields order: adis, data, chip_info, ext_clk, clk_mode, clk_freq, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adis16480 {
   ~~~~~~~^~~~~~~~~~~
   drivers/iio/imu/adis16480.c:169:8: note: Excessive padding in 'struct adis16480' (40 padding bytes, where 8 is optimal). Optimal fields order: adis, data, chip_info, ext_clk, clk_mode, clk_freq, consider reordering the fields or adding explicit padding members
   struct adis16480 {
   ~~~~~~~^~~~~~~~~~~
   1 warning generated.
   drivers/iio/imu/fxos8700_core.c:167:8: warning: Excessive padding in 'struct fxos8700_data' (50 padding bytes, where 18 is optimal). Optimal fields order: buf, regmap, trig, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct fxos8700_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/imu/fxos8700_core.c:167:8: note: Excessive padding in 'struct fxos8700_data' (50 padding bytes, where 18 is optimal). Optimal fields order: buf, regmap, trig, consider reordering the fields or adding explicit padding members
   struct fxos8700_data {
   ~~~~~~~^~~~~~~~~~~~~~~
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   net/caif/cfsrvl.c:99:14: warning: Access to field 'dn' results in a dereference of a null pointer (loaded from variable 'layr') [clang-analyzer-core.NullDereference]
           caif_assert(layr->dn != NULL);
                       ^
   include/net/caif/caif_layer.h:29:8: note: expanded from macro 'caif_assert'
           if (!(assert)) {                                        \
                 ^~~~~~
   net/caif/cfsrvl.c:96:27: note: Left side of '&&' is false
           struct cfsrvl *service = container_obj(layr);
                                    ^
   net/caif/cfsrvl.c:25:29: note: expanded from macro 'container_obj'
   #define container_obj(layr) container_of(layr, struct cfsrvl, layer)
                               ^
   include/linux/kernel.h:704:61: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                                                                      ^
   net/caif/cfsrvl.c:96:27: note: Taking false branch
           struct cfsrvl *service = container_obj(layr);
                                    ^
   net/caif/cfsrvl.c:25:29: note: expanded from macro 'container_obj'
   #define container_obj(layr) container_of(layr, struct cfsrvl, layer)
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
   net/caif/cfsrvl.c:96:27: note: Loop condition is false.  Exiting loop
           struct cfsrvl *service = container_obj(layr);
                                    ^
   net/caif/cfsrvl.c:25:29: note: expanded from macro 'container_obj'
   #define container_obj(layr) container_of(layr, struct cfsrvl, layer)
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
   net/caif/cfsrvl.c:98:14: note: Assuming 'layr' is equal to null
           caif_assert(layr != NULL);
                       ^
   include/net/caif/caif_layer.h:29:8: note: expanded from macro 'caif_assert'
           if (!(assert)) {                                        \
                 ^~~~~~

vim +169 drivers/iio/imu/adis16480.c

326e2357553d39 Stefan Popa        2019-03-11  168  
2f3abe6cbb6c96 Lars-Peter Clausen 2012-11-20 @169  struct adis16480 {
2f3abe6cbb6c96 Lars-Peter Clausen 2012-11-20  170  	const struct adis16480_chip_info *chip_info;
2f3abe6cbb6c96 Lars-Peter Clausen 2012-11-20  171  
2f3abe6cbb6c96 Lars-Peter Clausen 2012-11-20  172  	struct adis adis;
326e2357553d39 Stefan Popa        2019-03-11  173  	struct clk *ext_clk;
326e2357553d39 Stefan Popa        2019-03-11  174  	enum adis16480_clock_mode clk_mode;
326e2357553d39 Stefan Popa        2019-03-11  175  	unsigned int clk_freq;
941f130881fa90 Nuno Sa            2021-04-22  176  	/* Alignment needed for the timestamp */
941f130881fa90 Nuno Sa            2021-04-22  177  	__be16 data[ADIS16495_BURST_MAX_DATA] __aligned(8);
2f3abe6cbb6c96 Lars-Peter Clausen 2012-11-20  178  };
2f3abe6cbb6c96 Lars-Peter Clausen 2012-11-20  179  

:::::: The code at line 169 was first introduced by commit
:::::: 2f3abe6cbb6c963ac790b40936b6761c9f0497b4 iio:imu: Add support for the ADIS16480 and similar IMUs

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
