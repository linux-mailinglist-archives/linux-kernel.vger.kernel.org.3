Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD67956C2BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiGHXDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiGHXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:03:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382EA371BD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657321394; x=1688857394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yloxL7jBcF9E8yBbZEf42R0LSZmPOFre9IbOm6O9CPg=;
  b=faJHyn0t2HE9o6lfZ2HKPTqRfChy4gGrPdk+r8YcnlRYfd5eFA4C5SFo
   Zc/mmWpL+DgdAn/tMXlQtWyyHhkqy0/sSWSmImgRXXN+Rl5tzH1Y9Xa17
   l0WmhORKMZsCFx/CsHfzl0qzGS90sfgFKVXTdtH+jRu7smp57cQMs74Am
   spoKisDMvsx60ChKrAWQcBHVy00oWdrzBqJ9ygUxDf0eBk8pmbyYpp/6Y
   Tb7fs72ccutjTadBbvjtvYEa7jpZaSieBGavKIbaPmMl19XrbuBhalqv+
   V9dXDLoL/lrX9DSAKDQEXnuo6HFn3WPzj/e9vjdgp/ya7R9g4TMA/RCh2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="309969400"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="309969400"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="594275684"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2022 16:03:12 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9x0B-000O26-Gy;
        Fri, 08 Jul 2022 23:03:11 +0000
Date:   Sat, 9 Jul 2022 07:02:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:ceph-netfs-llist 1/10] fs/afs/file.c:376:2: warning:
 #warning TRIGGER NEW FLUSH GROUP FOR TESTING
Message-ID: <202207090619.RyQJMYoY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-netfs-llist
head:   fd428464b2220bd6c59f0a30f9dadb4720b3efb5
commit: 3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca [1/10] netfs: Add a write context
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220709/202207090619.RyQJMYoY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-netfs-llist
        git checkout 3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/afs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:5,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from fs/afs/file.c:9:
   include/linux/page-flags.h: In function 'PageHead':
   include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
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
   fs/afs/file.c: In function 'afs_init_write_context':
>> fs/afs/file.c:376:2: warning: #warning TRIGGER NEW FLUSH GROUP FOR TESTING [-Wcpp]
     376 | #warning TRIGGER NEW FLUSH GROUP FOR TESTING
         |  ^~~~~~~


vim +376 fs/afs/file.c

   373	
   374	static int afs_init_write_context(struct netfs_write_context *write)
   375	{
 > 376	#warning TRIGGER NEW FLUSH GROUP FOR TESTING
   377		static atomic_t jump;
   378		return netfs_require_flush_group(write, (atomic_inc_return(&jump) & 3) == 3);
   379	}
   380	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
