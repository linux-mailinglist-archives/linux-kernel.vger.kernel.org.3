Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8608E5A6E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiH3Uhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3Uhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:37:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45297FE71
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661891852; x=1693427852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=47h2zZOD3G4KaB+AcRlr1CpNgYpMBzVEBSjPolnyaow=;
  b=f+C91AIwYoiq2HXYE/oxE01ScLyBP+OgDPJBeTzIYRUf0A0FdlSzTZl8
   Leh1sWtkOUXkPZxRqD5RyFA1VNDIyEOi/TAQ6rZMFtPBk9tDpjjh+wPw+
   Drc7Gwc+yf8j18cDSxWOGDSnvdE3gR3Qk4OoxRxcmORkno+X+MeogVIhQ
   PF+p5vGMFKsVQ/WAyKpua7TBlcSKnfsCZ3Os9fg/Knrb9aPV9IZlTXZMo
   H2zw7ECO7tKCh+qk7x9tiKg+Ceb+J91++aJx5wM9vb5WBEnav/4EkZbhR
   bDVKV44BzYVghH3zYCMsmSop2o1AnQC6Thm0cKqceAS4u+AFcqYm7xVKF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295299299"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="295299299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 13:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="641556069"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 13:37:31 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT7zG-0000aN-1h;
        Tue, 30 Aug 2022 20:37:30 +0000
Date:   Wed, 31 Aug 2022 04:36:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:for-next 5/7] arch/arm/mm/init.c:219: undefined reference
 to `phys_initrd_start'
Message-ID: <202208310435.G07HW3ZF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm for-next
head:   a72b4b3ba681398a3ac1c1384efb949bef3ac846
commit: b35b2736b43d7124e7da6a8050b8fd9e02f9f734 [5/7] ARM: 9230/1: Support initrd with address in boot alias region
config: arm-lubbock_defconfig (https://download.01.org/0day-ci/archive/20220831/202208310435.G07HW3ZF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm for-next
        git checkout b35b2736b43d7124e7da6a8050b8fd9e02f9f734
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
>> arch/arm/mm/init.c:219: undefined reference to `phys_initrd_start'


vim +219 arch/arm/mm/init.c

b35b2736b43d71 Matija Glavinic Pecotic 2022-08-19  197  
3928624812dcfa Russell King            2017-01-16  198  void __init arm_memblock_init(const struct machine_desc *mdesc)
3928624812dcfa Russell King            2017-01-16  199  {
3928624812dcfa Russell King            2017-01-16  200  	/* Register the kernel text, kernel data and initrd with memblock. */
3928624812dcfa Russell King            2017-01-16  201  	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
3928624812dcfa Russell King            2017-01-16  202  
b35b2736b43d71 Matija Glavinic Pecotic 2022-08-19  203  	sanitize_initrd_address();
e46e45f00d9ea5 Wang Kefeng             2021-12-22  204  	reserve_initrd_mem();
2778f62056ada4 Russell King            2010-07-09  205  
2778f62056ada4 Russell King            2010-07-09  206  	arm_mm_memblock_reserve();
2778f62056ada4 Russell King            2010-07-09  207  
8d717a52d1b095 Russell King            2010-05-22  208  	/* reserve any platform specific memblock areas */
8d717a52d1b095 Russell King            2010-05-22  209  	if (mdesc->reserve)
8d717a52d1b095 Russell King            2010-05-22  210  		mdesc->reserve();
8d717a52d1b095 Russell King            2010-05-22  211  
bcedb5f9bd7466 Marek Szyprowski        2014-02-28  212  	early_init_fdt_scan_reserved_mem();
bcedb5f9bd7466 Marek Szyprowski        2014-02-28  213  
99a468d779f685 George G. Davis         2015-01-16  214  	/* reserve memory for DMA contiguous allocations */
95b0e655f91488 Marek Szyprowski        2014-10-09  215  	dma_contiguous_reserve(arm_dma_limit);
c79095092834a1 Marek Szyprowski        2011-12-29  216  
716a3dc20084da Russell King            2012-01-13  217  	arm_memblock_steal_permitted = false;
2778f62056ada4 Russell King            2010-07-09  218  	memblock_dump_all();
2778f62056ada4 Russell King            2010-07-09 @219  }
2778f62056ada4 Russell King            2010-07-09  220  

:::::: The code at line 219 was first introduced by commit
:::::: 2778f62056ada442414392d7ccd41188bb631619 ARM: initial LMB trial

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
