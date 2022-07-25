Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0657F9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiGYG56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiGYG5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:57:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD311C2A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658732226; x=1690268226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rNqL097KkP49/RUKA8IsyqFJAmEU9oEkXv00h5AVqoc=;
  b=eiId/Yd8PTC+i5+PiM9BK1hsKYavnwjY0Ai1DohAPTJrL0d2tp1g8ig2
   Qz/rXpBMRKfQeF/zMCykqK+TUiar3ERsqJbW+muESuq1Vrw55lt6JW9tD
   /naSvaenYi/hiTa3e8xgSCIl1VHelfiSmeyL8KhNDwtgr4zH43sD1xVZ8
   l1QAA4WS0/qSEvo1s6G6ATREU9mIBLzonc7Vu2MY3y87M0RiRbNMecR3n
   X9SRLvjBiS9vS4MLYYMNiHs+8DNpJlGhbVwaNdTLiSEiiI8Pu80BwU+43
   zGmR44mc7M39fN3Aqij2MTiCuKFCUhhvtWxkr7PmmN5aW7nJIEHvkrITV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274491709"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="274491709"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 23:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="926782849"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 23:57:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFs1X-0004oL-0Z;
        Mon, 25 Jul 2022 06:57:03 +0000
Date:   Mon, 25 Jul 2022 14:56:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/adc/max1027.c:268:8: warning: Excessive padding in
 'struct max1027_state' (55 padding bytes, where 23 is optimal). Optimal
 fields order: reg, info, spi, trig, buffer, lock, complete, consider
 reordering the fields or adding explicit padding me...
