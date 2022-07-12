Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF8570F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiGLAo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiGLAox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:44:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF3D22281
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657586691; x=1689122691;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YbDhhw0+O4IzuQgTHPbqBXBKPnl7K3467aw6SoRp1ws=;
  b=L71SJ3gegh4/d+UxUfc+3Nwiy21Rb+VquTaY/SNFKX+6tjBku3e+fcJc
   qO2Jy+vckJfNL/tHU9tVo98ioyjwaw57JCDjDKktDzGC4bawdGHlZUfMY
   cM3g13JKxY0FvfZx7ejkEAKqjPD4ZWSvr2C678u7gSfykKlmE4vJ1hkVs
   YfVxQqLnvziFQvz8k8lv7xGjRxne4CQAobdOc/Dz1GTLMe3rw2OjWtEBu
   qCVeoTTT3R5SS9X4F1I3cZWMtHkugAT2+2M2+BFkenBJJ/Pw8W+CCRaci
   IXocXaNt9hOQ85040MtgEatv35EFRUiEkdvGG1WvNX1mxzjDMV9tlaJTi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283559434"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="283559434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="569988437"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2022 17:44:48 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB41A-0001RH-1X;
        Tue, 12 Jul 2022 00:44:48 +0000
Date:   Tue, 12 Jul 2022 08:44:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/iio/potentiometer/ad5110.c:59:8: warning: Excessive padding
 in 'struct ad5110_data' (107 padding bytes, where 43 is optimal). Optimal
 fields order: buf, tol, client, cfg, lock, enable, consider reordering the
 fields or adding explicit padding memb...
