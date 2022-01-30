Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437BA4A38E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356081AbiA3UNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:13:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:45800 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356061AbiA3UNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643573632; x=1675109632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+1lqG9JTmDsoDU5PefXbrgGEpdmUytitdMnYe6yuPnk=;
  b=lOcxQVKYIpMY2Wj/y99VnSrEeomR1OctbFfvzd7oWwk+8aEGQXp4M9Mj
   SjtzErGwKD1AIHKR8aCBQREXlpFiitVwOjjPQnfAHzQzsP+EohlQUzpKm
   CPnaRlifZKblGHN6DShYUP2Z9DGpAQMJIKkt9bE+B7pE32M2RHCPD90BV
   +MN9nT6wj9yeBhtBUAIvi3+D8SqB1E/vy4TfYCplLoQ/t5x9+LUX6DYzO
   b2664V5mgz/igfXX2BfVEPsA/92fkxbqor+cz/R4UGKoyk9IoA7jYnrFf
   lY1MEl75uy12JIj4AWyd/tNuAa2HvvWM/3gcO04p3IbeYaXxIRdWz+eqk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="271838104"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="271838104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 12:13:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="675560970"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2022 12:13:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEGa6-000Qwm-E4; Sun, 30 Jan 2022 20:13:50 +0000
Date:   Mon, 31 Jan 2022 04:13:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rust:rust 964/1016] warning: unknown warning option
 '-Wpacked-not-aligned'; did you mean '-Wover-aligned'?
 [-Wunknown-warning-option], err: false
Message-ID: <202201310402.vCWP8CUS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/Rust-for-Linux/linux rust
head:   29fd422f0dfc943c7509b6e6af61c20cc73c3e26
commit: 60524bca853f1d1971d216e508a4cc6d2365d63b [964/1016] rust: remove `!COMPILE_TEST` gate
config: arm64-randconfig-r006-20220131 (https://download.01.org/0day-ci/archive/20220131/202201310402.vCWP8CUS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/Rust-for-Linux/linux/commit/60524bca853f1d1971d216e508a4cc6d2365d63b
        git remote add rust https://github.com/Rust-for-Linux/linux
        git fetch --no-tags rust rust
        git checkout 60524bca853f1d1971d216e508a4cc6d2365d63b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   error: unknown argument: '-fzero-call-used-regs=used-gpr', err: true
   warning: optimization flag '-fno-inline-functions-called-once' is not supported [-Wignored-optimization-argument], err: false
>> warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wover-aligned'? [-Wunknown-warning-option], err: false
>> warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option], err: false
   thread 'main' panicked at 'Unable to generate bindings: ()', /usr/local/registry/src/github.com-1ecc6299db9ec823/bindgen-0.56.0/src/main.rs:54:36
   note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
   error: unknown argument: '-fzero-call-used-regs=used-gpr', err: true
   warning: optimization flag '-fno-inline-functions-called-once' is not supported [-Wignored-optimization-argument], err: false
>> warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wover-aligned'? [-Wunknown-warning-option], err: false
>> warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option], err: false
   rust/helpers.c:22:17: warning: no previous prototype for function 'rust_helper_BUG' [-Wmissing-prototypes], err: false
   rust/helpers.c:27:6: warning: no previous prototype for function 'rust_helper_clk_disable_unprepare' [-Wmissing-prototypes], err: false
   rust/helpers.c:33:5: warning: no previous prototype for function 'rust_helper_clk_prepare_enable' [-Wmissing-prototypes], err: false
   rust/helpers.c:39:15: warning: no previous prototype for function 'rust_helper_copy_from_user' [-Wmissing-prototypes], err: false
   rust/helpers.c:44:15: warning: no previous prototype for function 'rust_helper_copy_to_user' [-Wmissing-prototypes], err: false
   rust/helpers.c:49:15: warning: no previous prototype for function 'rust_helper_clear_user' [-Wmissing-prototypes], err: false
   rust/helpers.c:54:15: warning: no previous prototype for function 'rust_helper_ioremap' [-Wmissing-prototypes], err: false
   rust/helpers.c:60:4: warning: no previous prototype for function 'rust_helper_readb' [-Wmissing-prototypes], err: false
   rust/helpers.c:66:5: warning: no previous prototype for function 'rust_helper_readw' [-Wmissing-prototypes], err: false
   rust/helpers.c:72:5: warning: no previous prototype for function 'rust_helper_readl' [-Wmissing-prototypes], err: false
   rust/helpers.c:79:5: warning: no previous prototype for function 'rust_helper_readq' [-Wmissing-prototypes], err: false
   rust/helpers.c:86:6: warning: no previous prototype for function 'rust_helper_writeb' [-Wmissing-prototypes], err: false
   rust/helpers.c:92:6: warning: no previous prototype for function 'rust_helper_writew' [-Wmissing-prototypes], err: false
   rust/helpers.c:98:6: warning: no previous prototype for function 'rust_helper_writel' [-Wmissing-prototypes], err: false
   rust/helpers.c:105:6: warning: no previous prototype for function 'rust_helper_writeq' [-Wmissing-prototypes], err: false
   rust/helpers.c:112:4: warning: no previous prototype for function 'rust_helper_readb_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:118:5: warning: no previous prototype for function 'rust_helper_readw_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:124:5: warning: no previous prototype for function 'rust_helper_readl_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:131:5: warning: no previous prototype for function 'rust_helper_readq_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:138:6: warning: no previous prototype for function 'rust_helper_writeb_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:144:6: warning: no previous prototype for function 'rust_helper_writew_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:150:6: warning: no previous prototype for function 'rust_helper_writel_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:157:6: warning: no previous prototype for function 'rust_helper_writeq_relaxed' [-Wmissing-prototypes], err: false
   rust/helpers.c:163:6: warning: no previous prototype for function 'rust_helper___spin_lock_init' [-Wmissing-prototypes], err: false
   rust/helpers.c:174:6: warning: no previous prototype for function 'rust_helper_spin_lock' [-Wmissing-prototypes], err: false
   rust/helpers.c:180:6: warning: no previous prototype for function 'rust_helper_spin_unlock' [-Wmissing-prototypes], err: false
   rust/helpers.c:186:15: warning: no previous prototype for function 'rust_helper_spin_lock_irqsave' [-Wmissing-prototypes], err: false
   rust/helpers.c:194:6: warning: no previous prototype for function 'rust_helper_spin_unlock_irqrestore' [-Wmissing-prototypes], err: false
   rust/helpers.c:200:6: warning: no previous prototype for function 'rust_helper_init_wait' [-Wmissing-prototypes], err: false
   rust/helpers.c:206:5: warning: no previous prototype for function 'rust_helper_signal_pending' [-Wmissing-prototypes], err: false
   rust/helpers.c:212:14: warning: no previous prototype for function 'rust_helper_alloc_pages' [-Wmissing-prototypes], err: false
   rust/helpers.c:218:7: warning: no previous prototype for function 'rust_helper_kmap' [-Wmissing-prototypes], err: false
   rust/helpers.c:224:6: warning: no previous prototype for function 'rust_helper_kunmap' [-Wmissing-prototypes], err: false
   rust/helpers.c:230:5: warning: no previous prototype for function 'rust_helper_cond_resched' [-Wmissing-prototypes], err: false
   rust/helpers.c:236:8: warning: no previous prototype for function 'rust_helper_copy_from_iter' [-Wmissing-prototypes], err: false
   rust/helpers.c:242:8: warning: no previous prototype for function 'rust_helper_copy_to_iter' [-Wmissing-prototypes], err: false
   rust/helpers.c:248:6: warning: no previous prototype for function 'rust_helper_IS_ERR' [-Wmissing-prototypes], err: false
   rust/helpers.c:254:6: warning: no previous prototype for function 'rust_helper_PTR_ERR' [-Wmissing-prototypes], err: false
   rust/helpers.c:260:13: warning: no previous prototype for function 'rust_helper_errname' [-Wmissing-prototypes], err: false
   rust/helpers.c:266:6: warning: no previous prototype for function 'rust_helper_mutex_lock' [-Wmissing-prototypes], err: false
   rust/helpers.c:272:6: warning: no previous prototype for function 'rust_helper_amba_set_drvdata' [-Wmissing-prototypes], err: false
   rust/helpers.c:278:7: warning: no previous prototype for function 'rust_helper_amba_get_drvdata' [-Wmissing-prototypes], err: false
   rust/helpers.c:285:1: warning: no previous prototype for function 'rust_helper_platform_get_drvdata' [-Wmissing-prototypes], err: false
   rust/helpers.c:292:1: warning: no previous prototype for function 'rust_helper_platform_set_drvdata' [-Wmissing-prototypes], err: false
   rust/helpers.c:299:12: warning: no previous prototype for function 'rust_helper_REFCOUNT_INIT' [-Wmissing-prototypes], err: false
   rust/helpers.c:305:6: warning: no previous prototype for function 'rust_helper_refcount_inc' [-Wmissing-prototypes], err: false
   rust/helpers.c:311:6: warning: no previous prototype for function 'rust_helper_refcount_dec_and_test' [-Wmissing-prototypes], err: false
   rust/helpers.c:317:6: warning: no previous prototype for function 'rust_helper_rb_link_node' [-Wmissing-prototypes], err: false
   rust/helpers.c:324:21: warning: no previous prototype for function 'rust_helper_get_current' [-Wmissing-prototypes], err: false
   rust/helpers.c:330:6: warning: no previous prototype for function 'rust_helper_get_task_struct' [-Wmissing-prototypes], err: false
   rust/helpers.c:336:6: warning: no previous prototype for function 'rust_helper_put_task_struct' [-Wmissing-prototypes], err: false
   rust/helpers.c:342:5: warning: no previous prototype for function 'rust_helper_security_binder_set_context_mgr' [-Wmissing-prototypes], err: false
   rust/helpers.c:348:5: warning: no previous prototype for function 'rust_helper_security_binder_transaction' [-Wmissing-prototypes], err: false
   rust/helpers.c:355:5: warning: no previous prototype for function 'rust_helper_security_binder_transfer_binder' [-Wmissing-prototypes], err: false
   rust/helpers.c:362:5: warning: no previous prototype for function 'rust_helper_security_binder_transfer_file' [-Wmissing-prototypes], err: false
   rust/helpers.c:370:6: warning: no previous prototype for function 'rust_helper_rcu_read_lock' [-Wmissing-prototypes], err: false
   rust/helpers.c:376:6: warning: no previous prototype for function 'rust_helper_rcu_read_unlock' [-Wmissing-prototypes], err: false
   rust/helpers.c:382:6: warning: no previous prototype for function 'rust_helper_synchronize_rcu' [-Wmissing-prototypes], err: false
   rust/helpers.c:388:7: warning: no previous prototype for function 'rust_helper_dev_get_drvdata' [-Wmissing-prototypes], err: false
   rust/helpers.c:394:13: warning: no previous prototype for function 'rust_helper_dev_name' [-Wmissing-prototypes], err: false
   rust/helpers.c:400:6: warning: no previous prototype for function 'rust_helper___seqcount_init' [-Wmissing-prototypes], err: false
   rust/helpers.c:407:10: warning: no previous prototype for function 'rust_helper_read_seqcount_begin' [-Wmissing-prototypes], err: false
   rust/helpers.c:413:5: warning: no previous prototype for function 'rust_helper_read_seqcount_retry' [-Wmissing-prototypes], err: false
   rust/helpers.c:419:6: warning: no previous prototype for function 'rust_helper_write_seqcount_begin' [-Wmissing-prototypes], err: false
   rust/helpers.c:425:6: warning: no previous prototype for function 'rust_helper_write_seqcount_end' [-Wmissing-prototypes], err: false
   rust/helpers.c:431:6: warning: no previous prototype for function 'rust_helper_irq_set_handler_locked' [-Wmissing-prototypes], err: false
   rust/helpers.c:438:7: warning: no previous prototype for function 'rust_helper_irq_data_get_irq_chip_data' [-Wmissing-prototypes], err: false
   rust/helpers.c:444:18: warning: no previous prototype for function 'rust_helper_irq_desc_get_chip' [-Wmissing-prototypes], err: false
   rust/helpers.c:450:7: warning: no previous prototype for function 'rust_helper_irq_desc_get_handler_data' [-Wmissing-prototypes], err: false
   rust/helpers.c:456:6: warning: no previous prototype for function 'rust_helper_chained_irq_enter' [-Wmissing-prototypes], err: false
   rust/helpers.c:463:6: warning: no previous prototype for function 'rust_helper_chained_irq_exit' [-Wmissing-prototypes], err: false
   rust/helpers.c:470:20: warning: no previous prototype for function 'rust_helper_get_cred' [-Wmissing-prototypes], err: false
   rust/helpers.c:476:6: warning: no previous prototype for function 'rust_helper_put_cred' [-Wmissing-prototypes], err: false
   rust/helpers.c:481:28: warning: no previous prototype for function 'rust_helper_of_match_device' [-Wmissing-prototypes], err: false
   make[2]: *** [rust/Makefile:243: rust/bindings_generated.rs] Error 1
   make[2]: *** Deleting file 'rust/bindings_generated.rs'
   thread 'main' panicked at 'Unable to generate bindings: ()', /usr/local/registry/src/github.com-1ecc6299db9ec823/bindgen-0.56.0/src/main.rs:54:36
   note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
   make[2]: *** [rust/Makefile:256: rust/bindings_helpers_generated.rs] Error 1
   make[2]: *** Deleting file 'rust/bindings_helpers_generated.rs'
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1272: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
