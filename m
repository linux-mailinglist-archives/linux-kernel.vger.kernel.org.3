Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F544CB43F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiCCBQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:16:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F73585E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646270169; x=1677806169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DbLPVh72WV2DORvwNkbxJbvzCbXLEmfRbd74N3MutPo=;
  b=MvbzMqUfZ5JPQHaXdFcHFN+o09PBhDAeilAL+0NSRyUmzwk7db/wIFTs
   Ygrf/Hk3WY6CLPuaa/N2cqUI2oQ7B8tPkbTvMEcipqJfWQu15oVScTasF
   QREnHlwHORkSX5AJo8Uxkq/Pa2FURQbLs7xTjT2fxDF2IfyZxRH7iE12Q
   q/MF/1XzsvyoRlVDYKoZRMd1qCcxCJHXbRU8zBf6NQTGXBkamfkc2yFZZ
   vmNI7c47J7zc0Y6bzKketNbxu9ubpPttWPsoqB4BTII6CqOF6kJ3qwgVF
   nsebxF126bLNKHHHwXCh9iM4jP1y/9YWlMlrc10xxPUWhOthMjiIhyLBx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278224109"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="278224109"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 17:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="508404575"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 17:16:06 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPa4b-0002C4-MK; Thu, 03 Mar 2022 01:16:05 +0000
Date:   Thu, 3 Mar 2022 09:15:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Quentin Perret <quentin.perret@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.9-p-release
 6326/9999] kernel/sched/fair.c:5431:15: warning: no previous declaration for
 'capacity_min_of'
Message-ID: <202203030914.dPl5K6Z8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.9-p-release
head:   74f5cdd2ad41ea660f18bcaf7ce3d8d3e8e88428
commit: 58b761f4c089c6138195334ebd5b1c880e502551 [6326/9999] sched/fair: introduce minimum capacity capping sched feature
config: i386-randconfig-r034-20211122 (https://download.01.org/0day-ci/archive/20220303/202203030914.dPl5K6Z8-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/58b761f4c089c6138195334ebd5b1c880e502551
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.9-p-release
        git checkout 58b761f4c089c6138195334ebd5b1c880e502551
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:23:0:
   include/linux/sched.h:1260:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   kernel/sched/fair.c:3438:6: warning: no previous declaration for 'sync_entity_load_avg' [-Wmissing-declarations]
    void sync_entity_load_avg(struct sched_entity *se)
         ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:3451:6: warning: no previous declaration for 'remove_entity_load_avg' [-Wmissing-declarations]
    void remove_entity_load_avg(struct sched_entity *se)
         ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:5431:15: warning: no previous declaration for 'capacity_min_of' [-Wmissing-declarations]
    unsigned long capacity_min_of(int cpu)
                  ^~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'find_best_target':
   kernel/sched/fair.c:6703:16: warning: variable 'target_util' set but not used [-Wunused-but-set-variable]
     unsigned long target_util = ULONG_MAX;
                   ^~~~~~~~~~~
   kernel/sched/fair.c: In function 'select_energy_cpu_brute':
   kernel/sched/fair.c:5873:11: warning: array subscript is above array bounds [-Warray-bounds]
     eenv->cpu[cpu_idx].nrg_delta = 0;
     ~~~~~~~~~^~~~~~~~~
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'


vim +/capacity_min_of +5431 kernel/sched/fair.c

  5426	
  5427	/*
  5428	 * Returns the current capacity of cpu after applying both
  5429	 * cpu and min freq scaling.
  5430	 */
> 5431	unsigned long capacity_min_of(int cpu)
  5432	{
  5433		if (!sched_feat(MIN_CAPACITY_CAPPING))
  5434			return 0;
  5435		return arch_scale_cpu_capacity(NULL, cpu) *
  5436		       arch_scale_min_freq_capacity(NULL, cpu)
  5437		       >> SCHED_CAPACITY_SHIFT;
  5438	}
  5439	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
