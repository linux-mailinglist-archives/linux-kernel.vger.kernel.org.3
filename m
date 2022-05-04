Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6325196F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbiEDFmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiEDFmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:42:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E624BF4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651642741; x=1683178741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E9tG3SXKs0FY6/8Enp14/1nQegyW5MhoV10nEN/hBMA=;
  b=n7NolYGXlkE+6sT8lqY9N8pkGezy1ceYdAXrOwXtxQ0H/xKYtwvIF9O0
   g89IYsGpSWSQMOjNVP83/5C7EbG7BqepoSU8sbl/1Nog8pd1Cj0Emzs9H
   7aP/qFl9EcmUkK7oOYxcrEFmdspgEO4s/MEl8XAWJesS+o8IvORIFnkAk
   kzrF/LP8Fw+xSrtPr5XNmwA4sYdFXS4pctDjwZgyqCPpIYe9kEQVCf+V9
   FdqsdxxMBeqrvsjOSkbQFYVLGqQ3KoEtrZfQV6BNyt2T7YjC82s1TWIPl
   EP8uV0fYctZhKCvVZDV4HbJtVEIVuCbtIKcFAymh/yPTNY8WLruCfG3FZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265256490"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="265256490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 22:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734242383"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 22:38:47 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm7io-000B63-Cf;
        Wed, 04 May 2022 05:38:46 +0000
Date:   Wed, 4 May 2022 13:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 39/39] include/asm-generic/io.h:737:9: warning:
 'insb' macro redefined
Message-ID: <202205041331.P2Djdwnj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   45df38c1492340a5c06ff7ad2966735c1f5c4d94
commit: 45df38c1492340a5c06ff7ad2966735c1f5c4d94 [39/39] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
config: riscv-randconfig-r003-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041331.P2Djdwnj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=45df38c1492340a5c06ff7ad2966735c1f5c4d94
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout 45df38c1492340a5c06ff7ad2966735c1f5c4d94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:737:9: warning: 'insb' macro redefined [-Wmacro-redefined]
   #define insb insb
           ^
   arch/riscv/include/asm/io.h:104:9: note: previous definition is here
   #define insb(addr, buffer, count) __insb((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:740:9: warning: 'insw' macro redefined [-Wmacro-redefined]
   #define insw insw
           ^
   arch/riscv/include/asm/io.h:105:9: note: previous definition is here
   #define insw(addr, buffer, count) __insw((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:743:9: warning: 'insl' macro redefined [-Wmacro-redefined]
   #define insl insl
           ^
   arch/riscv/include/asm/io.h:106:9: note: previous definition is here
   #define insl(addr, buffer, count) __insl((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:746:9: warning: 'outsb' macro redefined [-Wmacro-redefined]
   #define outsb outsb
           ^
   arch/riscv/include/asm/io.h:118:9: note: previous definition is here
   #define outsb(addr, buffer, count) __outsb((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:749:9: warning: 'outsw' macro redefined [-Wmacro-redefined]
   #define outsw outsw
           ^
   arch/riscv/include/asm/io.h:119:9: note: previous definition is here
   #define outsw(addr, buffer, count) __outsw((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:752:9: warning: 'outsl' macro redefined [-Wmacro-redefined]
   #define outsl outsl
           ^
   arch/riscv/include/asm/io.h:120:9: note: previous definition is here
   #define outsl(addr, buffer, count) __outsl((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_configfs.c:28:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1081:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   7 warnings and 20 errors generated.
--
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:737:9: warning: 'insb' macro redefined [-Wmacro-redefined]
   #define insb insb
           ^
   arch/riscv/include/asm/io.h:104:9: note: previous definition is here
   #define insb(addr, buffer, count) __insb((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:740:9: warning: 'insw' macro redefined [-Wmacro-redefined]
   #define insw insw
           ^
   arch/riscv/include/asm/io.h:105:9: note: previous definition is here
   #define insw(addr, buffer, count) __insw((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:743:9: warning: 'insl' macro redefined [-Wmacro-redefined]
   #define insl insl
           ^
   arch/riscv/include/asm/io.h:106:9: note: previous definition is here
   #define insl(addr, buffer, count) __insl((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:746:9: warning: 'outsb' macro redefined [-Wmacro-redefined]
   #define outsb outsb
           ^
   arch/riscv/include/asm/io.h:118:9: note: previous definition is here
   #define outsb(addr, buffer, count) __outsb((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:749:9: warning: 'outsw' macro redefined [-Wmacro-redefined]
   #define outsw outsw
           ^
   arch/riscv/include/asm/io.h:119:9: note: previous definition is here
   #define outsw(addr, buffer, count) __outsw((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
>> include/asm-generic/io.h:752:9: warning: 'outsl' macro redefined [-Wmacro-redefined]
   #define outsl outsl
           ^
   arch/riscv/include/asm/io.h:120:9: note: previous definition is here
   #define outsl(addr, buffer, count) __outsl((void __iomem *)(long)addr, buffer, count)
           ^
   In file included from drivers/target/target_core_spc.c:16:
   In file included from include/scsi/scsi_tcq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1081:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
   drivers/target/target_core_spc.c:223:6: warning: variable 'prod_len' set but not used [-Wunused-but-set-variable]
           u32 prod_len;
               ^
   drivers/target/target_core_spc.c:224:6: warning: variable 'unit_serial_len' set but not used [-Wunused-but-set-variable]
           u32 unit_serial_len, off = 0;
               ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   9 warnings and 20 errors generated.


vim +/insb +737 include/asm-generic/io.h

   736	
 > 737	#define insb insb
   738	void insb(unsigned long addr, void *buffer, unsigned int count)
   739		__compiletime_error("insb()/insb_p() requires CONFIG_HAS_IOPORT");
 > 740	#define insw insw
   741	void insw(unsigned long addr, void *buffer, unsigned int count)
   742		__compiletime_error("insw()/insw_p() requires CONFIG_HAS_IOPORT");
 > 743	#define insl insl
   744	void insl(unsigned long addr, void *buffer, unsigned int count)
   745		__compiletime_error("insl()/insl_p() requires CONFIG_HAS_IOPORT");
 > 746	#define outsb outsb
   747	void outsb(unsigned long addr, const void *buffer, unsigned int count)
   748		__compiletime_error("outsb()/outsb_p() requires CONFIG_HAS_IOPORT");
 > 749	#define outsw outsw
   750	void outsw(unsigned long addr, const void *buffer, unsigned int count)
   751		__compiletime_error("outsw()/outsw_p() requires CONFIG_HAS_IOPORT");
 > 752	#define outsl outsl
   753	void outsl(unsigned long addr, const void *buffer, unsigned int count)
   754		__compiletime_error("outsl()/outsl_p() requires CONFIG_HAS_IOPORT");
   755	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
