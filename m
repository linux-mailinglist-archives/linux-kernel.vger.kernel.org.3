Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6B57AA80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiGSXcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiGSXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:32:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF05A8A1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658273560; x=1689809560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kjl/gJcXa9ywx9LBzGe6Gsh+uBAgtGqIZvjmO+m87YE=;
  b=SwYbV+Y+TppOpCQrMiReGfYsjLQP7x32P2IbrA5Yt2IGecv9ouqNKVe9
   hAHbzpV/N2c31KcBqomac5NdkWiemkpm08sw5PWHJVqHMR5DIHLAWt/rW
   hm0dQImnQlpu9W1E53MBw5wbFTkzTdAy6LOxvA3CC1+QxhoEIepP7P8An
   JhMgOYSNJ8Kwz7tUFJLVUl8cCVJC91i1RSFVSUZJYIa2E1fjOcirPAKi/
   jBFQrOVl1faaZNbPFpoB3icDOIRfBrIK2z1/EI/jwJ7rsAAXsQKRArXXd
   jkcDFKOTjZD/nWoRvqNrMd8QT/8hAGJo7PA6pkJ2huHIRPvcXmsJqhof+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269659843"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="269659843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 16:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="548113329"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2022 16:32:38 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDwhh-0006Du-Oo;
        Tue, 19 Jul 2022 23:32:37 +0000
Date:   Wed, 20 Jul 2022 07:31:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-register 4/4] io_uring/rsrc.c:1242:12: error: 'struct
 io_mapped_ubuf' has no member named 'dma_tag'
Message-ID: <202207200749.b8XeMpQ8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-register
head:   9de6909fed20955193275bbf9c75ccc85553b7d8
commit: 9de6909fed20955193275bbf9c75ccc85553b7d8 [4/4] dma-prereg: add memory cleanup
config: openrisc-randconfig-r032-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200749.b8XeMpQ8-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=9de6909fed20955193275bbf9c75ccc85553b7d8
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-register
        git checkout 9de6909fed20955193275bbf9c75ccc85553b7d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   io_uring/rsrc.c: In function 'io_sqe_buffer_register':
