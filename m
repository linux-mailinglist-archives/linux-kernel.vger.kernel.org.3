Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B74BE577
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358834AbiBUNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:18:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358825AbiBUNSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:18:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312471EED9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645449498; x=1676985498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vcJYgubBwS5EWIZVc7wEuxJrBDMZX2y3GacrrLk695Y=;
  b=Ra7EVIZdB+3b4SQuvi4A0Bmv3ic/M7MpXGs4trnnA14Jg/YnBU0aqbBd
   J843CASvPHgLJpq5oLL0jpPAEhRfhTXWTEoJs7EbDJzYoGbt5yfztQqGO
   ejVFUnaztnCC285/W3ByP2ypKQ+1iDGAZ+JsZd0qn94jgAVkK2j3+S/E0
   9ITqmHkTx/+OXEqXZgowk4rn1s7QQRJqguDujfpdYrcz94oMxdvWHsnrZ
   r0gpenFeDabx90QUazP1KRXZc2JO0OK6oXCas+YrQXlv19YOx199MBKQh
   lb7Krwvx7BxgN0Br0PFdhzHdwxiOGO8gZTZm8DFtlZY/zn2mMRYcIf0Qz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276098710"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="276098710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="638553145"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2022 05:18:16 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM8Zz-0001dP-9V; Mon, 21 Feb 2022 13:18:15 +0000
Date:   Mon, 21 Feb 2022 21:18:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/dw-edma/dw-edma-v0-core.c:192:19: warning: unused
 function 'readq_ch'
Message-ID: <202202212129.7Gipg08u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec dmaengine: dw-edma: Add support for the HDMA feature
date:   11 months ago
config: mips-randconfig-r001-20220221 (https://download.01.org/0day-ci/archive/20220221/202202212129.7Gipg08u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/cavium-octeon/crypto/ arch/mips/cavium-octeon/executive/ arch/mips/kernel/ drivers/dma/dw-edma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/dw-edma/dw-edma-v0-core.c:192:19: warning: unused function 'readq_ch'
   static inline u64 readq_ch(struct dw_edma enum dw_edma_dir dir, u16 ch,
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x00 == 0x04)); sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d271fc04d5/bin
   clang-15: note: diagnostic msg:
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
