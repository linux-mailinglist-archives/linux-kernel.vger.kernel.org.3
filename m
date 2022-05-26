Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5453507F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiEZOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiEZOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:22:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2618340
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653574932; x=1685110932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MExdy0PQ1mm12crzu+MfwurQlT0wcSHvnPQYx0GnPU4=;
  b=SFRFI33A3AWhtgrW56tRQgi0nTN1W61gxzRc531mgXVaRUrkLOZ0Ty1l
   EeU+W8GAkf1qzEV4GCjRCEWonLNb2NKxvk7iXLlsOR/3wx6GEz6Q/t/Tr
   PucQsELgYu9n9dwEqx+M8aobqH7PfA3Cedran8XQW2WRh0qXYfUXzBDPz
   dSQ6QDCJVopUCtbLp1tqzq7xFZj69UEFZ+4enXGVVe7HLOCbiRGHmiY2a
   olaXC4nBBPipbEczjO7uPQzrV1DOfdd3b3VYtYM6ex8b0Xjh+fgRxRve4
   2SEm1QcZtrnRki3SAvvmZ3xtorD/1O6a9pHDuH2gpws+vOFaGVScSR/3X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="273895574"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="273895574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 07:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="664955508"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2022 07:22:08 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuENL-0003vI-Ro;
        Thu, 26 May 2022 14:22:07 +0000
Date:   Thu, 26 May 2022 22:21:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/intel/pt.c:719:2: warning: array index -1 is before the
 beginning of the array
Message-ID: <202205262245.87lBx9Fw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   012bb7ae4eb84ae93ded12888ccd1e123c64200f
commit: c838cb5fbb27ca829668a88691b07ca63f91fde7 [9/10] perf/x86/intel: Optimize short PEBS counters
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220526/202205262245.87lBx9Fw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6f4644d194da594562027a5d458d9fb7a20ebc39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=c838cb5fbb27ca829668a88691b07ca63f91fde7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.cleanup
        git checkout c838cb5fbb27ca829668a88691b07ca63f91fde7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/events/intel/pt.c:27:
   arch/x86/events/intel/../perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
   arch/x86/events/intel/../perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
>> arch/x86/events/intel/pt.c:719:2: warning: array index -1 is before the beginning of the array [-Warray-bounds]
           TOPA_ENTRY(last, -1)->base = topa_pfn(topa);
           ^                ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:720:2: warning: array index -1 is before the beginning of the array [-Warray-bounds]
           TOPA_ENTRY(last, -1)->end = 1;
           ^                ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:769:2: warning: array index -1 is before the beginning of the array [-Warray-bounds]
           TOPA_ENTRY(topa, -1)->base = page_to_phys(p) >> TOPA_SHIFT;
           ^                ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:770:2: warning: array index -1 is before the beginning of the array [-Warray-bounds]
           TOPA_ENTRY(topa, -1)->size = order;
           ^                ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:773:3: warning: array index -1 is before the beginning of the array [-Warray-bounds]
                   TOPA_ENTRY(topa, -1)->intr = 1;
                   ^                ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:774:3: warning: array index -1 is before the beginning of the array [-Warray-bounds]
                   TOPA_ENTRY(topa, -1)->stop = 1;
                   ^                ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:1235:3: warning: array index -1 is before the beginning of the array [-Warray-bounds]
                   TOPA_ENTRY(buf->last, -1)->base = topa_pfn(buf->first);
                   ^                     ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   arch/x86/events/intel/pt.c:1236:3: warning: array index -1 is before the beginning of the array [-Warray-bounds]
                   TOPA_ENTRY(buf->last, -1)->end = 1;
                   ^                     ~~
   arch/x86/events/intel/pt.c:619:6: note: expanded from macro 'TOPA_ENTRY'
                   : &topa_to_page(t)->table[(i)])
                      ^                       ~
   arch/x86/events/intel/pt.c:596:2: note: array 'table' declared here
           struct topa_entry       table[TENTS_PER_PAGE];
           ^
   8 warnings and 2 errors generated.


vim +719 arch/x86/events/intel/pt.c

52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  690  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  691  /**
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  692   * topa_insert_table() - insert a ToPA table into a buffer
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  693   * @buf:	 PT buffer that's being extended.
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  694   * @topa:	 New topa table to be inserted.
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  695   *
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  696   * If it's the first table in this buffer, set up buffer's pointers
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  697   * accordingly; otherwise, add a END=1 link entry to @topa to the current
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  698   * "last" table and adjust the last table pointer to @topa.
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  699   */
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  700  static void topa_insert_table(struct pt_buffer *buf, struct topa *topa)
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  701  {
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  702  	struct topa *last = buf->last;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  703  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  704  	list_add_tail(&topa->list, &buf->tables);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  705  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  706  	if (!buf->first) {
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  707  		buf->first = buf->last = buf->cur = topa;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  708  		return;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  709  	}
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  710  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  711  	topa->offset = last->offset + last->size;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  712  	buf->last = topa;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  713  
f6d079ce867d67 arch/x86/events/intel/pt.c                Chao Peng          2018-10-24  714  	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  715  		return;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  716  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  717  	BUG_ON(last->last != TENTS_PER_PAGE - 1);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  718  
91feca5e2ecc97 arch/x86/events/intel/pt.c                Alexander Shishkin 2019-08-21 @719  	TOPA_ENTRY(last, -1)->base = topa_pfn(topa);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  720  	TOPA_ENTRY(last, -1)->end = 1;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  721  }
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  722  

:::::: The code at line 719 was first introduced by commit
:::::: 91feca5e2ecc9752894d57c9a72c2645471929c3 perf/x86/intel/pt: Free up space in a ToPA descriptor

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
