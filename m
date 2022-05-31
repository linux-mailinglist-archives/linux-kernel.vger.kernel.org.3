Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE753953B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbiEaRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346391AbiEaRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:07:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD17719D1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654016842; x=1685552842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ss8C3wT5Ka+COPPXfUaUW6AkO/fa82NeiHAzBT3fkbs=;
  b=gGKMnHoE43kV981554FA5uF61RgW6ycbKLI3OF3A4l/+sJxgZhknaQRy
   +9wRfVyn7eJDRwyOUjwCb91v/Go5Qx+tA98rfOqXpNcTP8ZU1Dc6+tiuo
   bcM/EqK72O9KeWPqeG2eOSshRGPuKo65N04kHqh5nKkg7wJRxLR1uA5i9
   WtvAXTF2lk4BC3QPartwwxv6aQYOxSRGOLz0Y5tbQMfnap5Kg/RfsH/tP
   6L37o1ywfuXYY8vUogSn3xwx8PQF3rriqFir+IoaLiL/Z+EbmPOuFDVXu
   hGqpHrZMppLnBiw0N7B48EI+UwVJhGM6qRdGSg5iOdVwdSJIMwF/yaGNk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275407030"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275407030"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="667011393"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 10:07:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw5Kw-0002uG-Tu;
        Tue, 31 May 2022 17:07:18 +0000
Date:   Wed, 1 Jun 2022 01:07:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [stable:linux-5.15.y 5773/6856] <instantiation>:3:19: error: too
 many positional arguments
Message-ID: <202206010058.CoFfIpvt-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   4e67be407725b1d8b829ed2075987037abec98ec
commit: 33db9912ff7c491f839c89a08e98f755aa09598f [5773/6856] ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
config: s390-randconfig-r026-20220530 (https://download.01.org/0day-ci/archive/20220601/202206010058.CoFfIpvt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=33db9912ff7c491f839c89a08e98f755aa09598f
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout 33db9912ff7c491f839c89a08e98f755aa09598f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/raid6/s390vx8.c:14:
   In file included from include/linux/raid/pq.h:15:
   In file included from include/linux/blkdev.h:23:
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
   In file included from lib/raid6/s390vx8.c:14:
   In file included from include/linux/raid/pq.h:15:
   In file included from include/linux/blkdev.h:23:
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
   In file included from lib/raid6/s390vx8.c:14:
   In file included from include/linux/raid/pq.h:15:
   In file included from include/linux/blkdev.h:23:
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
>> <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 0,7,0,1
           ^
>> <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 8,15,0,1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 0,7,0,%r1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
>> <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 16,23,0,1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
>> <instantiation>:3:19: error: too many positional arguments
           GR_NUM  b2, 1       /* Base register */
                               ^
   lib/raid6/s390vx8.c:73:16: note: while in macro instantiation
           asm volatile ("VSTM %2,%3,0,1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VSTM 16,23,0,1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 0,7,0,%r1
           ^
   <instantiation>:3:21: error: too many positional arguments
           GR_NUM  b2, %r1     /* Base register */
                               ^
   lib/raid6/s390vx8.c:63:16: note: while in macro instantiation
           asm volatile ("VLM %2,%3,0,%1"
                         ^
   <inline asm>:1:2: note: instantiated into assembly here
           VLM 16,23,0,%r1
           ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
>> <instantiation>:5:8: error: expected relocatable expression
           .word   (b2 << 12) | (0)
                   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   12 warnings and 20 errors generated.
--
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
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
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: invalid number of bytes
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:83:2: note: expanded from macro 'OLDINSTR'
           OLDINSTR_PADDING(oldinstr, num)                                 \
           ^
   arch/s390/include/asm/alternative.h:74:3: note: expanded from macro 'OLDINSTR_PADDING'
           "\t.fill (" oldinstr_pad_len(num) " - (6620b-662b)) / 2, 2, 0x0700\n" \
            ^
   <inline asm>:18:8: note: instantiated into assembly here
           .fill (-(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) - (6620b-662b)) / 2, 2, 0x0700
                 ^
   In file included from kernel/trace/trace_clock.c:16:
   In file included from include/linux/spinlock.h:94:
>> arch/s390/include/asm/spinlock.h:89:3: error: invalid number of bytes
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:83:2: note: expanded from macro 'OLDINSTR'
           OLDINSTR_PADDING(oldinstr, num)                                 \
           ^
   arch/s390/include/asm/alternative.h:74:3: note: expanded from macro 'OLDINSTR_PADDING'
           "\t.fill (" oldinstr_pad_len(num) " - (6620b-662b)) / 2, 2, 0x0700\n" \
            ^
   <inline asm>:18:8: note: instantiated into assembly here
           .fill (-(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) - (6620b-662b)) / 2, 2, 0x0700
                 ^
   11 errors generated.
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
