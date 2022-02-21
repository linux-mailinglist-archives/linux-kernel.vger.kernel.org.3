Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5C4BEE35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiBUXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:32:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiBUXcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:32:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCEF1133
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486307; x=1677022307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e+q01QedYHb7A+hgClNwFVG6Ur/ydCjlwf5WcD2ykk4=;
  b=XgMqXZ2CykCLx4z2q1pPGI0Fskan2klviDU/zHNSyodRkF+ugzTvYqeX
   IyNwKlBR3BJiyiaojftOIguk5ieasNd3TDfK9J+XtLBcVMd3svPlQ0kH9
   0JT/LGFxwZ3w35PFzjnXQWLlRM2eyaOZrPQ+iToWjXdwlCEJQxZ4kdC3F
   VhJbu5rjMGOlRdbvkYLWZJy7Vf4GVXzgf2LmaipBIK+c4GiH+c+vpULlD
   /dBhORGxTJGD3DABG1kwxystgGJaQXVGNKrQ4E0s7IOnaOFwu9UskPT8V
   /ENYkboiCM97xpAy06XSpcCCWzxsgVJoh/UTGdAXO2Cw/bEy9V2KpBCqm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314841792"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="314841792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507772536"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 15:31:45 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMI9g-000255-SV; Mon, 21 Feb 2022 23:31:44 +0000
Date:   Tue, 22 Feb 2022 07:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1964:46: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <202202220710.SPJ8ha4K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
commit: 98c5611163603d3d8012b1bf64ab48fd932cf734 octeontx2-af: cn10k: Add mbox support for CN10K platform
date:   1 year ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220222/202202220710.SPJ8ha4K-lkp@intel.com/config)
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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
