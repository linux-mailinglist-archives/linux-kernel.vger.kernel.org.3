Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FCE5B0FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIGW2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIGW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:28:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B299080A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662589715; x=1694125715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tFMK98RAA01a8CPVim5mEA1L1GHgCQWqaGM5p9mIpHA=;
  b=ha5YhOxSjegUMBigpQWcB303J2D8S50xbIc1aOCzlHNYAozHw8f6jSa/
   UmVYS4fVSRSwmWQpDB1dU/tFnAngUNnsmhTx8rDOpUxu0xG9ayndYIiwU
   b0eQceK6YJqdiFwjD6xMXy9feqh5I1k5jD4i01MEuH1IWXkdqtf8zvLFE
   NqLNgJ/07p8/l+i7va5ln/65d8HVITBsgZFz5+fObPcXighelPU5SC/b4
   fQBe3B6QD5oMEkF4pkJwpY1xmlWexgtkxZ+Q6B2M1a5fHcBKDOeVIboyp
   rJ5wOTzlXK49Oc800eZq1FKZtTSCqqaL2oe41VcPM2QhqAGxzIvASc70D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295747629"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295747629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="565700502"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 15:28:33 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW3X7-000717-0B;
        Wed, 07 Sep 2022 22:28:33 +0000
Date:   Thu, 8 Sep 2022 06:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v10 6/8]
 block/blk-map.c:261:25: error: implicit declaration of function
 'iov_iter_get_pages_alloc_flags'; did you mean 'iov_iter_get_pages_alloc2'?
Message-ID: <202209080607.uLZao3Lh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v10
head:   efd6fef685a844fb4eec90383861b3a0bd48545f
commit: d931dbbbcc766ef83297fffb65d1194c6dbef235 [6/8] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220908/202209080607.uLZao3Lh-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/sbates130272/linux-p2pmem/commit/d931dbbbcc766ef83297fffb65d1194c6dbef235
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v10
        git checkout d931dbbbcc766ef83297fffb65d1194c6dbef235
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/blk-map.c: In function 'bio_map_user_iov':
>> block/blk-map.c:261:25: error: implicit declaration of function 'iov_iter_get_pages_alloc_flags'; did you mean 'iov_iter_get_pages_alloc2'? [-Werror=implicit-function-declaration]
     261 |                 bytes = iov_iter_get_pages_alloc_flags(iter, &pages, LONG_MAX,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         iov_iter_get_pages_alloc2
   cc1: some warnings being treated as errors


vim +261 block/blk-map.c

   233	
   234	static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
   235			gfp_t gfp_mask)
   236	{
   237		unsigned int max_sectors = queue_max_hw_sectors(rq->q);
   238		unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
   239		unsigned int gup_flags = 0;
   240		struct bio *bio;
   241		int ret;
   242		int j;
   243	
   244		if (!iov_iter_count(iter))
   245			return -EINVAL;
   246	
   247		bio = bio_kmalloc(nr_vecs, gfp_mask);
   248		if (!bio)
   249			return -ENOMEM;
   250		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
   251	
   252		if (blk_queue_pci_p2pdma(rq->q))
   253			gup_flags |= FOLL_PCI_P2PDMA;
   254	
   255		while (iov_iter_count(iter)) {
   256			struct page **pages;
   257			ssize_t bytes;
   258			size_t offs, added = 0;
   259			int npages;
   260	
 > 261			bytes = iov_iter_get_pages_alloc_flags(iter, &pages, LONG_MAX,
   262							       &offs, gup_flags);
   263			if (unlikely(bytes <= 0)) {
   264				ret = bytes ? bytes : -EFAULT;
   265				goto out_unmap;
   266			}
   267	
   268			npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
   269	
   270			if (unlikely(offs & queue_dma_alignment(rq->q)))
   271				j = 0;
   272			else {
   273				for (j = 0; j < npages; j++) {
   274					struct page *page = pages[j];
   275					unsigned int n = PAGE_SIZE - offs;
   276					bool same_page = false;
   277	
   278					if (n > bytes)
   279						n = bytes;
   280	
   281					if (!bio_add_hw_page(rq->q, bio, page, n, offs,
   282							     max_sectors, &same_page)) {
   283						if (same_page)
   284							put_page(page);
   285						break;
   286					}
   287	
   288					added += n;
   289					bytes -= n;
   290					offs = 0;
   291				}
   292			}
   293			/*
   294			 * release the pages we didn't map into the bio, if any
   295			 */
   296			while (j < npages)
   297				put_page(pages[j++]);
   298			kvfree(pages);
   299			/* couldn't stuff something into bio? */
   300			if (bytes) {
   301				iov_iter_revert(iter, bytes);
   302				break;
   303			}
   304		}
   305	
   306		ret = blk_rq_append_bio(rq, bio);
   307		if (ret)
   308			goto out_unmap;
   309		return 0;
   310	
   311	 out_unmap:
   312		bio_release_pages(bio, false);
   313		bio_uninit(bio);
   314		kfree(bio);
   315		return ret;
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
