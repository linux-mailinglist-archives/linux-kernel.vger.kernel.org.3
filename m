Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815BD480EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 03:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhL2CCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 21:02:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:44633 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232645AbhL2CCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 21:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640743355; x=1672279355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=910om+ApoeSHQ0F8ZPlhQvRww/xQ0KldHftQIRb1utw=;
  b=PSaZsf2sTnG1VQOxtSAUJ62TTQnIYyjl2LjOp5B3XLqTXjq6LLvElW+P
   JitzLjLSVt9VTT4P7dqCG8Kt/i5dmBoo5hTo754kA2O9rVPHHqVn2OCnD
   g44vUDM/QKYPxyXdbkLi/LMQvLAcFXmCVi3fEDJPaRP21doR9bOXV9znj
   XQD+WsgL00OTb8CCc1yfa03UMmhJcz8DEtKOp2DGAx8xZ4UY7Wz3x8esq
   RxPdkpo3sAPi3UZudzdBrWC/62EwBwhpUPyuVv3RCqkfD/ulmdyjyaUm0
   TaTaLK3xvLtL3aTBCSJRlu5LAD/Lb0ZEGWPAt8IX/bKhtnebU54g2ZRo6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="222118815"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="222118815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:02:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="572469036"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2021 18:02:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2OIS-0008HX-Rx; Wed, 29 Dec 2021 02:02:32 +0000
Date:   Wed, 29 Dec 2021 10:01:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [axboe-block:for-5.17/io_uring 26/28] fs/io_uring.c:5465:65: sparse:
 sparse: incorrect type in argument 1 (different base types)
Message-ID: <202112290923.rnV1s3NY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.17/io_uring
head:   cc8e9ba71a8626bd322d1945a8fc0c8a52131a63
commit: aa43477b040251f451db0d844073ac00a8ab66ee [26/28] io_uring: poll rework
config: alpha-randconfig-s032-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290923.rnV1s3NY-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=aa43477b040251f451db0d844073ac00a8ab66ee
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.17/io_uring
        git checkout aa43477b040251f451db0d844073ac00a8ab66ee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c:3196:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got struct io_buffer *[assigned] kbuf @@
   fs/io_uring.c:3196:24: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3196:24: sparse:     got struct io_buffer *[assigned] kbuf
   fs/io_uring.c:4740:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:4740:14: sparse:     expected struct file *file
   fs/io_uring.c:4740:14: sparse:     got struct file [noderef] __rcu *
   fs/io_uring.c:5460:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] result @@     got restricted __poll_t @@
   fs/io_uring.c:5460:37: sparse:     expected unsigned int [usertype] result
   fs/io_uring.c:5460:37: sparse:     got restricted __poll_t
   fs/io_uring.c:5465:71: sparse: sparse: restricted __poll_t degrades to integer
>> fs/io_uring.c:5465:65: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5465:65: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5465:65: sparse:     got unsigned int
>> fs/io_uring.c:5465:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:5465:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:5465:52: sparse:     got unsigned short
>> fs/io_uring.c:5469:71: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:5469:71: sparse:     expected signed int [usertype] res
   fs/io_uring.c:5469:71: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:5499:66: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5499:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5499:55: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5499:55: sparse:     got unsigned int
   fs/io_uring.c:5572:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:5572:40: sparse:     expected int mask
   fs/io_uring.c:5572:40: sparse:     got restricted __poll_t [usertype] mask
>> fs/io_uring.c:5658:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:5658:24: sparse:     expected int
   fs/io_uring.c:5658:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:5675:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:5675:40: sparse:     expected int mask
   fs/io_uring.c:5675:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:5710:25: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5710:48: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   fs/io_uring.c:5710:48: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:5710:48: sparse:     got unsigned int
   fs/io_uring.c:5719:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:5719:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:5719:22: sparse:    right side has type int
   fs/io_uring.c:5724:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:5724:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:5724:30: sparse:    right side has type int
   fs/io_uring.c:5726:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:5726:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:5726:22: sparse:    right side has type int
   fs/io_uring.c:5742:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:5742:33: sparse:     expected int mask
   fs/io_uring.c:5742:33: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:5742:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:5742:50: sparse:     expected int events
   fs/io_uring.c:5742:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:5823:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:5823:24: sparse:    left side has type unsigned int
   fs/io_uring.c:5823:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:5824:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5824:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5824:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:5824:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:5824:38: sparse:     got unsigned int
   fs/io_uring.c:5913:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:5913:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:5913:43: sparse:    right side has type int
   fs/io_uring.c:5914:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5914:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:5914:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:5914:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2241:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:7945:9: sparse: sparse: context imbalance in 'io_sq_thread_unpark' - wrong count at exit
   fs/io_uring.c:7956:9: sparse: sparse: context imbalance in 'io_sq_thread_park' - wrong count at exit

