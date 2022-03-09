Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D34D2672
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiCIBYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiCIBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:24:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3F3A1A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646788981; x=1678324981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xtRs6oi+J5auIPKJEANNMf/Y0ox4XmKqILRhR300NLg=;
  b=TR5VvBvol+FCRVEehNeXGpNpbRiYwhcNMrqIFwsRHaQ0KMVklPsys7jB
   va39S5qZ/nnqiv+H/aL9eqSy08L0T4EoHJrMwXZ3QaX2ivWIGZ+aWF/Rz
   yTRWSDErgXB4LT62hlXdC31E8AMI/OeuhAGEVtYZxerv2HeGOFf8y6BUw
   3M+rVbYerCICE+XOeFHDY6Rirky1lNt4HfYOAcxxhr9HL5TRuMVMi2fvw
   KS79qZTCBvDTfSodgGC8Y8y3h6EXkK/VuDvTUZU/M5SHp8C+k7r2vEBnR
   Ul6I7OrNmQlbp1Ep1XynVECcXSFoqYUWBj/By3xQZOTIFmsgxyctCb4gF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253686606"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253686606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:12:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495664617"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 17:12:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRksf-0002Ic-1d; Wed, 09 Mar 2022 01:12:45 +0000
Date:   Wed, 9 Mar 2022 09:12:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ebiederm-user-namespace:coredump-vma-snapshot-fix 1/5]
 fs/binfmt_flat.c:121:36: error: incomplete definition of type 'struct
 coredump_params'
Message-ID: <202203090943.0a2uUHMd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix
head:   390031c942116d4733310f0684beb8db19885fe6
commit: a99a3e2efaf1f4454eb5c9176f47e66de075b134 [1/5] coredump: Move definition of struct coredump_params into coredump.h
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20220309/202203090943.0a2uUHMd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a2e9c68fcd4425fbce7380746e916966f00a39a0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=a99a3e2efaf1f4454eb5c9176f47e66de075b134
        git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
        git fetch --no-tags ebiederm-user-namespace coredump-vma-snapshot-fix
        git checkout a99a3e2efaf1f4454eb5c9176f47e66de075b134
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/binfmt_flat.c:121:36: error: incomplete definition of type 'struct coredump_params'
                   current->comm, current->pid, cprm->siginfo->si_signo);
                                                ~~~~^
   include/linux/printk.h:499:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                              ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
   include/linux/binfmts.h:11:8: note: forward declaration of 'struct coredump_params'
   struct coredump_params;
          ^
   1 error generated.


vim +121 fs/binfmt_flat.c

^1da177e4c3f415 Linus Torvalds   2005-04-16  111  
^1da177e4c3f415 Linus Torvalds   2005-04-16  112  /****************************************************************************/
^1da177e4c3f415 Linus Torvalds   2005-04-16  113  /*
^1da177e4c3f415 Linus Torvalds   2005-04-16  114   * Routine writes a core dump image in the current directory.
^1da177e4c3f415 Linus Torvalds   2005-04-16  115   * Currently only a stub-function.
^1da177e4c3f415 Linus Torvalds   2005-04-16  116   */
^1da177e4c3f415 Linus Torvalds   2005-04-16  117  
f6151dfea21496d Masami Hiramatsu 2009-12-17  118  static int flat_core_dump(struct coredump_params *cprm)
^1da177e4c3f415 Linus Torvalds   2005-04-16  119  {
4adbb6ac4b807e2 Nicolas Pitre    2016-07-24  120  	pr_warn("Process %s:%d received signr %d and should have core dumped\n",
13c3f50c914e6a5 Nicolas Pitre    2016-07-24 @121  		current->comm, current->pid, cprm->siginfo->si_signo);
13c3f50c914e6a5 Nicolas Pitre    2016-07-24  122  	return 1;
^1da177e4c3f415 Linus Torvalds   2005-04-16  123  }
^1da177e4c3f415 Linus Torvalds   2005-04-16  124  

:::::: The code at line 121 was first introduced by commit
:::::: 13c3f50c914e6a51d11e1aba4a85c2223e197e13 binfmt_flat: assorted cleanups

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Greg Ungerer <gerg@linux-m68k.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
