Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AD4A9202
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356513AbiBDB3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:29:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:51618 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356486AbiBDB3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938187; x=1675474187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0FSjS0Ud40EXT5D2Oz6sFfQmHB0uEtDOH54t50nzhv4=;
  b=buamLQtcGx/5fqCzhr3p1r2ZCRLUr/hTa3x6qDgQAZ4UwXKZK1YzsasT
   fVL4yl8j6kCp4CwEknPlifvca3ixpLu2zTjf19s0B+9mqFn/9XZ0BzO6N
   kHtQedPO3T9IDlHWu24WJ/Wx6SXGj0BAUSDRw6R9NuLbFEPQHFAfMnerH
   Y9gCxOZuKg1e38QHldv+OfJmfWKJ5WfgQWXmsl9YEsM01Y0urSTR1elJS
   gZ42GrdNTJQkqeqqeJr34Y6ZK1uDiRVioa97GNs9xJ9tBOXKmlzmArRv8
   BYnzNbWd+0MlGzNmr6R82sxXjvvPqeAF3yJuy8Uw5U27on6tdht6SMVtr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334684815"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334684815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676973208"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 17:29:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnQ0-000Wte-D8; Fri, 04 Feb 2022 01:29:44 +0000
Date:   Fri, 4 Feb 2022 09:29:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Swathi Sridhar <swatsrid@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Prakash Gupta <guptap@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 802/9999] drivers/iommu/io-pgtable-arm.c:666:41: error: implicit declaration
 of function 'iommu_pgsize'
