Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825348F031
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiANSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:55:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:60394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236181AbiANSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642186523; x=1673722523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7M6SOEbxP+NzFhtIPqluAf+y50/Fq1AYP0EdbCcPbZk=;
  b=IXmBwoGKV1Pq7l16Qd1BwPipRtPNzGXSoaFH9tQXLEgV3ElgxsOaix9b
   Hwi5lQUjcrhLTKT5rtfldIvdJ9zwvASdIVcLK2bL+9gVVseT/8NGGsnlj
   A18z3tkqjgK34voln2jd04Zu0v0Q8jxsy4mTfv3tAQatMxbOSClp4I0aR
   x7DO04/xWesbuFvhsRq3bj7j4W8uwnw3riweSZZyG+kYXd/EFSEWd34Zh
   tVjvccvEZSgl4xPc+7HGuLi65mtxD1/r/ZfhyRxz+axvEE3duJ6yS9xzR
   WwzZD1JXeGb06xqDWYLiojHBeVJihcSZDiMhkRbz4PsqJVPVlc+NKRxHu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305038805"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="305038805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 10:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="559583506"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2022 10:55:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8RjN-0008uH-6t; Fri, 14 Jan 2022 18:55:21 +0000
Date:   Sat, 15 Jan 2022 02:54:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jammy Huang <jammy_huang@aspeedtech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:for-v5.18f 76/82]
 include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of
 type 'unsigned int', but argument 3 has type 'dma_addr_t' {aka 'long long
 unsigned int'}
Message-ID: <202201150246.rrQHjstb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.18f
head:   97dd85f0caf1ad96c275147583c46f8ee12308fc
commit: 63c049607882d11ee1cce0c739113c8dfd7fed02 [76/82] media: aspeed: add more debug log messages
config: arc-randconfig-r043-20220114 (https://download.01.org/0day-ci/archive/20220115/202201150246.rrQHjstb-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.18f
        git checkout 63c049607882d11ee1cce0c739113c8dfd7fed02
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:20,
                    from include/linux/clk.h:13,
                    from drivers/media/platform/aspeed-video.c:7:
   drivers/media/platform/aspeed-video.c: In function 'aspeed_video_set_resolution':
>> include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/media/v4l2-common.h:58:9: note: in expansion of macro 'printk'
      58 |         printk(level "%s: " fmt, (dev)->name , ## arg)
         |         ^~~~~~
   include/media/v4l2-common.h:74:25: note: in expansion of macro 'v4l2_printk'
      74 |                         v4l2_printk(KERN_DEBUG, dev, fmt , ## arg);     \
         |                         ^~~~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/media/v4l2-common.h:74:37: note: in expansion of macro 'KERN_DEBUG'
      74 |                         v4l2_printk(KERN_DEBUG, dev, fmt , ## arg);     \
         |                                     ^~~~~~~~~~
   drivers/media/platform/aspeed-video.c:976:17: note: in expansion of macro 'v4l2_dbg'
     976 |                 v4l2_dbg(1, debug, &video->v4l2_dev, "src buf0 addr(%#x) size(%d)\n",
         |                 ^~~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/media/v4l2-common.h:58:9: note: in expansion of macro 'printk'
      58 |         printk(level "%s: " fmt, (dev)->name , ## arg)
         |         ^~~~~~
   include/media/v4l2-common.h:74:25: note: in expansion of macro 'v4l2_printk'
      74 |                         v4l2_printk(KERN_DEBUG, dev, fmt , ## arg);     \
         |                         ^~~~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/media/v4l2-common.h:74:37: note: in expansion of macro 'KERN_DEBUG'
      74 |                         v4l2_printk(KERN_DEBUG, dev, fmt , ## arg);     \
         |                                     ^~~~~~~~~~
   drivers/media/platform/aspeed-video.c:978:17: note: in expansion of macro 'v4l2_dbg'
     978 |                 v4l2_dbg(1, debug, &video->v4l2_dev, "src buf1 addr(%#x) size(%d)\n",
         |                 ^~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/media/platform/aspeed-video.c:9:
   drivers/media/platform/aspeed-video.c: In function 'aspeed_video_init':
   drivers/media/platform/aspeed-video.c:1805:30: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
    1805 |         dev_info(video->dev, "alloc mem size(%d) at %#x for jpeg header\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/media/platform/aspeed-video.c:1805:9: note: in expansion of macro 'dev_info'
    1805 |         dev_info(video->dev, "alloc mem size(%d) at %#x for jpeg header\n",
         |         ^~~~~~~~
   drivers/media/platform/aspeed-video.c:1805:55: note: format string is defined here
    1805 |         dev_info(video->dev, "alloc mem size(%d) at %#x for jpeg header\n",
         |                                                     ~~^
         |                                                       |
         |                                                       unsigned int
         |                                                     %#llx


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
