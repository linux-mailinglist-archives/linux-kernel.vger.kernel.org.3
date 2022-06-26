Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CD55B39E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiFZSmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFZSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:42:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F60DF79
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656268953; x=1687804953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qKVLkatOLdxjF5CtUvwHyxvGQyf3WivTT79tQydsles=;
  b=HD0Iol8bwYKL6LH03dOLWT59113VJzpyhPC6db9CiZO9rUcdMhR5f4b1
   tI0F+lDBmUQFDJOnNw026S6Mn2hBPlgt1Z4wgID7RvgBwW7iaHniryQ7W
   S6QlRjG5ol6r+jrNkOyYgtyLzBo5gr7Z7LcWAt6m2A8u0T7XiJnvmRomc
   LDrn9n1CJji1sWwau5gL86vX0hHBmdeMbVbTH2hiS7f2znk/FMg92tR8I
   3ehoS8/kvvMELL5H38PQPXMDaKbelPwg8wAarbmCSTITnXx83hYu6T2G0
   JwUokW9E0F8vEB0eXOK8wZF0eV2iDHEEH1oDlIN19gguCr1d+RTg5+q4m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280062934"
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="280062934"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 11:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="616525052"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2022 11:42:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5XDL-0007ip-56;
        Sun, 26 Jun 2022 18:42:31 +0000
