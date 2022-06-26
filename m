Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2F55B398
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFZSck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFZScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:32:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415DDFFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656268353; x=1687804353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zpqQ44uxqKzfNBqTwId7NHSA7IghV7QUBRzY7xbwF/g=;
  b=MXGW/bgTZwvAHa4hINpUkn41TxMnBEKlZbRgsu7vGB+7UXaSA+9pUsgO
   BRO1h2/mmeMdArI17/t2tk8BYmB5Ed1H88/LxJu5skL5mDhucnbgfhqqB
   ZXWyRPxRcmGKdzzWF4/jgrV//ailza4f1QmLTg/eHCR4cUWDMlH1o5ToG
   qhUiYaM99QBmUG9JDNJRXSEZjEsuFjuPwmWrI0SD9w9yvKzJCR4RxuLDg
   34SWqCFZtZwDG+Dfw0myUxDrRv06ygbHMamxtRmB2XTMrPXZ/xptxdqX7
   HeYE4ablpPYxqX91gRrvJDkg1W0xmPn1iNLBYhy64AEVVBxKf/Xi3RYUU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="270043109"
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="270043109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 11:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="916407506"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2022 11:32:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5X3e-0007iC-O1;
        Sun, 26 Jun 2022 18:32:30 +0000
Date:   Mon, 27 Jun 2022 02:31:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 49/51]
 drivers/misc/habanalabs/gaudi2/gaudi2.c:5809:13: error: call to
 __compiletime_assert_452 declared with 'error' attribute: FIELD_PREP: value
 too large for the field
