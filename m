Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8030057682B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiGOUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiGOUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:34:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB187C1B9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657917287; x=1689453287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nJ0M24idHS5m1j/vi9GIalitdhanFbxupBn5I356qP8=;
  b=IYjf9O7WNygOS0NQmRPfdPlCAHt5OpSOhyEtvsPGSFhD3FNvuNJGscSd
   PlsbXZGePB9fk279IqJthxiFnC83BpoYGoy0frmOPBvBUlgxovA9VMhyq
   1zrVURZtpKVls7ffOQnP2Uf9Omo9rbIppPQAJ3K472CUV9otYHB2cmP/C
   WWnyIELRpzXcOwqd0nIsuHd7PZgAzzsrsaxbLOTH0k0XYTkR5/wFWh4Oc
   wqrYSCd4q654toLs54+gDRYqOsDZb1WWyp1pVi2E1hVg/1Kwy53BALgrA
   +4EE66fV6+9VkOD/T5QjGGjmm6VY1AJ5d9w50aNagTW5pVPlSbFcQJqWh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266307259"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="266307259"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 13:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="571666001"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 13:34:44 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCS1M-0000k8-8F;
        Fri, 15 Jul 2022 20:34:44 +0000
Date:   Sat, 16 Jul 2022 04:34:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 12/108]
 drivers/block/ublk_drv.c:417:24: sparse: sparse: incorrect type in return
 expression (different base types)
Message-ID: <202207160409.lm5WvURw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   dc2ebf038c4a21786283c56d67e3cfd995275771
commit: 71f28f3136aff5890cd56de78abc673f8393cad9 [12/108] ublk_drv: add io_uring based userspace block driver
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220716/202207160409.lm5WvURw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/71f28f3136aff5890cd56de78abc673f8393cad9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout 71f28f3136aff5890cd56de78abc673f8393cad9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/block/ublk_drv.c:417:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted blk_status_t [usertype] @@
   drivers/block/ublk_drv.c:417:24: sparse:     expected int
   drivers/block/ublk_drv.c:417:24: sparse:     got restricted blk_status_t [usertype]
>> drivers/block/ublk_drv.c:570:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted blk_status_t [usertype] res @@     got int @@
   drivers/block/ublk_drv.c:570:13: sparse:     expected restricted blk_status_t [usertype] res
   drivers/block/ublk_drv.c:570:13: sparse:     got int

