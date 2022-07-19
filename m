Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472A57A340
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGSPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGSPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:35:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF232ED7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658244919; x=1689780919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YuD/9yqwgde3mnh1AA3dZVn12N/kVvIXcmiSlVB5Jys=;
  b=FGzg/s0mL8GPE+BGRWCSRL2gtIZpaZ26IbCWUMBR8GtWBgTCw4pqSPEY
   c1paw2Woi3MGz0gVg3dMmcu8ckb2BaHBdVwfTrGp768QLmtRiG1ElmFX6
   0GkUb9tqfCZL0ZyXV8raHXZemmDdF2uHhP84M4I5FWVDct0cdrXB86BPB
   h5AzdbnyP9u5eJwlUo/Dwsvph4tXiUMd1mapafeAyaUzt1K/8tIp8ubDz
   GyXjBlRvwusawIubhwG1XPd6R80vxbEKR2cll4uDr/YcN9nmdpj+PWn0p
   Q9OtCRiHhujsBJIk/iawCQ6LpucnMsOmG5sjmLnVWGWanw016m/qdTXrJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273354485"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="273354485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 08:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="625234047"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2022 08:35:17 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDpFl-0005mw-9I;
        Tue, 19 Jul 2022 15:35:17 +0000
Date:   Tue, 19 Jul 2022 23:34:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-register 1/4] block/bio.c:1155:6: warning: no previous
 prototype for 'bio_iov_dma_tag_set'
Message-ID: <202207192339.BezSHVyy-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-register
head:   9de6909fed20955193275bbf9c75ccc85553b7d8
commit: 8c38d1fa715ef4cd8c42a27cd252e66f99a440a3 [1/4] iouring/block/nvme: preregister dma mapped buffers
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220719/202207192339.BezSHVyy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=8c38d1fa715ef4cd8c42a27cd252e66f99a440a3
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-register
        git checkout 8c38d1fa715ef4cd8c42a27cd252e66f99a440a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/bio.c:1155:6: warning: no previous prototype for 'bio_iov_dma_tag_set' [-Wmissing-prototypes]
    1155 | void bio_iov_dma_tag_set(struct bio *bio, struct iov_iter *iter)
         |      ^~~~~~~~~~~~~~~~~~~
   block/bio.c:1170:13: warning: 'bio_put_pages' defined but not used [-Wunused-function]
    1170 | static void bio_put_pages(struct page **pages, size_t size, size_t off)
         |             ^~~~~~~~~~~~~


vim +/bio_iov_dma_tag_set +1155 block/bio.c

  1154	
> 1155	void bio_iov_dma_tag_set(struct bio *bio, struct iov_iter *iter)
  1156	{
  1157		size_t size = iov_iter_count(iter);
  1158	
  1159		bio->bi_vcnt = iter->nr_segs;
  1160		bio->bi_dma_tag = iter->dma_tag;
  1161		bio->bi_iter.bi_bvec_done = iter->iov_offset;
  1162		bio->bi_iter.bi_size = size;
  1163		bio->bi_opf |= REQ_NOMERGE;
  1164		bio_set_flag(bio, BIO_NO_PAGE_REF);
  1165		bio_set_flag(bio, BIO_DMA_TAGGED);
  1166	
  1167		iov_iter_advance(iter, bio->bi_iter.bi_size);
  1168	}
  1169	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
