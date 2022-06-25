Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5655A7EC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiFYH4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiFYH4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 03:56:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1681E3EB85
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656143765; x=1687679765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kya31ugcsG/Sd+B9qv3nFD6CkBukP9KVMn6BK+fL/GM=;
  b=YEQAOc0QCZF+vYqGInC4FHlAeSWjNXfdyDuASzMVsf02sw7krIWoob1r
   0uYeZuHmm8MDFoJW9rj+u0VMg1DMV+Vm0Fme6XjSvoPYMKSiX8gpYkfmc
   nQcMbGbeStodlyd9c4HezaOGscxCw6RLMOLWL6z+V3/VI/XAMfmdeCCjW
   A1XKVWvNEujCOGWozlmN+CA06UZMXCVAyOWYlwqmBhAeGv7n9IzG/evkg
   x2kY4jNvt+UH/KfmdxvBqL2Mgri5yiLfSc+lQGV8lmym0nTzfXEveq+fJ
   NkCJAwzsYAJAOiscGcz6KoqNC58f8wIWcB2RLkIToFfXOJEO+INcRWS//
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="306630345"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="306630345"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 00:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="586842389"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 00:55:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o50e5-0005WT-G8;
        Sat, 25 Jun 2022 07:55:57 +0000
Date:   Sat, 25 Jun 2022 15:55:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: [asahilinux:bits/050-nvme 6/9] drivers/nvme/host/apple.c:291:19:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202206251551.PTd0wn6d-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   54dfe8ce63a23f4a11e9aa0481a09a6ec2267b2f
commit: 01cb5f6fdaf932ffa3f466b17a146e5784e19947 [6/9] nvme-apple: Add initial Apple SoC NVMe driver
config: openrisc-randconfig-s031-20220625
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/AsahiLinux/linux/commit/01cb5f6fdaf932ffa3f466b17a146e5784e19947
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout 01cb5f6fdaf932ffa3f466b17a146e5784e19947
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/apple.c:291:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] prp1 @@     got restricted __le64 [usertype] prp1 @@
   drivers/nvme/host/apple.c:291:19: sparse:     expected unsigned long long [usertype] prp1
   drivers/nvme/host/apple.c:291:19: sparse:     got restricted __le64 [usertype] prp1
>> drivers/nvme/host/apple.c:292:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] prp2 @@     got restricted __le64 [usertype] prp2 @@
   drivers/nvme/host/apple.c:292:19: sparse:     expected unsigned long long [usertype] prp2
   drivers/nvme/host/apple.c:292:19: sparse:     got restricted __le64 [usertype] prp2
>> drivers/nvme/host/apple.c:293:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __le16 [usertype] length @@
   drivers/nvme/host/apple.c:293:21: sparse:     expected unsigned int [usertype] length
   drivers/nvme/host/apple.c:293:21: sparse:     got restricted __le16 [usertype] length
>> drivers/nvme/host/apple.c:351:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] next_dma_addr @@     got restricted __le64 [usertype] @@
   drivers/nvme/host/apple.c:351:52: sparse:     expected unsigned int [usertype] next_dma_addr
   drivers/nvme/host/apple.c:351:52: sparse:     got restricted __le64 [usertype]
>> drivers/nvme/host/apple.c:456:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] @@     got unsigned int [addressable] [usertype] prp_dma @@
   drivers/nvme/host/apple.c:456:45: sparse:     expected restricted __le64 [usertype]
   drivers/nvme/host/apple.c:456:45: sparse:     got unsigned int [addressable] [usertype] prp_dma
>> drivers/nvme/host/apple.c:459:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] @@     got unsigned long long [assigned] [usertype] dma_addr @@
   drivers/nvme/host/apple.c:459:31: sparse:     expected restricted __le64 [usertype]
   drivers/nvme/host/apple.c:459:31: sparse:     got unsigned long long [assigned] [usertype] dma_addr
>> drivers/nvme/host/apple.c:474:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] prp1 @@     got unsigned int [usertype] dma_address @@
   drivers/nvme/host/apple.c:474:25: sparse:     expected restricted __le64 [usertype] prp1
   drivers/nvme/host/apple.c:474:25: sparse:     got unsigned int [usertype] dma_address
