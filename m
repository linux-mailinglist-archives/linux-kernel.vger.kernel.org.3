Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EFC470E7F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbhLJXX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:23:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:2168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239950AbhLJXX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639178423; x=1670714423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zvbvzcHFxGuLxcM1P61fXcsCn8Cuj9yD9A3o0f3rRRg=;
  b=FSaG/FL3cAFG2HpZ+U4IIGNyMWuQIRddufkUobZPavOdXmEeYq9tzx3A
   xAR4wpHpBu1svhFaz9RXR6Ntgi4QBnEcIfTcaJ9NDPix3EwiTeZu2kley
   SaWn2oGioYMk/4aVclK4oLD9MEFNW5/xZIiO9gYQtxgzJbsOeCh+hhbrH
   ql/U1Y1hjTsbi9j6kUHHXXlwZnn+PeFiGfa1qJF4VMXZF9Sq+7suO1Qfy
   rM7E1G+hC0bMl8aAi0jr06z8YUuzqherp0oe0rEe52iZIxCwEG0ztPst/
   MRJ56rEZvVBWXWlaUfYPTM+/gcZMQBK/ABPTDz+VensApquR1RONDzb3M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238281399"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238281399"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="480897493"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2021 15:20:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvpBc-0003nF-KO; Fri, 10 Dec 2021 23:20:20 +0000
Date:   Sat, 11 Dec 2021 07:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [axboe-block:for-5.17/drivers 77/78]
 drivers/block/null_blk/main.c:1577:55: sparse: sparse: incorrect type in
 argument 3 (different base types)
Message-ID: <202112110756.lMQBZRW5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.17/drivers
head:   db67097aa6f2587b44055f2e16db72a11e17faef
commit: 2385ebf38f94d4f7761b1e9a4973d04753da02c2 [77/78] block: null_blk: batched complete poll requests
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20211211/202112110756.lMQBZRW5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=2385ebf38f94d4f7761b1e9a4973d04753da02c2
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.17/drivers
        git checkout 2385ebf38f94d4f7761b1e9a4973d04753da02c2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/block/null_blk/main.c:1577:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int ioerror @@     got restricted blk_status_t [usertype] error @@
   drivers/block/null_blk/main.c:1577:55: sparse:     expected int ioerror
   drivers/block/null_blk/main.c:1577:55: sparse:     got restricted blk_status_t [usertype] error

vim +1577 drivers/block/null_blk/main.c

  1557	
  1558	static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
  1559	{
  1560		struct nullb_queue *nq = hctx->driver_data;
  1561		LIST_HEAD(list);
  1562		int nr = 0;
  1563	
  1564		spin_lock(&nq->poll_lock);
  1565		list_splice_init(&nq->poll_list, &list);
  1566		spin_unlock(&nq->poll_lock);
  1567	
  1568		while (!list_empty(&list)) {
  1569			struct nullb_cmd *cmd;
  1570			struct request *req;
  1571	
  1572			req = list_first_entry(&list, struct request, queuelist);
  1573			list_del_init(&req->queuelist);
  1574			cmd = blk_mq_rq_to_pdu(req);
  1575			cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
  1576							blk_rq_sectors(req));
> 1577			if (!blk_mq_add_to_batch(req, iob, cmd->error,
  1578						blk_mq_end_request_batch))
  1579				end_cmd(cmd);
  1580			nr++;
  1581		}
  1582	
  1583		return nr;
  1584	}
  1585	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
