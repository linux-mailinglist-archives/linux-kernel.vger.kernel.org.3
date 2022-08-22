Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE89A59C4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiHVRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiHVRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:18:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED511C17;
        Mon, 22 Aug 2022 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661188738; x=1692724738;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rvzhxAN923TZNtxOk4/pdjMAS98gjeFl05tyBxLutYE=;
  b=VDb91db0sdPk/EH46ke/2lbUsvoa1O4zT2PUmgcoE3B+12NjtC+tbox6
   fb4ejhZepEYvaCAq7Rqw4Ruq8QiKrtn1iB8KWx96vCngy9gzOYekaTWZb
   2ev4Oc2TKQWJIIrRp/UdwzdOHQrx+b1lvvhlO4UOASYJxrK+fUpbHLD1j
   yojxHeiwlx3BNl7kD+uE82Cr6lmZ+hrHXweqCSwGc6p38PfyPZbZYiuh3
   yb5Yc3NX/0I+q7RZ+/QDx7wMSJIyh4I0KyXjFM1vMdPrRgviCrgHFCyCR
   VfGmgNPr5VhPE6octcjnuAO360AxxyFek3rN0rh0qsyHCF9jGqgVU63o/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280445954"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280445954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 10:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="784929198"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2022 10:18:56 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQB4h-0000W0-39;
        Mon, 22 Aug 2022 17:18:55 +0000
Date:   Tue, 23 Aug 2022 01:18:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused
 variable 'pxa_camera_of_match'
Message-ID: <202208230120.e4q8YyzQ-lkp@intel.com>
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

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: 95495f2aa9d8df1a7697bab24118544d3568f41d media: platform: place Intel drivers on a separate dir
date:   5 months ago
config: s390-randconfig-r034-20220822 (https://download.01.org/0day-ci/archive/20220823/202208230120.e4q8YyzQ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project abce7acebd4c06c977bc4bd79170697f1122bc5e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95495f2aa9d8df1a7697bab24118544d3568f41d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 95495f2aa9d8df1a7697bab24118544d3568f41d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag where applicable
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

7254026cedd42d7 drivers/media/video/pxa_camera.c               Guennadi Liakhovetski 2011-06-29  2448  
e9a1d94fa85542d drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29 @2449  static const struct of_device_id pxa_camera_of_match[] = {
e9a1d94fa85542d drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2450  	{ .compatible = "marvell,pxa270-qci", },
e9a1d94fa85542d drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2451  	{},
e9a1d94fa85542d drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2452  };
e9a1d94fa85542d drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2453  MODULE_DEVICE_TABLE(of, pxa_camera_of_match);
e9a1d94fa85542d drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2454  

:::::: The code at line 2449 was first introduced by commit
:::::: e9a1d94fa85542d4f3046ac82d234a3c8349c948 [media] media: pxa_camera device-tree support

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
