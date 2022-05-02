Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7A516AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383404AbiEBGY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiEBGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:24:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5880B2702
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651472484; x=1683008484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=biwKOA28VeX5Nrjpb+vh/m5zHN7TB76nMxJdSjk9EOs=;
  b=ed7XaPg66OUiIiio3bniO0ymECHSX96W/ArpPMBtMJNKJHzOwTgNa0K0
   UVe6vI1bdIGDoDHHvzq/XJyTR3c0RZ8ETazEo0NgfXfiEdK/b723cILwL
   s8UWpNPZNWtoP7luaaNtbevfbZtmxqA9vlDQOMCiGn0m/HkDtwzXrBGLx
   GQNjKXfezfTZkfqjLYhhnH7JtB7A7BmU68wcv4Qj443vcSRxZLq15KLXC
   JmH4isHU+Q/ZEsvRosniNOGEL4T8WB8uYElpx1aNWTwAPzeDYCQVpED5N
   oZFqgsOHfZbAB2T8ETnoVNq0NcMNJX+o8WBx6TWV6L0NhBX0OIpeFMuRs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247046912"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247046912"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 23:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="733293262"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2022 23:21:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlPQv-0009L9-Rq;
        Mon, 02 May 2022 06:21:21 +0000
Date:   Mon, 2 May 2022 14:20:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tomoyo-test1:master 2/2] drivers/infiniband/core/device.c:2857:2:
 error: call to __compiletime_assert_500 declared with 'error' attribute:
 Please avoid flushing system_unbound_wq.
Message-ID: <202205021448.6SzhD1Cz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git master
head:   c806998d6e2cfdbcf8f4b241b709552b7d85fa3e
commit: c806998d6e2cfdbcf8f4b241b709552b7d85fa3e [2/2] workqueue: Wrap flush_workqueue() using a macro
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220502/202205021448.6SzhD1Cz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add tomoyo-test1 https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git
        git fetch --no-tags tomoyo-test1 master
        git checkout c806998d6e2cfdbcf8f4b241b709552b7d85fa3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/infiniband/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/infiniband/core/device.c:2857:2: error: call to __compiletime_assert_500 declared with 'error' attribute: Please avoid flushing system_unbound_wq.
           flush_workqueue(system_unbound_wq);
           ^
   include/linux/workqueue.h:669:2: note: expanded from macro 'flush_workqueue'
           BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_unbound_wq) && \
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:39:1: note: expanded from here
   __compiletime_assert_500
   ^
   1 error generated.


vim +/error +2857 drivers/infiniband/core/device.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  2840  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2841  static void __exit ib_core_cleanup(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2842  {
5ef8c0c180a631 Jason Gunthorpe   2018-05-28  2843  	roce_gid_mgmt_cleanup();
6c80b41abe22ae Leon Romanovsky   2017-06-20  2844  	nldev_exit();
c9901724a2f141 Leon Romanovsky   2017-06-05  2845  	rdma_nl_unregister(RDMA_NL_LS);
4e0f7b9070726a Parav Pandit      2019-02-26  2846  	unregister_pernet_device(&rdma_dev_net_ops);
42df744c4166af Janne Karhunen    2019-06-14  2847  	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
c2e49c92326f9b Mark Bloch        2016-05-19  2848  	ib_sa_cleanup();
4c2cb4220431cb Mark Bloch        2016-05-19  2849  	ib_mad_cleanup();
e3f20f02864f6d Leon Romanovsky   2016-05-19  2850  	addr_cleanup();
c9901724a2f141 Leon Romanovsky   2017-06-05  2851  	rdma_nl_exit();
55aeed06544f67 Jason Gunthorpe   2015-08-04  2852  	class_unregister(&ib_class);
f794809a7259df Jack Morgenstein  2018-08-27  2853  	destroy_workqueue(ib_comp_unbound_wq);
14d3a3b2498eda Christoph Hellwig 2015-12-11  2854  	destroy_workqueue(ib_comp_wq);
f7c6a7b5d59980 Roland Dreier     2007-03-04  2855  	/* Make sure that any pending umem accounting work is done. */
f06267104dd911 Tejun Heo         2010-10-19  2856  	destroy_workqueue(ib_wq);
d0899892edd089 Jason Gunthorpe   2019-02-12 @2857  	flush_workqueue(system_unbound_wq);
e59178d895afa2 Jason Gunthorpe   2019-02-06  2858  	WARN_ON(!xa_empty(&clients));
0df91bb67334ee Jason Gunthorpe   2019-02-06  2859  	WARN_ON(!xa_empty(&devices));
^1da177e4c3f41 Linus Torvalds    2005-04-16  2860  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  2861  

:::::: The code at line 2857 was first introduced by commit
:::::: d0899892edd089790eb17943ecf28254a909deae RDMA/device: Provide APIs from the core code to help unregistration

:::::: TO: Jason Gunthorpe <jgg@mellanox.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
