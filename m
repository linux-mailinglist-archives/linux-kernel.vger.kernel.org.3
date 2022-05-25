Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B77F5334A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiEYBUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiEYBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:20:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498026B025
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653441629; x=1684977629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pF91zDSA8U1Uv7fAAqztF2F+UfMaJyxJ7uuw78shyaI=;
  b=IDvktJT+Rpf/oGb2q+81fZtJ6rj8qLoLZyUD0jcrW558XFxycOXD0SU2
   98SOAH5b/xhvr9hvVxpJcA/J37wUTl0ZZA5U82fHWSWsInFHOM3WvMSis
   oYQqFJgMKOwwaghnUfp41Eu2GT32F8iz7pEr3hHka8615Hoqv1j6nDXF7
   5iXK71X9sBM3/5mliHltTEUBXUILe+UloeKntqzQ89JZWQCn/51l73ovu
   1UfhZz6JO/51kuJrtc01WBdOSoRfnKJcBTwpLhKQMTf6apLui1UwF5c4a
   /7dV5Oemg3kfjxak1rpOXSeDQUOaQtcpuYbRBF2s+cZqzLNX4tufXNmg+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273799820"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273799820"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="664199047"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 18:20:27 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntfhK-0002bS-J9;
        Wed, 25 May 2022 01:20:26 +0000
Date:   Wed, 25 May 2022 09:19:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/io_uring-5.19 6/6]
 fs/io_uring.c:6775:1: error: redefinition of 'io_shutdown'
Message-ID: <202205250952.fOrdanvO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/io_uring-5.19
head:   18f8e4c9acdb48c78db9a29d079a8e8248f7171d
commit: 18f8e4c9acdb48c78db9a29d079a8e8248f7171d [6/6] io_uring: move shutdown under the general net section
config: s390-randconfig-r035-20220524 (https://download.01.org/0day-ci/archive/20220525/202205250952.fOrdanvO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/18f8e4c9acdb48c78db9a29d079a8e8248f7171d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/io_uring-5.19
        git checkout 18f8e4c9acdb48c78db9a29d079a8e8248f7171d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/io_uring.c:60:
   In file included from include/linux/blk-mq.h:8:
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
   In file included from fs/io_uring.c:60:
   In file included from include/linux/blk-mq.h:8:
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
   In file included from fs/io_uring.c:60:
   In file included from include/linux/blk-mq.h:8:
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
>> fs/io_uring.c:6775:1: error: redefinition of 'io_shutdown'
   IO_NETOP_FN(shutdown);
   ^
   fs/io_uring.c:6748:12: note: expanded from macro 'IO_NETOP_FN'
   static int io_##op(struct io_kiocb *req, unsigned int issue_flags)      \
              ^
   <scratch space>:183:1: note: expanded from here
   io_shutdown
   ^
   fs/io_uring.c:6772:1: note: previous definition is here
   IO_NETOP_PREP(shutdown);
   ^
   fs/io_uring.c:6753:32: note: expanded from macro 'IO_NETOP_PREP'
   #define IO_NETOP_PREP(op)                                               \
                                                                           ^
   fs/io_uring.c:6748:12: note: expanded from macro '\
   IO_NETOP_FN'
   static int io_##op(struct io_kiocb *req, unsigned int issue_flags)      \
              ^
   <scratch space>:178:1: note: expanded from here
   io_shutdown
   ^
   12 warnings and 1 error generated.


vim +/io_shutdown +6775 fs/io_uring.c

  6766	
  6767	IO_NETOP_PREP_ASYNC(sendmsg);
  6768	IO_NETOP_PREP_ASYNC(recvmsg);
  6769	IO_NETOP_PREP_ASYNC(connect);
  6770	IO_NETOP_PREP(accept);
  6771	IO_NETOP_PREP(socket);
  6772	IO_NETOP_PREP(shutdown);
  6773	IO_NETOP_FN(send);
  6774	IO_NETOP_FN(recv);
> 6775	IO_NETOP_FN(shutdown);
  6776	#endif /* CONFIG_NET */
  6777	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
