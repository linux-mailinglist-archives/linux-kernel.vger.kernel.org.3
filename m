Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0394D535198
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348009AbiEZPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbiEZPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:43:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72FC8BC2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653579813; x=1685115813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n319ZaHcVVU7/TnStzhFgifgeVqR0no63HwJF61Gm5A=;
  b=Cnf41GfFL2U2DRP352flD6AvgoVYFR0/SIMzo+rWEqf1Ff5pHdeXlVCL
   9xSGIZxDZCaUWJtQC+tRoLSUeuRAFK2Kx885CmtdC/FBwQHBP1cKh7dvU
   wY9dsCP5dD8Upnnn2SU3h/oKi4w5ngmQUfY9v4QuS7HJsmIfd7PmAMi8l
   dGJtHLcayjJA7LLbGAATZ6bGCx5QU5tKiqNJs4mghs9eYxVRMlX3TFbPR
   QBfRDf20pUPXQ5IdBeqWCfRaACbRLti1lLETeGgjpTPR4YBFizRl2pi1m
   CgSGUSRhSqa8BOKZt1E8IUhP7j43SvYTeFHigJBLsDwwoZkyFocW/QL3h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254069297"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254069297"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 08:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="746389007"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2022 08:43:10 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuFdl-0003xw-Sw;
        Thu, 26 May 2022 15:43:09 +0000
Date:   Thu, 26 May 2022 23:42:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/perf_event.h:1056:23: error: implicit declaration of
 function 'this_cpu_load'; did you mean 'this_cpu_read'?
Message-ID: <202205262353.IuelPkqA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   012bb7ae4eb84ae93ded12888ccd1e123c64200f
commit: c838cb5fbb27ca829668a88691b07ca63f91fde7 [9/10] perf/x86/intel: Optimize short PEBS counters
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220526/202205262353.IuelPkqA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=c838cb5fbb27ca829668a88691b07ca63f91fde7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.cleanup
        git checkout c838cb5fbb27ca829668a88691b07ca63f91fde7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/events/core.c:45:
   arch/x86/events/perf_event.h: In function 'intel_pmu_is_short_pebs':
>> arch/x86/events/perf_event.h:1056:23: error: implicit declaration of function 'this_cpu_load'; did you mean 'this_cpu_read'? [-Werror=implicit-function-declaration]
    1056 |         s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
         |                       ^~~~~~~~~~~~~
         |                       this_cpu_read
>> arch/x86/events/perf_event.h:1057:20: error: implicit declaration of function 'load64_read'; did you mean 'local64_read'? [-Werror=implicit-function-declaration]
    1057 |         s64 left = load64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~
         |                    local64_read
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/events/intel/core.c:25:
   arch/x86/events/intel/../perf_event.h: In function 'intel_pmu_is_short_pebs':
>> arch/x86/events/intel/../perf_event.h:1056:23: error: implicit declaration of function 'this_cpu_load'; did you mean 'this_cpu_read'? [-Werror=implicit-function-declaration]
    1056 |         s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
         |                       ^~~~~~~~~~~~~
         |                       this_cpu_read
>> arch/x86/events/intel/../perf_event.h:1057:20: error: implicit declaration of function 'load64_read'; did you mean 'local64_read'? [-Werror=implicit-function-declaration]
    1057 |         s64 left = load64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~
         |                    local64_read
   arch/x86/events/intel/core.c: In function 'intel_pmu_handle_short_pebs':
>> arch/x86/events/intel/core.c:2841:33: error: invalid operands to binary & (have 'long unsigned int *' and 'long long unsigned int')
    2841 |         if (!(cpuc->active_mask & (1ULL << hwc->idx)))
         |               ~~~~              ^ ~~~~~~~~~~~~~~~~~~
         |               |                         |
         |               long unsigned int *       long long unsigned int
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/events/intel/bts.c:21:
   arch/x86/events/intel/../perf_event.h: In function 'intel_pmu_is_short_pebs':
>> arch/x86/events/intel/../perf_event.h:1056:23: error: implicit declaration of function 'this_cpu_load'; did you mean 'this_cpu_read'? [-Werror=implicit-function-declaration]
    1056 |         s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
         |                       ^~~~~~~~~~~~~
         |                       this_cpu_read
>> arch/x86/events/intel/../perf_event.h:1057:20: error: implicit declaration of function 'load64_read'; did you mean 'local64_read'? [-Werror=implicit-function-declaration]
    1057 |         s64 left = load64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~
         |                    local64_read
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/events/zhaoxin/core.c:19:
   arch/x86/events/zhaoxin/../perf_event.h: In function 'intel_pmu_is_short_pebs':
>> arch/x86/events/zhaoxin/../perf_event.h:1056:23: error: implicit declaration of function 'this_cpu_load'; did you mean 'this_cpu_read'? [-Werror=implicit-function-declaration]
    1056 |         s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
         |                       ^~~~~~~~~~~~~
         |                       this_cpu_read
>> arch/x86/events/zhaoxin/../perf_event.h:1057:20: error: implicit declaration of function 'load64_read'; did you mean 'local64_read'? [-Werror=implicit-function-declaration]
    1057 |         s64 left = load64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~
         |                    local64_read
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/events/amd/core.c:14:
   arch/x86/events/amd/../perf_event.h: In function 'intel_pmu_is_short_pebs':
>> arch/x86/events/amd/../perf_event.h:1056:23: error: implicit declaration of function 'this_cpu_load'; did you mean 'this_cpu_read'? [-Werror=implicit-function-declaration]
    1056 |         s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
         |                       ^~~~~~~~~~~~~
         |                       this_cpu_read
>> arch/x86/events/amd/../perf_event.h:1057:20: error: implicit declaration of function 'load64_read'; did you mean 'local64_read'? [-Werror=implicit-function-declaration]
    1057 |         s64 left = load64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~
         |                    local64_read
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/kernel/cpu/resctrl/pseudo_lock.c:30:
   arch/x86/include/uapi/../../events/perf_event.h: In function 'intel_pmu_is_short_pebs':
>> arch/x86/include/uapi/../../events/perf_event.h:1056:23: error: implicit declaration of function 'this_cpu_load'; did you mean 'this_cpu_read'? [-Werror=implicit-function-declaration]
    1056 |         s64 counter = this_cpu_load(pmc_prev_left[hwc->idx]);
         |                       ^~~~~~~~~~~~~
         |                       this_cpu_read
>> arch/x86/include/uapi/../../events/perf_event.h:1057:20: error: implicit declaration of function 'load64_read'; did you mean 'local64_read'? [-Werror=implicit-function-declaration]
    1057 |         s64 left = load64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~
         |                    local64_read
   cc1: some warnings being treated as errors


vim +1056 arch/x86/events/perf_event.h

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
