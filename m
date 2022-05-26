Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0666A5351EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348127AbiEZQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:17:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B376C0E5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653581835; x=1685117835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VUhlbdgQERzdoVgjDiurZ3gmQ5MmD/xs3vH9xlbpmKQ=;
  b=SgVr2JZpqlRED59Lh/vesFRMseT4EXLXm1iwjxBKm7CMF53oyNyvIT/s
   hT0/1cZBdcWZc4I/cf8BmrbHp8pm3BABEqMmslge7L9ktHNnscKcE2iZJ
   lxwLltY4eoz6TOv4m68UTb+8M5UQxHe/+RkdzKnVXD6hFcFiB4qDtxT/g
   Pk1J5Fe/W6jOCrBqcgCep/zB2fcRSITc4GbKBRy5DSYfSN1Fm2mOc6qXJ
   A1OCdIQT2XqmI/xTb8V1ZPhHyXyagHH6aVvYi1clLw1UdgVb9ukTcGFJj
   K5Dqv0EHW2KpbS8700dYPPDx8FVCyJX9Rhj3n8JdJKrtNSizsfyyegM7m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256271853"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256271853"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="527490179"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2022 09:17:14 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuGAj-00040M-Cc;
        Thu, 26 May 2022 16:17:13 +0000
Date:   Fri, 27 May 2022 00:17:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.20/io_uring 54/55] io_uring/poll.c:168:38:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202205270016.p6f8TmQi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring
head:   030e5a1b325edbe3b173db29156613f9eddd44e6
commit: 55bc1c3e59e8972f62d95a771a8e2f35e5c8989d [54/55] io_uring: move poll handling into its own file
config: openrisc-randconfig-s032-20220524 (https://download.01.org/0day-ci/archive/20220527/202205270016.p6f8TmQi-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=55bc1c3e59e8972f62d95a771a8e2f35e5c8989d
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.20/io_uring
        git checkout 55bc1c3e59e8972f62d95a771a8e2f35e5c8989d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> io_uring/poll.c:168:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/poll.c:168:38: sparse:     expected signed int [usertype] res
   io_uring/poll.c:168:38: sparse:     got restricted __poll_t
>> io_uring/poll.c:179:56: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:178:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:178:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:178:66: sparse:     got unsigned int
>> io_uring/poll.c:178:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/poll.c:178:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:178:52: sparse:     got unsigned short
>> io_uring/poll.c:184:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:184:50: sparse:     expected signed int [usertype] res
   io_uring/poll.c:184:50: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:219:63: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:219:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:219:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:219:57: sparse:     got unsigned int
>> io_uring/poll.c:337:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:337:40: sparse:     expected int mask
   io_uring/poll.c:337:40: sparse:     got restricted __poll_t [usertype] mask
>> io_uring/poll.c:430:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:430:24: sparse:     expected int
   io_uring/poll.c:430:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:447:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:447:40: sparse:     expected int mask
   io_uring/poll.c:447:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:476:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   io_uring/poll.c:476:33: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:476:33: sparse:     got int
   io_uring/poll.c:523:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:523:33: sparse:     expected int mask
   io_uring/poll.c:523:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:523:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/poll.c:523:50: sparse:     expected int events
   io_uring/poll.c:523:50: sparse:     got restricted __poll_t [usertype] events
>> io_uring/poll.c:637:24: sparse: sparse: invalid assignment: |=
>> io_uring/poll.c:637:24: sparse:    left side has type unsigned int
>> io_uring/poll.c:637:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:638:65: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:638:29: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:638:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/poll.c:638:38: sparse:     expected restricted __poll_t
   io_uring/poll.c:638:38: sparse:     got unsigned int
   io_uring/poll.c:733:38: sparse: sparse: invalid assignment: &=
>> io_uring/poll.c:733:38: sparse:    left side has type restricted __poll_t
>> io_uring/poll.c:733:38: sparse:    right side has type int
   io_uring/poll.c:734:52: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:734:38: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:734:38: sparse:    left side has type restricted __poll_t
>> io_uring/poll.c:734:38: sparse:    right side has type unsigned int
   io_uring/poll.c: note: in included file:
   io_uring/io_uring_types.h:90:37: sparse: sparse: array of flexible structures

vim +168 io_uring/poll.c

   135	
   136	/*
   137	 * All poll tw should go through this. Checks for poll events, manages
   138	 * references, does rewait, etc.
   139	 *
   140	 * Returns a negative error on failure. >0 when no action require, which is
   141	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
   142	 * the request, then the mask is stored in req->cqe.res.
   143	 */
   144	static int io_poll_check_events(struct io_kiocb *req, bool *locked)
   145	{
   146		struct io_ring_ctx *ctx = req->ctx;
   147		int v, ret;
   148	
   149		/* req->task == current here, checking PF_EXITING is safe */
   150		if (unlikely(req->task->flags & PF_EXITING))
   151			return -ECANCELED;
   152	
   153		do {
   154			v = atomic_read(&req->poll_refs);
   155	
   156			/* tw handler should be the owner, and so have some references */
   157			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
   158				return 0;
   159			if (v & IO_POLL_CANCEL_FLAG)
   160				return -ECANCELED;
   161	
   162			if (!req->cqe.res) {
   163				struct poll_table_struct pt = { ._key = req->apoll_events };
   164				unsigned flags = locked ? 0 : IO_URING_F_UNLOCKED;
   165	
   166				if (unlikely(!io_assign_file(req, flags)))
   167					return -EBADF;
 > 168				req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
   169			}
   170	
   171			if ((unlikely(!req->cqe.res)))
   172				continue;
   173			if (req->apoll_events & EPOLLONESHOT)
   174				return 0;
   175	
   176			/* multishot, just fill a CQE and proceed */
   177			if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
 > 178				__poll_t mask = mangle_poll(req->cqe.res &
 > 179							    req->apoll_events);
   180				bool filled;
   181	
   182				spin_lock(&ctx->completion_lock);
   183				filled = io_fill_cqe_aux(ctx, req->cqe.user_data,
 > 184							 mask, IORING_CQE_F_MORE);
   185				io_commit_cqring(ctx);
   186				spin_unlock(&ctx->completion_lock);
   187				if (filled) {
   188					io_cqring_ev_posted(ctx);
   189					continue;
   190				}
   191				return -ECANCELED;
   192			}
   193	
   194			ret = io_poll_issue(req, locked);
   195			if (ret)
   196				return ret;
   197	
   198			/*
   199			 * Release all references, retry if someone tried to restart
   200			 * task_work while we were executing it.
   201			 */
   202		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
   203	
   204		return 1;
   205	}
   206	
   207	static void io_poll_task_func(struct io_kiocb *req, bool *locked)
   208	{
   209		struct io_ring_ctx *ctx = req->ctx;
   210		int ret;
   211	
   212		ret = io_poll_check_events(req, locked);
   213		if (ret > 0)
   214			return;
   215	
   216		if (!ret) {
   217			struct io_poll *poll = io_kiocb_to_cmd(req);
   218	
   219			req->cqe.res = mangle_poll(req->cqe.res & poll->events);
   220		} else {
   221			req->cqe.res = ret;
   222			req_set_fail(req);
   223		}
   224	
   225		io_poll_remove_entries(req);
   226		spin_lock(&ctx->completion_lock);
   227		hash_del(&req->hash_node);
   228		req->cqe.flags = 0;
   229		__io_req_complete_post(req);
   230		io_commit_cqring(ctx);
   231		spin_unlock(&ctx->completion_lock);
   232		io_cqring_ev_posted(ctx);
   233	}
   234	
   235	static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
   236	{
   237		struct io_ring_ctx *ctx = req->ctx;
   238		int ret;
   239	
   240		ret = io_poll_check_events(req, locked);
   241		if (ret > 0)
   242			return;
   243	
   244		io_poll_remove_entries(req);
   245		spin_lock(&ctx->completion_lock);
   246		hash_del(&req->hash_node);
   247		spin_unlock(&ctx->completion_lock);
   248	
   249		if (!ret)
   250			io_req_task_submit(req, locked);
   251		else
   252			io_req_complete_failed(req, ret);
   253	}
   254	
   255	static void __io_poll_execute(struct io_kiocb *req, int mask, __poll_t events)
   256	{
   257		io_req_set_res(req, mask, 0);
   258		/*
   259		 * This is useful for poll that is armed on behalf of another
   260		 * request, and where the wakeup path could be on a different
   261		 * CPU. We want to avoid pulling in req->apoll->events for that
   262		 * case.
   263		 */
   264		req->apoll_events = events;
   265		if (req->opcode == IORING_OP_POLL_ADD)
   266			req->io_task_work.func = io_poll_task_func;
   267		else
   268			req->io_task_work.func = io_apoll_task_func;
   269	
   270		trace_io_uring_task_add(req->ctx, req, req->cqe.user_data, req->opcode, mask);
   271		io_req_task_work_add(req);
   272	}
   273	
   274	static inline void io_poll_execute(struct io_kiocb *req, int res,
   275			__poll_t events)
   276	{
   277		if (io_poll_get_ownership(req))
   278			__io_poll_execute(req, res, events);
   279	}
   280	
   281	static void io_poll_cancel_req(struct io_kiocb *req)
   282	{
   283		io_poll_mark_cancelled(req);
   284		/* kick tw, which should complete the request */
   285		io_poll_execute(req, 0, 0);
   286	}
   287	
   288	#define wqe_to_req(wait)	((void *)((unsigned long) (wait)->private & ~1))
   289	#define wqe_is_double(wait)	((unsigned long) (wait)->private & 1)
   290	#define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
   291	
   292	static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
   293				void *key)
   294	{
   295		struct io_kiocb *req = wqe_to_req(wait);
   296		struct io_poll *poll = container_of(wait, struct io_poll, wait);
   297		__poll_t mask = key_to_poll(key);
   298	
   299		if (unlikely(mask & POLLFREE)) {
   300			io_poll_mark_cancelled(req);
   301			/* we have to kick tw in case it's not already */
   302			io_poll_execute(req, 0, poll->events);
   303	
   304			/*
   305			 * If the waitqueue is being freed early but someone is already
   306			 * holds ownership over it, we have to tear down the request as
   307			 * best we can. That means immediately removing the request from
   308			 * its waitqueue and preventing all further accesses to the
   309			 * waitqueue via the request.
   310			 */
   311			list_del_init(&poll->wait.entry);
   312	
   313			/*
   314			 * Careful: this *must* be the last step, since as soon
   315			 * as req->head is NULL'ed out, the request can be
   316			 * completed and freed, since aio_poll_complete_work()
   317			 * will no longer need to take the waitqueue lock.
   318			 */
   319			smp_store_release(&poll->head, NULL);
   320			return 1;
   321		}
   322	
   323		/* for instances that support it check for an event match first */
   324		if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
   325			return 0;
   326	
   327		if (io_poll_get_ownership(req)) {
   328			/* optional, saves extra locking for removal in tw handler */
   329			if (mask && poll->events & EPOLLONESHOT) {
   330				list_del_init(&poll->wait.entry);
   331				poll->head = NULL;
   332				if (wqe_is_double(wait))
   333					req->flags &= ~REQ_F_DOUBLE_POLL;
   334				else
   335					req->flags &= ~REQ_F_SINGLE_POLL;
   336			}
 > 337			__io_poll_execute(req, mask, poll->events);
   338		}
   339		return 1;
   340	}
   341	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
