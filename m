Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92C54CC20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbiFOPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiFOPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:03:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93635879
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655305438; x=1686841438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHeoGg3PQPdP5VbC2PG27RoW1s04/Fz9tzoP6DSf9WQ=;
  b=JRh1cvCqg6Y6SSEiaylHziC1kTCVQ2B5g1pxcHIEd5E21/wn0V1axMhr
   6YLlPJlp5MdW1o651JH4BdNUtqcCxgs0Ay0mq+U5ViRN+/aTLRHaKZAa2
   vTQixZTjeIa38wLJTSHNs5Ir512cWgQdk3lvfGu1LMI5nLZlgUwHn48+0
   wHNYZT1VyIh8T8JHpkmw7egCiUixBsdqWJ1fFWGhiwFFN1O3v13M7TQd3
   1mz04JrO+BE+tQ4nkmqQHLMCyuS3KfKtnj8vMB/xSvfzOYLoIHgFNcSOq
   n/cT1tE+z4Vs+XTFjLA/3TtdwK7qQ9lJXQcFmrZYSG2Adb02+k9T14JDb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277784493"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277784493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="612778636"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2022 08:03:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1UYA-000MxD-PE;
        Wed, 15 Jun 2022 15:03:18 +0000
Date:   Wed, 15 Jun 2022 23:02:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ren Zhijie <renzhijie2@huawei.com>, jaegeuk@kernel.org,
        chao@kernel.org, daehojeong@google.com
Cc:     kbuild-all@lists.01.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Ren Zhijie <renzhijie2@huawei.com>
Subject: Re: [PATCH -next] f2fs: fix build error too many arguments to
 functions
Message-ID: <202206152345.By6X3FNj-lkp@intel.com>
References: <20220615070422.214106-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615070422.214106-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ren,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220615]

url:    https://github.com/intel-lab-lkp/linux/commits/Ren-Zhijie/f2fs-fix-build-error-too-many-arguments-to-functions/20220615-150808
base:    6012273897fefb12566580efedee10bb06e5e6ed
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220615/202206152345.By6X3FNj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1832104c73270fad342bf40c089542083dca7585
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ren-Zhijie/f2fs-fix-build-error-too-many-arguments-to-functions/20220615-150808
        git checkout 1832104c73270fad342bf40c089542083dca7585
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/f2fs/data.c: In function 'f2fs_finish_read_bio':
>> fs/f2fs/data.c:136:33: error: too few arguments to function 'f2fs_end_read_compressed_page'
     136 |                                 f2fs_end_read_compressed_page(page, true, 0);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/f2fs/data.c:25:
   fs/f2fs/f2fs.h:4226:20: note: declared here
    4226 | static inline void f2fs_end_read_compressed_page(struct page *page, bool failed,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/f2fs/data.c:137:25: error: too few arguments to function 'f2fs_put_page_dic'
     137 |                         f2fs_put_page_dic(page);
         |                         ^~~~~~~~~~~~~~~~~
   In file included from fs/f2fs/data.c:25:
   fs/f2fs/f2fs.h:4231:20: note: declared here
    4231 | static inline void f2fs_put_page_dic(struct page *page, bool in_softirq)
         |                    ^~~~~~~~~~~~~~~~~
   fs/f2fs/data.c: In function 'f2fs_handle_step_decompress':
   fs/f2fs/data.c:239:25: error: too few arguments to function 'f2fs_end_read_compressed_page'
     239 |                         f2fs_end_read_compressed_page(page, PageError(page),
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/f2fs/data.c:25:
   fs/f2fs/f2fs.h:4226:20: note: declared here
    4226 | static inline void f2fs_end_read_compressed_page(struct page *page, bool failed,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/f2fs_end_read_compressed_page +136 fs/f2fs/data.c

6dbb17961f46b2 Eric Biggers      2018-04-18  121  
7f59b277f79e8a Eric Biggers      2021-01-04  122  static void f2fs_finish_read_bio(struct bio *bio)
93dfe2ac516250 Jaegeuk Kim       2013-11-30  123  {
6dbb17961f46b2 Eric Biggers      2018-04-18  124  	struct bio_vec *bv;
6dc4f100c175dd Ming Lei          2019-02-15  125  	struct bvec_iter_all iter_all;
93dfe2ac516250 Jaegeuk Kim       2013-11-30  126  
7f59b277f79e8a Eric Biggers      2021-01-04  127  	/*
7f59b277f79e8a Eric Biggers      2021-01-04  128  	 * Update and unlock the bio's pagecache pages, and put the
7f59b277f79e8a Eric Biggers      2021-01-04  129  	 * decompression context for any compressed pages.
7f59b277f79e8a Eric Biggers      2021-01-04  130  	 */
2b070cfe582b8e Christoph Hellwig 2019-04-25  131  	bio_for_each_segment_all(bv, bio, iter_all) {
7f59b277f79e8a Eric Biggers      2021-01-04  132  		struct page *page = bv->bv_page;
6dbb17961f46b2 Eric Biggers      2018-04-18  133  
7f59b277f79e8a Eric Biggers      2021-01-04  134  		if (f2fs_is_compressed_page(page)) {
7f59b277f79e8a Eric Biggers      2021-01-04  135  			if (bio->bi_status)
6ce19aff0b8cd3 Chao Yu           2021-05-20 @136  				f2fs_end_read_compressed_page(page, true, 0);
7f59b277f79e8a Eric Biggers      2021-01-04 @137  			f2fs_put_page_dic(page);
4c8ff7095bef64 Chao Yu           2019-11-01  138  			continue;
4c8ff7095bef64 Chao Yu           2019-11-01  139  		}
4c8ff7095bef64 Chao Yu           2019-11-01  140  
7f59b277f79e8a Eric Biggers      2021-01-04  141  		/* PG_error was set if decryption or verity failed. */
6dbb17961f46b2 Eric Biggers      2018-04-18  142  		if (bio->bi_status || PageError(page)) {
6dbb17961f46b2 Eric Biggers      2018-04-18  143  			ClearPageUptodate(page);
fb7d70db305a14 Jaegeuk Kim       2018-09-25  144  			/* will re-read again later */
fb7d70db305a14 Jaegeuk Kim       2018-09-25  145  			ClearPageError(page);
6dbb17961f46b2 Eric Biggers      2018-04-18  146  		} else {
6dbb17961f46b2 Eric Biggers      2018-04-18  147  			SetPageUptodate(page);
6dbb17961f46b2 Eric Biggers      2018-04-18  148  		}
5f9abab42b60e6 Jaegeuk Kim       2018-10-16  149  		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
6dbb17961f46b2 Eric Biggers      2018-04-18  150  		unlock_page(page);
6dbb17961f46b2 Eric Biggers      2018-04-18  151  	}
79bbefb19f1359 Chao Yu           2020-03-23  152  
7f59b277f79e8a Eric Biggers      2021-01-04  153  	if (bio->bi_private)
7f59b277f79e8a Eric Biggers      2021-01-04  154  		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
7f59b277f79e8a Eric Biggers      2021-01-04  155  	bio_put(bio);
4c8ff7095bef64 Chao Yu           2019-11-01  156  }
4c8ff7095bef64 Chao Yu           2019-11-01  157  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
