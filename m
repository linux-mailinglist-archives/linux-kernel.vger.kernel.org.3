Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4157659B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiGORAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiGORAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:00:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32D820C3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657904440; x=1689440440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e3VKXAnq32O/MiYuI7amCRRN/Y85H/Ky2ZStbfVc93M=;
  b=dDj3p/AwFE8BQDOIsRuc6YIwqrOafa26t+s0/mAZXmuOOWpPGmXgs0DL
   py9TOm7mqxETwOS2amdgRHsj7kFPDtmKkpJV6qqVoNJ1o/CyW7VWZI2HZ
   3iwbxyhw+bmnBCFwcolFuIhFz2i9pn5SIwexk6vIkqSCuebPZujAUOZUa
   /hrAJs2efdbTcWQKaeA78MQMDfDjQmExN3gCO7BeVq1E67/uTnUd2BpAd
   MTZbf3TxU3MmnEhBy6583KbUPBORVlx80gaxdyzdccqF8sSG4mzjZzs15
   Aw5aVS80ENF5Hg85fZgtZfrHl1DkcLvS0Ns0IQgkwXzDooUbWRDHrjcQ9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="311506698"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="311506698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 10:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="723141480"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2022 10:00:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCOg8-0000W0-BV;
        Fri, 15 Jul 2022 17:00:36 +0000
Date:   Sat, 16 Jul 2022 01:00:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/18]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for function 'spihid_get_data'
Message-ID: <202207160028.MFKQvcjJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   2902ed1bd2d6ac439a835c53841122c7f3455a6c
commit: caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92 [11/18] WIP: HID: transport: spi: add Apple SPI transport
config: arm64-randconfig-r014-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160028.MFKQvcjJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/spi-hid/ drivers/irqchip/

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
