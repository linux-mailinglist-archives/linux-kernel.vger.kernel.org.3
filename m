Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8C5336F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiEYGyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiEYGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:54:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A9762B9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653461689; x=1684997689;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sNRmLVGfzRJNMK+s8x7hza8MpzNbvyFls3N2bzF/zAI=;
  b=NmvZZ0QYBnH7mvZLXOyGvDMlOl90aNvO1g5kVH4OiYcVrK7V5nfiSBst
   fcT9KjsYozP43qUiRd3ggFaY7WmH4HG6XyOY1DgTGS2B8tUbHYtve2NKn
   S1RMPiocy5KuilGILvcLEInGspiWDhYfCsxsC5szDRH2S1/r5gJmUu95L
   +6TS1SN18V3WrTYuPfpR+IMqqRl/Cg1g/GZtDHqeQ5J3/t3M9pcYkAq58
   KButFX6OMrU/o90qirpBOl6aZSx7Mv0NL3kUlqWN/en4W6bmqNdHPkHL7
   n+tpXTuFOaYN2I0NwQoJ0kgu1uDjwzTt51AKf7yN3gGhKiFvMFfEKtRix
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="272552965"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="272552965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="608999662"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 23:54:46 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntkur-0002pC-P9;
        Wed, 25 May 2022 06:54:45 +0000
Date:   Wed, 25 May 2022 14:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/11]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for function 'spihid_get_data'
Message-ID: <202205251434.YLWM26fA-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   42af7072aa3351c9a5716b754babb8ded16874ab
commit: 42af7072aa3351c9a5716b754babb8ded16874ab [11/11] WIP: HID: transport: spi: add Apple SPI transport
config: arm64-buildonly-randconfig-r005-20220524 (https://download.01.org/0day-ci/archive/20220525/202205251434.YLWM26fA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/42af7072aa3351c9a5716b754babb8ded16874ab
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 42af7072aa3351c9a5716b754babb8ded16874ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/spi-hid/

If you fix the issue, kindly add following tag where applicable
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
