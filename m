Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AE155B39F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiFZSmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFZSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:42:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B08DF81
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656268954; x=1687804954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rMeaszjrKJaKVPv7quHFugejmU2376BlRC7md9AciBs=;
  b=G3IQYaKIS0pu5SdWWzZ8VNsGIAxO5JoVUPbwE8powfN62MFnoCD52L3E
   ShTr29o8UErbL30JF3gv2CssZLp8/Naukkfe/DYKYa0QHv3I03w3BZ0j8
   LCIGf6jiuzsXtS+wEFgAZfoQhNnHurPS78C7yiJO3o58gtN8t/8AqAxKi
   aocCgkHd45a6bADNG7MT39YXju/LjU9XoOF6xxQgyEu+R9PSvvTjNwpiO
   +mynO2JZqR4UySet9pZM1Gr/XyFpLy8ysqZhirUe80OkwH7LZZxLWq3Nf
   VzdgQ5rWBeBRg1OxCZ/oc4DkVCe3DzZJKv6C916ujdhdYjyybM7kpLVJf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280062935"
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="280062935"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 11:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="716802943"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2022 11:42:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5XDL-0007im-4O;
        Sun, 26 Jun 2022 18:42:31 +0000
Date:   Mon, 27 Jun 2022 02:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 49/51]
 drivers/misc/habanalabs/gaudi2/gaudi2.c:1784:6: warning: no previous
 prototype for 'gaudi2_host_phys_addr_valid'
