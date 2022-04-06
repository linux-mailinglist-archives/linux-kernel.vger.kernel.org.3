Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B165C4F5C10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbiDFLUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244465AbiDFLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:19:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D35473C1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649230854; x=1680766854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sV9b+cScATro9Da3kwZV40I5CBiv4vmg1Aeg62rfn/Y=;
  b=DpP1MfrbanPG5Qd4ptLz8nPJI1RoeXSjWf2irakAx8AjxC8kb1C+0gEt
   xBjIzjqL3VmYc7m9B2WyOIwG3JNdJGZoWwGdYvsljCIFgSbfBuGwWGgkE
   e7hq0gMZru3efiyHJ0jxqztG0D+F9EMxa+nG8LN2rZelXv6lE09th0T4t
   YjCSTpKVgYx1QSaVd0PgOZGJLRyrCkkmYIpJxF8RUnYV2xS2y3EuHchZQ
   0QecvyX09D6WXEPJI+HeP9l3POsioXNrWKU4CYzrJEXLoVovgQSaOvrzA
   l7/eSLptt3xIKUf69i1CrlrXhy2XF8YzlqouyrgEil6WRWTtWI4LKRouf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259810681"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="259810681"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 00:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588266160"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 00:39:53 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc0Ge-0004Bn-Fh;
        Wed, 06 Apr 2022 07:39:52 +0000
Date:   Wed, 6 Apr 2022 15:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/rcu/next 103/110] WARNING:
 modpost: vmlinux.o(.text+0x9deeba): Section mismatch in reference from the
 function spi_dv_device_work_wrapper() to the function
 .exit.text:test_ww_mutex_exit()
Message-ID: <202204061528.kzz0m3tZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/rcu/next
head:   d0c78768fd9c838d9c4f1965a33ce7f51f16a319
commit: d00674235d8d0e85006ad5b107a266e2c7ee594d [103/110] srcu: Prevent expedited GPs and blocking readers from consuming CPU
config: riscv-buildonly-randconfig-r004-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061528.kzz0m3tZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/d00674235d8d0e85006ad5b107a266e2c7ee594d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/rcu/next
        git checkout d00674235d8d0e85006ad5b107a266e2c7ee594d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x9deeba): Section mismatch in reference from the function spi_dv_device_work_wrapper() to the function .exit.text:test_ww_mutex_exit()
The function spi_dv_device_work_wrapper() references a function in an exit section.
Often the function test_ww_mutex_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of test_ww_mutex_exit.
--
>> WARNING: modpost: vmlinux.o(.text+0x9e0b08): Section mismatch in reference from the function child_iter() to the function .exit.text:test_ww_mutex_exit()
The function child_iter() references a function in an exit section.
Often the function test_ww_mutex_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of test_ww_mutex_exit.
--
>> WARNING: modpost: vmlinux.o(.text+0xa2c6e2): Section mismatch in reference from the function hisi_sas_phy_down() to the function .init.text:set_reset_devices()
The function hisi_sas_phy_down() references
the function __init set_reset_devices().
This is often because hisi_sas_phy_down lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xa2dc2e): Section mismatch in reference from the function hisi_sas_remove() to the function .init.text:set_reset_devices()
The function hisi_sas_remove() references
the function __init set_reset_devices().
This is often because hisi_sas_remove lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9eb084): Section mismatch in reference from the function sas_phy_enable() to the function .init.text:set_reset_devices()
The function sas_phy_enable() references
the function __init set_reset_devices().
This is often because sas_phy_enable lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x14b5336): Section mismatch in reference from the function rds_sysctl_init() to the function .meminit.text:init_reserve_notifier()
The function rds_sysctl_init() references
the function __meminit init_reserve_notifier().
This is often because rds_sysctl_init lacks a __meminit
annotation or the annotation of init_reserve_notifier is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x15abf1a): Section mismatch in reference from the function ceph_strings_empty() to the function .init.text:set_reset_devices()
The function ceph_strings_empty() references
the function __init set_reset_devices().
This is often because ceph_strings_empty lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.init.text+0x460f2): Section mismatch in reference from the function scsi_init_devinfo() to the function .exit.text:test_ww_mutex_exit()
The function __init scsi_init_devinfo() references
a function __exit test_ww_mutex_exit().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
test_ww_mutex_exit() so it may be used outside an exit section.
--
>> WARNING: modpost: vmlinux.o(.init.text+0x7340e): Section mismatch in reference from the function xbc_node_find_next_leaf() to the variable .exit.text:.LBB3_6
The function __init xbc_node_find_next_leaf() references
a variable __exit .LBB3_6.
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
.LBB3_6 so it may be used outside an exit section.
--
>> WARNING: modpost: vmlinux.o(.init.setup+0x73c): Section mismatch in reference from the variable __setup_debug_boot_weak_hash_enable to the function .exit.text:test_ww_mutex_exit()
The variable __init __setup_debug_boot_weak_hash_enable references
a function __exit test_ww_mutex_exit().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
test_ww_mutex_exit() so it may be used outside an exit section.
--
>> WARNING: modpost: vmlinux.o(.data+0x179b3c): Section mismatch in reference from the variable iscsi_flashnode_bus to the function .exit.text:test_ww_mutex_exit()
The variable iscsi_flashnode_bus references
the function __exit test_ww_mutex_exit()
If the reference is valid then annotate the
variable with (see linux/init.h) or name the variable:

..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb0c7e2): Section mismatch in reference from the function __spi_pump_messages() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb11244): Section mismatch in reference from the function spi_mem_dirmap_read() to the variable .exit.text:.LBB0_3
<< WARNING: modpost: vmlinux.o(.text+0xb46a60): Section mismatch in reference from the function stm32_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb47604): Section mismatch in reference from the function sun4i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4827c): Section mismatch in reference from the function sun6i_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb492f0): Section mismatch in reference from the function synquacer_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4a894): Section mismatch in reference from the function tegra_qspi_remove() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0xb4cbd6): Section mismatch in reference from the function tegra_spi_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f030): Section mismatch in reference from the function tegra_slink_probe() to the variable .exit.text:.LBB0_4
<< WARNING: modpost: vmlinux.o(.text+0xb4f410): Section mismatch in reference from the function tegra_slink_remove() to the function .exit.text:test_ww_mutex_exit()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
