Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60DE5B0F00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIGVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIGVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:15:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D9963F09
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662585332; x=1694121332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IcwFtZrk0uxcOuuTlf4K7v7kNvRR9ajN4YQ+auov3Co=;
  b=OghWi/Gk3Z1x3UvbjPahli8iq3+P9SYs0Pa402nfEihkNPX+uHWqodzr
   0N17TtGmSzGOJmLjaE9Ls/GKx/OJs7wPoxPrFVn8CcVuZUULDqW1KSMFC
   qjvlRaUwtKpsapXlVSFbRwRZS0ql2XYn9yTGmOvsOzvQHpNI8pj+FHvju
   tVVteYVck4YvahrDEuv9YAYSwEI0k9Sf+ULtzGbz1HR9A328XOpThQKkX
   YYJ0rt1Ugu9YqEVPflB8MRj2RW9rjD/lBxCo4R/QglY5O+oO38L0sABrY
   0Pb5lMemjho3TuaG8PORc5o/3FHZ0d4zX7Xvb5h2C2I2TA/K5c9Sk/feI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295733934"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295733934"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="614639451"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2022 14:15:30 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW2OP-0006xt-2F;
        Wed, 07 Sep 2022 21:15:29 +0000
Date:   Thu, 8 Sep 2022 05:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v10 5/8] block/bio.c:1227:16:
 error: implicit declaration of function 'iov_iter_get_pages_flags'; did you
 mean 'iov_iter_get_pages_alloc'?
Message-ID: <202209080503.f1YVsG0F-lkp@intel.com>
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
commit: 59e0a213f965c1cdbef34cf99527eae8072e255b [5/8] block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220908/202209080503.f1YVsG0F-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/sbates130272/linux-p2pmem/commit/59e0a213f965c1cdbef34cf99527eae8072e255b
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v10
        git checkout 59e0a213f965c1cdbef34cf99527eae8072e255b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/bio.c: In function '__bio_iov_iter_get_pages':
>> block/bio.c:1227:16: error: implicit declaration of function 'iov_iter_get_pages_flags'; did you mean 'iov_iter_get_pages_alloc'? [-Werror=implicit-function-declaration]
    1227 |         size = iov_iter_get_pages_flags(iter, pages,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
         |                iov_iter_get_pages_alloc
   cc1: some warnings being treated as errors


vim +1227 block/bio.c

  1186	
  1187	/**
  1188	 * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
  1189	 * @bio: bio to add pages to
  1190	 * @iter: iov iterator describing the region to be mapped
  1191	 *
  1192	 * Pins pages from *iter and appends them to @bio's bvec array. The
  1193	 * pages will have to be released using put_page() when done.
  1194	 * For multi-segment *iter, this function only adds pages from the
  1195	 * next non-empty segment of the iov iterator.
  1196	 */
  1197	static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
  1198	{
  1199		unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
  1200		unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
  1201		struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
  1202		struct page **pages = (struct page **)bv;
  1203		unsigned int gup_flags = 0;
  1204		ssize_t size, left;
  1205		unsigned len, i = 0;
  1206		size_t offset, trim;
  1207		int ret = 0;
  1208	
  1209		/*
  1210		 * Move page array up in the allocated memory for the bio vecs as far as
  1211		 * possible so that we can start filling biovecs from the beginning
  1212		 * without overwriting the temporary page array.
  1213		 */
  1214		BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
  1215		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
  1216	
  1217		if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
  1218			gup_flags |= FOLL_PCI_P2PDMA;
  1219	
  1220		/*
  1221		 * Each segment in the iov is required to be a block size multiple.
  1222		 * However, we may not be able to get the entire segment if it spans
  1223		 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
  1224		 * result to ensure the bio's total size is correct. The remainder of
  1225		 * the iov data will be picked up in the next bio iteration.
  1226		 */
> 1227		size = iov_iter_get_pages_flags(iter, pages,
  1228						UINT_MAX - bio->bi_iter.bi_size,
  1229						nr_pages, &offset, gup_flags);
  1230		if (unlikely(size <= 0))
  1231			return size ? size : -EFAULT;
  1232	
  1233		nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
  1234	
  1235		trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
  1236		iov_iter_revert(iter, trim);
  1237	
  1238		size -= trim;
  1239		if (unlikely(!size)) {
  1240			ret = -EFAULT;
  1241			goto out;
  1242		}
  1243	
  1244		for (left = size, i = 0; left > 0; left -= len, i++) {
  1245			struct page *page = pages[i];
  1246	
  1247			len = min_t(size_t, PAGE_SIZE - offset, left);
  1248			if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
  1249				ret = bio_iov_add_zone_append_page(bio, page, len,
  1250						offset);
  1251				if (ret)
  1252					break;
  1253			} else
  1254				bio_iov_add_page(bio, page, len, offset);
  1255	
  1256			offset = 0;
  1257		}
  1258	
  1259		iov_iter_revert(iter, left);
  1260	out:
  1261		while (i < nr_pages)
  1262			put_page(pages[i++]);
  1263	
  1264		return ret;
  1265	}
  1266	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