Message-ID: <202202040253.jsNxVzXI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swathi,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   a2429bd75fe959e3bf866aa5005606031b5c16be
commit: 27de1978c331d4e7571a5d0187ef1802d65dbf65 [802/9999] ANDROID: GKI: iommu/io-pgtable-arm: LPAE related updates by vendor
config: arm-randconfig-r033-20220130 (https://download.01.org/0day-ci/archive/20220204/202202040253.jsNxVzXI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/27de1978c331d4e7571a5d0187ef1802d65dbf65
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 27de1978c331d4e7571a5d0187ef1802d65dbf65
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/crypto/ drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/io-pgtable-arm.c: In function '__arm_lpae_alloc_pages':
   drivers/iommu/io-pgtable-arm.c:312:23: error: implicit declaration of function 'io_pgtable_alloc_pages_exact' [-Werror=implicit-function-declaration]
     312 |         void *pages = io_pgtable_alloc_pages_exact(cfg, cookie, size,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:312:23: warning: initialization of 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/iommu/io-pgtable-arm.c:337:9: error: implicit declaration of function 'io_pgtable_free_pages_exact' [-Werror=implicit-function-declaration]
     337 |         io_pgtable_free_pages_exact(cfg, cookie, pages, size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_prot_to_pte':
   drivers/iommu/io-pgtable-arm.c:572:33: error: 'IOMMU_USE_UPSTREAM_HINT' undeclared (first use in this function)
     572 |                 else if (prot & IOMMU_USE_UPSTREAM_HINT)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:572:33: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/io-pgtable-arm.c:575:33: error: 'IOMMU_USE_LLC_NWA' undeclared (first use in this function)
     575 |                 else if (prot & IOMMU_USE_LLC_NWA)
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_map_sg':
>> drivers/iommu/io-pgtable-arm.c:666:41: error: implicit declaration of function 'iommu_pgsize' [-Werror=implicit-function-declaration]
     666 |                         size_t pgsize = iommu_pgsize(
         |                                         ^~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_alloc_pgtable':
   drivers/iommu/io-pgtable-arm.c:1095:18: error: 'struct io_pgtable_ops' has no member named 'map_sg'
    1095 |                 .map_sg         = arm_lpae_map_sg,
         |                  ^~~~~~
   drivers/iommu/io-pgtable-arm.c:1095:35: error: initialization of 'size_t (*)(struct io_pgtable_ops *, long unsigned int,  size_t)' {aka 'unsigned int (*)(struct io_pgtable_ops *, long unsigned int,  unsigned int)'} from incompatible pointer type 'int (*)(struct io_pgtable_ops *, long unsigned int,  struct scatterlist *, unsigned int,  int,  size_t *)' {aka 'int (*)(struct io_pgtable_ops *, long unsigned int,  struct scatterlist *, unsigned int,  int,  unsigned int *)'} [-Werror=incompatible-pointer-types]
    1095 |                 .map_sg         = arm_lpae_map_sg,
         |                                   ^~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1095:35: note: (near initialization for '(anonymous).unmap')
   drivers/iommu/io-pgtable-arm.c:1096:35: warning: initialized field overwritten [-Woverride-init]
    1096 |                 .unmap          = arm_lpae_unmap,
         |                                   ^~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1096:35: note: (near initialization for '(anonymous).unmap')
   drivers/iommu/io-pgtable-arm.c:1098:18: error: 'struct io_pgtable_ops' has no member named 'is_iova_coherent'
    1098 |                 .is_iova_coherent = arm_lpae_is_iova_coherent,
         |                  ^~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1098:37: warning: excess elements in struct initializer
    1098 |                 .is_iova_coherent = arm_lpae_is_iova_coherent,
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1098:37: note: (near initialization for '(anonymous)')
   drivers/iommu/io-pgtable-arm.c:1099:18: error: 'struct io_pgtable_ops' has no member named 'iova_to_pte'; did you mean 'iova_to_phys'?
    1099 |                 .iova_to_pte    = arm_lpae_iova_get_pte,
         |                  ^~~~~~~~~~~
         |                  iova_to_phys
   drivers/iommu/io-pgtable-arm.c:1099:35: warning: excess elements in struct initializer
    1099 |                 .iova_to_pte    = arm_lpae_iova_get_pte,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1099:35: note: (near initialization for '(anonymous)')
   drivers/iommu/io-pgtable-arm.c: In function 'arm_64_lpae_alloc_pgtable_s1':
   drivers/iommu/io-pgtable-arm.c:1113:29: error: 'IO_PGTABLE_QUIRK_QCOM_USE_UPSTREAM_HINT' undeclared (first use in this function)
    1113 |                           | IO_PGTABLE_QUIRK_QCOM_USE_UPSTREAM_HINT
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1114:29: error: 'IO_PGTABLE_QUIRK_QSMMUV500_NON_SHAREABLE' undeclared (first use in this function)
    1114 |                           | IO_PGTABLE_QUIRK_QSMMUV500_NON_SHAREABLE
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:1115:29: error: 'IO_PGTABLE_QUIRK_QCOM_USE_LLC_NWA' undeclared (first use in this function)
    1115 |                           | IO_PGTABLE_QUIRK_QCOM_USE_LLC_NWA))
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/iommu_pgsize +666 drivers/iommu/io-pgtable-arm.c

   546	
   547	static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
   548						   int prot)
   549	{
   550		arm_lpae_iopte pte;
   551	
   552		if (data->iop.fmt == ARM_64_LPAE_S1 ||
   553		    data->iop.fmt == ARM_32_LPAE_S1) {
   554			pte = ARM_LPAE_PTE_nG;
   555	
   556			if (prot & IOMMU_WRITE)
   557				pte |= (prot & IOMMU_PRIV) ? ARM_LPAE_PTE_AP_PRIV_RW
   558						: ARM_LPAE_PTE_AP_UNPRIV;
   559			else
   560				pte |= (prot & IOMMU_PRIV) ? ARM_LPAE_PTE_AP_PRIV_RO
   561						: ARM_LPAE_PTE_AP_RO;
   562	
   563			if (!(prot & IOMMU_PRIV))
   564				pte |= ARM_LPAE_PTE_AP_UNPRIV;
   565	
   566			if (prot & IOMMU_MMIO)
   567				pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
   568					<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
   569			else if (prot & IOMMU_CACHE)
   570				pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
   571					<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 > 572			else if (prot & IOMMU_USE_UPSTREAM_HINT)
   573				pte |= (ARM_LPAE_MAIR_ATTR_IDX_UPSTREAM
   574					<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
   575			else if (prot & IOMMU_USE_LLC_NWA)
   576				pte |= (ARM_LPAE_MAIR_ATTR_IDX_LLC_NWA
   577					<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
   578		} else {
   579			pte = ARM_LPAE_PTE_HAP_FAULT;
   580			if (prot & IOMMU_READ)
   581				pte |= ARM_LPAE_PTE_HAP_READ;
   582			if (prot & IOMMU_WRITE)
   583				pte |= ARM_LPAE_PTE_HAP_WRITE;
   584			if (prot & IOMMU_MMIO)
   585				pte |= ARM_LPAE_PTE_MEMATTR_DEV;
   586			else if (prot & IOMMU_CACHE)
   587				pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
   588			else
   589				pte |= ARM_LPAE_PTE_MEMATTR_NC;
   590		}
   591	
   592		if (prot & IOMMU_NOEXEC)
   593			pte |= ARM_LPAE_PTE_XN;
   594	
   595		return pte;
   596	}
   597	
   598	static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
   599				phys_addr_t paddr, size_t size, int iommu_prot)
   600	{
   601		struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
   602		arm_lpae_iopte *ptep = data->pgd;
   603		int ret, lvl = ARM_LPAE_START_LVL(data);
   604		arm_lpae_iopte prot;
   605	
   606		/* If no access, then nothing to do */
   607		if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
   608			return 0;
   609	
   610		if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
   611			    paddr >= (1ULL << data->iop.cfg.oas)))
   612			return -ERANGE;
   613	
   614		prot = arm_lpae_prot_to_pte(data, iommu_prot);
   615		ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, NULL,
   616					NULL);
   617		/*
   618		 * Synchronise all PTE updates for the new mapping before there's
   619		 * a chance for anything to kick off a table walk for the new iova.
   620		 */
   621		wmb();
   622	
   623		return ret;
   624	}
   625	
   626	static int arm_lpae_map_sg(struct io_pgtable_ops *ops, unsigned long iova,
   627				   struct scatterlist *sg, unsigned int nents,
   628				   int iommu_prot, size_t *size)
   629	{
   630		struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
   631		arm_lpae_iopte *ptep = data->pgd;
   632		int lvl = ARM_LPAE_START_LVL(data);
   633		arm_lpae_iopte prot;
   634		struct scatterlist *s;
   635		size_t mapped = 0;
   636		int i;
   637		int ret = -EINVAL;
   638		unsigned int min_pagesz;
   639		struct io_pgtable_cfg *cfg = &data->iop.cfg;
   640		struct map_state ms;
   641	
   642		/* If no access, then nothing to do */
   643		if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
   644			goto out_err;
   645	
   646		prot = arm_lpae_prot_to_pte(data, iommu_prot);
   647	
   648		min_pagesz = 1 << __ffs(cfg->pgsize_bitmap);
   649	
   650		memset(&ms, 0, sizeof(ms));
   651	
   652		for_each_sg(sg, s, nents, i) {
   653			phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
   654			size_t size = s->length;
   655	
   656			/*
   657			 * We are mapping on IOMMU page boundaries, so offset within
   658			 * the page must be 0. However, the IOMMU may support pages
   659			 * smaller than PAGE_SIZE, so s->offset may still represent
   660			 * an offset of that boundary within the CPU page.
   661			 */
   662			if (!IS_ALIGNED(s->offset, min_pagesz))
   663				goto out_err;
   664	
   665			while (size) {
 > 666				size_t pgsize = iommu_pgsize(
   667					cfg->pgsize_bitmap, iova | phys, size);
   668	
   669				if (ms.pgtable && (iova < ms.iova_end)) {
   670					arm_lpae_iopte *ptep = ms.pgtable +
   671						ARM_LPAE_LVL_IDX(iova, MAP_STATE_LVL,
   672								 data);
   673					arm_lpae_init_pte(
   674						data, iova, phys, prot, MAP_STATE_LVL,
   675						ptep, ms.prev_pgtable, false);
   676					ms.num_pte++;
   677				} else {
   678					ret = __arm_lpae_map(data, iova, phys, pgsize,
   679							prot, lvl, ptep, NULL, &ms);
   680					if (ret)
   681						goto out_err;
   682				}
   683	
   684				iova += pgsize;
   685				mapped += pgsize;
   686				phys += pgsize;
   687				size -= pgsize;
   688			}
   689		}
   690	
   691		if (ms.pgtable)
   692			pgtable_dma_sync_single_for_device(cfg,
   693				__arm_lpae_dma_addr(ms.pte_start),
   694				ms.num_pte * sizeof(*ms.pte_start),
   695				DMA_TO_DEVICE);
   696	
   697		/*
   698		 * Synchronise all PTE updates for the new mapping before there's
   699		 * a chance for anything to kick off a table walk for the new iova.
   700		 */
   701		wmb();
   702	
   703		return mapped;
   704	
   705	out_err:
   706		/* Return the size of the partial mapping so that they can be undone */
   707		*size = mapped;
   708		return ret;
   709	}
   710	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
