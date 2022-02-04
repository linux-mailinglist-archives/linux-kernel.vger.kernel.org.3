Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53144A9200
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356524AbiBDB3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:29:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:29112 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356496AbiBDB3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938188; x=1675474188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqRXEq5eFQAFL9s4JP+oZ1EPgm3GgJ9ZI0T/Aex6awE=;
  b=ck+KfyoLwjx+na77pkUHIR9yujryw0LwW8d8d/bU0Z+WOlu1YMcghO7N
   azKig+GLYoukP/THNtTj8ZcetnbWf3Jvgyn1GEo+iTF8V3oI7IKtAATnj
   y2lMrU+R6Zu5GNHLUfYBnGJpDWq5Se4sila5ASZGYA6xkue4P+bdyu7gU
   jDOdVLrL/TCmYWfdKxfcab7IWUxS8cSa2ONUqx1Rl3VC6cznIYD/cYF0J
   SyPNhrLhExbJpoE0iukMoLZAMTRNrVdZfjF+FfSw1OFtAB8ojgOJ9iWb9
   LSL2GSmq0z5f+y3iXOHPtUEDs/m+nouKHz7tWm4m+Z2g7A5hSXhwKOHrT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="247124384"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="247124384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="769821121"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Feb 2022 17:29:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnQ0-000Wtj-E4; Fri, 04 Feb 2022 01:29:44 +0000
