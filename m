Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5C4B157E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbiBJSpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:45:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiBJSpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:45:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9EF47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644518706; x=1676054706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v3iYPiqCdKGv+k/GYQIr2pn/ZjWnJ8s735hfY/vqC9A=;
  b=VdN6NrajvPaMVHqGtpwaUt+KmuQgzdXZf7v1XjWzE3dnAxUIZh4vCyxv
   cQPe+U1o9dkY7CqfWha1zU5e4tDwE9wripU5iHOb5OtWRVttUlOXNKrOh
   Iy6BvJwM34z/zlu1BoCgvZNw/KEHWpC4J+YfB8/+YWWPhfZpENlvzGQVK
   rve0HZDCeJIUyId4lMDOBeLbSNi89lFmN0iEpi8BmCo2LmE2SZh/9uGmT
   xIvUpDbVlm/8/yqfO2vXekpQSPHQzNvcg3niCuikPTw+7xGYB7iXodxT5
   TsRhZ6rvpFLui5b8Tt7WP2Ay4xWxqDCJK4alBIixdjc7RuPtZORwHL3LC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312849089"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="312849089"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:45:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="633778683"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2022 10:45:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIERD-0003bL-11; Thu, 10 Feb 2022 18:45:03 +0000
Date:   Fri, 11 Feb 2022 02:44:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v6_svpbmt-v6 35/35]
 arch/riscv/include/asm/pgtable-64.h:105:2: error: expected assembly-time
 absolute expression
Message-ID: <202202110254.CrnRD2CM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_svpbmt-v6
head:   54acb36c958fc990cc59889f79c8ddca7386c295
commit: 54acb36c958fc990cc59889f79c8ddca7386c295 [35/35] riscv: xtpbmt: Fixup T-HEAD CPU _PAGE_KERNEL quirks
config: riscv-randconfig-c006-20220209 (https://download.01.org/0day-ci/archive/20220211/202202110254.CrnRD2CM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project aa845d7a245d85c441d0bd44fc7b6c3be8f3de8d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/54acb36c958fc990cc59889f79c8ddca7386c295
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_svpbmt-v6
        git checkout 54acb36c958fc990cc59889f79c8ddca7386c295
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
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
   In file included from arch/riscv/kernel/setup.c:12:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:105:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_NOCACHE);
           ^
   arch/riscv/include/asm/errata_list.h:52:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE_2("li %0, 0\t\nnop",                                                    \
       ^
   arch/riscv/include/asm/alternative-macros.h:147:2: note: expanded from macro 'ALTERNATIVE_2'
           _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1, \
           ^
   arch/riscv/include/asm/alternative-macros.h:117:2: note: expanded from macro '_ALTERNATIVE_CFG_2'
           __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),   \
           ^
   arch/riscv/include/asm/alternative-macros.h:112:2: note: expanded from macro '__ALTERNATIVE_CFG_2'
           ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)    \
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/kernel/setup.c:12:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:105:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_NOCACHE);
           ^
   arch/riscv/include/asm/errata_list.h:52:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE_2("li %0, 0\t\nnop",                                                    \
       ^
   arch/riscv/include/asm/alternative-macros.h:147:2: note: expanded from macro 'ALTERNATIVE_2'
           _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1, \
           ^
   arch/riscv/include/asm/alternative-macros.h:117:2: note: expanded from macro '_ALTERNATIVE_CFG_2'
           __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),   \
           ^
   arch/riscv/include/asm/alternative-macros.h:112:2: note: expanded from macro '__ALTERNATIVE_CFG_2'
           ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)    \
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   7 warnings and 2 errors generated.


vim +105 arch/riscv/include/asm/pgtable-64.h

54acb36c958fc9 Guo Ren 2022-02-10  100  
bac41a3372f958 Wei Fu  2021-11-29  101  static inline u64 riscv_page_nocache(void)
bac41a3372f958 Wei Fu  2021-11-29  102  {
bac41a3372f958 Wei Fu  2021-11-29  103  	u64 val;
bac41a3372f958 Wei Fu  2021-11-29  104  
bac41a3372f958 Wei Fu  2021-11-29 @105  	ALT_SVPBMT(val, _PAGE_NOCACHE);
bac41a3372f958 Wei Fu  2021-11-29  106  	return val;
bac41a3372f958 Wei Fu  2021-11-29  107  }
bac41a3372f958 Wei Fu  2021-11-29  108  

:::::: The code at line 105 was first introduced by commit
:::::: bac41a3372f9586652716665df9da6c4059b9309 riscv: add RISC-V Svpbmt extension support

:::::: TO: Wei Fu <wefu@redhat.com>
:::::: CC: Guo Ren <guoren@linux.alibaba.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
