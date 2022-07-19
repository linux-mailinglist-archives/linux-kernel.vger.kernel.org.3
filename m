Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385CF57A5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiGSRre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiGSRra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:47:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C554AC7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658252849; x=1689788849;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QID1S/HCrnkT3/N5OpddMuCNcG4aYv3bv94xsjNpqYE=;
  b=QwHn8VSLmLdoZAEcKZBhxnw589w/nYqzOGbz7qpN0L2ci976B0Ijrsbe
   trPanCWgv/BtOal4L2F69QkDjFqeoSuX2cXVwYYtrw+LnmYhsHh1mRddc
   faw7E6i0tT//6LQEHvPQiNXgVS0nOyKMIP5QAx/OIkC5J5Ls/iJHVVoM8
   pEPFIuqMdxrcI2zsCOaC3FPU2tQF8nT/nvuwyWG1Rabzr+FqoNgfGOHLW
   MLOCrKBSA6R8rmF1Q7S92sdzjAmy4w4KhMn/hxnLO2omAlfRJhOHS3/qM
   pAgHMb/ocuUMezlyodHrUs2+95g/5LTquygHGotYR6qAGUJtMIPFq/W3l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="287709453"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="287709453"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="572947439"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2022 10:47:23 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDrJa-0005rm-So;
        Tue, 19 Jul 2022 17:47:22 +0000
Date:   Wed, 20 Jul 2022 01:46:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/dac/ad5766.c:109:8: warning: Excessive padding in
 'struct ad5766_state' (44 padding bytes, where 12 is optimal). Optimal
 fields order: data, spi, chip_info, gpio_reset, crt_range, dither_source,
 dither_scale, lock, dither_enable, dither_invert...
Message-ID: <202207200100.AsG8AClR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: fd9373e41b9ba5b609f97e98a04687f4ff136aff iio: dac: ad5766: add driver support for AD5766
date:   1 year, 6 months ago
config: arm-randconfig-c002-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200100.AsG8AClR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd9373e41b9ba5b609f97e98a04687f4ff136aff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fd9373e41b9ba5b609f97e98a04687f4ff136aff
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
   Suppressed 1 warnings (1 with check filters).
   18 warnings generated.
   drivers/media/tuners/mxl5005s.c:2668:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2668:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2669:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2669:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2677:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2677:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2678:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2678:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2686:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2686:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2687:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2687:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2695:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2695:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2696:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2696:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2704:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2704:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2705:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2705:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2713:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2713:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2714:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2714:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2722:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2722:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2723:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2723:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2731:3: warning: Value stored to 'Fmax' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2731:3: note: Value stored to 'Fmax' is never read
                   Fmax = FmaxBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2732:3: warning: Value stored to 'Fmin' is never read [clang-analyzer-deadcode.DeadStores]
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   drivers/media/tuners/mxl5005s.c:2732:3: note: Value stored to 'Fmin' is never read
                   Fmin = FminBin ;
                   ^      ~~~~~~~
   Suppressed 2 warnings (2 with check filters).
   1 warning generated.
