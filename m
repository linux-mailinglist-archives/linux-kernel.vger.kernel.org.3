Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64C50C7B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiDWFvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiDWFvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:51:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5A236E06
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650692928; x=1682228928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YseDN4ww4b+WfzhPh8V+oqITqtsVrDQitUI7zU1X+nM=;
  b=XdLAijc1qCoMGFXVV7AdXjY5QHXiRNgwvbf6NZljTun9bVnoh2Ttt1Gs
   Vd7lPHiDBOsd7EU7SB+1oEMmcRcgYCYshZhTwPYYzu/423ormFmc+nKN0
   hOXDtnpgN/s3ELDj3dnnQ6PeFDEoL9q9XderGVvuDUdCG7viIU1QvBfy2
   FLoFLFkmb1/ZpFz3sJYJRkU4kVqnd/bRoR78JbqdITMR9klYxKnPvN2Sm
   xWKYFykFL+K/8Vhy6nX7siADq+U51H1wH+/nsmpUV5nhp4ky4XNfuyHPP
   CXbcFMz0+aq49nkB5nuxK8tctOmOK1ACyaq/5mM2PLo/7P3TpKTZf9EwD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262449387"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="262449387"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 22:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="563335602"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2022 22:48:46 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni8dS-000B3v-9Q;
        Sat, 23 Apr 2022 05:48:46 +0000
Date:   Sat, 23 Apr 2022 13:48:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: drivers/gpu/drm/selftests/test-drm_buddy.c:371:7: warning: Local
 variable 'order' shadows outer variable [shadowVariable]
Message-ID: <202204231336.z5q1hTRd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
commit: e6ff5ef81170e11dc0f196b0391f708f04fa8c87 drm/selftests: add drm buddy smoke testcase
date:   8 weeks ago
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout e6ff5ef81170e11dc0f196b0391f708f04fa8c87
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
   In file included from drivers/gpu/drm/selftests/test-drm_buddy.c:
>> drivers/gpu/drm/selftests/test-drm_buddy.c:371:7: warning: Local variable 'order' shadows outer variable [shadowVariable]
     int order;
         ^
   drivers/gpu/drm/selftests/test-drm_buddy.c:346:7: note: Shadowed declaration
    int *order;
         ^
   drivers/gpu/drm/selftests/test-drm_buddy.c:371:7: note: Shadow variable
     int order;
         ^

vim +/order +371 drivers/gpu/drm/selftests/test-drm_buddy.c

   340	
   341	static int igt_buddy_alloc_smoke(void *arg)
   342	{
   343		u64 mm_size, min_page_size, chunk_size, start = 0;
   344		unsigned long flags = 0;
   345		struct drm_buddy mm;
   346		int *order;
   347		int err, i;
   348	
   349		DRM_RND_STATE(prng, random_seed);
   350		IGT_TIMEOUT(end_time);
   351	
   352		igt_mm_config(&mm_size, &chunk_size);
   353	
   354		err = drm_buddy_init(&mm, mm_size, chunk_size);
   355		if (err) {
   356			pr_err("buddy_init failed(%d)\n", err);
   357			return err;
   358		}
   359	
   360		order = drm_random_order(mm.max_order + 1, &prng);
   361		if (!order)
   362			goto out_fini;
   363	
   364		for (i = 0; i <= mm.max_order; ++i) {
   365			struct drm_buddy_block *block;
   366			int max_order = order[i];
   367			bool timeout = false;
   368			LIST_HEAD(blocks);
   369			u64 total, size;
   370			LIST_HEAD(tmp);
 > 371			int order;
   372	
   373			err = igt_check_mm(&mm);
   374			if (err) {
   375				pr_err("pre-mm check failed, abort\n");
   376				break;
   377			}
   378	
   379			order = max_order;
   380			total = 0;
   381	
   382			do {
   383	retry:
   384				size = min_page_size = get_size(order, chunk_size);
   385				err = drm_buddy_alloc_blocks(&mm, start, mm_size, size,
   386							     min_page_size, &tmp, flags);
   387				if (err) {
   388					if (err == -ENOMEM) {
   389						pr_info("buddy_alloc hit -ENOMEM with order=%d\n",
   390							order);
   391					} else {
   392						if (order--) {
   393							err = 0;
   394							goto retry;
   395						}
   396	
   397						pr_err("buddy_alloc with order=%d failed(%d)\n",
   398						       order, err);
   399					}
   400	
   401					break;
   402				}
   403	
   404				block = list_first_entry_or_null(&tmp,
   405								 struct drm_buddy_block,
   406								 link);
   407				if (!block) {
   408					pr_err("alloc_blocks has no blocks\n");
   409					err = -EINVAL;
   410					break;
   411				}
   412	
   413				list_move_tail(&block->link, &blocks);
   414	
   415				if (drm_buddy_block_order(block) != order) {
   416					pr_err("buddy_alloc order mismatch\n");
   417					err = -EINVAL;
   418					break;
   419				}
   420	
   421				total += drm_buddy_block_size(&mm, block);
   422	
   423				if (__igt_timeout(end_time, NULL)) {
   424					timeout = true;
   425					break;
   426				}
   427			} while (total < mm.size);
   428	
   429			if (!err)
   430				err = igt_check_blocks(&mm, &blocks, total, false);
   431	
   432			drm_buddy_free_list(&mm, &blocks);
   433	
   434			if (!err) {
   435				err = igt_check_mm(&mm);
   436				if (err)
   437					pr_err("post-mm check failed\n");
   438			}
   439	
   440			if (err || timeout)
   441				break;
   442	
   443			cond_resched();
   444		}
   445	
   446		if (err == -ENOMEM)
   447			err = 0;
   448	
   449		kfree(order);
   450	out_fini:
   451		drm_buddy_fini(&mm);
   452	
   453		return err;
   454	}
   455	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
