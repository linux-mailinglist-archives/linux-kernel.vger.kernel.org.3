Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8768B5351B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbiEZPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiEZPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:54:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DFDE31F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653580453; x=1685116453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PRzwLMo3UMy+KGc4jJUoI8v/BSa7kTxB5o8O+V94qYI=;
  b=htOZKm/u1sHWiN22bXGqedVpjKdO5QywCuKCiTMG+YzcDr79sJiktx9r
   rHyC84TuUI9mSMgXvVHbVXBOGfa7KkxgTLmAlUKo5kwrW+3QfXPN46lnu
   NNtyvHgFEMrJ0AIYOrWBKMNEpOV5D85PVbPKyK9gG/4fOBq5rAh3DJ9LA
   rW+TWEyhWZUXEyyBr5A1hAL61RjPzFGGsKzV0sKIOTRdc3JEovGG2DQeu
   +s5iepQ/rDwuAoZmFZMlWmu33lMLIBBIDLXBRsysjyZ9Pz3ICLTo+q8JG
   Of3gqByN4RwczqOdpAiPhXNSfKnsk+Td5qFNvyY6c5yKko2Z4TAR6AJus
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274302763"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274302763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 08:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="664991013"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2022 08:54:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuFoQ-0003z6-I3;
        Thu, 26 May 2022 15:54:10 +0000
Date:   Thu, 26 May 2022 23:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/perf_event.h:1056:16: error: call to undeclared function
 'this_cpu_load'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202205262333.thHbJnaz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   012bb7ae4eb84ae93ded12888ccd1e123c64200f
commit: c838cb5fbb27ca829668a88691b07ca63f91fde7 [9/10] perf/x86/intel: Optimize short PEBS counters
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220526/202205262333.thHbJnaz-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/events/core.c:45:
>> arch/x86/events/perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
>> arch/x86/events/perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
   2 errors generated.
--
   In file included from arch/x86/events/intel/core.c:25:
>> arch/x86/events/intel/../perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
>> arch/x86/events/intel/../perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
>> arch/x86/events/intel/core.c:2841:26: error: invalid operands to binary expression ('unsigned long[2]' and 'unsigned long long')
           if (!(cpuc->active_mask & (1ULL << hwc->idx)))
                 ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   3 errors generated.
--
   In file included from arch/x86/events/intel/bts.c:21:
>> arch/x86/events/intel/../perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
>> arch/x86/events/intel/../perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
   2 errors generated.
--
   In file included from arch/x86/events/intel/pt.c:27:
>> arch/x86/events/intel/../perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
>> arch/x86/events/intel/../perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
   arch/x86/events/intel/pt.c:719:2: warning: array index -1 is before the beginning of the array [-Warray-bounds]
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
--
   In file included from arch/x86/events/zhaoxin/core.c:19:
>> arch/x86/events/zhaoxin/../perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
>> arch/x86/events/zhaoxin/../perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
   2 errors generated.
--
   In file included from arch/x86/events/amd/core.c:14:
>> arch/x86/events/amd/../perf_event.h:1056:16: error: call to undeclared function 'this_cpu_load'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
                         ^
>> arch/x86/events/amd/../perf_event.h:1057:13: error: call to undeclared function 'load64_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           s64 left = load64_read(&hwc->period_left);
                      ^
   2 errors generated.


vim +/this_cpu_load +1056 arch/x86/events/perf_event.h

  1052	
  1053	static inline bool intel_pmu_is_short_pebs(struct perf_event *event)
  1054	{
  1055		struct hw_perf_event *hwc = &event->hw;
> 1056		s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
> 1057		s64 left = load64_read(&hwc->period_left);
  1058	
  1059		return counter < left;
  1060	}
  1061	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
