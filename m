Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9A58B635
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiHFOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiHFOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:51:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1222B101C1
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659797461; x=1691333461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hsOHnu16BJDnr5KFOMUvBgeTDv0OyWA3t15hU4xg33Y=;
  b=iDURZ5mLLXA7ySofuCPisXx5U/4aS+n2KTfXmpyruqNGp7e0KOLXQ82M
   u7IlM/gVgeGNVmrU522qvRIX3I0IUO49g1pCYpeQHZqARS7BjpRBEHJ67
   ej2p7Byb17VRLWjHjHw1xXwAwuBH1RtiQVZYHBKk/pyODNCQdR6sxsIPt
   30lmahgFSoSpci5AYe8HHqbjNtDATIN+zzXJ9smUqF2eXn0SlqPPVDNGn
   hlAYsDgI0R2JTsYLIK5q8znzXhkGOeQDkPfjwLgVsdpkrF0eeIfS5WhPC
   gzNCrwcyaVT4b+FnmurYWJ/m8dSBvheXszfuYvSQX9h8ERbh3Po0Jb7fN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="289129834"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289129834"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 07:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746156160"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2022 07:50:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKL8k-000KSJ-2C;
        Sat, 06 Aug 2022 14:50:58 +0000
Date:   Sat, 6 Aug 2022 22:49:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: io_uring/poll.c:164:38: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202208062220.ncoAm5uo-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 329061d3e2f9a0082a097e9558bd5497098586c6 io_uring: move poll handling into its own file
date:   13 days ago
config: alpha-randconfig-s042-20220804 (https://download.01.org/0day-ci/archive/20220806/202208062220.ncoAm5uo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=329061d3e2f9a0082a097e9558bd5497098586c6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 329061d3e2f9a0082a097e9558bd5497098586c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> io_uring/poll.c:164:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/poll.c:164:38: sparse:     expected signed int [usertype] res
   io_uring/poll.c:164:38: sparse:     got restricted __poll_t
>> io_uring/poll.c:175:56: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:174:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:174:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:174:66: sparse:     got unsigned int
>> io_uring/poll.c:174:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/poll.c:174:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:174:52: sparse:     got unsigned short
>> io_uring/poll.c:180:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:180:50: sparse:     expected signed int [usertype] res
   io_uring/poll.c:180:50: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:215:63: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:215:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:215:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:215:57: sparse:     got unsigned int
>> io_uring/poll.c:333:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:333:40: sparse:     expected int mask
   io_uring/poll.c:333:40: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:428:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:428:24: sparse:     expected int
   io_uring/poll.c:428:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:448:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:448:40: sparse:     expected int mask
   io_uring/poll.c:448:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:477:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   io_uring/poll.c:477:33: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:477:33: sparse:     got int
   io_uring/poll.c:525:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:525:33: sparse:     expected int mask
   io_uring/poll.c:525:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:525:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/poll.c:525:50: sparse:     expected int events
   io_uring/poll.c:525:50: sparse:     got restricted __poll_t [usertype] events
>> io_uring/poll.c:639:24: sparse: sparse: invalid assignment: |=
>> io_uring/poll.c:639:24: sparse:    left side has type unsigned int
>> io_uring/poll.c:639:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:640:65: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:640:29: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:640:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/poll.c:640:38: sparse:     expected restricted __poll_t
   io_uring/poll.c:640:38: sparse:     got unsigned int
   io_uring/poll.c:735:38: sparse: sparse: invalid assignment: &=
>> io_uring/poll.c:735:38: sparse:    left side has type restricted __poll_t
>> io_uring/poll.c:735:38: sparse:    right side has type int
   io_uring/poll.c:736:52: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:736:38: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:736:38: sparse:    left side has type restricted __poll_t
>> io_uring/poll.c:736:38: sparse:    right side has type unsigned int
   io_uring/poll.c: note: in included file:
   io_uring/io_uring_types.h:90:37: sparse: sparse: array of flexible structures

vim +164 io_uring/poll.c

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
 > 164				req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
   165			}
   166	
   167			if ((unlikely(!req->cqe.res)))
   168				continue;
   169			if (req->apoll_events & EPOLLONESHOT)
   170				return 0;
   171	
   172			/* multishot, just fill a CQE and proceed */
   173			if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
 > 174				__poll_t mask = mangle_poll(req->cqe.res &
 > 175							    req->apoll_events);
   176				bool filled;
   177	
   178				spin_lock(&ctx->completion_lock);
   179				filled = io_fill_cqe_aux(ctx, req->cqe.user_data,
 > 180							 mask, IORING_CQE_F_MORE);
   181				io_commit_cqring(ctx);
   182				spin_unlock(&ctx->completion_lock);
   183				if (filled) {
   184					io_cqring_ev_posted(ctx);
   185					continue;
   186				}
   187				return -ECANCELED;
   188			}
   189	
   190			ret = io_poll_issue(req, locked);
   191			if (ret)
   192				return ret;
   193	
   194			/*
   195			 * Release all references, retry if someone tried to restart
   196			 * task_work while we were executing it.
   197			 */
   198		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
   199	
   200		return 1;
   201	}
   202	
   203	static void io_poll_task_func(struct io_kiocb *req, bool *locked)
   204	{
   205		struct io_ring_ctx *ctx = req->ctx;
   206		int ret;
   207	
   208		ret = io_poll_check_events(req, locked);
   209		if (ret > 0)
   210			return;
   211	
   212		if (!ret) {
   213			struct io_poll *poll = io_kiocb_to_cmd(req);
   214	
   215			req->cqe.res = mangle_poll(req->cqe.res & poll->events);
   216		} else {
   217			req->cqe.res = ret;
   218			req_set_fail(req);
   219		}
   220	
   221		io_poll_remove_entries(req);
   222		spin_lock(&ctx->completion_lock);
   223		hash_del(&req->hash_node);
   224		req->cqe.flags = 0;
   225		__io_req_complete_post(req);
   226		io_commit_cqring(ctx);
   227		spin_unlock(&ctx->completion_lock);
   228		io_cqring_ev_posted(ctx);
   229	}
   230	
   231	static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
   232	{
   233		struct io_ring_ctx *ctx = req->ctx;
   234		int ret;
   235	
   236		ret = io_poll_check_events(req, locked);
   237		if (ret > 0)
   238			return;
   239	
   240		io_poll_remove_entries(req);
   241		spin_lock(&ctx->completion_lock);
   242		hash_del(&req->hash_node);
   243		spin_unlock(&ctx->completion_lock);
   244	
   245		if (!ret)
   246			io_req_task_submit(req, locked);
   247		else
   248			io_req_complete_failed(req, ret);
   249	}
   250	
   251	static void __io_poll_execute(struct io_kiocb *req, int mask,
   252				      __poll_t __maybe_unused events)
   253	{
   254		io_req_set_res(req, mask, 0);
   255		/*
   256		 * This is useful for poll that is armed on behalf of another
   257		 * request, and where the wakeup path could be on a different
   258		 * CPU. We want to avoid pulling in req->apoll->events for that
   259		 * case.
   260		 */
   261		if (req->opcode == IORING_OP_POLL_ADD)
   262			req->io_task_work.func = io_poll_task_func;
   263		else
   264			req->io_task_work.func = io_apoll_task_func;
   265	
   266		trace_io_uring_task_add(req->ctx, req, req->cqe.user_data, req->opcode, mask);
   267		io_req_task_work_add(req);
   268	}
   269	
   270	static inline void io_poll_execute(struct io_kiocb *req, int res,
   271			__poll_t events)
   272	{
   273		if (io_poll_get_ownership(req))
   274			__io_poll_execute(req, res, events);
   275	}
   276	
   277	static void io_poll_cancel_req(struct io_kiocb *req)
   278	{
   279		io_poll_mark_cancelled(req);
   280		/* kick tw, which should complete the request */
   281		io_poll_execute(req, 0, 0);
   282	}
   283	
   284	#define wqe_to_req(wait)	((void *)((unsigned long) (wait)->private & ~1))
   285	#define wqe_is_double(wait)	((unsigned long) (wait)->private & 1)
   286	#define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
   287	
   288	static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
   289				void *key)
   290	{
   291		struct io_kiocb *req = wqe_to_req(wait);
   292		struct io_poll *poll = container_of(wait, struct io_poll, wait);
   293		__poll_t mask = key_to_poll(key);
   294	
   295		if (unlikely(mask & POLLFREE)) {
   296			io_poll_mark_cancelled(req);
   297			/* we have to kick tw in case it's not already */
   298			io_poll_execute(req, 0, poll->events);
   299	
   300			/*
   301			 * If the waitqueue is being freed early but someone is already
   302			 * holds ownership over it, we have to tear down the request as
   303			 * best we can. That means immediately removing the request from
   304			 * its waitqueue and preventing all further accesses to the
   305			 * waitqueue via the request.
   306			 */
   307			list_del_init(&poll->wait.entry);
   308	
   309			/*
   310			 * Careful: this *must* be the last step, since as soon
   311			 * as req->head is NULL'ed out, the request can be
   312			 * completed and freed, since aio_poll_complete_work()
   313			 * will no longer need to take the waitqueue lock.
   314			 */
   315			smp_store_release(&poll->head, NULL);
   316			return 1;
   317		}
   318	
   319		/* for instances that support it check for an event match first */
   320		if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
   321			return 0;
   322	
   323		if (io_poll_get_ownership(req)) {
   324			/* optional, saves extra locking for removal in tw handler */
   325			if (mask && poll->events & EPOLLONESHOT) {
   326				list_del_init(&poll->wait.entry);
   327				poll->head = NULL;
   328				if (wqe_is_double(wait))
   329					req->flags &= ~REQ_F_DOUBLE_POLL;
   330				else
   331					req->flags &= ~REQ_F_SINGLE_POLL;
   332			}
 > 333			__io_poll_execute(req, mask, poll->events);
   334		}
   335		return 1;
   336	}
   337	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
