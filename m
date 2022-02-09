Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEFA4AF2A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiBIN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiBIN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:26:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E94C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644413210; x=1675949210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yRxLiCCsKty7UwQgrjOb+UfCHwO5LNQYwAMxkh40LT4=;
  b=UKTO0+RZSAkK1SSmtPYHLwFnqeevJ4VvBKzDjs9Y4boaycvEtJhq2dT6
   Uo3jBAN2DZdpdG9U/zVYraz+JrePOJvgelXK+rUz3ReOWYwmMUdHQsRAG
   99/SHij6JtAA0nqnF5DSoGTqVubkZlXX9Rm7g3EoPTz6FROcQbHqF1LWT
   ul3XcVeGLdlFDdaqXnbRkIFyNLh+3trDl8iIENN89N1LO1cUXpgXs7AbI
   YBfrsFa5RQTz73sMHj6KzXKL4rZpybDDHs2DBExkW5Jd7Vs3FjICBS9Oy
   Ipyu6ucxTVp4dFhM60LDF52h8QK1Al8tIIkohoP4xla9SycENoSdgnuTE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248961459"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="248961459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="482326542"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2022 05:26:48 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHmzf-0001rU-UQ; Wed, 09 Feb 2022 13:26:47 +0000
Date:   Wed, 9 Feb 2022 21:26:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 29/29] kernel/sched/fair.c:230:2: error:
 implicit declaration of function 'sched_cfs_bandwidth_sysctl_init'
Message-ID: <202202092107.WdTEsmSF-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   bf8d9ef490e0600b3b30ac2244858ecd327123ab
commit: bf8d9ef490e0600b3b30ac2244858ecd327123ab [29/29] sched: Move cfs_bandwidth_slice sysctls to fair.c
config: hexagon-randconfig-r045-20220209 (https://download.01.org/0day-ci/archive/20220209/202202092107.WdTEsmSF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=bf8d9ef490e0600b3b30ac2244858ecd327123ab
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout bf8d9ef490e0600b3b30ac2244858ecd327123ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sched/fair.c:230:2: error: implicit declaration of function 'sched_cfs_bandwidth_sysctl_init' [-Werror,-Wimplicit-function-declaration]
           sched_cfs_bandwidth_sysctl_init();
           ^
   kernel/sched/fair.c:652:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]
   int sched_update_scaling(void)
       ^
   kernel/sched/fair.c:652:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_update_scaling(void)
   ^
   static 
   kernel/sched/fair.c:5469:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:5469:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
   kernel/sched/fair.c:11694:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11694:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11696:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:11696:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:11701:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11701:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11703:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11703:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   6 warnings and 1 error generated.


vim +/sched_cfs_bandwidth_sysctl_init +230 kernel/sched/fair.c

   226	
   227	void __init sched_init_granularity(void)
   228	{
   229		update_sysctl();
 > 230		sched_cfs_bandwidth_sysctl_init();
   231	}
   232	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
