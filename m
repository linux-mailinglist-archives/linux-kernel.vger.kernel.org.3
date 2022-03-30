Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DC4ECCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350384AbiC3St2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350219AbiC3StP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:49:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B834246;
        Wed, 30 Mar 2022 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648666049; x=1680202049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fR98BAS9xxFmuyNkbXQwJSd+XKma8MKivJ5ZtEcuCN4=;
  b=ivxwl2hSAclmeyO5u0vsCxkjGLW2sBUBxXqa1cL/ZgAbbGGRYNLpv2LY
   KYuLz2UqjTyhRs5rseU7P8Xdpynhn0oreAKcN9vmLzOlAb4OjwPGH/h1O
   9Ni7T/u2FGZlmrFENudYLQw9tNwZzbT+9sbb/C+oHqQnGSG94Lo2eJCsX
   2vCaJ4vbGVU0+YWPBskjQMXYWFYiCOG3OOfwK6lk8IfG0qyT1WfLpKAu3
   hMlv5Uc9WNxXjb+rK9r1zJsXbqKw1Cp2DtNWqavCT5dCoChAhPlwnj1Sh
   WZEKDWLispg9dWyEmjIKVbzmwuZrlpWvFfd2t/QxGU5gu8TPXuT8LAjQ9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259802776"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259802776"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="554770868"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2022 11:47:27 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZdLq-0000K2-S9;
        Wed, 30 Mar 2022 18:47:26 +0000
Date:   Thu, 31 Mar 2022 02:46:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused
 variable 'pxa_camera_of_match'
Message-ID: <202203310219.HvAOIHBC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: 95495f2aa9d8df1a7697bab24118544d3568f41d media: platform: place Intel drivers on a separate dir
date:   2 weeks ago
config: s390-randconfig-r036-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310219.HvAOIHBC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95495f2aa9d8df1a7697bab24118544d3568f41d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 95495f2aa9d8df1a7697bab24118544d3568f41d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/intel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/intel/pxa_camera.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/media/platform/intel/pxa_camera.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/media/platform/intel/pxa_camera.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused variable 'pxa_camera_of_match' [-Wunused-const-variable]
   static const struct of_device_id pxa_camera_of_match[] = {
                                    ^
   13 warnings generated.


vim +/pxa_camera_of_match +2449 drivers/media/platform/intel/pxa_camera.c

7254026cedd42d drivers/media/video/pxa_camera.c               Guennadi Liakhovetski 2011-06-29  2448  
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29 @2449  static const struct of_device_id pxa_camera_of_match[] = {
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2450  	{ .compatible = "marvell,pxa270-qci", },
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2451  	{},
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2452  };
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2453  MODULE_DEVICE_TABLE(of, pxa_camera_of_match);
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2454  

:::::: The code at line 2449 was first introduced by commit
:::::: e9a1d94fa85542d4f3046ac82d234a3c8349c948 [media] media: pxa_camera device-tree support

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
