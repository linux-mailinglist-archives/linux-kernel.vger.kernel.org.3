Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0F4C29D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiBXKoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiBXKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:44:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B691A39E8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645699462; x=1677235462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xESBG4/jyA4FAMoPXGie0n4PdZood0TNu1idzpebtEc=;
  b=lCdvMddFo3LwrBu9ljSdtOuK/KAWLi4GswCcd5JN+3OZCOMx4/E4qwQA
   hB5S7kU227E5yTmBDls3OrBnb7yoKWgfdatWb2nOtPUM4FDAoOuhG/Q2A
   GZtQg2OzFUn4vQon7w3nFt/SACsYF/dRAAlnJxmcj8HkK9cJnqf94IzJh
   Ny/6UZytIgwJgViL7Q4cEmoa1oBSMnGSCCS8eJnlaqVbOBVzOFwZi1d2w
   2ME/z98tVlh352hr8QNEACEhYtmd36IUp8UiPm3HAs0Isd7DR2f4IiljE
   7pYnJ8PBIOnppcLCMdiatIvK95M96GZDH0ENkXKSXtmoMphKlbab0k2PQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251938495"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="251938495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 02:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="574166635"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Feb 2022 02:44:20 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNBbf-00030q-JY; Thu, 24 Feb 2022 10:44:19 +0000
Date:   Thu, 24 Feb 2022 18:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/stackleak.c:33:50: sparse: sparse: incorrect type in argument
 3 (different address spaces)
Message-ID: <202202241831.OT84m49q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23d04328444a8fa0ca060c5e532220dac8e8bc26
commit: 0df8bdd5e3b3e557ce2c2575fce0c64c5dd1045a stackleak: move stack_erasing sysctl to stackleak.c
date:   5 weeks ago
config: arm64-randconfig-s031-20220223 (https://download.01.org/0day-ci/archive/20220224/202202241831.OT84m49q-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0df8bdd5e3b3e557ce2c2575fce0c64c5dd1045a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0df8bdd5e3b3e557ce2c2575fce0c64c5dd1045a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/stackleak.c:33:50: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/stackleak.c:33:50: sparse:     expected void *
   kernel/stackleak.c:33:50: sparse:     got void [noderef] __user *buffer
>> kernel/stackleak.c:53:35: sparse: sparse: incorrect type in initializer (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   kernel/stackleak.c:53:35: sparse:     expected int ( [usertype] *proc_handler )( ... )
   kernel/stackleak.c:53:35: sparse:     got int ( * )( ... )

vim +33 kernel/stackleak.c

964c9dff009189 Alexander Popov 2018-08-17  22  
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  23  #ifdef CONFIG_SYSCTL
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  24  static int stack_erasing_sysctl(struct ctl_table *table, int write,
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  25  			void __user *buffer, size_t *lenp, loff_t *ppos)
964c9dff009189 Alexander Popov 2018-08-17  26  {
964c9dff009189 Alexander Popov 2018-08-17  27  	int ret = 0;
964c9dff009189 Alexander Popov 2018-08-17  28  	int state = !static_branch_unlikely(&stack_erasing_bypass);
964c9dff009189 Alexander Popov 2018-08-17  29  	int prev_state = state;
964c9dff009189 Alexander Popov 2018-08-17  30  
964c9dff009189 Alexander Popov 2018-08-17  31  	table->data = &state;
964c9dff009189 Alexander Popov 2018-08-17  32  	table->maxlen = sizeof(int);
964c9dff009189 Alexander Popov 2018-08-17 @33  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
964c9dff009189 Alexander Popov 2018-08-17  34  	state = !!state;
964c9dff009189 Alexander Popov 2018-08-17  35  	if (ret || !write || state == prev_state)
964c9dff009189 Alexander Popov 2018-08-17  36  		return ret;
964c9dff009189 Alexander Popov 2018-08-17  37  
964c9dff009189 Alexander Popov 2018-08-17  38  	if (state)
964c9dff009189 Alexander Popov 2018-08-17  39  		static_branch_disable(&stack_erasing_bypass);
964c9dff009189 Alexander Popov 2018-08-17  40  	else
964c9dff009189 Alexander Popov 2018-08-17  41  		static_branch_enable(&stack_erasing_bypass);
964c9dff009189 Alexander Popov 2018-08-17  42  
964c9dff009189 Alexander Popov 2018-08-17  43  	pr_warn("stackleak: kernel stack erasing is %s\n",
964c9dff009189 Alexander Popov 2018-08-17  44  					state ? "enabled" : "disabled");
964c9dff009189 Alexander Popov 2018-08-17  45  	return ret;
964c9dff009189 Alexander Popov 2018-08-17  46  }
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  47  static struct ctl_table stackleak_sysctls[] = {
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  48  	{
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  49  		.procname	= "stack_erasing",
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  50  		.data		= NULL,
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  51  		.maxlen		= sizeof(int),
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  52  		.mode		= 0600,
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21 @53  		.proc_handler	= stack_erasing_sysctl,
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  54  		.extra1		= SYSCTL_ZERO,
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  55  		.extra2		= SYSCTL_ONE,
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  56  	},
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  57  	{}
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  58  };
0df8bdd5e3b3e5 Xiaoming Ni     2022-01-21  59  

:::::: The code at line 33 was first introduced by commit
:::::: 964c9dff0091893a9a74a88edf984c6da0b779f7 stackleak: Allow runtime disabling of kernel stack erasing

:::::: TO: Alexander Popov <alex.popov@linux.com>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