Message-ID: <202207120820.CgmP4eFQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5a29232d870d9e63fe5ff30b081be6ea7cc2465d
commit: d03a74bfaccefcf271bf8e889c31229aa521cd66 iio: potentiometer: Add driver support for AD5110
date:   11 months ago
config: arm-randconfig-c002-20220702 (https://download.01.org/0day-ci/archive/20220712/202207120820.CgmP4eFQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d03a74bfaccefcf271bf8e889c31229aa521cd66
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d03a74bfaccefcf271bf8e889c31229aa521cd66
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
   sound/core/control.c:2197:13: note: Loop condition is false.  Exiting loop
                   control = snd_kcontrol(card->controls.next);
                             ^
   include/sound/control.h:87:25: note: expanded from macro 'snd_kcontrol'
   #define snd_kcontrol(n) list_entry(n, struct snd_kcontrol, list)
                           ^
   include/linux/list.h:511:2: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ^
   include/linux/kernel.h:495:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:306:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   sound/core/control.c:2198:3: note: Use of memory after it is freed
                   snd_ctl_remove(card, control);
                   ^                    ~~~~~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   Suppressed 17 warnings (16 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   Suppressed 17 warnings (16 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   drivers/iio/accel/sca3000.c:163:8: warning: Excessive padding in 'struct sca3000_state' (94 padding bytes, where 30 is optimal). Optimal fields order: tx, last_timestamp, us, info, mo_det_use_count, lock, rx, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct sca3000_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/accel/sca3000.c:163:8: note: Excessive padding in 'struct sca3000_state' (94 padding bytes, where 30 is optimal). Optimal fields order: tx, last_timestamp, us, info, mo_det_use_count, lock, rx, consider reordering the fields or adding explicit padding members
   struct sca3000_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   Suppressed 17 warnings (17 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   Suppressed 17 warnings (17 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/iio/magnetometer/yamaha-yas530.c:680:29: warning: Value stored to 'c' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct yas5xx_calibration *c = &yas5xx->calibration;
                                      ^   ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/magnetometer/yamaha-yas530.c:680:29: note: Value stored to 'c' during its initialization is never read
           struct yas5xx_calibration *c = &yas5xx->calibration;
                                      ^   ~~~~~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/iio/potentiometer/ad5110.c:59:8: warning: Excessive padding in 'struct ad5110_data' (107 padding bytes, where 43 is optimal). Optimal fields order: buf, tol, client, cfg, lock, enable, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad5110_data {
   ~~~~~~~^~~~~~~~~~~~~
   drivers/iio/potentiometer/ad5110.c:59:8: note: Excessive padding in 'struct ad5110_data' (107 padding bytes, where 43 is optimal). Optimal fields order: buf, tol, client, cfg, lock, enable, consider reordering the fields or adding explicit padding members
   struct ad5110_data {
   ~~~~~~~^~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/mtd/devices/phram.c:231:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(str, val);
           ^~~~~~
   drivers/mtd/devices/phram.c:231:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(str, val);
           ^~~~~~
   drivers/mtd/devices/phram.c:315:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(phram_paramline, val);
           ^~~~~~
   drivers/mtd/devices/phram.c:315:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(phram_paramline, val);
           ^~~~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   sound/core/seq/seq_prioq.c:292:16: warning: Access to field 'next' results in a dereference of a null pointer (loaded from variable 'prev') [clang-analyzer-core.NullDereference]
                                   prev->next = cell->next;
                                   ~~~~       ^
   sound/core/seq/seq_prioq.c:279:2: note: 'prev' initialized to a null pointer value
           struct snd_seq_event_cell *prev = NULL;
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/seq/seq_prioq.c:283:2: note: Loop condition is false.  Exiting loop
           spin_lock_irqsave(&f->lock, flags);
           ^
   include/linux/spinlock.h:384:2: note: expanded from macro 'spin_lock_irqsave'
           raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
           ^
   include/linux/spinlock.h:250:2: note: expanded from macro 'raw_spin_lock_irqsave'
           do {                                            \
           ^
   sound/core/seq/seq_prioq.c:283:2: note: Loop condition is false.  Exiting loop
           spin_lock_irqsave(&f->lock, flags);
           ^
   include/linux/spinlock.h:382:43: note: expanded from macro 'spin_lock_irqsave'
   #define spin_lock_irqsave(lock, flags)                          \
                                                                   ^
   sound/core/seq/seq_prioq.c:285:2: note: Loop condition is true.  Entering loop body
           while (cell) {
           ^
   sound/core/seq/seq_prioq.c:287:3: note: Taking true branch
                   if (prioq_match(cell, client, timestamp)) {
                   ^
   sound/core/seq/seq_prioq.c:289:8: note: 'cell' is equal to field 'head'
                           if (cell == f->head) {
                               ^~~~
   sound/core/seq/seq_prioq.c:289:4: note: Taking true branch
                           if (cell == f->head) {
                           ^
   sound/core/seq/seq_prioq.c:294:8: note: Assuming 'cell' is not equal to field 'tail'
                           if (cell == f->tail)
                               ^~~~~~~~~~~~~~~
   sound/core/seq/seq_prioq.c:294:4: note: Taking false branch
                           if (cell == f->tail)
                           ^
   sound/core/seq/seq_prioq.c:299:8: note: 'freefirst' is equal to NULL
                           if (freefirst == NULL) {
                               ^~~~~~~~~
   sound/core/seq/seq_prioq.c:299:4: note: Taking true branch
                           if (freefirst == NULL) {
                           ^
   sound/core/seq/seq_prioq.c:285:2: note: Loop condition is true.  Entering loop body
           while (cell) {
           ^
   sound/core/seq/seq_prioq.c:287:3: note: Taking true branch
                   if (prioq_match(cell, client, timestamp)) {
                   ^
   sound/core/seq/seq_prioq.c:289:8: note: 'cell' is equal to field 'head'
                           if (cell == f->head) {
                               ^~~~
   sound/core/seq/seq_prioq.c:289:4: note: Taking true branch
                           if (cell == f->head) {
--
                   ^               ~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   drivers/iio/adc/hi8435.c:43:8: warning: Excessive padding in 'struct hi8435_priv' (89 padding bytes, where 25 is optimal). Optimal fields order: reg_buffer, spi, event_scan_mask, event_prev_val, threshold_lo, threshold_hi, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct hi8435_priv {
   ~~~~~~~^~~~~~~~~~~~~
   drivers/iio/adc/hi8435.c:43:8: note: Excessive padding in 'struct hi8435_priv' (89 padding bytes, where 25 is optimal). Optimal fields order: reg_buffer, spi, event_scan_mask, event_prev_val, threshold_lo, threshold_hi, lock, consider reordering the fields or adding explicit padding members
   struct hi8435_priv {
   ~~~~~~~^~~~~~~~~~~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/power/supply/bq256xx_charger.c:1521:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
           ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/bq256xx_charger.c:1521:2: note: Value stored to 'ret' is never read
           ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   drivers/power/supply/sc2731_charger.c:450:14: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
           info->limit = min;
                       ^ ~~~
   drivers/power/supply/sc2731_charger.c:439:15: note: 'min' declared without an initial value
           unsigned int min, max;
                        ^~~
   drivers/power/supply/sc2731_charger.c:446:6: note: Assuming field 'chg_state' is equal to USB_CHARGER_PRESENT
           if (info->usb_phy->chg_state != USB_CHARGER_PRESENT)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:446:2: note: Taking false branch
           if (info->usb_phy->chg_state != USB_CHARGER_PRESENT)
           ^
   drivers/power/supply/sc2731_charger.c:449:2: note: Calling 'usb_phy_get_charger_current'
           usb_phy_get_charger_current(info->usb_phy, &min, &max);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb/phy.h:279:1: note: Returning without writing to '*min'
   }
   ^
   drivers/power/supply/sc2731_charger.c:449:2: note: Returning from 'usb_phy_get_charger_current'
           usb_phy_get_charger_current(info->usb_phy, &min, &max);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:450:14: note: Assigned value is garbage or undefined
           info->limit = min;
                       ^ ~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   Suppressed 17 warnings (17 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/iio/magnetometer/yamaha-yas530.c:680:29: warning: Value stored to 'c' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct yas5xx_calibration *c = &yas5xx->calibration;
                                      ^   ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/magnetometer/yamaha-yas530.c:680:29: note: Value stored to 'c' during its initialization is never read
           struct yas5xx_calibration *c = &yas5xx->calibration;
                                      ^   ~~~~~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/iio/potentiometer/ad5110.c:59:8: warning: Excessive padding in 'struct ad5110_data' (107 padding bytes, where 43 is optimal). Optimal fields order: buf, tol, client, cfg, lock, enable, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad5110_data {
   ~~~~~~~^~~~~~~~~~~~~
   drivers/iio/potentiometer/ad5110.c:59:8: note: Excessive padding in 'struct ad5110_data' (107 padding bytes, where 43 is optimal). Optimal fields order: buf, tol, client, cfg, lock, enable, consider reordering the fields or adding explicit padding members
   struct ad5110_data {
   ~~~~~~~^~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   drivers/iio/potentiometer/max5481.c:44:8: warning: Excessive padding in 'struct max5481_data' (117 padding bytes, where 53 is optimal). Optimal fields order: msg, spi, cfg, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct max5481_data {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/potentiometer/max5481.c:44:8: note: Excessive padding in 'struct max5481_data' (117 padding bytes, where 53 is optimal). Optimal fields order: msg, spi, cfg, consider reordering the fields or adding explicit padding members
   struct max5481_data {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   25 warnings generated.
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:148:15: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage [clang-analyzer-core.uninitialized.Assign]
                           temp[i][0] |= (value & 0x00ff) >> 0;
                           ~~~~~~~~~~ ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:118:34: note: Assuming 'type' is not equal to PERIODIC_TRAINING_UPDATE
           bool periodic_training_update = type == PERIODIC_TRAINING_UPDATE;
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:123:21: note: Assuming 'type' is not equal to DVFS_UPDATE
           bool dvfs_update = type == DVFS_UPDATE;
                              ^~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:125:18: note: Assuming 'type' is equal to DVFS_PT1
           bool dvfs_pt1 = type == DVFS_PT1;
                           ^~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:133:6: note: 'dvfs_pt1' is true
           if (dvfs_pt1 || periodic_training_update) {
               ^~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:133:15: note: Left side of '||' is true
           if (dvfs_pt1 || periodic_training_update) {
                        ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:136:15: note: Assuming 'i' is >= field 'num_channels'
                   for (i = 0; i < emc->num_channels; i++) {
                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:136:3: note: Loop condition is false. Execution continues on line 145
                   for (i = 0; i < emc->num_channels; i++) {
                   ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:147:15: note: Assuming 'i' is < field 'num_channels'
                   for (i = 0; i < emc->num_channels; i++) {
                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:147:3: note: Loop condition is true.  Entering loop body
                   for (i = 0; i < emc->num_channels; i++) {
                   ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:148:15: note: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage
                           temp[i][0] |= (value & 0x00ff) >> 0;
                           ~~~~~~~~~~ ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:157:36: warning: The right operand of '*' is a garbage value [clang-analyzer-core.UndefinedBinaryOperatorResult]
                   cval /= last_timing_rate_mhz * 2 * temp[0][0];
                                                    ^ ~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:118:34: note: Assuming 'type' is not equal to PERIODIC_TRAINING_UPDATE
           bool periodic_training_update = type == PERIODIC_TRAINING_UPDATE;
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:123:21: note: Assuming 'type' is not equal to DVFS_UPDATE
           bool dvfs_update = type == DVFS_UPDATE;
                              ^~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:125:18: note: Assuming 'type' is equal to DVFS_PT1
           bool dvfs_pt1 = type == DVFS_PT1;
                           ^~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:133:6: note: 'dvfs_pt1' is true
           if (dvfs_pt1 || periodic_training_update) {
               ^~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:133:15: note: Left side of '||' is true
           if (dvfs_pt1 || periodic_training_update) {
                        ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:136:15: note: Assuming 'i' is >= field 'num_channels'
                   for (i = 0; i < emc->num_channels; i++) {
                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:136:3: note: Loop condition is false. Execution continues on line 145
                   for (i = 0; i < emc->num_channels; i++) {
                   ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:147:15: note: Assuming 'i' is >= field 'num_channels'
                   for (i = 0; i < emc->num_channels; i++) {
                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:147:3: note: Loop condition is false. Execution continues on line 154
                   for (i = 0; i < emc->num_channels; i++) {
                   ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:154:6: note: 'dvfs_pt1' is true
           if (dvfs_pt1 || periodic_training_update) {
               ^~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:154:15: note: Left side of '||' is true
           if (dvfs_pt1 || periodic_training_update) {
                        ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:157:36: note: The right operand of '*' is a garbage value
                   cval /= last_timing_rate_mhz * 2 * temp[0][0];
                                                    ^ ~~~~~~~~~~
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:283:15: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage [clang-analyzer-core.uninitialized.Assign]
                           temp[i][0] |= (value & 0x00ff) >> 0;

vim +59 drivers/iio/potentiometer/ad5110.c

    58	
  > 59	struct ad5110_data {
    60		struct i2c_client       *client;
    61		s16			tol;		/* resistor tolerance */
    62		bool			enable;
    63		struct mutex            lock;
    64		const struct ad5110_cfg	*cfg;
    65		/*
    66		 * DMA (thus cache coherency maintenance) requires the
    67		 * transfer buffers to live in their own cache lines.
    68		 */
    69		u8			buf[2] ____cacheline_aligned;
    70	};
    71	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
