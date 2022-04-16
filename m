Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B445035F7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiDPKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:39:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE50ED3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650105421; x=1681641421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a44SeHyTH7VQMDklTi7QspECq6TJ8gl5vSd+S3ZVJcQ=;
  b=KL+ttWO3DqmWX9vnH/penE12OkY5z4AQi6JfUtNZWuH36hqoX1nD0K/p
   lAhH/jqGB6W/QYX28lWpp0lSgARlaUo3+A31/nwRojd9p7R9hJmD10i+B
   6KOa1OxoFIRP0KdEiWfnwhBnM7Lj0rj161EdIxe/GJXggAnKpnaenDJf/
   a4eCIiMkJXckgYsOLdgyNNFMhImFV98TfNm8lZpHMsCp+fo59W95LGAOX
   6w9Qv2rCFWNV834Xfd2Yxot97Klk6Uq8SwZljsEqxArP4/oVZE80bIMT/
   p+6qH0JJWymIAjnj43psC1O42yiP673YgedzPKU53JDRF3LuL/jeEz2Cc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263458936"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="263458936"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 03:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="613074683"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2022 03:37:00 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nffnX-000321-CV;
        Sat, 16 Apr 2022 10:36:59 +0000
Date:   Sat, 16 Apr 2022 18:35:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/io_uring.c:5856:68: sparse: sparse: incorrect type in initializer
 (different base types)
Message-ID: <202204161835.i9zZy7KL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
commit: 2804ecd8d3e3730b4f999cc1ff4b2441e1f4d513 io_uring: move apoll->events cache
date:   4 days ago
config: arm-randconfig-s031-20220414 (https://download.01.org/0day-ci/archive/20220416/202204161835.i9zZy7KL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2804ecd8d3e3730b4f999cc1ff4b2441e1f4d513
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2804ecd8d3e3730b4f999cc1ff4b2441e1f4d513
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/io_uring.h):
   include/trace/events/io_uring.h:488:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] op_flags @@     got restricted __kernel_rwf_t const [usertype] rw_flags @@
   include/trace/events/io_uring.h:488:1: sparse:     expected unsigned int [usertype] op_flags
   include/trace/events/io_uring.h:488:1: sparse:     got restricted __kernel_rwf_t const [usertype] rw_flags
   fs/io_uring.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, include/trace/events/io_uring.h):
   include/trace/events/io_uring.h:488:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] op_flags @@     got restricted __kernel_rwf_t const [usertype] rw_flags @@
   include/trace/events/io_uring.h:488:1: sparse:     expected unsigned int [usertype] op_flags
   include/trace/events/io_uring.h:488:1: sparse:     got restricted __kernel_rwf_t const [usertype] rw_flags
   fs/io_uring.c:3161:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __kernel_rwf_t @@
   fs/io_uring.c:3161:23: sparse:     expected unsigned int [usertype] flags
   fs/io_uring.c:3161:23: sparse:     got restricted __kernel_rwf_t
   fs/io_uring.c:3379:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got struct io_buffer *[assigned] kbuf @@
   fs/io_uring.c:3379:24: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3379:24: sparse:     got struct io_buffer *[assigned] kbuf
   fs/io_uring.c:3766:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __kernel_rwf_t [usertype] flags @@     got unsigned int [usertype] flags @@
   fs/io_uring.c:3766:48: sparse:     expected restricted __kernel_rwf_t [usertype] flags
   fs/io_uring.c:3766:48: sparse:     got unsigned int [usertype] flags
   fs/io_uring.c:5091:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5091:14: sparse:     expected struct file *file
   fs/io_uring.c:5091:14: sparse:     got struct file [noderef] __rcu *
