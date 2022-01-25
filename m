Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C608A49ADC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447889AbiAYIAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:00:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:27451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354992AbiAYH5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643097461; x=1674633461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZSMu/ePfONg2z+5dsk9SdCvB9LvYb8I+0DJ/pkBK04w=;
  b=k5N8cI2sYTMwf9xQnJR0KG5aJQujSl/ukqWUH9zujWeuX0wvpzT9eVd4
   hx2JUlOOHNLlCqVOf5PImtExxYDsjZj3dOaF0/cl2B470powNmHuxhzJk
   1oHyiNjx5Hchd2YfYRb4dOnacb68qDdaQAZ0Xh13jctgCZeU5UqNx7nT/
   Huv64kEqRkRj6TvevdTkQxtb4FA/ICRcVAKXxK88uRQpuObpqHm8bNC53
   tc4ZNfAqXpJ+ijV1FzN/5oxOeJeHg+PB3HOo7TVQ+R90eyhxDSBJ1OwH+
   MY5+xLpUYyUJgLRS/U64rAU/WoCytcM65j7306vtb3jPWjpgi8bWyxqeb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243845297"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="243845297"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 23:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="617531111"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 23:57:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCGhm-000JYO-GJ; Tue, 25 Jan 2022 07:57:30 +0000
Date:   Tue, 25 Jan 2022 15:56:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/events/rapl.c:540:59: sparse: sparse: Using plain integer
 as NULL pointer
Message-ID: <202201251514.ZEiF0Q7N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 0036fb00a756a2f6e360d44e2e3d2200a8afbc9b perf/x86/rapl: fix AMD event handling
date:   7 days ago
config: i386-randconfig-s001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201251514.ZEiF0Q7N-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0036fb00a756a2f6e360d44e2e3d2200a8afbc9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0036fb00a756a2f6e360d44e2e3d2200a8afbc9b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/events/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/events/rapl.c:540:59: sparse: sparse: Using plain integer as NULL pointer
   arch/x86/events/rapl.c:542:59: sparse: sparse: Using plain integer as NULL pointer
   arch/x86/events/rapl.c:543:59: sparse: sparse: Using plain integer as NULL pointer
   arch/x86/events/rapl.c:544:59: sparse: sparse: Using plain integer as NULL pointer

vim +540 arch/x86/events/rapl.c

   533	
   534	/*
   535	 * Force to PERF_RAPL_MAX size due to:
   536	 * - perf_msr_probe(PERF_RAPL_MAX)
   537	 * - want to use same event codes across both architectures
   538	 */
   539	static struct perf_msr amd_rapl_msrs[] = {
 > 540		[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
   541		[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
   542		[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
   543		[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
   544		[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
   545	};
   546	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
