Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276FE57138C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiGLHyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiGLHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:53:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B722BC0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:53:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6239CB816E1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C405C3411E;
        Tue, 12 Jul 2022 07:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657612430;
        bh=enIPoJMLVlQFwMTWGxQnpmCvL1Po0ahpnSfgc/Q2zcY=;
        h=Date:From:To:Cc:Subject:From;
        b=aaWOLO0xVmXEMEFNnhvYjXFRANx9ch/L7Uavm4PT4cBZTAYAU24QlI2VbyR4uaDda
         AA16NQ3ADALyqHN7XOw4zcm6LYHGYOfRWuMWggEfCZMR6MfkztKfWTJNGAePYChY7i
         3qzQuXbD3SMFfk77HUDD7XsdZNAFk8cAx4seOjEFM1E9mPp+OFpolo7Oc+0WnjO0mG
         zY03U9sNEaNpzRGUmapcbGXKmlBvklE2RBpcCQOcuRj7oyZ2++eckSaaoT5csJT2Ez
         lS2b7aBqTrLWD6HFQM+JCpKxhE2Qn2ofFHgrax3Spcbej+Q7m8rquBN6dbqdVY2ZCc
         9oxQniTez7Ihg==
Date:   Tue, 12 Jul 2022 10:53:45 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.20
Message-ID: <20220712075345.GA3318116@ogabbay-vm-u20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.20.

This is a relatively large pull request as it contains the code to support our
new Gaudi2 AI accelerator.

Outside of that there is nothing else too exciting. Except for a few
enhancements to features added in 5.19, most of the commits are small bug
fixes or cleanups.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 7e724422a7e9dfc8229ba90ee95aaafb902a788b:

  Merge tag 'coresight-next-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next (2022-07-11 20:54:28 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-07-12

