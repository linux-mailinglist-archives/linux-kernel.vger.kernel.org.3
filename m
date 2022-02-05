Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD23B4AA543
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378858AbiBEBRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:17:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:26193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378852AbiBEBRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644023831; x=1675559831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uHn93oKNgTpPSTexIzqu/Jqpy30iL5ZfSMF1VUbeB1Y=;
  b=FnRSkfMGCd496MltnEHMn2A5tCW3pn+Ah5iN6yg+10iujL4DCAyHrub7
   WlwGM2nGYbq6fAWZTRXkYQcL/2Tt4w7oC6bdSJUlMckMlCthGd8kwPyvJ
   jCpothEHFafJkZ3wMhGSsC1givAJ23dX3ABslVcnl3vR16vfym2kA0B3V
   8oUoNS3+fc+DDcBmEflGaZQJ7zVU1EdfsSiVpzx8P9xspFMGHnbHfa7XF
   3PF17TjqCslElogxjRwCSRzD4Dayb0UH9AQF/7dfb7+5tqt0CJ6xAAd8E
   GrAC0RVLGSCQPgstCcwSnI1rs/OIO8r0H/t3GRfF3PsXaO/E5HXsiB40i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248685450"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248685450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="539373447"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2022 17:17:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG9hI-000YPj-1n; Sat, 05 Feb 2022 01:17:04 +0000
Date:   Sat, 5 Feb 2022 09:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: [oracle-dtrace:v2/5.17-rc2 6/10] kernel/kallsyms.c:775:3: error:
 expected expression
Message-ID: <202202050909.66P7tRUv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/oracle/dtrace-linux-kernel v2/5.17-rc2
head:   47946e7b2e2319f39cbb7f8aaa294298c2dec5b4
commit: ea16e4ce65d8342913051086a89eac87dc54aced [6/10] kallsyms: add /proc/kallmodsyms
config: s390-randconfig-r032-20220130 (https://download.01.org/0day-ci/archive/20220205/202202050909.66P7tRUv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/oracle/dtrace-linux-kernel/commit/ea16e4ce65d8342913051086a89eac87dc54aced
        git remote add oracle-dtrace https://github.com/oracle/dtrace-linux-kernel
        git fetch --no-tags oracle-dtrace v2/5.17-rc2
        git checkout ea16e4ce65d8342913051086a89eac87dc54aced
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from kernel/kallsyms.c:25:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
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
   In file included from kernel/kallsyms.c:25:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
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
   In file included from kernel/kallsyms.c:25:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
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
   kernel/kallsyms.c:666:12: warning: no previous prototype for function 'arch_get_kallsym' [-Wmissing-prototypes]
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
              ^
   kernel/kallsyms.c:666:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
   ^
   static 
>> kernel/kallsyms.c:775:3: error: expected expression
                   unsigned long mod_idx = (unsigned long) -1;
                   ^
>> kernel/kallsyms.c:806:28: warning: comparison between pointer and integer ('unsigned long' and 'char (*)[]') [-Wpointer-integer-compare]
                     if (likely(iter->value != &_etext))
                                ~~~~~~~~~~~ ^  ~~~~~~~
   include/linux/compiler.h:77:40: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                                               ^
   kernel/kallsyms.c:804:17: warning: unused variable 'endstr' [-Wunused-variable]
                     const char *endstr;
                                 ^
   15 warnings and 1 error generated.


vim +775 kernel/kallsyms.c

   755	
   756	/* Returns space to next name. */
   757	static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
   758	{
   759		unsigned off = iter->nameoff;
   760	
   761		iter->exported = 0;
   762		iter->value = kallsyms_sym_address(iter->pos);
   763	
   764		iter->type = kallsyms_get_symbol_type(off);
   765	
   766		iter->module_name[0] = '\0';
   767		iter->builtin_module_names = NULL;
   768	
   769		off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
   770	#ifdef CONFIG_KALLMODSYMS
   771		if (kallmodsyms) {
   772			unsigned long mod_idx = (unsigned long) -1;
   773	
   774			if (kallsyms_module_offsets)
 > 775			unsigned long mod_idx = (unsigned long) -1;
   776	
   777			if (kallsyms_module_offsets)
   778				mod_idx =
   779				  get_builtin_module_idx(iter->value,
   780							 iter->hint_builtin_module_idx);
   781	
   782			/*
   783			 * This is a built-in module iff the tables of built-in modules
   784			 * (address->module name mappings) and module names are known,
   785			 * and if the address was found there, and if the corresponding
   786			 * module index is nonzero, and iff this is a text (or weak)
   787			 * symbol.  All other cases mean off the end of the binary or in
   788			 * a non-modular range in between one or more modules.  (Also
   789			 * guard against a corrupt kallsyms_objfiles array pointing off
   790			 * the end of kallsyms_modules.)
   791			 */
   792			if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
   793			    (iter->type == 't' || iter->type == 'T' ||
   794			     iter->type == 'w' || iter->type == 'W') &&
   795			    mod_idx != (unsigned long) -1 &&
   796			    kallsyms_modules[mod_idx] != 0 &&
   797			    kallsyms_modules[mod_idx] < kallsyms_module_names_len) {
   798			  /*
   799			   * Rule out (rare) section start/end symbols which might
   800			   * overlap the last symbol in .text.  (Will also hit at most
   801			   * one symbol which really is in a built-in module, but only
   802			   * if that symbol is zero-length.)
   803			   */
   804			  const char *endstr;
   805	
 > 806			  if (likely(iter->value != &_etext))
   807			    iter->builtin_module_names =
   808			      &kallsyms_module_names[kallsyms_modules[mod_idx]];
   809			}
   810			iter->hint_builtin_module_idx = mod_idx;
   811		}
   812	#endif
   813		return off - iter->nameoff;
   814	}
   815	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
