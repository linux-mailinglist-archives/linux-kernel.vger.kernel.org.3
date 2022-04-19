Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2317D506407
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbiDSFtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiDSFtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:49:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD927CD3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650347192; x=1681883192;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=37FJ2nsCSZQtlVE9UBVezOUr6RFQ83E2d1QMGGZ+N+o=;
  b=la5s5MUR4Q+DOiaQc6YkAdOa6Bgv2ieiFonTX7l2k3A7r+YqWkXtQ0uW
   LZ1Z3mfDsL981oXUZNRVAd6feRmJ/dAGOAbOqRmFBxl6saLYxGzg7FFuV
   6h6cYFPNCa0XQAnqUoAIobGWPELHpotBgddkffIVSTsr9hGIar1uaBMuh
   VuSNGA8lRQV1DF9QdlIDLg/u1LMr5XvKNU48tghs6z4RhIb+x/epHtUkC
   eVKs+t3Oz1xZmgFVUR2/iqjbcjtpYwRtrCgDF0t6tq7Vlr1sGhOcXqIGA
   CBqNSs0ARtcGb5DU6r2YXA/T7W5Y6Pi2kE/vXHl16RP0kGkFf+jQb02pW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250985539"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="250985539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="702067021"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2022 22:46:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggh1-0005Oo-Bl;
        Tue, 19 Apr 2022 05:46:27 +0000
Date:   Tue, 19 Apr 2022 13:45:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1707/2356] drivers/spi/spi-intel.c:549:27:
 error: use of undeclared identifier 'SZ_4K'
Message-ID: <202204191301.Nv9tUAUw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 26730fd8712d97926bd7b6517dba4e77a24314ea [1707/2356] headers/deps: lib/scatterlist: Optimize <linux/scatterlist_types.h> dependencies, remove <linux/mm.h>
config: x86_64-randconfig-a014-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191301.Nv9tUAUw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=26730fd8712d97926bd7b6517dba4e77a24314ea
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 26730fd8712d97926bd7b6517dba4e77a24314ea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-intel.c:13:
   In file included from include/linux/mtd/spi-nor.h:10:
   include/linux/mtd/cfi.h:62:2: warning: No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-W#warnings]
   #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
    ^
>> drivers/spi/spi-intel.c:549:27: error: use of undeclared identifier 'SZ_4K'
                                      round_up(addr + 1, SZ_4K)) - addr;
                                                         ^
>> drivers/spi/spi-intel.c:549:27: error: use of undeclared identifier 'SZ_4K'
   drivers/spi/spi-intel.c:606:27: error: use of undeclared identifier 'SZ_4K'
                                      round_up(addr + 1, SZ_4K)) - addr;
                                                         ^
   drivers/spi/spi-intel.c:606:27: error: use of undeclared identifier 'SZ_4K'
   1 warning and 4 errors generated.


vim +/SZ_4K +549 drivers/spi/spi-intel.c

8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  526  
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  527  static int intel_spi_read(struct intel_spi *ispi,
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  528  			  const struct intel_spi_mem_op *iop,
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  529  			  const struct spi_mem_op *op)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  530  {
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  531  	void *read_buf = op->data.buf.in;
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  532  	size_t block_size, nbytes = op->data.nbytes;
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  533  	u32 addr = op->addr.val;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  534  	u32 val, status;
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  535  	int ret;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  536  
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  537  	/*
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  538  	 * Atomic sequence is not expected with HW sequencer reads. Make
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  539  	 * sure it is cleared regardless.
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  540  	 */
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  541  	if (WARN_ON_ONCE(ispi->atomic_preopcode))
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  542  		ispi->atomic_preopcode = 0;
c7d6a82d90e193 drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2018-02-05  543  
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  544  	while (nbytes > 0) {
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  545  		block_size = min_t(size_t, nbytes, INTEL_SPI_FIFO_SZ);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  546  
2b75ebeea6f493 drivers/mtd/spi-nor/intel-spi.c Alexander Sverdlin 2019-03-19  547  		/* Read cannot cross 4K boundary */
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  548  		block_size = min_t(loff_t, addr + block_size,
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09 @549  				   round_up(addr + 1, SZ_4K)) - addr;
2b75ebeea6f493 drivers/mtd/spi-nor/intel-spi.c Alexander Sverdlin 2019-03-19  550  
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  551  		writel(addr, ispi->base + FADDR);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  552  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  553  		val = readl(ispi->base + HSFSTS_CTL);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  554  		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  555  		val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  556  		val |= (block_size - 1) << HSFSTS_CTL_FDBC_SHIFT;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  557  		val |= HSFSTS_CTL_FCYCLE_READ;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  558  		val |= HSFSTS_CTL_FGO;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  559  		writel(val, ispi->base + HSFSTS_CTL);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  560  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  561  		ret = intel_spi_wait_hw_busy(ispi);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  562  		if (ret)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  563  			return ret;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  564  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  565  		status = readl(ispi->base + HSFSTS_CTL);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  566  		if (status & HSFSTS_CTL_FCERR)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  567  			ret = -EIO;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  568  		else if (status & HSFSTS_CTL_AEL)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  569  			ret = -EACCES;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  570  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  571  		if (ret < 0) {
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  572  			dev_err(ispi->dev, "read error: %x: %#x\n", addr, status);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  573  			return ret;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  574  		}
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  575  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  576  		ret = intel_spi_read_block(ispi, read_buf, block_size);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  577  		if (ret)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  578  			return ret;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  579  
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  580  		nbytes -= block_size;
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  581  		addr += block_size;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  582  		read_buf += block_size;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  583  	}
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  584  
e23e5a05d1fd94 drivers/spi/spi-intel.c         Mika Westerberg    2022-02-09  585  	return 0;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  586  }
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg    2016-11-28  587  

:::::: The code at line 549 was first introduced by commit
:::::: e23e5a05d1fd9479586c40ffbcc056b3e34ef816 mtd: spi-nor: intel-spi: Convert to SPI MEM

:::::: TO: Mika Westerberg <mika.westerberg@linux.intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