Message-ID: <202207251400.INBNhoyY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 1f7b4048b31b2b1aba9d297d34055dac17485823 iio: adc: max1027: Use the EOC IRQ when populated for single reads
date:   9 months ago
config: arm-randconfig-c002-20220718 (https://download.01.org/0day-ci/archive/20220725/202207251400.INBNhoyY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f7b4048b31b2b1aba9d297d34055dac17485823
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1f7b4048b31b2b1aba9d297d34055dac17485823
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   drivers/iio/adc/stm32-adc-core.c:325:11: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
           u32 ier, offset = stm32_adc_offset[adc];
                    ^
   drivers/iio/adc/stm32-adc-core.c:355:14: note: Assuming 'i' is < field 'num_irqs'
           for (i = 0; i < priv->cfg->num_irqs; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:355:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < priv->cfg->num_irqs; i++) {
           ^
   drivers/iio/adc/stm32-adc-core.c:356:8: note: Assuming the condition is false
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:45: note: Left side of '&&' is false
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                                                             ^
   drivers/iio/adc/stm32-adc-core.c:358:9: note: Assuming the condition is false
                        (status & priv->cfg->regs->ovr_msk[i]))
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:3: note: Taking false branch
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                   ^
   drivers/iio/adc/stm32-adc-core.c:355:14: note: Assuming 'i' is < field 'num_irqs'
           for (i = 0; i < priv->cfg->num_irqs; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:355:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < priv->cfg->num_irqs; i++) {
           ^
   drivers/iio/adc/stm32-adc-core.c:356:8: note: Assuming the condition is false
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:45: note: Left side of '&&' is false
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                                                             ^
   drivers/iio/adc/stm32-adc-core.c:358:9: note: Assuming the condition is false
                        (status & priv->cfg->regs->ovr_msk[i]))
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:3: note: Taking false branch
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                   ^
   drivers/iio/adc/stm32-adc-core.c:355:14: note: Assuming 'i' is < field 'num_irqs'
           for (i = 0; i < priv->cfg->num_irqs; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:355:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < priv->cfg->num_irqs; i++) {
           ^
   drivers/iio/adc/stm32-adc-core.c:356:8: note: Assuming the condition is false
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:45: note: Left side of '&&' is false
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                                                             ^
   drivers/iio/adc/stm32-adc-core.c:358:9: note: Assuming the condition is false
                        (status & priv->cfg->regs->ovr_msk[i]))
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:3: note: Taking false branch
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                   ^
   drivers/iio/adc/stm32-adc-core.c:355:39: note: The value 3 is assigned to 'i'
           for (i = 0; i < priv->cfg->num_irqs; i++) {
                                                ^~~
   drivers/iio/adc/stm32-adc-core.c:355:14: note: Assuming 'i' is < field 'num_irqs'
           for (i = 0; i < priv->cfg->num_irqs; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:355:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < priv->cfg->num_irqs; i++) {
           ^
   drivers/iio/adc/stm32-adc-core.c:356:8: note: Assuming the condition is true
                   if ((status & priv->cfg->regs->eoc_msk[i] &&
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:356:8: note: Left side of '&&' is true
   drivers/iio/adc/stm32-adc-core.c:357:36: note: Passing the value 3 via 2nd parameter 'adc'
                        stm32_adc_eoc_enabled(priv, i)) ||
                                                    ^
   drivers/iio/adc/stm32-adc-core.c:357:8: note: Calling 'stm32_adc_eoc_enabled'
                        stm32_adc_eoc_enabled(priv, i)) ||
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/stm32-adc-core.c:325:11: note: Assigned value is garbage or undefined
           u32 ier, offset = stm32_adc_offset[adc];
                    ^        ~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   2 warnings generated.
   drivers/media/i2c/ov2680.c:424:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
           ret = ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
           ^
   drivers/media/i2c/ov2680.c:424:2: note: Value stored to 'ret' is never read
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   2 warnings generated.
>> drivers/iio/adc/max1027.c:268:8: warning: Excessive padding in 'struct max1027_state' (55 padding bytes, where 23 is optimal). Optimal fields order: reg, info, spi, trig, buffer, lock, complete, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct max1027_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/adc/max1027.c:268:8: note: Excessive padding in 'struct max1027_state' (55 padding bytes, where 23 is optimal). Optimal fields order: reg, info, spi, trig, buffer, lock, complete, consider reordering the fields or adding explicit padding members
   struct max1027_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/adc/max1027.c:304:13: warning: The result of the left shift is undefined because the left operand is negative [clang-analyzer-core.UndefinedBinaryOperatorResult]
           st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
                      ^
   drivers/iio/adc/max1027.c:38:32: note: expanded from macro 'MAX1027_CHAN'
   #define MAX1027_CHAN(n)   ((n) << 3)
                                  ^
   drivers/iio/adc/max1027.c:456:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/iio/adc/max1027.c:456:2: note: Taking false branch
           if (ret)
           ^
   drivers/iio/adc/max1027.c:459:6: note: 'state' is true
           if (state) {
               ^~~~~
   drivers/iio/adc/max1027.c:459:2: note: Taking true branch
           if (state) {
           ^
   drivers/iio/adc/max1027.c:460:9: note: Calling 'max1027_configure_chans_and_start'
                   ret = max1027_configure_chans_and_start(indio_dev);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/max1027.c:304:13: note: The result of the left shift is undefined because the left operand is negative
           st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
                      ^
   drivers/iio/adc/max1027.c:38:32: note: expanded from macro 'MAX1027_CHAN'
   #define MAX1027_CHAN(n)   ((n) << 3)
                              ~~~ ^
   1 warning generated.
   drivers/iio/adc/max11100.c:31:8: warning: Excessive padding in 'struct max11100_state' (53 padding bytes, where 21 is optimal). Optimal fields order: buffer, vref_reg, spi, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct max11100_state {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/iio/adc/max11100.c:31:8: note: Excessive padding in 'struct max11100_state' (53 padding bytes, where 21 is optimal). Optimal fields order: buffer, vref_reg, spi, consider reordering the fields or adding explicit padding members
   struct max11100_state {
   ~~~~~~~^~~~~~~~~~~~~~~~
   10 warnings generated.
   kernel/sched/fair.c:676:15: warning: Value stored to 'nr_running' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           unsigned int nr_running = cfs_rq->nr_running;
                        ^~~~~~~~~~   ~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:676:15: note: Value stored to 'nr_running' during its initialization is never read
           unsigned int nr_running = cfs_rq->nr_running;
                        ^~~~~~~~~~   ~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:7084:37: warning: Access to field 'vruntime' results in a dereference of a null pointer (loaded from variable 'se') [clang-analyzer-core.NullDereference]
           s64 gran, vdiff = curr->vruntime - se->vruntime;
                                              ^
   kernel/sched/fair.c:7403:9: note: Calling 'pick_next_task_fair'
           return pick_next_task_fair(rq, NULL, NULL);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:7266:7: note: Calling 'sched_fair_runnable'
           if (!sched_fair_runnable(rq))
                ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/sched.h:2238:9: note: Assuming field 'nr_running' is > 0
           return rq->cfs.nr_running > 0;
                  ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/sched.h:2238:2: note: Returning without writing to 'rq->cfs.tasks_timeline.rb_leftmost', which participates in a condition later
           return rq->cfs.nr_running > 0;
           ^
   kernel/sched/sched.h:2238:2: note: Returning without writing to 'rq->cfs.next', which participates in a condition later
   kernel/sched/fair.c:7266:7: note: Returning from 'sched_fair_runnable'
           if (!sched_fair_runnable(rq))
                ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:7266:2: note: Taking false branch
           if (!sched_fair_runnable(rq))
           ^
   kernel/sched/fair.c:7270:7: note: 'prev' is null
           if (!prev || prev->sched_class != &fair_sched_class)
                ^~~~
   kernel/sched/fair.c:7270:12: note: Left side of '||' is true
           if (!prev || prev->sched_class != &fair_sched_class)
                     ^
   kernel/sched/fair.c:7271:3: note: Control jumps to line 7347
                   goto simple;
                   ^
   kernel/sched/fair.c:7347:6: note: 'prev' is null
           if (prev)
               ^~~~
   kernel/sched/fair.c:7347:2: note: Taking false branch
           if (prev)
           ^
   kernel/sched/fair.c:7351:33: note: Passing null pointer value via 2nd parameter 'curr'
                   se = pick_next_entity(cfs_rq, NULL);
                                                 ^
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   kernel/sched/fair.c:7351:8: note: Calling 'pick_next_entity'
                   se = pick_next_entity(cfs_rq, NULL);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:4526:30: note: Calling '__pick_first_entity'
           struct sched_entity *left = __pick_first_entity(cfs_rq);
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:592:6: note: Assuming 'left' is null
           if (!left)
               ^~~~~
   kernel/sched/fair.c:592:2: note: Taking true branch
           if (!left)

vim +268 drivers/iio/adc/max1027.c

fc167f62483325a Philippe Reynes 2014-06-14  267  
fc167f62483325a Philippe Reynes 2014-06-14 @268  struct max1027_state {
fc167f62483325a Philippe Reynes 2014-06-14  269  	const struct max1027_chip_info	*info;
fc167f62483325a Philippe Reynes 2014-06-14  270  	struct spi_device		*spi;
fc167f62483325a Philippe Reynes 2014-06-14  271  	struct iio_trigger		*trig;
fc167f62483325a Philippe Reynes 2014-06-14  272  	__be16				*buffer;
fc167f62483325a Philippe Reynes 2014-06-14  273  	struct mutex			lock;
1f7b4048b31b2b1 Miquel Raynal   2021-09-21  274  	struct completion		complete;
fc167f62483325a Philippe Reynes 2014-06-14  275  
fc167f62483325a Philippe Reynes 2014-06-14  276  	u8				reg ____cacheline_aligned;
fc167f62483325a Philippe Reynes 2014-06-14  277  };
fc167f62483325a Philippe Reynes 2014-06-14  278  

:::::: The code at line 268 was first introduced by commit
:::::: fc167f62483325aea9137e70e6773fe7ad1ca2ac iio: add support of the max1027

:::::: TO: Philippe Reynes <tremyfr@yahoo.fr>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
