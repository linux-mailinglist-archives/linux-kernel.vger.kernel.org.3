Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0594F6227
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiDFOuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiDFOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:49:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D55EC1AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649244243; x=1680780243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uNoUd5cBdwRj0mH2oEvIrN6RW+fASFoNNEfnU9Civ+Y=;
  b=IC7rXSHABKFTtIN2j9z2XL97OJcOzBt4CCHsUry0XujJ7z/hasE+ooEF
   iw8hXKOF4toZn+IQs6WwhG2zryDUg/pNZQOV2ZRjIqizmjoY8plLHtseQ
   BrBtPyexBkek4MO/3nqpqWCJQPAu8NfyE77SYuh4GO7/zhWnDs8NwyK8l
   bTyvwQgshB80vIVhGV9yUxFiLZQPZZLYSK3Xm6mC26qfhEUd5NbSw/SVf
   etvYdXDA4I6CHx34qIFtoy0JEnt3FMz8Yzr1cKaCRpJZ5afdD4rLqooWh
   asYz5OOlPbeB7F5EtEabjebPkZBq7N3u4ZRrqW+yxUOj9WwMg067PUqj6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261197246"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="261197246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="523889287"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2022 04:24:00 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc3lX-0004MF-Fz;
        Wed, 06 Apr 2022 11:23:59 +0000
Date:   Wed, 6 Apr 2022 19:23:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/rcu/next 109/110] WARNING:
 modpost: vmlinux.o(.text+0x9dc07c): Section mismatch in reference from the
 function scsi_device_dev_release_usercontext() to the function
 .exit.text:exit_ntfs_fs()
Message-ID: <202204061911.n6Uo7ofC-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/rcu/next
head:   d0c78768fd9c838d9c4f1965a33ce7f51f16a319
commit: ec583e2e8d0934891c976402ec1f7ed144539e7c [109/110] rcu: Add polled expedited grace-period primitives
config: riscv-buildonly-randconfig-r004-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061911.n6Uo7ofC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/ec583e2e8d0934891c976402ec1f7ed144539e7c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/rcu/next
        git checkout ec583e2e8d0934891c976402ec1f7ed144539e7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x9dc07c): Section mismatch in reference from the function scsi_device_dev_release_usercontext() to the function .exit.text:exit_ntfs_fs()
The function scsi_device_dev_release_usercontext() references a function in an exit section.
Often the function exit_ntfs_fs() has valid usage outside the exit section
and the fix is to remove the __exit annotation of exit_ntfs_fs.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f94c4): Section mismatch in reference from the function iscsi_nop_out_rsp() to the variable .init.text:.LBB1_24
The function iscsi_nop_out_rsp() references
the variable __init .LBB1_24.
This is often because iscsi_nop_out_rsp lacks a __init
annotation or the annotation of .LBB1_24 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9f97a2): Section mismatch in reference from the function iscsi_queuecommand() to the function .init.text:set_reset_devices()
The function iscsi_queuecommand() references
the function __init set_reset_devices().
This is often because iscsi_queuecommand lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9fbf08): Section mismatch in reference from the function iscsi_session_setup() to the variable .init.text:.LBB1_20
The function iscsi_session_setup() references
the variable __init .LBB1_20.
This is often because iscsi_session_setup lacks a __init
annotation or the annotation of .LBB1_20 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9fc2f8): Section mismatch in reference from the function iscsi_session_teardown() to the variable .init.text:.LBB1_22
The function iscsi_session_teardown() references
the variable __init .LBB1_22.
This is often because iscsi_session_teardown lacks a __init
annotation or the annotation of .LBB1_22 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9fc334): Section mismatch in reference from the function iscsi_conn_setup() to the function .init.text:set_reset_devices()
The function iscsi_conn_setup() references
the function __init set_reset_devices().
This is often because iscsi_conn_setup lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9fca86): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_23
The function iscsi_conn_teardown() references
the variable __init .LBB1_23.
This is often because iscsi_conn_teardown lacks a __init
annotation or the annotation of .LBB1_23 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9fcb8e): Section mismatch in reference from the function iscsi_conn_teardown() to the function .init.text:set_reset_devices()
The function iscsi_conn_teardown() references
the function __init set_reset_devices().
This is often because iscsi_conn_teardown lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xa2a88c): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_28
The function ses_intf_add() references
the variable __init .LBB1_28.
This is often because ses_intf_add lacks a __init
annotation or the annotation of .LBB1_28 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xa2c158): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_47
The function hisi_sas_scan_finished() references
the variable __init .LBB1_47.
This is often because hisi_sas_scan_finished lacks a __init
annotation or the annotation of .LBB1_47 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xa2cbd4): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the variable .init.text:.LBB1_48
The function hisi_sas_bytes_dmaed() references
the variable __init .LBB1_48.
This is often because hisi_sas_bytes_dmaed lacks a __init
annotation or the annotation of .LBB1_48 is wrong.
..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x9deee2): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9e0b30): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x9eb04e): Section mismatch in reference from the function sas_try_ata_reset() to the variable .init.text:.LBB1_41
<< WARNING: modpost: vmlinux.o(.text+0x9fc074): Section mismatch in reference from the function iscsi_conn_setup() to the variable .init.text:.LBB1_21
<< WARNING: modpost: vmlinux.o(.text+0x9fc7c6): Section mismatch in reference from the function iscsi_conn_teardown() to the variable .init.text:.LBB1_22
<< WARNING: modpost: vmlinux.o(.text+0xa2a5c0): Section mismatch in reference from the function ses_intf_add() to the variable .init.text:.LBB1_36
<< WARNING: modpost: vmlinux.o(.text+0xa2a5cc): Section mismatch in reference from the function ses_intf_add() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2be98): Section mismatch in reference from the function hisi_sas_scan_finished() to the variable .init.text:.LBB1_45
<< WARNING: modpost: vmlinux.o(.text+0xa2c70a): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xa2c852): Section mismatch in reference from the function hisi_sas_bytes_dmaed() to the function .init.text:set_reset_devices()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
