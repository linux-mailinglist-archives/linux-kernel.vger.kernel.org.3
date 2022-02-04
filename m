Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24034A9208
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356535AbiBDBbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:31:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:25359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233523AbiBDBbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938308; x=1675474308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKNC38QQkoLEjYU35h7X8RwRTVXCa4g9SQ2zWIQ3890=;
  b=Mm+GE4FcjTQSAQGK8Kec+7n1/k1cCqo1yFMYC5fWQA5RiBeho3PsZ95r
   rLIbtrd2y/JsiC0zfcN+A3hnCu3SVd2bc+4US8bOw3Z2fo7E5nokfuG5s
   OPt6o9e8Ny21/DS5jpsFcgzbwN4SVA8R60CcFPkkVJrbJ3eaWnsGwTjWs
   DerLSpgLB08H/JIEhQasF+rAKeaprbA6XKEfgidkhtHJgFkpA6yGomH7C
   2Xg2MvaAFl4z95Ud5hc+0mau0zLxHHaokwhmJDW80LBqItLrCkXW12DpC
   rdIBzIUj5nJtLphLvS8178IQ9E9g50HTYS69+bWVLOkFUn8OPH3kEi/2q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="272790984"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="272790984"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="498347235"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2022 17:31:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnRx-000Ww5-3R; Fri, 04 Feb 2022 01:31:45 +0000
