Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B564E1984
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 04:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiCTDCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 23:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCTDCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 23:02:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF09F21FF7D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647745255; x=1679281255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j5+Llm7g5e2zUDcYP4XXhcx4gklcdN5/avsNT/A3Vk4=;
  b=mVpAPDRapTTPNlAugP0FVBWxpNW9mUq3NvTXwmxInJKsuNhJUCe0ongH
   nt4V/vWRLVaLrWOrmSs+wcaWjMjutrAVa5KxlTc6QaKc1tEKi+HPnhT2X
   KfRSWrpiGGgsKTt65hDWxYy9D550ZZSttApL3ydHb0boPxkIhvZA6jUlb
   puNBMYO1Wt1VGIhzZGLp/QP7l7UD46MmC+Ta6O9V+vTwN9nGbZP5bgbQf
   gf+54FUMQ2n6nnrkH6vwvROVfJ++Hj/16USWNofRWtXgbyo6Du8aek95k
   Q4tmByf36e2lllac+ZHNtbxq1h++ajTCHBgDZmM/DnbnJp7fiLlBRMm3A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="244818242"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="244818242"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 20:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="517980634"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2022 20:00:53 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVloL-000GVS-3C; Sun, 20 Mar 2022 03:00:53 +0000
Date:   Sun, 20 Mar 2022 11:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/dw-edma/dw-edma-v0-core.c:326
 dw_edma_v0_core_write_chunk() warn: inconsistent indenting
Message-ID: <202203201029.ZsGgjczC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34e047aa16c0123bbae8e2f6df33e5ecc1f56601
commit: e0c1d53891c43a70c9fa85ddb3174ab5afd7e2ec dmaengine: dw-edma: Add support for the HDMA feature
date:   1 year ago
config: ia64-randconfig-m031-20220320 (https://download.01.org/0day-ci/archive/20220320/202203201029.ZsGgjczC-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/dma/dw-edma/dw-edma-v0-core.c:326 dw_edma_v0_core_write_chunk() warn: inconsistent indenting
drivers/dma/dw-edma/dw-edma-v0-core.c:418 dw_edma_v0_core_start() warn: inconsistent indenting

Old smatch warnings:
drivers/dma/dw-edma/dw-edma-v0-core.c:350 dw_edma_v0_core_write_chunk() warn: inconsistent indenting

vim +326 drivers/dma/dw-edma/dw-edma-v0-core.c

7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  300  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  301  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  302  {
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  303  	struct dw_edma_burst *child;
756c3ef93492af Arnd Bergmann    2019-07-22  304  	struct dw_edma_v0_lli __iomem *lli;
756c3ef93492af Arnd Bergmann    2019-07-22  305  	struct dw_edma_v0_llp __iomem *llp;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  306  	u32 control = 0, i = 0;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  307  	int j;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  308  
756c3ef93492af Arnd Bergmann    2019-07-22  309  	lli = chunk->ll_region.vaddr;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  310  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  311  	if (chunk->cb)
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  312  		control = DW_EDMA_V0_CB;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  313  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  314  	j = chunk->bursts_alloc;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  315  	list_for_each_entry(child, &chunk->burst->list, list) {
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  316  		j--;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  317  		if (!j)
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  318  			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  319  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  320  		/* Channel control */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  321  		SET_LL_32(&lli[i].control, control);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  322  		/* Transfer size */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  323  		SET_LL_32(&lli[i].transfer_size, child->sz);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  324  		/* SAR */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  325  		#ifdef CONFIG_64BIT
04e0a39fc10f82 Gustavo Pimentel 2021-02-18 @326  			SET_LL_64(&lli[i].sar.reg, child->sar);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  327  		#else /* CONFIG_64BIT */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  328  			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  329  			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  330  		#endif /* CONFIG_64BIT */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  331  		/* DAR */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  332  		#ifdef CONFIG_64BIT
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  333  			SET_LL_64(&lli[i].dar.reg, child->dar);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  334  		#else /* CONFIG_64BIT */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  335  			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  336  			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  337  		#endif /* CONFIG_64BIT */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  338  		i++;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  339  	}
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  340  
756c3ef93492af Arnd Bergmann    2019-07-22  341  	llp = (void __iomem *)&lli[i];
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  342  	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  343  	if (!chunk->cb)
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  344  		control |= DW_EDMA_V0_CB;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  345  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  346  	/* Channel control */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  347  	SET_LL_32(&llp->control, control);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  348  	/* Linked list */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  349  	#ifdef CONFIG_64BIT
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  350  		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  351  	#else /* CONFIG_64BIT */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  352  		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  353  		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  354  	#endif /* CONFIG_64BIT */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  355  }
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  356  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  357  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  358  {
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  359  	struct dw_edma_chan *chan = chunk->chan;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  360  	struct dw_edma *dw = chan->chip->dw;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  361  	u32 tmp;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  362  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  363  	dw_edma_v0_core_write_chunk(chunk);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  364  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  365  	if (first) {
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  366  		/* Enable engine */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  367  		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  368  		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
e0c1d53891c43a Gustavo Pimentel 2021-02-18  369  			switch (chan->id) {
e0c1d53891c43a Gustavo Pimentel 2021-02-18  370  			case 0:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  371  				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  372  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  373  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  374  			case 1:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  375  				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  376  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  377  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  378  			case 2:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  379  				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  380  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  381  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  382  			case 3:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  383  				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  384  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  385  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  386  			case 4:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  387  				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  388  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  389  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  390  			case 5:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  391  				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  392  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  393  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  394  			case 6:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  395  				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  396  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  397  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  398  			case 7:
e0c1d53891c43a Gustavo Pimentel 2021-02-18  399  				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
e0c1d53891c43a Gustavo Pimentel 2021-02-18  400  					      BIT(0));
e0c1d53891c43a Gustavo Pimentel 2021-02-18  401  				break;
e0c1d53891c43a Gustavo Pimentel 2021-02-18  402  			}
e0c1d53891c43a Gustavo Pimentel 2021-02-18  403  		}
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  404  		/* Interrupt unmask - done, abort */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  405  		tmp = GET_RW_32(dw, chan->dir, int_mask);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  406  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  407  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  408  		SET_RW_32(dw, chan->dir, int_mask, tmp);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  409  		/* Linked list error */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  410  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  411  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  412  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  413  		/* Channel control */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  414  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  415  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  416  		/* Linked list */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  417  		#ifdef CONFIG_64BIT
04e0a39fc10f82 Gustavo Pimentel 2021-02-18 @418  			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  419  				  chunk->ll_region.paddr);
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  420  		#else /* CONFIG_64BIT */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  421  			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
6f4722b1d1ebf2 Arnd Bergmann    2019-07-22  422  				  lower_32_bits(chunk->ll_region.paddr));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  423  			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
6f4722b1d1ebf2 Arnd Bergmann    2019-07-22  424  				  upper_32_bits(chunk->ll_region.paddr));
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  425  		#endif /* CONFIG_64BIT */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  426  	}
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  427  	/* Doorbell */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  428  	SET_RW_32(dw, chan->dir, doorbell,
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  429  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  430  }
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  431  

:::::: The code at line 326 was first introduced by commit
:::::: 04e0a39fc10f82a71b84af73351333b184cee578 dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures

:::::: TO: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
