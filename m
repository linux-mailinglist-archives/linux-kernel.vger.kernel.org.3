Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934415AC122
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiICTbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:31:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB548C99
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662233464; x=1693769464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ZpWWn9bhFroyOUx3+Apl1nhkOMU4SaDz+sTMnRtgyw=;
  b=hf+juKJJPK5LvGuJlhy3lRo5qW566Eo6rbZ1umMF01T9SR5MURkp+o33
   yfBxQMY88RLS5JKfjOyoaBVxcefsTc4VSNJlA7gLyYoLg6UrYrpMoXS8g
   mOEwBmjGQvHId0iVJn5yIFsVpQ4nb8U3MRhj6cFgylE4SxfBSIPWXwglc
   ynHywq+zUekr/CvCzOS8HixOSK/bfMFuAgvqjTkLopoZUumPgYUYHICE9
   Gc+vbwD2B2U/a3ixlDmMShKeh9nUwUR88pKM4iF97ZYJREsY7S3w9IwPC
   KA5MRF1sRuSX/mGCxZmNm+6ms7DhoUJ7DLOU7+fxZyyQLIZ3d0ud69+wL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296967326"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="296967326"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 12:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="643323584"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 12:31:02 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUYr7-00025f-29;
        Sat, 03 Sep 2022 19:31:01 +0000
Date:   Sun, 4 Sep 2022 03:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/22]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for function 'spihid_get_data'
Message-ID: <202209040357.Xt9ih8dg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   480924e97dddd088c4ed360eb12ecf92a30f19b1
commit: ab84f7572c5928c7412539ab0e51a581ecafe4f1 [11/22] WIP: HID: transport: spi: add Apple SPI transport
config: riscv-randconfig-r032-20220904 (https://download.01.org/0day-ci/archive/20220904/202209040357.Xt9ih8dg-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/ab84f7572c5928c7412539ab0e51a581ecafe4f1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout ab84f7572c5928c7412539ab0e51a581ecafe4f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/hid/spi-hid/ drivers/platform/

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
