Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23DA5336C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiEYGeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbiEYGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:34:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948604EA11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653460429; x=1684996429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UY9EOvuTWTCgZnTrz4P6I4WVEY/YYj39aLr977C+sDY=;
  b=nev61ui+N7n58vxmt41Cx99v+9OSspRxbP36dnUtUwJeZmu1ors5Z+o6
   ckLE6LhKfHbJOSj4I6zC3cB4YdgT9C2OP+Xup7uQzOF7IO6AG9rny66+2
   s4JTGgQOQJt5s88tN2sL9YDneSj6xVQr8nrVGvu/fprbQurTU7NJmDGyw
   Xa+g8vYAWp3KyBJpu/7aYseaEkglwFMG04T5b4EvLS8BEwsdJiBXRS0+X
   kwDoMDD4+BP2k276UwtWQp5mEUL/647GXU48874fXQfytqD8mYJf0NmZT
   6+mpMLQCn8/8PpLLMfzFjcvVBBEqq47L5WxkGKjQYehq63LVx/1xdQvnh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273727566"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273727566"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="717504973"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2022 23:33:45 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntkaX-0002oI-8D;
        Wed, 25 May 2022 06:33:45 +0000
Date:   Wed, 25 May 2022 14:33:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring 8/40]
 io_uring/io_uring.c:6701:38: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202205251432.irxNkGpU-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring
head:   9da4fba4e0165c5e40d689eb5d34b73d780bf067
commit: 4ad7740c8e760244c249fff910d82f4fcf214bda [8/40] io_uring: move to separate directory
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220525/202205251432.irxNkGpU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/4ad7740c8e760244c249fff910d82f4fcf214bda
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring
        git checkout 4ad7740c8e760244c249fff910d82f4fcf214bda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   io_uring/io_uring.c:204:37: sparse: sparse: array of flexible structures
>> io_uring/io_uring.c:6701:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/io_uring.c:6701:38: sparse:     expected signed int [usertype] res
   io_uring/io_uring.c:6701:38: sparse:     got restricted __poll_t
>> io_uring/io_uring.c:6712:56: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/io_uring.c:6711:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/io_uring.c:6711:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/io_uring.c:6711:66: sparse:     got unsigned int
>> io_uring/io_uring.c:6711:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/io_uring.c:6711:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/io_uring.c:6711:52: sparse:     got unsigned short
>> io_uring/io_uring.c:6717:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/io_uring.c:6717:50: sparse:     expected signed int [usertype] res
   io_uring/io_uring.c:6717:50: sparse:     got restricted __poll_t [usertype] mask
   io_uring/io_uring.c:6754:68: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:6754:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/io_uring.c:6754:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/io_uring.c:6754:57: sparse:     got unsigned int
>> io_uring/io_uring.c:6872:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/io_uring.c:6872:40: sparse:     expected int mask
   io_uring/io_uring.c:6872:40: sparse:     got restricted __poll_t [usertype] mask
>> io_uring/io_uring.c:6964:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/io_uring.c:6964:24: sparse:     expected int
   io_uring/io_uring.c:6964:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/io_uring.c:6981:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/io_uring.c:6981:40: sparse:     expected int mask
   io_uring/io_uring.c:6981:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/io_uring.c:7016:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   io_uring/io_uring.c:7016:33: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/io_uring.c:7016:33: sparse:     got int
   io_uring/io_uring.c:7064:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/io_uring.c:7064:33: sparse:     expected int mask
   io_uring/io_uring.c:7064:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/io_uring.c:7064:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/io_uring.c:7064:50: sparse:     expected int events
   io_uring/io_uring.c:7064:50: sparse:     got restricted __poll_t [usertype] events
>> io_uring/io_uring.c:7178:24: sparse: sparse: invalid assignment: |=
>> io_uring/io_uring.c:7178:24: sparse:    left side has type unsigned int
>> io_uring/io_uring.c:7178:24: sparse:    right side has type restricted __poll_t
   io_uring/io_uring.c:7179:65: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:7179:29: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/io_uring.c:7179:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/io_uring.c:7179:38: sparse:     expected restricted __poll_t
   io_uring/io_uring.c:7179:38: sparse:     got unsigned int
   io_uring/io_uring.c:7266:43: sparse: sparse: invalid assignment: &=