Date:   Fri, 4 Feb 2022 09:29:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
Message-ID: <202202040109.d4u6Jwvm-lkp@intel.com>
References: <20220203131237.298090-1-pedrodemargomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131237.298090-1-pedrodemargomes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pedro,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Pedro-Demarchi-Gomes/mm-damon-Add-option-to-monitor-only-writes/20220203-211407
base:   https://github.com/hnaz/linux-mm master
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220204/202202040109.d4u6Jwvm-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0958bb7e2514b62f174b8e5ccfdcff07ce2a2b6b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Pedro-Demarchi-Gomes/mm-damon-Add-option-to-monitor-only-writes/20220203-211407
        git checkout 0958bb7e2514b62f174b8e5ccfdcff07ce2a2b6b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h: In function 'damon_test_merge_two':
   mm/damon/core-test.h:154:33: error: passing argument 1 of 'damon_merge_two_regions' from incompatible pointer type [-Werror=incompatible-pointer-types]
     154 |         damon_merge_two_regions(t, r, r2);
         |                                 ^
         |                                 |
         |                                 struct damon_target *
   mm/damon/core.c:761:55: note: expected 'struct damon_ctx *' but argument is of type 'struct damon_target *'
     761 | static void damon_merge_two_regions(struct damon_ctx *c, struct damon_target *t,
         |                                     ~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h:154:36: error: passing argument 2 of 'damon_merge_two_regions' from incompatible pointer type [-Werror=incompatible-pointer-types]
     154 |         damon_merge_two_regions(t, r, r2);
         |                                    ^
         |                                    |
         |                                    struct damon_region *
   mm/damon/core.c:761:79: note: expected 'struct damon_target *' but argument is of type 'struct damon_region *'
     761 | static void damon_merge_two_regions(struct damon_ctx *c, struct damon_target *t,
         |                                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h:154:9: error: too few arguments to function 'damon_merge_two_regions'
     154 |         damon_merge_two_regions(t, r, r2);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:761:13: note: declared here
     761 | static void damon_merge_two_regions(struct damon_ctx *c, struct damon_target *t,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h: In function 'damon_test_merge_regions_of':
   mm/damon/core-test.h:201:32: error: passing argument 1 of 'damon_merge_regions_of' from incompatible pointer type [-Werror=incompatible-pointer-types]
     201 |         damon_merge_regions_of(t, 9, 9999);
         |                                ^
         |                                |
         |                                struct damon_target *
   mm/damon/core.c:787:54: note: expected 'struct damon_ctx *' but argument is of type 'struct damon_target *'
     787 | static void damon_merge_regions_of(struct damon_ctx *c, struct damon_target *t, unsigned int thres,
         |                                    ~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1123:
>> mm/damon/core-test.h:201:35: warning: passing argument 2 of 'damon_merge_regions_of' makes pointer from integer without a cast [-Wint-conversion]
     201 |         damon_merge_regions_of(t, 9, 9999);
         |                                   ^
         |                                   |
         |                                   int
   mm/damon/core.c:787:78: note: expected 'struct damon_target *' but argument is of type 'int'
     787 | static void damon_merge_regions_of(struct damon_ctx *c, struct damon_target *t, unsigned int thres,
         |                                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h:201:9: error: too few arguments to function 'damon_merge_regions_of'
     201 |         damon_merge_regions_of(t, 9, 9999);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:787:13: note: declared here
     787 | static void damon_merge_regions_of(struct damon_ctx *c, struct damon_target *t, unsigned int thres,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from include/trace/events/damon.h:43,
                    from mm/damon/core.c:19:
   At top level:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/damon_merge_regions_of +201 mm/damon/core-test.h

17ccae8bb5c9289 SeongJae Park 2021-09-07  181  
17ccae8bb5c9289 SeongJae Park 2021-09-07  182  static void damon_test_merge_regions_of(struct kunit *test)
17ccae8bb5c9289 SeongJae Park 2021-09-07  183  {
17ccae8bb5c9289 SeongJae Park 2021-09-07  184  	struct damon_target *t;
17ccae8bb5c9289 SeongJae Park 2021-09-07  185  	struct damon_region *r;
17ccae8bb5c9289 SeongJae Park 2021-09-07  186  	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
17ccae8bb5c9289 SeongJae Park 2021-09-07  187  	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
17ccae8bb5c9289 SeongJae Park 2021-09-07  188  	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
17ccae8bb5c9289 SeongJae Park 2021-09-07  189  
17ccae8bb5c9289 SeongJae Park 2021-09-07  190  	unsigned long saddrs[] = {0, 114, 130, 156, 170};
17ccae8bb5c9289 SeongJae Park 2021-09-07  191  	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
17ccae8bb5c9289 SeongJae Park 2021-09-07  192  	int i;
17ccae8bb5c9289 SeongJae Park 2021-09-07  193  
17ccae8bb5c9289 SeongJae Park 2021-09-07  194  	t = damon_new_target(42);
17ccae8bb5c9289 SeongJae Park 2021-09-07  195  	for (i = 0; i < ARRAY_SIZE(sa); i++) {
17ccae8bb5c9289 SeongJae Park 2021-09-07  196  		r = damon_new_region(sa[i], ea[i]);
17ccae8bb5c9289 SeongJae Park 2021-09-07  197  		r->nr_accesses = nrs[i];
17ccae8bb5c9289 SeongJae Park 2021-09-07  198  		damon_add_region(r, t);
17ccae8bb5c9289 SeongJae Park 2021-09-07  199  	}
17ccae8bb5c9289 SeongJae Park 2021-09-07  200  
17ccae8bb5c9289 SeongJae Park 2021-09-07 @201  	damon_merge_regions_of(t, 9, 9999);
17ccae8bb5c9289 SeongJae Park 2021-09-07  202  	/* 0-112, 114-130, 130-156, 156-170 */
17ccae8bb5c9289 SeongJae Park 2021-09-07  203  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
17ccae8bb5c9289 SeongJae Park 2021-09-07  204  	for (i = 0; i < 5; i++) {
17ccae8bb5c9289 SeongJae Park 2021-09-07  205  		r = __nth_region_of(t, i);
17ccae8bb5c9289 SeongJae Park 2021-09-07  206  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
17ccae8bb5c9289 SeongJae Park 2021-09-07  207  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
17ccae8bb5c9289 SeongJae Park 2021-09-07  208  	}
17ccae8bb5c9289 SeongJae Park 2021-09-07  209  	damon_free_target(t);
17ccae8bb5c9289 SeongJae Park 2021-09-07  210  }
17ccae8bb5c9289 SeongJae Park 2021-09-07  211  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
