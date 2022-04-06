Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C044F6D62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiDFVv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiDFVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:10 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA9973048
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649281248; x=1680817248;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gUyL6FycKb23LNc76jSKk5EEtkEsBex0zJxT/AWzp18=;
  b=FEsPKxMsTjb60smYlqWrlrNp/dp3OD78Kufc/E6VTS+rawY58b0ps+mB
   3VqTGQNu33/2JtLizPlLKsKaQft602k/tuCaYe+CA5JUcyyzri7OsEMDs
   JZcf3gtJqEsUsinLWMq9YUcouYUqFj37o3LphwNvJwbUBdyw5ovFnffuv
   ZTheg0KPE/qpwP6eLefJ6Xa+HZWo1C+jS7/jvrvIbFpi/KfxE/UnGMFD2
   tFyOlDm+sZucN0M2Qj2MMOGzQqIO+/Q8chpnFYSPAMJcbYStwyTtWmj7O
   nUo5tbP38uzTUEtoyb5a4Kazgxcnlr+VxTgbGIsjQS5C0lUGhqGBCfSZo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321855503"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="321855503"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 14:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="642223827"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2022 14:40:45 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncDOP-0004n1-4i;
        Wed, 06 Apr 2022 21:40:45 +0000
Date:   Thu, 07 Apr 2022 05:40:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS WITH WARNING
 d0c78768fd9c838d9c4f1965a33ce7f51f16a319
Message-ID: <624e08ce.Di/sYWwBRoerfg4W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d0c78768fd9c838d9c4f1965a33ce7f51f16a319  rcu: Fix expedited GP polling against UP/no-preempt environment

Warning reports:

https://lore.kernel.org/lkml/202204061528.kzz0m3tZ-lkp@intel.com
https://lore.kernel.org/lkml/202204061911.n6Uo7ofC-lkp@intel.com

Warning: (recently discovered and may have been fixed)

