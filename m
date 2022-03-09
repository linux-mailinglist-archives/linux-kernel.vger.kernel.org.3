Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C44C4D292A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiCIGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiCIGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:52:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B46F163060
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646808720; x=1678344720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fS6h+ssIo0QE9bU4nbg5fmathtVXnIXLFhGAfUIB8Vo=;
  b=E9xkMWXjYur5avDB94JPrrWc0tdHyvdq5KTbH7b/nPEZZZatN0hFiKXT
   PgczOpQbRqr13U2p574INnMzs84NURfeqoxoRZB0BVkrGKXeeoq37meqQ
   Y4mBe57wFmNHAGdM6mzdMblaFLYmI04u9Zf0v/BKPiLpWFowCMt/dygA5
   sm59rDz3l/kiFpRk9yDp6TfCuR39A6qb5xlMVLTvNOg9/FGlGREY/ildp
   gyuIxWiD9frupD/5x0JkGqc5w6R6m9PPazP/Y5EtHw5M7IJ9iMULvAz/l
   IBIzMWpaifthEA3MNwhR4N0TzUwZLJU0ELI8fiqSaGUiGhxnwooJCSRrZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242347283"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="242347283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="643939364"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 22:51:56 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRqAt-0002mU-Uo; Wed, 09 Mar 2022 06:51:55 +0000
Date:   Wed, 9 Mar 2022 14:51:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laura Abbott <lauraa@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Patrick Daly <pdaly@codeaurora.org>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 551/9999] arch/arm64/mm/mmu.c:80:13: warning: no previous prototype for
 'dma_contiguous_early_fixup'
Message-ID: <202203091423.BhhlT2nM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   3fba6c6e70994eff4dcc5be475c9d2bd3848b83d
commit: 0a85ff1b796eade4d8867982209c5cba8078b940 [551/9999] ANDROID: GKI: arm64: Support early fixup for CMA
config: arm64-randconfig-r033-20220308 (https://download.01.org/0day-ci/archive/20220309/202203091423.BhhlT2nM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0a85ff1b796eade4d8867982209c5cba8078b940
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 0a85ff1b796eade4d8867982209c5cba8078b940
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/mm/mmu.c:80:13: warning: no previous prototype for 'dma_contiguous_early_fixup' [-Wmissing-prototypes]
      80 | void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/mm/mmu.c:806:6: warning: no previous prototype for 'vmemmap_free' [-Wmissing-prototypes]
     806 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~
   arch/arm64/mm/mmu.c:969:12: warning: no previous prototype for 'arch_ioremap_p4d_supported' [-Wmissing-prototypes]
     969 | int __init arch_ioremap_p4d_supported(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dma_contiguous_early_fixup +80 arch/arm64/mm/mmu.c

    79	
  > 80	void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
    81	{
    82		if (dma_mmu_remap_num >= ARRAY_SIZE(dma_mmu_remap)) {
    83			pr_err("ARM64: Not enough slots for DMA fixup reserved regions!\n");
    84			return;
    85		}
    86		dma_mmu_remap[dma_mmu_remap_num].base = base;
    87		dma_mmu_remap[dma_mmu_remap_num].size = size;
    88		dma_mmu_remap_num++;
    89	}
    90	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
