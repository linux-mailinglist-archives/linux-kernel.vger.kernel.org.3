Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFC4D2786
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiCIBUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiCIBUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:20:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044A1409F9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646788465; x=1678324465;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oE02vI4yneAw15d53fN+S9tmER+pyOaZpag7Z2NIsfk=;
  b=PbfDpeO/KhFym1Kf293DvFgKFUrFuLzJgQHFQ+weubQFGcTgRCmtyKyn
   eZBe99nin94p27zZ0WmoZDJBxqsiC+05YthsDjieZvbcHNqgnUNwfhsgN
   btOeNXlbt35QVyuCYD+cjbFWd96YN2OKGoyQcB2C4uUWAeqV+YJ0gGdNp
   SftnubO+0ySDwrNVCGL0YyYZxSVtQWLS+xsYROGF982xwjVyZEV+i3fh6
   CReP1IOCgBhFuejUrYZPXjIXJN8y8GkALXIVub5RsXauq/Thm8i7p9w/N
   wOA6uoIlQbbHPIMbhvfpxarjUEcPgywX7ph4In2Z75zJ9NRz8PQUgyRTR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341286923"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="341286923"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="711754590"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 17:12:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRksf-0002IZ-19; Wed, 09 Mar 2022 01:12:45 +0000
Date:   Wed, 9 Mar 2022 09:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Mark <lmark@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        Patrick Daly <pdaly@codeaurora.org>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 552/9999] arch/xtensa/kernel/pci-dma.c:205:17: error: too few arguments to
 function 'dma_common_free_remap'
Message-ID: <202203090909.9xSg55aP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   3fba6c6e70994eff4dcc5be475c9d2bd3848b83d
commit: 9257548d3c05e6fe98399729a796a23d801e027e [552/9999] ANDROID: GKI: dma-mapping: Add dma_remap functions
config: xtensa-buildonly-randconfig-r001-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090909.9xSg55aP-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9257548d3c05e6fe98399729a796a23d801e027e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 9257548d3c05e6fe98399729a796a23d801e027e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/ioport.h:13,
                    from include/linux/device.h:15,
                    from include/linux/dma-contiguous.h:56,
                    from arch/xtensa/kernel/pci-dma.c:18:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
         |                ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dma-mapping.h:339:9: note: in expansion of macro 'BUG_ON'
     339 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
         |         ^~~~~~
   include/linux/dma-mapping.h:339:16: note: in expansion of macro 'pfn_valid'
     339 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
         |                ^~~~~~~~~
   arch/xtensa/kernel/pci-dma.c: In function 'arch_dma_free':
>> arch/xtensa/kernel/pci-dma.c:205:17: error: too few arguments to function 'dma_common_free_remap'
     205 |                 dma_common_free_remap(vaddr, size, VM_MAP);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/dma-noncoherent.h:5,
                    from arch/xtensa/kernel/pci-dma.c:19:
   include/linux/dma-mapping.h:467:6: note: declared here
     467 | void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags,
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/dma_common_free_remap +205 arch/xtensa/kernel/pci-dma.c

5a0015d62668e64 Chris Zankel        2005-06-23  192  
3f2bbf443e21584 Christoph Hellwig   2018-06-19  193  void arch_dma_free(struct device *dev, size_t size, void *vaddr,
00085f1efa387a8 Krzysztof Kozlowski 2016-08-03  194  		dma_addr_t dma_handle, unsigned long attrs)
5a0015d62668e64 Chris Zankel        2005-06-23  195  {
9d2ffe5c62554f2 Max Filippov        2016-04-25  196  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
6137e4166004e2e Max Filippov        2018-02-14  197  	struct page *page;
6137e4166004e2e Max Filippov        2018-02-14  198  
adbfa4e6f996895 Max Filippov        2018-02-14  199  	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
adbfa4e6f996895 Max Filippov        2018-02-14  200  		page = vaddr;
2cc15e802b250a1 Max Filippov        2018-07-11  201  	} else if (platform_vaddr_uncached(vaddr)) {
2cc15e802b250a1 Max Filippov        2018-07-11  202  		page = virt_to_page(platform_vaddr_to_cached(vaddr));
6137e4166004e2e Max Filippov        2018-02-14  203  	} else {
6137e4166004e2e Max Filippov        2018-02-14  204  #ifdef CONFIG_MMU
6137e4166004e2e Max Filippov        2018-02-14 @205  		dma_common_free_remap(vaddr, size, VM_MAP);

:::::: The code at line 205 was first introduced by commit
:::::: 6137e4166004e2ec383ac05d5ca15831f4668806 xtensa: support DMA buffers in high memory

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Max Filippov <jcmvbkbc@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