>> io_uring/rsrc.c:1242:12: error: 'struct io_mapped_ubuf' has no member named 'dma_tag'
    1242 |         imu->dma_tag = 0;
         |            ^~
   io_uring/rsrc.c: In function 'io_import_fixed':
   io_uring/rsrc.c:1337:16: error: 'struct io_mapped_ubuf' has no member named 'dma_tag'
    1337 |         if (imu->dma_tag) {
         |                ^~
   io_uring/rsrc.c:1340:49: error: 'struct io_mapped_ubuf' has no member named 'dma_tag'
    1340 |                 iov_iter_dma_tag(iter, ddir, imu->dma_tag, offset, nr_segs, len);
         |                                                 ^~


vim +1242 io_uring/rsrc.c

129ce6a148558b Jens Axboe     2022-06-13  1192  
129ce6a148558b Jens Axboe     2022-06-13  1193  static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
129ce6a148558b Jens Axboe     2022-06-13  1194  				  struct io_mapped_ubuf **pimu,
129ce6a148558b Jens Axboe     2022-06-13  1195  				  struct page **last_hpage)
129ce6a148558b Jens Axboe     2022-06-13  1196  {
129ce6a148558b Jens Axboe     2022-06-13  1197  	struct io_mapped_ubuf *imu = NULL;
129ce6a148558b Jens Axboe     2022-06-13  1198  	struct page **pages = NULL;
129ce6a148558b Jens Axboe     2022-06-13  1199  	unsigned long off;
129ce6a148558b Jens Axboe     2022-06-13  1200  	size_t size;
129ce6a148558b Jens Axboe     2022-06-13  1201  	int ret, nr_pages, i;
129ce6a148558b Jens Axboe     2022-06-13  1202  
129ce6a148558b Jens Axboe     2022-06-13  1203  	*pimu = ctx->dummy_ubuf;
faee7b38d3c3e4 Pavel Begunkov 2022-06-15  1204  	if (!iov->iov_base)
129ce6a148558b Jens Axboe     2022-06-13  1205  		return 0;
129ce6a148558b Jens Axboe     2022-06-13  1206  
129ce6a148558b Jens Axboe     2022-06-13  1207  	ret = -ENOMEM;
129ce6a148558b Jens Axboe     2022-06-13  1208  	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
129ce6a148558b Jens Axboe     2022-06-13  1209  				&nr_pages);
129ce6a148558b Jens Axboe     2022-06-13  1210  	if (IS_ERR(pages)) {
129ce6a148558b Jens Axboe     2022-06-13  1211  		ret = PTR_ERR(pages);
129ce6a148558b Jens Axboe     2022-06-13  1212  		pages = NULL;
129ce6a148558b Jens Axboe     2022-06-13  1213  		goto done;
129ce6a148558b Jens Axboe     2022-06-13  1214  	}
129ce6a148558b Jens Axboe     2022-06-13  1215  
129ce6a148558b Jens Axboe     2022-06-13  1216  	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL);
129ce6a148558b Jens Axboe     2022-06-13  1217  	if (!imu)
129ce6a148558b Jens Axboe     2022-06-13  1218  		goto done;
129ce6a148558b Jens Axboe     2022-06-13  1219  
129ce6a148558b Jens Axboe     2022-06-13  1220  	ret = io_buffer_account_pin(ctx, pages, nr_pages, imu, last_hpage);
129ce6a148558b Jens Axboe     2022-06-13  1221  	if (ret) {
129ce6a148558b Jens Axboe     2022-06-13  1222  		unpin_user_pages(pages, nr_pages);
129ce6a148558b Jens Axboe     2022-06-13  1223  		goto done;
129ce6a148558b Jens Axboe     2022-06-13  1224  	}
129ce6a148558b Jens Axboe     2022-06-13  1225  
129ce6a148558b Jens Axboe     2022-06-13  1226  	off = (unsigned long) iov->iov_base & ~PAGE_MASK;
129ce6a148558b Jens Axboe     2022-06-13  1227  	size = iov->iov_len;
129ce6a148558b Jens Axboe     2022-06-13  1228  	for (i = 0; i < nr_pages; i++) {
129ce6a148558b Jens Axboe     2022-06-13  1229  		size_t vec_len;
129ce6a148558b Jens Axboe     2022-06-13  1230  
129ce6a148558b Jens Axboe     2022-06-13  1231  		vec_len = min_t(size_t, size, PAGE_SIZE - off);
129ce6a148558b Jens Axboe     2022-06-13  1232  		imu->bvec[i].bv_page = pages[i];
129ce6a148558b Jens Axboe     2022-06-13  1233  		imu->bvec[i].bv_len = vec_len;
129ce6a148558b Jens Axboe     2022-06-13  1234  		imu->bvec[i].bv_offset = off;
129ce6a148558b Jens Axboe     2022-06-13  1235  		off = 0;
129ce6a148558b Jens Axboe     2022-06-13  1236  		size -= vec_len;
129ce6a148558b Jens Axboe     2022-06-13  1237  	}
129ce6a148558b Jens Axboe     2022-06-13  1238  	/* store original address for later verification */
129ce6a148558b Jens Axboe     2022-06-13  1239  	imu->ubuf = (unsigned long) iov->iov_base;
129ce6a148558b Jens Axboe     2022-06-13  1240  	imu->ubuf_end = imu->ubuf + iov->iov_len;
129ce6a148558b Jens Axboe     2022-06-13  1241  	imu->nr_bvecs = nr_pages;
8c38d1fa715ef4 Keith Busch    2022-07-18 @1242  	imu->dma_tag = 0;
129ce6a148558b Jens Axboe     2022-06-13  1243  	*pimu = imu;
129ce6a148558b Jens Axboe     2022-06-13  1244  	ret = 0;
129ce6a148558b Jens Axboe     2022-06-13  1245  done:
129ce6a148558b Jens Axboe     2022-06-13  1246  	if (ret)
129ce6a148558b Jens Axboe     2022-06-13  1247  		kvfree(imu);
129ce6a148558b Jens Axboe     2022-06-13  1248  	kvfree(pages);
129ce6a148558b Jens Axboe     2022-06-13  1249  	return ret;
129ce6a148558b Jens Axboe     2022-06-13  1250  }
129ce6a148558b Jens Axboe     2022-06-13  1251  

:::::: The code at line 1242 was first introduced by commit
:::::: 8c38d1fa715ef4cd8c42a27cd252e66f99a440a3 iouring/block/nvme: preregister dma mapped buffers

:::::: TO: Keith Busch <kbusch@kernel.org>
:::::: CC: Keith Busch <kbusch@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