>> fs/io_uring.c:5856:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got int apoll_events @@
   fs/io_uring.c:5856:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:5856:68: sparse:     got int apoll_events
   fs/io_uring.c:5861:55: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5865:58: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5866:65: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5866:65: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5866:65: sparse:     got unsigned int
   fs/io_uring.c:5866:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:5866:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:5866:52: sparse:     got unsigned short
   fs/io_uring.c:5870:71: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:5870:71: sparse:     expected signed int [usertype] res
   fs/io_uring.c:5870:71: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:5900:66: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5900:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5900:55: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5900:55: sparse:     got unsigned int
   fs/io_uring.c:5981:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:5981:45: sparse:     expected int events
   fs/io_uring.c:5981:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6016:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6016:40: sparse:     expected int mask
   fs/io_uring.c:6016:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6016:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6016:50: sparse:     expected int events
   fs/io_uring.c:6016:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6107:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6107:24: sparse:     expected int
   fs/io_uring.c:6107:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6124:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6124:40: sparse:     expected int mask
   fs/io_uring.c:6124:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6124:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6124:50: sparse:     expected int events
   fs/io_uring.c:6124:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6134:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6134:47: sparse:     expected int events
   fs/io_uring.c:6134:47: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6159:25: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6159:48: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   fs/io_uring.c:6159:48: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6159:48: sparse:     got unsigned int
   fs/io_uring.c:6168:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6168:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6168:22: sparse:    right side has type int
   fs/io_uring.c:6173:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6173:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6173:30: sparse:    right side has type int
   fs/io_uring.c:6175:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6175:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6175:22: sparse:    right side has type int
   fs/io_uring.c:6201:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6201:33: sparse:     expected int mask
   fs/io_uring.c:6201:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6201:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6201:50: sparse:     expected int events
   fs/io_uring.c:6201:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6283:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6283:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6283:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6284:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6284:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6284:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6284:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6284:38: sparse:     got unsigned int
>> fs/io_uring.c:6336:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int apoll_events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6336:27: sparse:     expected int apoll_events
   fs/io_uring.c:6336:27: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6374:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6374:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6374:43: sparse:    right side has type int
   fs/io_uring.c:6375:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6375:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6375:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6375:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2412:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:7382:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7382:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7382:39: sparse: sparse: marked inline, but without a definition

vim +5856 fs/io_uring.c

  5828	
  5829	/*
  5830	 * All poll tw should go through this. Checks for poll events, manages
  5831	 * references, does rewait, etc.
  5832	 *
  5833	 * Returns a negative error on failure. >0 when no action require, which is
  5834	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
  5835	 * the request, then the mask is stored in req->result.
  5836	 */
  5837	static int io_poll_check_events(struct io_kiocb *req, bool locked)
  5838	{
  5839		struct io_ring_ctx *ctx = req->ctx;
  5840		int v;
  5841	
  5842		/* req->task == current here, checking PF_EXITING is safe */
  5843		if (unlikely(req->task->flags & PF_EXITING))
  5844			io_poll_mark_cancelled(req);
  5845	
  5846		do {
  5847			v = atomic_read(&req->poll_refs);
  5848	
  5849			/* tw handler should be the owner, and so have some references */
  5850			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
  5851				return 0;
  5852			if (v & IO_POLL_CANCEL_FLAG)
  5853				return -ECANCELED;
  5854	
  5855			if (!req->result) {
> 5856				struct poll_table_struct pt = { ._key = req->apoll_events };
  5857	
  5858				if (unlikely(!io_assign_file(req, IO_URING_F_UNLOCKED)))
  5859					req->result = -EBADF;
  5860				else
  5861					req->result = vfs_poll(req->file, &pt) & req->apoll_events;
  5862			}
  5863	
  5864			/* multishot, just fill an CQE and proceed */
  5865			if (req->result && !(req->apoll_events & EPOLLONESHOT)) {
  5866				__poll_t mask = mangle_poll(req->result & req->apoll_events);
  5867				bool filled;
  5868	
  5869				spin_lock(&ctx->completion_lock);
  5870				filled = io_fill_cqe_aux(ctx, req->user_data, mask,
  5871							 IORING_CQE_F_MORE);
  5872				io_commit_cqring(ctx);
  5873				spin_unlock(&ctx->completion_lock);
  5874				if (unlikely(!filled))
  5875					return -ECANCELED;
  5876				io_cqring_ev_posted(ctx);
  5877			} else if (req->result) {
  5878				return 0;
  5879			}
  5880	
  5881			/*
  5882			 * Release all references, retry if someone tried to restart
  5883			 * task_work while we were executing it.
  5884			 */
  5885		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
  5886	
  5887		return 1;
  5888	}
  5889	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
