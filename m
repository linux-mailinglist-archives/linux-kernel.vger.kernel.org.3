Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5753DD40
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbiFERB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiFERBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:01:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09148313BF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654448513; x=1685984513;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/rxpM1h/GmALKBDe71iQtoXuCocas5ohPt75HD+skjg=;
  b=Obha6gT7Sx9xYvhUsG2M13/PdvTcTR1WvNlCz5sb+ZZ4KPRRdFzCZCOs
   T8L94k8rQU6iWMPu+HVlm8f4LYgMypDnx9J4xg4Isz6A2BJ+DcBZbDBhP
   CiUvUGXu1ZL0+75Qgxl4Ni9JxsJ8itWwVmPIccaSXR7x8LyVIw1UPuH7z
   9mQwaAG8FrJ+vU1Q1QUMszi+kuUxn6kO/fJAqBUYORKPaf+WSU6cfPD0h
   d7USR/qQ007Hm+rYc7tKxYxVp1XjbrvDIFkPiPILU5+izyS28M4JEO35+
   hyatJG3ToHI7Bm4a7yUxTD8KeKn0qOjQsBo0PW1aAJbJQuGDtbxH3axyS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="337281424"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="337281424"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 10:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="578810729"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jun 2022 10:01:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxtdO-000C5J-Rr;
        Sun, 05 Jun 2022 17:01:50 +0000
Date:   Mon, 6 Jun 2022 01:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 5/33] drivers/idle/intel_idle.c:134:
 warning: expecting prototype for intel_idle(). Prototype was for
 __intel_idle() instead
Message-ID: <202206060056.fqu4UFgZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   5aca393851ce7ebb9a3405bb4ffd4f38d96949e4
commit: 625fb75b0c1feec90c70e69c722cb6df86ff3631 [5/33] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220606/202206060056.fqu4UFgZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=625fb75b0c1feec90c70e69c722cb6df86ff3631
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 625fb75b0c1feec90c70e69c722cb6df86ff3631
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/idle/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/idle/intel_idle.c:134: warning: expecting prototype for intel_idle(). Prototype was for __intel_idle() instead


vim +134 drivers/idle/intel_idle.c

b1beab48f6148d Len Brown         2013-01-31  117  
30a996fbb359ed Rafael J. Wysocki 2020-02-06  118  /**
30a996fbb359ed Rafael J. Wysocki 2020-02-06  119   * intel_idle - Ask the processor to enter the given idle state.
30a996fbb359ed Rafael J. Wysocki 2020-02-06  120   * @dev: cpuidle device of the target CPU.
30a996fbb359ed Rafael J. Wysocki 2020-02-06  121   * @drv: cpuidle driver (assumed to point to intel_idle_driver).
30a996fbb359ed Rafael J. Wysocki 2020-02-06  122   * @index: Target idle state index.
30a996fbb359ed Rafael J. Wysocki 2020-02-06  123   *
30a996fbb359ed Rafael J. Wysocki 2020-02-06  124   * Use the MWAIT instruction to notify the processor that the CPU represented by
30a996fbb359ed Rafael J. Wysocki 2020-02-06  125   * @dev is idle and it can try to enter the idle state corresponding to @index.
30a996fbb359ed Rafael J. Wysocki 2020-02-06  126   *
30a996fbb359ed Rafael J. Wysocki 2020-02-06  127   * If the local APIC timer is not known to be reliable in the target idle state,
30a996fbb359ed Rafael J. Wysocki 2020-02-06  128   * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
30a996fbb359ed Rafael J. Wysocki 2020-02-06  129   *
30a996fbb359ed Rafael J. Wysocki 2020-02-06  130   * Must be called under local_irq_disable().
30a996fbb359ed Rafael J. Wysocki 2020-02-06  131   */
625fb75b0c1fee Peter Zijlstra    2022-06-02  132  static __always_inline int __intel_idle(struct cpuidle_device *dev,
30a996fbb359ed Rafael J. Wysocki 2020-02-06  133  					struct cpuidle_driver *drv, int index)
30a996fbb359ed Rafael J. Wysocki 2020-02-06 @134  {
30a996fbb359ed Rafael J. Wysocki 2020-02-06  135  	struct cpuidle_state *state = &drv->states[index];
30a996fbb359ed Rafael J. Wysocki 2020-02-06  136  	unsigned long eax = flg2MWAIT(state->flags);
30a996fbb359ed Rafael J. Wysocki 2020-02-06  137  	unsigned long ecx = 1; /* break on interrupt flag */
30a996fbb359ed Rafael J. Wysocki 2020-02-06  138  
30a996fbb359ed Rafael J. Wysocki 2020-02-06  139  	mwait_idle_with_hints(eax, ecx);
30a996fbb359ed Rafael J. Wysocki 2020-02-06  140  
30a996fbb359ed Rafael J. Wysocki 2020-02-06  141  	return index;
30a996fbb359ed Rafael J. Wysocki 2020-02-06  142  }
30a996fbb359ed Rafael J. Wysocki 2020-02-06  143  

:::::: The code at line 134 was first introduced by commit
:::::: 30a996fbb359ed53536a055af84a54223beabf91 intel_idle: Relocate definitions of cpuidle callbacks

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
