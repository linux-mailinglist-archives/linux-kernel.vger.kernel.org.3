Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E770A57738D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiGQDHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiGQDHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:07:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51D13FA6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658027229; x=1689563229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=woDyvCxHbDJJsi/2kRKD2XH70ZgxnFoC32Cdw/f27xs=;
  b=h9gmSN1Rbw5rbvMx1k2QLPtiSc1i/0NNKRV/YXA50Whi5fCcjfscb7ZY
   ZuJ+uXRly8njk7EXWEeRL4K3qhlJC4FvdlqLZ6bVyUyvnRKYcQ/DBDc66
   oSLYNnoCdxWeDB/lD/OvZuGwV/mzyKNxZ/VntiLGS9MPSCeIarw3PeUJ8
   +pX0TQ6U8ATkal2wVWu54cc9FD5RMEvyO9X4G5lOQuSnEktyD9b8J1Bb4
   a/TkugbdvAYDUeI4eMq7YwXbLxuCqLwviffGBVAe826pN1+1jm0ejLl0d
   GL5AR/K0PA5l0Atej/1c/g9Ffgsl/p0Fj2vqQj1y5AajRz9sFOnYXBhdH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="265808222"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="265808222"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 20:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="624305076"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2022 20:07:07 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCucc-0002aQ-ND;
        Sun, 17 Jul 2022 03:07:06 +0000
Date:   Sun, 17 Jul 2022 11:06:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.20/io_uring 2/171] io_uring/io_uring.c:11521:1:
 sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202207171120.jkCZ5Bc7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring
