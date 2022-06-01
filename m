Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6890E53B043
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiFAV3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiFAV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:29:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83025C64
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654118981; x=1685654981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XaUvMjPfT2W2aw+g9NxsIl0lvb5oDg2s1Bs/042+9Xo=;
  b=UcwZw704/hObeAWbnBZltrjTKLQqqkvqPYElzywpiftxmeV/JWDOs/5m
   /78/GOjyiF5xVlwxN3CtuZbQ45r052FaUVJLVF+xrgEbW1UnAXIBfSccp
   IR+fm60zLeg++mn7fuJWSHzWMVU7OcbM8Lru4Caal5ksEBDWcSZYAkirz
   SLToRgDPG47MX9kz3ambNQZLOMZTQZsB530Zv3TcRqbTGXID2fIsoV1Qg
   ar86HMKWe8ffhyb445Plf8+ECMu90k36H2mpFye9BkpU6rfGNl1OpQspY
   1Ctuo5nEKDzzBoHVzrkXkpLt46K55nLPa9bDRtYJSXJVxWhdzO9gZHjEs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="338781518"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="338781518"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 14:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="904650091"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2022 14:29:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwVu4-0004QC-Lx;
        Wed, 01 Jun 2022 21:29:20 +0000
Date:   Thu, 2 Jun 2022 05:28:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 37/59]
 fs/netfs/output.c:274:32: warning: unused variable 'cookie'
Message-ID: <202206020506.JJRuspb2-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   22ecc2fcdab4616e624408911ec1d54644e82030
commit: 5c1c3ba2afbf95dfbd1cb36cae7a28e20c4eaace [37/59] netfs: Dispatch write requests to process a writeback slice
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220602/202206020506.JJRuspb2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/5c1c3ba2afbf95dfbd1cb36cae7a28e20c4eaace
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 5c1c3ba2afbf95dfbd1cb36cae7a28e20c4eaace
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
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
