Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC44BD283
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbiBTXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:17:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiBTXRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:17:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8BC11C09
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645399019; x=1676935019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rfJ/IFZIc/HVYuFxpVLwAV84bFj2swrY1UCftdBPdHA=;
  b=Jo/i+dBpxirzM0+0SeUjXJTgYrqf68dNNA9Nzk4PgZNe7gwYSQur0d7h
   IALCIDen49fHnrFNCatb7+33qqNuEU9I/rptXa3ozX+bdk3EkCGDIHN7L
   p/dbem7XLkMcCvFCE96uKnk6vJWukMg3RWYA0l3R8/VbozlCB9HXW71r5
   0qycMamvbvGVABVW1uzna/bZRsY0C5m+tPa4YuznbKDESd38IhE6vldNN
   WCtWPGXn+cuUWVPY2c864118v1WgxAsJrT/8ejC9K3upV6KdQEX0iOYUX
   pJHhact2N1OpH8e3de8RkcYJhEUmtV3WObDUglXUQL3JymHk1JNI5vSQ/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251356057"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251356057"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504691550"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 15:16:57 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLvRo-000102-H4; Sun, 20 Feb 2022 23:16:56 +0000
Date:   Mon, 21 Feb 2022 07:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:modules-next 9/10] kernel/module/main.c:3411:2: error:
 implicit declaration of function 'init_build_id'
