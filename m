Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0AA46B4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhLGIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:01:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:64570 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhLGIB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:01:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218206934"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="218206934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 23:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611580379"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2021 23:57:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muVMD-000MKG-EZ; Tue, 07 Dec 2021 07:57:49 +0000
Date:   Tue, 7 Dec 2021 15:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/dw-edma/dw-edma-v0-core.c:192:19: warning: unused
 function 'readq_ch'
Message-ID: <202112071510.Udt7cE6h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
commit: e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec dmaengine: dw-edma: Add support for the HDMA feature
date:   9 months ago
config: mips-buildonly-randconfig-r004-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071510.Udt7cE6h-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f50be8eb0a12a61d23db6cda452c693001d76898)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/mm/ drivers/dma/dw-edma/ drivers/video/fbdev/savage/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/dw-edma/dw-edma-v0-core.c:192:19: warning: unused function 'readq_ch'
   static inline u64 readq_ch(struct dw_edma enum dw_edma_dir dir, u16 ch,
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-097a1cb1d5/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts source usr


vim +/readq_ch +192 drivers/dma/dw-edma/dw-edma-v0-core.c

04e0a39fc10f82 Gustavo Pimentel 2021-02-18  191  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18 @192  static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  193  			   const void __iomem *addr)
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  194  {
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  195  	u32 value;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  196  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  197  	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  198  		u32 viewport_sel;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  199  		unsigned long flags;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  200  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  201  		raw_spin_lock_irqsave(&dw->lock, flags);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  202  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  203  		viewport_sel = FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  204  		if (dir == EDMA_DIR_READ)
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  205  			viewport_sel |= BIT(31);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  206  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  207  		writel(viewport_sel,
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  208  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  209  		value = readq(addr);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  210  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  211  		raw_spin_unlock_irqrestore(&dw->lock, flags);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  212  	} else {
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  213  		value = readq(addr);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  214  	}
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  215  
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  216  	return value;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  217  }
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  218  

:::::: The code at line 192 was first introduced by commit
:::::: 04e0a39fc10f82a71b84af73351333b184cee578 dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures

:::::: TO: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