WARNING: modpost: vmlinux.o(.data+0x179b3c): Section mismatch in reference from the variable iscsi_flashnode_bus to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.data+0x17bad4): Section mismatch in reference from the variable sft to the variable .init.text:.LBB1_45
WARNING: modpost: vmlinux.o(.data+0x280968): Section mismatch in reference from the variable dev_attr_topology_change_detected to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.data+0x285644): Section mismatch in reference from the variable reg_regdb_work to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.data+0x28bc80): Section mismatch in reference from the variable string_tree_lock to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.init.setup+0x73c): Section mismatch in reference from the variable __setup_debug_boot_weak_hash_enable to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.init.text+0x460f2): Section mismatch in reference from the function scsi_init_devinfo() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.init.text+0x7340e): Section mismatch in reference from the function xbc_node_find_next_leaf() to the variable .exit.text:.LBB3_6
WARNING: modpost: vmlinux.o(.text+0x10d82f0): Section mismatch in reference from the function multipath_clone_and_map() to the variable .exit.text:.LBB0_3
WARNING: modpost: vmlinux.o(.text+0x10da0ae): Section mismatch in reference from the function activate_path_work() to the variable .exit.text:.LBB0_3
WARNING: modpost: vmlinux.o(.text+0x14b5336): Section mismatch in reference from the function rds_sysctl_init() to the function .meminit.text:init_reserve_notifier()
WARNING: modpost: vmlinux.o(.text+0x15abf1a): Section mismatch in reference from the function ceph_strings_empty() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9dc07c): Section mismatch in reference from the function scsi_device_dev_release_usercontext() to the function .exit.text:exit_ntfs_fs()
WARNING: modpost: vmlinux.o(.text+0x9deeba): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0x9e0b08): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0x9e10bc): Section mismatch in reference from the function spi_device_configure() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0x9e2518): Section mismatch in reference from the function iscsi_create_session() to the variable .init.text:.LBB1_20
WARNING: modpost: vmlinux.o(.text+0x9e2526): Section mismatch in reference from the function iscsi_create_session() to the variable .init.text:.LBB1_21
WARNING: modpost: vmlinux.o(.text+0x9e8004): Section mismatch in reference from the function do_sas_phy_delete() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9e85cc): Section mismatch in reference from the function sas_port_alloc_num() to the variable .init.text:.LBB1_31
WARNING: modpost: vmlinux.o(.text+0x9eb084): Section mismatch in reference from the function sas_phy_enable() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9eb14a): Section mismatch in reference from the function transport_sas_phy_reset() to the variable .init.text:.LBB1_42
WARNING: modpost: vmlinux.o(.text+0x9eb26a): Section mismatch in reference from the function sas_phy_reset() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9eb30e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_42
WARNING: modpost: vmlinux.o(.text+0x9eb336): Section mismatch in reference from the function sas_set_phy_speed() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9eb432): Section mismatch in reference from the function transport_sas_phy_reset() to the variable .init.text:.LBB1_44
WARNING: modpost: vmlinux.o(.text+0x9eb886): Section mismatch in reference from the function sas_get_linkerrors() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9ebc18): Section mismatch in reference from the function queue_phy_reset() to the variable .init.text:.LBB1_47
WARNING: modpost: vmlinux.o(.text+0x9ebcc0): Section mismatch in reference from the function queue_phy_enable() to the variable .init.text:.LBB1_47
WARNING: modpost: vmlinux.o(.text+0x9ebe40): Section mismatch in reference from the function phy_enable_work() to the variable .init.text:.LBB1_43
WARNING: modpost: vmlinux.o(.text+0x9ec176): Section mismatch in reference from the function sas_deform_port() to the variable .init.text:.LBB1_34
WARNING: modpost: vmlinux.o(.text+0x9ec504): Section mismatch in reference from the function sas_form_port() to the variable .init.text:.LBB1_31
WARNING: modpost: vmlinux.o(.text+0x9ec824): Section mismatch in reference from the function sas_queue_deferred_work() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9ecd24): Section mismatch in reference from the function sas_enable_revalidation() to the variable .init.text:.LBB1_48
WARNING: modpost: vmlinux.o(.text+0x9ed4c8): Section mismatch in reference from the function sas_destruct_devices() to the variable .init.text:.LBB1_27
WARNING: modpost: vmlinux.o(.text+0x9ed4d2): Section mismatch in reference from the function sas_destruct_devices() to the variable .init.text:.LBB1_33
WARNING: modpost: vmlinux.o(.text+0x9ed72c): Section mismatch in reference from the function sas_unregister_dev() to the variable .init.text:.LBB1_37
WARNING: modpost: vmlinux.o(.text+0x9ee26e): Section mismatch in reference from the function sas_ex_to_ata() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9ee59a): Section mismatch in reference from the function sas_smp_get_phy_events() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9ee8e2): Section mismatch in reference from the function sas_discover_expander() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9ef2b2): Section mismatch in reference from the function sas_smp_handler() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9ef89e): Section mismatch in reference from the function sas_set_ex_phy() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9efbba): Section mismatch in reference from the function sas_set_ex_phy() to the variable .init.text:.LBB1_30
WARNING: modpost: vmlinux.o(.text+0x9f073c): Section mismatch in reference from the function sas_ex_discover_dev() to the variable .init.text:.LBB1_31
WARNING: modpost: vmlinux.o(.text+0x9f220c): Section mismatch in reference from the function sas_unregister_devs_sas_addr() to the variable .init.text:.LBB1_34
WARNING: modpost: vmlinux.o(.text+0x9f26f4): Section mismatch in reference from the function sas_queue_reset() to the variable .init.text:.LBB1_42
WARNING: modpost: vmlinux.o(.text+0x9f2fa8): Section mismatch in reference from the function sas_target_alloc() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9f3320): Section mismatch in reference from the function sas_slave_configure() to the variable .init.text:.LBB1_35
WARNING: modpost: vmlinux.o(.text+0x9f4f9c): Section mismatch in reference from the function sas_ata_qc_issue() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9f92a6): Section mismatch in reference from the function iscsi_session_failure() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9f94c4): Section mismatch in reference from the function iscsi_nop_out_rsp() to the variable .init.text:.LBB1_24
WARNING: modpost: vmlinux.o(.text+0x9f97a2): Section mismatch in reference from the function iscsi_queuecommand() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9fbb1a): Section mismatch in reference from the function iscsi_notify_host_removed() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9fbf08): Section mismatch in reference from the function iscsi_session_setup() to the variable .init.text:.LBB1_20
WARNING: modpost: vmlinux.o(.text+0x9fc2f8): Section mismatch in reference from the function iscsi_session_teardown() to the variable .init.text:.LBB1_22
WARNING: modpost: vmlinux.o(.text+0x9fc334): Section mismatch in reference from the function iscsi_conn_setup() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0x9fca86): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_23
WARNING: modpost: vmlinux.o(.text+0x9fcb8e): Section mismatch in reference from the function iscsi_conn_teardown() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0xa2a88c): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_28
WARNING: modpost: vmlinux.o(.text+0xa2c158): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_47
WARNING: modpost: vmlinux.o(.text+0xa2c6e2): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0xa2cbd4): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the variable .init.text:.LBB1_48
WARNING: modpost: vmlinux.o(.text+0xa2dc2e): Section mismatch in reference from the function hisi_sas_remove() to the function .init.text:set_reset_devices()
WARNING: modpost: vmlinux.o(.text+0xa2df0a): Section mismatch in reference from the function hisi_sas_remove() to the variable .init.text:.LBB1_41
WARNING: modpost: vmlinux.o(.text+0xa3263e): Section mismatch in reference from the function int_bcast_v1_hw() to the variable .init.text:.LBB1_48
WARNING: modpost: vmlinux.o(.text+0xa55448): Section mismatch in reference from the function ata_scsi_set_sense_information() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa56c1a): Section mismatch in reference from the function ata_scsi_set_invalid_field() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa5807c): Section mismatch in reference from the function ata_scsi_rw_xlat() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa58238): Section mismatch in reference from the function ata_scsi_write_same_xlat() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa5859e): Section mismatch in reference from the function ata_scsi_verify_xlat() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa58872): Section mismatch in reference from the function ata_scsi_pass_thru() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa58ca4): Section mismatch in reference from the function ata_scsi_mode_select_xlat() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa591ba): Section mismatch in reference from the function ata_scsi_zbc_out_xlat() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa5944c): Section mismatch in reference from the function ata_scsi_security_inout_xlat() to the function .exit.text:test_ww_mutex_exit()
WARNING: modpost: vmlinux.o(.text+0xa59810): Section mismatch in reference from the function ata_scsi_set_invalid_parameter() to the function .exit.text:test_ww_mutex_exit()

