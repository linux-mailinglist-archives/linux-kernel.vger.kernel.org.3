Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA46453234E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiEXGhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiEXGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:37:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453379393
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653374233; x=1684910233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ct3VwdGw1vT8shDjF/RItd2cXMngHVCA6ptzl3SwK6s=;
  b=DobYdRa6lAu+tD6U3aHbcCzMAZM+RdnWt7KVavIJemW9NgXg6zReF8W4
   dvFIhrGLAYzkmkTOLJ4oNYYvc089a8bZV38ubEudhqIVhDsS4lx43AT4L
   eLC4enyiC7mxohg4I//vIRTiNjmVW2TyNNxEKLAvYVvb6riCHZ+ThzveS
   2fXEygAwPRX/vE3F5thp78oCunouYOtw/UNCmRlZ5pRmsFKEy+W37H1LU
   lf6bSUdpKp7ItpDGLC3/xC60SBm64P2804H1PR5OoS9Xa/tX6x9mAieC4
   Ob7pszT3fcIet9rXy1uznBF9qZycQF+gdxcMWH6Q/3Vfx8vzCW++SQl6V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="336501194"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="336501194"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 23:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="676227423"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 May 2022 23:37:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntOAI-0001pA-O1;
        Tue, 24 May 2022 06:37:10 +0000
Date:   Tue, 24 May 2022 14:36:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/net/dsa/lan9303_mdio.c:145:34: warning: unused variable
 'lan9303_mdio_of_match'
Message-ID: <202205241446.TMjrujfW-lkp@intel.com>
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

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   143a6252e1b8ab424b4b293512a97cca7295c182
commit: 227d72063fccb2d19b30fb4197fba478514f7d83 dsa: simplify Kconfig symbols and dependencies
date:   1 year, 2 months ago
config: s390-randconfig-r034-20220524 (https://download.01.org/0day-ci/archive/20220524/202205241446.TMjrujfW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=227d72063fccb2d19b30fb4197fba478514f7d83
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 227d72063fccb2d19b30fb4197fba478514f7d83
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/dsa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   In file included from drivers/net/dsa/lan9303_mdio.c:10:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
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
   In file included from drivers/net/dsa/lan9303_mdio.c:10:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
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
   In file included from drivers/net/dsa/lan9303_mdio.c:10:
   In file included from include/linux/mdio.h:9:
   In file included from include/uapi/linux/mdio.h:15:
   In file included from include/linux/mii.h:13:
   In file included from include/linux/linkmode.h:5:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
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
>> drivers/net/dsa/lan9303_mdio.c:145:34: warning: unused variable 'lan9303_mdio_of_match' [-Wunused-const-variable]
   static const struct of_device_id lan9303_mdio_of_match[] = {
                                    ^
   21 warnings generated.


vim +/lan9303_mdio_of_match +145 drivers/net/dsa/lan9303_mdio.c

dc7005831523d6 Juergen Beisert 2017-04-18  144  
dc7005831523d6 Juergen Beisert 2017-04-18 @145  static const struct of_device_id lan9303_mdio_of_match[] = {
dc7005831523d6 Juergen Beisert 2017-04-18  146  	{ .compatible = "smsc,lan9303-mdio" },
dc7005831523d6 Juergen Beisert 2017-04-18  147  	{ /* sentinel */ },
dc7005831523d6 Juergen Beisert 2017-04-18  148  };
dc7005831523d6 Juergen Beisert 2017-04-18  149  MODULE_DEVICE_TABLE(of, lan9303_mdio_of_match);
dc7005831523d6 Juergen Beisert 2017-04-18  150  

:::::: The code at line 145 was first introduced by commit
:::::: dc7005831523d674be11a98f3256e0cc871157d6 net: dsa: LAN9303: add MDIO managed mode support

:::::: TO: Juergen Beisert <jbe@pengutronix.de>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
