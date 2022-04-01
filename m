Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71624EE64E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiDAC57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244308AbiDAC5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:57:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD319E081
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648781766; x=1680317766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lfHplC/HVi/jIs2bJ7G6nE1endTG1bCkDbuUBJKPWag=;
  b=oECwHvBCHcCkF9D20UhHjRb4nb/XGaOtEGWtnFCg4bFw4rXADBPk6uL7
   DVe4bxaQvlNixm0X6I06QqUcEt8BAZxzp3ozZLVSR/WLSXRNnROU/RHtY
   bmPMHwEpLP3lgSSmNbykmoEO9FYDRguvJXZTEb+nXAMWCQiRDfJUviPGX
   GwRZMkx4d9RbTzkpgIr+1QH1RvVaXIYTRnvzqalrff3JX1J9iwu//3nXG
   FBYXg0sTABBQKvB/DTLkVh2ChB8RpX7/jg5+ppk6ZSCoLtx54xTkQifbG
   1YFkoeaXMSayie//62MHCF9icZUhi+I099H0Cz/nj6zBu/cZ+YKJDm7BE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="242175862"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="242175862"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 19:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="720718415"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 19:56:04 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na7SF-0000rz-RD;
        Fri, 01 Apr 2022 02:56:03 +0000
Date:   Fri, 1 Apr 2022 10:55:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202204011037.4f7vvM8S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8b767f5e04097aaedcd6e06e2270f9fe5282696
commit: 3d04158814e7a808c38124c87502b430b916dfcb crypto: amlogic - enable working on big endian kernel
date:   2 years, 4 months ago
config: sh-randconfig-s031-20220328 (https://download.01.org/0day-ci/archive/20220401/202204011037.4f7vvM8S-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d04158814e7a808c38124c87502b430b916dfcb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d04158814e7a808c38124c87502b430b916dfcb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] v @@     got unsigned long @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse:     expected restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse:     got unsigned long
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] v @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse:     expected unsigned int [usertype] val
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse:     got restricted __le32 [usertype] v
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:215:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] v @@     got unsigned long @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:215:19: sparse:     expected restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:215:19: sparse:     got unsigned long
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:217:27: sparse: sparse: invalid assignment: |=
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:217:27: sparse:    left side has type restricted __le32
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:217:27: sparse:    right side has type unsigned long
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:221:27: sparse: sparse: invalid assignment: |=
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:221:27: sparse:    left side has type restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:221:27: sparse:    right side has type unsigned long
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] v @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse:     expected unsigned int [usertype] val
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse:     got restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32

