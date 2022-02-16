Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8424B7F94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiBPEkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:40:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344443AbiBPEki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:40:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF7F4063
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644986425; x=1676522425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=45p/ccbSCLZriz24oHxlzVsHh2l6gck3wzaVxMC4XcA=;
  b=KThTMTaHqs3a6hLvIeh7knwnYDLIPF+iXXZEU0qk+jTroz9fY5Bl/yM1
   4I69AyHCp5C0tDGtS38kn1eEclXgLcPCeYNQx0gTyz3fZPi+T9NA99Tir
   knlbgQPq9Z32n/bt+LfDZGULBljFjyHgIOVBwov94ET0BqsOFXh9cgpa4
   i8i7Us2z8MAYj7JJXDXjebkf0LnfnMQwDcUM7TLNgru/17JN2a9p04IbU
   sR55PIjgPtppdmErG9Bd3OyqDoBIS0Hs+qjn72WPo/STwVs3HcdCK4sY4
   21IktMSs/WdyY+mUmmq2wtHDhNbnkIhLGuY+eZOMI+6wpRTnN0KGu83Tw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="249354440"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="249354440"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="625215334"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Feb 2022 20:40:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKC75-000APT-HV; Wed, 16 Feb 2022 04:40:23 +0000
Date:   Wed, 16 Feb 2022 12:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 9/43]
 fs/9p/vfs_inode.c:258:5: error: 'struct netfs_i_context' has no member named
 'wsize'
Message-ID: <202202161243.Gj2NbDFG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   d40df0841e9f8de3713a19dd3f0ba283c860cb93
commit: 90870fcbed9794a03bee7aba8195e8c43e46e1dd [9/43] netfs: Add a netfs inode context
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220216/202202161243.Gj2NbDFG-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/90870fcbed9794a03bee7aba8195e8c43e46e1dd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 90870fcbed9794a03bee7aba8195e8c43e46e1dd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/9p/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/dhowells/linux-fs/netfs-maple HEAD d40df0841e9f8de3713a19dd3f0ba283c860cb93 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   fs/9p/vfs_inode.c: In function 'v9fs_set_netfs_context':
>> fs/9p/vfs_inode.c:258:5: error: 'struct netfs_i_context' has no member named 'wsize'
     258 |  ctx->wsize = 1024 * 1024;
         |     ^~


vim +258 fs/9p/vfs_inode.c

   249	
   250	/*
   251	 * Set parameters for the netfs library
   252	 */
   253	static void v9fs_set_netfs_context(struct inode *inode)
   254	{
   255		struct netfs_i_context *ctx = netfs_i_context(inode);
   256	
   257		netfs_i_context_init(inode, &v9fs_req_ops);
 > 258		ctx->wsize = 1024 * 1024;
   259	}
   260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
