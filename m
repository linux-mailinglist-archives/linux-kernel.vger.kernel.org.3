Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0253D81A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiFDScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiFDSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 14:31:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0F61D9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654367512; x=1685903512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9XTQIzHEBj0nYIW3pXe5Kq7qGEBVyGnwuVcb/zSra5I=;
  b=le133uZu0GdtCXGjtUzkyg3Fs++ssbgBjJbWE9U8T07SPihiIKVEqqch
   Rzdao4yXLMgxcx6oE9VuJaEe3FWjdWXXRsjJTwthefydyImbGCYx5VxDw
   FkQZ4CssEANGi570kHG7VWLYsQZs2LgH4iuvN/btMVv7wvnAyzELOv++C
   dM6fL0n9N8GjHng2XX4nIvPzBCYbYIs2BDIJhes7meLd5h7LJ8WQvIehq
   pTZJGrFEoeOxlsRK1oUSPCrCmaEXvHlLH+I+D3QrXEE6cM0dLARqCbJ1H
   OcxI0d/7oizFpJ4EIaFVOK9DP9iZGK+lxmRVcjeW04WL4YhkG+nj0gGgc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="362829355"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="362829355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 11:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="613706641"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2022 11:31:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxYYv-000B7p-C6;
        Sat, 04 Jun 2022 18:31:49 +0000
Date:   Sun, 5 Jun 2022 02:31:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202206050255.CU8yNvC3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   4 months ago
config: arm-randconfig-s032-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050255.CU8yNvC3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/mtd/nand/onenand/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     got void [noderef] __iomem *
>> drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:385:17: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:404:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     got void [noderef] __iomem *
>> drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     expected void *
   drivers/mtd/nand/onenand/onenand_omap2.c:444:9: sparse:     got void [noderef] __iomem *

vim +385 drivers/mtd/nand/onenand/onenand_omap2.c

3621311695f5b1a drivers/mtd/onenand/omap2.c              Peter Ujfalusi  2018-01-12  359  
fb25070afdf07cc drivers/mtd/onenand/omap2.c              Ladislav Michl  2018-01-12  360  static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  361  					unsigned char *buffer, int offset,
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  362  					size_t count)
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  363  {
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  364  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  365  	struct onenand_chip *this = mtd->priv;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  366  	struct device *dev = &c->pdev->dev;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  367  	void *buf = (void *)buffer;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  368  	dma_addr_t dma_src, dma_dst;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  369  	int bram_offset, err;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  370  	size_t xtra;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  371  
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  372  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  373  	/*
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  374  	 * If the buffer address is not DMA-able, len is not long enough to
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  375  	 * make DMA transfers profitable or if invoked from panic_write()
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  376  	 * fallback to PIO mode.
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  377  	 */
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  378  	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  379  	    count < 384 || mtd->oops_panic_write)
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  380  		goto out_copy;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  381  
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  382  	xtra = count & 3;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  383  	if (xtra) {
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  384  		count -= xtra;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06 @385  		memcpy(buf + count, this->base + bram_offset + count, xtra);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  386  	}
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  387  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  388  	dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  389  	dma_src = c->phys_base + bram_offset;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  390  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  391  	if (dma_mapping_error(dev, dma_dst)) {
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  392  		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  393  		goto out_copy;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  394  	}
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  395  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  396  	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  397  	dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  398  	if (!err)
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  399  		return 0;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  400  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  401  	dev_err(dev, "timeout waiting for DMA\n");
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  402  
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  403  out_copy:
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  404  	memcpy(buf, this->base + bram_offset, count);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  405  	return 0;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  406  }
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  407  
fb25070afdf07cc drivers/mtd/onenand/omap2.c              Ladislav Michl  2018-01-12  408  static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  409  					 const unsigned char *buffer,
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  410  					 int offset, size_t count)
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  411  {
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  412  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  413  	struct onenand_chip *this = mtd->priv;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  414  	struct device *dev = &c->pdev->dev;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  415  	void *buf = (void *)buffer;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  416  	dma_addr_t dma_src, dma_dst;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  417  	int bram_offset, err;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  418  
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  419  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  420  	/*
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  421  	 * If the buffer address is not DMA-able, len is not long enough to
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  422  	 * make DMA transfers profitable or if invoked from panic_write()
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  423  	 * fallback to PIO mode.
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  424  	 */
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  425  	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
875330f87a057a7 drivers/mtd/nand/onenand/onenand_omap2.c Thomas Gleixner 2020-11-13  426  	    count < 384 || mtd->oops_panic_write)
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  427  		goto out_copy;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  428  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  429  	dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  430  	dma_dst = c->phys_base + bram_offset;
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  431  	if (dma_mapping_error(dev, dma_src)) {
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  432  		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  433  		goto out_copy;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  434  	}
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  435  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  436  	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  437  	dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  438  	if (!err)
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  439  		return 0;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  440  
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  441  	dev_err(dev, "timeout waiting for DMA\n");
6732cfd4cac514b drivers/mtd/nand/onenand/omap2.c         Ladislav Michl  2018-05-02  442  
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  443  out_copy:
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06 @444  	memcpy(this->base + bram_offset, buf, count);
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  445  	return 0;
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  446  }
36cd4fb5d277f34 drivers/mtd/onenand/omap2.c              Adrian Hunter   2008-08-06  447  

:::::: The code at line 385 was first introduced by commit
:::::: 36cd4fb5d277f34fe9e4db0deac2d4efd7dff735 [MTD] [OneNAND] Add OMAP2 / OMAP3 OneNAND driver

:::::: TO: Adrian Hunter <ext-adrian.hunter@nokia.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
