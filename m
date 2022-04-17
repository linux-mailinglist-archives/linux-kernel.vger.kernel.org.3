Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A655048BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiDQSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiDQSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:04:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957F13F46
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650218525; x=1681754525;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x/m+JhS2MQX+M3FW9Pzi/1wZPuLIiA4cNo0RmjfwG9g=;
  b=He7R2XLJX5FR8cFvnKP/ET8nIhi8Ri6WKjmRBWlMGwJJoCFwk5bH12wP
   XjPhjQpsZMnoisJdSBrMlRq/QU4DJLt8/Vs8cC7jvoDWvsLY6p4bIurek
   FhDA2kqRVCMNkO5YKLYCnzSXMblUvyld1jkZD8fkJ98ZebQH99tsJ/dUr
   909sjzIqaphXP++MgJhYnoyF9CcbAXhFwEJWVUbrF8HXRdav6ABMTlLZo
   avMjlk2M1WgB8r9fozrcWQhb4ntfQc/T7u4eYAcvzgoEzk+6pF2fDnC08
   Sv1v8eB8TDyo0Q5MVRqSghCxCaCNDUE5jEa+VTTtpEQpm4XUNyM+7eiEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="288486159"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="288486159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 11:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="613368059"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2022 11:01:55 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ng9De-00044j-OU;
        Sun, 17 Apr 2022 18:01:54 +0000
Date:   Mon, 18 Apr 2022 02:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.text+0x1719f9c): Section mismatch in
 reference from the function fxos8700_core_probe() to the function
 .init.text:set_reset_devices()
Message-ID: <202204180155.7WFnHuLm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a2c29ccd9477861b16ddc02c411a6c9665250558
commit: d83ce027a54068fabb70d2c252e1ce2da86784a4 ubsan: no need to unset panic_on_warn in ubsan_epilogue()
date:   4 weeks ago
config: riscv-randconfig-r004-20220408 (https://download.01.org/0day-ci/archive/20220418/202204180155.7WFnHuLm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d83ce027a54068fabb70d2c252e1ce2da86784a4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d83ce027a54068fabb70d2c252e1ce2da86784a4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1719f9c): Section mismatch in reference from the function fxos8700_core_probe() to the function .init.text:set_reset_devices()
The function fxos8700_core_probe() references
the function __init set_reset_devices().
This is often because fxos8700_core_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x172ef66): Section mismatch in reference from the function al3320a_probe() to the function .init.text:set_reset_devices()
The function al3320a_probe() references
the function __init set_reset_devices().
This is often because al3320a_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x174bf64): Section mismatch in reference from the function bmc150_magn_probe() to the function .init.text:set_reset_devices()
The function bmc150_magn_probe() references
the function __init set_reset_devices().
This is often because bmc150_magn_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1751f2c): Section mismatch in reference from the function mux_probe() to the function .init.text:set_reset_devices()
The function mux_probe() references
the function __init set_reset_devices().
This is often because mux_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1764a86): Section mismatch in reference from the function mlx90632_probe() to the function .init.text:set_reset_devices()
The function mlx90632_probe() references
the function __init set_reset_devices().
This is often because mlx90632_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1766fd4): Section mismatch in reference from the function tmp006_probe() to the function .init.text:set_reset_devices()
The function tmp006_probe() references
the function __init set_reset_devices().
This is often because tmp006_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x43f08a): Section mismatch in reference from the function chksum_update() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x43f0cc): Section mismatch in reference from the function chksum_finup() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x440f76): Section mismatch in reference from the function lzorle_decompress() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x8080ba): Section mismatch in reference from the function ccu_mux_enable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778818): Section mismatch in reference from the function mcb_lpc_probe() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080d8): Section mismatch in reference from the function ccu_mux_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778fc6): Section mismatch in reference from the function binderfs_fill_super() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080f6): Section mismatch in reference from the function ccu_mux_is_enabled() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x177ff94): Section mismatch in reference from the function print_binder_transaction_ilocked() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x808148): Section mismatch in reference from the function ccu_mux_set_parent() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x43f08a): Section mismatch in reference from the function chksum_update() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x43f0cc): Section mismatch in reference from the function chksum_finup() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x440f76): Section mismatch in reference from the function lzorle_decompress() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x8080ba): Section mismatch in reference from the function ccu_mux_enable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778818): Section mismatch in reference from the function mcb_lpc_probe() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080d8): Section mismatch in reference from the function ccu_mux_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778fc6): Section mismatch in reference from the function binderfs_fill_super() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080f6): Section mismatch in reference from the function ccu_mux_is_enabled() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x177ff94): Section mismatch in reference from the function print_binder_transaction_ilocked() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x808148): Section mismatch in reference from the function ccu_mux_set_parent() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x43f08a): Section mismatch in reference from the function chksum_update() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x43f0cc): Section mismatch in reference from the function chksum_finup() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x440f76): Section mismatch in reference from the function lzorle_decompress() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x8080ba): Section mismatch in reference from the function ccu_mux_enable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778818): Section mismatch in reference from the function mcb_lpc_probe() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080d8): Section mismatch in reference from the function ccu_mux_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778fc6): Section mismatch in reference from the function binderfs_fill_super() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080f6): Section mismatch in reference from the function ccu_mux_is_enabled() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x177ff94): Section mismatch in reference from the function print_binder_transaction_ilocked() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x808148): Section mismatch in reference from the function ccu_mux_set_parent() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x43f08a): Section mismatch in reference from the function chksum_update() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x43f0cc): Section mismatch in reference from the function chksum_finup() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x440f76): Section mismatch in reference from the function lzorle_decompress() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x8080ba): Section mismatch in reference from the function ccu_mux_enable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778818): Section mismatch in reference from the function mcb_lpc_probe() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080d8): Section mismatch in reference from the function ccu_mux_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778fc6): Section mismatch in reference from the function binderfs_fill_super() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080f6): Section mismatch in reference from the function ccu_mux_is_enabled() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x177ff94): Section mismatch in reference from the function print_binder_transaction_ilocked() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x808148): Section mismatch in reference from the function ccu_mux_set_parent() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x43f08a): Section mismatch in reference from the function chksum_update() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x43f0cc): Section mismatch in reference from the function chksum_finup() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x440f76): Section mismatch in reference from the function lzorle_decompress() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x8080ba): Section mismatch in reference from the function ccu_mux_enable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778818): Section mismatch in reference from the function mcb_lpc_probe() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080d8): Section mismatch in reference from the function ccu_mux_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778fc6): Section mismatch in reference from the function binderfs_fill_super() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080f6): Section mismatch in reference from the function ccu_mux_is_enabled() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x177ff94): Section mismatch in reference from the function print_binder_transaction_ilocked() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x808148): Section mismatch in reference from the function ccu_mux_set_parent() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x43f08a): Section mismatch in reference from the function chksum_update() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x43f0cc): Section mismatch in reference from the function chksum_finup() to the function .exit.text:cryptomgr_exit()
<< WARNING: modpost: vmlinux.o(.text+0x440f76): Section mismatch in reference from the function lzorle_decompress() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x8080ba): Section mismatch in reference from the function ccu_mux_enable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778818): Section mismatch in reference from the function mcb_lpc_probe() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080d8): Section mismatch in reference from the function ccu_mux_disable() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1778fc6): Section mismatch in reference from the function binderfs_fill_super() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x8080f6): Section mismatch in reference from the function ccu_mux_is_enabled() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x177ff94): Section mismatch in reference from the function print_binder_transaction_ilocked() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x808148): Section mismatch in reference from the function ccu_mux_set_parent() to the function .init.text:set_reset_devices()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
