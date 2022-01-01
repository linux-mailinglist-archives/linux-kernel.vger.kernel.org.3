Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3913482639
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 01:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiAAA4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 19:56:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:44270 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbiAAA4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 19:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640998582; x=1672534582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2HFGC/OfpPDDxtoPYhmbmSb5PLrj5xh+f3NHm9mZPLI=;
  b=RYgxrFlo4Sl0KXj4CpJVRknbkHUu+Xpu0OjKus/uB0VV8dEij4NnmCOV
   7ucU+hfJxN1curDxPt/E+hsxvp/GXnpWSJlOWn/1yKQAUPK8r5RSmfm95
   XzO+c2nYPQfa6uEth0yvSnVN2ncCezaUDVsqKDy0jpmgNZE1tkpzbHVqC
   3FdWewx06U25yOfbZ5iHnpcO4TKWbiTBoZFZvv+zPTZEJRvFsu89v5sMp
   1HoOUKVP8WR42sKmNUzpb4yahbB22ca/RYqIzJEwYEuq1D/5BDnD5ZkVY
   tb3myuvGLDYfBVQy5dvi2mCO8DgFG7JAIrAQRPqEPeMKM3r609DLOzM6/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="228679857"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="228679857"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 16:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="555148696"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Dec 2021 16:56:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Sh1-000Bqp-1S; Sat, 01 Jan 2022 00:56:19 +0000
Date:   Sat, 1 Jan 2022 08:55:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/net/dsa/ocelot/seville_vsc9953.c:1255:34: warning: unused
 variable 'seville_of_match'
Message-ID: <202201010857.K6Bw7Kem-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 227d72063fccb2d19b30fb4197fba478514f7d83 dsa: simplify Kconfig symbols and dependencies
date:   9 months ago
config: s390-randconfig-r044-20220101 (https://download.01.org/0day-ci/archive/20220101/202201010857.K6Bw7Kem-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7cd109b92c72855937273a6c8ab19016fbe27d33)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=227d72063fccb2d19b30fb4197fba478514f7d83
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 227d72063fccb2d19b30fb4197fba478514f7d83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/dsa/ocelot/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/dsa/ocelot/seville_vsc9953.c:6:
   In file included from include/soc/mscc/ocelot_vcap.h:9:
   In file included from include/soc/mscc/ocelot.h:10:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:21:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |            \
                     ^
   In file included from drivers/net/dsa/ocelot/seville_vsc9953.c:6:
   In file included from include/soc/mscc/ocelot_vcap.h:9:
   In file included from include/soc/mscc/ocelot.h:10:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:22:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
                     ^
   In file included from drivers/net/dsa/ocelot/seville_vsc9953.c:6:
   In file included from include/soc/mscc/ocelot_vcap.h:9:
   In file included from include/soc/mscc/ocelot.h:10:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:120:12: note: expanded from macro '__swab32'
           __fswab32(x))
                     ^
   In file included from drivers/net/dsa/ocelot/seville_vsc9953.c:6:
   In file included from include/soc/mscc/ocelot_vcap.h:9:
   In file included from include/soc/mscc/ocelot.h:10:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
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
>> drivers/net/dsa/ocelot/seville_vsc9953.c:1255:34: warning: unused variable 'seville_of_match' [-Wunused-const-variable]
   static const struct of_device_id seville_of_match[] = {
                                    ^
   21 warnings generated.


vim +/seville_of_match +1255 drivers/net/dsa/ocelot/seville_vsc9953.c

84705fc165526e Maxim Kochetkov 2020-07-13  1254  
84705fc165526e Maxim Kochetkov 2020-07-13 @1255  static const struct of_device_id seville_of_match[] = {
84705fc165526e Maxim Kochetkov 2020-07-13  1256  	{ .compatible = "mscc,vsc9953-switch" },
84705fc165526e Maxim Kochetkov 2020-07-13  1257  	{ },
84705fc165526e Maxim Kochetkov 2020-07-13  1258  };
84705fc165526e Maxim Kochetkov 2020-07-13  1259  MODULE_DEVICE_TABLE(of, seville_of_match);
84705fc165526e Maxim Kochetkov 2020-07-13  1260  

:::::: The code at line 1255 was first introduced by commit
:::::: 84705fc165526e8e55d208b2b10a48cc720a106a net: dsa: felix: introduce support for Seville VSC9953 switch

:::::: TO: Maxim Kochetkov <fido_max@inbox.ru>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
