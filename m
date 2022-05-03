Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBF518821
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiECPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiECPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:21:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC93A5D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651591075; x=1683127075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Xz6Ln5q443Z2ALPSncn4/b7gf6beXhMjiot51vykZg=;
  b=iWOoYLEju16jjDvfRCJJEBaAxSXq8cYiySZOBJ1Gxpi1uulLe3xA+ECr
   +9kcC+bTAgpXryIXd7vKZFlWmOJbwpFy/iDmiPtpDpYq+r+gttrTjVp5b
   a1JLgG3b77pn4uGut7bFxbEVQtZbW7xIlSItMtADgpndgU+fChm+PuYsj
   0nht4Aeut0sUFhWpv4jAV6oI8VTPaRfcePxisOp4+SlXfOG9mq5Tr6Hp8
   82hzDfhQ2kxOQGoAJS6me2k/OsVZRy6ZRylHNjYVCl4uWLFA8VE24EoFt
   h2ZiDwT0Koquqhi4dF6bWF/YQFSLzEzFZPRKwjHgjkSKywk8wyNR8/KQo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267380539"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267380539"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="733951527"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 08:17:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nluHg-000AYx-SM;
        Tue, 03 May 2022 15:17:52 +0000
Date:   Tue, 3 May 2022 23:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/11]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for 'spihid_get_data'
Message-ID: <202205032332.JmX0xZHq-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   11b586fd5cff82ad72e9a281c0deb27959d16857
commit: 11b586fd5cff82ad72e9a281c0deb27959d16857 [11/11] WIP: HID: transport: spi: add Apple SPI transport
config: h8300-allmodconfig (https://download.01.org/0day-ci/archive/20220503/202205032332.JmX0xZHq-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/11b586fd5cff82ad72e9a281c0deb27959d16857
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 11b586fd5cff82ad72e9a281c0deb27959d16857
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/hid/spi-hid/ drivers/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/swab.h:6,
                    from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:14,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/h8300/include/asm/byteorder.h:5,
                    from include/asm-generic/unaligned.h:10,
                    from ./arch/h8300/include/generated/asm/unaligned.h:1,
                    from drivers/hid/spi-hid/spi-hid-apple-core.c:19:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:160:9: note: in expansion of macro 'BUG_ON'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:160:17: note: in expansion of macro 'virt_addr_valid'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-apple-core.c: At top level:
>> drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous prototype for 'spihid_get_data' [-Wmissing-prototypes]
     259 | struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
         |                      ^~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/div64.h:27,
                    from ./arch/h8300/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:22,
                    from drivers/hid/spi-hid/spi-hid-apple-of.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:160:9: note: in expansion of macro 'BUG_ON'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:160:17: note: in expansion of macro 'virt_addr_valid'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-apple-of.c: At top level:
>> drivers/hid/spi-hid/spi-hid-apple-of.c:24:5: warning: no previous prototype for 'spihid_apple_of_power_on' [-Wmissing-prototypes]
      24 | int spihid_apple_of_power_on(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:40:5: warning: no previous prototype for 'spihid_apple_of_power_off' [-Wmissing-prototypes]
      40 | int spihid_apple_of_power_off(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:50:5: warning: no previous prototype for 'spihid_apple_of_enable_irq' [-Wmissing-prototypes]
      50 | int spihid_apple_of_enable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:59:5: warning: no previous prototype for 'spihid_apple_of_disable_irq' [-Wmissing-prototypes]
      59 | int spihid_apple_of_disable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


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
