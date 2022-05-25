Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78B53343A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiEYASa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiEYAS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:18:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45370901
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653437907; x=1684973907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DH2WUhDPraUoittMKNIClkc2Y/BkFK1Kzy0SfRxStVY=;
  b=bJhcz/l5z5oUZd0zKRhIF8m8bPy5t1cq2DWJSaEZ/UtL9aNVP2wwf7A9
   ojGf5110yt1TJ92FvdX7MXbIt2EG6BrxSVqKltjjsldOSfNOFDEvDETWf
   YiCL3SpfGXoQUDhhN1abx+5WHaPgcNjZULSKIMrM3iIs97jy81OCJjUC/
   ivUNScEpWHL8GeQFkYKwZLEcJP1AOOEy1uzusFNpW1A6bKO2/ZlJBKjGs
   l40FSNoKcOTdJN/6cngLu9KW056Mbc0qCIvLqBVmvCsv1uVYse57yFzyf
   ow7plvykIN1kfmoZw4IkUHsy+/pJMA7IiqXgyDNPfiQttorEE0LX4FEKE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="299007735"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="299007735"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 17:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="608891220"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 17:18:25 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntejI-0002Zq-Gw;
        Wed, 25 May 2022 00:18:24 +0000
Date:   Wed, 25 May 2022 08:18:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring 8/34]
 io_uring/io_uring.c:2937:40: warning: variable 'prev' set but not used
Message-ID: <202205250842.F5Qwo4Hc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring
head:   efc30c3b043b70c4a299df9f10a948b60ef721e3
commit: 4ad7740c8e760244c249fff910d82f4fcf214bda [8/34] io_uring: move to separate directory
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220525/202205250842.F5Qwo4Hc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/4ad7740c8e760244c249fff910d82f4fcf214bda
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring
        git checkout 4ad7740c8e760244c249fff910d82f4fcf214bda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   io_uring/io_uring.c: In function '__io_submit_flush_completions':
>> io_uring/io_uring.c:2937:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2937 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~


vim +/prev +2937 io_uring/io_uring.c

7a743e225b2a9d fs/io_uring.c Pavel Begunkov 2020-03-03  2933  
c450178d9be9dc fs/io_uring.c Pavel Begunkov 2021-09-08  2934  static void __io_submit_flush_completions(struct io_ring_ctx *ctx)
a141dd896f544d fs/io_uring.c Jens Axboe     2021-08-12  2935  	__must_hold(&ctx->uring_lock)
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2936  {
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24 @2937  	struct io_wq_work_node *node, *prev;
cd0ca2e048dc0d fs/io_uring.c Pavel Begunkov 2021-08-09  2938  	struct io_submit_state *state = &ctx->submit_state;
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2939  
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2940  	if (state->flush_cqes) {
79ebeaee8a21a0 fs/io_uring.c Jens Axboe     2021-08-10  2941  		spin_lock(&ctx->completion_lock);
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2942  		wq_list_for_each(node, prev, &state->compl_reqs) {
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2943  			struct io_kiocb *req = container_of(node, struct io_kiocb,
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2944  						    comp_list);
5182ed2e332e8e fs/io_uring.c Pavel Begunkov 2021-06-26  2945  
0e2e5c47fed68c fs/io_uring.c Stefan Roesch  2022-04-26  2946  			if (!(req->flags & REQ_F_CQE_SKIP)) {
0e2e5c47fed68c fs/io_uring.c Stefan Roesch  2022-04-26  2947  				if (!(ctx->flags & IORING_SETUP_CQE32))
90e7c35fb89154 fs/io_uring.c Pavel Begunkov 2022-04-12  2948  					__io_fill_cqe_req_filled(ctx, req);
0e2e5c47fed68c fs/io_uring.c Stefan Roesch  2022-04-26  2949  				else
0e2e5c47fed68c fs/io_uring.c Stefan Roesch  2022-04-26  2950  					__io_fill_cqe32_req_filled(ctx, req);
0e2e5c47fed68c fs/io_uring.c Stefan Roesch  2022-04-26  2951  			}
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2952  		}
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2953  
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2954  		io_commit_cqring(ctx);
79ebeaee8a21a0 fs/io_uring.c Jens Axboe     2021-08-10  2955  		spin_unlock(&ctx->completion_lock);
905c172f32c56f fs/io_uring.c Pavel Begunkov 2021-02-10  2956  		io_cqring_ev_posted(ctx);
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2957  		state->flush_cqes = false;
3d4aeb9f98058c fs/io_uring.c Pavel Begunkov 2021-11-10  2958  	}
5182ed2e332e8e fs/io_uring.c Pavel Begunkov 2021-06-26  2959  
1cce17aca621c3 fs/io_uring.c Pavel Begunkov 2021-09-24  2960  	io_free_batch_list(ctx, state->compl_reqs.first);
6f33b0bc4ea43f fs/io_uring.c Pavel Begunkov 2021-09-24  2961  	INIT_WQ_LIST(&state->compl_reqs);
7a743e225b2a9d fs/io_uring.c Pavel Begunkov 2020-03-03  2962  }
7a743e225b2a9d fs/io_uring.c Pavel Begunkov 2020-03-03  2963  

:::::: The code at line 2937 was first introduced by commit
:::::: 6f33b0bc4ea43f5c5ce7b7c9ab66051f80837862 io_uring: use slist for completion batching

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
