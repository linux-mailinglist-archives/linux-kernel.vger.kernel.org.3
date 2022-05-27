Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B52536903
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355021AbiE0Wtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346068AbiE0Wtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:49:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2711AFEF
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653691779; x=1685227779;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nnvsQR+sPloRmqdZUT2J4BHukHAOtYxJ08rJZcsysEI=;
  b=QMyFYwBSZNU6fD93oCM007J6YPeBU4X23pyzJ3Pt6PVpCpIAJCTit542
   laM7utNAW3BrWqIQ8IhNIaetQi1SFXfQoAI06a/ePi5GJq4Pk1NSWtoOJ
   B+cxrj7etMIGOiXcUb7ewNt2/FPFVWksBGwxvYd9KKYY/lv2r/yVFxA11
   L9AQr3qWggqdMAEr/2IUgCy1Iv/GtFBtEkLLeZdwaoyThJlNXy/IhXgr5
   HEfcnrD8kYUfYITNB9XsS1vggtim3rVckWsVfV6argHT/+N69/YM/FZ/H
   YrRXAInQWzBZ35VoiQK3b6Az5858oeMrHAz3j93ImbNAVws5ERHgKILzV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274319032"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274319032"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 15:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="610551792"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2022 15:49:37 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuim0-0005CG-Ct;
        Fri, 27 May 2022 22:49:36 +0000
Date:   Sat, 28 May 2022 06:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Xu <howeyxu@tencent.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: fs/io_uring.c:6361:33: sparse: sparse: incorrect type in initializer
 (different base types)
Message-ID: <202205280650.UIaqqALt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8291eaafed36f575f23951f3ce18407f480e9ecf
commit: dbc2564cfe0faff439dc46adb8c009589054ea46 io_uring: let fast poll support multishot
date:   13 days ago
config: arc-randconfig-s031-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280650.UIaqqALt-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dbc2564cfe0faff439dc46adb8c009589054ea46
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dbc2564cfe0faff439dc46adb8c009589054ea46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c:3305:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __kernel_rwf_t @@
   fs/io_uring.c:3305:23: sparse:     expected unsigned int [usertype] flags
   fs/io_uring.c:3305:23: sparse:     got restricted __kernel_rwf_t
   fs/io_uring.c:3472:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   fs/io_uring.c:3472:31: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3472:31: sparse:     got void *
   fs/io_uring.c:3496:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   fs/io_uring.c:3496:31: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3496:31: sparse:     got void *
   fs/io_uring.c:3890:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __kernel_rwf_t [usertype] flags @@     got unsigned int [usertype] flags @@
   fs/io_uring.c:3890:48: sparse:     expected restricted __kernel_rwf_t [usertype] flags
   fs/io_uring.c:3890:48: sparse:     got unsigned int [usertype] flags
   fs/io_uring.c:5251:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5251:14: sparse:     expected struct file *file
   fs/io_uring.c:5251:14: sparse:     got struct file [noderef] __rcu *
   fs/io_uring.c:6042:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got int apoll_events @@
   fs/io_uring.c:6042:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:6042:68: sparse:     got int apoll_events
   fs/io_uring.c:6047:48: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6052:41: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6057:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got int @@
   fs/io_uring.c:6057:66: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6057:66: sparse:     got int
   fs/io_uring.c:6057:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:6057:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6057:52: sparse:     got unsigned short
   fs/io_uring.c:6063:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6063:50: sparse:     expected signed int [usertype] res
   fs/io_uring.c:6063:50: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6100:68: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6100:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6100:57: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6100:57: sparse:     got unsigned int
   fs/io_uring.c:6182:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6182:45: sparse:     expected int events
   fs/io_uring.c:6182:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6204:47: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6204:35: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6204:23: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6217:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6217:40: sparse:     expected int mask
   fs/io_uring.c:6217:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6217:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6217:50: sparse:     expected int events
   fs/io_uring.c:6217:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6309:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6309:24: sparse:     expected int
   fs/io_uring.c:6309:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6326:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6326:40: sparse:     expected int mask
   fs/io_uring.c:6326:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6326:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6326:50: sparse:     expected int events
   fs/io_uring.c:6326:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6336:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6336:47: sparse:     expected int events
   fs/io_uring.c:6336:47: sparse:     got restricted __poll_t [usertype] events
>> fs/io_uring.c:6361:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   fs/io_uring.c:6361:33: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6361:33: sparse:     got int
   fs/io_uring.c:6374:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6374:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6374:22: sparse:    right side has type int
   fs/io_uring.c:6379:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6379:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6379:30: sparse:    right side has type int
   fs/io_uring.c:6381:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6381:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6381:22: sparse:    right side has type int
   fs/io_uring.c:6409:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6409:33: sparse:     expected int mask
   fs/io_uring.c:6409:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6409:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6409:50: sparse:     expected int events
   fs/io_uring.c:6409:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6523:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6523:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6523:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6524:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6524:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6524:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6524:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6524:38: sparse:     got unsigned int
   fs/io_uring.c:6572:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int apoll_events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6572:27: sparse:     expected int apoll_events
   fs/io_uring.c:6572:27: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6611:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6611:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6611:43: sparse:    right side has type int
   fs/io_uring.c:6612:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6612:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6612:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6612:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2561:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:7676:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7676:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7676:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7676:39: sparse: sparse: marked inline, but without a definition

