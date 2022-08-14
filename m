Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C6591D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 03:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiHNByl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 21:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNByk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 21:54:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4145047
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660442079; x=1691978079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W6MBtWKO8tMPHF/oumnvXqnlJO5Gd5TzgHu3Kmhb8J4=;
  b=M0XHpKO9NRjagexgs+BjfTLu7xSYM4T2ll8JtGrfzOSI9yzAxIKDq4pz
   Pf4AP9j71eBN0lpHdqfs17/Yn1g79Wvfv5Y6BkmTVYX586Bkfia845f5o
   seOXtw19tY05m7znw7XHagdubQU/hEna6u/qhQVMq/BERY7yLsX44K+UK
   QTBEYqULRxQGBib8IMwHkYoSXRStuEn+WOVbw5WEUq+/R/aA5YsHOjaow
   vqpPSQlNP6JdaS49GhHhW//ynTr4YS//iUfjSvU0YWmM5gH58gzoIzJGF
   GA51iGx4g7DXYju2Pminj6MQPUKRccZPCEuUTZfwRiDUp7moek0Fl3c5o
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317767606"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="317767606"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 18:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="695624197"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2022 18:54:37 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN2pp-0002K7-0U;
        Sun, 14 Aug 2022 01:54:37 +0000
Date:   Sun, 14 Aug 2022 09:54:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.19 294/1034]
 io_uring/io_uring.c:3150:40: warning: variable 'prev' set but not used
Message-ID: <202208140958.F7WLU1BS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.19
head:   a93eab25d54766b1d89d7fa7dd315b3fc268d0b5
commit: a1fd6af4b362b4f8ed0d7f5a78f0e8ff2f15d70f [294/1034] io_uring: move to separate directory
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220814/202208140958.F7WLU1BS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a1fd6af4b362b4f8ed0d7f5a78f0e8ff2f15d70f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.19
        git checkout a1fd6af4b362b4f8ed0d7f5a78f0e8ff2f15d70f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   io_uring/io_uring.c: In function '__io_submit_flush_completions':
>> io_uring/io_uring.c:3150:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    3150 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~


vim +/prev +3150 io_uring/io_uring.c

7a743e225b2a9da fs/io_uring.c Pavel Begunkov 2020-03-03  3146  
c450178d9be9dc4 fs/io_uring.c Pavel Begunkov 2021-09-08  3147  static void __io_submit_flush_completions(struct io_ring_ctx *ctx)
a141dd896f544df fs/io_uring.c Jens Axboe     2021-08-12  3148  	__must_hold(&ctx->uring_lock)
905c172f32c56f0 fs/io_uring.c Pavel Begunkov 2021-02-10  3149  {
6f33b0bc4ea43f5 fs/io_uring.c Pavel Begunkov 2021-09-24 @3150  	struct io_wq_work_node *node, *prev;
cd0ca2e048dc0dd fs/io_uring.c Pavel Begunkov 2021-08-09  3151  	struct io_submit_state *state = &ctx->submit_state;
905c172f32c56f0 fs/io_uring.c Pavel Begunkov 2021-02-10  3152  
3d4aeb9f98058c3 fs/io_uring.c Pavel Begunkov 2021-11-10  3153  	if (state->flush_cqes) {
79ebeaee8a21a00 fs/io_uring.c Jens Axboe     2021-08-10  3154  		spin_lock(&ctx->completion_lock);
6f33b0bc4ea43f5 fs/io_uring.c Pavel Begunkov 2021-09-24  3155  		wq_list_for_each(node, prev, &state->compl_reqs) {
6f33b0bc4ea43f5 fs/io_uring.c Pavel Begunkov 2021-09-24  3156  			struct io_kiocb *req = container_of(node, struct io_kiocb,
6f33b0bc4ea43f5 fs/io_uring.c Pavel Begunkov 2021-09-24  3157  						    comp_list);
5182ed2e332e8e1 fs/io_uring.c Pavel Begunkov 2021-06-26  3158  
f43de1f88841d59 fs/io_uring.c Pavel Begunkov 2022-06-15  3159  			if (!(req->flags & REQ_F_CQE_SKIP))
91ef75a7db0d085 fs/io_uring.c Pavel Begunkov 2022-06-15  3160  				__io_fill_cqe_req(ctx, req);
905c172f32c56f0 fs/io_uring.c Pavel Begunkov 2021-02-10  3161  		}
3d4aeb9f98058c3 fs/io_uring.c Pavel Begunkov 2021-11-10  3162  
905c172f32c56f0 fs/io_uring.c Pavel Begunkov 2021-02-10  3163  		io_commit_cqring(ctx);
79ebeaee8a21a00 fs/io_uring.c Jens Axboe     2021-08-10  3164  		spin_unlock(&ctx->completion_lock);
905c172f32c56f0 fs/io_uring.c Pavel Begunkov 2021-02-10  3165  		io_cqring_ev_posted(ctx);
3d4aeb9f98058c3 fs/io_uring.c Pavel Begunkov 2021-11-10  3166  		state->flush_cqes = false;
3d4aeb9f98058c3 fs/io_uring.c Pavel Begunkov 2021-11-10  3167  	}
5182ed2e332e8e1 fs/io_uring.c Pavel Begunkov 2021-06-26  3168  
1cce17aca621c38 fs/io_uring.c Pavel Begunkov 2021-09-24  3169  	io_free_batch_list(ctx, state->compl_reqs.first);
6f33b0bc4ea43f5 fs/io_uring.c Pavel Begunkov 2021-09-24  3170  	INIT_WQ_LIST(&state->compl_reqs);
7a743e225b2a9da fs/io_uring.c Pavel Begunkov 2020-03-03  3171  }
7a743e225b2a9da fs/io_uring.c Pavel Begunkov 2020-03-03  3172  

:::::: The code at line 3150 was first introduced by commit
:::::: 6f33b0bc4ea43f5c5ce7b7c9ab66051f80837862 io_uring: use slist for completion batching

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
