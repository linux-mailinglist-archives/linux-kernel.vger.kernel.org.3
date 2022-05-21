Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEBB52FC13
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244958AbiEULh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbiEULhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:37:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29D4B1DB
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653133059; x=1684669059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=StyTawR6ebpv/qFh9L5sVHJBQh7Ewr1uQvGAF/aS5UI=;
  b=dwvjbhAidtx0mPd4on5e6bqynaPFI03Ok9yo9Bly9AYIPaIkqVKQIaSI
   Lxt/qkbnqvkQQM5EDGUwTCtJqXGYVneQ4tMrULMzCTm9XVBD+PeIMyywh
   nWpy3E6/YZGi9l47zyyJkKO3GUEPfiWJrzRvxyyFReUXtMOluJK+L2ihL
   +uiCKuvXyEXVviueLpHtlYFgskXia4C4O4gjEUbyPPLyG+di0vYI/EDwo
   9lh/87BYbEsrMje2JYTlJ6b06wnZfnUvV5QdbeKi1HpPFlfQpqEqZKkvc
   We3Gx1YP597JzS2KzFD6f7J8/lmZJAAT00UQkBUSgJwTOVBWIwa8uE0eb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="271667117"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="271667117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 04:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="743885342"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2022 04:37:38 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsNQP-0006FH-HN;
        Sat, 21 May 2022 11:37:37 +0000
Date:   Sat, 21 May 2022 19:36:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/16]
 drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: warning: passing argument 1 of
 'virt_to_pfn' makes pointer from integer without a cast
Message-ID: <202205211911.kEgr1rzS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   b9b1d325d83c15b2e27bfa8635f99a7d20811457
commit: 16d1427dc6f44107571afbf96254956716c9ad1f [8/16] ARM: Compile the kernel into VMALLOC
config: arm-buildonly-randconfig-r002-20220519 (https://download.01.org/0day-ci/archive/20220521/202205211911.kEgr1rzS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=16d1427dc6f44107571afbf96254956716c9ad1f
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 16d1427dc6f44107571afbf96254956716c9ad1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/memory.h:448,
                    from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/prandom.h:12,
                    from include/linux/random.h:120,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_get_pblpage':
>> drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
      32 |                 return virt_to_page(paddr);
         |                                     ^~~~~
         |                                     |
         |                                     dma_addr_t {aka unsigned int}
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   drivers/infiniband/sw/siw/siw_qp_tx.c:32:24: note: in expansion of macro 'virt_to_page'
      32 |                 return virt_to_page(paddr);
         |                        ^~~~~~~~~~~~
   In file included from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/prandom.h:12,
                    from include/linux/random.h:120,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   arch/arm/include/asm/memory.h:323:53: note: expected 'const void *' but argument is of type 'dma_addr_t' {aka 'unsigned int'}
     323 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^
   In file included from arch/arm/include/asm/memory.h:448,
                    from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/prandom.h:12,
                    from include/linux/random.h:120,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
   drivers/infiniband/sw/siw/siw_qp_tx.c:538:67: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     538 |                                 page_array[seg] = virt_to_page(va & PAGE_MASK);
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   drivers/infiniband/sw/siw/siw_qp_tx.c:538:51: note: in expansion of macro 'virt_to_page'
     538 |                                 page_array[seg] = virt_to_page(va & PAGE_MASK);
         |                                                   ^~~~~~~~~~~~
   In file included from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/prandom.h:12,
                    from include/linux/random.h:120,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   arch/arm/include/asm/memory.h:323:53: note: expected 'const void *' but argument is of type 'u64' {aka 'long long unsigned int'}
     323 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^


vim +/virt_to_pfn +32 drivers/infiniband/sw/siw/siw_qp_tx.c

b9be6f18cf9ed0 Bernard Metzler 2019-06-20   5  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20   6  #include <linux/errno.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20   7  #include <linux/types.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  @8  #include <linux/net.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20   9  #include <linux/scatterlist.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  10  #include <linux/highmem.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  11  #include <net/tcp.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  12  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  13  #include <rdma/iw_cm.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  14  #include <rdma/ib_verbs.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  15  #include <rdma/ib_user_verbs.h>
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  16  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  17  #include "siw.h"
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  18  #include "siw_verbs.h"
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  19  #include "siw_mem.h"
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  20  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  21  #define MAX_HDR_INLINE					\
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  22  	(((uint32_t)(sizeof(struct siw_rreq_pkt) -	\
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  23  		     sizeof(struct iwarp_send))) & 0xF8)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  24  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  25  static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  26  {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  27  	struct siw_pbl *pbl = mem->pbl;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  28  	u64 offset = addr - mem->va;
c536277e0db1ad Bernard Metzler 2019-08-22  29  	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  30  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  31  	if (paddr)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20 @32  		return virt_to_page(paddr);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  33  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  34  	return NULL;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  35  }
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  36  

:::::: The code at line 32 was first introduced by commit
:::::: b9be6f18cf9ed04dd8087cb9d69de6e90d8ceb08 rdma/siw: transmit path

:::::: TO: Bernard Metzler <bmt@zurich.ibm.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