Date:   Mon, 27 Jun 2022 02:41:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 49/51] gaudi2.c:undefined reference to `__udivdi3'
Message-ID: <202206270234.HAFoxLu9-lkp@intel.com>
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
config: i386-randconfig-a001
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=e86cc96aba150c067b57bfb623e093086d372403
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout e86cc96aba150c067b57bfb623e093086d372403
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   ld: drivers/misc/habanalabs/gaudi2/gaudi2.o: in function `gaudi2_cpucp_info_get':
>> gaudi2.c:(.text+0x12857): undefined reference to `__udivdi3'
>> ld: gaudi2.c:(.text+0x12898): undefined reference to `__udivdi3'
--
         |     ^~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:6346:5: warning: no previous prototype for 'gaudi2_get_eeprom_data' [-Wmissing-prototypes]
    6346 | int gaudi2_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:6356:6: warning: no previous prototype for 'gaudi2_update_eq_ci' [-Wmissing-prototypes]
    6356 | void gaudi2_update_eq_ci(struct hl_device *hdev, u32 val)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:6361:7: warning: no previous prototype for 'gaudi2_get_events_stat' [-Wmissing-prototypes]
    6361 | void *gaudi2_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size)
         |       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:8246:6: warning: no previous prototype for 'gaudi2_handle_eqe' [-Wmissing-prototypes]
    8246 | void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
         |      ^~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:8719:5: warning: no previous prototype for 'gaudi2_scrub_device_dram' [-Wmissing-prototypes]
    8719 | int gaudi2_scrub_device_dram(struct hl_device *hdev, u64 val)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:8892:5: warning: no previous prototype for 'gaudi2_context_switch' [-Wmissing-prototypes]
    8892 | int gaudi2_context_switch(struct hl_device *hdev, u32 asid)
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:8897:6: warning: no previous prototype for 'gaudi2_restore_phase_topology' [-Wmissing-prototypes]
    8897 | void gaudi2_restore_phase_topology(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:8920:6: warning: no previous prototype for 'gaudi2_init_blocks_with_mask' [-Wmissing-prototypes]
    8920 | void gaudi2_init_blocks_with_mask(struct hl_device *hdev, struct dup_block_ctx *cfg_ctx, u64 mask)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:8935:5: warning: no previous prototype for 'gaudi2_debugfs_read_dma' [-Wmissing-prototypes]
    8935 | int gaudi2_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size, void *blob_addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9115:5: warning: no previous prototype for 'gaudi2_ctx_init' [-Wmissing-prototypes]
    9115 | int gaudi2_ctx_init(struct hl_ctx *ctx)
         |     ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9134:6: warning: no previous prototype for 'gaudi2_ctx_fini' [-Wmissing-prototypes]
    9134 | void gaudi2_ctx_fini(struct hl_ctx *ctx)
         |      ^~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9142:5: warning: no previous prototype for 'gaudi2_pre_schedule_cs' [-Wmissing-prototypes]
    9142 | int gaudi2_pre_schedule_cs(struct hl_cs *cs)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9168:5: warning: no previous prototype for 'gaudi2_get_queue_id_for_cq' [-Wmissing-prototypes]
    9168 | u32 gaudi2_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9173:5: warning: no previous prototype for 'gaudi2_gen_signal_cb' [-Wmissing-prototypes]
    9173 | u32 gaudi2_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id, u32 size, bool eb)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9266:5: warning: no previous prototype for 'gaudi2_gen_wait_cb' [-Wmissing-prototypes]
    9266 | u32 gaudi2_gen_wait_cb(struct hl_device *hdev, struct hl_gen_wait_properties *prop)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9318:6: warning: no previous prototype for 'gaudi2_reset_sob' [-Wmissing-prototypes]
    9318 | void gaudi2_reset_sob(struct hl_device *hdev, void *data)
         |      ^~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9329:6: warning: no previous prototype for 'gaudi2_reset_sob_group' [-Wmissing-prototypes]
    9329 | void gaudi2_reset_sob_group(struct hl_device *hdev, u16 sob_group)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9333:5: warning: no previous prototype for 'gaudi2_get_device_time' [-Wmissing-prototypes]
    9333 | u64 gaudi2_get_device_time(struct hl_device *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9340:5: warning: no previous prototype for 'gaudi2_collective_wait_init_cs' [-Wmissing-prototypes]
    9340 | int gaudi2_collective_wait_init_cs(struct hl_cs *cs)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9345:5: warning: no previous prototype for 'gaudi2_collective_wait_create_jobs' [-Wmissing-prototypes]
    9345 | int gaudi2_collective_wait_create_jobs(struct hl_device *hdev, struct hl_ctx *ctx,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9390:5: warning: no previous prototype for 'gaudi2_mmu_descramble_addr' [-Wmissing-prototypes]
    9390 | u64 gaudi2_mmu_descramble_addr(struct hl_device *hdev, u64 scrambled_addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9411:5: warning: no previous prototype for 'gaudi2_get_dec_base_addr' [-Wmissing-prototypes]
    9411 | u32 gaudi2_get_dec_base_addr(struct hl_device *hdev, u32 core_id)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9434:5: warning: no previous prototype for 'gaudi2_get_hw_block_id' [-Wmissing-prototypes]
    9434 | int gaudi2_get_hw_block_id(struct hl_device *hdev, u64 block_addr,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9454:5: warning: no previous prototype for 'gaudi2_block_mmap' [-Wmissing-prototypes]
    9454 | int gaudi2_block_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
         |     ^~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9488:6: warning: no previous prototype for 'gaudi2_enable_events_from_fw' [-Wmissing-prototypes]
    9488 | void gaudi2_enable_events_from_fw(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9577:5: warning: no previous prototype for 'gaudi2_ack_mmu_page_fault_or_access_error' [-Wmissing-prototypes]
    9577 | int gaudi2_ack_mmu_page_fault_or_access_error(struct hl_device *hdev, u64 mmu_cap_mask)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9601:5: warning: no previous prototype for 'gaudi2_map_pll_idx_to_fw_idx' [-Wmissing-prototypes]
    9601 | int gaudi2_map_pll_idx_to_fw_idx(u32 pll_idx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9656:6: warning: no previous prototype for 'gaudi2_state_dump_init' [-Wmissing-prototypes]
    9656 | void gaudi2_state_dump_init(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9663:5: warning: no previous prototype for 'gaudi2_get_sob_addr' [-Wmissing-prototypes]
    9663 | u32 gaudi2_get_sob_addr(struct hl_device *hdev, u32 sob_id)
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9668:6: warning: no previous prototype for 'gaudi2_get_stream_master_qid_arr' [-Wmissing-prototypes]
    9668 | u32 *gaudi2_get_stream_master_qid_arr(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9673:6: warning: no previous prototype for 'gaudi2_add_device_attr' [-Wmissing-prototypes]
    9673 | void gaudi2_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9680:5: warning: no previous prototype for 'gaudi2_mmu_get_real_page_size' [-Wmissing-prototypes]
    9680 | int gaudi2_mmu_get_real_page_size(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi2/gaudi2.c:9817:6: warning: no previous prototype for 'gaudi2_set_asic_funcs' [-Wmissing-prototypes]
    9817 | void gaudi2_set_asic_funcs(struct hl_device *hdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:694:27: warning: 'gaudi2_nic_rxe_spi_interrupts_cause' defined but not used [-Wunused-const-variable=]
     694 | static const char * const gaudi2_nic_rxe_spi_interrupts_cause[GAUDI2_NUM_OF_NIC_RXE_SPI_CAUSE] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:687:27: warning: 'gaudi2_nic_rxe_sei_interrupts_cause' defined but not used [-Wunused-const-variable=]
     687 | static const char * const gaudi2_nic_rxe_sei_interrupts_cause[GAUDI2_NUM_OF_NIC_RXE_SEI_CAUSE] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:678:1: warning: 'gaudi2_nic_rxb_core_spi_interrupts_cause' defined but not used [-Wunused-const-variable=]
     678 | gaudi2_nic_rxb_core_spi_interrupts_cause[GAUDI2_NUM_OF_NIC_RXB_CORE_SPI_CAUSE] = {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:672:1: warning: 'gaudi2_nic_rxb_core_sei_interrupts_cause' defined but not used [-Wunused-const-variable=]
     672 | gaudi2_nic_rxb_core_sei_interrupts_cause[GAUDI2_NUM_OF_NIC_RXB_CORE_SEI_CAUSE] = {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
