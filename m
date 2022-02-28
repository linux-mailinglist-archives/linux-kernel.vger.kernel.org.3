Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BAF4C62CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiB1GKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiB1GKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:10:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024E60068
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646028597; x=1677564597;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G2g/jnsNGMKF/+NzBtMT6NPS25ljpuIp5ejqkYzLzTQ=;
  b=ibz1nasc/QRijb8QKJiP64A1na5XCOtoaD3bq9TOIXg7z3O23v99OHfv
   fZG4f2A0Q/YeEtuAeZJAqhmKThG7ikblz4/wqK9Yf2tQps8N05tgTIsdY
   NOu9EeKfQdjiw251wPn/WUsMR46waIuOWlYtH1S1GOdYBMwFSLIAfC64s
   S1jeyMCyQsHZv0RC3gGN1kRmpQxjDWQRGsKKNLC5INWY0RDK3hRwUnqhJ
   HS102mPnm/ljGZXMwwOQ/WABSfg0GySuic2I28RGvxLIYFQZsZss4V/7M
   tDCes2B4JE3zPCj2Lilr+9mFgF0eO/l5RfKi9XvRm9wE0kN3bJCas2SLa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="252739864"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="252739864"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 22:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="801618925"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2022 22:09:55 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOZEI-00075o-B4; Mon, 28 Feb 2022 06:09:54 +0000
Date:   Mon, 28 Feb 2022 14:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: kernel/module.c:4478:14: warning: variable 'exit' set but not used
Message-ID: <202202281419.BQ8frGhi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
commit: 0d67e332e6df72f43eaa21228daa3a79e23093f3 module: fix clang CFI with MODULE_UNLOAD=n
date:   5 months ago
config: arm64-buildonly-randconfig-r001-20220228 (https://download.01.org/0day-ci/archive/20220228/202202281419.BQ8frGhi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d67e332e6df72f43eaa21228daa3a79e23093f3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0d67e332e6df72f43eaa21228daa3a79e23093f3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/module.c:4478:14: warning: variable 'exit' set but not used [-Wunused-but-set-variable]
           exitcall_t *exit;
                       ^
   kernel/module.c:1103:20: warning: unused function 'print_unload_info' [-Wunused-function]
   static inline void print_unload_info(struct seq_file *m, struct module *mod)
                      ^
   2 warnings generated.


vim +/exit +4478 kernel/module.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  4473  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4474  static void cfi_init(struct module *mod)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4475  {
cf68fffb66d60d Sami Tolvanen  2021-04-08  4476  #ifdef CONFIG_CFI_CLANG
cf68fffb66d60d Sami Tolvanen  2021-04-08  4477  	initcall_t *init;
cf68fffb66d60d Sami Tolvanen  2021-04-08 @4478  	exitcall_t *exit;
cf68fffb66d60d Sami Tolvanen  2021-04-08  4479  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4480  	rcu_read_lock_sched();
cf68fffb66d60d Sami Tolvanen  2021-04-08  4481  	mod->cfi_check = (cfi_check_fn)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4482  		find_kallsyms_symbol_value(mod, "__cfi_check");
cf68fffb66d60d Sami Tolvanen  2021-04-08  4483  	init = (initcall_t *)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4484  		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
cf68fffb66d60d Sami Tolvanen  2021-04-08  4485  	exit = (exitcall_t *)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4486  		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
cf68fffb66d60d Sami Tolvanen  2021-04-08  4487  	rcu_read_unlock_sched();
cf68fffb66d60d Sami Tolvanen  2021-04-08  4488  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4489  	/* Fix init/exit functions to point to the CFI jump table */
cf68fffb66d60d Sami Tolvanen  2021-04-08  4490  	if (init)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4491  		mod->init = *init;
0d67e332e6df72 Arnd Bergmann  2021-09-27  4492  #ifdef CONFIG_MODULE_UNLOAD
cf68fffb66d60d Sami Tolvanen  2021-04-08  4493  	if (exit)
cf68fffb66d60d Sami Tolvanen  2021-04-08  4494  		mod->exit = *exit;
0d67e332e6df72 Arnd Bergmann  2021-09-27  4495  #endif
cf68fffb66d60d Sami Tolvanen  2021-04-08  4496  
cf68fffb66d60d Sami Tolvanen  2021-04-08  4497  	cfi_module_add(mod, module_addr_min);
cf68fffb66d60d Sami Tolvanen  2021-04-08  4498  #endif
cf68fffb66d60d Sami Tolvanen  2021-04-08  4499  }
cf68fffb66d60d Sami Tolvanen  2021-04-08  4500  

:::::: The code at line 4478 was first introduced by commit
:::::: cf68fffb66d60d96209446bfc4a15291dc5a5d41 add support for Clang CFI

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
