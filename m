Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F950CDE2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 00:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiDWWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 18:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiDWWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:10:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4453139759
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650751656; x=1682287656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rkRGR22eEuv1oM9xxa6jnEemsvuLfCXgIIj+ORWpj+M=;
  b=Q+XqYxjMIaqoZSSMXQV5xgn+bWl8B59YfI2HdZogy0pa7kClZVIS/AbT
   rR5sCiFyHEZG0ggJ0IevJ8qVbGY1s8lhNkQikczhOegMx8Kn3ZVclkayx
   RjPAuPzjrmduw3eBhEi/HHW0r7S5aRqDEZRAH8GAot2ZDLtO+jUHeDiDs
   ThtKwft7dzcWM6zv+zTUFTisDJeY3txij0bjCKtWkjATmm5XcE1MTzbpY
   ECsEXlcOkjTjY8pMe6UPzm8fqsfa73VOHECxrXkQJZRlrKT5GEdWoO4Cu
   GjBE8vBaBpLpltM3Y6rqZmUn99ufWo8S3erZRnWkQqbCu2bmOHFkNlQ+w
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="246868574"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="246868574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 15:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="649132721"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2022 15:07:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niNuf-0000XN-Rx;
        Sat, 23 Apr 2022 22:07:33 +0000
Date:   Sun, 24 Apr 2022 06:07:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/dw-edma/dw-edma-v0-core.c:192:19: warning: unused
 function 'readq_ch'
Message-ID: <202204240640.NsKCxxv9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
commit: e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec dmaengine: dw-edma: Add support for the HDMA feature
date:   1 year, 1 month ago
config: mips-randconfig-r032-20220424 (https://download.01.org/0day-ci/archive/20220424/202204240640.NsKCxxv9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/dma/dw-edma/ drivers/usb/gadget/ fs/overlayfs/ kernel/bpf/ sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/dw-edma/dw-edma-v0-core.c:192:19: warning: unused function 'readq_ch'
   static inline u64 readq_ch(struct dw_edma enum dw_edma_dir dir, u16 ch,
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-1cddcfdc3c/bin
   clang-15: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm nr_bisected scripts sound source usr virt


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
