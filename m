Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1220A528D73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiEPSvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiEPSvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:51:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C23EA8F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652727108; x=1684263108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bu9A2FLNqJyynjkFJSR1rIgGLMg6U+qTZ+vN+N3RJGQ=;
  b=l3xgyH+cEdKMSvzgLaYBjc1xezeZoOkir8ezjWJDE8c0634hb34SZR76
   JDJLjd1rarCPlS4vORZ+XxzEEH+rzySO5YseT/gYmfFD1FfP63v/TyXi/
   l+MPce1tlt7dqFXnocGN+kanFToL3xeTblENnohlt1vyq5zcHQqBgC3FM
   N2Xjpglj1wuiv8ygvWD42G5WzFNrTGrnGLA8GCPJJ+kJ3/Fis0Ssm6If4
   u5V9XuB6OXmSYG3t7c6PZ0AmQhj7cPCJSlueMUfXGsqIEt1+sVPzYi2uw
   7W1VZyc/29WoJczxbdWxt8mts+ujXxepEUGR8Go67Xs2ogExDi/jAHYoj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="252986291"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="252986291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="713500451"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2022 11:51:45 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqfom-0000Gw-IR;
        Mon, 16 May 2022 18:51:44 +0000
Date:   Tue, 17 May 2022 02:51:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.19/io_uring-pbuf 99/102] fs/io_uring.c:3470:35:
 sparse: sparse: incorrect type in initializer (different address spaces)
Message-ID: <202205170253.iHvYIuRG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.19/io_uring-pbuf
head:   5c7b7e4148d4c9c699b2af604822a012f026fc8f
commit: ed3ec408f289963ff22b5a9a783e4f211ed45b20 [99/102] io_uring: fix locking state for empty buffer group
config: sparc-randconfig-s031-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170253.iHvYIuRG-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=ed3ec408f289963ff22b5a9a783e4f211ed45b20
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.19/io_uring-pbuf
        git checkout ed3ec408f289963ff22b5a9a783e4f211ed45b20
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/io_uring.c:3470:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *ret @@     got void * @@
   fs/io_uring.c:3470:35: sparse:     expected void [noderef] __user *ret
   fs/io_uring.c:3470:35: sparse:     got void *
   fs/io_uring.c:3500:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   fs/io_uring.c:3500:31: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3500:31: sparse:     got void *
   fs/io_uring.c:5255:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5255:14: sparse:     expected struct file *file
   fs/io_uring.c:5255:14: sparse:     got struct file [noderef] __rcu *
   fs/io_uring.c:6087:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got int apoll_events @@
   fs/io_uring.c:6087:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:6087:68: sparse:     got int apoll_events
   fs/io_uring.c:6092:48: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6097:41: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6102:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got int @@
   fs/io_uring.c:6102:66: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6102:66: sparse:     got int
   fs/io_uring.c:6102:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:6102:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6102:52: sparse:     got unsigned short
   fs/io_uring.c:6108:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6108:50: sparse:     expected signed int [usertype] res
   fs/io_uring.c:6108:50: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6145:68: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6145:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6145:57: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6145:57: sparse:     got unsigned int
   fs/io_uring.c:6227:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6227:45: sparse:     expected int events
   fs/io_uring.c:6227:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6249:47: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6249:35: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6249:23: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6262:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6262:40: sparse:     expected int mask
   fs/io_uring.c:6262:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6262:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6262:50: sparse:     expected int events
   fs/io_uring.c:6262:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6354:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6354:24: sparse:     expected int
   fs/io_uring.c:6354:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6371:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6371:40: sparse:     expected int mask
   fs/io_uring.c:6371:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6371:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6371:50: sparse:     expected int events
   fs/io_uring.c:6371:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6381:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6381:47: sparse:     expected int events
   fs/io_uring.c:6381:47: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6406:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   fs/io_uring.c:6406:33: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6406:33: sparse:     got int
   fs/io_uring.c:6419:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6419:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6419:22: sparse:    right side has type int
   fs/io_uring.c:6424:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6424:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6424:30: sparse:    right side has type int
   fs/io_uring.c:6426:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6426:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6426:22: sparse:    right side has type int
   fs/io_uring.c:6454:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6454:33: sparse:     expected int mask
   fs/io_uring.c:6454:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6454:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6454:50: sparse:     expected int events
   fs/io_uring.c:6454:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6568:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6568:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6568:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6569:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6569:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6569:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6569:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6569:38: sparse:     got unsigned int
   fs/io_uring.c:6617:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int apoll_events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6617:27: sparse:     expected int apoll_events
   fs/io_uring.c:6617:27: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6656:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6656:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6656:43: sparse:    right side has type int
   fs/io_uring.c:6657:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6657:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6657:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6657:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2562:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
   fs/io_uring.c:7721:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7721:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7721:39: sparse: sparse: marked inline, but without a definition
   fs/io_uring.c:7721:39: sparse: sparse: marked inline, but without a definition

vim +3470 fs/io_uring.c

  3465	
  3466	static void __user *io_provided_buffer_select(struct io_kiocb *req, size_t *len,
  3467						      struct io_buffer_list *bl,
  3468						      unsigned int issue_flags)
  3469	{
> 3470		void __user *ret = ERR_PTR(-ENOBUFS);
  3471	
  3472		if (!list_empty(&bl->buf_list)) {
  3473			struct io_buffer *kbuf;
  3474	
  3475			kbuf = list_first_entry(&bl->buf_list, struct io_buffer, list);
  3476			list_del(&kbuf->list);
  3477			if (*len > kbuf->len)
  3478				*len = kbuf->len;
  3479			req->flags |= REQ_F_BUFFER_SELECTED;
  3480			req->kbuf = kbuf;
  3481			req->buf_index = kbuf->bid;
  3482			ret = u64_to_user_ptr(kbuf->addr);
  3483		}
  3484	
  3485		io_ring_submit_unlock(req->ctx, issue_flags);
  3486		return ret;
  3487	}
  3488	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
