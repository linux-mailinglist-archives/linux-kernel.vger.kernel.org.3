Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF8562789
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiGAAJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGAAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:09:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C34D4D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656634159; x=1688170159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nDha/9xVCzCx0c/TegLGOLnxq5FBcaBT4tgYPNP3d0s=;
  b=Cn0gjjyC2mGIN/UE2j02YOpNwaNHdjLLuQt4w/+YUYBHjafi7vGg1RuG
   1j00eg1SOV++Up6+BJ1NhSw+jzMHOdHqSgmba/Wr4oUV97W5ergmSKKnL
   87Q1DkF44MyeCw7Qk+KML9MHFOs/TKORWWxIsVL/HsxOOlOWwFR/2V5Ke
   AwXF17jcDeB1160Qu1wpU/ZC1j8VSEZZw2s/N8nv5o3+mpvLmZn0sm/IR
   PY6IesL4BNaycqcqBTPe99kgLtTpdxUQ32ZzunikRe1AL5Xk8ngt4psAL
   hxQUSfc79bX4FYzcGsnsH4Agr+Qx4jyl0tbEMvcHCBs9m9UyH0OnFhnmr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271274972"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="271274972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 17:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="596025463"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 17:09:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o74Dk-000DL8-HW;
        Fri, 01 Jul 2022 00:09:16 +0000
Date:   Fri, 1 Jul 2022 08:08:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 56/56]
 include/linux/fscache.h:387: undefined reference to
 `__fscache_resize_cookie'
Message-ID: <202207010846.LBBlghEK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   acac17cdb0f9f6db9fc03eea371e399906146f96
commit: acac17cdb0f9f6db9fc03eea371e399906146f96 [56/56] netfs: Implement truncation
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220701/202207010846.LBBlghEK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/acac17cdb0f9f6db9fc03eea371e399906146f96
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout acac17cdb0f9f6db9fc03eea371e399906146f96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/netfs/truncate.o: in function `fscache_resize_cookie':
>> include/linux/fscache.h:387: undefined reference to `__fscache_resize_cookie'
   ld: fs/9p/vfs_addr.o:(.rodata+0x138): undefined reference to `fscache_begin_cache_operation'


vim +387 include/linux/fscache.h

ed1235eb78a742 David Howells 2021-10-20  372  
16a96bdf92d5af David Howells 2021-10-20  373  /**
16a96bdf92d5af David Howells 2021-10-20  374   * fscache_resize_cookie - Request that a cache object be resized
16a96bdf92d5af David Howells 2021-10-20  375   * @cookie: The cookie representing the cache object
16a96bdf92d5af David Howells 2021-10-20  376   * @new_size: The new size of the object (may be NULL)
16a96bdf92d5af David Howells 2021-10-20  377   *
16a96bdf92d5af David Howells 2021-10-20  378   * Request that the size of an object be changed.
16a96bdf92d5af David Howells 2021-10-20  379   *
16a96bdf92d5af David Howells 2021-10-20  380   * See Documentation/filesystems/caching/netfs-api.txt for a complete
16a96bdf92d5af David Howells 2021-10-20  381   * description.
16a96bdf92d5af David Howells 2021-10-20  382   */
16a96bdf92d5af David Howells 2021-10-20  383  static inline
16a96bdf92d5af David Howells 2021-10-20  384  void fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
16a96bdf92d5af David Howells 2021-10-20  385  {
16a96bdf92d5af David Howells 2021-10-20  386  	if (fscache_cookie_enabled(cookie))
16a96bdf92d5af David Howells 2021-10-20 @387  		__fscache_resize_cookie(cookie, new_size);
16a96bdf92d5af David Howells 2021-10-20  388  }
16a96bdf92d5af David Howells 2021-10-20  389  

:::::: The code at line 387 was first introduced by commit
:::::: 16a96bdf92d5af06f9fa6a01a4b08e2fdfed2e5b fscache: Provide a function to resize a cookie

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
