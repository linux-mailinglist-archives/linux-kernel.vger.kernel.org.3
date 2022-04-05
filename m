Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADF4F4A82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457880AbiDEWrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573214AbiDESY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:24:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7434B1F7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649182948; x=1680718948;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t+jqLhXF602tscQP97f4wSy1QeXsfz6MXjAFbX6OTrk=;
  b=BhiNqPOwRlk6V1gdES5Diuo8bZ3ZPWbs5ogLtRs0JkPN7ZQVxvSQf6tJ
   BCV4Etb+hEAHgloRG9WrlrdtzgPJPmO2jnTJI54k/MGHd9LqwkJ05kZCi
   1WlZDNE5EZshuwYFf3sE5ctVNJbAuTrPg9U4T+DkhOVnbcYtEXo1uaW3P
   HVesIlUFPL19P+wl6nVvHL69Aah/Q6Nvxn0+jC3zkwDd2Tp4N+9eLOz4h
   Eds7GXCVrr6N3mk++17H2jBEwmcBp598E6m3IgIoZjc/mc3sz7n4iEwPL
   MhtUwy/gzV7xA7PH9K0GFKmmjTw0fo0mwG2T8eT3RarA9HhiOkQlUT5YQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260824251"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260824251"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 11:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="588035653"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 11:22:25 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbnov-0003ev-16;
        Tue, 05 Apr 2022 18:22:25 +0000
Date:   Wed, 6 Apr 2022 02:21:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [yu-chen-surf:sched 1/2] WARNING: modpost:
 vmlinux.o(.text+0x9e24b8): Section mismatch in reference from the function
 iscsi_create_session() to the function .exit.text:test_ww_mutex_exit()
Message-ID: <202204060222.wCunKJY5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/yu-chen-surf/linux.git sched
head:   b5da2faf435871f1c615da2e336976fb6455fe53
commit: c319c5f71d3359991a7cde110c1382a3f0c2ed8d [1/2] sched/fair: Don't rely on ->exec_start for migration
config: riscv-buildonly-randconfig-r004-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060222.wCunKJY5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/yu-chen-surf/linux/commit/c319c5f71d3359991a7cde110c1382a3f0c2ed8d
        git remote add yu-chen-surf https://github.com/yu-chen-surf/linux.git
        git fetch --no-tags yu-chen-surf sched
        git checkout c319c5f71d3359991a7cde110c1382a3f0c2ed8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x9e24b8): Section mismatch in reference from the function iscsi_create_session() to the function .exit.text:test_ww_mutex_exit()
The function iscsi_create_session() references a function in an exit section.
Often the function test_ww_mutex_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of test_ww_mutex_exit.
--
>> WARNING: modpost: vmlinux.o(.text+0x9eb23c): Section mismatch in reference from the function sas_unregister_ha() to the function .init.text:set_reset_devices()
The function sas_unregister_ha() references
the function __init set_reset_devices().
This is often because sas_unregister_ha lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f2398): Section mismatch in reference from the function sas_queuecommand() to the function .init.text:set_reset_devices()
The function sas_queuecommand() references
the function __init set_reset_devices().
This is often because sas_queuecommand lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f23e4): Section mismatch in reference from the function sas_queuecommand() to the variable .init.text:.LBB1_22
The function sas_queuecommand() references
the variable __init .LBB1_22.
This is often because sas_queuecommand lacks a __init
annotation or the annotation of .LBB1_22 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f2694): Section mismatch in reference from the function sas_queue_reset() to the function .init.text:set_reset_devices()
The function sas_queue_reset() references
the function __init set_reset_devices().
This is often because sas_queue_reset lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f314e): Section mismatch in reference from the function sas_ioctl() to the function .init.text:set_reset_devices()
The function sas_ioctl() references
the function __init set_reset_devices().
This is often because sas_ioctl lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f3230): Section mismatch in reference from the function sas_target_alloc() to the variable .init.text:.LBB1_25
The function sas_target_alloc() references
the variable __init .LBB1_25.
This is often because sas_target_alloc lacks a __init
annotation or the annotation of .LBB1_25 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f32aa): Section mismatch in reference from the function sas_slave_configure() to the function .init.text:set_reset_devices()
The function sas_slave_configure() references
the function __init set_reset_devices().
This is often because sas_slave_configure lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f3374): Section mismatch in reference from the function sas_change_queue_depth() to the function .init.text:set_reset_devices()
The function sas_change_queue_depth() references
the function __init set_reset_devices().
This is often because sas_change_queue_depth lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f3b9a): Section mismatch in reference from the function sas_abort_task_set() to the function .init.text:set_reset_devices()
The function sas_abort_task_set() references
the function __init set_reset_devices().
This is often because sas_abort_task_set lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f3c04): Section mismatch in reference from the function sas_clear_task_set() to the function .init.text:set_reset_devices()
The function sas_clear_task_set() references
the function __init set_reset_devices().
This is often because sas_clear_task_set lacks a __init
annotation or the annotation of set_reset_devices is wrong.
..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xcdc6e0): Section mismatch in reference from the function ath11k_mac_bcn_tx_event() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xce3040): Section mismatch in reference from the function ath11k_mac_op_ampdu_action() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd233ca): Section mismatch in reference from the function b43_calc_nrssi_slope() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce5966): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .init.text:init_ntfs_fs()
<< WARNING: modpost: vmlinux.o(.text+0xd2401a): Section mismatch in reference from the function b43_set_txpower_g() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24478): Section mismatch in reference from the function b43_set_all_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd2457e): Section mismatch in reference from the function b43_set_original_gains() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xd24758): Section mismatch in reference from the function b43_radio_interference_mitigation_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xce59a4): Section mismatch in reference from the function ath11k_mac_op_assign_vif_chanctx() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xd28972): Section mismatch in reference from the function b43_gphy_dc_lt_init() to the function .init.text:set_reset_devices()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
