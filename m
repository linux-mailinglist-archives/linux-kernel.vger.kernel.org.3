Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8B50C966
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiDWKzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiDWKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:55:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2481FF544
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650711139; x=1682247139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0UOZgvJ2bmcDdjHLpIX4c2tMkDUj3A2FMChhiL2LOL8=;
  b=bDw/QB+fOHXLj5rxcTXYSpeh+LRtnWUN2KzbRFzwK7PLuyZRL+IB67U7
   qRzL4MAIrE1y8dI2BzsU7zLIe8Wg4Rt4WKBZmRbnRPc91KZsDGer3p0Wy
   YDA4QYuPpbZoypB/3CzIGY05R9puWQqU/7R1thm3JpDXsceW/0lESbb0O
   zxydPr1gptBVEZOj9Hyhxo6BOrgqipX8oV7MuxIGy2ZLMqfyromG/JluJ
   Lw0xIujIN+oTQ4QfKWywnGsL1pe3aenEUY59gscMrHlJV4lzv65wfVRcW
   EMB/LfQg1OtyYnNIsQkSZZ1vJGcE8dpfld9SrE8yLCOBf5h8bufSZ25BD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264659424"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="264659424"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 03:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="869238371"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2022 03:52:17 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niDNA-0000BH-Rf;
        Sat, 23 Apr 2022 10:52:16 +0000
Date:   Sat, 23 Apr 2022 18:52:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [vkoul-dmaengine:next 38/42] WARNING: modpost:
 vmlinux.o(.text+0xc2ea84): Section mismatch in reference from the function
 gpiochip_relres_irq() to the function .exit.text:gxt4500_exit()
Message-ID: <202204231815.vlFfJefM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
head:   99faef48e7a3f878848a2d711af710e36fadbd6e
commit: 643a4a85b0bc7efeb5732fb4563c43c77ba0c6ac [38/42] dmaengine: hidma: In hidma_prep_dma_memset treat value as a single byte
config: riscv-buildonly-randconfig-r002-20220421 (https://download.01.org/0day-ci/archive/20220423/202204231815.vlFfJefM-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=643a4a85b0bc7efeb5732fb4563c43c77ba0c6ac
        git remote add vkoul-dmaengine https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
        git fetch --no-tags vkoul-dmaengine next
        git checkout 643a4a85b0bc7efeb5732fb4563c43c77ba0c6ac
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xc2ea84): Section mismatch in reference from the function gpiochip_relres_irq() to the function .exit.text:gxt4500_exit()
The function gpiochip_relres_irq() references a function in an exit section.
Often the function gxt4500_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of gxt4500_exit.
--
>> WARNING: modpost: vmlinux.o(.text+0x188e5b0): Section mismatch in reference from the function vme_free_consistent() to the variable .exit.text:.LFE5732
The function vme_free_consistent() references a variable in an exit section.
Often the variable .LFE5732 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .LFE5732.
--
>> WARNING: modpost: vmlinux.o(.text+0x1be08ac): Section mismatch in reference from the function sctp_sched_get_sched() to the variable .init.text:.L0
The function sctp_sched_get_sched() references
the variable __init .L0 .
This is often because sctp_sched_get_sched lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF296
FATAL: modpost: extable_entry size hasn't been discovered!
--
>> WARNING: modpost: vmlinux.o(.text+0x1a89c3c): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3680
The function fib_free_table() references
the variable __init .LBE3680.
This is often because fib_free_table lacks a __init
annotation or the annotation of .LBE3680 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bdf950): Section mismatch in reference from the function sctp_auth_asoc_set_default_hmac() to the variable .exit.text:.LVL24
The function sctp_auth_asoc_set_default_hmac() references a variable in an exit section.
Often the variable .LVL24 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .LVL24.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bdf9cc): Section mismatch in reference from the function sctp_auth_send_cid() to the variable .init.text:.LVL0
The function sctp_auth_send_cid() references
the variable __init .LVL0.
This is often because sctp_auth_send_cid lacks a __init
annotation or the annotation of .LVL0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1be06d0): Section mismatch in reference from the function sctp_sched_ops_register() to the variable .init.text:.L0
The function sctp_sched_ops_register() references
the variable __init .L0 .
This is often because sctp_sched_ops_register lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1be0718): Section mismatch in reference from the function sctp_sched_set_sched() to the variable .init.text:.L0
The function sctp_sched_set_sched() references
the variable __init .L0 .
This is often because sctp_sched_set_sched lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284
<< WARNING: modpost: vmlinux.o(.text+0xa570d0): Section mismatch in reference from the function blkdev_get_no_open() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xa57164): Section mismatch in reference from the function blkdev_get_by_dev() to the variable .exit.text:.LFE4493
<< WARNING: modpost: vmlinux.o(.text+0xdc547c): Section mismatch in reference from the function dss_dispc_uninitialize_irq() to the variable .init.text:.L20
<< WARNING: modpost: vmlinux.o(.text+0x10c05ec): Section mismatch in reference from the function nvmet_exit_discovery() to the variable .exit.text:.LVL53
<< WARNING: modpost: vmlinux.o(.text+0x1a89c24): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.LBE3661
<< WARNING: modpost: vmlinux.o(.text+0x1ad8528): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF284

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