vim +5465 fs/io_uring.c

  5429	
  5430	/*
  5431	 * All poll tw should go through this. Checks for poll events, manages
  5432	 * references, does rewait, etc.
  5433	 *
  5434	 * Returns a negative error on failure. >0 when no action require, which is
  5435	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
  5436	 * the request, then the mask is stored in req->result.
  5437	 */
  5438	static int io_poll_check_events(struct io_kiocb *req)
  5439	{
  5440		struct io_ring_ctx *ctx = req->ctx;
  5441		struct io_poll_iocb *poll = io_poll_get_single(req);
  5442		int v;
  5443	
  5444		/* req->task == current here, checking PF_EXITING is safe */
  5445		if (unlikely(req->task->flags & PF_EXITING))
  5446			io_poll_mark_cancelled(req);
  5447	
  5448		do {
  5449			v = atomic_read(&req->poll_refs);
  5450	
  5451			/* tw handler should be the owner, and so have some references */
  5452			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
  5453				return 0;
  5454			if (v & IO_POLL_CANCEL_FLAG)
  5455				return -ECANCELED;
  5456	
  5457			if (!req->result) {
  5458				struct poll_table_struct pt = { ._key = poll->events };
  5459	
  5460				req->result = vfs_poll(req->file, &pt) & poll->events;
  5461			}
  5462	
  5463			/* multishot, just fill an CQE and proceed */
  5464			if (req->result && !(poll->events & EPOLLONESHOT)) {
> 5465				__poll_t mask = mangle_poll(req->result & poll->events);
  5466				bool filled;
  5467	
  5468				spin_lock(&ctx->completion_lock);
> 5469				filled = io_fill_cqe_aux(ctx, req->user_data, mask,
  5470							 IORING_CQE_F_MORE);
  5471				io_commit_cqring(ctx);
  5472				spin_unlock(&ctx->completion_lock);
  5473				if (unlikely(!filled))
  5474					return -ECANCELED;
  5475				io_cqring_ev_posted(ctx);
  5476			} else if (req->result) {
  5477				return 0;
  5478			}
  5479	
  5480			/*
  5481			 * Release all references, retry if someone tried to restart
  5482			 * task_work while we were executing it.
  5483			 */
  5484		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
  5485	
  5486		return 1;
  5487	}
  5488	
  5489	static void io_poll_task_func(struct io_kiocb *req, bool *locked)
  5490	{
  5491		struct io_ring_ctx *ctx = req->ctx;
  5492		int ret;
  5493	
  5494		ret = io_poll_check_events(req);
  5495		if (ret > 0)
  5496			return;
  5497	
  5498		if (!ret) {
  5499			req->result = mangle_poll(req->result & req->poll.events);
  5500		} else {
  5501			req->result = ret;
  5502			req_set_fail(req);
  5503		}
  5504	
  5505		io_poll_remove_entries(req);
  5506		spin_lock(&ctx->completion_lock);
  5507		hash_del(&req->hash_node);
  5508		__io_req_complete_post(req, req->result, 0);
  5509		io_commit_cqring(ctx);
  5510		spin_unlock(&ctx->completion_lock);
  5511		io_cqring_ev_posted(ctx);
  5512	}
  5513	
  5514	static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
  5515	{
  5516		struct io_ring_ctx *ctx = req->ctx;
  5517		int ret;
  5518	
  5519		ret = io_poll_check_events(req);
  5520		if (ret > 0)
  5521			return;
  5522	
  5523		io_poll_remove_entries(req);
  5524		spin_lock(&ctx->completion_lock);
  5525		hash_del(&req->hash_node);
  5526		spin_unlock(&ctx->completion_lock);
  5527	
  5528		if (!ret)
  5529			io_req_task_submit(req, locked);
  5530		else
  5531			io_req_complete_failed(req, ret);
  5532	}
  5533	
  5534	static void __io_poll_execute(struct io_kiocb *req, int mask)
  5535	{
  5536		req->result = mask;
  5537		if (req->opcode == IORING_OP_POLL_ADD)
  5538			req->io_task_work.func = io_poll_task_func;
  5539		else
  5540			req->io_task_work.func = io_apoll_task_func;
  5541	
  5542		trace_io_uring_task_add(req->ctx, req->opcode, req->user_data, mask);
  5543		io_req_task_work_add(req, false);
  5544	}
  5545	
  5546	static inline void io_poll_execute(struct io_kiocb *req, int res)
  5547	{
  5548		if (io_poll_get_ownership(req))
  5549			__io_poll_execute(req, res);
  5550	}
  5551	
  5552	static void io_poll_cancel_req(struct io_kiocb *req)
  5553	{
  5554		io_poll_mark_cancelled(req);
  5555		/* kick tw, which should complete the request */
  5556		io_poll_execute(req, 0);
  5557	}
  5558	
  5559	static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
  5560				void *key)
  5561	{
  5562		struct io_kiocb *req = wait->private;
  5563		struct io_poll_iocb *poll = container_of(wait, struct io_poll_iocb,
  5564							 wait);
  5565		__poll_t mask = key_to_poll(key);
  5566	
  5567		/* for instances that support it check for an event match first */
  5568		if (mask && !(mask & poll->events))
  5569			return 0;
  5570	
  5571		if (io_poll_get_ownership(req))
  5572			__io_poll_execute(req, mask);
  5573		return 1;
  5574	}
  5575	
  5576	static void __io_queue_proc(struct io_poll_iocb *poll, struct io_poll_table *pt,
  5577				    struct wait_queue_head *head,
  5578				    struct io_poll_iocb **poll_ptr)
  5579	{
  5580		struct io_kiocb *req = pt->req;
  5581	
  5582		/*
  5583		 * The file being polled uses multiple waitqueues for poll handling
  5584		 * (e.g. one for read, one for write). Setup a separate io_poll_iocb
  5585		 * if this happens.
  5586		 */
  5587		if (unlikely(pt->nr_entries)) {
  5588			struct io_poll_iocb *first = poll;
  5589	
  5590			/* double add on the same waitqueue head, ignore */
  5591			if (first->head == head)
  5592				return;
  5593			/* already have a 2nd entry, fail a third attempt */
  5594			if (*poll_ptr) {
  5595				if ((*poll_ptr)->head == head)
  5596					return;
  5597				pt->error = -EINVAL;
  5598				return;
  5599			}
  5600	
  5601			poll = kmalloc(sizeof(*poll), GFP_ATOMIC);
  5602			if (!poll) {
  5603				pt->error = -ENOMEM;
  5604				return;
  5605			}
  5606			io_init_poll_iocb(poll, first->events, first->wait.func);
  5607			*poll_ptr = poll;
  5608			if (req->opcode == IORING_OP_POLL_ADD)
  5609				req->flags |= REQ_F_ASYNC_DATA;
  5610		}
  5611	
  5612		pt->nr_entries++;
  5613		poll->head = head;
  5614		poll->wait.private = req;
  5615	
  5616		if (poll->events & EPOLLEXCLUSIVE)
  5617			add_wait_queue_exclusive(head, &poll->wait);
  5618		else
  5619			add_wait_queue(head, &poll->wait);
  5620	}
  5621	
  5622	static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
  5623				       struct poll_table_struct *p)
  5624	{
  5625		struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
  5626	
  5627		__io_queue_proc(&pt->req->poll, pt, head,
  5628				(struct io_poll_iocb **) &pt->req->async_data);
  5629	}
  5630	
  5631	static int __io_arm_poll_handler(struct io_kiocb *req,
  5632					 struct io_poll_iocb *poll,
  5633					 struct io_poll_table *ipt, __poll_t mask)
  5634	{
  5635		struct io_ring_ctx *ctx = req->ctx;
  5636		int v;
  5637	
  5638		INIT_HLIST_NODE(&req->hash_node);
  5639		io_init_poll_iocb(poll, mask, io_poll_wake);
  5640		poll->file = req->file;
  5641		poll->wait.private = req;
  5642	
  5643		ipt->pt._key = mask;
  5644		ipt->req = req;
  5645		ipt->error = 0;
  5646		ipt->nr_entries = 0;
  5647	
  5648		/*
  5649		 * Take the ownership to delay any tw execution up until we're done
  5650		 * with poll arming. see io_poll_get_ownership().
  5651		 */
  5652		atomic_set(&req->poll_refs, 1);
  5653		mask = vfs_poll(req->file, &ipt->pt) & poll->events;
  5654	
  5655		if (mask && (poll->events & EPOLLONESHOT)) {
  5656			io_poll_remove_entries(req);
  5657			/* no one else has access to the req, forget about the ref */
> 5658			return mask;
  5659		}
  5660		if (!mask && unlikely(ipt->error || !ipt->nr_entries)) {
  5661			io_poll_remove_entries(req);
  5662			if (!ipt->error)
  5663				ipt->error = -EINVAL;
  5664			return 0;
  5665		}
  5666	
  5667		spin_lock(&ctx->completion_lock);
  5668		io_poll_req_insert(req);
  5669		spin_unlock(&ctx->completion_lock);
  5670	
  5671		if (mask) {
  5672			/* can't multishot if failed, just queue the event we've got */
  5673			if (unlikely(ipt->error || !ipt->nr_entries))
  5674				poll->events |= EPOLLONESHOT;
  5675			__io_poll_execute(req, mask);
  5676			return 0;
  5677		}
  5678	
  5679		/*
  5680		 * Release ownership. If someone tried to queue a tw while it was
  5681		 * locked, kick it off for them.
  5682		 */
  5683		v = atomic_dec_return(&req->poll_refs);
  5684		if (unlikely(v & IO_POLL_REF_MASK))
  5685			__io_poll_execute(req, 0);
  5686		return 0;
  5687	}
  5688	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