vim +6361 fs/io_uring.c

  6281	
  6282	static int __io_arm_poll_handler(struct io_kiocb *req,
  6283					 struct io_poll_iocb *poll,
  6284					 struct io_poll_table *ipt, __poll_t mask)
  6285	{
  6286		struct io_ring_ctx *ctx = req->ctx;
  6287		int v;
  6288	
  6289		INIT_HLIST_NODE(&req->hash_node);
  6290		req->work.cancel_seq = atomic_read(&ctx->cancel_seq);
  6291		io_init_poll_iocb(poll, mask, io_poll_wake);
  6292		poll->file = req->file;
  6293	
  6294		ipt->pt._key = mask;
  6295		ipt->req = req;
  6296		ipt->error = 0;
  6297		ipt->nr_entries = 0;
  6298	
  6299		/*
  6300		 * Take the ownership to delay any tw execution up until we're done
  6301		 * with poll arming. see io_poll_get_ownership().
  6302		 */
  6303		atomic_set(&req->poll_refs, 1);
  6304		mask = vfs_poll(req->file, &ipt->pt) & poll->events;
  6305	
  6306		if (mask && (poll->events & EPOLLONESHOT)) {
  6307			io_poll_remove_entries(req);
  6308			/* no one else has access to the req, forget about the ref */
  6309			return mask;
  6310		}
  6311		if (!mask && unlikely(ipt->error || !ipt->nr_entries)) {
  6312			io_poll_remove_entries(req);
  6313			if (!ipt->error)
  6314				ipt->error = -EINVAL;
  6315			return 0;
  6316		}
  6317	
  6318		spin_lock(&ctx->completion_lock);
  6319		io_poll_req_insert(req);
  6320		spin_unlock(&ctx->completion_lock);
  6321	
  6322		if (mask) {
  6323			/* can't multishot if failed, just queue the event we've got */
  6324			if (unlikely(ipt->error || !ipt->nr_entries))
  6325				poll->events |= EPOLLONESHOT;
> 6326			__io_poll_execute(req, mask, poll->events);
  6327			return 0;
  6328		}
  6329	
  6330		/*
  6331		 * Release ownership. If someone tried to queue a tw while it was
  6332		 * locked, kick it off for them.
  6333		 */
  6334		v = atomic_dec_return(&req->poll_refs);
  6335		if (unlikely(v & IO_POLL_REF_MASK))
  6336			__io_poll_execute(req, 0, poll->events);
  6337		return 0;
  6338	}
  6339	
  6340	static void io_async_queue_proc(struct file *file, struct wait_queue_head *head,
  6341				       struct poll_table_struct *p)
  6342	{
  6343		struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
  6344		struct async_poll *apoll = pt->req->apoll;
  6345	
  6346		__io_queue_proc(&apoll->poll, pt, head, &apoll->double_poll);
  6347	}
  6348	
  6349	enum {
  6350		IO_APOLL_OK,
  6351		IO_APOLL_ABORTED,
  6352		IO_APOLL_READY
  6353	};
  6354	
  6355	static int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
  6356	{
  6357		const struct io_op_def *def = &io_op_defs[req->opcode];
  6358		struct io_ring_ctx *ctx = req->ctx;
  6359		struct async_poll *apoll;
  6360		struct io_poll_table ipt;
> 6361		__poll_t mask = POLLPRI | POLLERR;
  6362		int ret;
  6363	
  6364		if (!def->pollin && !def->pollout)
  6365			return IO_APOLL_ABORTED;
  6366		if (!file_can_poll(req->file))
  6367			return IO_APOLL_ABORTED;
  6368		if ((req->flags & (REQ_F_POLLED|REQ_F_PARTIAL_IO)) == REQ_F_POLLED)
  6369			return IO_APOLL_ABORTED;
  6370		if (!(req->flags & REQ_F_APOLL_MULTISHOT))
  6371			mask |= EPOLLONESHOT;
  6372	
  6373		if (def->pollin) {
  6374			mask |= POLLIN | POLLRDNORM;
  6375	
  6376			/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
  6377			if ((req->opcode == IORING_OP_RECVMSG) &&
  6378			    (req->sr_msg.msg_flags & MSG_ERRQUEUE))
  6379				mask &= ~POLLIN;
  6380		} else {
  6381			mask |= POLLOUT | POLLWRNORM;
  6382		}
  6383		if (def->poll_exclusive)
  6384			mask |= EPOLLEXCLUSIVE;
  6385		if (req->flags & REQ_F_POLLED) {
  6386			apoll = req->apoll;
  6387		} else if (!(issue_flags & IO_URING_F_UNLOCKED) &&
  6388			   !list_empty(&ctx->apoll_cache)) {
  6389			apoll = list_first_entry(&ctx->apoll_cache, struct async_poll,
  6390							poll.wait.entry);
  6391			list_del_init(&apoll->poll.wait.entry);
  6392		} else {
  6393			apoll = kmalloc(sizeof(*apoll), GFP_ATOMIC);
  6394			if (unlikely(!apoll))
  6395				return IO_APOLL_ABORTED;
  6396		}
  6397		apoll->double_poll = NULL;
  6398		req->apoll = apoll;
  6399		req->flags |= REQ_F_POLLED;
  6400		ipt.pt._qproc = io_async_queue_proc;
  6401	
  6402		io_kbuf_recycle(req, issue_flags);
  6403	
  6404		ret = __io_arm_poll_handler(req, &apoll->poll, &ipt, mask);
  6405		if (ret || ipt.error)
  6406			return ret ? IO_APOLL_READY : IO_APOLL_ABORTED;
  6407	
  6408		trace_io_uring_poll_arm(ctx, req, req->cqe.user_data, req->opcode,
  6409					mask, apoll->poll.events);
  6410		return IO_APOLL_OK;
  6411	}
  6412	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
