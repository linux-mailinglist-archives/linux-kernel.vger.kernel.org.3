Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421557DB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiGVHtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiGVHt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:49:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB09A698
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658476168; x=1690012168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JZN3empNMk8Y/74069KnhnyGg2nb3EahPmTaJa3lwkY=;
  b=Gtm+tIfZ48FCw+ly5FlVYOrVbz8xzNFNC0w/TvQ6Ee81oeF8oHtAbdSd
   Vdb1ff9TDOdMP6T3WdAjoWwlHSiK0jvmkn/wObqI35OZPmQdGfMUc/XCA
   DOqA/QQbcK1yZPA/orPfpFApGXqE43HVUj2lzrt4zERNw0HFzUStC4mO0
   IlZvl+Pj8vRdsBFqC1RU+96bG4AHjyoYsIRC4JzAj0wwiAknlZ7GtRhiW
   crOfj5V3oYWO/Vjs6eheevnF1Ys7+ono5/DlaZQX71Yqx34lR4A7msGWo
   9kaQI6Y/+ouf/l5e+ElkHqPUI30jhGXR7v7JyKMgyVKP7+Jm8vMYCJzOi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="288016237"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="288016237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 00:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="574075888"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2022 00:49:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEnPa-00018O-1t;
        Fri, 22 Jul 2022 07:49:26 +0000
Date:   Fri, 22 Jul 2022 15:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v3-wip 5/6] io_uring/rsrc.c:155: undefined
 reference to `io_dma_unmap'
Message-ID: <202207221539.1JrGZRYG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v3-wip
head:   4625fa7adf745334c0a2eb635121d587df797b29
commit: 1390adeaee356151aeb13383e6ee1ad1c5798816 [5/6] io_uring: add support for dma pre-mapping
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220722/202207221539.1JrGZRYG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=1390adeaee356151aeb13383e6ee1ad1c5798816
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v3-wip
        git checkout 1390adeaee356151aeb13383e6ee1ad1c5798816
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: io_uring/rsrc.o: in function `io_buffer_unmap':
>> io_uring/rsrc.c:155: undefined reference to `io_dma_unmap'


vim +155 io_uring/rsrc.c

   144	
   145	static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf **slot)
   146	{
   147		struct io_mapped_ubuf *imu = *slot;
   148		unsigned int i;
   149	
   150		if (imu != ctx->dummy_ubuf) {
   151			for (i = 0; i < imu->nr_bvecs; i++)
   152				unpin_user_page(imu->bvec[i].bv_page);
   153			if (imu->acct_pages)
   154				io_unaccount_mem(ctx, imu->acct_pages);
 > 155			io_dma_unmap(imu);
   156			kvfree(imu);
   157		}
   158		*slot = NULL;
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
