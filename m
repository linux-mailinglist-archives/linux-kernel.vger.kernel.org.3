Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F0A581EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiG0Eby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiG0Ebw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:31:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925023B960
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658896309; x=1690432309;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MPLetgUkdxZGYEdy5Oe+aGCJFgFu03LZ44fkIcokPsA=;
  b=M24HPA2xDSNNFDQPEH4cPP5wMknpyuFqC4ZU9t/cILfXhBmdHY9yidDr
   /OEdDlIwpPxVPcSHIVoYGl92+iqXp2HvCHG8I/qcx6vNKvJMiTHErzBAP
   OwdDRGGfR7ZBkoXPG1J5k9qH6/Xetdsqs5+axtXm7W1C2ckMtcWCRv18m
   oW9tYS0FtexHek5/LGMGwJqGHUrDmHZnsNnqbAYE6IBAndYbYAWshiHld
   lVDPRm09ZQPaiR9yBwAXRfZJZbh0eey0HP+WZKsh92lcRNsDFmIx93MNE
   J47gDSlsutRpwxq82sAuwn93JeVkdPneTNoN5wwc/jueICr84feuqx/ED
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="271181178"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="271181178"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 21:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="927638092"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2022 21:31:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGYi2-0008Jy-3B;
        Wed, 27 Jul 2022 04:31:46 +0000
Date:   Wed, 27 Jul 2022 12:31:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [axboe-block:for-5.20/io_uring-zerocopy-send 23/23]
 io_uring/notif.c:52:23: error: implicit declaration of function
 'io_alloc_req_refill'; did you mean 'io_rsrc_refs_refill'?
Message-ID: <202207271204.TWHjABcr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring-zerocopy-send
head:   fbe6f6bc3210e853aab74f20da776c15c5b052fe
commit: fbe6f6bc3210e853aab74f20da776c15c5b052fe [23/23] io_uring/zc: notification completion optimisation
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220727/202207271204.TWHjABcr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=fbe6f6bc3210e853aab74f20da776c15c5b052fe
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.20/io_uring-zerocopy-send
        git checkout fbe6f6bc3210e853aab74f20da776c15c5b052fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/export.h:33,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from io_uring/notif.c:1:
   io_uring/notif.c: In function 'io_alloc_notif':
>> io_uring/notif.c:52:23: error: implicit declaration of function 'io_alloc_req_refill'; did you mean 'io_rsrc_refs_refill'? [-Werror=implicit-function-declaration]
      52 |         if (unlikely(!io_alloc_req_refill(ctx)))
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> io_uring/notif.c:54:17: error: implicit declaration of function 'io_alloc_req'; did you mean 'xa_alloc_irq'? [-Werror=implicit-function-declaration]
      54 |         notif = io_alloc_req(ctx);
         |                 ^~~~~~~~~~~~
         |                 xa_alloc_irq
>> io_uring/notif.c:54:15: warning: assignment to 'struct io_kiocb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      54 |         notif = io_alloc_req(ctx);
         |               ^
   cc1: some warnings being treated as errors


vim +52 io_uring/notif.c

   > 1	#include <linux/kernel.h>
     2	#include <linux/errno.h>
     3	#include <linux/file.h>
     4	#include <linux/slab.h>
     5	#include <linux/net.h>
     6	#include <linux/io_uring.h>
     7	
     8	#include "io_uring.h"
     9	#include "notif.h"
    10	#include "rsrc.h"
    11	
    12	static void __io_notif_complete_tw(struct io_kiocb *notif, bool *locked)
    13	{
    14		struct io_notif_data *nd = io_notif_to_data(notif);
    15		struct io_ring_ctx *ctx = notif->ctx;
    16	
    17		if (nd->account_pages && ctx->user) {
    18			__io_unaccount_mem(ctx->user, nd->account_pages);
    19			nd->account_pages = 0;
    20		}
    21		io_req_task_complete(notif, locked);
    22	}
    23	
    24	static inline void io_notif_complete(struct io_kiocb *notif)
    25		__must_hold(&notif->ctx->uring_lock)
    26	{
    27		bool locked = true;
    28	
    29		__io_notif_complete_tw(notif, &locked);
    30	}
    31	
    32	static void io_uring_tx_zerocopy_callback(struct sk_buff *skb,
    33						  struct ubuf_info *uarg,
    34						  bool success)
    35	{
    36		struct io_notif_data *nd = container_of(uarg, struct io_notif_data, uarg);
    37		struct io_kiocb *notif = cmd_to_io_kiocb(nd);
    38	
    39		if (refcount_dec_and_test(&uarg->refcnt)) {
    40			notif->io_task_work.func = __io_notif_complete_tw;
    41			io_req_task_work_add(notif);
    42		}
    43	}
    44	
    45	struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx,
    46					struct io_notif_slot *slot)
    47		__must_hold(&ctx->uring_lock)
    48	{
    49		struct io_kiocb *notif;
    50		struct io_notif_data *nd;
    51	
  > 52		if (unlikely(!io_alloc_req_refill(ctx)))
    53			return NULL;
  > 54		notif = io_alloc_req(ctx);
    55		notif->opcode = IORING_OP_NOP;
    56		notif->flags = 0;
    57		notif->file = NULL;
    58		notif->task = current;
    59		io_get_task_refs(1);
    60		notif->rsrc_node = NULL;
    61		io_req_set_rsrc_node(notif, ctx, 0);
    62		notif->cqe.user_data = slot->tag;
    63		notif->cqe.flags = slot->seq++;
    64		notif->cqe.res = 0;
    65	
    66		nd = io_notif_to_data(notif);
    67		nd->account_pages = 0;
    68		nd->uarg.flags = SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
    69		nd->uarg.callback = io_uring_tx_zerocopy_callback;
    70		/* master ref owned by io_notif_slot, will be dropped on flush */
    71		refcount_set(&nd->uarg.refcnt, 1);
    72		return notif;
    73	}
    74	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