Date:   Fri, 4 Feb 2022 09:30:46 +0800
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
Message-ID: <202202040626.isVzU9Xl-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Pedro-Demarchi-Gomes/mm-damon-Add-option-to-monitor-only-writes/20220203-211407
base:   https://github.com/hnaz/linux-mm master
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220204/202202040626.isVzU9Xl-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h: In function 'damon_test_merge_two':
>> mm/damon/core-test.h:154:33: error: passing argument 1 of 'damon_merge_two_regions' from incompatible pointer type [-Werror=incompatible-pointer-types]
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
>> mm/damon/core-test.h:154:9: error: too few arguments to function 'damon_merge_two_regions'
     154 |         damon_merge_two_regions(t, r, r2);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:761:13: note: declared here
     761 | static void damon_merge_two_regions(struct damon_ctx *c, struct damon_target *t,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h: In function 'damon_test_merge_regions_of':
>> mm/damon/core-test.h:201:32: error: passing argument 1 of 'damon_merge_regions_of' from incompatible pointer type [-Werror=incompatible-pointer-types]
     201 |         damon_merge_regions_of(t, 9, 9999);
         |                                ^
         |                                |
         |                                struct damon_target *
   mm/damon/core.c:787:54: note: expected 'struct damon_ctx *' but argument is of type 'struct damon_target *'
     787 | static void damon_merge_regions_of(struct damon_ctx *c, struct damon_target *t, unsigned int thres,
         |                                    ~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1123:
   mm/damon/core-test.h:201:35: warning: passing argument 2 of 'damon_merge_regions_of' makes pointer from integer without a cast [-Wint-conversion]
     201 |         damon_merge_regions_of(t, 9, 9999);
         |                                   ^
         |                                   |
         |                                   int
   mm/damon/core.c:787:78: note: expected 'struct damon_target *' but argument is of type 'int'
     787 | static void damon_merge_regions_of(struct damon_ctx *c, struct damon_target *t, unsigned int thres,
         |                                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1123:
>> mm/damon/core-test.h:201:9: error: too few arguments to function 'damon_merge_regions_of'
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


vim +/damon_merge_two_regions +154 mm/damon/core-test.h

17ccae8bb5c928 SeongJae Park 2021-09-07  139  
17ccae8bb5c928 SeongJae Park 2021-09-07  140  static void damon_test_merge_two(struct kunit *test)
17ccae8bb5c928 SeongJae Park 2021-09-07  141  {
17ccae8bb5c928 SeongJae Park 2021-09-07  142  	struct damon_target *t;
17ccae8bb5c928 SeongJae Park 2021-09-07  143  	struct damon_region *r, *r2, *r3;
17ccae8bb5c928 SeongJae Park 2021-09-07  144  	int i;
17ccae8bb5c928 SeongJae Park 2021-09-07  145  
17ccae8bb5c928 SeongJae Park 2021-09-07  146  	t = damon_new_target(42);
17ccae8bb5c928 SeongJae Park 2021-09-07  147  	r = damon_new_region(0, 100);
17ccae8bb5c928 SeongJae Park 2021-09-07  148  	r->nr_accesses = 10;
17ccae8bb5c928 SeongJae Park 2021-09-07  149  	damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  150  	r2 = damon_new_region(100, 300);
17ccae8bb5c928 SeongJae Park 2021-09-07  151  	r2->nr_accesses = 20;
17ccae8bb5c928 SeongJae Park 2021-09-07  152  	damon_add_region(r2, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  153  
17ccae8bb5c928 SeongJae Park 2021-09-07 @154  	damon_merge_two_regions(t, r, r2);
17ccae8bb5c928 SeongJae Park 2021-09-07  155  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  156  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  157  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
17ccae8bb5c928 SeongJae Park 2021-09-07  158  
17ccae8bb5c928 SeongJae Park 2021-09-07  159  	i = 0;
17ccae8bb5c928 SeongJae Park 2021-09-07  160  	damon_for_each_region(r3, t) {
17ccae8bb5c928 SeongJae Park 2021-09-07  161  		KUNIT_EXPECT_PTR_EQ(test, r, r3);
17ccae8bb5c928 SeongJae Park 2021-09-07  162  		i++;
17ccae8bb5c928 SeongJae Park 2021-09-07  163  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  164  	KUNIT_EXPECT_EQ(test, i, 1);
17ccae8bb5c928 SeongJae Park 2021-09-07  165  
17ccae8bb5c928 SeongJae Park 2021-09-07  166  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  167  }
17ccae8bb5c928 SeongJae Park 2021-09-07  168  
17ccae8bb5c928 SeongJae Park 2021-09-07  169  static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
17ccae8bb5c928 SeongJae Park 2021-09-07  170  {
17ccae8bb5c928 SeongJae Park 2021-09-07  171  	struct damon_region *r;
17ccae8bb5c928 SeongJae Park 2021-09-07  172  	unsigned int i = 0;
17ccae8bb5c928 SeongJae Park 2021-09-07  173  
17ccae8bb5c928 SeongJae Park 2021-09-07  174  	damon_for_each_region(r, t) {
17ccae8bb5c928 SeongJae Park 2021-09-07  175  		if (i++ == idx)
17ccae8bb5c928 SeongJae Park 2021-09-07  176  			return r;
17ccae8bb5c928 SeongJae Park 2021-09-07  177  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  178  
17ccae8bb5c928 SeongJae Park 2021-09-07  179  	return NULL;
17ccae8bb5c928 SeongJae Park 2021-09-07  180  }
17ccae8bb5c928 SeongJae Park 2021-09-07  181  
17ccae8bb5c928 SeongJae Park 2021-09-07  182  static void damon_test_merge_regions_of(struct kunit *test)
17ccae8bb5c928 SeongJae Park 2021-09-07  183  {
17ccae8bb5c928 SeongJae Park 2021-09-07  184  	struct damon_target *t;
17ccae8bb5c928 SeongJae Park 2021-09-07  185  	struct damon_region *r;
17ccae8bb5c928 SeongJae Park 2021-09-07  186  	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
17ccae8bb5c928 SeongJae Park 2021-09-07  187  	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
17ccae8bb5c928 SeongJae Park 2021-09-07  188  	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
17ccae8bb5c928 SeongJae Park 2021-09-07  189  
17ccae8bb5c928 SeongJae Park 2021-09-07  190  	unsigned long saddrs[] = {0, 114, 130, 156, 170};
17ccae8bb5c928 SeongJae Park 2021-09-07  191  	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
17ccae8bb5c928 SeongJae Park 2021-09-07  192  	int i;
17ccae8bb5c928 SeongJae Park 2021-09-07  193  
17ccae8bb5c928 SeongJae Park 2021-09-07  194  	t = damon_new_target(42);
17ccae8bb5c928 SeongJae Park 2021-09-07  195  	for (i = 0; i < ARRAY_SIZE(sa); i++) {
17ccae8bb5c928 SeongJae Park 2021-09-07  196  		r = damon_new_region(sa[i], ea[i]);
17ccae8bb5c928 SeongJae Park 2021-09-07  197  		r->nr_accesses = nrs[i];
17ccae8bb5c928 SeongJae Park 2021-09-07  198  		damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  199  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  200  
17ccae8bb5c928 SeongJae Park 2021-09-07 @201  	damon_merge_regions_of(t, 9, 9999);
17ccae8bb5c928 SeongJae Park 2021-09-07  202  	/* 0-112, 114-130, 130-156, 156-170 */
17ccae8bb5c928 SeongJae Park 2021-09-07  203  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
17ccae8bb5c928 SeongJae Park 2021-09-07  204  	for (i = 0; i < 5; i++) {
17ccae8bb5c928 SeongJae Park 2021-09-07  205  		r = __nth_region_of(t, i);
17ccae8bb5c928 SeongJae Park 2021-09-07  206  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
17ccae8bb5c928 SeongJae Park 2021-09-07  207  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
17ccae8bb5c928 SeongJae Park 2021-09-07  208  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  209  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  210  }
17ccae8bb5c928 SeongJae Park 2021-09-07  211  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
