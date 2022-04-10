Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F584FB0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiDJWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDJWpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:45:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1452198
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649630608; x=1681166608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TCgUjX9ahyVohoCaXgsx/M0QoUtcPbTjViibn9csD3I=;
  b=LoV+4nYejwLi7BqA6iaLgMrjkHWkv+G0GhlqOpNo7FYvdQnzztyWHjfF
   aiY7/KY/Ebj0CzkCGDv9Nez3yGDLsCCFrbbE8Q3vgqHMGZ6M23287z7TC
   1Q7y2m4Gqiuw3ib+WKJeQRbkQpvuRTSlP7lEaJ0hyqIQPfOMkYTZ0ScSc
   HG6TQ6yZuSyZdb+Q7ZORd78HAAX7a8z1LmHWee8owVqA5zFT+0WSnBrnd
   d4VsooALQh/JqwUzWk2wJS9kBpryRjbqE3IfO70WuwyDK0eqHvbzIFjzX
   4wsMNDNmvBEBytXNxLyGWKW2k8dnr8WEy15EF5ThbCmwjesPXfmn0+yLN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261744630"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="261744630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 15:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="610751134"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2022 15:43:25 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndgHF-00019r-32;
        Sun, 10 Apr 2022 22:43:25 +0000
Date:   Mon, 11 Apr 2022 06:42:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.text+0x1750660): Section mismatch in
 reference from the function mux_probe() to the function
 .init.text:set_reset_devices()
Message-ID: <202204110637.2vxBcwsq-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ea3c6425269d33da53c79d539ce9554117cf4d4
commit: f334f5668bedf7307f6df1d98b14f55902931926 ilog2: force inlining of __ilog2_u32() and __ilog2_u64()
date:   3 weeks ago
config: riscv-randconfig-r004-20220408 (https://download.01.org/0day-ci/archive/20220411/202204110637.2vxBcwsq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f334f5668bedf7307f6df1d98b14f55902931926
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f334f5668bedf7307f6df1d98b14f55902931926
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1750660): Section mismatch in reference from the function mux_probe() to the function .init.text:set_reset_devices()
The function mux_probe() references
the function __init set_reset_devices().
This is often because mux_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x178ef72): Section mismatch in reference from the function binder_alloc_free_page() to the function .init.text:set_reset_devices()
The function binder_alloc_free_page() references
the function __init set_reset_devices().
This is often because binder_alloc_free_page lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x17900fc): Section mismatch in reference from the function binder_update_page_range() to the function .init.text:set_reset_devices()
The function binder_update_page_range() references
the function __init set_reset_devices().
This is often because binder_update_page_range lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1798464): Section mismatch in reference from the function uniphier_efuse_probe() to the function .init.text:set_reset_devices()
The function uniphier_efuse_probe() references
the function __init set_reset_devices().
This is often because uniphier_efuse_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x179915a): Section mismatch in reference from the function snvs_lpgpr_probe() to the function .init.text:set_reset_devices()
The function snvs_lpgpr_probe() references
the function __init set_reset_devices().
This is often because snvs_lpgpr_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x17abcd8): Section mismatch in reference from the function counter_comp_u64_store() to the function .init.text:set_reset_devices()
The function counter_comp_u64_store() references
the function __init set_reset_devices().
This is often because counter_comp_u64_store lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1872892): Section mismatch in reference from the function ethtool_rxnfc_copy_from_user() to the function .init.text:set_reset_devices()
The function ethtool_rxnfc_copy_from_user() references
the function __init set_reset_devices().
This is often because ethtool_rxnfc_copy_from_user lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1872c26): Section mismatch in reference from the function ethtool_copy_validate_indir() to the function .init.text:set_reset_devices()
The function ethtool_copy_validate_indir() references
the function __init set_reset_devices().
This is often because ethtool_copy_validate_indir lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1874ffe): Section mismatch in reference from the function ethnl_default_dumpit() to the function .init.text:set_reset_devices()
The function ethnl_default_dumpit() references
the function __init set_reset_devices().
This is often because ethnl_default_dumpit lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x191aec6): Section mismatch in reference from the function ieee802154_start_req() to the function .init.text:set_reset_devices()
The function ieee802154_start_req() references
the function __init set_reset_devices().
This is often because ieee802154_start_req lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x191e056): Section mismatch in reference from the function llsec_parse_seclevel() to the function .init.text:set_reset_devices()
The function llsec_parse_seclevel() references
the function __init set_reset_devices().
This is often because llsec_parse_seclevel lacks a __init
annotation or the annotation of set_reset_devices is wrong.
..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ee88a): Section mismatch in reference from the function __keyctl_dh_compute() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x3ef672): Section mismatch in reference from the function trusted_instantiate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x60f5f4): Section mismatch in reference from the function virtio_gpio_irq_prepare() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703c08): Section mismatch in reference from the function adxrs290_write_raw() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x7a4466): Section mismatch in reference from the function __traceiter_clk_set_duty_cycle_complete() to the function .exit.text:crypto_user_exit()
<< WARNING: modpost: vmlinux.o(.text+0x1703e28): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_set_reset_devices
<< WARNING: modpost: vmlinux.o(.text+0x1703e40): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_debug_kernel
<< WARNING: modpost: vmlinux.o(.text+0x1703e6c): Section mismatch in reference from the function adxrs290_reg_access() to the variable .init.setup:__setup_rdinit_setup
<< WARNING: modpost: vmlinux.o(.text+0x7a5778): Section mismatch in reference from the function __clk_mux_determine_rate() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x170406a): Section mismatch in reference from the function adxrs290_reset_trig() to the function .init.text:set_reset_devices()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
