Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890024B64AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiBOHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:48:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiBOHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:47:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530558A303
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644911262; x=1676447262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VpZ49gA6+j5BEhe/K07WVSlEahngiMDyInTw/eoMTHQ=;
  b=Tn3PiAxTWrtin5SzPpMvPl/6l4BnKck8Eh5WGo5qykRLmHTti4kmdDmF
   RksqmSc3Mi82ZEqE8Xi6iHhrEArqXB7jfderY8kx4EZBK+usL68EPyfL3
   Ng8Us+xX9/eHpGYQ23hDAvOSzADs+pXFBK0vffyHAas1GsXAITB/8CSi8
   1mRTffKEpdlbYkpKtTWM/9Kf2TFf8jAqwSf5BZmcqZw7RAyTG5hePd9an
   MvatG/H8i4WaFlBq5BfHk7iSZquwsLKw5WqYPuCSxUXqcdyFkV1L08HsD
   T35dSRvS7ZadwkPp5xTm/WPxsjFxuA8BpT+NaO/pWvWNNw/Pox4pxh4rt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313546536"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="313546536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 23:47:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="680888056"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 23:47:40 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJsYl-0009Qq-Cv; Tue, 15 Feb 2022 07:47:39 +0000
Date:   Tue, 15 Feb 2022 15:47:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/iio/adc/da9150-gpadc.c:281:2: error: use of undeclared
 identifier 'DA9150_GPADC_CHAN_0x08'
