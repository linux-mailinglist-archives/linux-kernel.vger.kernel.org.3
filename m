Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724347C4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbhLURTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:19:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:24284 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240304AbhLURTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640107149; x=1671643149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+1Ala7BLBE4wkmFBmGVNyhWqbmKl0C+VXkfaFuRoCaA=;
  b=Xf8UMRQyg0m71SHwq4TB551MhzBuG8MO9M/8Sl2AuwPrUzweE/AOpEeT
   X68QjGfSSIZkpkHmEW+MBce9LlaYPaIbVdvARiQjtjC19x5w+PC2+sI8d
   xp5TqgMDFDNBHdaoxlJ6oNjEeIOLLlEU5fWnvAmEVhuRN8wldZsdgE74L
   kJuP2tFzAy735E4Cmk9eo+kZ7Sv+8lcc318mQ+5otgezgbjOVUbcQm0O8
   hulbd/GABkvq7gfbg+ehiMsqwAnf2B2DSZe+JqBvlDI1dpHW4cIMGr5L/
   uIrB+fFTAMDi/ae9wElNJ2/ey8gCY4ncTQ1jxPWD9YeEG7in10OqXHtO3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227734586"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227734586"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 09:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="616833164"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 09:16:01 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzik4-0009F2-VF; Tue, 21 Dec 2021 17:16:00 +0000
Date:   Wed, 22 Dec 2021 01:15:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [linuxppc:next-test 126/140] arch/powerpc/perf/core-book3s.c:2455:6:
 warning: no previous prototype for 'power_pmu_wants_prompt_pmi'
Message-ID: <202112220137.X16y07Dp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/linuxppc/linux next-test
head:   9c4c79c450672b18889a42e6b16a0254ed9721e0
commit: 5a7745b96f43c69f9b4875bcf516a0341acbc3fb [126/140] powerpc/64s/perf: add power_pmu_wants_prompt_pmi to say whether perf wants PMIs to be soft-NMI
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220137.X16y07Dp-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linuxppc/linux/commit/5a7745b96f43c69f9b4875bcf516a0341acbc3fb
        git remote add linuxppc https://github.com/linuxppc/linux
        git fetch --no-tags linuxppc next-test
        git checkout 5a7745b96f43c69f9b4875bcf516a0341acbc3fb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/perf/core-book3s.c:2455:6: warning: no previous prototype for 'power_pmu_wants_prompt_pmi' [-Wmissing-prototypes]
    2455 | bool power_pmu_wants_prompt_pmi(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/power_pmu_wants_prompt_pmi +2455 arch/powerpc/perf/core-book3s.c

  2440	
  2441	/*
  2442	 * If the perf subsystem wants performance monitor interrupts as soon as
  2443	 * possible (e.g., to sample the instruction address and stack chain),
  2444	 * this should return true. The IRQ masking code can then enable MSR[EE]
  2445	 * in some places (e.g., interrupt handlers) that allows PMI interrupts
  2446	 * though to improve accuracy of profiles, at the cost of some performance.
  2447	 *
  2448	 * The PMU counters can be enabled by other means (e.g., sysfs raw SPR
  2449	 * access), but in that case there is no need for prompt PMI handling.
  2450	 *
  2451	 * This currently returns true if any perf counter is being used. It
  2452	 * could possibly return false if only events are being counted rather than
  2453	 * samples being taken, but for now this is good enough.
  2454	 */
> 2455	bool power_pmu_wants_prompt_pmi(void)
  2456	{
  2457		struct cpu_hw_events *cpuhw;
  2458	
  2459		/*
  2460		 * This could simply test local_paca->pmcregs_in_use if that were not
  2461		 * under ifdef KVM.
  2462		 */
  2463	
  2464		if (!ppmu)
  2465			return false;
  2466	
  2467		cpuhw = this_cpu_ptr(&cpu_hw_events);
  2468		return cpuhw->n_events;
  2469	}
  2470	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
