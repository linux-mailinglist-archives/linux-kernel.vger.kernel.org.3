Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F97536A73
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 05:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiE1Dgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 23:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE1Dgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 23:36:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D291511A28
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653708997; x=1685244997;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JXJb4Sb6zAjxoHyneonrl0atdJFhOhJQ/INRGlHqsJ8=;
  b=QkIhaXD1Wwhs+JDP9+zF5YhvktYCaw3/6cvWbVVpZFib5EZurca8qIkS
   TzMDZuq409a+jM/7hbQD+85TphK/jrR5qRQKnnpSr0526wl2JmYFHmukp
   /JCDztlhkX+72qqpP9gV1NfZ9HYIaS5SqdcKxkX20GHRc4/IR9PUpfDuD
   4wJMBkXQkV/yZC4YKHZMwyxMlZaWkH7I6TFZnRwrwkQxbgqLISQy3A/Kf
   qOfbbvVKVRqqE8zQ4/LFWHNSi3DLQZGViXCItFfHzCY+EiFPYB4JYel9Y
   KgXtCgiyE/MtdPnIStzORodxslt+ACVb6KSXlt4U+WUTlZaEYO4MXxXD3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="337667635"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="337667635"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 20:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="747347549"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 20:36:35 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nunFi-0005PZ-Tm;
        Sat, 28 May 2022 03:36:34 +0000
