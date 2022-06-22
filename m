Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C1554992
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355092AbiFVKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiFVKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:38:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38973BA42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655894325; x=1687430325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rr5UuRYwdMhBPI+HAfBKvBZnzaU7T68eFKU3fNNebpg=;
  b=j4tv/6jZIqaqVPpcJAMdIuYEL0DKyqlFRCHqbWwe3jYWn4VVqznmaQ16
   7Z51/73u6EtnswaGiMKumul4DMS9z7Can3iJUEyKMGXWWi2ncbmC5z97E
   ZahHlaOUaSvOHOctZupANcdlhw+MmoYf6LGCB861iooj8DusQLN9Q27NC
   KnVT6q+3FaT1CYyzW0KlXncJf/v9U8iICNSAturtUYb4jK4cWPfXNlsMg
   x0QcSgV6LQIgj/Smw0Qq2mBaqsqeBfdmdsZohz92eBOVpM1dRYaqCkOKA
   VtPai/0CzCNHPT85C0xO1A8lWNbTqzZKKkVqSE/rMBfFKLQ1RuaU+mFgI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="280428390"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="280428390"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677472778"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 03:38:43 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3xkw-00019d-TV;
        Wed, 22 Jun 2022 10:38:42 +0000
Date:   Wed, 22 Jun 2022 18:38:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haijun Liu <haijun.liu@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: include/asm-generic/io.h:464:31: error: performing pointer
 arithmetic on a null pointer has undefined behavior
Message-ID: <202206221853.R4O7PFFI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haijun,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d
commit: 13e920d93e37fcaef4a9309515798a3cae9dcf19 net: wwan: t7xx: Add core components
date:   6 weeks ago
config: s390-buildonly-randconfig-r004-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221853.R4O7PFFI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13e920d93e37fcaef4a9309515798a3cae9dcf19
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 13e920d93e37fcaef4a9309515798a3cae9dcf19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/wwan/t7xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/wwan/t7xx/t7xx_pci.c:22:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
>> include/asm-generic/io.h:464:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/net/wwan/t7xx/t7xx_pci.c:22:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/net/wwan/t7xx/t7xx_pci.c:22:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   12 errors generated.


vim +464 include/asm-generic/io.h

3f7e212df82ca0 Arnd Bergmann  2009-05-13  450  
9216efafc52ff9 Thierry Reding 2014-10-01  451  /*
9216efafc52ff9 Thierry Reding 2014-10-01  452   * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
9216efafc52ff9 Thierry Reding 2014-10-01  453   * implemented on hardware that needs an additional delay for I/O accesses to
9216efafc52ff9 Thierry Reding 2014-10-01  454   * take effect.
9216efafc52ff9 Thierry Reding 2014-10-01  455   */
9216efafc52ff9 Thierry Reding 2014-10-01  456  
f009c89df79abe John Garry     2020-03-28  457  #if !defined(inb) && !defined(_inb)
f009c89df79abe John Garry     2020-03-28  458  #define _inb _inb
214ba3584b2e2c Stafford Horne 2020-07-26  459  static inline u8 _inb(unsigned long addr)
9216efafc52ff9 Thierry Reding 2014-10-01  460  {
87fe2d543f8173 Sinan Kaya     2018-04-05  461  	u8 val;
87fe2d543f8173 Sinan Kaya     2018-04-05  462  
87fe2d543f8173 Sinan Kaya     2018-04-05  463  	__io_pbr();
87fe2d543f8173 Sinan Kaya     2018-04-05 @464  	val = __raw_readb(PCI_IOBASE + addr);
abbbbc83a210e9 Will Deacon    2019-02-22  465  	__io_par(val);
87fe2d543f8173 Sinan Kaya     2018-04-05  466  	return val;
9216efafc52ff9 Thierry Reding 2014-10-01  467  }
9216efafc52ff9 Thierry Reding 2014-10-01  468  #endif
9216efafc52ff9 Thierry Reding 2014-10-01  469  

:::::: The code at line 464 was first introduced by commit
:::::: 87fe2d543f817300e13f0ea683f38c122737856e io: change inX() to have their own IO barrier overrides

:::::: TO: Sinan Kaya <okaya@codeaurora.org>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
