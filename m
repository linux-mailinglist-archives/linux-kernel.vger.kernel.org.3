Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81825767D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiGOTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGOTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:53:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F227DFB8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657914826; x=1689450826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0p4w331NloWks30o61+e4p1hx9ZVEQptU8+UIjJpx0k=;
  b=C7Wd3OOZeY4cF15kkK138iWbxKhQS8Q0TV8/86b8PFYR1jiPoRCQUjAl
   pRuSKUMN5nq5hm56AmcRiShF4/MzYIeICuGUn/uIxZLI7Em365hj3hGQ2
   Wtu8yGOagkljSj2JeLLzinY+mD0boCAHFu5zR03mBViHsLkDeJGUomGPm
   Y5p0rExOvJi6gLd32ZE8ZEMMRunAK4GP1UzWzfadReqcvYoixL3K6lzQ0
   0bSsmAiPtL2AkgWlOxGRQKPxqqOvzUGypaihcsiB9fHl20VDnJAsy61AB
   FmLzsurBU6gdwcXO+pKAxfKIVfwpvINmsBeTuRGrfdAwZT6XDoP7C0lwI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286624342"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="286624342"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="923635170"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 12:53:43 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCRNf-0000iC-9m;
        Fri, 15 Jul 2022 19:53:43 +0000
Date:   Sat, 16 Jul 2022 03:53:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 12/103]
 drivers/block/ublk_drv.c:831:6: warning: variable 'io' is used uninitialized
 whenever 'if' condition is true
Message-ID: <202207160356.xFEHFKfj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   dc2ebf038c4a21786283c56d67e3cfd995275771
commit: 71f28f3136aff5890cd56de78abc673f8393cad9 [12/103] ublk_drv: add io_uring based userspace block driver
config: hexagon-buildonly-randconfig-r001-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160356.xFEHFKfj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/71f28f3136aff5890cd56de78abc673f8393cad9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout 71f28f3136aff5890cd56de78abc673f8393cad9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/block/ublk_drv.c:831:6: warning: variable 'io' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (tag >= ubq->q_depth)
               ^~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:881:2: note: uninitialized use occurs here
           io->flags &= ~UBLK_IO_FLAG_ACTIVE;
           ^~
   drivers/block/ublk_drv.c:831:2: note: remove the 'if' if its condition is always false
           if (tag >= ubq->q_depth)
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:828:6: warning: variable 'io' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (ubq->ubq_daemon && ubq->ubq_daemon != current)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:881:2: note: uninitialized use occurs here
           io->flags &= ~UBLK_IO_FLAG_ACTIVE;
           ^~
   drivers/block/ublk_drv.c:828:2: note: remove the 'if' if its condition is always false
           if (ubq->ubq_daemon && ubq->ubq_daemon != current)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:825:6: warning: variable 'io' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!ubq || ub_cmd->q_id != ubq->q_id)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:881:2: note: uninitialized use occurs here
           io->flags &= ~UBLK_IO_FLAG_ACTIVE;
           ^~
   drivers/block/ublk_drv.c:825:2: note: remove the 'if' if its condition is always false
           if (!ubq || ub_cmd->q_id != ubq->q_id)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/block/ublk_drv.c:825:6: warning: variable 'io' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!ubq || ub_cmd->q_id != ubq->q_id)
               ^~~~
   drivers/block/ublk_drv.c:881:2: note: uninitialized use occurs here
           io->flags &= ~UBLK_IO_FLAG_ACTIVE;
           ^~
   drivers/block/ublk_drv.c:825:6: note: remove the '||' if its condition is always false
           if (!ubq || ub_cmd->q_id != ubq->q_id)
               ^~~~~~~
   drivers/block/ublk_drv.c:821:6: warning: variable 'io' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:881:2: note: uninitialized use occurs here
           io->flags &= ~UBLK_IO_FLAG_ACTIVE;
           ^~
   drivers/block/ublk_drv.c:821:2: note: remove the 'if' if its condition is always false
           if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:818:6: warning: variable 'io' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!(issue_flags & IO_URING_F_SQE128))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:881:2: note: uninitialized use occurs here
           io->flags &= ~UBLK_IO_FLAG_ACTIVE;
           ^~
   drivers/block/ublk_drv.c:818:2: note: remove the 'if' if its condition is always false
           if (!(issue_flags & IO_URING_F_SQE128))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/ublk_drv.c:809:20: note: initialize the variable 'io' to silence this warning
           struct ublk_io *io;
                             ^
                              = NULL
