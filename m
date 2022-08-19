Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5959A55E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350216AbiHSSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350214AbiHSSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:18:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93122DEF0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660933090; x=1692469090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JQAOPktEPRsnqLPYYBE3d+Ey4OcbjKfZooDFCCpPMXM=;
  b=GLpg6r+GkuKyX/h6M+VyuzWPQS+nLxxW4+JRxPJXcbmf/Vc3PcfiNCwP
   ctUI0tcRT20dZ7je4eRZoFTn+Ekky3XISqLE4sVLJ6L9uDG1nxELyV6nm
   eRT08Q8hp+8LkQq9pZpRHMqv2+L69T+iGIFBHDbj41tUJ7Ww/nqMq65KF
   30h8doOY0iWt5iYjO0InIgwHaWIDL9gQBtpq6/m+oi/30mAKhYfOLuKdO
   KPZMP0byjlGHifn1qOUXltrFKxPQDe3ZIscJjp4D6ZXuW3jByPaIIogf/
   H1MMW7mbtbf+HW9NkdyEzQKAzxP8R7XMJWIzgcl9dWKoyuVYuHCOpwtK4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="276111947"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="276111947"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 11:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="584747126"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2022 11:18:06 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP6ZK-0001hT-0n;
        Fri, 19 Aug 2022 18:18:06 +0000
Date:   Sat, 20 Aug 2022 02:17:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 5/42]
 drivers/net/wwan/t7xx/t7xx_port_devlink.c:465:35: error: use of undeclared
 identifier 'DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT'; did you mean
 'DEVLINK_ATTR_FLASH_UPDATE_COMPONENT'?
Message-ID: <202208200242.iM0kVtBs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/netdevsim/dev.c
include/net/devlink.h
net/core/devlink.c
tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   e7096f2b22b32bd60568d91d12b562b3314bc8cc
commit: d8cf683bc939bf07c19efa964a98f10829e30df4 [5/42] net: devlink: extend info_get() version put to indicate a flash component
config: s390-randconfig-r044-20220819 (https://download.01.org/0day-ci/archive/20220820/202208200242.iM0kVtBs-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/jpirko/linux_mlxsw/commit/d8cf683bc939bf07c19efa964a98f10829e30df4
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout d8cf683bc939bf07c19efa964a98f10829e30df4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/ drivers/net/wwan/t7xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/wwan/t7xx/t7xx_port_devlink.c:10:
   In file included from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:23:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/net/wwan/t7xx/t7xx_port_devlink.c:10:
   In file included from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:23:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/net/wwan/t7xx/t7xx_port_devlink.c:10:
   In file included from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:23:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/net/wwan/t7xx/t7xx_port_devlink.c:465:35: error: use of undeclared identifier 'DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT'; did you mean 'DEVLINK_ATTR_FLASH_UPDATE_COMPONENT'?
           .supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT,
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            DEVLINK_ATTR_FLASH_UPDATE_COMPONENT
   include/uapi/linux/devlink.h:532:2: note: 'DEVLINK_ATTR_FLASH_UPDATE_COMPONENT' declared here
           DEVLINK_ATTR_FLASH_UPDATE_COMPONENT,    /* string */
           ^
   13 errors generated.


vim +465 drivers/net/wwan/t7xx/t7xx_port_devlink.c

87dae9e70bf7be M Chetan Kumar 2022-08-16  462  
87dae9e70bf7be M Chetan Kumar 2022-08-16  463  /* Call back function for devlink ops */
87dae9e70bf7be M Chetan Kumar 2022-08-16  464  static const struct devlink_ops devlink_flash_ops = {
87dae9e70bf7be M Chetan Kumar 2022-08-16 @465  	.supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_COMPONENT,
87dae9e70bf7be M Chetan Kumar 2022-08-16  466  	.flash_update = t7xx_devlink_flash_update,
87dae9e70bf7be M Chetan Kumar 2022-08-16  467  	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
87dae9e70bf7be M Chetan Kumar 2022-08-16  468  			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
87dae9e70bf7be M Chetan Kumar 2022-08-16  469  	.reload_down = t7xx_devlink_reload_down,
87dae9e70bf7be M Chetan Kumar 2022-08-16  470  	.reload_up = t7xx_devlink_reload_up,
87dae9e70bf7be M Chetan Kumar 2022-08-16  471  };
87dae9e70bf7be M Chetan Kumar 2022-08-16  472  

:::::: The code at line 465 was first introduced by commit
:::::: 87dae9e70bf7be2bd8a3c561fe3ddf666eb8a7a4 net: wwan: t7xx: Enable devlink based fw flashing and coredump collection

:::::: TO: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
