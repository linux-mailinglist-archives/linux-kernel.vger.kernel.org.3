Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E157413D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiGNCFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiGNCE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:04:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030EDFD0D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657764296; x=1689300296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wKXE+tKB8Oc/YSpSDtXNzjGi4vRHirxTYfnydokcET8=;
  b=HBmnbWrDimE8t7lWET/5BWrBob9EmE4XD2nDk2R+L93vZWmOO8Mmbyo/
   aOHmsGtv9kkSNyueVr4bm5KMnhKsMPfcqeb0ZTVUcZYBn20K6mo4nxbkI
   JwUuHb3Y/mNH9DPTwI6RTdKAFkgGo/KuBUDiepOpJ7akev2xlNnzMTP6O
   tntVKXj1r8REYCxU1iGVOSjCZvMkpbUMmOhOuLtRnRZevr+142MiS2m87
   hM90SJtwEBF1b6ZFazdy4qZb5bvTqfkYDRZHvZ62CqYi6+Gswce2U3USI
   YL70ETZRFphn7kwVDNxLpkhE5ThwpCDd/QIqoVp+l8klT+6pw3PIDFsNl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286134996"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="286134996"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="628530837"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2022 19:04:53 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBoDk-000034-FF;
        Thu, 14 Jul 2022 02:04:52 +0000
Date:   Thu, 14 Jul 2022 10:04:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [bvanassche:block-bitwise-opf 38/64]
 drivers/nvme/target/io-cmd-bdev.c:310:6: error: use of undeclared identifier
 'op'
Message-ID: <202207140939.IrQaDqbX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   a18eedf7d10c719e2da2a802964f8aaade09e72c
commit: 5d612f7990f6438fe5d09c30560c0e25a1d292a2 [38/64] nvme/target: Use the new blk_opf_t type
config: riscv-randconfig-r042-20220713 (https://download.01.org/0day-ci/archive/20220714/202207140939.IrQaDqbX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/bvanassche/linux/commit/5d612f7990f6438fe5d09c30560c0e25a1d292a2
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 5d612f7990f6438fe5d09c30560c0e25a1d292a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/target/io-cmd-bdev.c:310:6: error: use of undeclared identifier 'op'
                                           op, GFP_KERNEL);
                                           ^
   1 error generated.


vim +/op +310 drivers/nvme/target/io-cmd-bdev.c

