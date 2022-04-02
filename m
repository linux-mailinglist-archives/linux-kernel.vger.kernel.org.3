Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150F94F061B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbiDBUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351863AbiDBUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:18:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C371652C9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648930566; x=1680466566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ib7WTqsW5hmbR83QY71o0sMyTEz8J1m9kJbfAmng+o0=;
  b=ikng/XlcKEB5V5xHK+JIVq/JGkKPHudPa00iBChyzqdyD2Uild21tSs/
   40gEjV3uQA8SyF8jDH11Y/D1Hbv6PMdGSPrXPDm4PupMraLZ69R04G8Cc
   54Tl/b+fD9jrnHGeNatlt4UBvhOUwuU0R6dep633C4OIgU4MmLjnsOo06
   BxjgzduOByGOgyKwpMI94XMBVZIvlCisMo3VXPcnHppfqWBY6UQseryvQ
   jLVBmguePYbsFyhnTZUwAWUCf7UmxdqoZtmCdeLJhFokhEbRvxmO6KmkY
   3Cn8rWSF69frFXgJoZOJsB7zBPyKaDN5yo10N+8Dy428SKMJtihXOBF+2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="260514528"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="260514528"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 13:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="523154473"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2022 13:16:03 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nakAF-0000ON-3Q;
        Sat, 02 Apr 2022 20:16:03 +0000
Date:   Sun, 3 Apr 2022 04:15:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: <inline asm>:18:8: error: unexpected token in '.rept' directive
Message-ID: <202204030434.f5uEqs4t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6f34f8c3d6178527d4c02aa3a53c370cc70cb91e
commit: 4afeb670710efa5cd5ed8b1d9f2d22d6ce332bcc s390/alternatives: use instructions instead of byte patterns
date:   6 days ago
config: s390-randconfig-r044-20220403 (https://download.01.org/0day-ci/archive/20220403/202204030434.f5uEqs4t-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4afeb670710efa5cd5ed8b1d9f2d22d6ce332bcc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4afeb670710efa5cd5ed8b1d9f2d22d6ce332bcc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/message/fusion/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/message/fusion/mptctl.c:54:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/message/fusion/mptctl.c:54:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/message/fusion/mptctl.c:54:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
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
   drivers/message/fusion/mptctl.c:2337:8: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
           int                     retval;
                                   ^
   drivers/message/fusion/mptctl.c:2887:6: warning: variable 'where' set but not used [-Wunused-but-set-variable]
           int where = 1;
               ^
   <inline asm>:5:5: error: expected absolute expression
   .if 6651b-6641b > 254
       ^
   <inline asm>:6:2: error: cpu alternatives does not support instructions blocks > 254 bytes
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   <inline asm>:8:5: error: expected absolute expression
   .if (6651b-6641b) % 2
       ^
   <inline asm>:9:2: error: cpu alternatives instructions length is odd
           .error "cpu alternatives instructions length is odd"
           ^
   <inline asm>:15:5: error: expected absolute expression
   .if -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) > 6
       ^
>> <inline asm>:18:8: error: unexpected token in '.rept' directive
           .rept (-(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) - (6620b-662b)) / 2
                 ^
   <inline asm>:21:8: error: unexpected token in '.rept' directive
           .rept -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) / 6
                 ^
>> <inline asm>:22:2: error: unknown directive
           .jgnop .
           ^
>> <inline asm>:23:7: error: unmatched '.endr' directive
           .endr
                ^
   <inline asm>:24:8: error: unexpected token in '.rept' directive
           .rept -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) % 6 / 4
                 ^
   <inline asm>:26:7: error: unmatched '.endr' directive
           .endr
                ^
   <inline asm>:27:8: error: unexpected token in '.rept' directive
           .rept -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) % 6 % 4 / 2
                 ^
   <inline asm>:29:6: error: unmatched '.endr' directive
   .endr
        ^
   <inline asm>:32:5: error: expected absolute expression
   .if 662b-661b > 254
       ^
   <inline asm>:33:2: error: cpu alternatives does not support instructions blocks > 254 bytes
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   <inline asm>:35:5: error: expected absolute expression
   .if (662b-661b) % 2
       ^
   <inline asm>:36:2: error: cpu alternatives instructions length is odd
           .error "cpu alternatives instructions length is odd"
           ^
   <inline asm>:5:5: error: expected absolute expression
   .if 6651b-6641b > 254
       ^
   <inline asm>:6:2: error: cpu alternatives does not support instructions blocks > 254 bytes
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   14 warnings and 20 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
