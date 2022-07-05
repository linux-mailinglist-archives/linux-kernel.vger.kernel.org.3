Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB15674B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiGEQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiGEQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:45:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F515717
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657039548; x=1688575548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6dSDS34h0pM2lODMFbi64forCxsiFVDGZK1rQcFQaUU=;
  b=aer+wAZrZWIX61NZ5rEtIYv+4AIxJ7668tRtz1qL7KBu43yHDasjS5RY
   +0rs+z5am8iyUbZuWzZQVk27M668YHdvcfWJUXFr4Ifys1BCv05wV0EBI
   CaBPSzOxfVpdeogQUqb3ldHBUp4HdDJTdx5YBnBQCdwNnH93u7gy/KMIn
   BesPe0KKyLX+6pIS0pgwRQ5T7m/wqNGi0G3uc/JD3V+n834vrnylEa6c4
   Qt8Mnm+y5QFyNLe242nvRO2laBwVAx8Hqom/pdT6Ze8FgEKd3fwIr+3cI
   t6fryLjGdF/LJJ7Ovm8n3w+lFMniHgLoOo//piy34ijejthaSqjc+wmdz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263823941"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="263823941"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 09:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="567686766"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 09:45:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8lgH-000JNl-Cy;
        Tue, 05 Jul 2022 16:45:45 +0000
Date:   Wed, 6 Jul 2022 00:45:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: drivers/iio/adc/ad7476.c:29:8: warning: Excessive padding in 'struct
 ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal fields
 order: reset, channel, convst_channel, int_vref_uv, has_vref, has_vdrive,
 consider reordering the fields or addin...
Message-ID: <202207060054.o8GrfMhS-lkp@intel.com>
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
head:   c1084b6c5620a743f86947caca66d90f24060f56
commit: 7bf50a968a1cd02728e9120ad0216dc80f7a6fb0 iio:adc:ad7476: Handle the different regulators used by various parts.
date:   1 year, 2 months ago
config: s390-randconfig-c005-20220703 (https://download.01.org/0day-ci/archive/20220706/202207060054.o8GrfMhS-lkp@intel.com/config)
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
                                    ^
   include/linux/spinlock_api_smp.h:161:2: note: Calling 'should_resched'
           preempt_enable();
           ^
   include/linux/preempt.h:195:15: note: expanded from macro 'preempt_enable'
           if (unlikely(preempt_count_dec_and_test())) \
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:160:27: note: expanded from macro 'preempt_count_dec_and_test'
           ({ preempt_count_sub(1); should_resched(0); })
                                    ^~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   arch/s390/include/asm/preempt.h:73:18: note: Left side of '||' is false
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:290:3: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
            ^
   arch/s390/include/asm/preempt.h:73:18: note: Left side of '||' is false
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:290:3: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
            ^
   arch/s390/include/asm/preempt.h:73:18: note: Left side of '||' is true
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:291:28: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                                     ^
   arch/s390/include/asm/preempt.h:73:18: note: Taking false branch
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:2: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
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
   arch/s390/include/asm/preempt.h:73:18: note: Loop condition is false.  Exiting loop
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:2: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
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
   arch/s390/include/asm/preempt.h:73:18: note: Dereference of null pointer
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
           ^
   include/asm-generic/rwonce.h:44:24: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                           ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   Suppressed 4 warnings (4 in non-user code).
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
   17 warnings generated.
   Suppressed 17 warnings (5 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   18 warnings generated.
   drivers/i3c/master/mipi-i3c-hci/ext_caps.c:78:7: warning: Value stored to 'mode_entry' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
                   u32 mode_entry = readl(base);
                       ^~~~~~~~~~
   drivers/i3c/master/mipi-i3c-hci/ext_caps.c:78:7: note: Value stored to 'mode_entry' during its initialization is never read
                   u32 mode_entry = readl(base);
                       ^~~~~~~~~~
   Suppressed 17 warnings (5 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   19 warnings generated.
   drivers/s390/cio/qdio_thinint.c:100:17: warning: Dereference of null pointer [clang-analyzer-core.NullDereference]
           u64 irq_time = S390_lowcore.int_clock;
                          ^
   arch/s390/include/asm/lowcore.h:192:22: note: expanded from macro 'S390_lowcore'
   #define S390_lowcore (*((struct lowcore *) 0))
                        ^
   drivers/s390/cio/qdio_thinint.c:100:17: note: Dereference of null pointer
           u64 irq_time = S390_lowcore.int_clock;
                          ^
   arch/s390/include/asm/lowcore.h:192:22: note: expanded from macro 'S390_lowcore'
   #define S390_lowcore (*((struct lowcore *) 0))
                        ^
   Suppressed 18 warnings (6 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   19 warnings generated.
   arch/s390/include/asm/preempt.h:73:18: warning: Dereference of null pointer [clang-analyzer-core.NullDereference]
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
           ^
   include/asm-generic/rwonce.h:44:24: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                           ^
   drivers/s390/cio/qdio_setup.c:495:2: note: Calling 'spin_unlock_irq'
           spin_unlock_irq(get_ccwdev_lock(cdev));
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:404:2: note: Calling '__raw_spin_unlock_irq'
           raw_spin_unlock_irq(&lock->rlock);
           ^
   include/linux/spinlock.h:285:35: note: expanded from macro 'raw_spin_unlock_irq'
   #define raw_spin_unlock_irq(lock)       _raw_spin_unlock_irq(lock)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_api_smp.h:79:36: note: expanded from macro '_raw_spin_unlock_irq'
   #define _raw_spin_unlock_irq(lock) __raw_spin_unlock_irq(lock)
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_api_smp.h:166:2: note: Loop condition is false.  Exiting loop
           spin_release(&lock->dep_map, _RET_IP_);
           ^
   include/linux/lockdep.h:540:30: note: expanded from macro 'spin_release'
   #define spin_release(l, i)                      lock_release(l, i)
                                                   ^
   include/linux/lockdep.h:360:31: note: expanded from macro 'lock_release'
   # define lock_release(l, i)                     do { } while (0)
                                                   ^
   include/linux/spinlock_api_smp.h:168:2: note: Loop condition is false.  Exiting loop
           local_irq_enable();
           ^
   include/linux/irqflags.h:235:28: note: expanded from macro 'local_irq_enable'
   #define local_irq_enable()      do { raw_local_irq_enable(); } while (0)
                                   ^
   include/linux/spinlock_api_smp.h:169:2: note: Calling 'should_resched'
           preempt_enable();

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
