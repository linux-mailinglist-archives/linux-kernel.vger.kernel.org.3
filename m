Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B37538844
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiE3Ujq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiE3Ujj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:39:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB654F97
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653943177; x=1685479177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QTkIl0vdLXId/U9IUXO3ODj7+mfYPr8/vzuTi/UY4VI=;
  b=YitZuIYBTg8qmuUbKSSLGkKawsV5RYF2FDsZ8SnPEN1loqjphIZ/SkuV
   COs+Q0kAZs+15H9Uwk8ZPGLiVf28rJdJpYbtBhCzCKHcWzpEkPkkDJHx5
   oba1o0jxdrxvDOXD81HxJHK1sBfnpcTMGHfJDFIejivhPuVhqUCejU7Fi
   tG7iXH4n1ygE1GtvCzvi0e8FzoIJF3IaFGJWzJdriokvfunXzZmkMB9CF
   r/FT8eEO2Z75XVBI2YKWXxT7s09ZqrzTpdc2LUvugEH0EhCg/oUOR+Npj
   ptasfAWJxG30udzuBMSsIUZFUYdwMgXp+gZOnjeAJNhpofBlNgm9LMeMF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275077655"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="275077655"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 13:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="706279638"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 13:39:34 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvmAn-0001yY-OI;
        Mon, 30 May 2022 20:39:33 +0000
Date:   Tue, 31 May 2022 04:38:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 40/41]
 fs/netfs/io.c:596:15: warning: variable 'ix' set but not used
Message-ID: <202205310415.IRC0glkJ-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-netfs
head:   1fc71b6b30f6d2a981c163b77c9aee0aecaecb29
commit: 4efb4efb053eca8b1e75a9242112e8e159baab68 [40/41] fixes
config: x86_64-randconfig-a011-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310415.IRC0glkJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4efb4efb053eca8b1e75a9242112e8e159baab68
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
        git checkout 4efb4efb053eca8b1e75a9242112e8e159baab68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/io.c:596:15: warning: variable 'ix' set but not used [-Wunused-but-set-variable]
           unsigned int ix = 0, nsegs = 0;
                        ^
   1 warning generated.


vim +/ix +596 fs/netfs/io.c

   586	
   587	/*
   588	 * Select the span of an xarray iterator we're going to use.  Limit it by both
   589	 * maximum size and maximum number of segments.  It is assumed that segments
   590	 * can be larger than a page in size, provided they're physically contiguous.
   591	 */
   592	static size_t netfs_limit_xarray(struct iov_iter *iter, size_t start_offset,
   593					 size_t max_size, size_t max_segs)
   594	{
   595		struct folio *folio;
 > 596		unsigned int ix = 0, nsegs = 0;
   597		loff_t pos = iter->xarray_start + iter->iov_offset;
   598		pgoff_t index = pos / PAGE_SIZE;
   599		size_t span = 0, n = iter->count;
   600	
   601		XA_STATE(xas, iter->xarray, index);
   602	
   603		if (WARN_ON(!iov_iter_is_xarray(iter)) ||
   604		    WARN_ON(start_offset > n) ||
   605		    n == 0)
   606			return 0;
   607		max_size = min(max_size, n - start_offset);
   608	
   609		rcu_read_lock();
   610		xas_for_each(&xas, folio, ULONG_MAX) {
   611			size_t offset, flen, len;
   612			if (xas_retry(&xas, folio))
   613				continue;
   614			if (WARN_ON(xa_is_value(folio)))
   615				break;
   616			if (WARN_ON(folio_test_hugetlb(folio)))
   617				break;
   618	
   619			flen = folio_size(folio);
   620			offset = offset_in_folio(folio, pos);
   621			len = min(max_size, flen - offset);
   622			span += len;
   623			nsegs++;
   624			ix++;
   625			if (span >= max_size || nsegs >= max_segs)
   626				break;
   627		}
   628	
   629		rcu_read_unlock();
   630		return min(span, max_size);
   631	}
   632	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
