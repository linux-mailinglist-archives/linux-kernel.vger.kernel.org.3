Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB34BB076
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiBRD7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:59:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBRD73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:59:29 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B728427F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645156753; x=1676692753;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OSGbZypEOwcCe0OaAJ2kZQaniBnS/aF4uV3HEa+PyAg=;
  b=XYbJlL9FIofwCvJnDSMo+ttoRFKeKHewspJaHXfJ9yoLaHYCaFO5okUl
   /jrMOeQn+GrF3l9hMhNmYA+zdqJ+SpgptKnggxFuiSLFMK206/bFUdPGW
   /wxfcGUETytU849NzxeEkW41hBxkZqaAQWYYOxpRX/HgKGaPPoJXtDWr9
   4wAfIoYrKkVlKWcNgN3xzhYxJvyCMWhP2pLxoymUxx7nWeEU9/gJOFXQX
   taHygAt/jAXHzDQ4grWoP3TFchcsXQCJjjO4zhM8/dZ8vdlUz0jIkta5O
   RpvR5rTeumWVnQIAfzve0TcQP9SQOKUD9OkeCBCApNLNncVSJRl39bQQ7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311787386"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="311787386"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:59:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="637599349"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 19:59:11 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKuQI-0000ui-Rp; Fri, 18 Feb 2022 03:59:10 +0000
Date:   Fri, 18 Feb 2022 11:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:m1-test-nvme 25/27] drivers/nvme/host/apple.c:507:15:
 error: 'struct bio_vec' has no member named 'bv_dma_start'
Message-ID: <202202181128.nqOiwDlV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git m1-test-nvme
head:   c0629b5191ba9a1a5372182580dc5452072ac666
commit: abdcb53ec9f23b6669cce5845151c6a1925bfd3d [25/27] apple-nvme: support persistent DMA maps
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220218/202202181128.nqOiwDlV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=abdcb53ec9f23b6669cce5845151c6a1925bfd3d
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block m1-test-nvme
        git checkout abdcb53ec9f23b6669cce5845151c6a1925bfd3d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/apple.c: In function 'apple_nvme_setup_prp_simple':
>> drivers/nvme/host/apple.c:507:15: error: 'struct bio_vec' has no member named 'bv_dma_start'
     507 |         if (bv->bv_dma_start) {
         |               ^~
   drivers/nvme/host/apple.c:509:36: error: 'struct bio_vec' has no member named 'bv_dma_start'
     509 |                 iod->first_dma = bv->bv_dma_start;
         |                                    ^~


vim +507 drivers/nvme/host/apple.c

   497	
   498	static blk_status_t apple_nvme_setup_prp_simple(struct apple_nvme *anv,
   499							struct request *req,
   500							struct nvme_rw_command *cmnd,
   501							struct bio_vec *bv)
   502	{
   503		struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
   504		unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
   505		unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
   506	
 > 507		if (bv->bv_dma_start) {
   508			iod->persistent = true;
   509			iod->first_dma = bv->bv_dma_start;
   510		} else {
   511			iod->first_dma = dma_map_bvec(anv->dev, bv, rq_dma_dir(req), 0);
   512			if (dma_mapping_error(anv->dev, iod->first_dma))
   513				return BLK_STS_RESOURCE;
   514		}
   515		iod->dma_len = bv->bv_len;
   516	
   517		cmnd->dptr.prp1 = iod->first_dma;
   518		if (bv->bv_len > first_prp_len)
   519			cmnd->dptr.prp2 = iod->first_dma + first_prp_len;
   520		return BLK_STS_OK;
   521	}
   522	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