Message-ID: <202206270228.6gLRl4Bt-lkp@intel.com>
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
head:   07630ebc57c01dece654dea4d238f18a96851cec
commit: e86cc96aba150c067b57bfb623e093086d372403 [49/51] habanalabs: add gaudi2 asic-specific code
config: x86_64-randconfig-a005
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=e86cc96aba150c067b57bfb623e093086d372403
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout e86cc96aba150c067b57bfb623e093086d372403
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/gaudi2/gaudi2.c:1784:6: warning: no previous prototype for function 'gaudi2_host_phys_addr_valid' [-Wmissing-prototypes]
   bool gaudi2_host_phys_addr_valid(u64 addr)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:1784:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool gaudi2_host_phys_addr_valid(u64 addr)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:1828:6: warning: variable 'hbm_drv_base_offset' set but not used [-Wunused-but-set-variable]
           u64 hbm_drv_base_offset = 0;
               ^
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:1887:5: warning: no previous prototype for function 'gaudi2_set_fixed_properties' [-Wmissing-prototypes]
   int gaudi2_set_fixed_properties(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:1887:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_set_fixed_properties(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2215:5: warning: no previous prototype for function 'gaudi2_set_tpc_binning_masks' [-Wmissing-prototypes]
   int gaudi2_set_tpc_binning_masks(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2215:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_set_tpc_binning_masks(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2273:5: warning: no previous prototype for function 'gaudi2_set_dec_binning_masks' [-Wmissing-prototypes]
   int gaudi2_set_dec_binning_masks(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2273:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_set_dec_binning_masks(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2395:5: warning: no previous prototype for function 'gaudi2_set_cluster_binning_masks_common' [-Wmissing-prototypes]
   int gaudi2_set_cluster_binning_masks_common(struct hl_device *hdev, u8 xbar_edge_iso_mask)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2395:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_set_cluster_binning_masks_common(struct hl_device *hdev, u8 xbar_edge_iso_mask)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2622:5: warning: no previous prototype for function 'gaudi2_early_fini' [-Wmissing-prototypes]
   int gaudi2_early_fini(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2622:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_early_fini(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2744:5: warning: no previous prototype for function 'gaudi2_late_init' [-Wmissing-prototypes]
   int gaudi2_late_init(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2744:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_late_init(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2771:6: warning: no previous prototype for function 'gaudi2_late_fini' [-Wmissing-prototypes]
   void gaudi2_late_fini(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2771:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_late_fini(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2808:6: warning: no previous prototype for function 'gaudi2_user_mapped_blocks_init' [-Wmissing-prototypes]
   void gaudi2_user_mapped_blocks_init(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2808:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_user_mapped_blocks_init(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2915:6: warning: no previous prototype for function 'gaudi2_set_pci_memory_regions' [-Wmissing-prototypes]
   void gaudi2_set_pci_memory_regions(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2915:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_set_pci_memory_regions(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2948:6: warning: no previous prototype for function 'gaudi2_user_interrupt_setup' [-Wmissing-prototypes]
   void gaudi2_user_interrupt_setup(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2948:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_user_interrupt_setup(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:2981:5: warning: no previous prototype for function 'gaudi2_sw_init' [-Wmissing-prototypes]
   int gaudi2_sw_init(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:2981:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_sw_init(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3081:5: warning: no previous prototype for function 'gaudi2_sw_fini' [-Wmissing-prototypes]
   int gaudi2_sw_fini(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3081:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_sw_fini(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3161:6: warning: no previous prototype for function 'gaudi2_stop_dma_qmans' [-Wmissing-prototypes]
   void gaudi2_stop_dma_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3161:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_stop_dma_qmans(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3194:6: warning: no previous prototype for function 'gaudi2_stop_mme_qmans' [-Wmissing-prototypes]
   void gaudi2_stop_mme_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3194:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_stop_mme_qmans(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3209:6: warning: no previous prototype for function 'gaudi2_stop_tpc_qmans' [-Wmissing-prototypes]
   void gaudi2_stop_tpc_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3209:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_stop_tpc_qmans(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3227:6: warning: no previous prototype for function 'gaudi2_stop_rot_qmans' [-Wmissing-prototypes]
   void gaudi2_stop_rot_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3227:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_stop_rot_qmans(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3245:6: warning: no previous prototype for function 'gaudi2_stop_nic_qmans' [-Wmissing-prototypes]
   void gaudi2_stop_nic_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_stop_nic_qmans(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3273:6: warning: no previous prototype for function 'gaudi2_dma_stall' [-Wmissing-prototypes]
   void gaudi2_dma_stall(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3273:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_dma_stall(struct hl_device *hdev)
   ^
   static 
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3305:6: warning: no previous prototype for function 'gaudi2_mme_stall' [-Wmissing-prototypes]
   void gaudi2_mme_stall(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3305:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_mme_stall(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3317:6: warning: no previous prototype for function 'gaudi2_tpc_stall' [-Wmissing-prototypes]
   void gaudi2_tpc_stall(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3317:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_tpc_stall(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3335:6: warning: no previous prototype for function 'gaudi2_rotator_stall' [-Wmissing-prototypes]
   void gaudi2_rotator_stall(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3335:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_rotator_stall(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3361:6: warning: no previous prototype for function 'gaudi2_disable_dma_qmans' [-Wmissing-prototypes]
   void gaudi2_disable_dma_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3361:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_disable_dma_qmans(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3393:6: warning: no previous prototype for function 'gaudi2_disable_mme_qmans' [-Wmissing-prototypes]
   void gaudi2_disable_mme_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3393:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_disable_mme_qmans(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3405:6: warning: no previous prototype for function 'gaudi2_disable_tpc_qmans' [-Wmissing-prototypes]
   void gaudi2_disable_tpc_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3405:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_disable_tpc_qmans(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3423:6: warning: no previous prototype for function 'gaudi2_disable_rot_qmans' [-Wmissing-prototypes]
   void gaudi2_disable_rot_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3423:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_disable_rot_qmans(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3441:6: warning: no previous prototype for function 'gaudi2_disable_nic_qmans' [-Wmissing-prototypes]
   void gaudi2_disable_nic_qmans(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3441:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_disable_nic_qmans(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3775:6: warning: no previous prototype for function 'gaudi2_stop_dec' [-Wmissing-prototypes]
   void gaudi2_stop_dec(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3775:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_stop_dec(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3800:6: warning: no previous prototype for function 'gaudi2_halt_arcs' [-Wmissing-prototypes]
   void gaudi2_halt_arcs(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3800:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_halt_arcs(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3810:6: warning: no previous prototype for function 'gaudi2_reset_arcs' [-Wmissing-prototypes]
   void gaudi2_reset_arcs(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3810:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_reset_arcs(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3823:6: warning: no previous prototype for function 'gaudi2_nic_qmans_manual_flush' [-Wmissing-prototypes]
   void gaudi2_nic_qmans_manual_flush(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3823:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_nic_qmans_manual_flush(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3890:5: warning: no previous prototype for function 'gaudi2_load_firmware_to_device' [-Wmissing-prototypes]
   int gaudi2_load_firmware_to_device(struct hl_device *hdev)
       ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3890:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi2_load_firmware_to_device(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3899:6: warning: no previous prototype for function 'gaudi2_init_firmware_loader' [-Wmissing-prototypes]
   void gaudi2_init_firmware_loader(struct hl_device *hdev)
        ^
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3899:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gaudi2_init_firmware_loader(struct hl_device *hdev)
   ^
   static 
   drivers/misc/habanalabs/gaudi2/gaudi2.c:3932:5: warning: no previous prototype for function 'gaudi2_init_cpu' [-Wmissing-prototypes]
   int gaudi2_init_cpu(struct hl_device *hdev)
       ^


vim +/error +5809 drivers/misc/habanalabs/gaudi2/gaudi2.c

  5615	
> 5616	void *gaudi2_dma_alloc_coherent(struct hl_device *hdev, size_t size,
  5617					dma_addr_t *dma_handle, gfp_t flags)
  5618	{
  5619		return dma_alloc_coherent(&hdev->pdev->dev, size, dma_handle, flags);
  5620	}
  5621	
> 5622	void gaudi2_dma_free_coherent(struct hl_device *hdev, size_t size,
  5623					void *cpu_addr, dma_addr_t dma_handle)
  5624	{
  5625		dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
  5626	}
  5627	
> 5628	int gaudi2_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
  5629					u32 timeout, u64 *result)
  5630	{
  5631		struct gaudi2_device *gaudi2 = hdev->asic_specific;
  5632	
  5633		if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q)) {
  5634			if (result)
  5635				*result = 0;
  5636			return 0;
  5637		}
  5638	
  5639		if (!timeout)
  5640			timeout = GAUDI2_MSG_TO_CPU_TIMEOUT_USEC;
  5641	
  5642		return hl_fw_send_cpu_message(hdev, GAUDI2_QUEUE_ID_CPU_PQ, msg, len, timeout, result);
  5643	}
  5644	
> 5645	void *gaudi2_dma_pool_zalloc(struct hl_device *hdev, size_t size,
  5646					gfp_t mem_flags, dma_addr_t *dma_handle)
  5647	{
  5648		if (size > GAUDI2_DMA_POOL_BLK_SIZE)
  5649			return NULL;
  5650	
  5651		return dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
  5652	}
  5653	
> 5654	void gaudi2_dma_pool_free(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr)
  5655	{
  5656		dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
  5657	}
  5658	
> 5659	void *gaudi2_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
  5660							dma_addr_t *dma_handle)
  5661	{
  5662		return hl_fw_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
  5663	}
  5664	
> 5665	void gaudi2_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size, void *vaddr)
  5666	{
  5667		hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
  5668	}
  5669	
  5670	static dma_addr_t gaudi2_dma_map_single(struct hl_device *hdev, void *addr, int len,
  5671						enum dma_data_direction dir)
  5672	{
  5673		dma_addr_t dma_addr;
  5674	
  5675		dma_addr = dma_map_single(&hdev->pdev->dev, addr, len, dir);
  5676		if (unlikely(dma_mapping_error(&hdev->pdev->dev, dma_addr)))
  5677			return 0;
  5678	
  5679		return dma_addr;
  5680	}
  5681	
  5682	static void gaudi2_dma_unmap_single(struct hl_device *hdev, dma_addr_t addr, int len,
  5683						enum dma_data_direction dir)
  5684	{
  5685		dma_unmap_single(&hdev->pdev->dev, addr, len, dir);
  5686	}
  5687	
  5688	static int gaudi2_validate_cb_address(struct hl_device *hdev, struct hl_cs_parser *parser)
  5689	{
  5690		struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
  5691		struct gaudi2_device *gaudi2 = hdev->asic_specific;
  5692	
  5693		if (!gaudi2_is_queue_enabled(hdev, parser->hw_queue_id)) {
  5694			dev_err(hdev->dev, "h/w queue %d is disabled\n", parser->hw_queue_id);
  5695			return -EINVAL;
  5696		}
  5697	
  5698		/* Just check if CB address is valid */
  5699	
  5700		if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
  5701						parser->user_cb_size,
  5702						asic_prop->sram_user_base_address,
  5703						asic_prop->sram_end_address))
  5704			return 0;
  5705	
  5706		if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
  5707						parser->user_cb_size,
  5708						asic_prop->dram_user_base_address,
  5709						asic_prop->dram_end_address))
  5710			return 0;
  5711	
  5712		if ((gaudi2->hw_cap_initialized & HW_CAP_DMMU_MASK) &&
  5713			hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
  5714							parser->user_cb_size,
  5715							asic_prop->dmmu.start_addr,
  5716							asic_prop->dmmu.end_addr))
  5717			return 0;
  5718	
  5719		if (gaudi2->hw_cap_initialized & HW_CAP_PMMU) {
  5720			if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
  5721						parser->user_cb_size,
  5722						asic_prop->pmmu.start_addr,
  5723						asic_prop->pmmu.end_addr) ||
  5724				hl_mem_area_inside_range(
  5725						(u64) (uintptr_t) parser->user_cb,
  5726						parser->user_cb_size,
  5727						asic_prop->pmmu_huge.start_addr,
  5728						asic_prop->pmmu_huge.end_addr))
  5729				return 0;
  5730	
  5731		} else if (gaudi2_host_phys_addr_valid((u64) (uintptr_t) parser->user_cb)) {
  5732			if (!hdev->pdev)
  5733				return 0;
  5734	
  5735			if (!device_iommu_mapped(&hdev->pdev->dev))
  5736				return 0;
  5737		}
  5738	
  5739		dev_err(hdev->dev, "CB address %p + 0x%x for internal QMAN is not valid\n",
  5740			parser->user_cb, parser->user_cb_size);
  5741	
  5742		return -EFAULT;
  5743	}
  5744	
> 5745	int gaudi2_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
  5746	{
  5747		struct gaudi2_device *gaudi2 = hdev->asic_specific;
  5748	
  5749		if (!parser->is_kernel_allocated_cb)
  5750			return gaudi2_validate_cb_address(hdev, parser);
  5751	
  5752		if (!(gaudi2->hw_cap_initialized & HW_CAP_PMMU)) {
  5753			dev_err(hdev->dev, "PMMU not initialized - Unsupported mode in Gaudi2\n");
  5754			return -EINVAL;
  5755		}
  5756	
  5757		return 0;
  5758	}
  5759	
> 5760	int gaudi2_send_heartbeat(struct hl_device *hdev)
  5761	{
  5762		struct gaudi2_device *gaudi2 = hdev->asic_specific;
  5763	
  5764		if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
  5765			return 0;
  5766	
  5767		return hl_fw_send_heartbeat(hdev);
  5768	}
  5769	
  5770	/* This is an internal helper function, used to update the KDMA mmu props.
  5771	 * Should be called with a proper kdma lock.
  5772	 */
  5773	static void gaudi2_kdma_set_mmbp_asid(struct hl_device *hdev,
  5774						   bool mmu_bypass, u32 asid)
  5775	{
  5776		u32 rw_asid, rw_mmu_bp;
  5777	
  5778		rw_asid = (asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_RD_SHIFT) |
  5779			      (asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_WR_SHIFT);
  5780	
  5781		rw_mmu_bp = (!!mmu_bypass << ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_RD_SHIFT) |
  5782				(!!mmu_bypass << ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_WR_SHIFT);
  5783	
  5784		WREG32(mmARC_FARM_KDMA_CTX_AXUSER_HB_ASID, rw_asid);
  5785		WREG32(mmARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP, rw_mmu_bp);
  5786	}
  5787	
  5788	static void gaudi2_arm_cq_monitor(struct hl_device *hdev, u32 index, u32 cq_id,
  5789							u32 mon_payload, u32 sync_value)
  5790	{
  5791		int offset = index * 4;
  5792		u32 sync_group_id, mask, mode, mon_arm;
  5793	
  5794		/* Reset the SOB value */
  5795		WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset, 0);
  5796	
  5797		/* Configure this address with CQ_ID 0 because CQ_EN is set */
  5798		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + offset, cq_id);
  5799	
  5800		/* Configure this address with CS index because CQ_EN is set */
  5801		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + offset, mon_payload);
  5802	
  5803		sync_group_id = index / 8;
  5804		mask = ~(1 << (index & 0x7));
  5805		mode = 1; /* comparison mode is "equal to" */
  5806	
  5807		mon_arm = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOD_MASK, sync_value);
  5808		mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOP_MASK, mode);
> 5809		mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_MASK_MASK, mask);
  5810		mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SID_MASK, sync_group_id);
  5811		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + offset, mon_arm);
  5812	}
  5813	
  5814	/* This is an internal helper function used by gaudi2_send_job_to_kdma only */
  5815	static int gaudi2_send_job_to_kdma(struct hl_device *hdev,
  5816						u64 src_addr, u64 dst_addr,
  5817						u32 size, bool is_memset)
  5818	{
  5819		u32 comp_val, commit_mask, *polling_addr, timeout, status = 0;
  5820		struct hl_cq_entry *cq_base;
  5821		struct hl_cq *cq;
  5822		u64 comp_addr;
  5823		int rc;
  5824	
  5825		gaudi2_arm_cq_monitor(hdev, GAUDI2_RESERVED_SOB_KDMA_COMP,
  5826					GAUDI2_RESERVED_CQ_KDMA_COMPLETION, 1, 1);
  5827	
  5828		comp_addr = CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 +
  5829				(GAUDI2_RESERVED_SOB_KDMA_COMP * sizeof(u32));
  5830	
  5831		comp_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1) |
  5832				FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1);
  5833	
  5834		WREG32(mmARC_FARM_KDMA_CTX_SRC_BASE_LO, lower_32_bits(src_addr));
  5835		WREG32(mmARC_FARM_KDMA_CTX_SRC_BASE_HI, upper_32_bits(src_addr));
  5836		WREG32(mmARC_FARM_KDMA_CTX_DST_BASE_LO, lower_32_bits(dst_addr));
  5837		WREG32(mmARC_FARM_KDMA_CTX_DST_BASE_HI, upper_32_bits(dst_addr));
  5838		WREG32(mmARC_FARM_KDMA_CTX_WR_COMP_ADDR_LO, lower_32_bits(comp_addr));
  5839		WREG32(mmARC_FARM_KDMA_CTX_WR_COMP_ADDR_HI, upper_32_bits(comp_addr));
  5840		WREG32(mmARC_FARM_KDMA_CTX_WR_COMP_WDATA, comp_val);
  5841		WREG32(mmARC_FARM_KDMA_CTX_DST_TSIZE_0, size);
  5842	
  5843		commit_mask = FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_LIN_MASK, 1) |
  5844					FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_WR_COMP_EN_MASK, 1);
  5845	
  5846		if (is_memset)
  5847			commit_mask |= FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_MEM_SET_MASK, 1);
  5848	
  5849		WREG32(mmARC_FARM_KDMA_CTX_COMMIT, commit_mask);
  5850	
  5851		/* Wait for completion */
  5852		cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_KDMA_COMPLETION];
  5853		cq_base = cq->kernel_address;
  5854		polling_addr = (u32 *)&cq_base[cq->ci];
  5855	
  5856		if (hdev->pldm)
  5857			/* for each 1MB 20 second of timeout */
  5858			timeout = ((size / SZ_1M) + 1) * USEC_PER_SEC * 20;
  5859		else
  5860			timeout = KDMA_TIMEOUT_USEC;
  5861	
  5862		/* Polling */
  5863		rc = hl_poll_timeout_memory(
  5864				hdev,
  5865				polling_addr,
  5866				status,
  5867				(status == 1),
  5868				1000,
  5869				timeout,
  5870				true);
  5871	
  5872		*polling_addr = 0;
  5873	
  5874		if (rc) {
  5875			dev_err(hdev->dev, "Timeout while waiting for KDMA to be idle\n");
  5876			WREG32(mmARC_FARM_KDMA_CFG_1, 1 << ARC_FARM_KDMA_CFG_1_HALT_SHIFT);
  5877			return rc;
  5878		}
  5879	
  5880		cq->ci = hl_cq_inc_ptr(cq->ci);
  5881	
  5882		return 0;
  5883	}
  5884	
  5885	static void gaudi2_memset_device_lbw(struct hl_device *hdev, u32 addr, u32 size, u32 val)
  5886	{
  5887		u32 i;
  5888	
  5889		for (i = 0 ; i < size ; i += sizeof(u32))
  5890			WREG32(addr + i, val);
  5891	}
  5892	
  5893	static void gaudi2_qman_set_test_mode(struct hl_device *hdev, u32 hw_queue_id, bool enable)
  5894	{
  5895		u32 reg_base = gaudi2_qm_blocks_bases[hw_queue_id];
  5896	
  5897		if (enable) {
  5898			WREG32(reg_base + QM_GLBL_PROT_OFFSET, QMAN_MAKE_TRUSTED_TEST_MODE);
  5899			WREG32(reg_base + QM_PQC_CFG_OFFSET, 0);
  5900		} else {
  5901			WREG32(reg_base + QM_GLBL_PROT_OFFSET, QMAN_MAKE_TRUSTED);
  5902			WREG32(reg_base + QM_PQC_CFG_OFFSET, 1 << PDMA0_QM_PQC_CFG_EN_SHIFT);
  5903		}
  5904	}
  5905	
  5906	static int gaudi2_test_queue(struct hl_device *hdev, u32 hw_queue_id)
  5907	{
  5908		u32 sob_offset = hdev->asic_prop.first_available_user_sob[0] * 4;
  5909		u32 sob_addr = mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset;
  5910		u32 timeout_usec, tmp, sob_base = 1, sob_val = 0x5a5a;
  5911		struct packet_msg_short *msg_short_pkt;
  5912		dma_addr_t pkt_dma_addr;
  5913		size_t pkt_size;
  5914		int rc;
  5915	
  5916		if (hdev->pldm)
  5917			timeout_usec = GAUDI2_PLDM_TEST_QUEUE_WAIT_USEC;
  5918		else
  5919			timeout_usec = GAUDI2_TEST_QUEUE_WAIT_USEC;
  5920	
  5921		pkt_size = sizeof(*msg_short_pkt);
  5922		msg_short_pkt = hl_asic_dma_pool_zalloc(hdev, pkt_size, GFP_KERNEL, &pkt_dma_addr);
  5923		if (!msg_short_pkt) {
  5924			dev_err(hdev->dev, "Failed to allocate packet for H/W queue %d testing\n",
  5925				hw_queue_id);
  5926			return -ENOMEM;
  5927		}
  5928	
  5929		tmp = (PACKET_MSG_SHORT << GAUDI2_PKT_CTL_OPCODE_SHIFT) |
  5930			(1 << GAUDI2_PKT_CTL_EB_SHIFT) |
  5931			(1 << GAUDI2_PKT_CTL_MB_SHIFT) |
  5932			(sob_base << GAUDI2_PKT_SHORT_CTL_BASE_SHIFT) |
  5933			(sob_offset << GAUDI2_PKT_SHORT_CTL_ADDR_SHIFT);
  5934	
  5935		msg_short_pkt->value = cpu_to_le32(sob_val);
  5936		msg_short_pkt->ctl = cpu_to_le32(tmp);
  5937	
  5938		/* Reset the SOB value */
  5939		WREG32(sob_addr, 0);
  5940	
  5941		rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id, pkt_size, pkt_dma_addr);
  5942		if (rc) {
  5943			dev_err(hdev->dev, "Failed to send msg_short packet to H/W queue %d\n",
  5944				hw_queue_id);
  5945			goto free_pkt;
  5946		}
  5947	
  5948		rc = hl_poll_timeout(
  5949				hdev,
  5950				sob_addr,
  5951				tmp,
  5952				(tmp == sob_val),
  5953				1000,
  5954				timeout_usec);
  5955	
  5956		if (rc == -ETIMEDOUT) {
  5957			dev_err(hdev->dev, "H/W queue %d test failed (SOB_OBJ_0 == 0x%x)\n",
  5958				hw_queue_id, tmp);
  5959			rc = -EIO;
  5960		}
  5961	
  5962		/* Reset the SOB value */
  5963		WREG32(sob_addr, 0);
  5964	
  5965	free_pkt:
  5966		hl_asic_dma_pool_free(hdev, (void *) msg_short_pkt, pkt_dma_addr);
  5967		return rc;
  5968	}
  5969	
> 5970	int gaudi2_test_cpu_queue(struct hl_device *hdev)
  5971	{
  5972		struct gaudi2_device *gaudi2 = hdev->asic_specific;
  5973	
  5974		/*
  5975		 * check capability here as send_cpu_message() won't update the result
  5976		 * value if no capability
  5977		 */
  5978		if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
  5979			return 0;
  5980	
  5981		return hl_fw_test_cpu_queue(hdev);
  5982	}
  5983	
> 5984	int gaudi2_test_queues(struct hl_device *hdev)
  5985	{
  5986		int i, rc, ret_val = 0;
  5987	
  5988		for (i = GAUDI2_QUEUE_ID_PDMA_0_0 ; i < GAUDI2_QUEUE_ID_CPU_PQ; i++) {
  5989			if (!gaudi2_is_queue_enabled(hdev, i))
  5990				continue;
  5991	
  5992			gaudi2_qman_set_test_mode(hdev, i, true);
  5993			rc = gaudi2_test_queue(hdev, i);
  5994			gaudi2_qman_set_test_mode(hdev, i, false);
  5995	
  5996			if (rc) {
  5997				ret_val = -EINVAL;
  5998				goto done;
  5999			}
  6000		}
  6001	
  6002		rc = gaudi2_test_cpu_queue(hdev);
  6003		if (rc) {
  6004			ret_val = -EINVAL;
  6005			goto done;
  6006		}
  6007	
  6008	done:
  6009		return ret_val;
  6010	}
  6011	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
