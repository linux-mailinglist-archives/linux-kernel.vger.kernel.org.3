Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D399D5177D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387257AbiEBUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbiEBUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:20:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61269BCAB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651522625; x=1683058625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TDgkeaExvvU4MUaWhsjsOW8SUcyecyq5v6Ttz09eSDk=;
  b=CglC6ij+PIVE626rB/QXGEnhz0NkhvqFGhAj5m1Cdgq6Gk8/R1lDBI3P
   QUrwbvsudKDr+wfukYvjjDzyiI4nfYQjtzuH0LP+e3k/d5WchH28RVfMU
   CpsZzgVoSBMd3M4kul7qj0FoX6h0cWTnvayrJZDXx2X3ft9l+cE2ISr9I
   nmuGiAIQJqil7zOz5VNoqY39jpomzdSoO4yWESMoh0E/WB+2n47iedhF0
   N90JprHnjcngwol0Qxh4lJoIrelF7oJeEZ2Q3yiVP8SsklICcVrMkEDQM
   vk0uZxi34+f/kxX5PLV94WVZVcrVPZ/ZMRpmtOc5+v5zWqsC52zY6KxMD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247227691"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247227691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="546602152"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 13:17:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlcTd-0009qH-Lh;
        Mon, 02 May 2022 20:17:01 +0000
Date:   Tue, 3 May 2022 04:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/11]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for function 'spihid_get_data'
Message-ID: <202205030410.6Owech62-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   11b586fd5cff82ad72e9a281c0deb27959d16857
commit: 11b586fd5cff82ad72e9a281c0deb27959d16857 [11/11] WIP: HID: transport: spi: add Apple SPI transport
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220503/202205030410.6Owech62-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/11b586fd5cff82ad72e9a281c0deb27959d16857
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 11b586fd5cff82ad72e9a281c0deb27959d16857
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/ drivers/hid/spi-hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous prototype for function 'spihid_get_data' [-Wmissing-prototypes]
   struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
                        ^
   drivers/hid/spi-hid/spi-hid-apple-core.c:259:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
   ^
   static 
   drivers/hid/spi-hid/spi-hid-apple-core.c:56:17: warning: variable 'spi_hid_apple_status_ok' is not needed and will not be emitted [-Wunneeded-internal-declaration]
   static const u8 spi_hid_apple_status_ok[4] = { 0xac, 0x27, 0x68, 0xd5 };
                   ^
   2 warnings generated.
--
>> drivers/hid/spi-hid/spi-hid-apple-of.c:24:5: warning: no previous prototype for function 'spihid_apple_of_power_on' [-Wmissing-prototypes]
   int spihid_apple_of_power_on(struct spihid_apple_ops *ops)
       ^
   drivers/hid/spi-hid/spi-hid-apple-of.c:24:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int spihid_apple_of_power_on(struct spihid_apple_ops *ops)
   ^
   static 
>> drivers/hid/spi-hid/spi-hid-apple-of.c:40:5: warning: no previous prototype for function 'spihid_apple_of_power_off' [-Wmissing-prototypes]
   int spihid_apple_of_power_off(struct spihid_apple_ops *ops)
       ^
   drivers/hid/spi-hid/spi-hid-apple-of.c:40:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int spihid_apple_of_power_off(struct spihid_apple_ops *ops)
   ^
   static 
>> drivers/hid/spi-hid/spi-hid-apple-of.c:50:5: warning: no previous prototype for function 'spihid_apple_of_enable_irq' [-Wmissing-prototypes]
   int spihid_apple_of_enable_irq(struct spihid_apple_ops *ops)
       ^
   drivers/hid/spi-hid/spi-hid-apple-of.c:50:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int spihid_apple_of_enable_irq(struct spihid_apple_ops *ops)
   ^
   static 
>> drivers/hid/spi-hid/spi-hid-apple-of.c:59:5: warning: no previous prototype for function 'spihid_apple_of_disable_irq' [-Wmissing-prototypes]
   int spihid_apple_of_disable_irq(struct spihid_apple_ops *ops)
       ^
   drivers/hid/spi-hid/spi-hid-apple-of.c:59:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int spihid_apple_of_disable_irq(struct spihid_apple_ops *ops)
   ^
   static 
   4 warnings generated.


vim +/spihid_get_data +259 drivers/hid/spi-hid/spi-hid-apple-core.c

   258	
 > 259	struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
   260	{
   261		switch (idev->id) {
   262		case SPIHID_DEVICE_ID_KBD:
   263			return container_of(idev, struct spihid_apple, kbd);
   264		case SPIHID_DEVICE_ID_TP:
   265			return container_of(idev, struct spihid_apple, tp);
   266		default:
   267			return NULL;
   268		}
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
