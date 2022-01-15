Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F848F909
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiAOTWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:22:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:62825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbiAOTWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642274554; x=1673810554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N2bI/kxek1Tspu5VAYSTbypzRUT7g18JUqKgHNPfSIw=;
  b=D5coIt8HnblqzjtlggIzMFUYJNuvgzHd13cY4Ep8pZoXH9/OT+b1EybZ
   p/kTGVnETGJh5LLo1FjVHHAXu7c28+P/Uh4HbxrKiUDccBSyAddfbk9iM
   iNCPL30SVhySeSdjrWSb6YbDH1VtupygcoUiAV6D82fk8IQmP47kJH9A6
   K0EdJQwUmoNzmi5qyYJmimDukQyJtWylc4CfqNPYrPL2AR6v7o1Q/crvW
   8id7Mkrr8qZZ+o0GiBkNkuXYwiZxdGmUxVAoQ9OpSLKX1KQp+ojdz8HFO
   k3Vee6mcenMxchUSQ0Y2d6CbmvXPI2+Por2Tmy1jIBwn1KEEHLp2LtXNG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="268804957"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268804957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 11:22:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="516896112"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2022 11:22:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8odD-000AFN-F7; Sat, 15 Jan 2022 19:22:31 +0000
Date:   Sun, 16 Jan 2022 03:21:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2040/2384]
 arch/mips/kernel/vpe-mt.c:322:21: error: variable has incomplete type
 'struct class'