Message-ID: <202202210752.aHR07BgY-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
head:   c55dc78176e6fe97a9e92d24a7ff3015b14ac858
commit: 54f2273e5feff8300714e6b37ef214ed8d8c1b4c [9/10] module: Move kallsyms support into a separate file
config: arm-tct_hammer_defconfig (https://download.01.org/0day-ci/archive/20220221/202202210752.aHR07BgY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=54f2273e5feff8300714e6b37ef214ed8d8c1b4c
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-next
        git checkout 54f2273e5feff8300714e6b37ef214ed8d8c1b4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/module/main.c:3411:2: error: implicit declaration of function 'init_build_id' [-Werror,-Wimplicit-function-declaration]
           init_build_id(mod, info);
           ^
   1 error generated.


vim +/init_build_id +3411 kernel/module/main.c

106a4ee258d148 kernel/module.c Rusty Russell            2012-09-26  3358  
8d8022e8aba851 kernel/module.c Rusty Russell            2013-07-03  3359  	/* To avoid stressing percpu allocator, do this once we're unique. */
9eb76d7797b892 kernel/module.c Rusty Russell            2013-07-03  3360  	err = percpu_modalloc(mod, info);
8d8022e8aba851 kernel/module.c Rusty Russell            2013-07-03  3361  	if (err)
8d8022e8aba851 kernel/module.c Rusty Russell            2013-07-03  3362  		goto unlink_mod;
8d8022e8aba851 kernel/module.c Rusty Russell            2013-07-03  3363  
49668688dd5a5f kernel/module.c Rusty Russell            2010-08-05  3364  	/* Now module is in final location, initialize linked lists, etc. */
9f85a4bbb1cf56 kernel/module.c Rusty Russell            2010-08-05  3365  	err = module_unload_init(mod);
9f85a4bbb1cf56 kernel/module.c Rusty Russell            2010-08-05  3366  	if (err)
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3367  		goto unlink_mod;
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3368  
cf2fde7b39e944 kernel/module.c Rusty Russell            2015-06-26  3369  	init_param_lock(mod);
b51d23e4e9fea6 kernel/module.c Dan Streetman            2015-06-17  3370  
24b9f0d2208145 kernel/module.c Sergey Shtylyov          2020-11-07  3371  	/*
24b9f0d2208145 kernel/module.c Sergey Shtylyov          2020-11-07  3372  	 * Now we've got everything in the final locations, we can
24b9f0d2208145 kernel/module.c Sergey Shtylyov          2020-11-07  3373  	 * find optional sections.
24b9f0d2208145 kernel/module.c Sergey Shtylyov          2020-11-07  3374  	 */
eb3057df732c30 kernel/module.c Frantisek Hrbata         2013-10-14  3375  	err = find_module_sections(mod, info);
eb3057df732c30 kernel/module.c Frantisek Hrbata         2013-10-14  3376  	if (err)
eb3057df732c30 kernel/module.c Frantisek Hrbata         2013-10-14  3377  		goto free_unload;
9b37ccfc637be2 kernel/module.c Pavel Roskin             2008-02-28  3378  
49668688dd5a5f kernel/module.c Rusty Russell            2010-08-05  3379  	err = check_module_license_and_versions(mod);
22e268ebecc549 kernel/module.c Rusty Russell            2010-08-05  3380  	if (err)
22e268ebecc549 kernel/module.c Rusty Russell            2010-08-05  3381  		goto free_unload;
9841d61d75da5e kernel/module.c Dave Jones               2006-01-08  3382  
c988d2b2845495 kernel/module.c Matt Domsch              2005-06-23  3383  	/* Set up MODINFO_ATTR fields */
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3384  	setup_modinfo(mod, info);
c988d2b2845495 kernel/module.c Matt Domsch              2005-06-23  3385  
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3386  	/* Fix up syms, so that st_value is a pointer to location. */
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3387  	err = simplify_symbols(mod, info);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3388  	if (err < 0)
d913188c751911 kernel/module.c Rusty Russell            2010-08-05  3389  		goto free_modinfo;
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3390  
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3391  	err = apply_relocations(mod, info);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3392  	if (err < 0)
d913188c751911 kernel/module.c Rusty Russell            2010-08-05  3393  		goto free_modinfo;
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3394  
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3395  	err = post_relocation(mod, info);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3396  	if (err < 0)
d913188c751911 kernel/module.c Rusty Russell            2010-08-05  3397  		goto free_modinfo;
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3398  
22e268ebecc549 kernel/module.c Rusty Russell            2010-08-05  3399  	flush_module_icache(mod);
378bac820be6a0 kernel/module.c Thomas Koeller           2005-09-06  3400  
cf68fffb66d60d kernel/module.c Sami Tolvanen            2021-04-08  3401  	/* Setup CFI for the module. */
cf68fffb66d60d kernel/module.c Sami Tolvanen            2021-04-08  3402  	cfi_init(mod);
cf68fffb66d60d kernel/module.c Sami Tolvanen            2021-04-08  3403  
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3404  	/* Now copy in args */
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3405  	mod->args = strndup_user(uargs, ~0UL >> 1);
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3406  	if (IS_ERR(mod->args)) {
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3407  		err = PTR_ERR(mod->args);
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3408  		goto free_arch_cleanup;
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3409  	}
8d3b33f67fdc0f kernel/module.c Rusty Russell            2006-03-25  3410  
9294523e376803 kernel/module.c Stephen Boyd             2021-07-07 @3411  	init_build_id(mod, info);
5279631271b322 kernel/module.c Zhou Chengming           2017-07-07  3412  	dynamic_debug_setup(mod, info->debug, info->num_debug);
ff49d74ad383f5 kernel/module.c Yehuda Sadeh             2010-07-03  3413  
a949ae560a511f kernel/module.c Steven Rostedt (Red Hat  2014-04-24  3414) 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
a949ae560a511f kernel/module.c Steven Rostedt (Red Hat  2014-04-24  3415) 	ftrace_module_init(mod);
a949ae560a511f kernel/module.c Steven Rostedt (Red Hat  2014-04-24  3416) 
a3535c7e4f4495 kernel/module.c Rusty Russell            2013-01-21  3417  	/* Finally it's fully formed, ready to start executing. */
a3535c7e4f4495 kernel/module.c Rusty Russell            2013-01-21  3418  	err = complete_formation(mod, info);
a3535c7e4f4495 kernel/module.c Rusty Russell            2013-01-21  3419  	if (err)
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3420  		goto ddebug_cleanup;
be593f4ce4eb1b kernel/module.c Rusty Russell            2010-06-05  3421  
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3422  	err = prepare_coming_module(mod);
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3423  	if (err)
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3424  		goto bug_cleanup;
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3425  
51f3d0f474aaeb kernel/module.c Rusty Russell            2010-08-05  3426  	/* Module is ready to execute: parsing args may do that. */
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3427  	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
4355efbd80482a kernel/module.c Luis R. Rodriguez        2016-02-03  3428  				  -32768, 32767, mod,
ecc8617053e0a9 kernel/module.c Luis R. Rodriguez        2015-03-30  3429  				  unknown_module_param_cb);
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3430  	if (IS_ERR(after_dashes)) {
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3431  		err = PTR_ERR(after_dashes);
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3432  		goto coming_cleanup;
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3433  	} else if (after_dashes) {
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3434  		pr_warn("%s: parameters '%s' after `--' ignored\n",
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3435  		       mod->name, after_dashes);
51e158c12aca3c kernel/module.c Rusty Russell            2014-04-28  3436  	}
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3437  
ca86cad7380e37 kernel/module.c Richard Guy Briggs       2017-02-04  3438  	/* Link in to sysfs. */
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3439  	err = mod_sysfs_setup(mod, info, mod->kp, mod->num_kp);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3440  	if (err < 0)
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3441  		goto coming_cleanup;
80a3d1bb410e00 kernel/module.c Rusty Russell            2010-06-05  3442  
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3443  	if (is_livepatch_module(mod)) {
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3444  		err = copy_module_elf(mod, info);
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3445  		if (err < 0)
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3446  			goto sysfs_cleanup;
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3447  	}
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3448  
48fd11880b5ef0 kernel/module.c Kevin Cernekee           2012-01-13  3449  	/* Get rid of temporary copy. */
b1ae6dc41eaaa9 kernel/module.c Dmitry Torokhov          2022-01-05  3450  	free_copy(info, flags);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3451  
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3452  	/* Done! */
51f3d0f474aaeb kernel/module.c Rusty Russell            2010-08-05  3453  	trace_module_load(mod);
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3454  
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3455  	return do_init_module(mod);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3456  
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3457   sysfs_cleanup:
1ce15ef4f60529 kernel/module.c Jessica Yu               2016-03-22  3458  	mod_sysfs_teardown(mod);
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3459   coming_cleanup:
885a78d4a5b3ad kernel/module.c Aaron Tomlin             2016-10-20  3460  	mod->state = MODULE_STATE_GOING;
a5544880aff90b kernel/module.c Luis R. Rodriguez        2017-02-10  3461  	destroy_params(mod->kp, mod->num_kp);
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3462  	blocking_notifier_call_chain(&module_notify_list,
4c973d1620ae08 kernel/module.c Jessica Yu               2016-03-16  3463  				     MODULE_STATE_GOING, mod);
7e545d6eca20ce kernel/module.c Jessica Yu               2016-03-16  3464  	klp_module_going(mod);
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3465   bug_cleanup:
5e8ed280dab9ee kernel/module.c Miroslav Benes           2020-10-27  3466  	mod->state = MODULE_STATE_GOING;
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3467  	/* module_bug_cleanup needs module_mutex protection */
75676500f8298f kernel/module.c Rusty Russell            2010-06-05  3468  	mutex_lock(&module_mutex);
5336377d622595 kernel/module.c Linus Torvalds           2010-10-05  3469  	module_bug_cleanup(mod);
ee61abb3223e28 kernel/module.c Linus Torvalds           2013-01-20  3470  	mutex_unlock(&module_mutex);
ff7e0055bb5ddb kernel/module.c Andy Lutomirski          2014-08-16  3471  
a3535c7e4f4495 kernel/module.c Rusty Russell            2013-01-21  3472   ddebug_cleanup:
1323eac7fd6560 kernel/module.c Namit Gupta              2018-01-08  3473  	ftrace_release_mod(mod);
5279631271b322 kernel/module.c Zhou Chengming           2017-07-07  3474  	dynamic_debug_remove(mod, info->debug);
cb2f55369d3a9e kernel/module.c Paul E. McKenney         2018-11-06  3475  	synchronize_rcu();
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3476  	kfree(mod->args);
6526c534b2677c kernel/module.c Rusty Russell            2010-08-05  3477   free_arch_cleanup:
cf68fffb66d60d kernel/module.c Sami Tolvanen            2021-04-08  3478  	cfi_cleanup(mod);
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3479  	module_arch_cleanup(mod);
d913188c751911 kernel/module.c Rusty Russell            2010-08-05  3480   free_modinfo:
a263f7763c3640 kernel/module.c Rusty Russell            2009-09-25  3481  	free_modinfo(mod);
22e268ebecc549 kernel/module.c Rusty Russell            2010-08-05  3482   free_unload:
^1da177e4c3f41 kernel/module.c Linus Torvalds           2005-04-16  3483  	module_unload_free(mod);
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3484   unlink_mod:
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3485  	mutex_lock(&module_mutex);
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3486  	/* Unlink carefully: kallsyms could be walking list. */
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3487  	list_del_rcu(&mod->list);
758556bdc1c8a8 kernel/module.c Peter Zijlstra           2015-07-09  3488  	mod_tree_remove(mod);
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3489  	wake_up_all(&module_wq);
0be964be0d4508 kernel/module.c Peter Zijlstra           2015-05-27  3490  	/* Wait for RCU-sched synchronizing before releasing mod->list. */
cb2f55369d3a9e kernel/module.c Paul E. McKenney         2018-11-06  3491  	synchronize_rcu();
1fb9341ac34825 kernel/module.c Rusty Russell            2013-01-12  3492  	mutex_unlock(&module_mutex);
d913188c751911 kernel/module.c Rusty Russell            2010-08-05  3493   free_module:
35a9393c95b318 kernel/module.c Peter Zijlstra           2015-02-26  3494  	/* Free lock-classes; relies on the preceding sync_rcu() */
7523e4dc5057e1 kernel/module.c Rusty Russell            2015-11-26  3495  	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
35a9393c95b318 kernel/module.c Peter Zijlstra           2015-02-26  3496  
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3497  	module_deallocate(mod, info);
d913188c751911 kernel/module.c Rusty Russell            2010-08-05  3498   free_copy:
b1ae6dc41eaaa9 kernel/module.c Dmitry Torokhov          2022-01-05  3499  	free_copy(info, flags);
34e1169d996ab1 kernel/module.c Kees Cook                2012-10-16  3500  	return err;
b99b87f70c7785 kernel/module.c Peter Oberparleiter      2009-06-17  3501  }
b99b87f70c7785 kernel/module.c Peter Oberparleiter      2009-06-17  3502  

:::::: The code at line 3411 was first introduced by commit
:::::: 9294523e3768030ae8afb84110bcecc66425a647 module: add printk formats to add module build ID to stacktraces

:::::: TO: Stephen Boyd <swboyd@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
