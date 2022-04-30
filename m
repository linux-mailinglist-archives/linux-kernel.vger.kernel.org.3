Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3344515951
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 02:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381847AbiD3Aav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 20:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiD3Aat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 20:30:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634FD1176
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651278449; x=1682814449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/21EfdRG7xpypFuCYvg3eIIuX+9bvVqU22khbyy5klA=;
  b=B0x2yKs9kUsrxqbbqFRt7kwAJZDcSbCLqyADMYvZSOPddw3uRS0mLJiz
   VFJR6MHOGjODpsBqykWhi1nkf0Knm+wXx8/ZYsFsrQUs2aDKWzx3NU6bR
   pfp/cDt3u9f1hfPEf/52pUL6XOSVMyEJViuHtOVDPIyUCwfF+Bsvoy5aC
   OUjvFoAgSVW5mJ1r0jsL9uNUFTQLVfNuaIJgwGxcBuMfzNybM4tUDoaQU
   nwbyXihaXEPWdmIqTHPYZ++mZKffzngq0iGOk5Q5h44Sbzhdko4va2lGp
   fhfkRQgeHNjFWLyYNOZQvaS/ucjPUgeBVBEhpryCvYFYbvb9lj9XkMSdm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266969932"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="266969932"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="685724582"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2022 17:27:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkaxL-0006ij-0D;
        Sat, 30 Apr 2022 00:27:27 +0000
Date:   Sat, 30 Apr 2022 08:26:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.19/io_uring-pbuf 75/84]
 fs/io_uring.c:3599:23: sparse: sparse: incorrect type in return expression
 (different address spaces)
Message-ID: <202204300822.PgmiQykR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.19/io_uring-pbuf
head:   074a323cc380d98290411884e8eb4c3ca7effb87
commit: d84cb823377d1cd0b056c07f404c69671193e795 [75/84] io_uring: make io_buffer_select() return the user address directly
config: arc-randconfig-s031-20220429 (https://download.01.org/0day-ci/archive/20220430/202204300822.PgmiQykR-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/d84cb823377d1cd0b056c07f404c69671193e795
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.19/io_uring-pbuf
        git checkout d84cb823377d1cd0b056c07f404c69671193e795
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/io_uring.h):
   include/trace/events/io_uring.h:493:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] op_flags @@     got restricted __kernel_rwf_t const [usertype] rw_flags @@
   include/trace/events/io_uring.h:493:1: sparse:     expected unsigned int [usertype] op_flags
   include/trace/events/io_uring.h:493:1: sparse:     got restricted __kernel_rwf_t const [usertype] rw_flags
   fs/io_uring.c:3414:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __kernel_rwf_t @@
   fs/io_uring.c:3414:23: sparse:     expected unsigned int [usertype] flags
   fs/io_uring.c:3414:23: sparse:     got restricted __kernel_rwf_t
>> fs/io_uring.c:3599:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   fs/io_uring.c:3599:23: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3599:23: sparse:     got void *
   fs/io_uring.c:3991:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __kernel_rwf_t [usertype] flags @@     got unsigned int [usertype] flags @@
   fs/io_uring.c:3991:48: sparse:     expected restricted __kernel_rwf_t [usertype] flags
   fs/io_uring.c:3991:48: sparse:     got unsigned int [usertype] flags
   fs/io_uring.c:5565:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5565:14: sparse:     expected struct file *file
   fs/io_uring.c:5565:14: sparse:     got struct file [noderef] __rcu *
   fs/io_uring.c:6402:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got int apoll_events @@
   fs/io_uring.c:6402:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:6402:68: sparse:     got int apoll_events
   fs/io_uring.c:6407:48: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6411:59: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6412:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got int @@
   fs/io_uring.c:6412:66: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6412:66: sparse:     got int
   fs/io_uring.c:6412:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:6412:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6412:52: sparse:     got unsigned short
   fs/io_uring.c:6416:75: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6416:75: sparse:     expected signed int [usertype] res
   fs/io_uring.c:6416:75: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6446:68: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6446:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6446:57: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6446:57: sparse:     got unsigned int
   fs/io_uring.c:6527:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6527:45: sparse:     expected int events
   fs/io_uring.c:6527:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6562:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6562:40: sparse:     expected int mask
   fs/io_uring.c:6562:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6562:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6562:50: sparse:     expected int events
   fs/io_uring.c:6562:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6654:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6654:24: sparse:     expected int
   fs/io_uring.c:6654:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6671:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6671:40: sparse:     expected int mask
   fs/io_uring.c:6671:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6671:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6671:50: sparse:     expected int events
   fs/io_uring.c:6671:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6681:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6681:47: sparse:     expected int events
   fs/io_uring.c:6681:47: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6706:25: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6706:48: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   fs/io_uring.c:6706:48: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6706:48: sparse:     got unsigned int
   fs/io_uring.c:6717:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6717:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6717:22: sparse:    right side has type int
   fs/io_uring.c:6722:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6722:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6722:30: sparse:    right side has type int
   fs/io_uring.c:6724:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6724:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6724:22: sparse:    right side has type int
   fs/io_uring.c:6752:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6752:33: sparse:     expected int mask
   fs/io_uring.c:6752:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6752:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6752:50: sparse:     expected int events
   fs/io_uring.c:6752:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6866:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6866:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6866:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6867:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6867:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6867:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6867:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6867:38: sparse:     got unsigned int
   fs/io_uring.c:6919:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int apoll_events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6919:27: sparse:     expected int apoll_events
   fs/io_uring.c:6919:27: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6958:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6958:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6958:43: sparse:    right side has type int
   fs/io_uring.c:6959:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6959:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6959:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6959:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2663:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:8058:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:8058:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:8058:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:8058:39: sparse: sparse: marked inline, but without a definition

vim +3599 fs/io_uring.c

  3573	
  3574	static void __user *io_buffer_select(struct io_kiocb *req, size_t *len,
  3575					     int bgid, unsigned int issue_flags)
  3576	{
  3577		struct io_buffer *kbuf = req->kbuf;
  3578		struct io_ring_ctx *ctx = req->ctx;
  3579		struct io_buffer_list *bl;
  3580	
  3581		if (req->flags & REQ_F_BUFFER_SELECTED)
  3582			return u64_to_user_ptr(kbuf->addr);
  3583	
  3584		io_ring_submit_lock(req->ctx, issue_flags);
  3585	
  3586		bl = io_buffer_get_list(ctx, bgid);
  3587		if (bl && !list_empty(&bl->buf_list)) {
  3588			kbuf = list_first_entry(&bl->buf_list, struct io_buffer, list);
  3589			list_del(&kbuf->list);
  3590			if (*len > kbuf->len)
  3591				*len = kbuf->len;
  3592			req->flags |= REQ_F_BUFFER_SELECTED;
  3593			req->kbuf = kbuf;
  3594			io_ring_submit_unlock(req->ctx, issue_flags);
  3595			return u64_to_user_ptr(kbuf->addr);
  3596		}
  3597	
  3598		io_ring_submit_unlock(req->ctx, issue_flags);
> 3599		return ERR_PTR(-ENOBUFS);
  3600	}
  3601	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