head:   4832d0f22cf865e569b3b90b9db346055730c224
commit: 239b2db7c7ca96b3b7dc883ca90d3b0244e238cd [2/171] io_uring: move to separate directory
config: s390-randconfig-s033-20220717 (https://download.01.org/0day-ci/archive/20220717/202207171120.jkCZ5Bc7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=239b2db7c7ca96b3b7dc883ca90d3b0244e238cd
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.20/io_uring
        git checkout 239b2db7c7ca96b3b7dc883ca90d3b0244e238cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   io_uring/io_uring.c:205:37: sparse: sparse: array of flexible structures
   io_uring/io_uring.c:6652:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/io_uring.c:6652:38: sparse:     expected signed int [usertype] res
   io_uring/io_uring.c:6652:38: sparse:     got restricted __poll_t
   io_uring/io_uring.c:6663:56: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:6662:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/io_uring.c:6662:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/io_uring.c:6662:66: sparse:     got unsigned int
   io_uring/io_uring.c:6662:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/io_uring.c:6662:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/io_uring.c:6662:52: sparse:     got unsigned short
   io_uring/io_uring.c:6668:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/io_uring.c:6668:50: sparse:     expected signed int [usertype] res
   io_uring/io_uring.c:6668:50: sparse:     got restricted __poll_t [usertype] mask
   io_uring/io_uring.c:6705:68: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:6705:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/io_uring.c:6705:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/io_uring.c:6705:57: sparse:     got unsigned int
   io_uring/io_uring.c:6823:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/io_uring.c:6823:40: sparse:     expected int mask
   io_uring/io_uring.c:6823:40: sparse:     got restricted __poll_t [usertype] mask
   io_uring/io_uring.c:6917:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/io_uring.c:6917:24: sparse:     expected int
   io_uring/io_uring.c:6917:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/io_uring.c:6937:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/io_uring.c:6937:40: sparse:     expected int mask
   io_uring/io_uring.c:6937:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/io_uring.c:6972:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   io_uring/io_uring.c:6972:33: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/io_uring.c:6972:33: sparse:     got int
   io_uring/io_uring.c:7021:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/io_uring.c:7021:33: sparse:     expected int mask
   io_uring/io_uring.c:7021:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/io_uring.c:7021:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/io_uring.c:7021:50: sparse:     expected int events
   io_uring/io_uring.c:7021:50: sparse:     got restricted __poll_t [usertype] events
   io_uring/io_uring.c:7135:24: sparse: sparse: invalid assignment: |=
   io_uring/io_uring.c:7135:24: sparse:    left side has type unsigned int
   io_uring/io_uring.c:7135:24: sparse:    right side has type restricted __poll_t
   io_uring/io_uring.c:7136:65: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:7136:29: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:7136:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/io_uring.c:7136:38: sparse:     expected restricted __poll_t
   io_uring/io_uring.c:7136:38: sparse:     got unsigned int
   io_uring/io_uring.c:7225:43: sparse: sparse: invalid assignment: &=
   io_uring/io_uring.c:7225:43: sparse:    left side has type restricted __poll_t
   io_uring/io_uring.c:7225:43: sparse:    right side has type int
   io_uring/io_uring.c:7226:62: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/io_uring.c:7226:43: sparse: sparse: invalid assignment: |=
   io_uring/io_uring.c:7226:43: sparse:    left side has type restricted __poll_t
   io_uring/io_uring.c:7226:43: sparse:    right side has type unsigned int
>> io_uring/io_uring.c:11521:1: sparse: sparse: Using plain integer as NULL pointer
>> io_uring/io_uring.c:11521:1: sparse: sparse: Using plain integer as NULL pointer
   io_uring/io_uring.c:12124:1: sparse: sparse: Using plain integer as NULL pointer
   io_uring/io_uring.c:12124:1: sparse: sparse: Using plain integer as NULL pointer
   io_uring/io_uring.c:12719:1: sparse: sparse: Using plain integer as NULL pointer
   io_uring/io_uring.c:12719:1: sparse: sparse: Using plain integer as NULL pointer
   io_uring/io_uring.c:2665:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   io_uring/io_uring.c:9303:9: sparse: sparse: context imbalance in 'io_sq_thread_unpark' - wrong count at exit
   io_uring/io_uring.c:9314:9: sparse: sparse: context imbalance in 'io_sq_thread_park' - wrong count at exit

vim +11521 io_uring/io_uring.c

c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11520  
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07 @11521  SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11522  		u32, min_complete, u32, flags, const void __user *, argp,
c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11523  		size_t, argsz)
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11524  {
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11525  	struct io_ring_ctx *ctx;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11526  	struct fd f;
33f993da9829738 fs/io_uring.c Pavel Begunkov     2021-03-19  11527  	long ret;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11528  
4c6e277c4cc4a6b fs/io_uring.c Jens Axboe         2020-07-01  11529  	io_run_task_work();
b41e98524e424d1 fs/io_uring.c Jens Axboe         2020-02-17  11530  
33f993da9829738 fs/io_uring.c Pavel Begunkov     2021-03-19  11531  	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11532  			       IORING_ENTER_SQ_WAIT | IORING_ENTER_EXT_ARG |
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11533  			       IORING_ENTER_REGISTERED_RING)))
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11534  		return -EINVAL;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11535  
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11536  	/*
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11537  	 * Ring fd has been registered via IORING_REGISTER_RING_FDS, we
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11538  	 * need only dereference our task private array to find it.
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11539  	 */
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11540  	if (flags & IORING_ENTER_REGISTERED_RING) {
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11541  		struct io_uring_task *tctx = current->io_uring;
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11542  
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11543  		if (!tctx || fd >= IO_RINGFD_REG_MAX)
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11544  			return -EINVAL;
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11545  		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11546  		f.file = tctx->registered_rings[fd];
4329490a78b66ae fs/io_uring.c Al Viro            2022-05-11  11547  		f.flags = 0;
e7a6c00dc77aedf fs/io_uring.c Jens Axboe         2022-03-04  11548  	} else {
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11549  		f = fdget(fd);
4329490a78b66ae fs/io_uring.c Al Viro            2022-05-11  11550  	}
4329490a78b66ae fs/io_uring.c Al Viro            2022-05-11  11551  
33f993da9829738 fs/io_uring.c Pavel Begunkov     2021-03-19  11552  	if (unlikely(!f.file))
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11553  		return -EBADF;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11554  
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11555  	ret = -EOPNOTSUPP;
33f993da9829738 fs/io_uring.c Pavel Begunkov     2021-03-19  11556  	if (unlikely(f.file->f_op != &io_uring_fops))
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11557  		goto out_fput;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11558  
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11559  	ret = -ENXIO;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11560  	ctx = f.file->private_data;
33f993da9829738 fs/io_uring.c Pavel Begunkov     2021-03-19  11561  	if (unlikely(!percpu_ref_tryget(&ctx->refs)))
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11562  		goto out_fput;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11563  
7e84e1c7566a1df fs/io_uring.c Stefano Garzarella 2020-08-27  11564  	ret = -EBADFD;
33f993da9829738 fs/io_uring.c Pavel Begunkov     2021-03-19  11565  	if (unlikely(ctx->flags & IORING_SETUP_R_DISABLED))
7e84e1c7566a1df fs/io_uring.c Stefano Garzarella 2020-08-27  11566  		goto out;
7e84e1c7566a1df fs/io_uring.c Stefano Garzarella 2020-08-27  11567  
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11568  	/*
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11569  	 * For SQ polling, the thread will do all submissions and completions.
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11570  	 * Just return the requested submit count, and wake the thread if
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11571  	 * we were asked to.
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11572  	 */
b2a9eadab857309 fs/io_uring.c Jens Axboe         2019-09-12  11573  	ret = 0;
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11574  	if (ctx->flags & IORING_SETUP_SQPOLL) {
90f67366cb88719 fs/io_uring.c Pavel Begunkov     2021-08-09  11575  		io_cqring_overflow_flush(ctx);
6c503150ae33ee1 fs/io_uring.c Pavel Begunkov     2021-01-04  11576  
21f965221e7c426 fs/io_uring.c Jens Axboe         2021-08-14  11577  		if (unlikely(ctx->sq_data->thread == NULL)) {
041474885e9707a fs/io_uring.c Stefan Metzmacher  2021-03-07  11578  			ret = -EOWNERDEAD;
5f3f26f98ae484a fs/io_uring.c Jens Axboe         2021-02-25  11579  			goto out;
21f965221e7c426 fs/io_uring.c Jens Axboe         2021-08-14  11580  		}
6c271ce2f1d572f fs/io_uring.c Jens Axboe         2019-01-10  11581  		if (flags & IORING_ENTER_SQ_WAKEUP)
534ca6d684f1fea fs/io_uring.c Jens Axboe         2020-09-02  11582  			wake_up(&ctx->sq_data->wait);
d9d05217cb6990b fs/io_uring.c Pavel Begunkov     2021-01-08  11583  		if (flags & IORING_ENTER_SQ_WAIT) {
d9d05217cb6990b fs/io_uring.c Pavel Begunkov     2021-01-08  11584  			ret = io_sqpoll_wait_sq(ctx);
d9d05217cb6990b fs/io_uring.c Pavel Begunkov     2021-01-08  11585  			if (ret)
d9d05217cb6990b fs/io_uring.c Pavel Begunkov     2021-01-08  11586  				goto out;
d9d05217cb6990b fs/io_uring.c Pavel Begunkov     2021-01-08  11587  		}
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11588  		ret = to_submit;
b2a9eadab857309 fs/io_uring.c Jens Axboe         2019-09-12  11589  	} else if (to_submit) {
eef51daa72f745b fs/io_uring.c Pavel Begunkov     2021-06-14  11590  		ret = io_uring_add_tctx_node(ctx);
0f2122045b94624 fs/io_uring.c Jens Axboe         2020-09-13  11591  		if (unlikely(ret))
0f2122045b94624 fs/io_uring.c Jens Axboe         2020-09-13  11592  			goto out;
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11593  
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11594  		mutex_lock(&ctx->uring_lock);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11595  		ret = io_submit_sqes(ctx, to_submit);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11596  		if (ret != to_submit) {
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11597  			mutex_unlock(&ctx->uring_lock);
7c504e65206a437 fs/io_uring.c Pavel Begunkov     2019-12-18  11598  			goto out;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11599  		}
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11600  		if ((flags & IORING_ENTER_GETEVENTS) && ctx->syscall_iopoll)
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11601  			goto iopoll_locked;
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11602  		mutex_unlock(&ctx->uring_lock);
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11603  	}
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11604  	if (flags & IORING_ENTER_GETEVENTS) {
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11605  		int ret2;
773697b610bff94 fs/io_uring.c Pavel Begunkov     2022-03-22  11606  		if (ctx->syscall_iopoll) {
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11607  			/*
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11608  			 * We disallow the app entering submit/complete with
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11609  			 * polling, but we still need to lock the ring to
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11610  			 * prevent racing with polled issue that got punted to
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11611  			 * a workqueue.
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11612  			 */
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11613  			mutex_lock(&ctx->uring_lock);
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11614  iopoll_locked:
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11615  			ret2 = io_validate_ext_arg(flags, argp, argsz);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11616  			if (likely(!ret2)) {
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11617  				min_complete = min(min_complete,
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11618  						   ctx->cq_entries);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11619  				ret2 = io_iopoll_check(ctx, min_complete);
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11620  			}
d487b43cd3276e4 fs/io_uring.c Pavel Begunkov     2022-03-22  11621  			mutex_unlock(&ctx->uring_lock);
def596e9557c91d fs/io_uring.c Jens Axboe         2019-01-09  11622  		} else {
c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11623  			const sigset_t __user *sig;
c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11624  			struct __kernel_timespec __user *ts;
c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11625  
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11626  			ret2 = io_get_ext_arg(flags, argp, &argsz, &ts, &sig);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11627  			if (likely(!ret2)) {
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11628  				min_complete = min(min_complete,
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11629  						   ctx->cq_entries);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11630  				ret2 = io_cqring_wait(ctx, min_complete, sig,
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11631  						      argsz, ts);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11632  			}
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11633  		}
c73ebb685fb6dfb fs/io_uring.c Hao Xu             2020-11-03  11634  
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11635  		if (!ret) {
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11636  			ret = ret2;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11637  
32b2244a840a90e fs/io_uring.c Xiaoguang Wang     2020-03-11  11638  			/*
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11639  			 * EBADR indicates that one or more CQE were dropped.
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11640  			 * Once the user has been informed we can clear the bit
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11641  			 * as they are obviously ok with those drops.
32b2244a840a90e fs/io_uring.c Xiaoguang Wang     2020-03-11  11642  			 */
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11643  			if (unlikely(ret2 == -EBADR))
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11644  				clear_bit(IO_CHECK_CQ_DROPPED_BIT,
155bc9505dbd661 fs/io_uring.c Dylan Yudaken      2022-04-21  11645  					  &ctx->check_cq);
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11646  		}
def596e9557c91d fs/io_uring.c Jens Axboe         2019-01-09  11647  	}
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11648  
7c504e65206a437 fs/io_uring.c Pavel Begunkov     2019-12-18  11649  out:
6805b32ec2b0897 fs/io_uring.c Pavel Begunkov     2019-10-08  11650  	percpu_ref_put(&ctx->refs);
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11651  out_fput:
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11652  	fdput(f);
3e813c9026720c1 fs/io_uring.c Dylan Yudaken      2022-04-21  11653  	return ret;
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11654  }
2b188cc1bb857a9 fs/io_uring.c Jens Axboe         2019-01-07  11655  

:::::: The code at line 11521 was first introduced by commit
:::::: 2b188cc1bb857a9d4701ae59aa7768b5124e262e Add io_uring IO interface

:::::: TO: Jens Axboe <axboe@kernel.dk>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