Message-ID: <202202151553.WMyhY9PJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d567f5db412ed52de0b3b3efca4a451263de6108
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 5 months ago
config: mips-buildonly-randconfig-r005-20220215 (https://download.01.org/0day-ci/archive/20220215/202202151553.WMyhY9PJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/da9150-gpadc.c:281:2: error: use of undeclared identifier 'DA9150_GPADC_CHAN_0x08'
           DA9150_GPADC_CHANNEL_PROCESSED(GPIOD, GPIOD_6V, IIO_VOLTAGE, NULL),
           ^
   drivers/iio/adc/da9150-gpadc.c:273:2: note: expanded from macro 'DA9150_GPADC_CHANNEL_PROCESSED'
           DA9150_GPADC_CHANNEL(_id, _hw_id, _type,                        \
           ^
   drivers/iio/adc/da9150-gpadc.c:254:13: note: expanded from macro 'DA9150_GPADC_CHANNEL'
           .channel = DA9150_GPADC_CHAN_##_id,                     \
                      ^
   <scratch space>:144:1: note: expanded from here
   DA9150_GPADC_CHAN_0x08
   ^
>> drivers/iio/adc/da9150-gpadc.c:360:28: error: invalid application of 'sizeof' to an incomplete type 'const struct iio_chan_spec[]'
           indio_dev->num_channels = ARRAY_SIZE(da9150_gpadc_channels);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:47:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   2 errors generated.


vim +/DA9150_GPADC_CHAN_0x08 +281 drivers/iio/adc/da9150-gpadc.c

ed5f07b3d3d434 Adam Thomson 2015-02-18  260  
ed5f07b3d3d434 Adam Thomson 2015-02-18  261  #define DA9150_GPADC_CHANNEL_RAW(_id, _hw_id, _type, _ext_name)	\
ed5f07b3d3d434 Adam Thomson 2015-02-18  262  	DA9150_GPADC_CHANNEL(_id, _hw_id, _type,		\
ed5f07b3d3d434 Adam Thomson 2015-02-18  263  			     BIT(IIO_CHAN_INFO_RAW), _ext_name)
ed5f07b3d3d434 Adam Thomson 2015-02-18  264  
ed5f07b3d3d434 Adam Thomson 2015-02-18  265  #define DA9150_GPADC_CHANNEL_SCALED(_id, _hw_id, _type, _ext_name)	\
ed5f07b3d3d434 Adam Thomson 2015-02-18  266  	DA9150_GPADC_CHANNEL(_id, _hw_id, _type,			\
ed5f07b3d3d434 Adam Thomson 2015-02-18  267  			     BIT(IIO_CHAN_INFO_RAW) |			\
ed5f07b3d3d434 Adam Thomson 2015-02-18  268  			     BIT(IIO_CHAN_INFO_SCALE) |			\
ed5f07b3d3d434 Adam Thomson 2015-02-18  269  			     BIT(IIO_CHAN_INFO_OFFSET),			\
ed5f07b3d3d434 Adam Thomson 2015-02-18  270  			     _ext_name)
ed5f07b3d3d434 Adam Thomson 2015-02-18  271  
ed5f07b3d3d434 Adam Thomson 2015-02-18  272  #define DA9150_GPADC_CHANNEL_PROCESSED(_id, _hw_id, _type, _ext_name)	\
ed5f07b3d3d434 Adam Thomson 2015-02-18 @273  	DA9150_GPADC_CHANNEL(_id, _hw_id, _type,			\
ed5f07b3d3d434 Adam Thomson 2015-02-18  274  			     BIT(IIO_CHAN_INFO_PROCESSED), _ext_name)
ed5f07b3d3d434 Adam Thomson 2015-02-18  275  
ed5f07b3d3d434 Adam Thomson 2015-02-18  276  /* Supported channels */
ed5f07b3d3d434 Adam Thomson 2015-02-18  277  static const struct iio_chan_spec da9150_gpadc_channels[] = {
ed5f07b3d3d434 Adam Thomson 2015-02-18  278  	DA9150_GPADC_CHANNEL_PROCESSED(GPIOA, GPIOA_6V, IIO_VOLTAGE, NULL),
ed5f07b3d3d434 Adam Thomson 2015-02-18  279  	DA9150_GPADC_CHANNEL_PROCESSED(GPIOB, GPIOB_6V, IIO_VOLTAGE, NULL),
ed5f07b3d3d434 Adam Thomson 2015-02-18  280  	DA9150_GPADC_CHANNEL_PROCESSED(GPIOC, GPIOC_6V, IIO_VOLTAGE, NULL),
ed5f07b3d3d434 Adam Thomson 2015-02-18 @281  	DA9150_GPADC_CHANNEL_PROCESSED(GPIOD, GPIOD_6V, IIO_VOLTAGE, NULL),
ed5f07b3d3d434 Adam Thomson 2015-02-18  282  	DA9150_GPADC_CHANNEL_PROCESSED(IBUS, IBUS_SENSE, IIO_CURRENT, "ibus"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  283  	DA9150_GPADC_CHANNEL_PROCESSED(VBUS, VBUS_DIV_, IIO_VOLTAGE, "vbus"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  284  	DA9150_GPADC_CHANNEL_PROCESSED(VSYS, VSYS, IIO_VOLTAGE, "vsys"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  285  	DA9150_GPADC_CHANNEL_SCALED(VBAT, VBAT, IIO_VOLTAGE, "vbat"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  286  	DA9150_GPADC_CHANNEL_RAW(TBAT, TBAT, IIO_VOLTAGE, "tbat"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  287  	DA9150_GPADC_CHANNEL_SCALED(TJUNC_CORE, TJUNC_CORE, IIO_TEMP,
ed5f07b3d3d434 Adam Thomson 2015-02-18  288  				    "tjunc_core"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  289  	DA9150_GPADC_CHANNEL_SCALED(TJUNC_OVP, TJUNC_OVP, IIO_TEMP,
ed5f07b3d3d434 Adam Thomson 2015-02-18  290  				    "tjunc_ovp"),
ed5f07b3d3d434 Adam Thomson 2015-02-18  291  };
ed5f07b3d3d434 Adam Thomson 2015-02-18  292  
ed5f07b3d3d434 Adam Thomson 2015-02-18  293  /* Default maps used by da9150-charger */
ed5f07b3d3d434 Adam Thomson 2015-02-18  294  static struct iio_map da9150_gpadc_default_maps[] = {
ed5f07b3d3d434 Adam Thomson 2015-02-18  295  	{
ed5f07b3d3d434 Adam Thomson 2015-02-18  296  		.consumer_dev_name = "da9150-charger",
ed5f07b3d3d434 Adam Thomson 2015-02-18  297  		.consumer_channel = "CHAN_IBUS",
ed5f07b3d3d434 Adam Thomson 2015-02-18  298  		.adc_channel_label = "IBUS",
ed5f07b3d3d434 Adam Thomson 2015-02-18  299  	},
ed5f07b3d3d434 Adam Thomson 2015-02-18  300  	{
ed5f07b3d3d434 Adam Thomson 2015-02-18  301  		.consumer_dev_name = "da9150-charger",
ed5f07b3d3d434 Adam Thomson 2015-02-18  302  		.consumer_channel = "CHAN_VBUS",
ed5f07b3d3d434 Adam Thomson 2015-02-18  303  		.adc_channel_label = "VBUS",
ed5f07b3d3d434 Adam Thomson 2015-02-18  304  	},
ed5f07b3d3d434 Adam Thomson 2015-02-18  305  	{
ed5f07b3d3d434 Adam Thomson 2015-02-18  306  		.consumer_dev_name = "da9150-charger",
ed5f07b3d3d434 Adam Thomson 2015-02-18  307  		.consumer_channel = "CHAN_TJUNC",
ed5f07b3d3d434 Adam Thomson 2015-02-18  308  		.adc_channel_label = "TJUNC_CORE",
ed5f07b3d3d434 Adam Thomson 2015-02-18  309  	},
ed5f07b3d3d434 Adam Thomson 2015-02-18  310  	{
ed5f07b3d3d434 Adam Thomson 2015-02-18  311  		.consumer_dev_name = "da9150-charger",
ed5f07b3d3d434 Adam Thomson 2015-02-18  312  		.consumer_channel = "CHAN_VBAT",
ed5f07b3d3d434 Adam Thomson 2015-02-18  313  		.adc_channel_label = "VBAT",
ed5f07b3d3d434 Adam Thomson 2015-02-18  314  	},
ed5f07b3d3d434 Adam Thomson 2015-02-18  315  	{},
ed5f07b3d3d434 Adam Thomson 2015-02-18  316  };
ed5f07b3d3d434 Adam Thomson 2015-02-18  317  
ed5f07b3d3d434 Adam Thomson 2015-02-18  318  static int da9150_gpadc_probe(struct platform_device *pdev)
ed5f07b3d3d434 Adam Thomson 2015-02-18  319  {
ed5f07b3d3d434 Adam Thomson 2015-02-18  320  	struct device *dev = &pdev->dev;
ed5f07b3d3d434 Adam Thomson 2015-02-18  321  	struct da9150 *da9150 = dev_get_drvdata(dev->parent);
ed5f07b3d3d434 Adam Thomson 2015-02-18  322  	struct da9150_gpadc *gpadc;
ed5f07b3d3d434 Adam Thomson 2015-02-18  323  	struct iio_dev *indio_dev;
ed5f07b3d3d434 Adam Thomson 2015-02-18  324  	int irq, ret;
ed5f07b3d3d434 Adam Thomson 2015-02-18  325  
ed5f07b3d3d434 Adam Thomson 2015-02-18  326  	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
ed5f07b3d3d434 Adam Thomson 2015-02-18  327  	if (!indio_dev) {
ed5f07b3d3d434 Adam Thomson 2015-02-18  328  		dev_err(&pdev->dev, "Failed to allocate IIO device\n");
ed5f07b3d3d434 Adam Thomson 2015-02-18  329  		return -ENOMEM;
ed5f07b3d3d434 Adam Thomson 2015-02-18  330  	}
ed5f07b3d3d434 Adam Thomson 2015-02-18  331  	gpadc = iio_priv(indio_dev);
ed5f07b3d3d434 Adam Thomson 2015-02-18  332  
ed5f07b3d3d434 Adam Thomson 2015-02-18  333  	platform_set_drvdata(pdev, indio_dev);
ed5f07b3d3d434 Adam Thomson 2015-02-18  334  	gpadc->da9150 = da9150;
ed5f07b3d3d434 Adam Thomson 2015-02-18  335  	gpadc->dev = dev;
ed5f07b3d3d434 Adam Thomson 2015-02-18  336  	mutex_init(&gpadc->lock);
ed5f07b3d3d434 Adam Thomson 2015-02-18  337  	init_completion(&gpadc->complete);
ed5f07b3d3d434 Adam Thomson 2015-02-18  338  
ed5f07b3d3d434 Adam Thomson 2015-02-18  339  	irq = platform_get_irq_byname(pdev, "GPADC");
7c279229f980e5 Stephen Boyd 2019-07-30  340  	if (irq < 0)
ed5f07b3d3d434 Adam Thomson 2015-02-18  341  		return irq;
ed5f07b3d3d434 Adam Thomson 2015-02-18  342  
ed5f07b3d3d434 Adam Thomson 2015-02-18  343  	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_gpadc_irq,
ed5f07b3d3d434 Adam Thomson 2015-02-18  344  					IRQF_ONESHOT, "GPADC", gpadc);
ed5f07b3d3d434 Adam Thomson 2015-02-18  345  	if (ret) {
ed5f07b3d3d434 Adam Thomson 2015-02-18  346  		dev_err(dev, "Failed to request IRQ %d: %d\n", irq, ret);
ed5f07b3d3d434 Adam Thomson 2015-02-18  347  		return ret;
ed5f07b3d3d434 Adam Thomson 2015-02-18  348  	}
ed5f07b3d3d434 Adam Thomson 2015-02-18  349  
ed5f07b3d3d434 Adam Thomson 2015-02-18  350  	ret = iio_map_array_register(indio_dev, da9150_gpadc_default_maps);
ed5f07b3d3d434 Adam Thomson 2015-02-18  351  	if (ret) {
ed5f07b3d3d434 Adam Thomson 2015-02-18  352  		dev_err(dev, "Failed to register IIO maps: %d\n", ret);
ed5f07b3d3d434 Adam Thomson 2015-02-18  353  		return ret;
ed5f07b3d3d434 Adam Thomson 2015-02-18  354  	}
ed5f07b3d3d434 Adam Thomson 2015-02-18  355  
ed5f07b3d3d434 Adam Thomson 2015-02-18  356  	indio_dev->name = dev_name(dev);
ed5f07b3d3d434 Adam Thomson 2015-02-18  357  	indio_dev->info = &da9150_gpadc_info;
ed5f07b3d3d434 Adam Thomson 2015-02-18  358  	indio_dev->modes = INDIO_DIRECT_MODE;
ed5f07b3d3d434 Adam Thomson 2015-02-18  359  	indio_dev->channels = da9150_gpadc_channels;
ed5f07b3d3d434 Adam Thomson 2015-02-18 @360  	indio_dev->num_channels = ARRAY_SIZE(da9150_gpadc_channels);
ed5f07b3d3d434 Adam Thomson 2015-02-18  361  
ed5f07b3d3d434 Adam Thomson 2015-02-18  362  	ret = iio_device_register(indio_dev);
ed5f07b3d3d434 Adam Thomson 2015-02-18  363  	if (ret) {
ed5f07b3d3d434 Adam Thomson 2015-02-18  364  		dev_err(dev, "Failed to register IIO device: %d\n", ret);
ed5f07b3d3d434 Adam Thomson 2015-02-18  365  		goto iio_map_unreg;
ed5f07b3d3d434 Adam Thomson 2015-02-18  366  	}
ed5f07b3d3d434 Adam Thomson 2015-02-18  367  
ed5f07b3d3d434 Adam Thomson 2015-02-18  368  	return 0;
ed5f07b3d3d434 Adam Thomson 2015-02-18  369  
ed5f07b3d3d434 Adam Thomson 2015-02-18  370  iio_map_unreg:
ed5f07b3d3d434 Adam Thomson 2015-02-18  371  	iio_map_array_unregister(indio_dev);
ed5f07b3d3d434 Adam Thomson 2015-02-18  372  
ed5f07b3d3d434 Adam Thomson 2015-02-18  373  	return ret;
ed5f07b3d3d434 Adam Thomson 2015-02-18  374  }
ed5f07b3d3d434 Adam Thomson 2015-02-18  375  

:::::: The code at line 281 was first introduced by commit
:::::: ed5f07b3d3d4344f917658a7f62cf62ccb19cb07 iio: Add support for DA9150 GPADC

:::::: TO: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
:::::: CC: Sebastian Reichel <sre@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
