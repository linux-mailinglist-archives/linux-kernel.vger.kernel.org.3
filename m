Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F624F1F55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiDDWuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiDDWtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:49:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444A5EBD4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649109758; x=1680645758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f4bKop7Rq7P0wPLbvkUf65W9ddFoX3orAke3r8suEp8=;
  b=C0g0scDbZEBBtcfEmhyLFwexDKPke6ovDxx+8asygAPTeqCMGNvZ2gIC
   cE+R/SJo7ngVch53AmtPpzHg5G3wUBsgOnnlwrXuz39QExF8BU23oWE2v
   YMTara4Xv8rMyjfgxWZbXCj/adeND/7/wJ6UbalM+uDe11OZ2HdPrJ3iG
   vFa6jaQGDlOrMNvrPoTnJhhJgKQMCN2v4FHjJlDzjd0e5vsYu3UcqdPA1
   esc1KZOEq6e9MgMclz8EBw/nw8GKQ0fU6Y+H96Ns1kCMJuOtd2S4pYoWV
   KOKa0SaTza+pTZE+Kdg3JC0ZdFyB5V1M+LBOT6j0sq2lR1XIvuUe/k6vu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260605583"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="260605583"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 15:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523746911"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 15:02:35 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbUmR-0002ON-3k;
        Mon, 04 Apr 2022 22:02:35 +0000
Date:   Tue, 5 Apr 2022 06:02:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.4 9697/9999] include/linux/blk-mq.h:62:33:
 error: field 'kobj' has incomplete type
