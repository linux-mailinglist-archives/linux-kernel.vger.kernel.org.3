Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2854E8089
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiCZLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiCZLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:06:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252F23D5B8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648292715; x=1679828715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O8rx2yhA71i8Ia/09O+956PixOXb7crTX+d1bHTkAqk=;
  b=a7kmqLHnaLi5yv6gC2Tpjz5bW/uUK9zK5mSB2OEQgpkw0NT7s+38tDgo
   hWh+0tYV1qjtHEbZqoTnUQoRJoTLnKeG1TkPhtYS+M1viQ8pLuKct0pUd
   E8acWEPiXaZacNRoGOkyXgBnjKgj6ZowTPhDvpAoLU9Ur+265ZKlglnf2
   6KZrNA7z5yg8ZYKrVP/wrdcU5pPJ/Sp7BCWdPGNO7gBQ2J/27r9fdFGRE
   0OYKmTK1SheHISI33rFzTMIzlYsoulg8i7qcJRXUmEhKwYGLkP4nsRHHq
   grCIucpDH6cP9nmyqK/DOgvhpNtl14zFXt9JczLBxWgqsleX3QTaid46a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="246262345"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="246262345"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 04:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="718486351"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2022 04:05:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY4EK-000NIu-Az; Sat, 26 Mar 2022 11:05:12 +0000
Date:   Sat, 26 Mar 2022 19:04:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next-2022-03-25 32/32]
 drivers/scsi/ufs-drivers/ufs-exynos.c:1596:34: warning: unused variable
 'exynos_ufs_of_match'
Message-ID: <202203261830.M6xPZjki-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://github.com/bvanassche/linux ufs-for-next-2022-03-25
head:   976ba17fe820846e56fb154b1ae35f5d90be192b
commit: 976ba17fe820846e56fb154b1ae35f5d90be192b [32/32] scsi: ufs: Split the drivers/scsi/ufs directory
config: s390-randconfig-r013-20220324 (https://download.01.org/0day-ci/archive/20220326/202203261830.M6xPZjki-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/bvanassche/linux/commit/976ba17fe820846e56fb154b1ae35f5d90be192b
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next-2022-03-25
        git checkout 976ba17fe820846e56fb154b1ae35f5d90be192b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/scsi/ufs-drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/ufs-drivers/ufs-exynos.c:16:
   In file included from include/linux/of_address.h:7:
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
   In file included from drivers/scsi/ufs-drivers/ufs-exynos.c:16:
   In file included from include/linux/of_address.h:7:
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
   In file included from drivers/scsi/ufs-drivers/ufs-exynos.c:16:
   In file included from include/linux/of_address.h:7:
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
>> drivers/scsi/ufs-drivers/ufs-exynos.c:1596:34: warning: unused variable 'exynos_ufs_of_match' [-Wunused-const-variable]
   static const struct of_device_id exynos_ufs_of_match[] = {
                                    ^
   13 warnings generated.


vim +/exynos_ufs_of_match +1596 drivers/scsi/ufs-drivers/ufs-exynos.c

55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28  1595  
55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28 @1596  static const struct of_device_id exynos_ufs_of_match[] = {
55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28  1597  	{ .compatible = "samsung,exynos7-ufs",
55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28  1598  	  .data	      = &exynos_ufs_drvs },
cc52e15397cc5d drivers/scsi/ufs/ufs-exynos.c Chanho Park 2021-10-18  1599  	{ .compatible = "samsung,exynosautov9-ufs",
cc52e15397cc5d drivers/scsi/ufs/ufs-exynos.c Chanho Park 2021-10-18  1600  	  .data	      = &exynosauto_ufs_drvs },
be39f4fd8dd430 drivers/scsi/ufs/ufs-exynos.c Chanho Park 2021-10-18  1601  	{ .compatible = "samsung,exynosautov9-ufs-vh",
be39f4fd8dd430 drivers/scsi/ufs/ufs-exynos.c Chanho Park 2021-10-18  1602  	  .data	      = &exynosauto_ufs_vh_drvs },
55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28  1603  	{},
55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28  1604  };
55f4b1f73631a0 drivers/scsi/ufs/ufs-exynos.c Alim Akhtar 2020-05-28  1605  

:::::: The code at line 1596 was first introduced by commit
:::::: 55f4b1f73631a0817717fe6e98517de51b4c3527 scsi: ufs: ufs-exynos: Add UFS host support for Exynos SoCs

:::::: TO: Alim Akhtar <alim.akhtar@samsung.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
