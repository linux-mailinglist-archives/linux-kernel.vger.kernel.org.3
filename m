Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86644F0D33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 02:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376794AbiDDAVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 20:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347200AbiDDAVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 20:21:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837622BC9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649031591; x=1680567591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vCBUk9WUML4QZmL5I49hRzwJvG/v/5pZUE/h0WAogjo=;
  b=ZCNgTJ3fqlGZ2Nx5dqxxvif/1XQmLB90akAzhuEuLaBtkbUdmgYW42us
   3uvy76bbBDT3fEx7M8iMu9wsi9P9l6347o0bNOm2m/rE03g957fb2wsGs
   4JoNJYruAtVxHEv6Mg6MTGDM1Ibj9zENtUwB6CO5+O/dAOcmlLCQoGlCr
   2cAdGBCG61U5L+A4jL0N1BkrIkcP1AxVX2Kq4HLy6NLvR9GiULCLxMJ7i
   id8dxF4H4BCJR/7YB7c0brRVD3e84iW0ZW0yckx97lsRLutg0OsLLUZ0z
   CgJWn+G3uEOc7REQrQaRAxYxrUOnsw0m/oBWRNeukgnpkudp1jmd1obGI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260596104"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="260596104"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 17:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="721466695"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2022 17:19:49 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbARh-0001J2-1D;
        Mon, 04 Apr 2022 00:19:49 +0000
Date:   Mon, 4 Apr 2022 08:18:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a 136/158]
 WARNING: modpost: vmlinux.o(.text+0x28d3a): Section mismatch in reference
 from the function cpu_in_idle() to the variable .init.text:.LVL79
Message-ID: <202204040803.eMjcdkZh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
head:   d9f3e7d671416fdf5b61f094765754269b652db0
commit: 4a8d065a72d07894b2d9f976ffa9ee4ab1f8abb4 [136/158] refscale: Allow refscale without RCU Tasks
config: riscv-randconfig-r002-20220403 (https://download.01.org/0day-ci/archive/20220404/202204040803.eMjcdkZh-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4a8d065a72d07894b2d9f976ffa9ee4ab1f8abb4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
        git checkout 4a8d065a72d07894b2d9f976ffa9ee4ab1f8abb4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x28d3a): Section mismatch in reference from the function cpu_in_idle() to the variable .init.text:.LVL79
The function cpu_in_idle() references
the variable __init .LVL79.
This is often because cpu_in_idle lacks a __init
annotation or the annotation of .LVL79 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x81fe66): Section mismatch in reference from the function pccard_sysfs_remove_socket() to the variable .init.text:.LVL163
The function pccard_sysfs_remove_socket() references
the variable __init .LVL163.
This is often because pccard_sysfs_remove_socket lacks a __init
annotation or the annotation of .LVL163 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x967e84): Section mismatch in reference from the function rproc_report_crash() to the variable .init.text:.L0
The function rproc_report_crash() references
the variable __init .L0 .
This is often because rproc_report_crash lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x97395c): Section mismatch in reference from the function sdw_debugfs_exit() to the variable .init.text:.L0
The function sdw_debugfs_exit() references
the variable __init .L0 .
This is often because sdw_debugfs_exit lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xa3373a): Section mismatch in reference from the function snd_pcm_period_elapsed() to the variable .init.text:.L0
The function snd_pcm_period_elapsed() references
the variable __init .L0 .
This is often because snd_pcm_period_elapsed lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xb54e76): Section mismatch in reference from the function br_vlan_tunnel_info() to the variable .init.text:.L0
The function br_vlan_tunnel_info() references
the variable __init .L0 .
This is often because br_vlan_tunnel_info lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xbd1d50): Section mismatch in reference from the function batadv_v_mesh_free() to the variable .init.text:.L0
The function batadv_v_mesh_free() references
the variable __init .L0 .
This is often because batadv_v_mesh_free lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xd24c8): Section mismatch in reference from the function wb_wakeup_delayed() to the variable .exit.text:.L0
The function wb_wakeup_delayed() references a variable in an exit section.
Often the variable .L0 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .L0 .
--
>> WARNING: modpost: vmlinux.o(.text+0x378a4a): Section mismatch in reference from the function drm_mode_equal() to the variable .init.text:.LBB506
The function drm_mode_equal() references
the variable __init .LBB506.
This is often because drm_mode_equal lacks a __init
annotation or the annotation of .LBB506 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x378a54): Section mismatch in reference from the function drm_mode_equal_no_clocks() to the variable .init.text:.LBB506
The function drm_mode_equal_no_clocks() references
the variable __init .LBB506.
This is often because drm_mode_equal_no_clocks lacks a __init
annotation or the annotation of .LBB506 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
<< WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
<< WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
<< WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
<< WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
<< WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