c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  241  
d5eff33ee6f808 drivers/nvme/target/io-cmd-bdev.c Chaitanya Kulkarni      2018-05-23  242  static void nvmet_bdev_execute_rw(struct nvmet_req *req)
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  243  {
5f7136db829960 drivers/nvme/target/io-cmd-bdev.c Matthew Wilcox (Oracle  2021-01-29  244) 	unsigned int sg_cnt = req->sg_cnt;
73383adfad245b drivers/nvme/target/io-cmd-bdev.c Sagi Grimberg           2018-09-28  245  	struct bio *bio;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  246  	struct scatterlist *sg;
9dea0c81ee4a7b drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2019-10-28  247  	struct blk_plug plug;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  248  	sector_t sector;
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  249  	blk_opf_t opf;
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  250  	int i, rc;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  251  	struct sg_mapping_iter prot_miter;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  252  	unsigned int iter_flags;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  253  	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  254  
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  255  	if (!nvmet_check_transfer_len(req, total_len))
e9061c397839ee drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2019-10-23  256  		return;
e9061c397839ee drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2019-10-23  257  
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  258  	if (!req->sg_cnt) {
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  259  		nvmet_req_complete(req, 0);
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  260  		return;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  261  	}
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  262  
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  263  	if (req->cmd->rw.opcode == nvme_cmd_write) {
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  264  		opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  265  		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  266  			opf |= REQ_FUA;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  267  		iter_flags = SG_MITER_TO_SG;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  268  	} else {
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  269  		opf = REQ_OP_READ;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  270  		iter_flags = SG_MITER_FROM_SG;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  271  	}
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  272  
c6925093d0b283 drivers/nvme/target/io-cmd-bdev.c Logan Gunthorpe         2018-10-04  273  	if (is_pci_p2pdma_page(sg_page(req->sg)))
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  274  		opf |= REQ_NOMERGE;
c6925093d0b283 drivers/nvme/target/io-cmd-bdev.c Logan Gunthorpe         2018-10-04  275  
193fcf371f9e37 drivers/nvme/target/io-cmd-bdev.c Chaitanya Kulkarni      2021-01-11  276  	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  277  
608a969046e6e0 drivers/nvme/target/io-cmd-bdev.c Chaitanya Kulkarni      2021-05-06  278  	if (nvmet_use_inline_bvec(req)) {
73383adfad245b drivers/nvme/target/io-cmd-bdev.c Sagi Grimberg           2018-09-28  279  		bio = &req->b.inline_bio;
49add4966d7924 drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2022-01-24  280  		bio_init(bio, req->ns->bdev, req->inline_bvec,
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  281  			 ARRAY_SIZE(req->inline_bvec), opf);
73383adfad245b drivers/nvme/target/io-cmd-bdev.c Sagi Grimberg           2018-09-28  282  	} else {
5d612f7990f643 drivers/nvme/target/io-cmd-bdev.c Bart Van Assche         2022-06-17  283  		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
07888c665b405b drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2022-01-24  284  				GFP_KERNEL);
73383adfad245b drivers/nvme/target/io-cmd-bdev.c Sagi Grimberg           2018-09-28  285  	}
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  286  	bio->bi_iter.bi_sector = sector;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  287  	bio->bi_private = req;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  288  	bio->bi_end_io = nvmet_bio_done;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  289  
9dea0c81ee4a7b drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2019-10-28  290  	blk_start_plug(&plug);
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  291  	if (req->metadata_len)
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  292  		sg_miter_start(&prot_miter, req->metadata_sg,
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  293  			       req->metadata_sg_cnt, iter_flags);
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  294  
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  295  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  296  		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  297  				!= sg->length) {
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  298  			struct bio *prev = bio;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  299  
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  300  			if (req->metadata_len) {
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  301  				rc = nvmet_bdev_alloc_bip(req, bio,
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  302  							  &prot_miter);
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  303  				if (unlikely(rc)) {
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  304  					bio_io_error(bio);
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  305  					return;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  306  				}
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  307  			}
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  308  
07888c665b405b drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2022-01-24  309  			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
07888c665b405b drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2022-01-24 @310  					op, GFP_KERNEL);
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  311  			bio->bi_iter.bi_sector = sector;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  312  
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  313  			bio_chain(bio, prev);
c2f30f08c115a6 drivers/nvme/target/io-cmd.c      Max Gurtovoy            2017-07-10  314  			submit_bio(prev);
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  315  		}
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  316  
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  317  		sector += sg->length >> 9;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  318  		sg_cnt--;
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  319  	}
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  320  
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  321  	if (req->metadata_len) {
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  322  		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  323  		if (unlikely(rc)) {
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  324  			bio_io_error(bio);
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  325  			return;
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  326  		}
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  327  	}
c6e3f13398123a drivers/nvme/target/io-cmd-bdev.c Israel Rukshin          2020-05-19  328  
16d3a280d4d73e drivers/nvme/target/io-cmd-bdev.c Sagi Grimberg           2018-12-12  329  	submit_bio(bio);
9dea0c81ee4a7b drivers/nvme/target/io-cmd-bdev.c Christoph Hellwig       2019-10-28  330  	blk_finish_plug(&plug);
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  331  }
a07b4970f464f1 drivers/nvme/target/io-cmd.c      Christoph Hellwig       2016-06-21  332  

:::::: The code at line 310 was first introduced by commit
:::::: 07888c665b405b1cd3577ddebfeb74f4717a84c4 block: pass a block_device and opf to bio_alloc

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
