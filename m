Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C7563FF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiGBL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGBL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:57:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B813F0D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656763074; x=1688299074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OrPJDMLVsU4l4k5D+287on2ev6mIRkVipHKjMx9Zoe8=;
  b=kJFSx78HRxG5AfoTJAATW6uL4A47l05TlIbvSk32wixyjktOU1kM9KyS
   QaoJkpGjesl+aujZcTIg5sbTBbFR3g5puWPSRdEVaMGldQZDIYG2wqb/H
   9D5qmvDu1KXCgPd/GxEyiO3Hz9wuieuIxmCV0x+KIRdOW5voYDQerTU+r
   ly4VpCYr7jspsVy/3fmStw5mQ3RmtuTxiDNU+ldZ8FwERw/eFh5mCExK1
   FS6lpM7At1SsjJRj/4LbJqhIOoG0vAK/h5qBCUA+ncc3FXeiFVIAcrAke
   tyRCWCGH5LxTsgGB39T1A4Je88bINKR8Ho3QBVrkMgNoDjnsRoEJXR6g6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="308353914"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="308353914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 04:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="618695945"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2022 04:57:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7bl1-000FCp-5W;
        Sat, 02 Jul 2022 11:57:51 +0000
Date:   Sat, 2 Jul 2022 19:57:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/tw-test 21/69]
 fs/io_uring.c:5877:66: sparse: sparse: incorrect type in argument 1
 (different base types)
Message-ID: <202207021942.erAJXKL7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/tw-test
head:   e5b6516251a2c7ef733eefa2cd02488235333d84
commit: 5dedbb47888fe7cd7872af9d4ec7ed30f821c831 [21/69] io_uring: explicitly keep a CQE in io_kiocb
config: alpha-randconfig-s032-20220629 (https://download.01.org/0day-ci/archive/20220702/202207021942.erAJXKL7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/5dedbb47888fe7cd7872af9d4ec7ed30f821c831
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/tw-test
        git checkout 5dedbb47888fe7cd7872af9d4ec7ed30f821c831
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c:3199:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __kernel_rwf_t @@
   fs/io_uring.c:3199:23: sparse:     expected unsigned int [usertype] flags
   fs/io_uring.c:3199:23: sparse:     got restricted __kernel_rwf_t
   fs/io_uring.c:3396:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got struct io_buffer *[assigned] kbuf @@
   fs/io_uring.c:3396:24: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3396:24: sparse:     got struct io_buffer *[assigned] kbuf
   fs/io_uring.c:3783:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __kernel_rwf_t [usertype] flags @@     got unsigned int [usertype] flags @@
   fs/io_uring.c:3783:48: sparse:     expected restricted __kernel_rwf_t [usertype] flags
   fs/io_uring.c:3783:48: sparse:     got unsigned int [usertype] flags
   fs/io_uring.c:5102:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5102:14: sparse:     expected struct file *file
   fs/io_uring.c:5102:14: sparse:     got struct file [noderef] __rcu *
   fs/io_uring.c:5867:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got int apoll_events @@
   fs/io_uring.c:5867:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:5867:68: sparse:     got int apoll_events
   fs/io_uring.c:5872:48: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5876:59: sparse: sparse: restricted __poll_t degrades to integer
>> fs/io_uring.c:5877:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got int @@
   fs/io_uring.c:5877:66: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5877:66: sparse:     got int
   fs/io_uring.c:5877:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:5877:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:5877:52: sparse:     got unsigned short
   fs/io_uring.c:5881:75: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:5881:75: sparse:     expected signed int [usertype] res
   fs/io_uring.c:5881:75: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:5911:68: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:5911:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:5911:57: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:5911:57: sparse:     got unsigned int
   fs/io_uring.c:5992:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:5992:45: sparse:     expected int events
   fs/io_uring.c:5992:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6027:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6027:40: sparse:     expected int mask
   fs/io_uring.c:6027:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6027:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6027:50: sparse:     expected int events
   fs/io_uring.c:6027:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6118:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6118:24: sparse:     expected int
   fs/io_uring.c:6118:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6135:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6135:40: sparse:     expected int mask
   fs/io_uring.c:6135:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6135:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6135:50: sparse:     expected int events
   fs/io_uring.c:6135:50: sparse:     got restricted __poll_t [usertype] events
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
   fs/io_uring.c:6212:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6212:33: sparse:     expected int mask
   fs/io_uring.c:6212:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6212:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6212:50: sparse:     expected int events
   fs/io_uring.c:6212:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6294:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6294:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6294:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6295:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6295:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6295:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6295:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6295:38: sparse:     got unsigned int
   fs/io_uring.c:6347:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int apoll_events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6347:27: sparse:     expected int apoll_events
   fs/io_uring.c:6347:27: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6385:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6385:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6385:43: sparse:    right side has type int
   fs/io_uring.c:6386:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6386:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6386:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6386:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2451:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:7396:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7396:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7396:39: sparse: sparse: marked inline, but without a definition

vim +5877 fs/io_uring.c

  5839	
  5840	/*
  5841	 * All poll tw should go through this. Checks for poll events, manages
  5842	 * references, does rewait, etc.
  5843	 *
  5844	 * Returns a negative error on failure. >0 when no action require, which is
  5845	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
  5846	 * the request, then the mask is stored in req->cqe.res.
  5847	 */
  5848	static int io_poll_check_events(struct io_kiocb *req, bool locked)
  5849	{
  5850		struct io_ring_ctx *ctx = req->ctx;
  5851		int v;
  5852	
  5853		/* req->task == current here, checking PF_EXITING is safe */
  5854		if (unlikely(req->task->flags & PF_EXITING))
  5855			io_poll_mark_cancelled(req);
  5856	
  5857		do {
  5858			v = atomic_read(&req->poll_refs);
  5859	
  5860			/* tw handler should be the owner, and so have some references */
  5861			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
  5862				return 0;
  5863			if (v & IO_POLL_CANCEL_FLAG)
  5864				return -ECANCELED;
  5865	
  5866			if (!req->cqe.res) {
  5867				struct poll_table_struct pt = { ._key = req->apoll_events };
  5868				unsigned flags = locked ? 0 : IO_URING_F_UNLOCKED;
  5869	
  5870				if (unlikely(!io_assign_file(req, flags)))
  5871					return -EBADF;
  5872				req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
  5873			}
  5874	
  5875			/* multishot, just fill an CQE and proceed */
  5876			if (req->cqe.res && !(req->apoll_events & EPOLLONESHOT)) {
> 5877				__poll_t mask = mangle_poll(req->cqe.res & req->apoll_events);
  5878				bool filled;
  5879	
  5880				spin_lock(&ctx->completion_lock);
  5881				filled = io_fill_cqe_aux(ctx, req->cqe.user_data, mask,
  5882							 IORING_CQE_F_MORE);
  5883				io_commit_cqring(ctx);
  5884				spin_unlock(&ctx->completion_lock);
  5885				if (unlikely(!filled))
  5886					return -ECANCELED;
  5887				io_cqring_ev_posted(ctx);
  5888			} else if (req->cqe.res) {
  5889				return 0;
  5890			}
  5891	
  5892			/*
  5893			 * Release all references, retry if someone tried to restart
  5894			 * task_work while we were executing it.
  5895			 */
  5896		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
  5897	
  5898		return 1;
  5899	}
  5900	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
