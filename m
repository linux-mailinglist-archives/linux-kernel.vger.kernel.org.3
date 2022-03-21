Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A34E2FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiCUSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCUSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:20:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A01EAD6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647886764; x=1679422764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RpxhtOeQxZ8yIXkXuKKL4DSSYVP8/RZrN59np0aIsu4=;
  b=TRWCxI7AMJPFxIehd13GS+IY0cxejktCMtGFQC69gRQLKxsktWSvIOg7
   wm5m2e/Q1VU0OlaP49j3J/oLmQxJEZBwX7e14RtBuevoJk1kexq/0GAMd
   tMrsdwC34+8w33Yc/MKkBnJLUVyeGsKm5qf8SkdK39uLDv4Upi093Yws4
   nmJL4L5CXX55eoMzcxiy4tpCXQIeP/Yp2wGRJnwtDkp4qz3/pzgkvMVtn
   BcqBlRRSJ2NBSI16+q1/pMoZ6VSapOgZkps1cmDnOhxATpEY2AKfuTiPX
   MvcgSJD1xEoo4dWGuQWE6Q0l/LIW/oZOk263hGPw0G9Y/6kc7LuEhCnbt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320823041"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="320823041"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 11:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="518541486"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 11:19:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWMcj-000I3m-MN; Mon, 21 Mar 2022 18:19:21 +0000
Date:   Tue, 22 Mar 2022 02:18:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:fsnotify-volatile 3/10]
 fs/notify/fanotify/fanotify_user.c:1147:8: error: too few arguments to
 function 'fsnotify_add_mark_locked'
Message-ID: <202203220253.CbyFvh3n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fsnotify-volatile
head:   46cbd4482bb2350a2d667d18272e2f0172c1633b
commit: 66f27fc99e46b12f1078e8e2915793040ce50ee7 [3/10] fsnotify: preallocate connector outside of group lock
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220322/202203220253.CbyFvh3n-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/amir73il/linux/commit/66f27fc99e46b12f1078e8e2915793040ce50ee7
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il fsnotify-volatile
        git checkout 66f27fc99e46b12f1078e8e2915793040ce50ee7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the amir73il/fsnotify-volatile HEAD 46cbd4482bb2350a2d667d18272e2f0172c1633b builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   fs/notify/fanotify/fanotify_user.c: In function 'fanotify_add_new_mark':
>> fs/notify/fanotify/fanotify_user.c:1147:8: error: too few arguments to function 'fsnotify_add_mark_locked'
    1147 |  ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/notify/fanotify/fanotify_user.c:8:
   include/linux/fsnotify_backend.h:642:12: note: declared here
     642 | extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/fsnotify_add_mark_locked +1147 fs/notify/fanotify/fanotify_user.c

912ee3946c5e57 Andreas Gruenbacher 2009-12-17  1121  
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1122  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
b812a9f5896379 Amir Goldstein      2018-06-23  1123  						   fsnotify_connp_t *connp,
ad69cd9972e79a Amir Goldstein      2021-11-29  1124  						   unsigned int obj_type,
77115225acc67d Amir Goldstein      2019-01-10  1125  						   __kernel_fsid_t *fsid)
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1126  {
5b8fea65d197f4 Amir Goldstein      2021-03-04  1127  	struct ucounts *ucounts = group->fanotify_data.ucounts;
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1128  	struct fsnotify_mark *mark;
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1129  	int ret;
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1130  
5b8fea65d197f4 Amir Goldstein      2021-03-04  1131  	/*
5b8fea65d197f4 Amir Goldstein      2021-03-04  1132  	 * Enforce per user marks limits per user in all containing user ns.
5b8fea65d197f4 Amir Goldstein      2021-03-04  1133  	 * A group with FAN_UNLIMITED_MARKS does not contribute to mark count
5b8fea65d197f4 Amir Goldstein      2021-03-04  1134  	 * in the limited groups account.
5b8fea65d197f4 Amir Goldstein      2021-03-04  1135  	 */
5b8fea65d197f4 Amir Goldstein      2021-03-04  1136  	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
5b8fea65d197f4 Amir Goldstein      2021-03-04  1137  	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1138  		return ERR_PTR(-ENOSPC);
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1139  
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1140  	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
5b8fea65d197f4 Amir Goldstein      2021-03-04  1141  	if (!mark) {
5b8fea65d197f4 Amir Goldstein      2021-03-04  1142  		ret = -ENOMEM;
5b8fea65d197f4 Amir Goldstein      2021-03-04  1143  		goto out_dec_ucounts;
5b8fea65d197f4 Amir Goldstein      2021-03-04  1144  	}
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1145  
054c636e5c8054 Jan Kara            2016-12-21  1146  	fsnotify_init_mark(mark, group);
ad69cd9972e79a Amir Goldstein      2021-11-29 @1147  	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1148  	if (ret) {
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1149  		fsnotify_put_mark(mark);
5b8fea65d197f4 Amir Goldstein      2021-03-04  1150  		goto out_dec_ucounts;
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1151  	}
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1152  
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1153  	return mark;
5b8fea65d197f4 Amir Goldstein      2021-03-04  1154  
5b8fea65d197f4 Amir Goldstein      2021-03-04  1155  out_dec_ucounts:
5b8fea65d197f4 Amir Goldstein      2021-03-04  1156  	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS))
5b8fea65d197f4 Amir Goldstein      2021-03-04  1157  		dec_ucount(ucounts, UCOUNT_FANOTIFY_MARKS);
5b8fea65d197f4 Amir Goldstein      2021-03-04  1158  	return ERR_PTR(ret);
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1159  }
5e9c070ca08543 Lino Sanfilippo     2013-07-08  1160  

:::::: The code at line 1147 was first introduced by commit
:::::: ad69cd9972e79aba103ba5365de0acd35770c265 fsnotify: clarify object type argument

:::::: TO: Amir Goldstein <amir73il@gmail.com>
:::::: CC: Jan Kara <jack@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
