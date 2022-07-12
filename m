Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB1571234
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGLGXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:23:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8427CDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657606992; x=1689142992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zfSQcjxr5N6S5FBW0rMkXiWlBa0/jUnP19F9Yqiw1LM=;
  b=Jju26+YJi4EiLWjj+KHZGhukmvojKxvdGZ1R6fUhRdbLfayAEUYNgEzZ
   B3k1nCxLuljjgbKPdfJeclVyCcmUGSYJ62GGhHwGGEm79MpH9rVKjkBdx
   sSK0R3qrJwUhP10A8Nj+tp5t7zkmVIjCV9aJSS7DCA3iDSMFItgaOjVRd
   6+b+lTDnbudgXmKBmPHgPS5kzRRImCkbQm4rzS1pGe4R49laK2G/lyGvE
   oj/4OJ4uuX/+iDdnEm0z49vnQi5HZrXdCEQl2yMYS/hJTjbcY1uU91+s8
   hcKdmd4Tw82/TjcZJ4wVB5w4zzmg/Q+6EP+R8KZT/dq/o7k8+/YRysCCg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348827274"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="348827274"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="922079161"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 23:23:02 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB9IT-0001ol-Ud;
        Tue, 12 Jul 2022 06:23:01 +0000
Date:   Tue, 12 Jul 2022 14:22:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [sj:damon/next 20/20] drivers/block/xen-blkback/xenbus.c:184:38:
 error: use of undeclared identifier 'feature_persistent'
Message-ID: <202207121401.8Yis7IHm-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
head:   40d1ef717dd762939c0a8734fd901ee517b50334
commit: 40d1ef717dd762939c0a8734fd901ee517b50334 [20/20] xen-blkback: fix persistent grants negotiation
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220712/202207121401.8Yis7IHm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?id=40d1ef717dd762939c0a8734fd901ee517b50334
        git remote add sj https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
        git fetch --no-tags sj damon/next
        git checkout 40d1ef717dd762939c0a8734fd901ee517b50334
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/block/xen-blkback/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/block/xen-blkback/xenbus.c:184:38: error: use of undeclared identifier 'feature_persistent'
           blkif->vbd.feature_gnt_persistent = feature_persistent;
                                               ^
   1 error generated.


vim +/feature_persistent +184 drivers/block/xen-blkback/xenbus.c

   159	
   160	static struct xen_blkif *xen_blkif_alloc(domid_t domid)
   161	{
   162		struct xen_blkif *blkif;
   163	
   164		BUILD_BUG_ON(MAX_INDIRECT_PAGES > BLKIF_MAX_INDIRECT_PAGES_PER_REQUEST);
   165	
   166		blkif = kmem_cache_zalloc(xen_blkif_cachep, GFP_KERNEL);
   167		if (!blkif)
   168			return ERR_PTR(-ENOMEM);
   169	
   170		blkif->domid = domid;
   171		atomic_set(&blkif->refcnt, 1);
   172		init_completion(&blkif->drain_complete);
   173	
   174		/*
   175		 * Because freeing back to the cache may be deferred, it is not
   176		 * safe to unload the module (and hence destroy the cache) until
   177		 * this has completed. To prevent premature unloading, take an
   178		 * extra module reference here and release only when the object
   179		 * has been freed back to the cache.
   180		 */
   181		__module_get(THIS_MODULE);
   182		INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
   183	
 > 184		blkif->vbd.feature_gnt_persistent = feature_persistent;
   185	
   186		return blkif;
   187	}
   188	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