>> drivers/nvme/host/apple.c:475:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] prp2 @@     got unsigned int [usertype] first_dma @@
   drivers/nvme/host/apple.c:475:25: sparse:     expected restricted __le64 [usertype] prp2
   drivers/nvme/host/apple.c:475:25: sparse:     got unsigned int [usertype] first_dma
>> drivers/nvme/host/apple.c:501:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] prp1 @@     got unsigned int [usertype] first_dma @@
   drivers/nvme/host/apple.c:501:25: sparse:     expected restricted __le64 [usertype] prp1
   drivers/nvme/host/apple.c:501:25: sparse:     got unsigned int [usertype] first_dma
>> drivers/nvme/host/apple.c:503:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] prp2 @@     got unsigned int @@
   drivers/nvme/host/apple.c:503:33: sparse:     expected restricted __le64 [usertype] prp2
   drivers/nvme/host/apple.c:503:33: sparse:     got unsigned int
>> drivers/nvme/host/apple.c:685:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [assigned] [usertype] prp1 @@     got unsigned int [usertype] cq_dma_addr @@
   drivers/nvme/host/apple.c:685:26: sparse:     expected restricted __le64 [assigned] [usertype] prp1
   drivers/nvme/host/apple.c:685:26: sparse:     got unsigned int [usertype] cq_dma_addr
>> drivers/nvme/host/apple.c:686:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] cqid @@     got int @@
   drivers/nvme/host/apple.c:686:26: sparse:     expected restricted __le16 [assigned] [usertype] cqid
   drivers/nvme/host/apple.c:686:26: sparse:     got int
>> drivers/nvme/host/apple.c:687:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] qsize @@     got int @@
   drivers/nvme/host/apple.c:687:27: sparse:     expected restricted __le16 [assigned] [usertype] qsize
   drivers/nvme/host/apple.c:687:27: sparse:     got int
>> drivers/nvme/host/apple.c:688:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] cq_flags @@     got int @@
   drivers/nvme/host/apple.c:688:30: sparse:     expected restricted __le16 [assigned] [usertype] cq_flags
   drivers/nvme/host/apple.c:688:30: sparse:     got int
>> drivers/nvme/host/apple.c:699:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] qid @@     got int @@
   drivers/nvme/host/apple.c:699:28: sparse:     expected restricted __le16 [assigned] [usertype] qid
   drivers/nvme/host/apple.c:699:28: sparse:     got int
>> drivers/nvme/host/apple.c:713:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [assigned] [usertype] prp1 @@     got unsigned int [usertype] sq_dma_addr @@
   drivers/nvme/host/apple.c:713:26: sparse:     expected restricted __le64 [assigned] [usertype] prp1
   drivers/nvme/host/apple.c:713:26: sparse:     got unsigned int [usertype] sq_dma_addr
>> drivers/nvme/host/apple.c:714:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] sqid @@     got int @@
   drivers/nvme/host/apple.c:714:26: sparse:     expected restricted __le16 [assigned] [usertype] sqid
   drivers/nvme/host/apple.c:714:26: sparse:     got int
   drivers/nvme/host/apple.c:715:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] qsize @@     got int @@
   drivers/nvme/host/apple.c:715:27: sparse:     expected restricted __le16 [assigned] [usertype] qsize
   drivers/nvme/host/apple.c:715:27: sparse:     got int
>> drivers/nvme/host/apple.c:716:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] sq_flags @@     got int @@
   drivers/nvme/host/apple.c:716:30: sparse:     expected restricted __le16 [assigned] [usertype] sq_flags
   drivers/nvme/host/apple.c:716:30: sparse:     got int
   drivers/nvme/host/apple.c:717:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] cqid @@     got int @@
   drivers/nvme/host/apple.c:717:26: sparse:     expected restricted __le16 [assigned] [usertype] cqid
   drivers/nvme/host/apple.c:717:26: sparse:     got int
   drivers/nvme/host/apple.c:727:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] qid @@     got int @@
   drivers/nvme/host/apple.c:727:28: sparse:     expected restricted __le16 [assigned] [usertype] qid
   drivers/nvme/host/apple.c:727:28: sparse:     got int