Warning ids grouped by kconfigs:

clang_recent_errors
`-- riscv-buildonly-randconfig-r004-20220405
    |-- Section-mismatch-in-reference-from-the-function-activate_path_work()-to-the-variable-.exit.text:.LBB0_3
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_mode_select_xlat()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_pass_thru()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_rw_xlat()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_security_inout_xlat()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_set_invalid_field()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_set_invalid_parameter()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_set_sense_information()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_verify_xlat()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_write_same_xlat()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ata_scsi_zbc_out_xlat()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ceph_strings_empty()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-child_iter()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-do_sas_phy_delete()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-hisi_sas_bytes_dmaed()-to-the-variable-.init.text:.LBB1_48
    |-- Section-mismatch-in-reference-from-the-function-hisi_sas_phy_down()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-hisi_sas_remove()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-hisi_sas_remove()-to-the-variable-.init.text:.LBB1_41
    |-- Section-mismatch-in-reference-from-the-function-hisi_sas_scan_finished()-to-the-variable-.init.text:.LBB1_47
    |-- Section-mismatch-in-reference-from-the-function-int_bcast_v1_hw()-to-the-variable-.init.text:.LBB1_48
    |-- Section-mismatch-in-reference-from-the-function-iscsi_conn_setup()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-iscsi_conn_teardown()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-iscsi_conn_teardown()-to-the-variable-.init.text:.LBB1_23
    |-- Section-mismatch-in-reference-from-the-function-iscsi_create_session()-to-the-variable-.init.text:.LBB1_20
    |-- Section-mismatch-in-reference-from-the-function-iscsi_create_session()-to-the-variable-.init.text:.LBB1_21
    |-- Section-mismatch-in-reference-from-the-function-iscsi_nop_out_rsp()-to-the-variable-.init.text:.LBB1_24
    |-- Section-mismatch-in-reference-from-the-function-iscsi_notify_host_removed()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-iscsi_queuecommand()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-iscsi_session_failure()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-iscsi_session_setup()-to-the-variable-.init.text:.LBB1_20
    |-- Section-mismatch-in-reference-from-the-function-iscsi_session_teardown()-to-the-variable-.init.text:.LBB1_22
    |-- Section-mismatch-in-reference-from-the-function-multipath_clone_and_map()-to-the-variable-.exit.text:.LBB0_3
    |-- Section-mismatch-in-reference-from-the-function-phy_enable_work()-to-the-variable-.init.text:.LBB1_43
    |-- Section-mismatch-in-reference-from-the-function-queue_phy_enable()-to-the-variable-.init.text:.LBB1_47
    |-- Section-mismatch-in-reference-from-the-function-queue_phy_reset()-to-the-variable-.init.text:.LBB1_47
    |-- Section-mismatch-in-reference-from-the-function-rds_sysctl_init()-to-the-function-.meminit.text:init_reserve_notifier()
    |-- Section-mismatch-in-reference-from-the-function-sas_ata_qc_issue()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_deform_port()-to-the-variable-.init.text:.LBB1_34
    |-- Section-mismatch-in-reference-from-the-function-sas_destruct_devices()-to-the-variable-.init.text:.LBB1_27
    |-- Section-mismatch-in-reference-from-the-function-sas_destruct_devices()-to-the-variable-.init.text:.LBB1_33
    |-- Section-mismatch-in-reference-from-the-function-sas_discover_expander()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_enable_revalidation()-to-the-variable-.init.text:.LBB1_48
    |-- Section-mismatch-in-reference-from-the-function-sas_ex_discover_dev()-to-the-variable-.init.text:.LBB1_31
    |-- Section-mismatch-in-reference-from-the-function-sas_ex_to_ata()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_form_port()-to-the-variable-.init.text:.LBB1_31
    |-- Section-mismatch-in-reference-from-the-function-sas_get_linkerrors()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_phy_enable()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_phy_reset()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_port_alloc_num()-to-the-variable-.init.text:.LBB1_31
    |-- Section-mismatch-in-reference-from-the-function-sas_queue_deferred_work()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_queue_reset()-to-the-variable-.init.text:.LBB1_42
    |-- Section-mismatch-in-reference-from-the-function-sas_set_ex_phy()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_set_ex_phy()-to-the-variable-.init.text:.LBB1_30
    |-- Section-mismatch-in-reference-from-the-function-sas_set_phy_speed()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_slave_configure()-to-the-variable-.init.text:.LBB1_35
    |-- Section-mismatch-in-reference-from-the-function-sas_smp_get_phy_events()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_smp_handler()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_target_alloc()-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-function-sas_try_ata_reset()-to-the-variable-.init.text:.LBB1_42
    |-- Section-mismatch-in-reference-from-the-function-sas_unregister_dev()-to-the-variable-.init.text:.LBB1_37
    |-- Section-mismatch-in-reference-from-the-function-sas_unregister_devs_sas_addr()-to-the-variable-.init.text:.LBB1_34
    |-- Section-mismatch-in-reference-from-the-function-scsi_device_dev_release_usercontext()-to-the-function-.exit.text:exit_ntfs_fs()
    |-- Section-mismatch-in-reference-from-the-function-scsi_init_devinfo()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-ses_intf_add()-to-the-variable-.init.text:.LBB1_28
    |-- Section-mismatch-in-reference-from-the-function-spi_device_configure()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-spi_dv_device_work_wrapper()-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-function-transport_sas_phy_reset()-to-the-variable-.init.text:.LBB1_42
    |-- Section-mismatch-in-reference-from-the-function-transport_sas_phy_reset()-to-the-variable-.init.text:.LBB1_44
    |-- Section-mismatch-in-reference-from-the-function-xbc_node_find_next_leaf()-to-the-variable-.exit.text:.LBB3_6
    |-- Section-mismatch-in-reference-from-the-variable-debug_boot_weak_hash_enable-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-variable-dev_attr_topology_change_detected-to-the-function-.init.text:set_reset_devices()
    |-- Section-mismatch-in-reference-from-the-variable-iscsi_flashnode_bus-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-variable-reg_regdb_work-to-the-function-.exit.text:test_ww_mutex_exit()
    |-- Section-mismatch-in-reference-from-the-variable-sft-to-the-variable-.init.text:.LBB1_45
    `-- Section-mismatch-in-reference-from-the-variable-string_tree_lock-to-the-function-.init.text:set_reset_devices()