vim +417 drivers/block/ublk_drv.c

   393	
   394	static int ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
   395	{
   396		struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
   397		struct ublk_io *io = &ubq->ios[req->tag];
   398		u32 ublk_op;
   399	
   400		switch (req_op(req)) {
   401		case REQ_OP_READ:
   402			ublk_op = UBLK_IO_OP_READ;
   403			break;
   404		case REQ_OP_WRITE:
   405			ublk_op = UBLK_IO_OP_WRITE;
   406			break;
   407		case REQ_OP_FLUSH:
   408			ublk_op = UBLK_IO_OP_FLUSH;
   409			break;
   410		case REQ_OP_DISCARD:
   411			ublk_op = UBLK_IO_OP_DISCARD;
   412			break;
   413		case REQ_OP_WRITE_ZEROES:
   414			ublk_op = UBLK_IO_OP_WRITE_ZEROES;
   415			break;
   416		default:
 > 417			return BLK_STS_IOERR;
   418		}
   419	
   420		/* need to translate since kernel may change */
   421		iod->op_flags = ublk_op | ublk_req_build_flags(req);
   422		iod->nr_sectors = blk_rq_sectors(req);
   423		iod->start_sector = blk_rq_pos(req);
   424		iod->addr = io->addr;
   425	
   426		return BLK_STS_OK;
   427	}
   428	
   429	static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
   430			struct io_uring_cmd *ioucmd)
   431	{
   432		return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
   433	}
   434	
   435	static bool ubq_daemon_is_dying(struct ublk_queue *ubq)
   436	{
   437		return ubq->ubq_daemon->flags & PF_EXITING;
   438	}
   439	
   440	/* todo: handle partial completion */
   441	static void ublk_complete_rq(struct request *req)
   442	{
   443		struct ublk_queue *ubq = req->mq_hctx->driver_data;
   444		struct ublk_io *io = &ubq->ios[req->tag];
   445		unsigned int unmapped_bytes;
   446	
   447		/* failed read IO if nothing is read */
   448		if (!io->res && req_op(req) == REQ_OP_READ)
   449			io->res = -EIO;
   450	
   451		if (io->res < 0) {
   452			blk_mq_end_request(req, errno_to_blk_status(io->res));
   453			return;
   454		}
   455	
   456		/*
   457		 * FLUSH or DISCARD usually won't return bytes returned, so end them
   458		 * directly.
   459		 *
   460		 * Both the two needn't unmap.
   461		 */
   462		if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE) {
   463			blk_mq_end_request(req, BLK_STS_OK);
   464			return;
   465		}
   466	
   467		/* for READ request, writing data in iod->addr to rq buffers */
   468		unmapped_bytes = ublk_unmap_io(ubq, req, io);
   469	
   470		/*
   471		 * Extremely impossible since we got data filled in just before
   472		 *
   473		 * Re-read simply for this unlikely case.
   474		 */
   475		if (unlikely(unmapped_bytes < io->res))
   476			io->res = unmapped_bytes;
   477	
   478		if (blk_update_request(req, BLK_STS_OK, io->res))
   479			blk_mq_requeue_request(req, true);
   480		else
   481			__blk_mq_end_request(req, BLK_STS_OK);
   482	}
   483	
   484	/*
   485	 * __ublk_fail_req() may be called from abort context or ->ubq_daemon
   486	 * context during exiting, so lock is required.
   487	 *
   488	 * Also aborting may not be started yet, keep in mind that one failed
   489	 * request may be issued by block layer again.
   490	 */
   491	static void __ublk_fail_req(struct ublk_io *io, struct request *req)
   492	{
   493		WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
   494	
   495		if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
   496			io->flags |= UBLK_IO_FLAG_ABORTED;
   497			blk_mq_end_request(req, BLK_STS_IOERR);
   498		}
   499	}
   500	
   501	#define UBLK_REQUEUE_DELAY_MS	3
   502	
   503	static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
   504	{
   505		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
   506		struct ublk_device *ub = cmd->file->private_data;
   507		struct request *req = pdu->req;
   508		struct ublk_queue *ubq = req->mq_hctx->driver_data;
   509		int tag = req->tag;
   510		struct ublk_io *io = &ubq->ios[tag];
   511		bool task_exiting = current != ubq->ubq_daemon ||
   512			(current->flags & PF_EXITING);
   513		unsigned int mapped_bytes;
   514	
   515		pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
   516				__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
   517				ublk_get_iod(ubq, req->tag)->addr);
   518	
   519		if (unlikely(task_exiting)) {
   520			blk_mq_end_request(req, BLK_STS_IOERR);
   521			mod_delayed_work(system_wq, &ub->monitor_work, 0);
   522			return;
   523		}
   524	
   525		mapped_bytes = ublk_map_io(ubq, req, io);
   526	
   527		/* partially mapped, update io descriptor */
   528		if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
   529			/*
   530			 * Nothing mapped, retry until we succeed.
   531			 *
   532			 * We may never succeed in mapping any bytes here because
   533			 * of OOM. TODO: reserve one buffer with single page pinned
   534			 * for providing forward progress guarantee.
   535			 */
   536			if (unlikely(!mapped_bytes)) {
   537				blk_mq_requeue_request(req, false);
   538				blk_mq_delay_kick_requeue_list(req->q,
   539						UBLK_REQUEUE_DELAY_MS);
   540				return;
   541			}
   542	
   543			ublk_get_iod(ubq, req->tag)->nr_sectors =
   544				mapped_bytes >> 9;
   545		}
   546	
   547		/* mark this cmd owned by ublksrv */
   548		io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
   549	
   550		/*
   551		 * clear ACTIVE since we are done with this sqe/cmd slot
   552		 * We can only accept io cmd in case of being not active.
   553		 */
   554		io->flags &= ~UBLK_IO_FLAG_ACTIVE;
   555	
   556		/* tell ublksrv one io request is coming */
   557		io_uring_cmd_done(io->cmd, UBLK_IO_RES_OK, 0);
   558	}
   559	
   560	static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
   561			const struct blk_mq_queue_data *bd)
   562	{
   563		struct ublk_queue *ubq = hctx->driver_data;
   564		struct request *rq = bd->rq;
   565		struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
   566		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
   567		blk_status_t res;
   568	
   569		/* fill iod to slot in io cmd buffer */
 > 570		res = ublk_setup_iod(ubq, rq);
   571		if (unlikely(res != BLK_STS_OK))
   572			return BLK_STS_IOERR;
   573	
   574		blk_mq_start_request(bd->rq);
   575	
   576		if (unlikely(ubq_daemon_is_dying(ubq))) {
   577			mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
   578			return BLK_STS_IOERR;
   579		}
   580	
   581		pdu->req = rq;
   582		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
   583	
   584		return BLK_STS_OK;
   585	}
   586	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
