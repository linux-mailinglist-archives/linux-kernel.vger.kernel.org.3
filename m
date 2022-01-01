Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325B148275C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiAAKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 05:54:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:53922 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbiAAKyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 05:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641034479; x=1672570479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ha7s+2QtLtZP4MEH1gak+iXGjy7xDlDv5uUrKrZQLIE=;
  b=dl1NY8/A2kUbq6PAlCdjelwDMNMBaUc9D1yawHsONh1f+8rFj9OQBfFG
   a1fPStj9NcV4VNnBY/SXYRTvPiJpcGCfnQUgx+r8qJvAGsgStN1aj8+7l
   71gnb7X1hm/I3JEsdd3XgysCG8JpEMb4mWLihYS4m5YcYs/spjVy3E1um
   Fza1pELc5d+giD2xGL+WOhwXfrzoV1Zxg8ns7pMhgY4YFglv9NcQO6baj
   yp+z/N2/68fQ1RwC1ih0PPk+8P0GWJ9tieEsKZTlVWXEtzuIpxqhvmhq7
   V5+d+bmt3TFkMZpCdurkyZA6ssMpnSAO3L7R4J4fDSgaLFzd1/nJ6HPHP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="221880340"
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="221880340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 02:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="469249286"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jan 2022 02:54:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3c20-000CMy-N0; Sat, 01 Jan 2022 10:54:36 +0000
Date:   Sat, 1 Jan 2022 18:54:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: fs/io_uring.c:2330:40: warning: variable 'prev' set but not used
Message-ID: <202201011808.Lm6C3RMA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 6f33b0bc4ea43f5c5ce7b7c9ab66051f80837862 io_uring: use slist for completion batching
date:   2 months ago
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220101/202201011808.Lm6C3RMA-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f33b0bc4ea43f5c5ce7b7c9ab66051f80837862
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6f33b0bc4ea43f5c5ce7b7c9ab66051f80837862
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/io_uring.c: In function 'io_queue_async_work':
   fs/io_uring.c:1455:61: warning: parameter 'locked' set but not used [-Wunused-but-set-parameter]
    1455 | static void io_queue_async_work(struct io_kiocb *req, bool *locked)
         |                                                       ~~~~~~^~~~~~
   fs/io_uring.c: In function '__io_submit_flush_completions':
>> fs/io_uring.c:2330:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2330 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~


vim +/prev +2330 fs/io_uring.c

  2326	
  2327	static void __io_submit_flush_completions(struct io_ring_ctx *ctx)
  2328		__must_hold(&ctx->uring_lock)
  2329	{
> 2330		struct io_wq_work_node *node, *prev;
  2331		struct io_submit_state *state = &ctx->submit_state;
  2332		struct req_batch rb;
  2333	
  2334		spin_lock(&ctx->completion_lock);
  2335		wq_list_for_each(node, prev, &state->compl_reqs) {
  2336			struct io_kiocb *req = container_of(node, struct io_kiocb,
  2337							    comp_list);
  2338	
  2339			__io_cqring_fill_event(ctx, req->user_data, req->result,
  2340						req->compl.cflags);
  2341		}
  2342		io_commit_cqring(ctx);
  2343		spin_unlock(&ctx->completion_lock);
  2344		io_cqring_ev_posted(ctx);
  2345	
  2346		io_init_req_batch(&rb);
  2347		node = state->compl_reqs.first;
  2348		do {
  2349			struct io_kiocb *req = container_of(node, struct io_kiocb,
  2350							    comp_list);
  2351	
  2352			node = req->comp_list.next;
  2353			if (req_ref_put_and_test(req))
  2354				io_req_free_batch(&rb, req, &ctx->submit_state);
  2355		} while (node);
  2356	
  2357		io_req_free_batch_finish(ctx, &rb);
  2358		INIT_WQ_LIST(&state->compl_reqs);
  2359	}
  2360	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
