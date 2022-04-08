Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0504F977F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiDHODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiDHOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:02:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65D1066D6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649426432; x=1680962432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JGEahfptMaisGpqsTz3IjwWEbJiEh74BgJcUZ8EK2Dk=;
  b=jY4+1Bn8g1PR2Ji/qlGVhpCSmGcm3+1rAY4te+QVTDTWsVw2BgrAAfbl
   apgeuxxZzXnBOjQ4egd/wxufu9BVb+zlBtqyo7Pwgtyv8OtF3QFiEQxrM
   8IyDCRzjWrzN6ZsL0HeVWMg6B+cGEE+ZPkIJM1hbwNFjoaoVlO1XFlmn4
   CxY4IVnQOFyVA+CvoOlUxBnsasWYbi6gaiS6CwOlXbmGojk4kGggr8P/b
   KAlYOr/6Thi5JzFn/vwP/s3NADCA/UndpFP/IoMP2cTzomVH6Gvq5NHaC
   VFCnDiP66I0xcN6aZcq5JT8dyDSC4RVML9Yurl2SidaFECPsedTnw8DlZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260434422"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260434422"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="852077676"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2022 07:00:31 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncpA6-0000Kj-E6;
        Fri, 08 Apr 2022 14:00:30 +0000
Date:   Fri, 8 Apr 2022 21:59:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:fan_evictable 6/16]
 include/linux/fsnotify_backend.h:269:36: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202204082112.PhSsWj1q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fan_evictable
head:   bac37b7aec7f4dc6f4bc9c96356341245620fb5e
commit: cb71ef37a75afb4856098c9bf1b2e860b836e74e [6/16] fsnotify: create helpers for group mark_mutex lock
config: openrisc-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082112.PhSsWj1q-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/amir73il/linux/commit/cb71ef37a75afb4856098c9bf1b2e860b836e74e
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il fan_evictable
        git checkout cb71ef37a75afb4856098c9bf1b2e860b836e74e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash fs/notify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/notify/mark.c:279:9: sparse: sparse: context imbalance in 'fsnotify_put_mark' - unexpected unlock
   fs/notify/mark.c: note: in included file:
>> include/linux/fsnotify_backend.h:269:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted gfp_t [usertype] owner_flags @@     got unsigned int @@
   include/linux/fsnotify_backend.h:269:36: sparse:     expected restricted gfp_t [usertype] owner_flags
   include/linux/fsnotify_backend.h:269:36: sparse:     got unsigned int
>> include/linux/fsnotify_backend.h:275:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t [usertype] owner_flags @@
   include/linux/fsnotify_backend.h:275:44: sparse:     expected unsigned int flags
   include/linux/fsnotify_backend.h:275:44: sparse:     got restricted gfp_t [usertype] owner_flags
   fs/notify/mark.c:545:39: sparse: sparse: context imbalance in 'fsnotify_grab_connector' - different lock contexts for basic block
   fs/notify/mark.c:657:20: sparse: sparse: context imbalance in 'fsnotify_add_mark_list' - unexpected unlock
>> include/linux/fsnotify_backend.h:269:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted gfp_t [usertype] owner_flags @@     got unsigned int @@
   include/linux/fsnotify_backend.h:269:36: sparse:     expected restricted gfp_t [usertype] owner_flags
   include/linux/fsnotify_backend.h:269:36: sparse:     got unsigned int
>> include/linux/fsnotify_backend.h:275:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t [usertype] owner_flags @@
   include/linux/fsnotify_backend.h:275:44: sparse:     expected unsigned int flags
   include/linux/fsnotify_backend.h:275:44: sparse:     got restricted gfp_t [usertype] owner_flags
   fs/notify/mark.c:738:25: sparse: sparse: context imbalance in 'fsnotify_find_mark' - unexpected unlock
>> include/linux/fsnotify_backend.h:269:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted gfp_t [usertype] owner_flags @@     got unsigned int @@
   include/linux/fsnotify_backend.h:269:36: sparse:     expected restricted gfp_t [usertype] owner_flags
   include/linux/fsnotify_backend.h:269:36: sparse:     got unsigned int
>> include/linux/fsnotify_backend.h:275:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t [usertype] owner_flags @@
   include/linux/fsnotify_backend.h:275:44: sparse:     expected unsigned int flags
   include/linux/fsnotify_backend.h:275:44: sparse:     got restricted gfp_t [usertype] owner_flags
>> include/linux/fsnotify_backend.h:269:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted gfp_t [usertype] owner_flags @@     got unsigned int @@
   include/linux/fsnotify_backend.h:269:36: sparse:     expected restricted gfp_t [usertype] owner_flags
   include/linux/fsnotify_backend.h:269:36: sparse:     got unsigned int
>> include/linux/fsnotify_backend.h:275:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t [usertype] owner_flags @@
   include/linux/fsnotify_backend.h:275:44: sparse:     expected unsigned int flags
   include/linux/fsnotify_backend.h:275:44: sparse:     got restricted gfp_t [usertype] owner_flags
>> include/linux/fsnotify_backend.h:275:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t [usertype] owner_flags @@
   include/linux/fsnotify_backend.h:275:44: sparse:     expected unsigned int flags
   include/linux/fsnotify_backend.h:275:44: sparse:     got restricted gfp_t [usertype] owner_flags
   fs/notify/mark.c:812:17: sparse: sparse: context imbalance in 'fsnotify_destroy_marks' - unexpected unlock
--
   fs/notify/fdinfo.c: note: in included file:
>> include/linux/fsnotify_backend.h:269:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted gfp_t [usertype] owner_flags @@     got unsigned int @@
   include/linux/fsnotify_backend.h:269:36: sparse:     expected restricted gfp_t [usertype] owner_flags
   include/linux/fsnotify_backend.h:269:36: sparse:     got unsigned int
>> include/linux/fsnotify_backend.h:275:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t [usertype] owner_flags @@
   include/linux/fsnotify_backend.h:275:44: sparse:     expected unsigned int flags
   include/linux/fsnotify_backend.h:275:44: sparse:     got restricted gfp_t [usertype] owner_flags

vim +269 include/linux/fsnotify_backend.h

   260	
   261	/*
   262	 * These helpers are used to prevent deadlock when reclaiming inodes with
   263	 * evictable marks of the same group that is allocating a new mark.
   264	 */
   265	static inline void fsnotify_group_lock(struct fsnotify_group *group)
   266	{
   267		mutex_lock(&group->mark_mutex);
   268		if (FSNOTIFY_GROUP_FLAG(group, NOFS))
 > 269			group->owner_flags = memalloc_nofs_save();
   270	}
   271	
   272	static inline void fsnotify_group_unlock(struct fsnotify_group *group)
   273	{
   274		if (FSNOTIFY_GROUP_FLAG(group, NOFS))
 > 275			memalloc_nofs_restore(group->owner_flags);
   276		mutex_unlock(&group->mark_mutex);
   277	}
   278	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
