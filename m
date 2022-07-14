Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36DB57417F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiGNCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiGNCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:42:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E62496A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657766521; x=1689302521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=htLOFGnemQAihGL9w2x61eJlWbf47zXdX5Dx4F8lH/U=;
  b=m7bsQEudDwZ+dY6etHObLiqkHc6h7RT3+1V9/9/mgdclpBG7f9Yp9XBS
   gEJULcaQdzH8vGgjhQxlnawBOgNnZEJoSOXdwU2uICLuhds4RFWCkA6xG
   /ZDQdWcR1zT8f8X8LE3gustluv7pFG5FM7IxMmo/1ltAEGL48b7RxGDdh
   aBYaZvk7Ha2CclEHnzcyv3e0mS8Z5BfQ6QRJTfpNeciw+vOxaB79r95kZ
   nk8i0P6OZk0PCBz+NsPF1m1kODfPh5EeD2XDoCX2e7PiuP4UNMYpext+s
   w9DJ0jzWKfpqSwsd9mPZRQnBW3V1Wb8DQe/BJWSF+FVPxo9OSLAr11NCG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="349366485"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="349366485"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="599968416"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2022 19:41:59 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBonZ-00004W-P4;
        Thu, 14 Jul 2022 02:41:53 +0000
Date:   Thu, 14 Jul 2022 10:41:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [bvanassche:block-bitwise-opf 38/64]
 drivers/nvme/target/zns.c:559:35: error: use of undeclared identifier 'op'
Message-ID: <202207141043.jpp94dQ8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   a18eedf7d10c719e2da2a802964f8aaade09e72c
commit: 5d612f7990f6438fe5d09c30560c0e25a1d292a2 [38/64] nvme/target: Use the new blk_opf_t type
config: hexagon-randconfig-r041-20220713 (https://download.01.org/0day-ci/archive/20220714/202207141043.jpp94dQ8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/5d612f7990f6438fe5d09c30560c0e25a1d292a2
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 5d612f7990f6438fe5d09c30560c0e25a1d292a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/target/zns.c:559:35: error: use of undeclared identifier 'op'
                            ARRAY_SIZE(req->inline_bvec), op);
                                                          ^
   drivers/nvme/target/zns.c:561:47: error: use of undeclared identifier 'op'
                   bio = bio_alloc(req->ns->bdev, req->sg_cnt, op, GFP_KERNEL);
                                                               ^
   2 errors generated.


vim +/op +559 drivers/nvme/target/zns.c

aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  524  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  525  void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  526  {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  527  	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
5d612f7990f643 Bart Van Assche    2022-06-17  528  	const blk_opf_t opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  529  	u16 status = NVME_SC_SUCCESS;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  530  	unsigned int total_len = 0;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  531  	struct scatterlist *sg;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  532  	struct bio *bio;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  533  	int sg_cnt;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  534  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  535  	/* Request is completed on len mismatch in nvmet_check_transter_len() */
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  536  	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  537  		return;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  538  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  539  	if (!req->sg_cnt) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  540  		nvmet_req_complete(req, 0);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  541  		return;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  542  	}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  543  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  544  	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  545  		req->error_loc = offsetof(struct nvme_rw_command, slba);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  546  		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  547  		goto out;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  548  	}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  549  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  550  	if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  551  		req->error_loc = offsetof(struct nvme_rw_command, slba);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  552  		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  553  		goto out;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  554  	}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  555  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  556  	if (nvmet_use_inline_bvec(req)) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  557  		bio = &req->z.inline_bio;
49add4966d7924 Christoph Hellwig  2022-01-24  558  		bio_init(bio, req->ns->bdev, req->inline_bvec,
49add4966d7924 Christoph Hellwig  2022-01-24 @559  			 ARRAY_SIZE(req->inline_bvec), op);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  560  	} else {
07888c665b405b Christoph Hellwig  2022-01-24  561  		bio = bio_alloc(req->ns->bdev, req->sg_cnt, op, GFP_KERNEL);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  562  	}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  563  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  564  	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  565  	bio->bi_iter.bi_sector = sect;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  566  	bio->bi_private = req;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  567  	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  568  		bio->bi_opf |= REQ_FUA;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  569  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  570  	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  571  		struct page *p = sg_page(sg);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  572  		unsigned int l = sg->length;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  573  		unsigned int o = sg->offset;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  574  		unsigned int ret;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  575  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  576  		ret = bio_add_zone_append_page(bio, p, l, o);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  577  		if (ret != sg->length) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  578  			status = NVME_SC_INTERNAL;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  579  			goto out_put_bio;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  580  		}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  581  		total_len += sg->length;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  582  	}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  583  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  584  	if (total_len != nvmet_rw_data_len(req)) {
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  585  		status = NVME_SC_INTERNAL | NVME_SC_DNR;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  586  		goto out_put_bio;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  587  	}
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  588  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  589  	submit_bio(bio);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  590  	return;
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  591  
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  592  out_put_bio:
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  593  	nvmet_req_bio_put(req, bio);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  594  out:
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  595  	nvmet_req_complete(req, status);
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  596  }
aaf2e048af2704 Chaitanya Kulkarni 2021-06-09  597  

:::::: The code at line 559 was first introduced by commit
:::::: 49add4966d79244013fce35f95c6833fae82b8b1 block: pass a block_device and opf to bio_init

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
