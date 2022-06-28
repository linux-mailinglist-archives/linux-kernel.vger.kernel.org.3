Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF455F164
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiF1W2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiF1W2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:28:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8701AF13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656455319; x=1687991319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nutrIfJ7v8MDpjfwMMUwW/irXHXX0D/R0suv+opyGLM=;
  b=ncL69t3dFEJ53u9URU4ezTVd5SG0a40iydRuPG2n9iROgSuIj6L5/UUJ
   juRsa76GvBhFLE92LaYJWg7+1nwWyEFq6/JbzYqi9ufmPmicjf7EZhB8g
   d/dax1nh3aFV67/X3dY4tYzYvdKnjOeXrysqmCfgXrpRp4lRmpoM1mRAu
   Z8nZDEu5AprejV1JIqHAwuIlmyrcRXkzpoulhooSgNM08SHlbon7srrmi
   7dlLCS0t+t9rVspJuCczkqOMC6TCJgjMBOJ5d2XQhBpZbnm1lJslXDonn
   c2CJ/fKM1a5S/5y5aO/DkYaD86jEFRARC54Op+7z1dTDTBMjq8e+UX7Ju
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368177728"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="368177728"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="540641517"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 15:28:37 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6JhF-000Agf-07;
        Tue, 28 Jun 2022 22:28:37 +0000
Date:   Wed, 29 Jun 2022 06:28:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:netfs-linked-list 26/54] include/linux/page-flags.h:788:27:
 error: passing argument 1 of 'dump_page' discards 'const' qualifier from
 pointer target type
Message-ID: <202206290625.KP0q3MpI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git netfs-linked-list
head:   d35a2461e039c9131e97bb125eac59a0f04e9161
commit: 06b03c53376206f3b98cc4dbb1f061a10085309b [26/54] mm: Make some folio function arguments const
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220629/202206290625.KP0q3MpI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=06b03c53376206f3b98cc4dbb1f061a10085309b
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton netfs-linked-list
        git checkout 06b03c53376206f3b98cc4dbb1f061a10085309b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/gfp.h:5,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from lib/test_bitops.c:9:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: error: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   cc1: all warnings being treated as errors


vim +788 include/linux/page-flags.h

e7d324850bfcb3 Muchun Song   2022-03-22  785  
06b03c53376206 David Howells 2022-06-08  786  static __always_inline int PageHead(const struct page *page)
e7d324850bfcb3 Muchun Song   2022-03-22  787  {
e7d324850bfcb3 Muchun Song   2022-03-22 @788  	PF_POISONED_CHECK(page);
e7d324850bfcb3 Muchun Song   2022-03-22  789  	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
e7d324850bfcb3 Muchun Song   2022-03-22  790  }
e7d324850bfcb3 Muchun Song   2022-03-22  791  

:::::: The code at line 788 was first introduced by commit
:::::: e7d324850bfcb30df563d144c0363cc44595277d mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page

:::::: TO: Muchun Song <songmuchun@bytedance.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
