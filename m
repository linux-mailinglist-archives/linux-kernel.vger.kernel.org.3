Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00274EDA67
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiCaNXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiCaNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:23:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16F1EA2BE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648732874; x=1680268874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YphCyCDyYB++FjBDTmWfkqYVyu71VV0RtubYJYXU9co=;
  b=hTMKSKZD3NbIuR6+xuPR6O73Iaut50aTuYhYntCVBzBrA5wIBlgr7XXo
   5G96yacIz46XXALqjvOud/TxWmmR1sOh2hO0DimTBucDXhRQ7BCfC2gkp
   R++9KnSVliupu5pKwTtPEQjuj7H2Fk9+18KKqdlAXeZZYpHr5OUOE2Qz/
   n6L2OIj56sjc/47e+4vgSNz5Jt4GHGwbr0j5mcO/juZT5Wupadots6Dwd
   yWKBFcCIMPI0t96dUHyMHXxQ0Pr7Y5ZVy8PDzA8B+TIZXvXskfx4NUcRw
   1mXTp0+lBBUXnkiqHMOoAwCPqxlzSdqqWTevAXiU8boZjsxWPkUZFHN6g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247335448"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="247335448"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="654742857"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 06:21:12 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZujf-0000Hg-UM;
        Thu, 31 Mar 2022 13:21:11 +0000
Date:   Thu, 31 Mar 2022 21:20:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_v5.18 16/25]
 drivers/vfio/pci/vfio_pci_zdev.c:112:5: warning: no previous prototype for
 function 'vfio_pci_info_zdev_add_caps'
Message-ID: <202203312150.HOgKwSSc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_v5.18
head:   2af6f07c2b38e8b37c41347ff9bd2b2e8b32a8d6
commit: cbf96a0bc2aeb156e3bedee832c2c336953d8df2 [16/25] vfio/pci: Split linux/vfio_pci_core.h
config: s390-randconfig-r025-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312150.HOgKwSSc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/jgunthorpe/linux/commit/cbf96a0bc2aeb156e3bedee832c2c336953d8df2
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_v5.18
        git checkout cbf96a0bc2aeb156e3bedee832c2c336953d8df2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kernel/ arch/s390/lib/ drivers/vfio/pci/ kernel/locking/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/vfio/pci/vfio_pci_zdev.c:9:
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
   In file included from drivers/vfio/pci/vfio_pci_zdev.c:9:
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
   In file included from drivers/vfio/pci/vfio_pci_zdev.c:9:
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
>> drivers/vfio/pci/vfio_pci_zdev.c:112:5: warning: no previous prototype for function 'vfio_pci_info_zdev_add_caps' [-Wmissing-prototypes]
   int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
       ^
   drivers/vfio/pci/vfio_pci_zdev.c:112:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
   ^
   static 
   13 warnings generated.


vim +/vfio_pci_info_zdev_add_caps +112 drivers/vfio/pci/vfio_pci_zdev.c

e6b817d4b8217a Matthew Rosato 2020-10-07  108  
e6b817d4b8217a Matthew Rosato 2020-10-07  109  /*
e6b817d4b8217a Matthew Rosato 2020-10-07  110   * Add all supported capabilities to the VFIO_DEVICE_GET_INFO capability chain.
e6b817d4b8217a Matthew Rosato 2020-10-07  111   */
536475109c8284 Max Gurtovoy   2021-08-26 @112  int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,

:::::: The code at line 112 was first introduced by commit
:::::: 536475109c82841126ca341ef0f138e7298880c1 vfio/pci: Rename vfio_pci_device to vfio_pci_core_device

:::::: TO: Max Gurtovoy <mgurtovoy@nvidia.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