for you to fetch changes up to a919b823abba8cb84bb99e007ea8a01ed9f5410a:

  habanalabs: move h/w dirty message to debug (2022-07-12 09:09:31 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.20:

- Add Gaudi2 ASIC support. All the features required for Gaudi2 are included
  in this tag (except the networking aspect).

- Add more events to the eventfd support in the driver. With the new code, we
  expose three events that the user can register to get notification about them.

- re-factor soft reset code and replace its name to compute reset to better
  reflect the actual reset done in new ASICs

- Change the way Gaudi2 triggers an MSI-X interrupt due to h/w bug.

- Improve the code of the debugfs node that scrubs the device's memory.

- Add mechanism for better compatibility with older f/w versions

- Cleanup kernel log prints by moving some prints to debug and removing others.

- Many small bug fixes and minor changes.

----------------------------------------------------------------
Benjamin Dotan (1):
      habanalabs/gaudi2: add gaudi2 profiler module

Christophe JAILLET (1):
      habanalabs: Use the bitmap API to allocate bitmaps

Dafna Hirschfeld (8):
      habanalabs: add terminating NULL to attrs arrays
      habanalabs: move memory_scrub_val to hdev struct
      habanalabs: don't do memory scrubbing when unmapping
      habanalabs: don't send addr and size to scrub_device_mem cb
      habanalabs/gaudi: use memory_scrub_val from debugfs
      habanalabs: move call to scrub_device_mem after ctx_fini
      habanalabs: set default value for memory_scrub
      habanalabs/gaudi: replace hl_poll_timeout with while loop

Dan Carpenter (1):
      habanalabs: fix double unlock on error in map_device_va()

Dan Rapaport (1):
      habanalabs: align ioctl uapi structures to 64-bit

Dani Liberman (1):
      habanalabs: avoid unnecessary error print

Jiapeng Chong (2):
      habanalabs: Fix kernel-doc
      habanalabs: Fix kernel-doc

Koby Elbaz (2):
      habanalabs/gaudi: fix incorrect MME offset calculation
      habanalabs/gaudi: fix warning: var might be used uninitialized

Moti Haimovski (1):
      habanalabs: add gaudi2 MMU support

Oded Gabbay (32):
      habanalabs/gaudi: fix comment to reflect current code
      habanalabs: remove unused get_dma_desc_list_size
      habanalabs: check fence pointer before use
      habanalabs: print pointer with correct modifier
      habanalabs: use kvcalloc when possible
      habanalabs: fix comment style
      habanalabs/goya: move dma direction enum to uapi file
      habanalabs/gaudi: fix function name in comment
      habanalabs/gaudi: use correct type in assignment
      habanalabs/gaudi: mask constant value before cast
      habanalabs/gaudi: remove unused enum
      habanalabs/gaudi: enable error interrupt on ARB WDT
      habanalabs: use %pa to print pci bar size
      habanalabs/gaudi2: add asic registers header files
      uapi: habanalabs: add gaudi2 defines
      habanalabs: add gaudi2 asic-specific code
      habanalabs: add unsupported functions
      habanalabs: initialize new asic properties
      habanalabs: remove obsolete device variables used for testing
      habanalabs: add gaudi2 wait-for-CS support
      habanalabs: enable gaudi2 code in driver
      habanalabs: allow detection of unsupported f/w packets
      habanalabs/gaudi2: remove unused variable
      habanalabs/gaudi2: SM mask can only be 8-bit
      habanalabs: don't declare tmp twice in same function
      habanalabs: make sure variable is set before used
      habanalabs/gaudi2: remove unused defines
      habanalabs: initialize variable explicitly
      habanalabs: fix update of is_in_soft_reset
      habanalabs: add status of reset after device release
      habanalabs: rename soft reset to compute reset
      habanalabs: move h/w dirty message to debug

Ofir Bitton (10):
      habanalabs/gaudi: fix shift out of bounds
      habanalabs: print if firmware is secured during load
      habanalabs: remove redundant argument in access_dev_mem APIs
      habanalabs: add generic security module
      habanalabs/gaudi2: add gaudi2 security module
      habanalabs/gaudi2: reset device upon critical ECC event
      habanalabs: naming refactor of user interrupt flow
      habanalabs: add support for common decoder interrupts
      habanalabs: do not set max power on a secured device
      habanalabs: expose only valid debugfs nodes

Ohad Sharabi (6):
      habanalabs: refactor dma asic-specific functions
      habanalabs: page size can only be a power of 2
      habanalabs: communicate supported page sizes to user
      habanalabs: wait for preboot ready after hard reset
      habanalabs/gaudi2: use DIV_ROUND_UP_SECTOR_T instead of roundup
      habanalabs: fixes to the poll-timeout macros

Sagiv Ozeri (1):
      habanalabs: save f/w preboot minor version

Tal Cohen (8):
      habanalabs/gaudi: move tpc assert raise into internal func
      habanalabs: change the write flag name of error info structs
      habanalabs/gaudi: collect undefined opcode error info
      habanalabs: expose undefined opcode status via info ioctl
      habanalabs/gaudi: invoke device reset from one code block
      habanalabs/gaudi: send device reset notification
      habanalabs: send an event notification when CS timeout occurs
      habanalabs/gaudi: notify user process on device unavailable

Tomer Tayar (8):
      habanalabs: fix race between hl_get_compute_ctx() and hl_ctx_put()
      habanalabs: remove dead code from free_device_memory()
      habanalabs: add a value field to hl_fw_send_pci_access_msg()
      habanalabs/gaudi2: configure virtual MSI-X doorbell interface
      habanalabs/gaudi2: replace defines for reserved sob/mob with enums
      habanalabs/gaudi2: modify CS completion CQ to use virtual MSI-X doorbell
      habanalabs/gaudi2: modify decoder to use virtual MSI-X doorbell
      habanalabs/gaudi2: map virtual MSI-X doorbell memory for user

Yuri Nudelman (3):
      habanalabs: keep a record of completed CS outcomes
      habanalabs: fix NULL dereference on cs timeout
      habanalabs/gaudi: fix a race condition causing DMAR error

farah kassabri (1):
      habanalabs: add validity check for cq counter offset

ran shalit (1):
      habanalabs: add critical indication in sram ecc

 .../ABI/testing/debugfs-driver-habanalabs          |    38 +-
 drivers/misc/habanalabs/Makefile                   |     3 +
 drivers/misc/habanalabs/common/Makefile            |     3 +-
 drivers/misc/habanalabs/common/asid.c              |     5 +-
 drivers/misc/habanalabs/common/command_buffer.c    |    12 +-
 .../misc/habanalabs/common/command_submission.c    |   296 +-
 drivers/misc/habanalabs/common/context.c           |    73 +-
 drivers/misc/habanalabs/common/debugfs.c           |   221 +-
 drivers/misc/habanalabs/common/decoder.c           |   133 +
 drivers/misc/habanalabs/common/device.c            |   242 +-
 drivers/misc/habanalabs/common/firmware_if.c       |   211 +-
 drivers/misc/habanalabs/common/habanalabs.h        |   756 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |    82 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |    54 +-
 drivers/misc/habanalabs/common/hw_queue.c          |    45 +-
 drivers/misc/habanalabs/common/irq.c               |   160 +-
 drivers/misc/habanalabs/common/memory.c            |   115 +-
 drivers/misc/habanalabs/common/memory_mgr.c        |     2 +-
 drivers/misc/habanalabs/common/mmu/Makefile        |     3 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   496 +-
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |     9 +-
 drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c     |   399 +
 drivers/misc/habanalabs/common/pci/pci.c           |    40 +-
 drivers/misc/habanalabs/common/security.c          |   600 +
 drivers/misc/habanalabs/common/sysfs.c             |    10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   681 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |     2 +-
 drivers/misc/habanalabs/gaudi2/Makefile            |     4 +
 drivers/misc/habanalabs/gaudi2/gaudi2.c            |  9986 ++++
 drivers/misc/habanalabs/gaudi2/gaudi2P.h           |   566 +
 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c  |  2720 ++
 .../misc/habanalabs/gaudi2/gaudi2_coresight_regs.h |  1063 +
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h      |   141 +
 drivers/misc/habanalabs/gaudi2/gaudi2_security.c   |  3849 ++
 drivers/misc/habanalabs/goya/goya.c                |   160 +-
 drivers/misc/habanalabs/goya/goyaP.h               |     6 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |     2 +
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   297 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |     7 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |     1 +
 .../include/gaudi2/arc/gaudi2_arc_common_packets.h |   213 +
 .../gaudi2/asic_reg/arc_farm_arc0_acp_eng_regs.h   |   567 +
 .../gaudi2/asic_reg/arc_farm_arc0_aux_masks.h      |   819 +
 .../gaudi2/asic_reg/arc_farm_arc0_aux_regs.h       |   591 +
 .../asic_reg/arc_farm_arc0_dup_eng_axuser_regs.h   |    61 +
 .../gaudi2/asic_reg/arc_farm_arc0_dup_eng_regs.h   |   575 +
 .../asic_reg/arc_farm_kdma_ctx_axuser_masks.h      |   135 +
 .../asic_reg/arc_farm_kdma_ctx_axuser_regs.h       |    61 +
 .../gaudi2/asic_reg/arc_farm_kdma_ctx_masks.h      |   221 +
 .../gaudi2/asic_reg/arc_farm_kdma_ctx_regs.h       |    95 +
 .../gaudi2/asic_reg/arc_farm_kdma_kdma_cgm_regs.h  |    29 +
 .../include/gaudi2/asic_reg/arc_farm_kdma_masks.h  |   415 +
 .../include/gaudi2/asic_reg/arc_farm_kdma_regs.h   |   157 +
 .../include/gaudi2/asic_reg/cpu_if_regs.h          |   777 +
 .../gaudi2/asic_reg/dcore0_dec0_cmd_masks.h        |   229 +
 .../include/gaudi2/asic_reg/dcore0_dec0_cmd_regs.h |    85 +
 .../asic_reg/dcore0_edma0_core_ctx_axuser_regs.h   |    61 +
 .../gaudi2/asic_reg/dcore0_edma0_core_ctx_regs.h   |    95 +
 .../gaudi2/asic_reg/dcore0_edma0_core_masks.h      |   415 +
 .../gaudi2/asic_reg/dcore0_edma0_core_regs.h       |   157 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_arc_aux_regs.h |   591 +
 .../dcore0_edma0_qm_axuser_nonsecured_regs.h       |    61 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_cgm_regs.h     |    29 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_masks.h        |  1165 +
 .../include/gaudi2/asic_reg/dcore0_edma0_qm_regs.h |  1057 +
 .../asic_reg/dcore0_edma1_core_ctx_axuser_regs.h   |    61 +
 .../dcore0_edma1_qm_axuser_nonsecured_regs.h       |    61 +
 .../gaudi2/asic_reg/dcore0_hmmu0_mmu_masks.h       |   294 +
 .../gaudi2/asic_reg/dcore0_hmmu0_mmu_regs.h        |   237 +
 .../gaudi2/asic_reg/dcore0_hmmu0_stlb_masks.h      |   348 +
 .../gaudi2/asic_reg/dcore0_hmmu0_stlb_regs.h       |   141 +
 .../include/gaudi2/asic_reg/dcore0_mme_acc_regs.h  |    73 +
 ...dcore0_mme_ctrl_lo_arch_agu_cout0_master_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_cout0_slave_regs.h |    33 +
 ...dcore0_mme_ctrl_lo_arch_agu_cout1_master_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_cout1_slave_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in0_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in0_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in1_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in1_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in2_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in2_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in3_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in3_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in4_master_regs.h  |    33 +
 .../dcore0_mme_ctrl_lo_arch_agu_in4_slave_regs.h   |    33 +
 .../dcore0_mme_ctrl_lo_arch_base_addr_regs.h       |    39 +
 .../dcore0_mme_ctrl_lo_arch_non_tensor_end_regs.h  |    73 +
 ...dcore0_mme_ctrl_lo_arch_non_tensor_start_regs.h |    35 +
 .../dcore0_mme_ctrl_lo_arch_tensor_a_regs.h        |    67 +
 .../dcore0_mme_ctrl_lo_arch_tensor_b_regs.h        |    67 +
 .../dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h     |    67 +
 .../gaudi2/asic_reg/dcore0_mme_ctrl_lo_masks.h     |   468 +
 .../asic_reg/dcore0_mme_ctrl_lo_mme_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_mme_ctrl_lo_regs.h      |   163 +
 .../asic_reg/dcore0_mme_qm_arc_acp_eng_regs.h      |   567 +
 .../gaudi2/asic_reg/dcore0_mme_qm_arc_aux_regs.h   |   591 +
 .../dcore0_mme_qm_arc_dup_eng_axuser_regs.h        |    61 +
 .../asic_reg/dcore0_mme_qm_arc_dup_eng_regs.h      |   575 +
 .../dcore0_mme_qm_axuser_nonsecured_regs.h         |    61 +
 .../asic_reg/dcore0_mme_qm_axuser_secured_regs.h   |    61 +
 .../gaudi2/asic_reg/dcore0_mme_qm_cgm_regs.h       |    29 +
 .../include/gaudi2/asic_reg/dcore0_mme_qm_regs.h   |  1057 +
 .../gaudi2/asic_reg/dcore0_mme_sbte0_masks.h       |   107 +
 .../dcore0_mme_sbte0_mstr_if_axuser_regs.h         |    61 +
 .../asic_reg/dcore0_mme_wb0_mstr_if_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_rtr0_ctrl_regs.h        |   291 +
 .../dcore0_rtr0_mstr_if_rr_prvt_hbw_regs.h         |   213 +
 .../dcore0_rtr0_mstr_if_rr_prvt_lbw_regs.h         |   189 +
 .../dcore0_rtr0_mstr_if_rr_shrd_hbw_regs.h         |   213 +
 .../dcore0_rtr0_mstr_if_rr_shrd_lbw_regs.h         |   189 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_glbl_masks.h  |   135 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_glbl_regs.h   |  1203 +
 .../dcore0_sync_mngr_mstr_if_axuser_masks.h        |   135 +
 .../dcore0_sync_mngr_mstr_if_axuser_regs.h         |    61 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_objs_masks.h  |    87 +
 .../gaudi2/asic_reg/dcore0_sync_mngr_objs_regs.h   | 43543 ++++++++++++++++++
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_regs.h  |   129 +
 .../dcore0_tpc0_cfg_kernel_tensor_0_regs.h         |    63 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_masks.h        |   509 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_qm_regs.h      |   129 +
 .../asic_reg/dcore0_tpc0_cfg_qm_sync_object_regs.h |    27 +
 .../asic_reg/dcore0_tpc0_cfg_qm_tensor_0_regs.h    |    63 +
 .../include/gaudi2/asic_reg/dcore0_tpc0_cfg_regs.h |   229 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_special_regs.h |   185 +
 .../asic_reg/dcore0_tpc0_eml_busmon_0_regs.h       |   163 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_etf_regs.h     |   113 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_funnel_regs.h  |    75 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_spmu_regs.h    |   151 +
 .../gaudi2/asic_reg/dcore0_tpc0_eml_stm_regs.h     |   131 +
 .../gaudi2/asic_reg/dcore0_tpc0_qm_arc_aux_regs.h  |   591 +
 .../dcore0_tpc0_qm_axuser_nonsecured_regs.h        |    61 +
 .../gaudi2/asic_reg/dcore0_tpc0_qm_cgm_regs.h      |    29 +
 .../include/gaudi2/asic_reg/dcore0_tpc0_qm_regs.h  |  1057 +
 .../dcore0_vdec0_brdg_ctrl_axuser_dec_regs.h       |    61 +
 ...dcore0_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h |    61 +
 .../dcore0_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h  |    61 +
 .../dcore0_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h  |    61 +
 .../dcore0_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_masks.h |   581 +
 .../gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_regs.h  |   245 +
 .../asic_reg/dcore0_vdec0_ctrl_special_regs.h      |   185 +
 .../gaudi2/asic_reg/dcore1_mme_ctrl_lo_regs.h      |   163 +
 .../gaudi2/asic_reg/dcore3_mme_ctrl_lo_regs.h      |   163 +
 .../gaudi2/asic_reg/gaudi2_blocks_linux_driver.h   | 45067 +++++++++++++++++++
 .../include/gaudi2/asic_reg/gaudi2_regs.h          |   550 +
 .../include/gaudi2/asic_reg/nic0_qm0_cgm_regs.h    |    29 +
 .../include/gaudi2/asic_reg/nic0_qm0_regs.h        |  1057 +
 .../gaudi2/asic_reg/nic0_qm_arc_aux0_regs.h        |   591 +
 .../include/gaudi2/asic_reg/nic0_qpc0_regs.h       |   905 +
 .../nic0_umr0_0_completion_queue_ci_1_regs.h       |    27 +
 .../asic_reg/nic0_umr0_0_unsecure_doorbell0_regs.h |    31 +
 .../include/gaudi2/asic_reg/pcie_aux_regs.h        |   293 +
 .../include/gaudi2/asic_reg/pcie_dbi_regs.h        |   422 +
 .../include/gaudi2/asic_reg/pcie_dec0_cmd_masks.h  |   229 +
 .../include/gaudi2/asic_reg/pcie_dec0_cmd_regs.h   |    85 +
 .../pcie_vdec0_brdg_ctrl_axuser_dec_regs.h         |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h  |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h    |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h    |    61 +
 .../pcie_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h    |    61 +
 .../gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_masks.h   |   580 +
 .../gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_regs.h    |   245 +
 .../gaudi2/asic_reg/pcie_vdec0_ctrl_special_regs.h |   185 +
 .../include/gaudi2/asic_reg/pcie_wrap_regs.h       |   601 +
 .../gaudi2/asic_reg/pdma0_core_ctx_axuser_regs.h   |    61 +
 .../include/gaudi2/asic_reg/pdma0_core_ctx_regs.h  |    95 +
 .../include/gaudi2/asic_reg/pdma0_core_masks.h     |   415 +
 .../include/gaudi2/asic_reg/pdma0_core_regs.h      |   157 +
 .../gaudi2/asic_reg/pdma0_core_special_masks.h     |   135 +
 .../gaudi2/asic_reg/pdma0_qm_arc_aux_regs.h        |   591 +
 .../asic_reg/pdma0_qm_axuser_nonsecured_regs.h     |    61 +
 .../gaudi2/asic_reg/pdma0_qm_axuser_secured_regs.h |    61 +
 .../include/gaudi2/asic_reg/pdma0_qm_cgm_regs.h    |    29 +
 .../include/gaudi2/asic_reg/pdma0_qm_masks.h       |  1165 +
 .../include/gaudi2/asic_reg/pdma0_qm_regs.h        |  1057 +
 .../gaudi2/asic_reg/pdma1_core_ctx_axuser_regs.h   |    61 +
 .../asic_reg/pdma1_qm_axuser_nonsecured_regs.h     |    61 +
 .../include/gaudi2/asic_reg/pmmu_hbw_stlb_masks.h  |   334 +
 .../include/gaudi2/asic_reg/pmmu_hbw_stlb_regs.h   |   141 +
 .../include/gaudi2/asic_reg/pmmu_pif_regs.h        |   135 +
 .../include/gaudi2/asic_reg/psoc_etr_masks.h       |   311 +
 .../include/gaudi2/asic_reg/psoc_etr_regs.h        |   115 +
 .../gaudi2/asic_reg/psoc_global_conf_masks.h       |  1406 +
 .../gaudi2/asic_reg/psoc_global_conf_regs.h        |  1337 +
 .../gaudi2/asic_reg/psoc_reset_conf_masks.h        |  2321 +
 .../include/gaudi2/asic_reg/psoc_reset_conf_regs.h |   989 +
 .../include/gaudi2/asic_reg/psoc_timestamp_regs.h  |    57 +
 .../include/gaudi2/asic_reg/rot0_desc_regs.h       |   155 +
 .../include/gaudi2/asic_reg/rot0_masks.h           |   313 +
 .../include/gaudi2/asic_reg/rot0_qm_arc_aux_regs.h |   591 +
 .../asic_reg/rot0_qm_axuser_nonsecured_regs.h      |    61 +
 .../include/gaudi2/asic_reg/rot0_qm_cgm_regs.h     |    29 +
 .../include/gaudi2/asic_reg/rot0_qm_regs.h         |  1057 +
 .../habanalabs/include/gaudi2/asic_reg/rot0_regs.h |   111 +
 .../include/gaudi2/asic_reg/xbar_edge_0_regs.h     |   199 +
 .../include/gaudi2/asic_reg/xbar_mid_0_regs.h      |   199 +
 drivers/misc/habanalabs/include/gaudi2/gaudi2.h    |   123 +
 .../include/gaudi2/gaudi2_async_events.h           |   963 +
 .../include/gaudi2/gaudi2_async_ids_map_extended.h |  2668 ++
 .../include/gaudi2/gaudi2_async_virt_events.h      |    57 +
 .../habanalabs/include/gaudi2/gaudi2_coresight.h   |   984 +
 .../misc/habanalabs/include/gaudi2/gaudi2_fw_if.h  |    99 +
 .../habanalabs/include/gaudi2/gaudi2_packets.h     |   197 +
 .../habanalabs/include/gaudi2/gaudi2_reg_map.h     |    59 +
 .../misc/habanalabs/include/goya/goya_packets.h    |    12 -
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |    14 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v2_0.h   |    51 +
 include/uapi/misc/habanalabs.h                     |   541 +-
 210 files changed, 159385 insertions(+), 1164 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/decoder.c
 create mode 100644 drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c
 create mode 100644 drivers/misc/habanalabs/common/security.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/Makefile
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2P.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_coresight_regs.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_security.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/arc/gaudi2_arc_common_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_acp_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_aux_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_dup_eng_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_dup_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_axuser_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_kdma_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_dec0_cmd_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_dec0_cmd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma1_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma1_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_mmu_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_acc_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout0_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout0_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout1_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout1_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in0_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in0_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in1_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in1_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in2_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in2_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in3_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in3_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in4_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in4_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_base_addr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_non_tensor_end_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_non_tensor_start_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_a_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_b_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_mme_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_acp_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_dup_eng_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_dup_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_axuser_secured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_sbte0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_sbte0_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_wb0_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_prvt_hbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_prvt_lbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_shrd_hbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_shrd_lbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_glbl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_glbl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_mstr_if_axuser_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_objs_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_objs_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_tensor_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_sync_object_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_tensor_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_busmon_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_etf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_funnel_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_spmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_stm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_dec_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_ctrl_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore1_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore3_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_blocks_linux_driver.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm0_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm_arc_aux0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qpc0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_umr0_0_completion_queue_ci_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_umr0_0_unsecure_doorbell0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dbi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dec0_cmd_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dec0_cmd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_dec_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_ctrl_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_special_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_axuser_secured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma1_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma1_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_hbw_stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_hbw_stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_pif_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_etr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_etr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_reset_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_reset_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_desc_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/xbar_edge_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/xbar_mid_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_reg_map.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v2_0.h
