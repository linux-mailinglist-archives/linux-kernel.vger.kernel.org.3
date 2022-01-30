Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701E04A3542
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354451AbiA3Iyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:54:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:10225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354402AbiA3Iya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643532869; x=1675068869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q0NDDtBiEM8z5ti1owuk2Dmv4VzlaMxUi93mnwNgEs4=;
  b=jUG8svwCgAeKKPzgUmyRLJqT9NQ3lwvyM4MRLTXhxnGepdHNlhN9sxga
   17c/5MQSV1zXzs1W3T+8kNhgnjkSklcb+bDXkYgj9nEjqFQXVu6IUKziX
   ggYJk+uaWtkSovXllnafQ9Nfb/jYNhmYOQeafAf9b6lyCiRJgdKIaUH+y
   CefLas1DatKfCnUoKXl9ihVtW1ZzV57TFg0LuVhMWqEdKGYd2ZurwRkSF
   emXQqTzRnpgivBKq3m2ku+rMaBGhXCMzqn1ayA3tMjXEXtNFbz+fIHOQv
   HOY6/SbCUTXZqT5BBA4SsLyULbE+Os9Kig0yJjrGPJ9EakTkGQocX6Jto
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="310640866"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="310640866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 00:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="675472668"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2022 00:54:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE5yc-000QHW-6Z; Sun, 30 Jan 2022 08:54:26 +0000
Date:   Sun, 30 Jan 2022 16:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/s390/lib/spinlock.c:78:3: error: expected absolute expression
Message-ID: <202201301448.qXX8mRNr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8c7e4ede46fe63ff10000669652648aab09d112
commit: 69d0db01e210e07fe915e5da91b54a867cda040f ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
date:   10 days ago
config: s390-randconfig-c005-20220130 (https://download.01.org/0day-ci/archive/20220130/202201301448.qXX8mRNr-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69d0db01e210e07fe915e5da91b54a867cda040f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 69d0db01e210e07fe915e5da91b54a867cda040f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/lib/spinlock.c:17:
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
   In file included from arch/s390/lib/spinlock.c:17:
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
   In file included from arch/s390/lib/spinlock.c:17:
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
>> arch/s390/lib/spinlock.c:78:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:5:5: note: instantiated into assembly here
   .if 6651b-6641b > 254
       ^
>> arch/s390/lib/spinlock.c:78:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:6:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
>> arch/s390/lib/spinlock.c:78:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:66:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if (" len ") %% 2\n"                                          \
            ^
   <inline asm>:8:5: note: instantiated into assembly here
   .if (6651b-6641b) % 2
       ^
>> arch/s390/lib/spinlock.c:78:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:67:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives instructions length is odd\"\n"    \
            ^
   <inline asm>:9:2: note: instantiated into assembly here
           .error "cpu alternatives instructions length is odd"
           ^
>> arch/s390/lib/spinlock.c:78:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:83:2: note: expanded from macro 'OLDINSTR'
           OLDINSTR_PADDING(oldinstr, num)                                 \
           ^
   arch/s390/include/asm/alternative.h:71:3: note: expanded from macro 'OLDINSTR_PADDING'
           ".if " oldinstr_pad_len(num) " > 6\n"                           \
            ^
   <inline asm>:15:5: note: instantiated into assembly here
   .if -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) > 6
       ^
>> arch/s390/lib/spinlock.c:78:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:85:2: note: expanded from macro 'OLDINSTR'
           INSTR_LEN_SANITY_CHECK(oldinstr_len)
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:25:5: note: instantiated into assembly here
   .if 662b-661b > 254
       ^
>> arch/s390/lib/spinlock.c:78:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:85:2: note: expanded from macro 'OLDINSTR'
           INSTR_LEN_SANITY_CHECK(oldinstr_len)
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:26:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
>> arch/s390/lib/spinlock.c:78:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:85:2: note: expanded from macro 'OLDINSTR'
           INSTR_LEN_SANITY_CHECK(oldinstr_len)
           ^
   arch/s390/include/asm/alternative.h:66:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if (" len ") %% 2\n"                                          \
            ^
   <inline asm>:28:5: note: instantiated into assembly here
   .if (662b-661b) % 2
       ^
>> arch/s390/lib/spinlock.c:78:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0040", 49) /* NIAI 4 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:85:2: note: expanded from macro 'OLDINSTR'
           INSTR_LEN_SANITY_CHECK(oldinstr_len)
           ^
   arch/s390/include/asm/alternative.h:67:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives instructions length is odd\"\n"    \
            ^
   <inline asm>:29:2: note: instantiated into assembly here
           .error "cpu alternatives instructions length is odd"
           ^
   arch/s390/lib/spinlock.c:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0080", 49) /* NIAI 8 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:5:5: note: instantiated into assembly here
   .if 6651b-6641b > 254
       ^
   arch/s390/lib/spinlock.c:89:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0080", 49) /* NIAI 8 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:6:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   arch/s390/lib/spinlock.c:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0080", 49) /* NIAI 8 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:66:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if (" len ") %% 2\n"                                          \
            ^
   <inline asm>:8:5: note: instantiated into assembly here
   .if (6651b-6641b) % 2
       ^
   arch/s390/lib/spinlock.c:89:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0080", 49) /* NIAI 8 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:67:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives instructions length is odd\"\n"    \
            ^
   <inline asm>:9:2: note: instantiated into assembly here
           .error "cpu alternatives instructions length is odd"
           ^
   arch/s390/lib/spinlock.c:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0080", 49) /* NIAI 8 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:83:2: note: expanded from macro 'OLDINSTR'
           OLDINSTR_PADDING(oldinstr, num)                                 \
           ^
   arch/s390/include/asm/alternative.h:71:3: note: expanded from macro 'OLDINSTR_PADDING'
           ".if " oldinstr_pad_len(num) " > 6\n"                           \
            ^
   <inline asm>:15:5: note: instantiated into assembly here
   .if -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) > 6
       ^
   arch/s390/lib/spinlock.c:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0080", 49) /* NIAI 8 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:85:2: note: expanded from macro 'OLDINSTR'
           INSTR_LEN_SANITY_CHECK(oldinstr_len)
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \


vim +78 arch/s390/lib/spinlock.c

b96f7d881ad942 Martin Schwidefsky 2017-03-24  72  
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  73  static inline int arch_load_niai4(int *lock)
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  74  {
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  75  	int owner;
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  76  
cceb018377a123 Heiko Carstens     2019-10-18  77  	asm_inline volatile(
f554be42fd0fd8 Vasily Gorbik      2017-10-12 @78  		ALTERNATIVE("", ".long 0xb2fa0040", 49)	/* NIAI 4 */
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  79  		"	l	%0,%1\n"
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  80  		: "=d" (owner) : "Q" (*lock) : "memory");
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  81  	return owner;
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  82  }
7f7e6e28cd3285 Martin Schwidefsky 2017-04-19  83  

:::::: The code at line 78 was first introduced by commit
:::::: f554be42fd0fd8dd14680c67f2db26b3e7de9670 s390/spinlock: use cpu alternatives to enable niai instruction

:::::: TO: Vasily Gorbik <gor@linux.vnet.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