Message-ID: <202206270205.CIHw0odK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   07630ebc57c01dece654dea4d238f18a96851cec
commit: e86cc96aba150c067b57bfb623e093086d372403 [49/51] habanalabs: add gaudi2 asic-specific code
config: alpha-randconfig-r012-20220626
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=e86cc96aba150c067b57bfb623e093086d372403
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout e86cc96aba150c067b57bfb623e093086d372403
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/gaudi2/gaudi2.c:1784:6: warning: no previous prototype for 'gaudi2_host_phys_addr_valid' [-Wmissing-prototypes]
    1784 | bool gaudi2_host_phys_addr_valid(u64 addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c: In function 'gaudi2_set_dram_properties':
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:1828:13: warning: variable 'hbm_drv_base_offset' set but not used [-Wunused-but-set-variable]
    1828 |         u64 hbm_drv_base_offset = 0;
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c: At top level:
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:1887:5: warning: no previous prototype for 'gaudi2_set_fixed_properties' [-Wmissing-prototypes]
    1887 | int gaudi2_set_fixed_properties(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2215:5: warning: no previous prototype for 'gaudi2_set_tpc_binning_masks' [-Wmissing-prototypes]
    2215 | int gaudi2_set_tpc_binning_masks(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2273:5: warning: no previous prototype for 'gaudi2_set_dec_binning_masks' [-Wmissing-prototypes]
    2273 | int gaudi2_set_dec_binning_masks(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2395:5: warning: no previous prototype for 'gaudi2_set_cluster_binning_masks_common' [-Wmissing-prototypes]
    2395 | int gaudi2_set_cluster_binning_masks_common(struct hl_device *hdev, u8 xbar_edge_iso_mask)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2622:5: warning: no previous prototype for 'gaudi2_early_fini' [-Wmissing-prototypes]
    2622 | int gaudi2_early_fini(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2744:5: warning: no previous prototype for 'gaudi2_late_init' [-Wmissing-prototypes]
    2744 | int gaudi2_late_init(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2771:6: warning: no previous prototype for 'gaudi2_late_fini' [-Wmissing-prototypes]
    2771 | void gaudi2_late_fini(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2808:6: warning: no previous prototype for 'gaudi2_user_mapped_blocks_init' [-Wmissing-prototypes]
    2808 | void gaudi2_user_mapped_blocks_init(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2915:6: warning: no previous prototype for 'gaudi2_set_pci_memory_regions' [-Wmissing-prototypes]
    2915 | void gaudi2_set_pci_memory_regions(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2948:6: warning: no previous prototype for 'gaudi2_user_interrupt_setup' [-Wmissing-prototypes]
    2948 | void gaudi2_user_interrupt_setup(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2981:5: warning: no previous prototype for 'gaudi2_sw_init' [-Wmissing-prototypes]
    2981 | int gaudi2_sw_init(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3081:5: warning: no previous prototype for 'gaudi2_sw_fini' [-Wmissing-prototypes]
    3081 | int gaudi2_sw_fini(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3161:6: warning: no previous prototype for 'gaudi2_stop_dma_qmans' [-Wmissing-prototypes]
    3161 | void gaudi2_stop_dma_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3194:6: warning: no previous prototype for 'gaudi2_stop_mme_qmans' [-Wmissing-prototypes]
    3194 | void gaudi2_stop_mme_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3209:6: warning: no previous prototype for 'gaudi2_stop_tpc_qmans' [-Wmissing-prototypes]
    3209 | void gaudi2_stop_tpc_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3227:6: warning: no previous prototype for 'gaudi2_stop_rot_qmans' [-Wmissing-prototypes]
    3227 | void gaudi2_stop_rot_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3245:6: warning: no previous prototype for 'gaudi2_stop_nic_qmans' [-Wmissing-prototypes]
    3245 | void gaudi2_stop_nic_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3273:6: warning: no previous prototype for 'gaudi2_dma_stall' [-Wmissing-prototypes]
    3273 | void gaudi2_dma_stall(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3305:6: warning: no previous prototype for 'gaudi2_mme_stall' [-Wmissing-prototypes]
    3305 | void gaudi2_mme_stall(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3317:6: warning: no previous prototype for 'gaudi2_tpc_stall' [-Wmissing-prototypes]
    3317 | void gaudi2_tpc_stall(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3335:6: warning: no previous prototype for 'gaudi2_rotator_stall' [-Wmissing-prototypes]
    3335 | void gaudi2_rotator_stall(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3361:6: warning: no previous prototype for 'gaudi2_disable_dma_qmans' [-Wmissing-prototypes]
    3361 | void gaudi2_disable_dma_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3393:6: warning: no previous prototype for 'gaudi2_disable_mme_qmans' [-Wmissing-prototypes]
    3393 | void gaudi2_disable_mme_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3405:6: warning: no previous prototype for 'gaudi2_disable_tpc_qmans' [-Wmissing-prototypes]
    3405 | void gaudi2_disable_tpc_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3423:6: warning: no previous prototype for 'gaudi2_disable_rot_qmans' [-Wmissing-prototypes]
    3423 | void gaudi2_disable_rot_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3441:6: warning: no previous prototype for 'gaudi2_disable_nic_qmans' [-Wmissing-prototypes]
    3441 | void gaudi2_disable_nic_qmans(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3775:6: warning: no previous prototype for 'gaudi2_stop_dec' [-Wmissing-prototypes]
    3775 | void gaudi2_stop_dec(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3800:6: warning: no previous prototype for 'gaudi2_halt_arcs' [-Wmissing-prototypes]
    3800 | void gaudi2_halt_arcs(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3810:6: warning: no previous prototype for 'gaudi2_reset_arcs' [-Wmissing-prototypes]
    3810 | void gaudi2_reset_arcs(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3823:6: warning: no previous prototype for 'gaudi2_nic_qmans_manual_flush' [-Wmissing-prototypes]
    3823 | void gaudi2_nic_qmans_manual_flush(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3890:5: warning: no previous prototype for 'gaudi2_load_firmware_to_device' [-Wmissing-prototypes]
    3890 | int gaudi2_load_firmware_to_device(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3899:6: warning: no previous prototype for 'gaudi2_init_firmware_loader' [-Wmissing-prototypes]
    3899 | void gaudi2_init_firmware_loader(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3932:5: warning: no previous prototype for 'gaudi2_init_cpu' [-Wmissing-prototypes]
    3932 | int gaudi2_init_cpu(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3952:5: warning: no previous prototype for 'gaudi2_init_cpu_queues' [-Wmissing-prototypes]
    3952 | int gaudi2_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4218:6: warning: no previous prototype for 'gaudi2_init_kdma' [-Wmissing-prototypes]
    4218 | void gaudi2_init_kdma(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4233:6: warning: no previous prototype for 'gaudi2_init_pdma' [-Wmissing-prototypes]
    4233 | void gaudi2_init_pdma(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4270:6: warning: no previous prototype for 'gaudi2_init_edma' [-Wmissing-prototypes]
    4270 | void gaudi2_init_edma(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4293:6: warning: no previous prototype for 'gaudi2_init_sm' [-Wmissing-prototypes]
    4293 | void gaudi2_init_sm(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4393:6: warning: no previous prototype for 'gaudi2_init_mme' [-Wmissing-prototypes]
    4393 | void gaudi2_init_mme(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4444:6: warning: no previous prototype for 'gaudi2_init_tpc' [-Wmissing-prototypes]
    4444 | void gaudi2_init_tpc(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4465:6: warning: no previous prototype for 'gaudi2_init_rotator' [-Wmissing-prototypes]
    4465 | void gaudi2_init_rotator(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4486:6: warning: no previous prototype for 'gaudi2_init_dec' [-Wmissing-prototypes]
    4486 | void gaudi2_init_dec(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4534:6: warning: no previous prototype for 'gaudi2_init_msix_gw_table' [-Wmissing-prototypes]
    4534 | void gaudi2_init_msix_gw_table(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4758:5: warning: no previous prototype for 'gaudi2_mmu_invalidate_cache' [-Wmissing-prototypes]
    4758 | int gaudi2_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:4783:5: warning: no previous prototype for 'gaudi2_mmu_invalidate_cache_range' [-Wmissing-prototypes]
    4783 | int gaudi2_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:5017:5: warning: no previous prototype for 'gaudi2_mmu_init' [-Wmissing-prototypes]
    5017 | int gaudi2_mmu_init(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:5378:5: warning: no previous prototype for 'gaudi2_mmap' [-Wmissing-prototypes]
    5378 | int gaudi2_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
         |     ^~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:5576:6: warning: no previous prototype for 'gaudi2_ring_doorbell' [-Wmissing-prototypes]
    5576 | void gaudi2_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:5607:6: warning: no previous prototype for 'gaudi2_pqe_write' [-Wmissing-prototypes]
    5607 | void gaudi2_pqe_write(struct hl_device *hdev, __le64 *pqe, struct hl_bd *bd)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:5616:7: warning: no previous prototype for 'gaudi2_dma_alloc_coherent' [-Wmissing-prototypes]
    5616 | void *gaudi2_dma_alloc_coherent(struct hl_device *hdev, size_t size,
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:5622:6: warning: no previous prototype for 'gaudi2_dma_free_coherent' [-Wmissing-prototypes]
    5622 | void gaudi2_dma_free_coherent(struct hl_device *hdev, size_t size,


vim +/gaudi2_host_phys_addr_valid +1784 drivers/misc/habanalabs/gaudi2/gaudi2.c

  1783	
> 1784	bool gaudi2_host_phys_addr_valid(u64 addr)
  1785	{
  1786		if ((addr < HOST_PHYS_BASE_0 + HOST_PHYS_SIZE_0) || (addr >= HOST_PHYS_BASE_1))
  1787			return true;
  1788	
  1789		return false;
  1790	}
  1791	
  1792	static int set_number_of_functional_hbms(struct hl_device *hdev)
  1793	{
  1794		struct asic_fixed_properties *prop = &hdev->asic_prop;
  1795		u8 faulty_hbms = hweight64(hdev->dram_binning);
  1796	
  1797		/* check if all HBMs should be used */
  1798		if (!faulty_hbms) {
  1799			dev_dbg(hdev->dev, "All HBM are in use (no binning)\n");
  1800			prop->num_functional_hbms = GAUDI2_HBM_NUM;
  1801			return 0;
  1802		}
  1803	
  1804		/*
  1805		 * check for error condition in which number of binning
  1806		 * candidates is higher than the maximum supported by the
  1807		 * driver (in which case binning mask shall be ignored and driver will
  1808		 * set the default)
  1809		 */
  1810		if (faulty_hbms > MAX_FAULTY_HBMS) {
  1811			dev_err(hdev->dev,
  1812				"HBM binning supports max of %d faulty HBMs, supplied mask 0x%llx.\n",
  1813				MAX_FAULTY_HBMS, hdev->dram_binning);
  1814			return -EINVAL;
  1815		}
  1816	
  1817		/*
  1818		 * by default, number of functional HBMs in Gaudi2 is always
  1819		 * GAUDI2_HBM_NUM - 1.
  1820		 */
  1821		prop->num_functional_hbms = GAUDI2_HBM_NUM - faulty_hbms;
  1822		return 0;
  1823	}
  1824	
  1825	static int gaudi2_set_dram_properties(struct hl_device *hdev)
  1826	{
  1827		struct asic_fixed_properties *prop = &hdev->asic_prop;
> 1828		u64 hbm_drv_base_offset = 0;
  1829		u32 basic_hbm_page_size;
  1830		int rc;
  1831	
  1832		rc = set_number_of_functional_hbms(hdev);
  1833		if (rc)
  1834			return -EINVAL;
  1835	
  1836		/*
  1837		 * Due to HW bug in which TLB size is x16 smaller than expected we use a workaround
  1838		 * in which we are using x16 bigger page size to be able to populate the entire
  1839		 * HBM mappings in the TLB
  1840		 */
  1841		basic_hbm_page_size = prop->num_functional_hbms * SZ_8M;
  1842		prop->dram_page_size = GAUDI2_COMPENSATE_TLB_PAGE_SIZE_FACTOR * basic_hbm_page_size;
  1843		prop->device_mem_alloc_default_page_size = prop->dram_page_size;
  1844		prop->dram_size = prop->num_functional_hbms * SZ_16G;
  1845		prop->dram_base_address = DRAM_PHYS_BASE;
  1846		prop->dram_end_address = prop->dram_base_address + prop->dram_size;
  1847		prop->dram_supports_virtual_memory = true;
  1848	
  1849		/*
  1850		 * Driver can't share an (48MB) HBM page with the F/W in order to prevent FW to block
  1851		 * the driver part by range register, so it must start at the next (48MB) page
  1852		 */
  1853		hbm_drv_base_offset = roundup(CPU_FW_IMAGE_SIZE, basic_hbm_page_size);
  1854	
  1855		prop->dram_user_base_address = DRAM_PHYS_BASE + prop->dram_page_size;
  1856		prop->dram_hints_align_mask = ~GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK;
  1857		prop->hints_dram_reserved_va_range.start_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_START;
  1858		prop->hints_dram_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_END;
  1859	
  1860		/* since DRAM page size differs from dmmu page size we need to allocate
  1861		 * DRAM memory in units of dram_page size and mapping this memory in
  1862		 * units of DMMU page size. we overcome this size mismatch using a
  1863		 * scarmbling routine which takes a DRAM page and converts it to a DMMU
  1864		 * page.
  1865		 * We therefore:
  1866		 * 1. partition the virtual address space to DRAM-page (whole) pages.
  1867		 *    (suppose we get n such pages)
  1868		 * 2. limit the amount of virtual address space we got from 1 above to
  1869		 *    a multiple of 64M as we don't want the scrambled address to cross
  1870		 *    the DRAM virtual address space.
  1871		 *    ( m = (n * DRAM_page_size) / DMMU_page_size).
  1872		 * 3. determine the and address accordingly
  1873		 *    end_addr = start_addr + m * 48M
  1874		 *
  1875		 *    the DRAM address MSBs (63:48) are not part of the roundup calculation
  1876		 */
  1877		prop->dmmu.start_addr = prop->dram_base_address +
  1878				roundup(prop->dram_size, prop->dram_page_size);
  1879	
  1880		prop->dmmu.end_addr = prop->dmmu.start_addr +
  1881				((VA_HBM_SPACE_END - prop->dmmu.start_addr) /
  1882				prop->dmmu.page_size) * prop->dram_page_size;
  1883	
  1884		return 0;
  1885	}
  1886	
> 1887	int gaudi2_set_fixed_properties(struct hl_device *hdev)
  1888	{
  1889		struct asic_fixed_properties *prop = &hdev->asic_prop;
  1890		struct hw_queue_properties *q_props;
  1891		u32 num_sync_stream_queues = 0;
  1892		int i;
  1893	
  1894		prop->max_queues = GAUDI2_QUEUE_ID_SIZE;
  1895		prop->hw_queues_props = kcalloc(prop->max_queues, sizeof(struct hw_queue_properties),
  1896						GFP_KERNEL);
  1897	
  1898		if (!prop->hw_queues_props)
  1899			return -ENOMEM;
  1900	
  1901		q_props = prop->hw_queues_props;
  1902	
  1903		for (i = 0 ; i < GAUDI2_QUEUE_ID_CPU_PQ ; i++) {
  1904			q_props[i].type = QUEUE_TYPE_HW;
  1905			q_props[i].driver_only = 0;
  1906	
  1907			if (i >= GAUDI2_QUEUE_ID_NIC_0_0 && i <= GAUDI2_QUEUE_ID_NIC_23_3) {
  1908				q_props[i].supports_sync_stream = 0;
  1909			} else {
  1910				q_props[i].supports_sync_stream = 1;
  1911				num_sync_stream_queues++;
  1912			}
  1913	
  1914			q_props[i].cb_alloc_flags = CB_ALLOC_USER;
  1915		}
  1916	
  1917		q_props[GAUDI2_QUEUE_ID_CPU_PQ].type = QUEUE_TYPE_CPU;
  1918		q_props[GAUDI2_QUEUE_ID_CPU_PQ].driver_only = 1;
  1919		q_props[GAUDI2_QUEUE_ID_CPU_PQ].cb_alloc_flags = CB_ALLOC_KERNEL;
  1920	
  1921		prop->cache_line_size = DEVICE_CACHE_LINE_SIZE;
  1922		prop->cfg_base_address = CFG_BASE;
  1923		prop->device_dma_offset_for_host_access = HOST_PHYS_BASE_0;
  1924		prop->host_base_address = HOST_PHYS_BASE_0;
  1925		prop->host_end_address = prop->host_base_address + HOST_PHYS_SIZE_0;
  1926		prop->max_pending_cs = GAUDI2_MAX_PENDING_CS;
  1927		prop->completion_queues_count = GAUDI2_RESERVED_CQ_NUMBER;
  1928		prop->user_dec_intr_count = NUMBER_OF_DEC;
  1929		prop->user_interrupt_count = GAUDI2_IRQ_NUM_USER_LAST - GAUDI2_IRQ_NUM_USER_FIRST + 1;
  1930		prop->completion_mode = HL_COMPLETION_MODE_CS;
  1931		prop->sync_stream_first_sob = GAUDI2_RESERVED_SOBS;
  1932		prop->sync_stream_first_mon = GAUDI2_RESERVED_MONITORS;
  1933	
  1934		prop->sram_base_address = SRAM_BASE_ADDR;
  1935		prop->sram_size = SRAM_SIZE;
  1936		prop->sram_end_address = prop->sram_base_address + prop->sram_size;
  1937		prop->sram_user_base_address = prop->sram_base_address + SRAM_USER_BASE_OFFSET;
  1938	
  1939		prop->hints_range_reservation = true;
  1940	
  1941		if (hdev->pldm)
  1942			prop->mmu_pgt_size = 0x800000; /* 8MB */
  1943		else
  1944			prop->mmu_pgt_size = MMU_PAGE_TABLES_INITIAL_SIZE;
  1945	
  1946		prop->mmu_pte_size = HL_PTE_SIZE;
  1947		prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
  1948		prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
  1949	
  1950		prop->dmmu.hop_shifts[MMU_HOP0] = DHOP0_SHIFT;
  1951		prop->dmmu.hop_shifts[MMU_HOP1] = DHOP1_SHIFT;
  1952		prop->dmmu.hop_shifts[MMU_HOP2] = DHOP2_SHIFT;
  1953		prop->dmmu.hop_shifts[MMU_HOP3] = DHOP3_SHIFT;
  1954		prop->dmmu.hop_shifts[MMU_HOP4] = DHOP4_SHIFT;
  1955		prop->dmmu.hop_masks[MMU_HOP0] = DHOP0_MASK;
  1956		prop->dmmu.hop_masks[MMU_HOP1] = DHOP1_MASK;
  1957		prop->dmmu.hop_masks[MMU_HOP2] = DHOP2_MASK;
  1958		prop->dmmu.hop_masks[MMU_HOP3] = DHOP3_MASK;
  1959		prop->dmmu.hop_masks[MMU_HOP4] = DHOP4_MASK;
  1960		prop->dmmu.page_size = PAGE_SIZE_1GB;
  1961		prop->dmmu.num_hops = MMU_ARCH_6_HOPS;
  1962		prop->dmmu.last_mask = LAST_MASK;
  1963		prop->dmmu.host_resident = 1;
  1964		/* TODO: will be duplicated until implementing per-MMU props */
  1965		prop->dmmu.hop_table_size = prop->mmu_hop_table_size;
  1966		prop->dmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
  1967	
  1968		/*
  1969		 * this is done in order to be able to validate FW descriptor (i.e. validating that
  1970		 * the addresses and allocated space for FW image does not cross memory bounds).
  1971		 * for this reason we set the DRAM size to the minimum possible and later it will
  1972		 * be modified according to what reported in the cpucp info packet
  1973		 */
  1974		prop->dram_size = (GAUDI2_HBM_NUM - 1) * SZ_16G;
  1975	
  1976		hdev->pmmu_huge_range = true;
  1977		prop->pmmu.host_resident = 1;
  1978		prop->pmmu.num_hops = MMU_ARCH_6_HOPS;
  1979		prop->pmmu.last_mask = LAST_MASK;
  1980		/* TODO: will be duplicated until implementing per-MMU props */
  1981		prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
  1982		prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
  1983	
  1984		prop->hints_host_reserved_va_range.start_addr =	RESERVED_VA_RANGE_FOR_ARC_ON_HOST_START;
  1985		prop->hints_host_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HOST_END;
  1986		prop->hints_host_hpage_reserved_va_range.start_addr =
  1987				RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_START;
  1988		prop->hints_host_hpage_reserved_va_range.end_addr =
  1989				RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_END;
  1990	
  1991		if (PAGE_SIZE == SZ_64K) {
  1992			prop->pmmu.hop_shifts[MMU_HOP0] = HOP0_SHIFT_64K;
  1993			prop->pmmu.hop_shifts[MMU_HOP1] = HOP1_SHIFT_64K;
  1994			prop->pmmu.hop_shifts[MMU_HOP2] = HOP2_SHIFT_64K;
  1995			prop->pmmu.hop_shifts[MMU_HOP3] = HOP3_SHIFT_64K;
  1996			prop->pmmu.hop_shifts[MMU_HOP4] = HOP4_SHIFT_64K;
  1997			prop->pmmu.hop_shifts[MMU_HOP5] = HOP5_SHIFT_64K;
  1998			prop->pmmu.hop_masks[MMU_HOP0] = HOP0_MASK_64K;
  1999			prop->pmmu.hop_masks[MMU_HOP1] = HOP1_MASK_64K;
  2000			prop->pmmu.hop_masks[MMU_HOP2] = HOP2_MASK_64K;
  2001			prop->pmmu.hop_masks[MMU_HOP3] = HOP3_MASK_64K;
  2002			prop->pmmu.hop_masks[MMU_HOP4] = HOP4_MASK_64K;
  2003			prop->pmmu.hop_masks[MMU_HOP5] = HOP5_MASK_64K;
  2004			prop->pmmu.start_addr = VA_HOST_SPACE_PAGE_START;
  2005			prop->pmmu.end_addr = VA_HOST_SPACE_PAGE_END;
  2006			prop->pmmu.page_size = PAGE_SIZE_64KB;
  2007	
  2008			/* shifts and masks are the same in PMMU and HPMMU */
  2009			memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
  2010			prop->pmmu_huge.page_size = PAGE_SIZE_16MB;
  2011			prop->pmmu_huge.start_addr = VA_HOST_SPACE_HPAGE_START;
  2012			prop->pmmu_huge.end_addr = VA_HOST_SPACE_HPAGE_END;
  2013		} else {
  2014			prop->pmmu.hop_shifts[MMU_HOP0] = HOP0_SHIFT_4K;
  2015			prop->pmmu.hop_shifts[MMU_HOP1] = HOP1_SHIFT_4K;
  2016			prop->pmmu.hop_shifts[MMU_HOP2] = HOP2_SHIFT_4K;
  2017			prop->pmmu.hop_shifts[MMU_HOP3] = HOP3_SHIFT_4K;
  2018			prop->pmmu.hop_shifts[MMU_HOP4] = HOP4_SHIFT_4K;
  2019			prop->pmmu.hop_shifts[MMU_HOP5] = HOP5_SHIFT_4K;
  2020			prop->pmmu.hop_masks[MMU_HOP0] = HOP0_MASK_4K;
  2021			prop->pmmu.hop_masks[MMU_HOP1] = HOP1_MASK_4K;
  2022			prop->pmmu.hop_masks[MMU_HOP2] = HOP2_MASK_4K;
  2023			prop->pmmu.hop_masks[MMU_HOP3] = HOP3_MASK_4K;
  2024			prop->pmmu.hop_masks[MMU_HOP4] = HOP4_MASK_4K;
  2025			prop->pmmu.hop_masks[MMU_HOP5] = HOP5_MASK_4K;
  2026			prop->pmmu.start_addr = VA_HOST_SPACE_PAGE_START;
  2027			prop->pmmu.end_addr = VA_HOST_SPACE_PAGE_END;
  2028			prop->pmmu.page_size = PAGE_SIZE_4KB;
  2029	
  2030			/* shifts and masks are the same in PMMU and HPMMU */
  2031			memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
  2032			prop->pmmu_huge.page_size = PAGE_SIZE_2MB;
  2033			prop->pmmu_huge.start_addr = VA_HOST_SPACE_HPAGE_START;
  2034			prop->pmmu_huge.end_addr = VA_HOST_SPACE_HPAGE_END;
  2035		}
  2036	
  2037		prop->cfg_size = CFG_SIZE;
  2038		prop->max_asid = MAX_ASID;
  2039		prop->num_of_events = GAUDI2_EVENT_SIZE;
  2040	
  2041		prop->dc_power_default = DC_POWER_DEFAULT;
  2042	
  2043		prop->cb_pool_cb_cnt = GAUDI2_CB_POOL_CB_CNT;
  2044		prop->cb_pool_cb_size = GAUDI2_CB_POOL_CB_SIZE;
  2045		prop->pcie_dbi_base_address = CFG_BASE + mmPCIE_DBI_BASE;
  2046		prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
  2047	
  2048		strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
  2049	
  2050		prop->mme_master_slave_mode = 1;
  2051	
  2052		prop->first_available_user_sob[0] = GAUDI2_RESERVED_SOBS +
  2053						(num_sync_stream_queues * HL_RSVD_SOBS);
  2054	
  2055		prop->first_available_user_mon[0] = GAUDI2_RESERVED_MONITORS +
  2056						(num_sync_stream_queues * HL_RSVD_MONS);
  2057	
  2058		prop->first_available_user_interrupt = GAUDI2_IRQ_NUM_USER_FIRST;
  2059	
  2060		prop->first_available_cq[0] = GAUDI2_RESERVED_CQ_NUMBER;
  2061	
  2062		prop->fw_cpu_boot_dev_sts0_valid = false;
  2063		prop->fw_cpu_boot_dev_sts1_valid = false;
  2064		prop->hard_reset_done_by_fw = false;
  2065		prop->gic_interrupts_enable = true;
  2066	
  2067		prop->server_type = HL_SERVER_TYPE_UNKNOWN;
  2068	
  2069		prop->cb_va_start_addr = VA_HOST_SPACE_USER_MAPPED_CB_START;
  2070		prop->cb_va_end_addr = VA_HOST_SPACE_USER_MAPPED_CB_END;
  2071	
  2072		prop->max_dec = NUMBER_OF_DEC;
  2073	
  2074		prop->clk_pll_index = HL_GAUDI2_MME_PLL;
  2075	
  2076		prop->dma_mask = 64;
  2077	
  2078		return 0;
  2079	}
  2080	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
