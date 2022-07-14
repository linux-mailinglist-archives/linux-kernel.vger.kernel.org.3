Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5819457417E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiGNCmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGNCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:41:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2AA140A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657766516; x=1689302516;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zz5LmvbKdud1k2C+9zrTQmJDhao9WKbiUSLlUNk3CVc=;
  b=fPvx1G6TfTErWMwKfgdd+8jhiLAjts8hPTgVSNl8x2W3OhqIBGmUS67B
   3YsYdIMCBzqvHk4plt10xep3ZqYLSuMZkh5akfJnpszRWZ+AxWieppq24
   LPtlrjp7Ijo5g7cU7bFlHDEG8XkPyh5Q38ZHVPWkRSVd7xbyXcn6Xggcz
   UhLOW3qYIe3AqFWvUxs1uEeNwY5E763GmMcWeEsF631URGbAJB7hLnOH+
   X1L34UqYCgbNmgieAEZDKdV+MfE4s9KSzdfLSp5K86prjuTESmvhjwKca
   pnDn0YujmtJhNkLW14vC9Fj7ug/M8B1xPwz0t1IOcF1YCjiJrkXQRiEm0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347078805"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="347078805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="595926902"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jul 2022 19:41:54 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBonZ-00004U-OP;
        Thu, 14 Jul 2022 02:41:53 +0000
Date:   Thu, 14 Jul 2022 10:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [bvanassche:block-bitwise-opf 38/64]
 drivers/nvme/target/zns.c:528:25: warning: unused variable 'opf'
Message-ID: <202207141000.WZs97iNH-lkp@intel.com>
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
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220714/202207141000.WZs97iNH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/5d612f7990f6438fe5d09c30560c0e25a1d292a2
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 5d612f7990f6438fe5d09c30560c0e25a1d292a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/target/zns.c: In function 'nvmet_bdev_execute_zone_append':
   drivers/nvme/target/zns.c:559:56: error: 'op' undeclared (first use in this function); did you mean 'opf'?
     559 |                          ARRAY_SIZE(req->inline_bvec), op);
         |                                                        ^~
         |                                                        opf
   drivers/nvme/target/zns.c:559:56: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/nvme/target/zns.c:528:25: warning: unused variable 'opf' [-Wunused-variable]
     528 |         const blk_opf_t opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
         |                         ^~~


vim +/opf +528 drivers/nvme/target/zns.c

   524	
   525	void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
   526	{
   527		sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 > 528		const blk_opf_t opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
   529		u16 status = NVME_SC_SUCCESS;
   530		unsigned int total_len = 0;
   531		struct scatterlist *sg;
   532		struct bio *bio;
   533		int sg_cnt;
   534	
   535		/* Request is completed on len mismatch in nvmet_check_transter_len() */
   536		if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
   537			return;
   538	
   539		if (!req->sg_cnt) {
   540			nvmet_req_complete(req, 0);
   541			return;
   542		}
   543	
   544		if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
   545			req->error_loc = offsetof(struct nvme_rw_command, slba);
   546			status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
   547			goto out;
   548		}
   549	
   550		if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
   551			req->error_loc = offsetof(struct nvme_rw_command, slba);
   552			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
   553			goto out;
   554		}
   555	
   556		if (nvmet_use_inline_bvec(req)) {
   557			bio = &req->z.inline_bio;
   558			bio_init(bio, req->ns->bdev, req->inline_bvec,
   559				 ARRAY_SIZE(req->inline_bvec), op);
   560		} else {
   561			bio = bio_alloc(req->ns->bdev, req->sg_cnt, op, GFP_KERNEL);
   562		}
   563	
   564		bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
   565		bio->bi_iter.bi_sector = sect;
   566		bio->bi_private = req;
   567		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
   568			bio->bi_opf |= REQ_FUA;
   569	
   570		for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
   571			struct page *p = sg_page(sg);
   572			unsigned int l = sg->length;
   573			unsigned int o = sg->offset;
   574			unsigned int ret;
   575	
   576			ret = bio_add_zone_append_page(bio, p, l, o);
   577			if (ret != sg->length) {
   578				status = NVME_SC_INTERNAL;
   579				goto out_put_bio;
   580			}
   581			total_len += sg->length;
   582		}
   583	
   584		if (total_len != nvmet_rw_data_len(req)) {
   585			status = NVME_SC_INTERNAL | NVME_SC_DNR;
   586			goto out_put_bio;
   587		}
   588	
   589		submit_bio(bio);
   590		return;
   591	
   592	out_put_bio:
   593		nvmet_req_bio_put(req, bio);
   594	out:
   595		nvmet_req_complete(req, status);
   596	}
   597	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
