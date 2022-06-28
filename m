Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44455DA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbiF1Id2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbiF1IdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:33:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9672B25E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405198; x=1687941198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1v8Gpbm1c7T1z+eaHvi0kry3YBGC4Ducql/yn6DtDIA=;
  b=BDwPiz34Kj76W/LgtArNZBxuN9QYkkF5/4XGSthqak6bWRC5IBlyPcCb
   UhnQtbobY/WKZlogFyNnkblwv8A2PKPEz/MZt2nwWv8QWQY1rL3JhJy2f
   tVEH4TLQuyAfV6I3dRvNiTF8blOR8U17Wr+gqNBkqLeCyjl384+h8MZYm
   YRaHVEu7lcuFsEr778yH9EuuRC0R4rGwCjwYjHQrUe5KPyojwod2MhT0B
   AyqSzmiMdWUuU0J946WSaYD++LYbeSbhZsUYdKtAep22CKW743JdeMwuO
   AgsVnNqLtjb+z23472d+K1//kaSXWEUJ2w0AqyKZgobY3oqXNdkxNuYaC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282411025"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282411025"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="693006586"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 01:33:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o66eq-0009lO-0F;
        Tue, 28 Jun 2022 08:33:16 +0000
Date:   Tue, 28 Jun 2022 16:32:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moti Haimovski <mhaimovski@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:gaudi2 59/61]
 drivers/misc/habanalabs/common/mmu/mmu.c:874:73: error: passing argument 3
 of 'hl_asic_dma_alloc_coherent' from incompatible pointer type
Message-ID: <202206281635.B4gHvlZ7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   a76819ab38942fcb341142a55e9dc81f3eaf08e3
commit: 950d1a3888fe751fb5b2e51a44ebf89d963fdde5 [59/61] habanalabs: add gaudi2 MMU support
config: csky-randconfig-r001-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281635.B4gHvlZ7-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=950d1a3888fe751fb5b2e51a44ebf89d963fdde5
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout 950d1a3888fe751fb5b2e51a44ebf89d963fdde5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/misc/habanalabs/common/mmu/mmu.c: In function 'hl_mmu_hr_init':
>> drivers/misc/habanalabs/common/mmu/mmu.c:874:73: error: passing argument 3 of 'hl_asic_dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
     874 |                                                                         &phys_addr,
         |                                                                         ^~~~~~~~~~
         |                                                                         |
         |                                                                         u64 * {aka long long unsigned int *}
   In file included from drivers/misc/habanalabs/common/mmu/mmu.c:10:
   drivers/misc/habanalabs/common/mmu/../habanalabs.h:3334:83: note: expected 'dma_addr_t *' {aka 'unsigned int *'} but argument is of type 'u64 *' {aka 'long long unsigned int *'}
    3334 | void *hl_asic_dma_alloc_coherent(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
         |                                                                       ~~~~~~~~~~~~^~~~~~~~~~
>> drivers/misc/habanalabs/common/mmu/mmu.c:896:73: error: passing argument 3 of 'gen_pool_dma_zalloc_align' from incompatible pointer type [-Werror=incompatible-pointer-types]
     896 |                                                                         &hop0_pgt->phys_addr,
         |                                                                         ^~~~~~~~~~~~~~~~~~~~
         |                                                                         |
         |                                                                         u64 * {aka long long unsigned int *}
   In file included from drivers/misc/habanalabs/common/mmu/../habanalabs.h:26,
                    from drivers/misc/habanalabs/common/mmu/mmu.c:10:
   include/linux/genalloc.h:166:29: note: expected 'dma_addr_t *' {aka 'unsigned int *'} but argument is of type 'u64 *' {aka 'long long unsigned int *'}
     166 |                 dma_addr_t *dma, int align);
         |                 ~~~~~~~~~~~~^~~
   drivers/misc/habanalabs/common/mmu/mmu.c: In function 'hl_mmu_hr_write_pte':
>> drivers/misc/habanalabs/common/mmu/mmu.c:998:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     998 |         *(u64 *) virt_addr = val;
         |          ^
   {standard input}: Assembler messages:
>> {standard input}:1916: Error: The instruction is not recognized.
   cc1: some warnings being treated as errors


vim +/hl_asic_dma_alloc_coherent +874 drivers/misc/habanalabs/common/mmu/mmu.c

   830	
   831	/**
   832	 * hl_mmu_hr_init() - initialize the MMU module.
   833	 * @hdev: habanalabs device structure.
   834	 * @hr_priv: MMU HR private data.
   835	 * @hop_table_size: HOP table size.
   836	 * @pgt_size: memory size allocated for the page table
   837	 *
   838	 * @return 0 on success otherwise non-zero error code
   839	 *
   840	 * This function does the following:
   841	 * - Create a pool of pages for pgt_infos.
   842	 * - Create a shadow table for pgt
   843	 */
   844	int hl_mmu_hr_init(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv, u32 hop_table_size,
   845				u64 pgt_size)
   846	{
   847		struct asic_fixed_properties *prop = &hdev->asic_prop;
   848		size_t pool_chunk_size = SZ_4M;
   849		struct pgt_info *hop0_pgt;
   850		u64 virt_addr, phys_addr;
   851		int i, rc;
   852	
   853		/*
   854		 * we set alloc size as PAGE_SIZE (sine dma_alloc_coherent allocation order/size is
   855		 * PAGE_SHIFT/PAGE_SIZE) in order to be able to control the allocations alignment.
   856		 * This way we can call "DMA alloc align" according to dma_alloc granularity and supply
   857		 * allocations with higher-order alignment restrictions
   858		 */
   859		hr_priv->mmu_pgt_pool = gen_pool_create(PAGE_SHIFT, -1);
   860		if (ZERO_OR_NULL_PTR(hr_priv->mmu_pgt_pool)) {
   861			dev_err(hdev->dev, "Failed to create hr page pool\n");
   862			return -ENOMEM;
   863		}
   864	
   865		hr_priv->mmu_asid_hop0 = kvcalloc(prop->max_asid, sizeof(struct pgt_info), GFP_KERNEL);
   866		if (ZERO_OR_NULL_PTR(hr_priv->mmu_asid_hop0)) {
   867			dev_err(hdev->dev, "Failed to allocate hr-mmu hop0 table\n");
   868			rc = -ENOMEM;
   869			goto destroy_mmu_pgt_pool;
   870		}
   871	
   872		for (i = 0 ; i < pgt_size ; i += pool_chunk_size) {
   873			virt_addr = (uintptr_t) hl_asic_dma_alloc_coherent(hdev, pool_chunk_size,
 > 874										&phys_addr,
   875										GFP_KERNEL | __GFP_ZERO);
   876			if (ZERO_OR_NULL_PTR(virt_addr)) {
   877				dev_err(hdev->dev,
   878					"Failed to allocate memory for host-resident page pool\n");
   879				rc = -ENOMEM;
   880				goto destroy_mmu_pgt_pool;
   881			}
   882	
   883			rc = gen_pool_add_virt(hr_priv->mmu_pgt_pool, virt_addr, phys_addr,
   884							pool_chunk_size, -1);
   885			if (rc) {
   886				dev_err(hdev->dev, "Failed to fill host-resident page pool\n");
   887				goto destroy_mmu_pgt_pool;
   888			}
   889		}
   890	
   891		for (i = 0 ; i < prop->max_asid ; i++) {
   892			hop0_pgt = &hr_priv->mmu_asid_hop0[i];
   893			hop0_pgt->virt_addr = (uintptr_t)
   894						gen_pool_dma_zalloc_align(hr_priv->mmu_pgt_pool,
   895										hop_table_size,
 > 896										&hop0_pgt->phys_addr,
   897										hop_table_size);
   898			if (!hop0_pgt->virt_addr) {
   899				dev_err(hdev->dev, "Failed to allocate HOP from pgt pool\n");
   900				rc = -ENOMEM;
   901				goto destroy_mmu_pgt_pool;
   902			}
   903		}
   904	
   905		/* MMU H/W init will be done in device hw_init() */
   906	
   907		return 0;
   908	
   909	destroy_mmu_pgt_pool:
   910		hl_mmu_hr_pool_destroy(hdev, hr_priv, hop_table_size);
   911		if (!ZERO_OR_NULL_PTR(hr_priv->mmu_asid_hop0))
   912			kvfree(hr_priv->mmu_asid_hop0);
   913	
   914		return rc;
   915	}
   916	
   917	/**
   918	 * hl_mmu_hr_fini() - release the MMU module.
   919	 * @hdev: habanalabs device structure.
   920	 * @hr_priv: MMU host resident private info.
   921	 * @hop_table_size: HOP table size
   922	 *
   923	 * This function does the following:
   924	 * - Disable MMU in H/W.
   925	 * - Free the pgt_infos pool.
   926	 *
   927	 * All contexts should be freed before calling this function.
   928	 */
   929	void hl_mmu_hr_fini(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv, u32 hop_table_size)
   930	{
   931		/* MMU H/W fini was already done in device hw_fini() */
   932	
   933		hl_mmu_hr_pool_destroy(hdev, hr_priv, hop_table_size);
   934	
   935		if (!ZERO_OR_NULL_PTR(hr_priv->mmu_asid_hop0)) {
   936			kvfree(hr_priv->mmu_asid_hop0);
   937	
   938			/* Make sure that if we arrive here again without init was
   939			 * called we won't cause kernel panic. This can happen for
   940			 * example if we fail during hard reset code at certain points
   941			 */
   942			hr_priv->mmu_asid_hop0 = NULL;
   943		}
   944	}
   945	
   946	/**
   947	 * hl_mmu_hr_free_hop_remove_pgt() - free HOP and remove PGT from hash
   948	 * @pgt_info: page table info structure.
   949	 * @hr_priv: MMU HR private data.
   950	 * @hop_table_size: HOP table size.
   951	 */
   952	void hl_mmu_hr_free_hop_remove_pgt(struct pgt_info *pgt_info, struct hl_mmu_hr_priv *hr_priv,
   953						u32 hop_table_size)
   954	{
   955		gen_pool_free(hr_priv->mmu_pgt_pool, pgt_info->virt_addr, hop_table_size);
   956		hash_del(&pgt_info->node);
   957		kfree(pgt_info);
   958	}
   959	
   960	/**
   961	 * hl_mmu_hr_pte_phys_to_virt() - translate PTE phys addr to virt addr
   962	 * @ctx: pointer to the context structure
   963	 * @pgt: pgt_info for the HOP hosting the PTE
   964	 * @phys_pte_addr: phys address of the PTE
   965	 * @hop_table_size: HOP table size
   966	 *
   967	 * @return PTE virtual address
   968	 *
   969	 * The function use the pgt_info to get HOP base virt addr and obtain the PTE's virt addr
   970	 * by adding the PTE offset.
   971	 */
   972	u64 hl_mmu_hr_pte_phys_to_virt(struct hl_ctx *ctx, struct pgt_info *pgt,
   973								u64 phys_pte_addr, u32 hop_table_size)
   974	{
   975		u64 page_mask = (hop_table_size - 1);
   976		u64 pte_offset = phys_pte_addr & page_mask;
   977	
   978		return pgt->virt_addr + pte_offset;
   979	}
   980	
   981	/**
   982	 * hl_mmu_hr_write_pte() - write HR PTE
   983	 * @ctx: pointer to the context structure
   984	 * @pgt_info: HOP's page table info structure
   985	 * @phys_pte_addr: phys PTE address
   986	 * @val: raw PTE data
   987	 * @hop_table_size: HOP table size
   988	 */
   989	void hl_mmu_hr_write_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, u64 phys_pte_addr,
   990									u64 val, u32 hop_table_size)
   991	{
   992		/*
   993		 * The value to write is the phys address of the next hop +
   994		 * flags at the 12 LSBs.
   995		 */
   996		u64 virt_addr = hl_mmu_hr_pte_phys_to_virt(ctx, pgt_info, phys_pte_addr, hop_table_size);
   997	
 > 998		*(u64 *) virt_addr = val;
   999	}
  1000	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
