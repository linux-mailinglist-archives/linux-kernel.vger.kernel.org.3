Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85D6530068
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 05:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiEVDcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 23:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiEVDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 23:32:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F020BE0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653190321; x=1684726321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sh2zeBTKC5/YRBsSek+vwiZ0w8ej3J5CM3Wqohlb8ZU=;
  b=T8k0m6+dym9iL2Kd8UKTfpCvmcZL3C6Ti+Y41FHDQ7RFcAJj4lb5MGhx
   hG7bIAd29GR9IMRV9bGkm/R564NuLybxemhFy/LkMiMjf0wiRqWQfhNUs
   2I6kUJAKrAKAKFiSNiDEZNb6zC/4fTZME8wW4q8Uds9zBqofEWEN/i7lO
   K+d6rUTqpOFSTYBkLV5jPiXDarEQHw/d4xfLy8V4CNXBwhNLZQ0mplu0v
   GluzW1K67KB0MicFuXFgBcO6Vo5hYUy3VuesgxQ6YLQY0N/eSqaPrk6Zp
   7Ob9Y5wI2a5qqH6eOjrAOtIw4YbZgVc4aSZR4lHHUL2o7HU2/2X4KOef8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="252819877"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="252819877"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 20:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="819208798"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 May 2022 20:31:59 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nscJy-0006t6-VE;
        Sun, 22 May 2022 03:31:58 +0000
Date:   Sun, 22 May 2022 11:31:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/16]
 drivers/infiniband/sw/siw/siw_qp_tx.c:32:23: warning: incompatible integer
 to pointer conversion passing 'dma_addr_t' (aka 'unsigned int') to parameter
 of type 'const void *'
Message-ID: <202205221113.qnlaLJKi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   b9b1d325d83c15b2e27bfa8635f99a7d20811457
commit: 16d1427dc6f44107571afbf96254956716c9ad1f [8/16] ARM: Compile the kernel into VMALLOC
config: arm-randconfig-c002-20220522 (https://download.01.org/0day-ci/archive/20220522/202205221113.qnlaLJKi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1443dbaba6f0e57be066995db9164f89fb57b413)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=16d1427dc6f44107571afbf96254956716c9ad1f
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 16d1427dc6f44107571afbf96254956716c9ad1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/siw/siw_qp_tx.c:32:23: warning: incompatible integer to pointer conversion passing 'dma_addr_t' (aka 'unsigned int') to parameter of type 'const void *' [-Wint-conversion]
                   return virt_to_page(paddr);
                                       ^~~~~
   arch/arm/include/asm/memory.h:442:53: note: expanded from macro 'virt_to_page'
   #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
                                                           ^~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
   #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                                ^~~
   arch/arm/include/asm/memory.h:323:53: note: passing argument to parameter 'p' here
   static inline unsigned long virt_to_pfn(const void *p)
                                                       ^
>> drivers/infiniband/sw/siw/siw_qp_tx.c:538:36: warning: incompatible integer to pointer conversion passing 'unsigned long long' to parameter of type 'const void *' [-Wint-conversion]
                                   page_array[seg] = virt_to_page(va & PAGE_MASK);
                                                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   arch/arm/include/asm/memory.h:442:53: note: expanded from macro 'virt_to_page'
   #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
                                   ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
   #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                                ^~~
   arch/arm/include/asm/memory.h:323:53: note: passing argument to parameter 'p' here
   static inline unsigned long virt_to_pfn(const void *p)
                                                       ^
   2 warnings generated.


vim +32 drivers/infiniband/sw/siw/siw_qp_tx.c

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
