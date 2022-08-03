Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB35C588633
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiHCEM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiHCEMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:12:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0327169
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659499970; x=1691035970;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9oX+onP7ht9HH5c0vbwg203y/Tb7RxzqJrlpcQeSffE=;
  b=hvNjgwFWQ4t8bQzF8srAIQTDyqNot1pGhRoOh7vMNCPGGBd3t1P4uzqr
   Hd8LHrgUy2cqlOdGCXEQoqGAJvtVsX2PdpgGLZZWim4Xqv9li73MZwzWM
   nYuZHwa0zZGeUqf/h1ocwZp3wz3Jbf25el2iGiCFmGncvUsd/xZKuuJ5b
   uCLpwjGpsgRAYjF8yCWT7nbcH0iEW8iljCzeizQp9HyiewLYs6PSh9GRW
   QhlHszFrTlvE5CYWlrR8rDVmVZzxuHs4dGNd5eMNpoNUjURT5pXUNDpsR
   6lZUnonRGXQuppSgkFVLNpsMOYxqqHRYNhiSqSo9uU363dYxdMIETGmyA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288333949"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="288333949"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 21:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="930230395"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 21:12:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ5kV-000Go9-2h;
        Wed, 03 Aug 2022 04:12:47 +0000
Date:   Wed, 3 Aug 2022 12:11:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tobetter:odroid-5.19.y 51/99] drivers/gpu/drm/drm_mipi_dbi.c:77:17:
 warning: unused variable 'mipi_dbi_dcs_read_commands'
Message-ID: <202208031219.1wtTDs54-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjin,

First bad commit (maybe != root cause):

tree:   https://github.com/tobetter/linux odroid-5.19.y
head:   7df5baf82efb498c71096e60e58d2bba6f4fb0e1
commit: 909850898b8e826a9df13be97cf03b0d01cf4b1b [51/99] ODROID-COMMON: gpu/drm: Add new Tiny DRM driver with Ili9488
config: s390-randconfig-c005-20220802 (https://download.01.org/0day-ci/archive/20220803/202208031219.1wtTDs54-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/tobetter/linux/commit/909850898b8e826a9df13be97cf03b0d01cf4b1b
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.19.y
        git checkout 909850898b8e826a9df13be97cf03b0d01cf4b1b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_mipi_dbi.c:13:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/gpu/drm/drm_mipi_dbi.c:13:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/gpu/drm/drm_mipi_dbi.c:13:
   In file included from include/linux/spi/spi.h:15:
   In file included from include/linux/scatterlist.h:9:
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
>> drivers/gpu/drm/drm_mipi_dbi.c:77:17: warning: unused variable 'mipi_dbi_dcs_read_commands' [-Wunused-const-variable]
   static const u8 mipi_dbi_dcs_read_commands[] = {
                   ^
   13 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
   Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
   Selected by [y]:
   - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)


vim +/mipi_dbi_dcs_read_commands +77 drivers/gpu/drm/drm_mipi_dbi.c

02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   76  
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  @77  static const u8 mipi_dbi_dcs_read_commands[] = {
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   78  	MIPI_DCS_GET_DISPLAY_ID,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   79  	MIPI_DCS_GET_RED_CHANNEL,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   80  	MIPI_DCS_GET_GREEN_CHANNEL,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   81  	MIPI_DCS_GET_BLUE_CHANNEL,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   82  	MIPI_DCS_GET_DISPLAY_STATUS,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   83  	MIPI_DCS_GET_POWER_MODE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   84  	MIPI_DCS_GET_ADDRESS_MODE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   85  	MIPI_DCS_GET_PIXEL_FORMAT,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   86  	MIPI_DCS_GET_DISPLAY_MODE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   87  	MIPI_DCS_GET_SIGNAL_MODE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   88  	MIPI_DCS_GET_DIAGNOSTIC_RESULT,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   89  	MIPI_DCS_READ_MEMORY_START,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   90  	MIPI_DCS_READ_MEMORY_CONTINUE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   91  	MIPI_DCS_GET_SCANLINE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   92  	MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   93  	MIPI_DCS_GET_CONTROL_DISPLAY,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   94  	MIPI_DCS_GET_POWER_SAVE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   95  	MIPI_DCS_GET_CABC_MIN_BRIGHTNESS,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   96  	MIPI_DCS_READ_DDB_START,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   97  	MIPI_DCS_READ_DDB_CONTINUE,
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   98  	0, /* sentinel */
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   99  };
02dd95fe3169362 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  100  

:::::: The code at line 77 was first introduced by commit
:::::: 02dd95fe316936269a52d6ccb971bb956412b40a drm/tinydrm: Add MIPI DBI support

:::::: TO: Noralf Trønnes <noralf@tronnes.org>
:::::: CC: Noralf Trønnes <noralf@tronnes.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
