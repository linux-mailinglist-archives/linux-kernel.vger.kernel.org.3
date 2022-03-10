Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF64D3E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiCJA6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCJA6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:58:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E6B0C50
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646873826; x=1678409826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JcpHmwGFE2qI7hzwLXL7EP/3u2PJjU58F0ibQ3fKEvs=;
  b=SQHaIRsXHCBSsnsU3IX4ychDFrHFY1ppEUI0EdXQJP6VVOwWdiH6+Pfy
   SLOO/DyGyLa2wPWWWz/M88tx979qrJpBgQzMLcHaG8YEnBHi/trw7FlPk
   WgsSyFnPBe9dKFPmMalVQDT6o90cNoZmbdFCE9nM7bVRZGdvrApvCF/hu
   xuFdGsn2SiXHk5Y6ep1d13Jhyox0InFnQoiTzNFoCluUTtimCWRlAw0fA
   tpyhO92R67IDaup7yD3s0h4A7rs11roEZ4ev9u+23iHRy3BFdKjWG/Zz5
   zifFoCRop2rkZGMk0AnOb1zmK646v6GsH2zf+WClQOsvVDhNAmsOuqB86
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="237295713"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="237295713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="496054610"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2022 16:57:04 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS771-00045T-Ey; Thu, 10 Mar 2022 00:57:03 +0000
Date:   Thu, 10 Mar 2022 08:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: block/blk-mq.c:1241:9: sparse: sparse: cast from restricted
 req_flags_t
Message-ID: <202203100836.WQYjRe2U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 4054cff92c357813b6861b622122b344990f7e31 block: remove blk-exec.c
date:   3 months ago
config: mips-randconfig-s032-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100836.WQYjRe2U-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4054cff92c357813b6861b622122b344990f7e31
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4054cff92c357813b6861b622122b344990f7e31
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   block/blk-mq.c:1071:36: sparse: sparse: cast from restricted blk_status_t
   block/blk-mq.c:1164:17: sparse: sparse: cast to restricted blk_status_t
>> block/blk-mq.c:1241:9: sparse: sparse: cast from restricted req_flags_t

vim +1241 block/blk-mq.c

6fca6a611c27f1 Christoph Hellwig 2014-05-28  1230  
2b053aca76b48e Bart Van Assche   2016-10-28  1231  void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
2b053aca76b48e Bart Van Assche   2016-10-28  1232  				bool kick_requeue_list)
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1233  {
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1234  	struct request_queue *q = rq->q;
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1235  	unsigned long flags;
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1236  
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1237  	/*
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1238  	 * We abuse this flag that is otherwise used by the I/O scheduler to
ff821d271415f1 Jens Axboe        2017-11-10  1239  	 * request head insertion from the workqueue.
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1240  	 */
e806402130c9c4 Christoph Hellwig 2016-10-20 @1241  	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1242  
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1243  	spin_lock_irqsave(&q->requeue_lock, flags);
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1244  	if (at_head) {
e806402130c9c4 Christoph Hellwig 2016-10-20  1245  		rq->rq_flags |= RQF_SOFTBARRIER;
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1246  		list_add(&rq->queuelist, &q->requeue_list);
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1247  	} else {
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1248  		list_add_tail(&rq->queuelist, &q->requeue_list);
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1249  	}
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1250  	spin_unlock_irqrestore(&q->requeue_lock, flags);
2b053aca76b48e Bart Van Assche   2016-10-28  1251  
2b053aca76b48e Bart Van Assche   2016-10-28  1252  	if (kick_requeue_list)
2b053aca76b48e Bart Van Assche   2016-10-28  1253  		blk_mq_kick_requeue_list(q);
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1254  }
6fca6a611c27f1 Christoph Hellwig 2014-05-28  1255  

:::::: The code at line 1241 was first introduced by commit
:::::: e806402130c9c494e22c73ae9ead4e79d2a5811c block: split out request-only flags into a new namespace

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@fb.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