Date:   Sat, 28 May 2022 11:36:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: fs/io_uring.c:6212:38: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202205281143.T47kfDb1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a9f94826e4bb6402e67f3eb849dee0811f1de6da
commit: 58f5c8d39e0ea07fdaaea6a85c49000da83dc0cc io_uring: make apoll_events a __poll_t
date:   10 days ago
config: arc-randconfig-s031-20220527 (https://download.01.org/0day-ci/archive/20220528/202205281143.T47kfDb1-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58f5c8d39e0ea07fdaaea6a85c49000da83dc0cc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 58f5c8d39e0ea07fdaaea6a85c49000da83dc0cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c:5375:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5375:14: sparse:     expected struct file *file
   fs/io_uring.c:5375:14: sparse:     got struct file [noderef] __rcu *
>> fs/io_uring.c:6212:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   fs/io_uring.c:6212:38: sparse:     expected signed int [usertype] res
   fs/io_uring.c:6212:38: sparse:     got restricted __poll_t
   fs/io_uring.c:6223:56: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6222:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6222:66: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6222:66: sparse:     got unsigned int
   fs/io_uring.c:6222:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:6222:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6222:52: sparse:     got unsigned short
   fs/io_uring.c:6228:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6228:50: sparse:     expected signed int [usertype] res
   fs/io_uring.c:6228:50: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6265:68: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6265:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6265:57: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6265:57: sparse:     got unsigned int
   fs/io_uring.c:6370:47: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6370:35: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6370:23: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6383:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6383:40: sparse:     expected int mask
   fs/io_uring.c:6383:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6475:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6475:24: sparse:     expected int
   fs/io_uring.c:6475:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6492:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6492:40: sparse:     expected int mask
   fs/io_uring.c:6492:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6527:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   fs/io_uring.c:6527:33: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6527:33: sparse:     got int
   fs/io_uring.c:6540:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6540:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6540:22: sparse:    right side has type int
   fs/io_uring.c:6545:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6545:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6545:30: sparse:    right side has type int
   fs/io_uring.c:6547:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6547:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6547:22: sparse:    right side has type int
   fs/io_uring.c:6575:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6575:33: sparse:     expected int mask
   fs/io_uring.c:6575:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6575:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6575:50: sparse:     expected int events
   fs/io_uring.c:6575:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6689:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6689:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6689:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6690:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6690:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6690:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6690:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6690:38: sparse:     got unsigned int
   fs/io_uring.c:6777:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6777:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6777:43: sparse:    right side has type int
   fs/io_uring.c:6778:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6778:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6778:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6778:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2610:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:8980:9: sparse: sparse: context imbalance in 'io_sq_thread_unpark' - wrong count at exit
   fs/io_uring.c:8991:9: sparse: sparse: context imbalance in 'io_sq_thread_park' - wrong count at exit

vim +6212 fs/io_uring.c

18bceab101adde Jens Axboe     2020-05-15  6178  
dbc2564cfe0faf Hao Xu         2022-05-14  6179  static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags);
aa43477b040251 Pavel Begunkov 2021-12-15  6180  /*
aa43477b040251 Pavel Begunkov 2021-12-15  6181   * All poll tw should go through this. Checks for poll events, manages
aa43477b040251 Pavel Begunkov 2021-12-15  6182   * references, does rewait, etc.
aa43477b040251 Pavel Begunkov 2021-12-15  6183   *
aa43477b040251 Pavel Begunkov 2021-12-15  6184   * Returns a negative error on failure. >0 when no action require, which is
aa43477b040251 Pavel Begunkov 2021-12-15  6185   * either spurious wakeup or multishot CQE is served. 0 when it's done with
cef216fc32d762 Pavel Begunkov 2022-04-12  6186   * the request, then the mask is stored in req->cqe.res.
aa43477b040251 Pavel Begunkov 2021-12-15  6187   */
dbc2564cfe0faf Hao Xu         2022-05-14  6188  static int io_poll_check_events(struct io_kiocb *req, bool *locked)
18bceab101adde Jens Axboe     2020-05-15  6189  {
18bceab101adde Jens Axboe     2020-05-15  6190  	struct io_ring_ctx *ctx = req->ctx;
dbc2564cfe0faf Hao Xu         2022-05-14  6191  	int v, ret;
18bceab101adde Jens Axboe     2020-05-15  6192  
316319e82f7342 Jens Axboe     2021-08-19  6193  	/* req->task == current here, checking PF_EXITING is safe */
e09ee510600b94 Pavel Begunkov 2021-07-01  6194  	if (unlikely(req->task->flags & PF_EXITING))
f22190570b213d Pavel Begunkov 2022-04-15  6195  		return -ECANCELED;
e09ee510600b94 Pavel Begunkov 2021-07-01  6196  
aa43477b040251 Pavel Begunkov 2021-12-15  6197  	do {
aa43477b040251 Pavel Begunkov 2021-12-15  6198  		v = atomic_read(&req->poll_refs);
aa43477b040251 Pavel Begunkov 2021-12-15  6199  
aa43477b040251 Pavel Begunkov 2021-12-15  6200  		/* tw handler should be the owner, and so have some references */
aa43477b040251 Pavel Begunkov 2021-12-15  6201  		if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
aa43477b040251 Pavel Begunkov 2021-12-15  6202  			return 0;
aa43477b040251 Pavel Begunkov 2021-12-15  6203  		if (v & IO_POLL_CANCEL_FLAG)
aa43477b040251 Pavel Begunkov 2021-12-15  6204  			return -ECANCELED;
aa43477b040251 Pavel Begunkov 2021-12-15  6205  
cef216fc32d762 Pavel Begunkov 2022-04-12  6206  		if (!req->cqe.res) {
2804ecd8d3e373 Jens Axboe     2022-04-11  6207  			struct poll_table_struct pt = { ._key = req->apoll_events };
cce64ef01308b6 Pavel Begunkov 2022-04-13  6208  			unsigned flags = locked ? 0 : IO_URING_F_UNLOCKED;
74ce6ce43d4fc6 Jens Axboe     2020-04-13  6209  
cce64ef01308b6 Pavel Begunkov 2022-04-13  6210  			if (unlikely(!io_assign_file(req, flags)))
7179c3ce3dbff6 Pavel Begunkov 2022-04-13  6211  				return -EBADF;
cef216fc32d762 Pavel Begunkov 2022-04-12 @6212  			req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
e27414bef7b4f2 Pavel Begunkov 2021-04-09  6213  		}
74ce6ce43d4fc6 Jens Axboe     2020-04-13  6214  
dbc2564cfe0faf Hao Xu         2022-05-14  6215  		if ((unlikely(!req->cqe.res)))
dbc2564cfe0faf Hao Xu         2022-05-14  6216  			continue;
dbc2564cfe0faf Hao Xu         2022-05-14  6217  		if (req->apoll_events & EPOLLONESHOT)
dbc2564cfe0faf Hao Xu         2022-05-14  6218  			return 0;
dbc2564cfe0faf Hao Xu         2022-05-14  6219  
dbc2564cfe0faf Hao Xu         2022-05-14  6220  		/* multishot, just fill a CQE and proceed */
dbc2564cfe0faf Hao Xu         2022-05-14  6221  		if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
dbc2564cfe0faf Hao Xu         2022-05-14  6222  			__poll_t mask = mangle_poll(req->cqe.res &
dbc2564cfe0faf Hao Xu         2022-05-14  6223  						    req->apoll_events);
aa43477b040251 Pavel Begunkov 2021-12-15  6224  			bool filled;
74ce6ce43d4fc6 Jens Axboe     2020-04-13  6225  
aa43477b040251 Pavel Begunkov 2021-12-15  6226  			spin_lock(&ctx->completion_lock);
dbc2564cfe0faf Hao Xu         2022-05-14  6227  			filled = io_fill_cqe_aux(ctx, req->cqe.user_data,
dbc2564cfe0faf Hao Xu         2022-05-14  6228  						 mask, IORING_CQE_F_MORE);
aa43477b040251 Pavel Begunkov 2021-12-15  6229  			io_commit_cqring(ctx);
aa43477b040251 Pavel Begunkov 2021-12-15  6230  			spin_unlock(&ctx->completion_lock);
dbc2564cfe0faf Hao Xu         2022-05-14  6231  			if (filled) {
aa43477b040251 Pavel Begunkov 2021-12-15  6232  				io_cqring_ev_posted(ctx);
dbc2564cfe0faf Hao Xu         2022-05-14  6233  				continue;
a62682f92eedb4 Hao Xu         2021-09-22  6234  			}
dbc2564cfe0faf Hao Xu         2022-05-14  6235  			return -ECANCELED;
dbc2564cfe0faf Hao Xu         2022-05-14  6236  		}
dbc2564cfe0faf Hao Xu         2022-05-14  6237  
dbc2564cfe0faf Hao Xu         2022-05-14  6238  		io_tw_lock(req->ctx, locked);
dbc2564cfe0faf Hao Xu         2022-05-14  6239  		if (unlikely(req->task->flags & PF_EXITING))
dbc2564cfe0faf Hao Xu         2022-05-14  6240  			return -EFAULT;
dbc2564cfe0faf Hao Xu         2022-05-14  6241  		ret = io_issue_sqe(req,
dbc2564cfe0faf Hao Xu         2022-05-14  6242  				   IO_URING_F_NONBLOCK|IO_URING_F_COMPLETE_DEFER);
dbc2564cfe0faf Hao Xu         2022-05-14  6243  		if (ret)
dbc2564cfe0faf Hao Xu         2022-05-14  6244  			return ret;
7b289c38335ec7 Hao Xu         2021-04-13  6245  
aa43477b040251 Pavel Begunkov 2021-12-15  6246  		/*
aa43477b040251 Pavel Begunkov 2021-12-15  6247  		 * Release all references, retry if someone tried to restart
aa43477b040251 Pavel Begunkov 2021-12-15  6248  		 * task_work while we were executing it.
aa43477b040251 Pavel Begunkov 2021-12-15  6249  		 */
aa43477b040251 Pavel Begunkov 2021-12-15  6250  	} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
18bceab101adde Jens Axboe     2020-05-15  6251  
aa43477b040251 Pavel Begunkov 2021-12-15  6252  	return 1;
18bceab101adde Jens Axboe     2020-05-15  6253  }
18bceab101adde Jens Axboe     2020-05-15  6254  

:::::: The code at line 6212 was first introduced by commit
:::::: cef216fc32d7628206c523994e7e267e7a8dda59 io_uring: explicitly keep a CQE in io_kiocb

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
