Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1EE4DBA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358214AbiCPWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358208AbiCPWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:04:04 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF27E4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647468169; x=1679004169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qTtgAXflLmfsnz85R3066NEtQCvueUxMuKAlABoIAB4=;
  b=HkPnGWMGuzfr6gdjTeqDn2a/Oa4L12PhiIw64Y5PQPn6cM1doa2qYeKc
   X+46v30o0V7GI0NSPyw2oKHTINpHX5qwmcMSj2ITURdvQxqGO5P8XhkPJ
   uEqeFxvAYhipQ8uOuHebJagoWHT99yoGQAAjiVbYHHR+Bg/GRNKd+ksEP
   zfd2DvgYV65lna1tcIN+hLwsLrwFC3GzMWqeprOoHIr/cjcB2apPFbsAr
   CZz7c92SDwQ7Ovzx+U6QjhSoS3tzT/A7NhyTr0l3aOgVqXSwLWgvswAWJ
   CZbPlUz/Bt2BVhBNkLWRjnq72d4rLZgtV3ztTUanKm0Wc6BYcaijVe1CT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317442210"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317442210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516514827"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 15:02:47 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUbjC-000Czj-Ff; Wed, 16 Mar 2022 22:02:46 +0000
Date:   Thu, 17 Mar 2022 06:02:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [gfs2:for-next 11/11] fs/gfs2/file.c:796:10: warning: comparison of
 distinct pointer types ('typeof (size) *' (aka 'unsigned int *') and 'typeof
 (nr_dirtied * ((1UL) << 12)) *' (aka 'unsigned long *'))
Message-ID: <202203170509.i1rWdOA0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   a20050c14edf19add5a9588cb196bb00aa410650
commit: a20050c14edf19add5a9588cb196bb00aa410650 [11/11] gfs2: Add read/write page 'fault_stats'
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220317/202203170509.i1rWdOA0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=a20050c14edf19add5a9588cb196bb00aa410650
        git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
        git fetch --no-tags gfs2 for-next
        git checkout a20050c14edf19add5a9588cb196bb00aa410650
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/gfs2/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/gfs2/file.c:796:10: warning: comparison of distinct pointer types ('typeof (size) *' (aka 'unsigned int *') and 'typeof (nr_dirtied * ((1UL) << 12)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size = min(size, nr_dirtied * PAGE_SIZE);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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


vim +796 fs/gfs2/file.c

   772	
   773	static inline bool should_fault_in_pages(ssize_t ret, struct iov_iter *i,
   774						 size_t *prev_count,
   775						 size_t *window_size)
   776	{
   777		size_t count = iov_iter_count(i);
   778		size_t size, offs;
   779	
   780		if (likely(!count))
   781			return false;
   782		if (ret <= 0 && ret != -EFAULT)
   783			return false;
   784		if (!iter_is_iovec(i))
   785			return false;
   786	
   787		size = PAGE_SIZE;
   788		offs = offset_in_page(i->iov[0].iov_base + i->iov_offset);
   789		if (*prev_count != count || !*window_size) {
   790			int nr_dirtied;
   791	
   792			size = ALIGN(offs + count, PAGE_SIZE);
   793			size = min_t(size_t, size, SZ_1M);
   794			nr_dirtied = max(current->nr_dirtied_pause -
   795					 current->nr_dirtied, 8);
 > 796			size = min(size, nr_dirtied * PAGE_SIZE);
   797		}
   798	
   799		*prev_count = count;
   800		*window_size = size - offs;
   801		return true;
   802	}
   803	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
