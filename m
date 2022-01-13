Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44A48D2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiAMHOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:14:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:4483 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbiAMHOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642058077; x=1673594077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KiSpcj4/NnMSpwRSVYPskvjQBtfgudtdmZCRio0Iomk=;
  b=UqQZD3tFQ8xaJW8x20Rx8zoIhBuP+Z3q8mlkF+KnKs0d0LQ39A1s2khA
   giPtCQaAwaDKheeZIRR9V5tvc04Y9jmGsmYsJW4soob2oY3ls8QzEPjo5
   C/JUKwN/I4JiK3QLzzeOZcJWdPNs9V15jeUrQYv6gFiaKr8yXKOAHiHea
   ljvW3PF3K7nBbhkhuIrxAzEB6IJMBF9d20CyIEZX6je1eXSkx8xZ/qmfi
   vqa+A0GMyEvRNWjNtgXFHyUZd7wEgGdsRk70/+BFq1OOHh1HuzTicl6IJ
   aUiDa2Pv6zXxTslzUOouGem0CgL7foqXuq4hsT9elnmJ5Ua7ffnv5dSO8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224639230"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="224639230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 23:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="691703763"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2022 23:14:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7uJe-0006wN-M6; Thu, 13 Jan 2022 07:14:34 +0000
Date:   Thu, 13 Jan 2022 15:13:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anatolij Gustschin <agust@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/bestcomm/gen_bd.c:145:22: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202201131500.CJesWOtX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: adec566b05288f2787a1f88dbaf77ed8b0c644fa dmaengine: bestcomm: fix system boot lockups
date:   3 months ago
config: powerpc-randconfig-s032-20220113 (https://download.01.org/0day-ci/archive/20220113/202201131500.CJesWOtX-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adec566b05288f2787a1f88dbaf77ed8b0c644fa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout adec566b05288f2787a1f88dbaf77ed8b0c644fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/bestcomm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/dma/bestcomm/gen_bd.c:169:25: sparse: sparse: function 'bcom_gen_bd_tx_init' with external linkage has definition
>> drivers/dma/bestcomm/gen_bd.c:145:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
   drivers/dma/bestcomm/gen_bd.c:145:22: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/gen_bd.c:145:22: sparse:     got struct bcom_bd *bd
   drivers/dma/bestcomm/gen_bd.c:229:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
   drivers/dma/bestcomm/gen_bd.c:229:22: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/gen_bd.c:229:22: sparse:     got struct bcom_bd *bd
--
>> drivers/dma/bestcomm/bestcomm.c:98:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
   drivers/dma/bestcomm/bestcomm.c:98:30: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:98:30: sparse:     got struct bcom_bd *bd
>> drivers/dma/bestcomm/bestcomm.c:189:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *[assigned] var @@
   drivers/dma/bestcomm/bestcomm.c:189:19: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:189:19: sparse:     got unsigned int [usertype] *[assigned] var
>> drivers/dma/bestcomm/bestcomm.c:190:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *[assigned] inc @@
   drivers/dma/bestcomm/bestcomm.c:190:19: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:190:19: sparse:     got unsigned int [usertype] *[assigned] inc
>> drivers/dma/bestcomm/bestcomm.c:196:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] *[assigned] desc @@
   drivers/dma/bestcomm/bestcomm.c:196:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:196:21: sparse:     got unsigned int [usertype] *[assigned] desc
>> drivers/dma/bestcomm/bestcomm.c:197:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] * @@
   drivers/dma/bestcomm/bestcomm.c:197:25: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:197:25: sparse:     got unsigned int [usertype] *
>> drivers/dma/bestcomm/bestcomm.c:198:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] *[assigned] inc @@
   drivers/dma/bestcomm/bestcomm.c:198:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:198:21: sparse:     got unsigned int [usertype] *[assigned] inc
>> drivers/dma/bestcomm/bestcomm.c:305:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_tdt *tdt @@
   drivers/dma/bestcomm/bestcomm.c:305:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:305:27: sparse:     got struct bcom_tdt *tdt
>> drivers/dma/bestcomm/bestcomm.c:306:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *ctx @@
   drivers/dma/bestcomm/bestcomm.c:306:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:306:27: sparse:     got unsigned int [usertype] *ctx
>> drivers/dma/bestcomm/bestcomm.c:307:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *var @@
   drivers/dma/bestcomm/bestcomm.c:307:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:307:27: sparse:     got unsigned int [usertype] *var
>> drivers/dma/bestcomm/bestcomm.c:308:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *fdt @@
   drivers/dma/bestcomm/bestcomm.c:308:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:308:27: sparse:     got unsigned int [usertype] *fdt
   drivers/dma/bestcomm/bestcomm.c:311:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] * @@
   drivers/dma/bestcomm/bestcomm.c:311:35: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:311:35: sparse:     got unsigned int [usertype] *

vim +145 drivers/dma/bestcomm/gen_bd.c

   112	
   113	int
   114	bcom_gen_bd_rx_reset(struct bcom_task *tsk)
   115	{
   116		struct bcom_gen_bd_priv *priv = tsk->priv;
   117		struct bcom_gen_bd_rx_var *var;
   118		struct bcom_gen_bd_rx_inc *inc;
   119	
   120		/* Shutdown the task */
   121		bcom_disable_task(tsk->tasknum);
   122	
   123		/* Reset the microcode */
   124		var = (struct bcom_gen_bd_rx_var *) bcom_task_var(tsk->tasknum);
   125		inc = (struct bcom_gen_bd_rx_inc *) bcom_task_inc(tsk->tasknum);
   126	
   127		if (bcom_load_image(tsk->tasknum, bcom_gen_bd_rx_task))
   128			return -1;
   129	
   130		var->enable	= bcom_eng->regs_base +
   131					offsetof(struct mpc52xx_sdma, tcr[tsk->tasknum]);
   132		var->fifo	= (u32) priv->fifo;
   133		var->bd_base	= tsk->bd_pa;
   134		var->bd_last	= tsk->bd_pa + ((tsk->num_bd-1) * tsk->bd_size);
   135		var->bd_start	= tsk->bd_pa;
   136		var->buffer_size = priv->maxbufsize;
   137	
   138		inc->incr_bytes	= -(s16)sizeof(u32);
   139		inc->incr_dst	= sizeof(u32);
   140	
   141		/* Reset the BDs */
   142		tsk->index = 0;
   143		tsk->outdex = 0;
   144	
 > 145		memset_io(tsk->bd, 0x00, tsk->num_bd * tsk->bd_size);
   146	
   147		/* Configure some stuff */
   148		bcom_set_task_pragma(tsk->tasknum, BCOM_GEN_RX_BD_PRAGMA);
   149		bcom_set_task_auto_start(tsk->tasknum, tsk->tasknum);
   150	
   151		out_8(&bcom_eng->regs->ipr[priv->initiator], priv->ipr);
   152		bcom_set_initiator(tsk->tasknum, priv->initiator);
   153	
   154		out_be32(&bcom_eng->regs->IntPend, 1<<tsk->tasknum);	/* Clear ints */
   155	
   156		return 0;
   157	}
   158	EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_reset);
   159	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
