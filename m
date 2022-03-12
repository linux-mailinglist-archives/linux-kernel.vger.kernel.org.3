Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F34D6D71
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiCLIFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCLIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:05:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC423D1AB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647072258; x=1678608258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2QXr5Dogh/A8C04F74qHZI3XCpmDhhOHsBxhQnRiaeQ=;
  b=OckBjM71PP9He/+dBt+O1imrxeLXSn55k0a53N+ddi2VzOmQxOfmigKS
   vuQOd4pz1zoP5/QgMbeRMOUs5f+dIs2xaYhULETFBQ+KL5OSxWbugDfyt
   dy4lpO0nXz6f7jKTdfwPwWyXJ8RXTMpJ4pfn1BnlcbyTwJ356/iixE4fQ
   rUk3i9lI24bpZ7G+wlUIneEl7G9WwFGRi2sjOFRolKgzLDEORx1BnsKvf
   HLBlXll0JyLR8yJasE6LN7xMd3rAI0KSytK0Jl9pu9UOYvFNXyX0xUsTl
   /O6WeqTJHo4J0NyjSQ8Plvvpkxw1Q/6XnBZMKFTinlWn/Rs8WkMASQrZC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237942995"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237942995"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539317860"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2022 00:04:15 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSwjX-0007hh-9d; Sat, 12 Mar 2022 08:04:15 +0000
Date:   Sat, 12 Mar 2022 16:03:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1964:46: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <202203121536.7EHHGIrm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: 98c5611163603d3d8012b1bf64ab48fd932cf734 octeontx2-af: cn10k: Add mbox support for CN10K platform
date:   1 year, 1 month ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203121536.7EHHGIrm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=98c5611163603d3d8012b1bf64ab48fd932cf734
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 98c5611163603d3d8012b1bf64ab48fd932cf734
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/tegra/ drivers/gpu/host1x/ drivers/hid/ drivers/irqchip/ drivers/net/ethernet/marvell/octeontx2/af/ drivers/net/ethernet/ti/ drivers/remoteproc/ drivers/scsi/hisi_sas/ security/integrity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:780:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct rvu_fwdata *fwdata @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:780:21: sparse:     expected struct rvu_fwdata *fwdata
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:780:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:786:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct rvu_fwdata *fwdata @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:786:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:786:28: sparse:     got struct rvu_fwdata *fwdata
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:799:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct rvu_fwdata *fwdata @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:799:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:799:28: sparse:     got struct rvu_fwdata *fwdata
>> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1964:46: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1984:38: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +1964 drivers/net/ethernet/marvell/octeontx2/af/rvu.c

  1941	
  1942	static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
  1943					int num, int type)
  1944	{
  1945		struct rvu_hwinfo *hw = rvu->hw;
  1946		int region;
  1947		u64 bar4;
  1948	
  1949		/* For cn10k platform VF mailbox regions of a PF follows after the
  1950		 * PF <-> AF mailbox region. Whereas for Octeontx2 it is read from
  1951		 * RVU_PF_VF_BAR4_ADDR register.
  1952		 */
  1953		if (type == TYPE_AFVF) {
  1954			for (region = 0; region < num; region++) {
  1955				if (hw->cap.per_pf_mbox_regs) {
  1956					bar4 = rvu_read64(rvu, BLKADDR_RVUM,
  1957							  RVU_AF_PFX_BAR4_ADDR(0)) +
  1958							  MBOX_SIZE;
  1959					bar4 += region * MBOX_SIZE;
  1960				} else {
  1961					bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
  1962					bar4 += region * MBOX_SIZE;
  1963				}
> 1964				mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
  1965				if (!mbox_addr[region])
  1966					goto error;
  1967			}
  1968			return 0;
  1969		}
  1970	
  1971		/* For cn10k platform AF <-> PF mailbox region of a PF is read from per
  1972		 * PF registers. Whereas for Octeontx2 it is read from
  1973		 * RVU_AF_PF_BAR4_ADDR register.
  1974		 */
  1975		for (region = 0; region < num; region++) {
  1976			if (hw->cap.per_pf_mbox_regs) {
  1977				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
  1978						  RVU_AF_PFX_BAR4_ADDR(region));
  1979			} else {
  1980				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
  1981						  RVU_AF_PF_BAR4_ADDR);
  1982				bar4 += region * MBOX_SIZE;
  1983			}
  1984			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
  1985			if (!mbox_addr[region])
  1986				goto error;
  1987		}
  1988		return 0;
  1989	
  1990	error:
  1991		while (region--)
  1992			iounmap((void __iomem *)mbox_addr[region]);
  1993		return -ENOMEM;
  1994	}
  1995	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
