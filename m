Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8CE597733
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiHQTx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiHQTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:53:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1201C93B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660766013; x=1692302013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8orXyyxCBtLLgcnJj9tTm6hfXgvhuN9NRJc8uabrmEk=;
  b=F94ysfiLVpcw+6ydNFt4ge78JitSAWUQNET9MWtkvTNCZDHO108tOAAC
   ZJbdDm5zt1bOAGExKMZNWoudi0wH2HHMcCs/zFaT4nMPwDuQVYwvOhgtd
   nE1Tn8bz7ApyWxzhPkkBnvqf5NJs/lj+b//TLY358Rbp0nG32bYiLJNvH
   f5LoiPUc5QTitEVUG59zfJRSEPNRfz/HGk7jeksIBc5J3qPr/Uz6bujXJ
   fBIL/+yQoJCLEqSldGLRxwb4RKpeSKvlErSfGuUKrgAttUXeMdfYYQBEo
   Ym1v22N87HLS9WMAvtBfjeVDyowjBBkTogfSmFNEqDggLwzuONLqmE6O1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354331681"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="354331681"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 12:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="935504196"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 12:53:31 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOP6Y-0001He-1h;
        Wed, 17 Aug 2022 19:53:30 +0000
Date:   Thu, 18 Aug 2022 03:53:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-regmap:for-next 4/4] include/asm-generic/io.h:187:18:
 error: redefinition of 'readb'
