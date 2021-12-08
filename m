Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1846DF27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbhLIACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:02:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:64957 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238024AbhLIACf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:02:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298771266"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="298771266"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 15:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="680115112"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2021 15:59:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv6pw-0001DX-1r; Wed, 08 Dec 2021 23:59:00 +0000
Date:   Thu, 9 Dec 2021 07:58:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:foll_unshare 1/2] net/phonet/sysctl.c:24:8: error:
 field designator 'seqcount' does not refer to any field in type 'seqcount_t'
 (aka 'struct seqcount')
Message-ID: <202112090736.d9HFdWOz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux foll_unshare
head:   f4b54ddc31ca94dedc57a3aab1f42d348537a31b
commit: f270db76384cb1df5a7f1b67226a8c8515583e5f [1/2] seqlock: provide lockdep-free raw_seqcount_t variant
config: riscv-buildonly-randconfig-r003-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090736.d9HFdWOz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/davidhildenbrand/linux/commit/f270db76384cb1df5a7f1b67226a8c8515583e5f
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand foll_unshare
        git checkout f270db76384cb1df5a7f1b67226a8c8515583e5f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/phonet/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/phonet/sysctl.c:17:
   In file included from include/net/sock.h:38:
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
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/phonet/sysctl.c:17:
   In file included from include/net/sock.h:38:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/phonet/sysctl.c:17:
   In file included from include/net/sock.h:38:
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
>> net/phonet/sysctl.c:24:8: error: field designator 'seqcount' does not refer to any field in type 'seqcount_t' (aka 'struct seqcount')
   static DEFINE_SEQLOCK(local_port_range_lock);
          ^
   include/linux/seqlock.h:907:18: note: expanded from macro 'DEFINE_SEQLOCK'
                   seqlock_t sl = __SEQLOCK_UNLOCKED(sl)
                                  ^
   include/linux/seqlock.h:888:15: note: expanded from macro '__SEQLOCK_UNLOCKED'
                   .seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
                               ^
   include/linux/seqlock.h:358:42: note: expanded from macro 'SEQCNT_SPINLOCK_ZERO'
   #define SEQCNT_SPINLOCK_ZERO(name, lock)        SEQCOUNT_LOCKNAME_ZERO(name, lock)
                                                   ^
   include/linux/seqlock.h:353:15: note: expanded from macro 'SEQCOUNT_LOCKNAME_ZERO'
           .seqcount               = SEQCNT_ZERO(seq_name.seqcount),       \
                                     ^
   include/linux/seqlock.h:141:30: note: expanded from macro 'SEQCNT_ZERO'
   #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
                                ^
   7 warnings and 1 error generated.


vim +24 net/phonet/sysctl.c

87ab4e20b445c6d Remi Denis-Courmont 2008-09-22  23  
87ab4e20b445c6d Remi Denis-Courmont 2008-09-22 @24  static DEFINE_SEQLOCK(local_port_range_lock);
87ab4e20b445c6d Remi Denis-Courmont 2008-09-22  25  static int local_port_range_min[2] = {0, 0};
87ab4e20b445c6d Remi Denis-Courmont 2008-09-22  26  static int local_port_range_max[2] = {1023, 1023};
87ab4e20b445c6d Remi Denis-Courmont 2008-09-22  27  static int local_port_range[2] = {DYNAMIC_PORT_MIN, DYNAMIC_PORT_MAX};
87ab4e20b445c6d Remi Denis-Courmont 2008-09-22  28  static struct ctl_table_header *phonet_table_hrd;
87ab4e20b445c6d Remi Denis-Courmont 2008-09-22  29  

:::::: The code at line 24 was first introduced by commit
:::::: 87ab4e20b445c6d2d2727ab4f96fa17f7259511e Phonet: proc interface for port range

:::::: TO: Remi Denis-Courmont <remi.denis-courmont@nokia.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