Message-ID: <202204050517.U9PdCKfa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   336570623f4c87024cb5937f243daba45774a0f0
commit: f990ca652d25eff602546c126a71b3810a21acee [9697/9999] block: don't merge across cgroup boundaries if blkcg is enabled
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220405/202204050517.U9PdCKfa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=f990ca652d25eff602546c126a71b3810a21acee
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.4
        git checkout f990ca652d25eff602546c126a71b3810a21acee
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/blk-cgroup.h:25,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
>> include/linux/blk-mq.h:62:33: error: field 'kobj' has incomplete type
      62 |         struct kobject          kobj;
         |                                 ^~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
   include/linux/blk-mq.h:352:29: error: invalid application of 'sizeof' to incomplete type 'struct request'
     352 |         return pdu - sizeof(struct request);
         |                             ^~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
   include/linux/blk-mq.h:356:19: error: invalid use of undefined type 'struct request'
     356 |         return rq + 1;
         |                   ^
   include/linux/blk-mq.h: In function 'request_to_qc_t':
   include/linux/blk-mq.h:370:15: error: invalid use of undefined type 'struct request'
     370 |         if (rq->tag != -1)
         |               ^~
   include/linux/blk-mq.h:371:26: error: invalid use of undefined type 'struct request'
     371 |                 return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
         |                          ^~
   include/linux/blk-mq.h:373:18: error: invalid use of undefined type 'struct request'
     373 |         return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
         |                  ^~
   include/linux/blk-mq.h: In function 'blk_mq_cleanup_rq':
   include/linux/blk-mq.h:379:15: error: invalid use of undefined type 'struct request'
     379 |         if (rq->q->mq_ops->cleanup_rq)
         |               ^~
   include/linux/blk-mq.h:380:19: error: invalid use of undefined type 'struct request'
     380 |                 rq->q->mq_ops->cleanup_rq(rq);
         |                   ^~
   make[2]: *** [scripts/Makefile.build:99: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1135: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:179: sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/kobj +62 include/linux/blk-mq.h

320ae51feed5c2 Jens Axboe        2013-10-24  11  
fe644072dfee06 Linus Walleij     2018-04-20  12  /**
fe644072dfee06 Linus Walleij     2018-04-20  13   * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware block device
fe644072dfee06 Linus Walleij     2018-04-20  14   */
320ae51feed5c2 Jens Axboe        2013-10-24  15  struct blk_mq_hw_ctx {
320ae51feed5c2 Jens Axboe        2013-10-24  16  	struct {
320ae51feed5c2 Jens Axboe        2013-10-24  17  		spinlock_t		lock;
320ae51feed5c2 Jens Axboe        2013-10-24  18  		struct list_head	dispatch;
8d354f133e86dd Jens Axboe        2016-08-25  19  		unsigned long		state;		/* BLK_MQ_S_* flags */
320ae51feed5c2 Jens Axboe        2013-10-24  20  	} ____cacheline_aligned_in_smp;
320ae51feed5c2 Jens Axboe        2013-10-24  21  
9f993737906b30 Jens Axboe        2017-04-10  22  	struct delayed_work	run_work;
e4043dcf30811f Jens Axboe        2014-04-09  23  	cpumask_var_t		cpumask;
506e931f92defd Jens Axboe        2014-05-07  24  	int			next_cpu;
506e931f92defd Jens Axboe        2014-05-07  25  	int			next_cpu_batch;
320ae51feed5c2 Jens Axboe        2013-10-24  26  
320ae51feed5c2 Jens Axboe        2013-10-24  27  	unsigned long		flags;		/* BLK_MQ_F_* flags */
320ae51feed5c2 Jens Axboe        2013-10-24  28  
bd166ef183c263 Jens Axboe        2017-01-17  29  	void			*sched_data;
320ae51feed5c2 Jens Axboe        2013-10-24  30  	struct request_queue	*queue;
f70ced09170761 Ming Lei          2014-09-25  31  	struct blk_flush_queue	*fq;
320ae51feed5c2 Jens Axboe        2013-10-24  32  
320ae51feed5c2 Jens Axboe        2013-10-24  33  	void			*driver_data;
320ae51feed5c2 Jens Axboe        2013-10-24  34  
88459642cba452 Omar Sandoval     2016-09-17  35  	struct sbitmap		ctx_map;
1429d7c9467e1e Jens Axboe        2014-05-19  36  
b347689ffbca74 Ming Lei          2017-10-14  37  	struct blk_mq_ctx	*dispatch_from;
6e768717304bdb Ming Lei          2018-07-03  38  	unsigned int		dispatch_busy;
b347689ffbca74 Ming Lei          2017-10-14  39  
f31967f0e455d0 Jens Axboe        2018-10-29  40  	unsigned short		type;
f31967f0e455d0 Jens Axboe        2018-10-29  41  	unsigned short		nr_ctx;
6e768717304bdb Ming Lei          2018-07-03  42  	struct blk_mq_ctx	**ctxs;
4bb659b156996f Jens Axboe        2014-05-09  43  
5815839b3ca16b Ming Lei          2018-06-25  44  	spinlock_t		dispatch_wait_lock;
ac6424b981bce1 Ingo Molnar       2017-06-20  45  	wait_queue_entry_t	dispatch_wait;
8537b12034cf1f Alexander Gordeev 2014-06-17  46  	atomic_t		wait_index;
320ae51feed5c2 Jens Axboe        2013-10-24  47  
320ae51feed5c2 Jens Axboe        2013-10-24  48  	struct blk_mq_tags	*tags;
bd166ef183c263 Jens Axboe        2017-01-17  49  	struct blk_mq_tags	*sched_tags;
320ae51feed5c2 Jens Axboe        2013-10-24  50  
320ae51feed5c2 Jens Axboe        2013-10-24  51  	unsigned long		queued;
320ae51feed5c2 Jens Axboe        2013-10-24  52  	unsigned long		run;
8d354f133e86dd Jens Axboe        2016-08-25  53  #define BLK_MQ_MAX_DISPATCH_ORDER	7
320ae51feed5c2 Jens Axboe        2013-10-24  54  	unsigned long		dispatched[BLK_MQ_MAX_DISPATCH_ORDER];
320ae51feed5c2 Jens Axboe        2013-10-24  55  
320ae51feed5c2 Jens Axboe        2013-10-24  56  	unsigned int		numa_node;
17ded320706c63 Jens Axboe        2015-01-07  57  	unsigned int		queue_num;
320ae51feed5c2 Jens Axboe        2013-10-24  58  
0d2602ca30e410 Jens Axboe        2014-05-13  59  	atomic_t		nr_active;
0d2602ca30e410 Jens Axboe        2014-05-13  60  
9467f85960a31d Thomas Gleixner   2016-09-22  61  	struct hlist_node	cpuhp_dead;
320ae51feed5c2 Jens Axboe        2013-10-24 @62  	struct kobject		kobj;
05229beeddf7e7 Jens Axboe        2015-11-05  63  
6e219353afa1f6 Stephen Bates     2016-09-13  64  	unsigned long		poll_considered;
05229beeddf7e7 Jens Axboe        2015-11-05  65  	unsigned long		poll_invoked;
05229beeddf7e7 Jens Axboe        2015-11-05  66  	unsigned long		poll_success;
9c1051aacde828 Omar Sandoval     2017-05-04  67  

:::::: The code at line 62 was first introduced by commit
:::::: 320ae51feed5c2f13664aa05a76bec198967e04d blk-mq: new multi-queue block IO queueing mechanism

:::::: TO: Jens Axboe <axboe@kernel.dk>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
