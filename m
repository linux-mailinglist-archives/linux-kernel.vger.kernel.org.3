Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6744DC90D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiCQOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCQOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:42:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E314F133
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647528050; x=1679064050;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wzSb18wq01PewNWJnO5lZ/G+LCe8Hrt4xI84kYl9YmY=;
  b=Q4yFrWR/C9rgxjYubnAkeGO6oDxIbAPKe1DJmA6zR2JJ/nJUaUigi1k2
   d9CrD52uDN1GK8gen8F54dzaUbnT4d9hR/o/mm2Fp/4lQHdGQ9rIIs8Pn
   5dvl5BWvtNdc6MgMiP6Eyd8I+sYl27xG7Rv+fGB9kW9Mn1RdaZsTHGDU4
   VqoAmOLAGnsZnZrhrsQvZaQJ1cDxFr6fyLxLNXBgTuXNpmI1fi54RZlC4
   jGI6P1sHBbAZqK73/lUmeDcB7dHJoF3NpMGX0sqFF2ByT6Fvs3eSMRwFg
   j+XaMgx6MCudjnoJyunTO+mJ6aIPrOGTQPfVbex6/Jlbx7tLvSnGe8svo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256608541"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256608541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516783991"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 07:40:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUrJ1-000DlP-Rj; Thu, 17 Mar 2022 14:40:47 +0000
Date:   Thu, 17 Mar 2022 22:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.18/io_uring 30/39]
 fs/io_uring.c:5879:68: sparse: sparse: incorrect type in initializer
 (different base types)
Message-ID: <202203172252.S8ZtTgQG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.18/io_uring
head:   9aa8dfde4869ccdec0a7290b686dbc10e079e163
commit: 81459350d581e958ee9c6e76031f77333881c23c [30/39] io_uring: cache req->apoll->events in req->cflags
config: alpha-randconfig-s031-20220317 (https://download.01.org/0day-ci/archive/20220317/202203172252.S8ZtTgQG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/81459350d581e958ee9c6e76031f77333881c23c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.18/io_uring
        git checkout 81459350d581e958ee9c6e76031f77333881c23c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c:3389:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got struct io_buffer *[assigned] kbuf @@
   fs/io_uring.c:3389:24: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3389:24: sparse:     got struct io_buffer *[assigned] kbuf
   fs/io_uring.c:5041:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5041:14: sparse:     expected struct file *file
   fs/io_uring.c:5041:14: sparse:     got struct file [noderef] __rcu *
>> fs/io_uring.c:5879:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got unsigned int [usertype] cflags @@
   fs/io_uring.c:5879:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:5879:68: sparse:     got unsigned int [usertype] cflags
   fs/io_uring.c:5881:47: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5885:52: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5886:71: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5886:65: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5886:65: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5886:65: sparse:     got unsigned int
   fs/io_uring.c:5886:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:5886:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:5886:52: sparse:     got unsigned short
   fs/io_uring.c:5890:71: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:5890:71: sparse:     expected signed int [usertype] res
   fs/io_uring.c:5890:71: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:5921:66: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5921:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5921:55: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5921:55: sparse:     got unsigned int
   fs/io_uring.c:5999:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:5999:45: sparse:     expected int events
   fs/io_uring.c:5999:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6030:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6030:40: sparse:     expected int mask
   fs/io_uring.c:6030:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6030:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6030:50: sparse:     expected int events
   fs/io_uring.c:6030:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6117:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6117:24: sparse:     expected int
   fs/io_uring.c:6117:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6134:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6134:40: sparse:     expected int mask
   fs/io_uring.c:6134:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6134:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6134:50: sparse:     expected int events
   fs/io_uring.c:6134:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6145:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6145:47: sparse:     expected int events
   fs/io_uring.c:6145:47: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6170:25: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6170:48: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   fs/io_uring.c:6170:48: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6170:48: sparse:     got unsigned int
   fs/io_uring.c:6179:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6179:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6179:22: sparse:    right side has type int
   fs/io_uring.c:6184:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6184:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6184:30: sparse:    right side has type int
   fs/io_uring.c:6186:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6186:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6186:22: sparse:    right side has type int
   fs/io_uring.c:6209:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6209:33: sparse:     expected int mask
   fs/io_uring.c:6209:33: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6209:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6209:50: sparse:     expected int events
   fs/io_uring.c:6209:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6290:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6290:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6290:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6291:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6291:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6291:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6291:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6291:38: sparse:     got unsigned int
>> fs/io_uring.c:6343:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cflags @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6343:21: sparse:     expected unsigned int [usertype] cflags
   fs/io_uring.c:6343:21: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6381:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6381:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6381:43: sparse:    right side has type int
   fs/io_uring.c:6382:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6382:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6382:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6382:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2406:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:8569:9: sparse: sparse: context imbalance in 'io_sq_thread_unpark' - wrong count at exit
   fs/io_uring.c:8580:9: sparse: sparse: context imbalance in 'io_sq_thread_park' - wrong count at exit

vim +5879 fs/io_uring.c

  5850	
  5851	/*
  5852	 * All poll tw should go through this. Checks for poll events, manages
  5853	 * references, does rewait, etc.
  5854	 *
  5855	 * Returns a negative error on failure. >0 when no action require, which is
  5856	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
  5857	 * the request, then the mask is stored in req->result.
  5858	 */
  5859	static int io_poll_check_events(struct io_kiocb *req)
  5860	{
  5861		struct io_ring_ctx *ctx = req->ctx;
  5862		struct io_poll_iocb *poll = io_poll_get_single(req);
  5863		int v;
  5864	
  5865		/* req->task == current here, checking PF_EXITING is safe */
  5866		if (unlikely(req->task->flags & PF_EXITING))
  5867			io_poll_mark_cancelled(req);
  5868	
  5869		do {
  5870			v = atomic_read(&req->poll_refs);
  5871	
  5872			/* tw handler should be the owner, and so have some references */
  5873			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
  5874				return 0;
  5875			if (v & IO_POLL_CANCEL_FLAG)
  5876				return -ECANCELED;
  5877	
  5878			if (!req->result) {
> 5879				struct poll_table_struct pt = { ._key = req->cflags };
  5880	
  5881				req->result = vfs_poll(req->file, &pt) & req->cflags;
  5882			}
  5883	
  5884			/* multishot, just fill an CQE and proceed */
  5885			if (req->result && !(req->cflags & EPOLLONESHOT)) {
  5886				__poll_t mask = mangle_poll(req->result & poll->events);
  5887				bool filled;
  5888	
  5889				spin_lock(&ctx->completion_lock);
  5890				filled = io_fill_cqe_aux(ctx, req->user_data, mask,
  5891							 IORING_CQE_F_MORE);
  5892				io_commit_cqring(ctx);
  5893				spin_unlock(&ctx->completion_lock);
  5894				if (unlikely(!filled))
  5895					return -ECANCELED;
  5896				io_cqring_ev_posted(ctx);
  5897				io_add_napi(req->file, ctx);
  5898			} else if (req->result) {
  5899				return 0;
  5900			}
  5901	
  5902			/*
  5903			 * Release all references, retry if someone tried to restart
  5904			 * task_work while we were executing it.
  5905			 */
  5906		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
  5907	
  5908		return 1;
  5909	}
  5910	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