elapsed time: 1097m

configs tested: 119
configs skipped: 3

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                        spear6xx_defconfig
sh                        sh7757lcr_defconfig
xtensa                generic_kc705_defconfig
sh                           se7712_defconfig
m68k                         apollo_defconfig
mips                      loongson3_defconfig
arc                     haps_hs_smp_defconfig
xtensa                           alldefconfig
sparc                               defconfig
sh                           se7343_defconfig
openrisc                            defconfig
openrisc                         alldefconfig
sh                        edosk7705_defconfig
m68k                          atari_defconfig
arm                           stm32_defconfig
powerpc                     stx_gp3_defconfig
parisc                              defconfig
powerpc                      cm5200_defconfig
sh                        sh7763rdp_defconfig
sh                               j2_defconfig
um                           x86_64_defconfig
powerpc                       eiger_defconfig
sh                         ap325rxa_defconfig
powerpc                   currituck_defconfig
ia64                             alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
ia64                         bigsur_defconfig
arm                      jornada720_defconfig
arm                  randconfig-c002-20220406
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220406
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc                    mvme5100_defconfig
mips                           ip28_defconfig
powerpc                      pmac32_defconfig
powerpc                      ppc64e_defconfig
arm                       aspeed_g4_defconfig
arm                        vexpress_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
