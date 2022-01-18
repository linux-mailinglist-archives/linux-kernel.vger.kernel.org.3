Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5934E492BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbiARRAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:00:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:52433 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346942AbiARRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642525204; x=1674061204;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s2XOKxUUEaS1aCY5y/DJ026eaexU/8xFQ9gMQi4JkTE=;
  b=iw4/rXpq72y6Roi5NUdmOZiE9V+18fKYo9e0nj7uiQDSfKcFbcaLYXkJ
   A/xFWNaeufgsFYqc1qS723OBsgJXnpTJ2ZLydZ0wkumqp3b9BfkvI8VfM
   pNcpgoK2QqG5ATN9UrBVT3TqhyqKMxGy5CGfpPtzZaQfftumbc9TRyjKB
   plqWF7q8r+NHJV4Xhaa9tuNEnW82ZcbgUTvuLxE+OOhONsk5IrLUstFpZ
   unfNlq4Nh2TVF0T+ZX0g+gRMEIPD3b5OT0o2xcS566GtfMFh42TmKPU95
   wRADfE2CkY6urtaHAYcHoQrDDn5UWv6riV5M+mL6pSjEN5iCle/igIUmp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="225538779"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="225538779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="693451207"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2022 09:00:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9rpx-000Clc-SZ; Tue, 18 Jan 2022 17:00:01 +0000
Date:   Wed, 19 Jan 2022 00:59:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 12/12]
 drivers/hid/spi-hid/spi-hid-apple-of.c:114:25: error:
 'spi_hid_apple_of_match' undeclared here (not in a function); did you mean
 'spihid_apple_of_match'?
Message-ID: <202201190058.vURTyce7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   25070af6e6d0c750f307b019df19cc93a54b664c
commit: 25070af6e6d0c750f307b019df19cc93a54b664c [12/12] WIP: HID: transport: spi: add Apple SPI transport
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220119/202201190058.vURTyce7-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/25070af6e6d0c750f307b019df19cc93a54b664c
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 25070af6e6d0c750f307b019df19cc93a54b664c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hid/spi-hid/spi-hid-apple-of.c:24:5: warning: no previous prototype for 'spihid_apple_of_power_on' [-Wmissing-prototypes]
      24 | int spihid_apple_of_power_on(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-apple-of.c:40:5: warning: no previous prototype for 'spihid_apple_of_power_off' [-Wmissing-prototypes]
      40 | int spihid_apple_of_power_off(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-apple-of.c:50:5: warning: no previous prototype for 'spihid_apple_of_enable_irq' [-Wmissing-prototypes]
      50 | int spihid_apple_of_enable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/spi-hid/spi-hid-apple-of.c:59:5: warning: no previous prototype for 'spihid_apple_of_disable_irq' [-Wmissing-prototypes]
      59 | int spihid_apple_of_disable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/spi/spi.h:10,
                    from drivers/hid/spi-hid/spi-hid-apple.h:7,
                    from drivers/hid/spi-hid/spi-hid-apple-of.c:14:
>> drivers/hid/spi-hid/spi-hid-apple-of.c:114:25: error: 'spi_hid_apple_of_match' undeclared here (not in a function); did you mean 'spihid_apple_of_match'?
     114 | MODULE_DEVICE_TABLE(of, spi_hid_apple_of_match);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table  \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__spi_hid_apple_of_match_device_table' aliased to undefined symbol 'spi_hid_apple_of_match'
     244 | extern typeof(name) __mod_##type##__##name##_device_table  \
         |                     ^~~~~~
   drivers/hid/spi-hid/spi-hid-apple-of.c:114:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     114 | MODULE_DEVICE_TABLE(of, spi_hid_apple_of_match);
         | ^~~~~~~~~~~~~~~~~~~


vim +114 drivers/hid/spi-hid/spi-hid-apple-of.c

   109	
   110	static const struct of_device_id spihid_apple_of_match[] = {
   111		{ .compatible = "apple,spi-hid-transport" },
   112		{},
   113	};
 > 114	MODULE_DEVICE_TABLE(of, spi_hid_apple_of_match);
   115	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
