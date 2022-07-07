Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C947F56990C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiGGEQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 00:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiGGEQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:16:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82C2CE1A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 21:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657167384; x=1688703384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CtWjuZT3SSCYZZQhRDjTavW5xEhKMj6AxF5M3EL5lB4=;
  b=BX3pZdBizsLhVtnoqsdqlDRSqtK/at4il13dQYlfiAsDCWg6cF03N+7O
   9/UHlTeaXF1ANx0yRC+Aw1HM+cqdlk+V7sO2jo6WmN0wSIAzEqr1WkMbC
   WqosRmHpnOTCphjAtAmEPSQ8tkrqsJSVtBIp2dJ7j/MuVFQyizIk3DPpm
   dJqmAJ2B9vUnvkyAtCTPYY5dp6RgbvckjxYUIu/uZV4OLHUg9H89C+0ET
   ss+n3VlhcVOtcDdqs5TkuDlybzG8BrT1eiRgqEtMx/TzS9h0RRgZO2peQ
   rGq1ylnWb/NfZWpfEK9kT/U6fj9pTZjQ4eC/BRIf3V2Yrpm63A+HWK44O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281473574"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="281473574"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 21:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="543664651"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 21:16:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Iw9-000LWL-05;
        Thu, 07 Jul 2022 04:16:21 +0000
Date:   Thu, 7 Jul 2022 12:15:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v8 5/21]
 kernel/dma/direct.c:467:7: error: call to undeclared function
 'sg_is_dma_bus_address'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202207071200.km0YZBTu-lkp@intel.com>
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

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v8
head:   a2dd359c3f1baca6c0438adec8900b7fe57f92af
commit: 8d3e7a5dd204152609cd4eee448224f071493784 [5/21] dma-direct: support PCI P2PDMA pages in dma-direct map_sg
config: s390-randconfig-r044-20220706 (https://download.01.org/0day-ci/archive/20220707/202207071200.km0YZBTu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/sbates130272/linux-p2pmem/commit/8d3e7a5dd204152609cd4eee448224f071493784
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v8
        git checkout 8d3e7a5dd204152609cd4eee448224f071493784
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
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
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
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
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
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
>> kernel/dma/direct.c:467:7: error: call to undeclared function 'sg_is_dma_bus_address'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (sg_is_dma_bus_address(sg))
                       ^
>> kernel/dma/direct.c:468:4: error: call to undeclared function 'sg_dma_unmark_bus_address'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           sg_dma_unmark_bus_address(sg);
                           ^
   12 warnings and 2 errors generated.


vim +/sg_is_dma_bus_address +467 kernel/dma/direct.c

   455	
   456	/*
   457	 * Unmaps segments, except for ones marked as pci_p2pdma which do not
   458	 * require any further action as they contain a bus address.
   459	 */
   460	void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
   461			int nents, enum dma_data_direction dir, unsigned long attrs)
   462	{
   463		struct scatterlist *sg;
   464		int i;
   465	
   466		for_each_sg(sgl,  sg, nents, i) {
 > 467			if (sg_is_dma_bus_address(sg))
 > 468				sg_dma_unmark_bus_address(sg);
   469			else
   470				dma_direct_unmap_page(dev, sg->dma_address,
   471						      sg_dma_len(sg), dir, attrs);
   472		}
   473	}
   474	#endif
   475	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