Message-ID: <202201160353.tvHYOOaJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: abe1ece6c06895bf5e7c8f03d10061f5712d8326 [2040/2384] headers/deps: dev/core: Optimize <linux/device.h> dependencies, remove <linux/device_api.h> inclusion
config: mips-maltaaprp_defconfig (https://download.01.org/0day-ci/archive/20220116/202201160353.tvHYOOaJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 650fc40b6d8d9a5869b4fca525d5f237b0ee2803)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=abe1ece6c06895bf5e7c8f03d10061f5712d8326
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout abe1ece6c06895bf5e7c8f03d10061f5712d8326
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/vpe-mt.c:9:
   include/linux/fs_api.h:35:19: error: expected ';' after top level declarator
   extern void __init inode_init(void);
                     ^
                     ;
   include/linux/fs_api.h:36:19: error: expected ';' after top level declarator
   extern void __init inode_init_early(void);
                     ^
                     ;
   include/linux/fs_api.h:37:19: error: expected ';' after top level declarator
   extern void __init files_init(void);
                     ^
                     ;
   include/linux/fs_api.h:38:19: error: expected ';' after top level declarator
   extern void __init files_maxfiles_init(void);
                     ^
                     ;
   include/linux/fs_api.h:1247:19: error: expected ';' after top level declarator
   extern void __init vfs_caches_init_early(void);
                     ^
                     ;
   include/linux/fs_api.h:1248:19: error: expected ';' after top level declarator
   extern void __init vfs_caches_init(void);
                     ^
                     ;
   include/linux/fs_api.h:2042:5: error: redefinition of '__init' with a different type: 'int' vs 'void'
   int __init list_bdev_fs_names(char *buf, size_t size);
       ^
   include/linux/fs_api.h:1248:13: note: previous declaration is here
   extern void __init vfs_caches_init(void);
               ^
   include/linux/fs_api.h:2042:11: error: expected ';' after top level declarator
   int __init list_bdev_fs_names(char *buf, size_t size);
             ^
             ;
   arch/mips/kernel/vpe-mt.c:181:7: warning: no previous prototype for function 'vpe_alloc' [-Wmissing-prototypes]
   void *vpe_alloc(void)
         ^
   arch/mips/kernel/vpe-mt.c:181:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *vpe_alloc(void)
   ^
   static 
   arch/mips/kernel/vpe-mt.c:199:5: warning: no previous prototype for function 'vpe_start' [-Wmissing-prototypes]
   int vpe_start(void *vpe, unsigned long start)
       ^
   arch/mips/kernel/vpe-mt.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vpe_start(void *vpe, unsigned long start)
   ^
   static 
   arch/mips/kernel/vpe-mt.c:209:5: warning: no previous prototype for function 'vpe_stop' [-Wmissing-prototypes]
   int vpe_stop(void *vpe)
       ^
   arch/mips/kernel/vpe-mt.c:209:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vpe_stop(void *vpe)
   ^
   static 
   arch/mips/kernel/vpe-mt.c:230:5: warning: no previous prototype for function 'vpe_free' [-Wmissing-prototypes]
   int vpe_free(void *vpe)
       ^
   arch/mips/kernel/vpe-mt.c:230:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vpe_free(void *vpe)
   ^
   static 
>> arch/mips/kernel/vpe-mt.c:322:21: error: variable has incomplete type 'struct class'
   static struct class vpe_class = {
                       ^
   include/linux/device_types.h:29:8: note: forward declaration of 'struct class'
   struct class;
          ^
>> arch/mips/kernel/vpe-mt.c:364:8: error: implicit declaration of function 'class_register' [-Werror,-Wimplicit-function-declaration]
           err = class_register(&vpe_class);
                 ^
>> arch/mips/kernel/vpe-mt.c:503:2: error: implicit declaration of function 'class_unregister' [-Werror,-Wimplicit-function-declaration]
           class_unregister(&vpe_class);
           ^
   arch/mips/kernel/vpe-mt.c:503:2: note: did you mean 'class_register'?
   arch/mips/kernel/vpe-mt.c:364:8: note: 'class_register' declared here
           err = class_register(&vpe_class);
                 ^
   arch/mips/kernel/vpe-mt.c:516:2: error: implicit declaration of function 'class_unregister' [-Werror,-Wimplicit-function-declaration]
           class_unregister(&vpe_class);
           ^
   4 warnings and 12 errors generated.


vim +322 arch/mips/kernel/vpe-mt.c

1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  321  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @322  static struct class vpe_class = {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  323  	.name = "vpe",
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  324  	.owner = THIS_MODULE,
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  325  	.dev_release = vpe_device_release,
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  326  	.dev_groups = vpe_groups,
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  327  };
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  328  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  329  static struct device vpe_device;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  330  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  331  int __init vpe_module_init(void)
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  332  {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  333  	unsigned int mtflags, vpflags;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  334  	unsigned long flags, val;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  335  	struct vpe *v = NULL;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  336  	struct tc *t;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  337  	int tc, err;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  338  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  339  	if (!cpu_has_mipsmt) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  340  		pr_warn("VPE loader: not a MIPS MT capable processor\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  341  		return -ENODEV;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  342  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  343  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  344  	if (vpelimit == 0) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  345  		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  346  			"Pass maxvpes=<n> argument as kernel argument\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  347  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  348  		return -ENODEV;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  349  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  350  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  351  	if (aprp_cpu_index() == 0) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  352  		pr_warn("No TCs reserved for AP/SP, not initialize VPE loader\n"
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  353  			"Pass maxtcs=<n> argument as kernel argument\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  354  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  355  		return -ENODEV;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  356  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  357  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  358  	major = register_chrdev(0, VPE_MODULE_NAME, &vpe_fops);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  359  	if (major < 0) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  360  		pr_warn("VPE loader: unable to register character device\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  361  		return major;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  362  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  363  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @364  	err = class_register(&vpe_class);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  365  	if (err) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  366  		pr_err("vpe_class registration failed\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  367  		goto out_chrdev;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  368  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  369  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  370  	device_initialize(&vpe_device);
3a845b30bc43d7 Zheng Yongjun 2020-12-16  371  	vpe_device.class	= &vpe_class;
3a845b30bc43d7 Zheng Yongjun 2020-12-16  372  	vpe_device.parent	= NULL;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  373  	dev_set_name(&vpe_device, "vpe1");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  374  	vpe_device.devt = MKDEV(major, VPE_MODULE_MINOR);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  375  	err = device_add(&vpe_device);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  376  	if (err) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  377  		pr_err("Adding vpe_device failed\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  378  		goto out_class;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  379  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  380  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  381  	local_irq_save(flags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  382  	mtflags = dmt();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  383  	vpflags = dvpe();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  384  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  385  	/* Put MVPE's into 'configuration state' */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  386  	set_c0_mvpcontrol(MVPCONTROL_VPC);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  387  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  388  	val = read_c0_mvpconf0();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  389  	hw_tcs = (val & MVPCONF0_PTC) + 1;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  390  	hw_vpes = ((val & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  391  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  392  	for (tc = aprp_cpu_index(); tc < hw_tcs; tc++) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  393  		/*
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  394  		 * Must re-enable multithreading temporarily or in case we
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  395  		 * reschedule send IPIs or similar we might hang.
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  396  		 */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  397  		clear_c0_mvpcontrol(MVPCONTROL_VPC);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  398  		evpe(vpflags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  399  		emt(mtflags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  400  		local_irq_restore(flags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  401  		t = alloc_tc(tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  402  		if (!t) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  403  			err = -ENOMEM;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  404  			goto out_dev;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  405  		}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  406  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  407  		local_irq_save(flags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  408  		mtflags = dmt();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  409  		vpflags = dvpe();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  410  		set_c0_mvpcontrol(MVPCONTROL_VPC);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  411  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  412  		/* VPE's */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  413  		if (tc < hw_tcs) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  414  			settc(tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  415  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  416  			v = alloc_vpe(tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  417  			if (v == NULL) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  418  				pr_warn("VPE: unable to allocate VPE\n");
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  419  				goto out_reenable;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  420  			}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  421  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  422  			v->ntcs = hw_tcs - aprp_cpu_index();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  423  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  424  			/* add the tc to the list of this vpe's tc's. */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  425  			list_add(&t->tc, &v->tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  426  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  427  			/* deactivate all but vpe0 */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  428  			if (tc >= aprp_cpu_index()) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  429  				unsigned long tmp = read_vpe_c0_vpeconf0();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  430  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  431  				tmp &= ~VPECONF0_VPA;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  432  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  433  				/* master VPE */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  434  				tmp |= VPECONF0_MVP;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  435  				write_vpe_c0_vpeconf0(tmp);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  436  			}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  437  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  438  			/* disable multi-threading with TC's */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  439  			write_vpe_c0_vpecontrol(read_vpe_c0_vpecontrol() &
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  440  						~VPECONTROL_TE);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  441  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  442  			if (tc >= vpelimit) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  443  				/*
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  444  				 * Set config to be the same as vpe0,
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  445  				 * particularly kseg0 coherency alg
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  446  				 */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  447  				write_vpe_c0_config(read_c0_config());
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  448  			}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  449  		}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  450  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  451  		/* TC's */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  452  		t->pvpe = v;	/* set the parent vpe */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  453  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  454  		if (tc >= aprp_cpu_index()) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  455  			unsigned long tmp;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  456  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  457  			settc(tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  458  
b633648c5ad3cf Ralf Baechle  2014-05-23  459  			/*
b633648c5ad3cf Ralf Baechle  2014-05-23  460  			 * A TC that is bound to any other VPE gets bound to
b633648c5ad3cf Ralf Baechle  2014-05-23  461  			 * VPE0, ideally I'd like to make it homeless but it
b633648c5ad3cf Ralf Baechle  2014-05-23  462  			 * doesn't appear to let me bind a TC to a non-existent
b633648c5ad3cf Ralf Baechle  2014-05-23  463  			 * VPE. Which is perfectly reasonable.
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  464  			 *
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  465  			 * The (un)bound state is visible to an EJTAG probe so
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  466  			 * may notify GDB...
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  467  			 */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  468  			tmp = read_tc_c0_tcbind();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  469  			if (tmp & TCBIND_CURVPE) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  470  				/* tc is bound >vpe0 */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  471  				write_tc_c0_tcbind(tmp & ~TCBIND_CURVPE);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  472  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  473  				t->pvpe = get_vpe(0);	/* set the parent vpe */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  474  			}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  475  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  476  			/* halt the TC */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  477  			write_tc_c0_tchalt(TCHALT_H);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  478  			mips_ihb();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  479  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  480  			tmp = read_tc_c0_tcstatus();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  481  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  482  			/* mark not activated and not dynamically allocatable */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  483  			tmp &= ~(TCSTATUS_A | TCSTATUS_DA);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  484  			tmp |= TCSTATUS_IXMT;	/* interrupt exempt */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  485  			write_tc_c0_tcstatus(tmp);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  486  		}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  487  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  488  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  489  out_reenable:
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  490  	/* release config state */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  491  	clear_c0_mvpcontrol(MVPCONTROL_VPC);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  492  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  493  	evpe(vpflags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  494  	emt(mtflags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  495  	local_irq_restore(flags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  496  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  497  	return 0;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  498  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  499  out_dev:
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  500  	device_del(&vpe_device);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  501  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  502  out_class:
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @503  	class_unregister(&vpe_class);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  504  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  505  out_chrdev:
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  506  	unregister_chrdev(major, VPE_MODULE_NAME);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  507  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  508  	return err;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  509  }
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  510  

:::::: The code at line 322 was first introduced by commit
:::::: 1a2a6d7e8816ed2b2679a0c4f7ba4019cd31dd62 MIPS: APRP: Split VPE loader into separate files.

:::::: TO: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