>> io_uring/io_uring.c:7266:43: sparse:    left side has type restricted __poll_t
>> io_uring/io_uring.c:7266:43: sparse:    right side has type int
   io_uring/io_uring.c:7267:62: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:7267:43: sparse: sparse: invalid assignment: |=
   io_uring/io_uring.c:7267:43: sparse:    left side has type restricted __poll_t
>> io_uring/io_uring.c:7267:43: sparse:    right side has type unsigned int
   io_uring/io_uring.c:2676:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   io_uring/io_uring.c:9284:9: sparse: sparse: context imbalance in 'io_sq_thread_unpark' - wrong count at exit
   io_uring/io_uring.c:9295:9: sparse: sparse: context imbalance in 'io_sq_thread_park' - wrong count at exit

vim +6701 io_uring/io_uring.c

18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6667  
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6668  static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6669  /*
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6670   * All poll tw should go through this. Checks for poll events, manages
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6671   * references, does rewait, etc.
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6672   *
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6673   * Returns a negative error on failure. >0 when no action require, which is
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6674   * either spurious wakeup or multishot CQE is served. 0 when it's done with
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6675   * the request, then the mask is stored in req->cqe.res.
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6676   */
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6677  static int io_poll_check_events(struct io_kiocb *req, bool *locked)
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6678  {
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6679  	struct io_ring_ctx *ctx = req->ctx;
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6680  	int v, ret;
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6681  
316319e82f7342 fs/io_uring.c Jens Axboe        2021-08-19  6682  	/* req->task == current here, checking PF_EXITING is safe */
e09ee510600b94 fs/io_uring.c Pavel Begunkov    2021-07-01  6683  	if (unlikely(req->task->flags & PF_EXITING))
f22190570b213d fs/io_uring.c Pavel Begunkov    2022-04-15  6684  		return -ECANCELED;
e09ee510600b94 fs/io_uring.c Pavel Begunkov    2021-07-01  6685  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6686  	do {
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6687  		v = atomic_read(&req->poll_refs);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6688  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6689  		/* tw handler should be the owner, and so have some references */
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6690  		if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6691  			return 0;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6692  		if (v & IO_POLL_CANCEL_FLAG)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6693  			return -ECANCELED;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6694  
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6695  		if (!req->cqe.res) {
2804ecd8d3e373 fs/io_uring.c Jens Axboe        2022-04-11  6696  			struct poll_table_struct pt = { ._key = req->apoll_events };
cce64ef01308b6 fs/io_uring.c Pavel Begunkov    2022-04-13  6697  			unsigned flags = locked ? 0 : IO_URING_F_UNLOCKED;
74ce6ce43d4fc6 fs/io_uring.c Jens Axboe        2020-04-13  6698  
cce64ef01308b6 fs/io_uring.c Pavel Begunkov    2022-04-13  6699  			if (unlikely(!io_assign_file(req, flags)))
7179c3ce3dbff6 fs/io_uring.c Pavel Begunkov    2022-04-13  6700  				return -EBADF;
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12 @6701  			req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
e27414bef7b4f2 fs/io_uring.c Pavel Begunkov    2021-04-09  6702  		}
74ce6ce43d4fc6 fs/io_uring.c Jens Axboe        2020-04-13  6703  
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6704  		if ((unlikely(!req->cqe.res)))
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6705  			continue;
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6706  		if (req->apoll_events & EPOLLONESHOT)
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6707  			return 0;
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6708  
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6709  		/* multishot, just fill a CQE and proceed */
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6710  		if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14 @6711  			__poll_t mask = mangle_poll(req->cqe.res &
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14 @6712  						    req->apoll_events);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6713  			bool filled;
74ce6ce43d4fc6 fs/io_uring.c Jens Axboe        2020-04-13  6714  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6715  			spin_lock(&ctx->completion_lock);
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6716  			filled = io_fill_cqe_aux(ctx, req->cqe.user_data,
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14 @6717  						 mask, IORING_CQE_F_MORE);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6718  			io_commit_cqring(ctx);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6719  			spin_unlock(&ctx->completion_lock);
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6720  			if (filled) {
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6721  				io_cqring_ev_posted(ctx);
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6722  				continue;
a62682f92eedb4 fs/io_uring.c Hao Xu            2021-09-22  6723  			}
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6724  			return -ECANCELED;
a62682f92eedb4 fs/io_uring.c Hao Xu            2021-09-22  6725  		}
7b289c38335ec7 fs/io_uring.c Hao Xu            2021-04-13  6726  
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6727  		io_tw_lock(req->ctx, locked);
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6728  		if (unlikely(req->task->flags & PF_EXITING))
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6729  			return -EFAULT;
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6730  		ret = io_issue_sqe(req,
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6731  				   IO_URING_F_NONBLOCK|IO_URING_F_COMPLETE_DEFER);
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6732  		if (ret)
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6733  			return ret;
7b289c38335ec7 fs/io_uring.c Hao Xu            2021-04-13  6734  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6735  		/*
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6736  		 * Release all references, retry if someone tried to restart
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6737  		 * task_work while we were executing it.
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6738  		 */
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6739  	} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6740  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6741  	return 1;
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6742  }
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6743  
f237c30a5610d3 fs/io_uring.c Pavel Begunkov    2021-08-18  6744  static void io_poll_task_func(struct io_kiocb *req, bool *locked)
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6745  {
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6746  	struct io_ring_ctx *ctx = req->ctx;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6747  	int ret;
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6748  
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6749  	ret = io_poll_check_events(req, locked);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6750  	if (ret > 0)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6751  		return;
88e41cf928a6e1 fs/io_uring.c Jens Axboe        2021-02-22  6752  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6753  	if (!ret) {
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6754  		req->cqe.res = mangle_poll(req->cqe.res & req->poll.events);
f40b964a66ace5 fs/io_uring.c Pavel Begunkov    2021-04-09  6755  	} else {
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6756  		req->cqe.res = ret;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6757  		req_set_fail(req);
88e41cf928a6e1 fs/io_uring.c Jens Axboe        2021-02-22  6758  	}
913a571affedd1 fs/io_uring.c Pavel Begunkov    2021-11-10  6759  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6760  	io_poll_remove_entries(req);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6761  	spin_lock(&ctx->completion_lock);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6762  	hash_del(&req->hash_node);
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6763  	__io_req_complete_post(req, req->cqe.res, 0);
31efe48eb5dc4d fs/io_uring.c Xiaoguang Wang    2021-09-03  6764  	io_commit_cqring(ctx);
79ebeaee8a21a0 fs/io_uring.c Jens Axboe        2021-08-10  6765  	spin_unlock(&ctx->completion_lock);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6766  	io_cqring_ev_posted(ctx);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6767  }
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6768  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6769  static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6770  {
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6771  	struct io_ring_ctx *ctx = req->ctx;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6772  	int ret;
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6773  
dbc2564cfe0faf fs/io_uring.c Hao Xu            2022-05-14  6774  	ret = io_poll_check_events(req, locked);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6775  	if (ret > 0)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6776  		return;
88e41cf928a6e1 fs/io_uring.c Jens Axboe        2021-02-22  6777  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6778  	io_poll_remove_entries(req);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6779  	spin_lock(&ctx->completion_lock);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6780  	hash_del(&req->hash_node);
5b7aa38d86f348 fs/io_uring.c Hao Xu            2021-09-22  6781  	spin_unlock(&ctx->completion_lock);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6782  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6783  	if (!ret)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6784  		io_req_task_submit(req, locked);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6785  	else
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6786  		io_req_complete_failed(req, ret);
5b7aa38d86f348 fs/io_uring.c Hao Xu            2021-09-22  6787  }
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6788  
58f5c8d39e0ea0 fs/io_uring.c Christoph Hellwig 2022-05-18  6789  static void __io_poll_execute(struct io_kiocb *req, int mask, __poll_t events)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6790  {
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6791  	req->cqe.res = mask;
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6792  	/*
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6793  	 * This is useful for poll that is armed on behalf of another
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6794  	 * request, and where the wakeup path could be on a different
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6795  	 * CPU. We want to avoid pulling in req->apoll->events for that
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6796  	 * case.
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6797  	 */
2804ecd8d3e373 fs/io_uring.c Jens Axboe        2022-04-11  6798  	req->apoll_events = events;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6799  	if (req->opcode == IORING_OP_POLL_ADD)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6800  		req->io_task_work.func = io_poll_task_func;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6801  	else
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6802  		req->io_task_work.func = io_apoll_task_func;
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6803  
cef216fc32d762 fs/io_uring.c Pavel Begunkov    2022-04-12  6804  	trace_io_uring_task_add(req->ctx, req, req->cqe.user_data, req->opcode, mask);
3fe07bcd800d6e fs/io_uring.c Jens Axboe        2022-05-21  6805  	io_req_task_work_add(req);
dd221f46f68ad9 fs/io_uring.c Pavel Begunkov    2020-10-18  6806  }
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6807  
58f5c8d39e0ea0 fs/io_uring.c Christoph Hellwig 2022-05-18  6808  static inline void io_poll_execute(struct io_kiocb *req, int res,
58f5c8d39e0ea0 fs/io_uring.c Christoph Hellwig 2022-05-18  6809  		__poll_t events)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6810  {
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6811  	if (io_poll_get_ownership(req))
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6812  		__io_poll_execute(req, res, events);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6813  }
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6814  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6815  static void io_poll_cancel_req(struct io_kiocb *req)
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6816  {
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6817  	io_poll_mark_cancelled(req);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6818  	/* kick tw, which should complete the request */
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6819  	io_poll_execute(req, 0, 0);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6820  }
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6821  
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6822  #define wqe_to_req(wait)	((void *)((unsigned long) (wait)->private & ~1))
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6823  #define wqe_is_double(wait)	((unsigned long) (wait)->private & 1)
a294bef57c55a4 fs/io_uring.c Christoph Hellwig 2022-05-18  6824  #define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6825  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6826  static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6827  			void *key)
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6828  {
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6829  	struct io_kiocb *req = wqe_to_req(wait);
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6830  	struct io_poll_iocb *poll = container_of(wait, struct io_poll_iocb,
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6831  						 wait);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6832  	__poll_t mask = key_to_poll(key);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6833  
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6834  	if (unlikely(mask & POLLFREE)) {
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6835  		io_poll_mark_cancelled(req);
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6836  		/* we have to kick tw in case it's not already */
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16  6837  		io_poll_execute(req, 0, poll->events);
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6838  
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6839  		/*
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6840  		 * If the waitqueue is being freed early but someone is already
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6841  		 * holds ownership over it, we have to tear down the request as
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6842  		 * best we can. That means immediately removing the request from
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6843  		 * its waitqueue and preventing all further accesses to the
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6844  		 * waitqueue via the request.
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6845  		 */
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6846  		list_del_init(&poll->wait.entry);
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6847  
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6848  		/*
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6849  		 * Careful: this *must* be the last step, since as soon
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6850  		 * as req->head is NULL'ed out, the request can be
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6851  		 * completed and freed, since aio_poll_complete_work()
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6852  		 * will no longer need to take the waitqueue lock.
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6853  		 */
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6854  		smp_store_release(&poll->head, NULL);
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6855  		return 1;
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6856  	}
791f3465c4afde fs/io_uring.c Pavel Begunkov    2022-01-14  6857  
aa43477b040251 fs/io_uring.c Pavel Begunkov    2021-12-15  6858  	/* for instances that support it check for an event match first */
1b1d7b4bf1d994 fs/io_uring.c Dylan Yudaken     2022-05-12  6859  	if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6860  		return 0;
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6861  
eb0089d629ba41 fs/io_uring.c Pavel Begunkov    2021-12-15  6862  	if (io_poll_get_ownership(req)) {
eb0089d629ba41 fs/io_uring.c Pavel Begunkov    2021-12-15  6863  		/* optional, saves extra locking for removal in tw handler */
eb0089d629ba41 fs/io_uring.c Pavel Begunkov    2021-12-15  6864  		if (mask && poll->events & EPOLLONESHOT) {
807abcb0883439 fs/io_uring.c Jens Axboe        2020-07-17  6865  			list_del_init(&poll->wait.entry);
eb0089d629ba41 fs/io_uring.c Pavel Begunkov    2021-12-15  6866  			poll->head = NULL;
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6867  			if (wqe_is_double(wait))
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6868  				req->flags &= ~REQ_F_DOUBLE_POLL;
d89a4fac0fbc6f fs/io_uring.c Jens Axboe        2022-03-22  6869  			else
91eac1c69c202d fs/io_uring.c Jens Axboe        2022-03-16  6870  				req->flags &= ~REQ_F_SINGLE_POLL;
c8b5e2600a2cfa fs/io_uring.c Jens Axboe        2020-10-25  6871  		}
81459350d581e9 fs/io_uring.c Jens Axboe        2022-03-16 @6872  		__io_poll_execute(req, mask, poll->events);
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6873  	}
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6874  	return 1;
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6875  }
18bceab101adde fs/io_uring.c Jens Axboe        2020-05-15  6876  

:::::: The code at line 6701 was first introduced by commit
:::::: cef216fc32d7628206c523994e7e267e7a8dda59 io_uring: explicitly keep a CQE in io_kiocb

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
