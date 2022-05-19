Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17852CB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiESF3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiESF3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:29:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D001145C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652938184; x=1684474184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vNJfSjbFT0fZfx23OXyNSXAesiZ6up1NaTEl+zvkJ5k=;
  b=aPn12FLh3z+ZGZQtGnlrjfzILnSUvqonbVy2FIi2Ynj5yWMiz3/Br8qm
   zqyY1JsEsyjzO2uhT3vJvrFnnePXSQd3SuPMMMmpmihY7/Y954iIyu43E
   bt+It8bs/1LDLOKX9QlOOhYCDGz1rs8mhuaIcG1AiPPuFe9J7xal4Fphm
   Iu4PaKDxI8Rqrut40fNCyGc4vrHySDjRjgYFA/8JgdUZuUTGDzHJ6FVy8
   6Dj/x2+9MOG3dv+i03HR23ekNWKXLhnebP/amlllVfEf9gldFMFyMEu2f
   YZ7pkjUfQ3ifop2IgKYCDPj2nbZRY+CI+ydU5H7Bds7NEsx328ICLo1wT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271984356"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="271984356"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 22:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="661518272"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 May 2022 22:29:42 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrYjF-00037D-Tt;
        Thu, 19 May 2022 05:29:41 +0000
Date:   Thu, 19 May 2022 13:29:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:ceph-netfs-llist 26/51] fs/netfs/output.c:274:32: warning:
 unused variable 'cookie'
Message-ID: <202205191357.rJyD2yOh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-netfs-llist
head:   33ef80e1351d57c7496e3dfb6974767f4493dd91
commit: 7bf4565326b2233dacf25020fc700d70a231a694 [26/51] netfs: Dispatch write requests to process a writeback slice
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220519/202205191357.rJyD2yOh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=7bf4565326b2233dacf25020fc700d70a231a694
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-netfs-llist
        git checkout 7bf4565326b2233dacf25020fc700d70a231a694
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/netfs/output.c: In function 'netfs_set_up_write_to_cache':
>> fs/netfs/output.c:274:32: warning: unused variable 'cookie' [-Wunused-variable]
     274 |         struct fscache_cookie *cookie = netfs_i_cookie(wreq->inode);
         |                                ^~~~~~


vim +/cookie +274 fs/netfs/output.c

   266	
   267	/*
   268	 * Set up a op for writing to the cache.
   269	 */
   270	static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
   271	{
   272		struct netfs_cache_resources *cres;
   273		struct netfs_io_subrequest *subreq;
 > 274		struct fscache_cookie *cookie = netfs_i_cookie(wreq->inode);
   275		loff_t start = wreq->first * PAGE_SIZE;
   276		size_t len = (wreq->last - wreq->first + 1) * PAGE_SIZE;
   277		int ret;
   278	
   279		if (!fscache_cookie_enabled(cookie)) {
   280			clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags);
   281			return;
   282		}
   283	
   284		_debug("write to cache");
   285		subreq = netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start, len,
   286						    netfs_write_to_cache_op_worker);
   287		if (!subreq)
   288			return;
   289	
   290		cres = &wreq->cache_resources;
   291		ret = -ENOBUFS;
   292		if (wreq->netfs_ops->begin_cache_operation)
   293			ret = wreq->netfs_ops->begin_cache_operation(wreq);
   294		if (ret < 0) {
   295			netfs_write_subrequest_terminated(subreq, ret, false);
   296			return;
   297		}
   298	
   299		ret = cres->ops->prepare_write(cres, &start, &len, i_size_read(wreq->inode),
   300					       true);
   301		if (ret < 0) {
   302			netfs_write_subrequest_terminated(subreq, ret, false);
   303			return;
   304		}
   305	
   306		netfs_queue_write_request(subreq);
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
