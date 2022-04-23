Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB150C9E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiDWM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiDWM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:27:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85605BEE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650716698; x=1682252698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o1f+T3LaJqFnpKfN5ykKQ1cYz0Qln59Ix3NT/uTK1vQ=;
  b=ZqvlYeREWGiuO1jJbkfQWrSz252BtBE2dOIajTvZg10AAsds3vmpA1b+
   gQQRPQdqWEzPDO4dl6SutOv9IAns+VjwDlqc1W94YOfP5hfTDRFX/KjAN
   31FoSVLRsJEi/7mc/osHRqOucNfa7wfifUuXajchy61KNhbGXnKE9scfC
   b79vXv0nX2UPtfkUngVVi9Dqrc9OOtKZsqn0Ib46M90VI0jZYofYs+hep
   cpVr20amuaUYZL20i2TVfFfCkoHgd/PM4+g5818BBHMXIr6fQ27IDyzgx
   qnDKa/o1fH5urgxt6ugjKmuE7ETSKoCQ23VuVU4Pda2SBuu+F2CpmWrU6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264383513"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="264383513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 05:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="511932564"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2022 05:24:56 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niEoq-0000HN-15;
        Sat, 23 Apr 2022 12:24:56 +0000
Date:   Sat, 23 Apr 2022 20:24:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 28/44]
 fs/netfs/crypto.c:76:31: sparse: sparse: incompatible types in comparison
 expression (different type sizes):
Message-ID: <202204232031.0Hw9DMix-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 777536e6af57becf14b8f4f34007ed3e3a95c911 [28/44] netfs: Perform content encryption
config: arc-randconfig-s032-20220422 (https://download.01.org/0day-ci/archive/20220423/202204232031.0Hw9DMix-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/777536e6af57becf14b8f4f34007ed3e3a95c911
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 777536e6af57becf14b8f4f34007ed3e3a95c911
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash fs/netfs/

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