>> drivers/nvme/host/apple.c:573:17: sparse: sparse: restricted __le16 degrades to integer

vim +291 drivers/nvme/host/apple.c

   282	
   283	static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
   284					  struct nvme_command *cmd)
   285	{
   286		struct apple_nvme *anv = queue_to_apple_nvme(q);
   287		u32 tag = nvme_tag_from_cid(cmd->common.command_id);
   288		struct apple_nvmmu_tcb *tcb = &q->tcbs[tag];
   289	
   290		tcb->opcode = cmd->common.opcode;
 > 291		tcb->prp1 = cmd->common.dptr.prp1;
 > 292		tcb->prp2 = cmd->common.dptr.prp2;
 > 293		tcb->length = cmd->rw.length;
   294		tcb->command_id = tag;
   295	
   296		if (nvme_is_write(cmd))
   297			tcb->dma_flags = APPLE_ANS_TCB_DMA_TO_DEVICE;
   298		else
   299			tcb->dma_flags = APPLE_ANS_TCB_DMA_FROM_DEVICE;
   300	
   301		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
   302	
   303		/*
   304		 * This lock here doesn't make much sense at a first glace but
   305		 * removing it will result in occasional missed completetion
   306		 * interrupts even though the commands still appear on the CQ.
   307		 * It's unclear why this happens but our best guess is that
   308		 * there is a bug in the firmware triggered when a new command
   309		 * is issued while we're inside the irq handler between the
   310		 * NVMMU invalidation (and making the tag available again)
   311		 * and the final CQ update.
   312		 */
   313		spin_lock_irq(&anv->lock);
   314		writel(tag, q->sq_db);
   315		spin_unlock_irq(&anv->lock);
   316	}
   317	
   318	/*
   319	 * From pci.c:
   320	 * Will slightly overestimate the number of pages needed.  This is OK
   321	 * as it only leads to a small amount of wasted memory for the lifetime of
   322	 * the I/O.
   323	 */
   324	static inline size_t apple_nvme_iod_alloc_size(void)
   325	{
   326		const unsigned int nprps = DIV_ROUND_UP(
   327			NVME_MAX_KB_SZ + NVME_CTRL_PAGE_SIZE, NVME_CTRL_PAGE_SIZE);
   328		const int npages = DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
   329		const size_t alloc_size = sizeof(__le64 *) * npages +
   330					  sizeof(struct scatterlist) * NVME_MAX_SEGS;
   331	
   332		return alloc_size;
   333	}
   334	
   335	static void **apple_nvme_iod_list(struct request *req)
   336	{
   337		struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
   338	
   339		return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
   340	}
   341	
   342	static void apple_nvme_free_prps(struct apple_nvme *anv, struct request *req)
   343	{
   344		const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
   345		struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
   346		dma_addr_t dma_addr = iod->first_dma;
   347		int i;
   348	
   349		for (i = 0; i < iod->npages; i++) {
   350			__le64 *prp_list = apple_nvme_iod_list(req)[i];
 > 351			dma_addr_t next_dma_addr = prp_list[last_prp];
   352	
   353			dma_pool_free(anv->prp_page_pool, prp_list, dma_addr);
   354			dma_addr = next_dma_addr;
   355		}
   356	}
   357	
   358	static void apple_nvme_unmap_data(struct apple_nvme *anv, struct request *req)
   359	{
   360		struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
   361	
   362		if (iod->dma_len) {
   363			dma_unmap_page(anv->dev, iod->first_dma, iod->dma_len,
   364				       rq_dma_dir(req));
   365			return;
   366		}
   367	
   368		WARN_ON_ONCE(!iod->nents);
   369	
   370		dma_unmap_sg(anv->dev, iod->sg, iod->nents, rq_dma_dir(req));
   371		if (iod->npages == 0)
   372			dma_pool_free(anv->prp_small_pool, apple_nvme_iod_list(req)[0],
   373				      iod->first_dma);
   374		else
   375			apple_nvme_free_prps(anv, req);
   376		mempool_free(iod->sg, anv->iod_mempool);
   377	}
   378	
   379	static void apple_nvme_print_sgl(struct scatterlist *sgl, int nents)
   380	{
   381		int i;
   382		struct scatterlist *sg;
   383	
   384		for_each_sg(sgl, sg, nents, i) {
   385			dma_addr_t phys = sg_phys(sg);
   386	
   387			pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d dma_address:%pad dma_length:%d\n",
   388				i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
   389				sg_dma_len(sg));
   390		}
   391	}
   392	
   393	static blk_status_t apple_nvme_setup_prps(struct apple_nvme *anv,
   394						  struct request *req,
   395						  struct nvme_rw_command *cmnd)
   396	{
   397		struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
   398		struct dma_pool *pool;
   399		int length = blk_rq_payload_bytes(req);
   400		struct scatterlist *sg = iod->sg;
   401		int dma_len = sg_dma_len(sg);
   402		u64 dma_addr = sg_dma_address(sg);
   403		int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
   404		__le64 *prp_list;
   405		void **list = apple_nvme_iod_list(req);
   406		dma_addr_t prp_dma;
   407		int nprps, i;
   408	
   409		length -= (NVME_CTRL_PAGE_SIZE - offset);
   410		if (length <= 0) {
   411			iod->first_dma = 0;
   412			goto done;
   413		}
   414	
   415		dma_len -= (NVME_CTRL_PAGE_SIZE - offset);
   416		if (dma_len) {
   417			dma_addr += (NVME_CTRL_PAGE_SIZE - offset);
   418		} else {
   419			sg = sg_next(sg);
   420			dma_addr = sg_dma_address(sg);
   421			dma_len = sg_dma_len(sg);
   422		}
   423	
   424		if (length <= NVME_CTRL_PAGE_SIZE) {
   425			iod->first_dma = dma_addr;
   426			goto done;
   427		}
   428	
   429		nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
   430		if (nprps <= (256 / 8)) {
   431			pool = anv->prp_small_pool;
   432			iod->npages = 0;
   433		} else {
   434			pool = anv->prp_page_pool;
   435			iod->npages = 1;
   436		}
   437	
   438		prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
   439		if (!prp_list) {
   440			iod->first_dma = dma_addr;
   441			iod->npages = -1;
   442			return BLK_STS_RESOURCE;
   443		}
   444		list[0] = prp_list;
   445		iod->first_dma = prp_dma;
   446		i = 0;
   447		for (;;) {
   448			if (i == NVME_CTRL_PAGE_SIZE >> 3) {
   449				__le64 *old_prp_list = prp_list;
   450	
   451				prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
   452				if (!prp_list)
   453					goto free_prps;
   454				list[iod->npages++] = prp_list;
   455				prp_list[0] = old_prp_list[i - 1];
 > 456				old_prp_list[i - 1] = prp_dma;
   457				i = 1;
   458			}
 > 459			prp_list[i++] = dma_addr;
   460			dma_len -= NVME_CTRL_PAGE_SIZE;
   461			dma_addr += NVME_CTRL_PAGE_SIZE;
   462			length -= NVME_CTRL_PAGE_SIZE;
   463			if (length <= 0)
   464				break;
   465			if (dma_len > 0)
   466				continue;
   467			if (unlikely(dma_len < 0))
   468				goto bad_sgl;
   469			sg = sg_next(sg);
   470			dma_addr = sg_dma_address(sg);
   471			dma_len = sg_dma_len(sg);
   472		}
   473	done:
 > 474		cmnd->dptr.prp1 = sg_dma_address(iod->sg);
 > 475		cmnd->dptr.prp2 = iod->first_dma;
   476		return BLK_STS_OK;
   477	free_prps:
   478		apple_nvme_free_prps(anv, req);
   479		return BLK_STS_RESOURCE;
   480	bad_sgl:
   481		WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
   482		     "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
   483		     iod->nents);
   484		return BLK_STS_IOERR;
   485	}
   486	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
