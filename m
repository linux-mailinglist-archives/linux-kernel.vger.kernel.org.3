Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E154464A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiFIIqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiFIIoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:44:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15B47561
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654764151; x=1686300151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rkvkafBJHA9CZwBiX7ZFsiojylCod4feTJKDvkaFfP4=;
  b=lW1f72hVlgSREq2pbeXGoGnWimRmsZUXq9xUlL/BdFsB0NfE1FO8wHWr
   sbs3j6+etKkqJGWq3MsZmlxyeECky3ccuGSG/gaX8LY2mMU96rrbscfv3
   Vs2tpPLE04NZE/RqRXNiTdCOYSOcE4I10Ys5e/x4VtRXUUafrQ/AOCgwd
   1BgshiEDPdRa6S3OhtyqeveotqgaVIKnID9kxgmWQwLU00u0jj6fEpgI7
   iCY6IkQrFrtfdX+WybcXs4yDFIFr+lxWCqW5mnCnU4/GuJkKeZYVcFWCT
   VjbWIdggEWMnVtHwBEFoK759R0R33oawB0ysOFLdTQmWbxZsRPceMICXS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="274728046"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="274728046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 01:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="566295068"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2022 01:42:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzDkI-000Fnx-Pd;
        Thu, 09 Jun 2022 08:42:26 +0000
Date:   Thu, 9 Jun 2022 16:42:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mayuresh Chitale <mchitale@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 35/52]
 arch/riscv/kernel/setup.c:299:2: error: call to undeclared function
 'riscv_tlbflush_init'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206091653.pAFZq908-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: efaaec7bcbaf3346e07955be46d5e3c2bd662167 [35/52] riscv: mm: use svinval instructions instead of sfence.vma
config: riscv-randconfig-r042-20220609 (https://download.01.org/0day-ci/archive/20220609/202206091653.pAFZq908-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/efaaec7bcbaf3346e07955be46d5e3c2bd662167
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout efaaec7bcbaf3346e07955be46d5e3c2bd662167
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/lib/ arch/riscv/mm/ kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/setup.c:21:
   In file included from include/linux/efi.h:20:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/riscv/kernel/setup.c:21:
   In file included from include/linux/efi.h:20:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/riscv/kernel/setup.c:21:
   In file included from include/linux/efi.h:20:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> arch/riscv/kernel/setup.c:299:2: error: call to undeclared function 'riscv_tlbflush_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           riscv_tlbflush_init();
           ^
   7 warnings and 1 error generated.


vim +/riscv_tlbflush_init +299 arch/riscv/kernel/setup.c

   297	
   298		riscv_fill_hwcap();
 > 299		riscv_tlbflush_init();
   300		apply_boot_alternatives();
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
