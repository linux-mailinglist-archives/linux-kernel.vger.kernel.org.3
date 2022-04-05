Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10034F5133
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845402AbiDFBy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380517AbiDELmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:42:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2A10CF2A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649156827; x=1680692827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e1INeSFg7esnR3hcJTDuT1auTFvTvVTZvHOFhQxsoT4=;
  b=UERP7xjelMVBrbB6uANhWzPE/RQU/fOg9qnPa9dH1coLkYLrQKKZpJXP
   tpky6uI47tSsuPhUTbVI53Qpr1nb0EsJLWLdRSuiV5qZQcHT8TFZz58M3
   AYgllhpp6WLTRHGuLV4EiYf/t2NQfNN2szdHb6FOMh3pUZ/oDUn5s2Aoa
   geJKEbtj65vWMmyekBuPPw/6N1xbLMcoIV10aXcZDAX7lw5kSD16x2EGh
   gjrw+YSAtURoLrngm5qq+vG+IiKP04sIQHgzQlqPdUPSm+6gmUTpZvL4G
   phPqdlIAIKXUafibAZyaxUSSX05IBZqAJjCKDMm0ZhRyld7uIg3DGLqid
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258306556"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258306556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523416957"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 04:07:05 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbh1c-00036b-SH;
        Tue, 05 Apr 2022 11:07:04 +0000
Date:   Tue, 5 Apr 2022 19:07:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 26/40]
 fs/netfs/crypto.c:76:31: sparse: sparse: incompatible types in comparison
 expression (different type sizes):
Message-ID: <202204051933.fe6riDOF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: fc693b2e39df6567a0312f21bb9004e1d7983286 [26/40] netfs: Perform content encryption
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220405/202204051933.fe6riDOF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/fc693b2e39df6567a0312f21bb9004e1d7983286
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout fc693b2e39df6567a0312f21bb9004e1d7983286
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/crypto.c:76:31: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/netfs/crypto.c:76:31: sparse:    unsigned int *
>> fs/netfs/crypto.c:76:31: sparse:    unsigned long *

vim +76 fs/netfs/crypto.c

    45	
    46	/*
    47	 * Populate a scatterlist from folios in an xarray.
    48	 */
    49	static int netfs_xarray_to_sglist(struct xarray *xa, loff_t pos, size_t len,
    50					  struct scatterlist *sg, unsigned int n_sg)
    51	{
    52		struct scatterlist *p = sg;
    53		struct folio *folio = NULL;
    54		size_t seg, offset, skip = 0;
    55		loff_t start = pos;
    56		pgoff_t index = start >> PAGE_SHIFT;
    57		int j;
    58	
    59		XA_STATE(xas, xa, index);
    60	
    61		sg_init_table(sg, n_sg);
    62	
    63		rcu_read_lock();
    64	
    65		xas_for_each(&xas, folio, ULONG_MAX) {
    66			if (xas_retry(&xas, folio))
    67				continue;
    68			if (WARN_ON(xa_is_value(folio)) || WARN_ON(folio_test_hugetlb(folio)))
    69				break;
    70			for (j = (folio_index(folio) < index) ? index - folio_index(folio) : 0;
    71			     j < folio_nr_pages(folio); j++
    72			     ) {
    73				struct page *subpage = folio_file_page(folio, j);
    74	
    75				offset = (pos + skip) & ~PAGE_MASK;
  > 76				seg = min(len, PAGE_SIZE - offset);
    77	
    78				sg_set_page(p++, subpage, seg, offset);
    79	
    80				len -= seg;
    81				skip += seg;
    82				if (len == 0)
    83					break;
    84			}
    85			if (len == 0)
    86				break;
    87		}
    88	
    89		rcu_read_unlock();
    90		if (len > 0) {
    91			kdebug("*** Insufficient source (%zx)", len);
    92			//WARN_ON(len > 0);
    93			return -EIO;
    94		}
    95	
    96		sg_mark_end(p - 1);
    97		return p - sg;
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
