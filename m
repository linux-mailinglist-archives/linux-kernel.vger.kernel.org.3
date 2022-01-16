Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231C448FF82
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiAPWpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:45:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:19370 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233840AbiAPWpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642373118; x=1673909118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wBhzhm1MkkAj/XdBpQvtEENwMU0TfZ9sa1g0h9RhP9w=;
  b=lnGm2pQHiSKRJVkHnxgy6k5hwCUYkCJEvENKp9WkZ4akbfiii/Ir3WtI
   +Wknkje7gK6lSwv2PWsAAdLDHBJuWE1duZWOCxSyY0U6bW5qvUcXzDRLk
   OLYF3K8FELIYJGUZgRqhv1oGE6IdoyFi3FjijLk5ZmgLqVaO1pqX9ViS6
   0MV/6GSlSoD2OSdvle7LNfEcRSZbFBdgEW7FvnqJzjFn7fBC1gjwb/tO9
   +Ctp29LCRsZfzjut8bwKCzM6mfIzSmjMUiEv2ZpYgZkGsT8wzmyh1PZwl
   7RDXfyeqtLJ5pjf0DnpG3W/lHvVcRFcNJ6vrZr4tAN+jnvHKqGZn4yB96
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244717296"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="244717296"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 14:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="476440230"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2022 14:45:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9EGx-000B1R-LV; Sun, 16 Jan 2022 22:45:15 +0000
Date:   Mon, 17 Jan 2022 06:45:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH] Wire up CONFIG_DEVTMPFS_MOUNT to initramfs.
Message-ID: <202201170603.CXS8HDSz-lkp@intel.com>
References: <d53f041a-83f7-57f7-28ae-eb7b23034f83@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53f041a-83f7-57f7-28ae-eb7b23034f83@landley.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.16 next-20220116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rob-Landley/Wire-up-CONFIG_DEVTMPFS_MOUNT-to-initramfs/20220117-023610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git daadb3bd0e8d3e317e36bc2c1542e86c528665e5
config: i386-randconfig-a001-20220117 (https://download.01.org/0day-ci/archive/20220117/202201170603.CXS8HDSz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c6b7e8ccdf2b0a9620c9dc0b5e5b2a719b223817
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rob-Landley/Wire-up-CONFIG_DEVTMPFS_MOUNT-to-initramfs/20220117-023610
        git checkout c6b7e8ccdf2b0a9620c9dc0b5e5b2a719b223817
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c:780:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:780:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
>> init/main.c:1624:3: error: implicit declaration of function 'sys_mkdir' [-Werror,-Wimplicit-function-declaration]
                   sys_mkdir("/dev", 0755);
                   ^
   init/main.c:1624:3: note: did you mean 'vfs_mkdir'?
   include/linux/fs.h:1867:5: note: 'vfs_mkdir' declared here
   int vfs_mkdir(struct user_namespace *, struct inode *,
       ^
   1 warning and 1 error generated.


vim +/sys_mkdir +1624 init/main.c

  1579	
  1580	static noinline void __init kernel_init_freeable(void)
  1581	{
  1582		/* Now the scheduler is fully set up and can do blocking allocations */
  1583		gfp_allowed_mask = __GFP_BITS_MASK;
  1584	
  1585		/*
  1586		 * init can allocate pages on any node
  1587		 */
  1588		set_mems_allowed(node_states[N_MEMORY]);
  1589	
  1590		cad_pid = get_pid(task_pid(current));
  1591	
  1592		smp_prepare_cpus(setup_max_cpus);
  1593	
  1594		workqueue_init();
  1595	
  1596		init_mm_internals();
  1597	
  1598		rcu_init_tasks_generic();
  1599		do_pre_smp_initcalls();
  1600		lockup_detector_init();
  1601	
  1602		smp_init();
  1603		sched_init_smp();
  1604	
  1605		padata_init();
  1606		page_alloc_init_late();
  1607		/* Initialize page ext after all struct pages are initialized. */
  1608		page_ext_init();
  1609	
  1610		do_basic_setup();
  1611	
  1612		kunit_run_all_tests();
  1613	
  1614		wait_for_initramfs();
  1615	
  1616		/*
  1617		 * check if there is an early userspace init.  If yes, let it do all
  1618		 * the work
  1619		 */
  1620		if (init_eaccess(ramdisk_execute_command) != 0) {
  1621			ramdisk_execute_command = NULL;
  1622			prepare_namespace();
  1623		} else if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT)) {
> 1624			sys_mkdir("/dev", 0755);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
