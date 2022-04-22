Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0150C518
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiDVXhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiDVXg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:36:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772506FF75
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650669745; x=1682205745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JACMD5EWiaOfR7L52fRfPgQQApOCo17lhZOUZruR7fo=;
  b=E0a2mJnizeRLZzcZ33bxnzwcKg/YYufswaszTApHONw9M/AiyR1HJudt
   B+WEHV8pqf3jETIl7fa7eXE85+1/kPvFOAonHe4UDo4Axc+/ep2TTK0f+
   RNAXojd1PqZj6Rdes6sGOSTgkHSxMltVDLMgGoe7yvEA3XI9OdbbYpVRX
   PBJV59U07rTpMN3KrqAi78WEJz3uhqd3reBiMxDgesYoPcMnQ2tMklBX0
   zc1geI39cvpTLH7/BAghnQvQ2rhBTcdE2HLYxTteKCFyeNH6nJcPmCqjC
   3FY7+IvvXzX+WkuNVHgR0Ju3AEG7/lodnRWrSADzaVbvNiUvPN1gO4Wv1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263660109"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="263660109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="703743706"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2022 16:22:23 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni2bX-000Aep-7R;
        Fri, 22 Apr 2022 23:22:23 +0000
Date:   Sat, 23 Apr 2022 07:22:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 28/44]
 fs/netfs/crypto.c:76:10: warning: comparison of distinct pointer types
 ('typeof (len) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12) -
 offset) *' (aka 'unsigned long *'))
Message-ID: <202204230710.ewAqNDow-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 777536e6af57becf14b8f4f34007ed3e3a95c911 [28/44] netfs: Perform content encryption
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220423/202204230710.ewAqNDow-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/777536e6af57becf14b8f4f34007ed3e3a95c911
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 777536e6af57becf14b8f4f34007ed3e3a95c911
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/crypto.c:76:10: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12) - offset) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                           seg = min(len, PAGE_SIZE - offset);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


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