>> drivers/iio/dac/ad5766.c:109:8: warning: Excessive padding in 'struct ad5766_state' (44 padding bytes, where 12 is optimal). Optimal fields order: data, spi, chip_info, gpio_reset, crt_range, dither_source, dither_scale, lock, dither_enable, dither_invert, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad5766_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/dac/ad5766.c:109:8: note: Excessive padding in 'struct ad5766_state' (44 padding bytes, where 12 is optimal). Optimal fields order: data, spi, chip_info, gpio_reset, crt_range, dither_source, dither_scale, lock, dither_enable, dither_invert, consider reordering the fields or adding explicit padding members
   struct ad5766_state {
   ~~~~~~~^~~~~~~~~~~~~~
   2 warnings generated.
   drivers/iio/dac/ad5770r.c:133:8: warning: Excessive padding in 'struct ad5770r_state' (54 padding bytes, where 22 is optimal). Optimal fields order: transf_buf, internal_ref, external_res, spi, regmap, vref_reg, gpio_reset, vref, ch_pwr_down, output_mode, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad5770r_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/dac/ad5770r.c:133:8: note: Excessive padding in 'struct ad5770r_state' (54 padding bytes, where 22 is optimal). Optimal fields order: transf_buf, internal_ref, external_res, spi, regmap, vref_reg, gpio_reset, vref, ch_pwr_down, output_mode, consider reordering the fields or adding explicit padding members
   struct ad5770r_state {
   ~~~~~~~^~~~~~~~~~~~~~~
   drivers/iio/dac/ad5770r.c:544:2: warning: Undefined or garbage value returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
           return ret;
           ^
   drivers/iio/dac/ad5770r.c:609:6: note: Assuming 'indio_dev' is non-null
           if (!indio_dev)
               ^~~~~~~~~~
   drivers/iio/dac/ad5770r.c:609:2: note: Taking false branch
           if (!indio_dev)
           ^
   drivers/iio/dac/ad5770r.c:618:2: note: Taking false branch
           if (IS_ERR(regmap)) {
           ^
   drivers/iio/dac/ad5770r.c:626:2: note: Taking false branch
           if (!IS_ERR(st->vref_reg)) {
           ^
   drivers/iio/dac/ad5770r.c:646:7: note: Assuming the condition is true
                   if (PTR_ERR(st->vref_reg) == -ENODEV) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad5770r.c:646:3: note: Taking true branch
                   if (PTR_ERR(st->vref_reg) == -ENODEV) {
                   ^
   drivers/iio/dac/ad5770r.c:660:8: note: Calling 'ad5770r_init'
           ret = ad5770r_init(st);
                 ^~~~~~~~~~~~~~~~
   drivers/iio/dac/ad5770r.c:553:2: note: Taking false branch
           if (IS_ERR(st->gpio_reset))
           ^
   drivers/iio/dac/ad5770r.c:558:6: note: 'ret' is 0
           if (ret)
               ^~~
   drivers/iio/dac/ad5770r.c:558:2: note: Taking false branch
           if (ret)
           ^
   drivers/iio/dac/ad5770r.c:562:8: note: Calling 'ad5770r_channel_config'
           ret = ad5770r_channel_config(st);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad5770r.c:516:6: note: 'ret' declared without an initial value
           int ret, tmp[2], min, max;
               ^~~
   drivers/iio/dac/ad5770r.c:521:6: note: Assuming 'num' is equal to AD5770R_MAX_CHANNELS
           if (num != AD5770R_MAX_CHANNELS)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ad5770r.c:521:2: note: Taking false branch
           if (num != AD5770R_MAX_CHANNELS)
           ^
   drivers/iio/dac/ad5770r.c:524:2: note: Loop condition is false. Execution continues on line 544
           device_for_each_child_node(&st->spi->dev, child) {
           ^
   include/linux/property.h:111:2: note: expanded from macro 'device_for_each_child_node'
           for (child = device_get_next_child_node(dev, NULL); child;      \
           ^
   drivers/iio/dac/ad5770r.c:544:2: note: Undefined or garbage value returned to caller
           return ret;
           ^      ~~~
   1 warning generated.
   kernel/irq/irqdomain.c:595:2: warning: Value stored to 'of_node' is never read [clang-analyzer-deadcode.DeadStores]
           of_node = irq_domain_get_of_node(domain);
           ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/irqdomain.c:595:2: note: Value stored to 'of_node' is never read
           of_node = irq_domain_get_of_node(domain);
           ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   2 warnings generated.
   drivers/mfd/qcom-pm8xxx.c:557:2: warning: Value stored to 'rev' is never read [clang-analyzer-deadcode.DeadStores]
           rev |= val << BITS_PER_BYTE;
           ^      ~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/qcom-pm8xxx.c:557:2: note: Value stored to 'rev' is never read
           rev |= val << BITS_PER_BYTE;
           ^      ~~~~~~~~~~~~~~~~~~~~
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   drivers/input/rmi4/rmi_f11.c:1129:2: warning: Value stored to 'query_offset' is never read [clang-analyzer-deadcode.DeadStores]
           query_offset += rc;
           ^               ~~
   drivers/input/rmi4/rmi_f11.c:1129:2: note: Value stored to 'query_offset' is never read
           query_offset += rc;
           ^               ~~

vim +109 drivers/iio/dac/ad5766.c

    88	
    89	/**
    90	 * struct ad5766_state - driver instance specific data
    91	 * @spi:		SPI device
    92	 * @lock:		Lock used to restrict concurent access to SPI device
    93	 * @chip_info:		Chip model specific constants
    94	 * @gpio_reset:		Reset GPIO, used to reset the device
    95	 * @crt_range:		Current selected output range
    96	 * @dither_enable:	Power enable bit for each channel dither block (for
    97	 *			example, D15 = DAC 15,D8 = DAC 8, and D0 = DAC 0)
    98	 *			0 - Normal operation, 1 - Power down
    99	 * @dither_invert:	Inverts the dither signal applied to the selected DAC
   100	 *			outputs
   101	 * @dither_source:	Selects between 2 possible sources:
   102	 *			1: N0, 2: N1
   103	 *			Two bits are used for each channel
   104	 * @dither_scale:	Two bits are used for each of the 16 channels:
   105	 *			0: 1 SCALING, 1: 0.75 SCALING, 2: 0.5 SCALING,
   106	 *			3: 0.25 SCALING.
   107	 * @data:		SPI transfer buffers
   108	 */
 > 109	struct ad5766_state {
   110		struct spi_device		*spi;
   111		struct mutex			lock;
   112		const struct ad5766_chip_info	*chip_info;
   113		struct gpio_desc		*gpio_reset;
   114		enum ad5766_voltage_range	crt_range;
   115		u16		dither_enable;
   116		u16		dither_invert;
   117		u32		dither_source;
   118		u32		dither_scale;
   119		union {
   120			u32	d32;
   121			u16	w16[2];
   122			u8	b8[4];
   123		} data[3] ____cacheline_aligned;
   124	};
   125	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
