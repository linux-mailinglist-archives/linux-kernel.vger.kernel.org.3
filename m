Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915DE4D989A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345367AbiCOKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiCOKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:21:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA634DF59
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647339627; x=1678875627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k9uLRr3euQP1lrOixPwwAc4AMQgQ2GiQWQY3pIim4xo=;
  b=ZNZc45DzBhVvugloVzzO2bAu1YI3gMHYmng4CQDPplKi39UyRd2wimrS
   UOmC6/gncaIReuOGMlw8lU//c6IEWYzI6dyTe4YPYLhQRXyoFBHEtX4ic
   z0RXQFyFP7xDSMRGX/Jgtzk9Ry7sUXbo9GxfBVH8ygzI3L8M2t84JnCoK
   mb8GZP+PrhrD/3JOCmg4yWSbl8jKnzIZHQQLNq2KgiHSuyX881tVg/QT9
   319FZ8mmXMfqyThms4C9gGg6PcLiE9XOjnokRQlUrFVhS6nG+He+iijDY
   4MhBu52cw+sdfMX0whF9dXPBdTOukSR1pywlT909Zd76qfUEJxkBphrq7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255992303"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="255992303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="714104039"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 03:20:25 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU4Hw-000AqE-Os; Tue, 15 Mar 2022 10:20:24 +0000
Date:   Tue, 15 Mar 2022 18:20:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 164/179] fs/ceph/cache.h:139:36: error:
 passing argument 1 of 'filemap_dirty_folio' from incompatible pointer type
Message-ID: <202203151822.AxRLjKqE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   af564d7369d44fbbe697a5f631fe3bba5ebecd59
commit: 09f7fc259e5dd9ab97313b62bdfc9b56abf0ef1d [164/179] fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()
config: powerpc64-randconfig-m031-20220313 (https://download.01.org/0day-ci/archive/20220315/202203151822.AxRLjKqE-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 09f7fc259e5dd9ab97313b62bdfc9b56abf0ef1d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/super.c:22:
   fs/ceph/cache.h: In function 'ceph_fscache_dirty_folio':
>> fs/ceph/cache.h:139:36: error: passing argument 1 of 'filemap_dirty_folio' from incompatible pointer type [-Werror=incompatible-pointer-types]
     139 |         return filemap_dirty_folio(folio);
         |                                    ^~~~~
         |                                    |
         |                                    struct folio *
   In file included from include/linux/backing-dev.h:16,
                    from fs/ceph/super.c:5:
   include/linux/writeback.h:393:48: note: expected 'struct address_space *' but argument is of type 'struct folio *'
     393 | bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
         |                          ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   In file included from fs/ceph/super.c:22:
>> fs/ceph/cache.h:139:16: error: too few arguments to function 'filemap_dirty_folio'
     139 |         return filemap_dirty_folio(folio);
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/backing-dev.h:16,
                    from fs/ceph/super.c:5:
   include/linux/writeback.h:393:6: note: declared here
     393 | bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from fs/ceph/addr.c:19:
   fs/ceph/cache.h: In function 'ceph_fscache_dirty_folio':
>> fs/ceph/cache.h:139:36: error: passing argument 1 of 'filemap_dirty_folio' from incompatible pointer type [-Werror=incompatible-pointer-types]
     139 |         return filemap_dirty_folio(folio);
         |                                    ^~~~~
         |                                    |
         |                                    struct folio *
   In file included from include/linux/backing-dev.h:16,
                    from fs/ceph/addr.c:4:
   include/linux/writeback.h:393:48: note: expected 'struct address_space *' but argument is of type 'struct folio *'
     393 | bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
         |                          ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   In file included from fs/ceph/addr.c:19:
>> fs/ceph/cache.h:139:16: error: too few arguments to function 'filemap_dirty_folio'
     139 |         return filemap_dirty_folio(folio);
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/backing-dev.h:16,
                    from fs/ceph/addr.c:4:
   include/linux/writeback.h:393:6: note: declared here
     393 | bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from fs/ceph/addr.c:19:
   fs/ceph/cache.h:140:1: error: control reaches end of non-void function [-Werror=return-type]
     140 | }
         | ^
   cc1: some warnings being treated as errors


vim +/filemap_dirty_folio +139 fs/ceph/cache.h

   135	
   136	static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
   137			struct folio *folio)
   138	{
 > 139		return filemap_dirty_folio(folio);
   140	}
   141	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