>> drivers/block/ublk_drv.c:1237:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!ub)
               ^~~
   drivers/block/ublk_drv.c:1263:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/block/ublk_drv.c:1237:2: note: remove the 'if' if its condition is always false
           if (!ub)
           ^~~~~~~~
   drivers/block/ublk_drv.c:1234:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   7 warnings generated.


vim +831 drivers/block/ublk_drv.c

   803	
   804	static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
   805	{
   806		struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
   807		struct ublk_device *ub = cmd->file->private_data;
   808		struct ublk_queue *ubq;
   809		struct ublk_io *io;
   810		u32 cmd_op = cmd->cmd_op;
   811		unsigned tag = ub_cmd->tag;
   812		int ret = -EINVAL;
   813	
   814		pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
   815				__func__, cmd->cmd_op, ub_cmd->q_id, tag,
   816				ub_cmd->result);
   817	
   818		if (!(issue_flags & IO_URING_F_SQE128))
   819			goto out;
   820	
   821		if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
   822			goto out;
   823	
   824		ubq = ublk_get_queue(ub, ub_cmd->q_id);
 > 825		if (!ubq || ub_cmd->q_id != ubq->q_id)
   826			goto out;
   827	
   828		if (ubq->ubq_daemon && ubq->ubq_daemon != current)
   829			goto out;
   830	
 > 831		if (tag >= ubq->q_depth)
   832			goto out;
   833	
   834		io = &ubq->ios[tag];
   835	
   836		/* there is pending io cmd, something must be wrong */
   837		if (io->flags & UBLK_IO_FLAG_ACTIVE) {
   838			ret = -EBUSY;
   839			goto out;
   840		}
   841	
   842		switch (cmd_op) {
   843		case UBLK_IO_FETCH_REQ:
   844			/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
   845			if (ublk_queue_ready(ubq)) {
   846				ret = -EBUSY;
   847				goto out;
   848			}
   849			/*
   850			 * The io is being handled by server, so COMMIT_RQ is expected
   851			 * instead of FETCH_REQ
   852			 */
   853			if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
   854				goto out;
   855			/* FETCH_RQ has to provide IO buffer */
   856			if (!ub_cmd->addr)
   857				goto out;
   858			io->cmd = cmd;
   859			io->flags |= UBLK_IO_FLAG_ACTIVE;
   860			io->addr = ub_cmd->addr;
   861	
   862			ublk_mark_io_ready(ub, ubq);
   863			break;
   864		case UBLK_IO_COMMIT_AND_FETCH_REQ:
   865			/* FETCH_RQ has to provide IO buffer */
   866			if (!ub_cmd->addr)
   867				goto out;
   868			if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
   869				goto out;
   870			io->addr = ub_cmd->addr;
   871			io->flags |= UBLK_IO_FLAG_ACTIVE;
   872			io->cmd = cmd;
   873			ublk_commit_completion(ub, ub_cmd);
   874			break;
   875		default:
   876			goto out;
   877		}
   878		return -EIOCBQUEUED;
   879	
   880	 out:
   881		io->flags &= ~UBLK_IO_FLAG_ACTIVE;
   882		io_uring_cmd_done(cmd, ret, 0);
   883		pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
   884				__func__, cmd_op, tag, ret, io->flags);
   885		return -EIOCBQUEUED;
   886	}
   887	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