Message-ID: <202208180333.1pfLpmaj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
head:   81c0386c1376da54f05d6916936db5220df9f97d
commit: 81c0386c1376da54f05d6916936db5220df9f97d [4/4] regmap: mmio: Support accelerared noinc operations
config: hexagon-randconfig-r035-20220815 (https://download.01.org/0day-ci/archive/20220818/202208180333.1pfLpmaj-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?id=81c0386c1376da54f05d6916936db5220df9f97d
        git remote add broonie-regmap https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
        git fetch --no-tags broonie-regmap for-next
        git checkout 81c0386c1376da54f05d6916936db5220df9f97d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:187:18: error: redefinition of 'readb'
   static inline u8 readb(const volatile void __iomem *addr)
                    ^
   include/asm-generic/io.h:186:15: note: expanded from macro 'readb'
   #define readb readb
                 ^
   arch/hexagon/include/asm/io.h:83:18: note: previous definition is here
   static inline u8 readb(const volatile void __iomem *addr)
                    ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:202:19: error: redefinition of 'readw'
   static inline u16 readw(const volatile void __iomem *addr)
                     ^
   include/asm-generic/io.h:201:15: note: expanded from macro 'readw'
   #define readw readw
                 ^
   arch/hexagon/include/asm/io.h:94:19: note: previous definition is here
   static inline u16 readw(const volatile void __iomem *addr)
                     ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:217:19: error: redefinition of 'readl'
   static inline u32 readl(const volatile void __iomem *addr)
                     ^
   include/asm-generic/io.h:216:15: note: expanded from macro 'readl'
   #define readl readl
                 ^
   arch/hexagon/include/asm/io.h:105:19: note: previous definition is here
   static inline u32 readl(const volatile void __iomem *addr)
                     ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:249:20: error: redefinition of 'writeb'
   static inline void writeb(u8 value, volatile void __iomem *addr)
                      ^
   include/asm-generic/io.h:248:16: note: expanded from macro 'writeb'
   #define writeb writeb
                  ^
   arch/hexagon/include/asm/io.h:122:20: note: previous definition is here
   static inline void writeb(u8 data, volatile void __iomem *addr)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:261:20: error: redefinition of 'writew'
   static inline void writew(u16 value, volatile void __iomem *addr)
                      ^
   include/asm-generic/io.h:260:16: note: expanded from macro 'writew'
   #define writew writew
                  ^
   arch/hexagon/include/asm/io.h:132:20: note: previous definition is here
   static inline void writew(u16 data, volatile void __iomem *addr)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:273:20: error: redefinition of 'writel'
   static inline void writel(u32 value, volatile void __iomem *addr)
                      ^
   include/asm-generic/io.h:272:16: note: expanded from macro 'writel'
   #define writel writel
                  ^
   arch/hexagon/include/asm/io.h:143:20: note: previous definition is here
   static inline void writel(u32 data, volatile void __iomem *addr)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> include/asm-generic/io.h:690:20: error: conflicting types for 'insb'
   static inline void insb(unsigned long addr, void *buffer, unsigned int count)
                      ^
   include/asm-generic/io.h:689:14: note: expanded from macro 'insb'
   #define insb insb
                ^
   arch/hexagon/include/asm/io.h:248:20: note: previous definition is here
   static inline void insb(unsigned long port, void *buffer, int count)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
>> include/asm-generic/io.h:698:20: error: conflicting types for 'insw'
   static inline void insw(unsigned long addr, void *buffer, unsigned int count)
                      ^
   include/asm-generic/io.h:697:14: note: expanded from macro 'insw'
   #define insw insw
                ^
   arch/hexagon/include/asm/io.h:259:20: note: previous definition is here
   static inline void insw(unsigned long port, void *buffer, int count)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   arch/hexagon/include/asm/io.h:39:38: note: expanded from macro 'readsw'
   #define readsw(p, d, l) __raw_readsw(p, d, l)
                                        ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:706:20: error: conflicting types for 'insl'
   static inline void insl(unsigned long addr, void *buffer, unsigned int count)
                      ^
   include/asm-generic/io.h:705:14: note: expanded from macro 'insl'
   #define insl insl
                ^
   arch/hexagon/include/asm/io.h:270:20: note: previous definition is here
   static inline void insl(unsigned long port, void *buffer, int count)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   arch/hexagon/include/asm/io.h:42:40: note: expanded from macro 'readsl'
   #define readsl(p, d, l)   __raw_readsl(p, d, l)
                                          ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:714:20: error: conflicting types for 'outsb'
   static inline void outsb(unsigned long addr, const void *buffer,
                      ^
   include/asm-generic/io.h:713:15: note: expanded from macro 'outsb'
   #define outsb outsb
                 ^
   arch/hexagon/include/asm/io.h:281:20: note: previous definition is here
   static inline void outsb(unsigned long port, const void *buffer, int count)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> include/asm-generic/io.h:723:20: error: conflicting types for 'outsw'
   static inline void outsw(unsigned long addr, const void *buffer,
                      ^
   include/asm-generic/io.h:722:15: note: expanded from macro 'outsw'
   #define outsw outsw
                 ^
   arch/hexagon/include/asm/io.h:291:20: note: previous definition is here
   static inline void outsw(unsigned long port, const void *buffer, int count)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   arch/hexagon/include/asm/io.h:40:40: note: expanded from macro 'writesw'
   #define writesw(p, d, l) __raw_writesw(p, d, l)
                                          ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:732:20: error: conflicting types for 'outsl'
   static inline void outsl(unsigned long addr, const void *buffer,
                      ^
   include/asm-generic/io.h:731:15: note: expanded from macro 'outsl'
   #define outsl outsl
                 ^
   arch/hexagon/include/asm/io.h:301:20: note: previous definition is here
   static inline void outsl(unsigned long port, const void *buffer, int count)
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   arch/hexagon/include/asm/io.h:43:41: note: expanded from macro 'writesl'
   #define writesl(p, d, l)  __raw_writesl(p, d, l)
                                           ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:1003:29: error: redefinition of 'virt_to_phys'
   static inline unsigned long virt_to_phys(volatile void *address)
                               ^
   include/asm-generic/io.h:1002:22: note: expanded from macro 'virt_to_phys'
   #define virt_to_phys virt_to_phys
                        ^
   arch/hexagon/include/asm/io.h:49:29: note: previous definition is here
   static inline unsigned long virt_to_phys(volatile void *address)
                               ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:1011:21: error: redefinition of 'phys_to_virt'
   static inline void *phys_to_virt(unsigned long address)
                       ^
   include/asm-generic/io.h:1010:22: note: expanded from macro 'phys_to_virt'
   #define phys_to_virt phys_to_virt
                        ^
   arch/hexagon/include/asm/io.h:58:21: note: previous definition is here
   static inline void *phys_to_virt(unsigned long address)
                       ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:1182:20: error: redefinition of 'memset_io'
   static inline void memset_io(volatile void __iomem *addr, int value,
                      ^
   include/asm-generic/io.h:1173:19: note: expanded from macro 'memset_io'
   #define memset_io memset_io
                     ^
   arch/hexagon/include/asm/io.h:191:20: note: previous definition is here
   static inline void memset_io(volatile void __iomem *addr, int value,
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:1199:20: error: conflicting types for 'memcpy_fromio'
   static inline void memcpy_fromio(void *buffer,
                      ^
   include/asm-generic/io.h:1190:23: note: expanded from macro 'memcpy_fromio'
   #define memcpy_fromio memcpy_fromio
                         ^
   arch/hexagon/include/asm/io.h:179:20: note: previous definition is here
   static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
                      ^
   In file included from arch/hexagon/kernel/asm-offsets.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:311:
>> include/asm-generic/io.h:1217:20: error: conflicting types for 'memcpy_toio'
   static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
                      ^
   include/asm-generic/io.h:1208:21: note: expanded from macro 'memcpy_toio'
   #define memcpy_toio memcpy_toio
                       ^
   arch/hexagon/include/asm/io.h:185:20: note: previous definition is here
   static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
                      ^
   12 warnings and 17 errors generated.
   make[2]: *** [scripts/Makefile.build:117: arch/hexagon/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1207: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/readb +187 include/asm-generic/io.h

cd24834130ac65 Jan Glauber        2012-11-29  179  
9216efafc52ff9 Thierry Reding     2014-10-01  180  /*
9216efafc52ff9 Thierry Reding     2014-10-01  181   * {read,write}{b,w,l,q}() access little endian memory and return result in
9216efafc52ff9 Thierry Reding     2014-10-01  182   * native endianness.
9216efafc52ff9 Thierry Reding     2014-10-01  183   */
3f7e212df82ca0 Arnd Bergmann      2009-05-13  184  
9216efafc52ff9 Thierry Reding     2014-10-01  185  #ifndef readb
9216efafc52ff9 Thierry Reding     2014-10-01  186  #define readb readb
9216efafc52ff9 Thierry Reding     2014-10-01 @187  static inline u8 readb(const volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann      2009-05-13  188  {
032d59e1cde9dd Sinan Kaya         2018-04-05  189  	u8 val;
032d59e1cde9dd Sinan Kaya         2018-04-05  190  
210031971cdd25 Sai Prakash Ranjan 2022-05-18  191  	log_read_mmio(8, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  192  	__io_br();
032d59e1cde9dd Sinan Kaya         2018-04-05  193  	val = __raw_readb(addr);
abbbbc83a210e9 Will Deacon        2019-02-22  194  	__io_ar(val);
210031971cdd25 Sai Prakash Ranjan 2022-05-18  195  	log_post_read_mmio(val, 8, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  196  	return val;
3f7e212df82ca0 Arnd Bergmann      2009-05-13  197  }
3f7e212df82ca0 Arnd Bergmann      2009-05-13  198  #endif
3f7e212df82ca0 Arnd Bergmann      2009-05-13  199  
9216efafc52ff9 Thierry Reding     2014-10-01  200  #ifndef readw
9216efafc52ff9 Thierry Reding     2014-10-01  201  #define readw readw
9216efafc52ff9 Thierry Reding     2014-10-01 @202  static inline u16 readw(const volatile void __iomem *addr)
9216efafc52ff9 Thierry Reding     2014-10-01  203  {
032d59e1cde9dd Sinan Kaya         2018-04-05  204  	u16 val;
032d59e1cde9dd Sinan Kaya         2018-04-05  205  
210031971cdd25 Sai Prakash Ranjan 2022-05-18  206  	log_read_mmio(16, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  207  	__io_br();
c1d55d50139bea Stafford Horne     2020-07-29  208  	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
abbbbc83a210e9 Will Deacon        2019-02-22  209  	__io_ar(val);
210031971cdd25 Sai Prakash Ranjan 2022-05-18  210  	log_post_read_mmio(val, 16, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  211  	return val;
9216efafc52ff9 Thierry Reding     2014-10-01  212  }
7dc59bdde70633 GuanXuetao         2011-02-22  213  #endif
7dc59bdde70633 GuanXuetao         2011-02-22  214  
9216efafc52ff9 Thierry Reding     2014-10-01  215  #ifndef readl
9216efafc52ff9 Thierry Reding     2014-10-01  216  #define readl readl
9216efafc52ff9 Thierry Reding     2014-10-01 @217  static inline u32 readl(const volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann      2009-05-13  218  {
032d59e1cde9dd Sinan Kaya         2018-04-05  219  	u32 val;
032d59e1cde9dd Sinan Kaya         2018-04-05  220  
210031971cdd25 Sai Prakash Ranjan 2022-05-18  221  	log_read_mmio(32, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  222  	__io_br();
c1d55d50139bea Stafford Horne     2020-07-29  223  	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
abbbbc83a210e9 Will Deacon        2019-02-22  224  	__io_ar(val);
210031971cdd25 Sai Prakash Ranjan 2022-05-18  225  	log_post_read_mmio(val, 32, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  226  	return val;
3f7e212df82ca0 Arnd Bergmann      2009-05-13  227  }
9216efafc52ff9 Thierry Reding     2014-10-01  228  #endif
3f7e212df82ca0 Arnd Bergmann      2009-05-13  229  
9216efafc52ff9 Thierry Reding     2014-10-01  230  #ifdef CONFIG_64BIT
9216efafc52ff9 Thierry Reding     2014-10-01  231  #ifndef readq
9216efafc52ff9 Thierry Reding     2014-10-01  232  #define readq readq
9216efafc52ff9 Thierry Reding     2014-10-01  233  static inline u64 readq(const volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann      2009-05-13  234  {
032d59e1cde9dd Sinan Kaya         2018-04-05  235  	u64 val;
032d59e1cde9dd Sinan Kaya         2018-04-05  236  
210031971cdd25 Sai Prakash Ranjan 2022-05-18  237  	log_read_mmio(64, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  238  	__io_br();
032d59e1cde9dd Sinan Kaya         2018-04-05  239  	val = __le64_to_cpu(__raw_readq(addr));
abbbbc83a210e9 Will Deacon        2019-02-22  240  	__io_ar(val);
210031971cdd25 Sai Prakash Ranjan 2022-05-18  241  	log_post_read_mmio(val, 64, addr, _THIS_IP_);
032d59e1cde9dd Sinan Kaya         2018-04-05  242  	return val;
3f7e212df82ca0 Arnd Bergmann      2009-05-13  243  }
9216efafc52ff9 Thierry Reding     2014-10-01  244  #endif
9216efafc52ff9 Thierry Reding     2014-10-01  245  #endif /* CONFIG_64BIT */
3f7e212df82ca0 Arnd Bergmann      2009-05-13  246  
9216efafc52ff9 Thierry Reding     2014-10-01  247  #ifndef writeb
9216efafc52ff9 Thierry Reding     2014-10-01  248  #define writeb writeb
9216efafc52ff9 Thierry Reding     2014-10-01 @249  static inline void writeb(u8 value, volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann      2009-05-13  250  {
210031971cdd25 Sai Prakash Ranjan 2022-05-18  251  	log_write_mmio(value, 8, addr, _THIS_IP_);
755bd04aaf4bf7 Sinan Kaya         2018-04-05  252  	__io_bw();
9216efafc52ff9 Thierry Reding     2014-10-01  253  	__raw_writeb(value, addr);
755bd04aaf4bf7 Sinan Kaya         2018-04-05  254  	__io_aw();
210031971cdd25 Sai Prakash Ranjan 2022-05-18  255  	log_post_write_mmio(value, 8, addr, _THIS_IP_);
3f7e212df82ca0 Arnd Bergmann      2009-05-13  256  }
9216efafc52ff9 Thierry Reding     2014-10-01  257  #endif
3f7e212df82ca0 Arnd Bergmann      2009-05-13  258  
9216efafc52ff9 Thierry Reding     2014-10-01  259  #ifndef writew
9216efafc52ff9 Thierry Reding     2014-10-01  260  #define writew writew
9216efafc52ff9 Thierry Reding     2014-10-01 @261  static inline void writew(u16 value, volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann      2009-05-13  262  {
210031971cdd25 Sai Prakash Ranjan 2022-05-18  263  	log_write_mmio(value, 16, addr, _THIS_IP_);
755bd04aaf4bf7 Sinan Kaya         2018-04-05  264  	__io_bw();
c1d55d50139bea Stafford Horne     2020-07-29  265  	__raw_writew((u16 __force)cpu_to_le16(value), addr);
755bd04aaf4bf7 Sinan Kaya         2018-04-05  266  	__io_aw();
210031971cdd25 Sai Prakash Ranjan 2022-05-18  267  	log_post_write_mmio(value, 16, addr, _THIS_IP_);
3f7e212df82ca0 Arnd Bergmann      2009-05-13  268  }
9216efafc52ff9 Thierry Reding     2014-10-01  269  #endif
3f7e212df82ca0 Arnd Bergmann      2009-05-13  270  
9216efafc52ff9 Thierry Reding     2014-10-01  271  #ifndef writel
9216efafc52ff9 Thierry Reding     2014-10-01  272  #define writel writel
9216efafc52ff9 Thierry Reding     2014-10-01 @273  static inline void writel(u32 value, volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann      2009-05-13  274  {
210031971cdd25 Sai Prakash Ranjan 2022-05-18  275  	log_write_mmio(value, 32, addr, _THIS_IP_);
755bd04aaf4bf7 Sinan Kaya         2018-04-05  276  	__io_bw();
c1d55d50139bea Stafford Horne     2020-07-29  277  	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
755bd04aaf4bf7 Sinan Kaya         2018-04-05  278  	__io_aw();
210031971cdd25 Sai Prakash Ranjan 2022-05-18  279  	log_post_write_mmio(value, 32, addr, _THIS_IP_);
3f7e212df82ca0 Arnd Bergmann      2009-05-13  280  }
9216efafc52ff9 Thierry Reding     2014-10-01  281  #endif
3f7e212df82ca0 Arnd Bergmann      2009-05-13  282  

:::::: The code at line 187 was first introduced by commit
:::::: 9216efafc52ff99e9351ef60de5fcafc2bc8adb6 asm-generic/io.h: Reconcile I/O accessor overrides

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