vim +171 drivers/crypto/amlogic/amlogic-gxl-cipher.c

   118	
   119		/*
   120		 * The hardware expect a list of meson_desc structures.
   121		 * The 2 first structures store key
   122		 * The third stores IV
   123		 */
   124		bkeyiv = kzalloc(48, GFP_KERNEL | GFP_DMA);
   125		if (!bkeyiv)
   126			return -ENOMEM;
   127	
   128		memcpy(bkeyiv, op->key, op->keylen);
   129		keyivlen = op->keylen;
   130	
   131		ivsize = crypto_skcipher_ivsize(tfm);
   132		if (areq->iv && ivsize > 0) {
   133			if (ivsize > areq->cryptlen) {
   134				dev_err(mc->dev, "invalid ivsize=%d vs len=%d\n", ivsize, areq->cryptlen);
   135				err = -EINVAL;
   136				goto theend;
   137			}
   138			memcpy(bkeyiv + 32, areq->iv, ivsize);
   139			keyivlen = 48;
   140			if (rctx->op_dir == MESON_DECRYPT) {
   141				backup_iv = kzalloc(ivsize, GFP_KERNEL);
   142				if (!backup_iv) {
   143					err = -ENOMEM;
   144					goto theend;
   145				}
   146				offset = areq->cryptlen - ivsize;
   147				scatterwalk_map_and_copy(backup_iv, areq->src, offset,
   148							 ivsize, 0);
   149			}
   150		}
   151		if (keyivlen == 24)
   152			keyivlen = 32;
   153	
   154		phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
   155					  DMA_TO_DEVICE);
   156		err = dma_mapping_error(mc->dev, phykeyiv);
   157		if (err) {
   158			dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
   159			goto theend;
   160		}
   161	
   162		tloffset = 0;
   163		eat = 0;
   164		i = 0;
   165		while (keyivlen > eat) {
   166			desc = &mc->chanlist[flow].tl[tloffset];
   167			memset(desc, 0, sizeof(struct meson_desc));
   168			todo = min(keyivlen - eat, 16u);
   169			desc->t_src = cpu_to_le32(phykeyiv + i * 16);
   170			desc->t_dst = cpu_to_le32(i * 16);
 > 171			v = (MODE_KEY << 20) | DESC_OWN | 16;
 > 172			desc->t_status = cpu_to_le32(v);
   173	
   174			eat += todo;
   175			i++;
   176			tloffset++;
   177		}
   178	
   179		if (areq->src == areq->dst) {
   180			nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
   181					    DMA_BIDIRECTIONAL);
   182			if (nr_sgs < 0) {
   183				dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
   184				err = -EINVAL;
   185				goto theend;
   186			}
   187			nr_sgd = nr_sgs;
   188		} else {
   189			nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
   190					    DMA_TO_DEVICE);
   191			if (nr_sgs < 0 || nr_sgs > MAXDESC - 3) {
   192				dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
   193				err = -EINVAL;
   194				goto theend;
   195			}
   196			nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
   197					    DMA_FROM_DEVICE);
   198			if (nr_sgd < 0 || nr_sgd > MAXDESC - 3) {
   199				dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
   200				err = -EINVAL;
   201				goto theend;
   202			}
   203		}
   204	
   205		src_sg = areq->src;
   206		dst_sg = areq->dst;
   207		len = areq->cryptlen;
   208		while (src_sg) {
   209			desc = &mc->chanlist[flow].tl[tloffset];
   210			memset(desc, 0, sizeof(struct meson_desc));
   211	
   212			desc->t_src = cpu_to_le32(sg_dma_address(src_sg));
   213			desc->t_dst = cpu_to_le32(sg_dma_address(dst_sg));
   214			todo = min(len, sg_dma_len(src_sg));
   215			v = (op->keymode << 20) | DESC_OWN | todo | (algt->blockmode << 26);
   216			if (rctx->op_dir)
 > 217				v |= DESC_ENCRYPTION;
   218			len -= todo;
   219	
   220			if (!sg_next(src_sg))
   221				v |= DESC_LAST;
   222			desc->t_status = cpu_to_le32(v);
   223			tloffset++;
   224			src_sg = sg_next(src_sg);
   225			dst_sg = sg_next(dst_sg);
   226		}
   227	
   228		reinit_completion(&mc->chanlist[flow].complete);
   229		mc->chanlist[flow].status = 0;
   230		writel(mc->chanlist[flow].t_phy | 2, mc->base + (flow << 2));
   231		wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
   232							  msecs_to_jiffies(500));
   233		if (mc->chanlist[flow].status == 0) {
   234			dev_err(mc->dev, "DMA timeout for flow %d\n", flow);
   235			err = -EINVAL;
   236		}
   237	
   238		dma_unmap_single(mc->dev, phykeyiv, keyivlen, DMA_TO_DEVICE);
   239	
   240		if (areq->src == areq->dst) {
   241			dma_unmap_sg(mc->dev, areq->src, nr_sgs, DMA_BIDIRECTIONAL);
   242		} else {
   243			dma_unmap_sg(mc->dev, areq->src, nr_sgs, DMA_TO_DEVICE);
   244			dma_unmap_sg(mc->dev, areq->dst, nr_sgd, DMA_FROM_DEVICE);
   245		}
   246	
   247		if (areq->iv && ivsize > 0) {
   248			if (rctx->op_dir == MESON_DECRYPT) {
   249				memcpy(areq->iv, backup_iv, ivsize);
   250			} else {
   251				scatterwalk_map_and_copy(areq->iv, areq->dst,
   252							 areq->cryptlen - ivsize,
   253							 ivsize, 0);
   254			}
   255		}
   256	theend:
   257		kzfree(bkeyiv);
   258		kzfree(backup_iv);
   259	
   260		return err;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
