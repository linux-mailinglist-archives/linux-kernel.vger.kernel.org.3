Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1457589E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiGOAYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiGOAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:24:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C67098A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657844645; x=1689380645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nm/OVhAzc3zhpntqxbxIshIZhMkLU+gfhOGJ2Wbs86U=;
  b=JeLJFHwX52dLdhNrsftz+It+IMyR5fY58CX62x+rYQNXcLajTfvAWt7w
   NvmbmrczmVOKzTSEcyeRtKK4+ZdZNwVfC2cyjSaZPhXPtCpqxBJRLL72Q
   o46Cdw/bOMuAuzv/OMrMg4kZREBo7O1eRgL9RYOIbpuSeU4V7rRw5BJun
   FQbJ/mSsw08mhFmOnON6XnUqTiHhxOrJeWzqCrPxPgUir/mbNy0LlShxA
   wRb4U5hYEd22ovpd6wcGI6rUP0JqPfKdFz2JdZ/93PBkx+Uf/UYL+c9f8
   k/4gkWZESv3VOdElRhFJG5f2DeSnAqGIFZAhInIvmJOX9vtmMwBRJ6sNs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349630637"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="349630637"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923298808"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 17:23:52 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC97X-0001J1-SE;
        Fri, 15 Jul 2022 00:23:51 +0000
Date:   Fri, 15 Jul 2022 08:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/joel.2022.07.14a 25/27]
 kernel/rcu/rcuscale.c:819:14: error: call to undeclared function
 'rcu_lazy_get_jiffies_till_flush'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202207150859.kU3p78eN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/joel.2022.07.14a
head:   37d0460c40e7e364151894260d483ade68b1de34
commit: 39e5f05326df757fa3be4617773fafb0454d9ec7 [25/27] rcuscale: Add laziness and kfree tests
config: hexagon-randconfig-r041-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150859.kU3p78eN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/39e5f05326df757fa3be4617773fafb0454d9ec7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/joel.2022.07.14a
        git checkout 39e5f05326df757fa3be4617773fafb0454d9ec7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/rcu/rcuscale.c:819:14: error: call to undeclared function 'rcu_lazy_get_jiffies_till_flush'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   orig_jif = rcu_lazy_get_jiffies_till_flush();
                              ^
>> kernel/rcu/rcuscale.c:822:3: error: call to undeclared function 'rcu_lazy_set_jiffies_till_flush'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   rcu_lazy_set_jiffies_till_flush(2 * HZ);
                   ^
   2 errors generated.


vim +/rcu_lazy_get_jiffies_till_flush +819 kernel/rcu/rcuscale.c

   796	
   797	static int __init
   798	kfree_scale_init(void)
   799	{
   800		long i;
   801		int firsterr = 0;
   802		unsigned long orig_jif, jif_start;
   803	
   804		// If lazy-rcu based kfree'ing is requested, then for kernels that
   805		// support it, force all call_rcu() to call_rcu_lazy() so that non-lazy
   806		// CBs do not remove laziness of the lazy ones (since the test tries to
   807		// stress call_rcu_lazy() for OOM).
   808		//
   809		// Also, do a quick self-test to ensure laziness is as much as
   810		// expected.
   811		if (kfree_rcu_by_lazy && !IS_ENABLED(CONFIG_RCU_LAZY)) {
   812			pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() "
   813				 "for delayed RCU kfree'ing\n");
   814			kfree_rcu_by_lazy = 0;
   815		}
   816	
   817		if (kfree_rcu_by_lazy) {
   818			/* do a test to check the timeout. */
 > 819			orig_jif = rcu_lazy_get_jiffies_till_flush();
   820	
   821			rcu_force_call_rcu_to_lazy(true);
 > 822			rcu_lazy_set_jiffies_till_flush(2 * HZ);
   823			rcu_barrier();
   824	
   825			jif_start = jiffies;
   826			jiffies_at_lazy_cb = 0;
   827			call_rcu_lazy(&lazy_test1_rh, call_rcu_lazy_test1);
   828	
   829			smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
   830	
   831			rcu_lazy_set_jiffies_till_flush(orig_jif);
   832	
   833			if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
   834				pr_alert("ERROR: Lazy CBs are not being lazy as expected!\n");
   835				WARN_ON_ONCE(1);
   836				return -1;
   837			}
   838	
   839			if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
   840				pr_alert("ERROR: Lazy CBs are being too lazy!\n");
   841				WARN_ON_ONCE(1);
   842				return -1;
   843			}
   844		}
   845	
   846		kfree_nrealthreads = compute_real(kfree_nthreads);
   847		/* Start up the kthreads. */
   848		if (shutdown) {
   849			init_waitqueue_head(&shutdown_wq);
   850			firsterr = torture_create_kthread(kfree_scale_shutdown, NULL,
   851							  shutdown_task);
   852			if (torture_init_error(firsterr))
   853				goto unwind;
   854			schedule_timeout_uninterruptible(1);
   855		}
   856	
   857		pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
   858				kfree_mult * sizeof(struct kfree_obj),
   859				kfree_rcu_by_lazy);
   860	
   861		kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
   862				       GFP_KERNEL);
   863		if (kfree_reader_tasks == NULL) {
   864			firsterr = -ENOMEM;
   865			goto unwind;
   866		}
   867	
   868		for (i = 0; i < kfree_nrealthreads; i++) {
   869			firsterr = torture_create_kthread(kfree_scale_thread, (void *)i,
   870							  kfree_reader_tasks[i]);
   871			if (torture_init_error(firsterr))
   872				goto unwind;
   873		}
   874	
   875		while (atomic_read(&n_kfree_scale_thread_started) < kfree_nrealthreads)
   876			schedule_timeout_uninterruptible(1);
   877	
   878		torture_init_end();
   879		return 0;
   880	
   881	unwind:
   882		torture_init_end();
   883		kfree_scale_cleanup();
   884		return firsterr;
   885	}
   886	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
