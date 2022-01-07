Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066DD487E66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiAGVlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:41:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:62651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbiAGVlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641591678; x=1673127678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Pmuy7o54TmXZCwtBjSxaQ6heIrQDvWCBXZmr+GzRM4=;
  b=IIsdO0VQgNQMCEo0jvcORljQpLrEB8FRholFWx7c7zooPUQkLru+AQdv
   yp6zNd4JQtdMGit9ahT1I2qCbJn9yHsXG15Mp7lauAoz/+ebYXRA0V59F
   4eQVlVvcS72IibU65Nm+UK0Isdc5J8EHuyGRgSpI+MAjuNAOy0C8c07wq
   ZxhJW4SHmU7yS+uSoK/I9MwXYfq6qTCT1eRplV12Vkwa19qvJAawBXcVv
   rFqCwz6dOHU9lxIyF7R6KxRLwkDbj4xy7po+LZgjkU0uj+o8fzLVcMc/w
   YTXMTFW4/D+8qiQHR+NrsvJ67SO0ZQeQWvwzLa++yWpXpvs8a/O2vXNAd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="243145826"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="243145826"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="513948828"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 13:41:16 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5wz6-000J4L-9m; Fri, 07 Jan 2022 21:41:16 +0000
Date:   Sat, 8 Jan 2022 05:40:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 81/2372]
 arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202201080551.oDOcaGTi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: cbe5c34b83fe53e121e44ba15f1af1f491da4602 [81/2372] headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220108/202201080551.oDOcaGTi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=cbe5c34b83fe53e121e44ba15f1af1f491da4602
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout cbe5c34b83fe53e121e44ba15f1af1f491da4602
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:34:
>> arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
       9 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
--
>> kernel/sched/core.c:9294:13: warning: no previous prototype for 'per_task_init' [-Wmissing-prototypes]
    9294 | void __init per_task_init(void)
         |             ^~~~~~~~~~~~~
--
   In file included from arch/x86/kernel/asm-offsets.c:34:
>> arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
       9 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~


vim +/per_task_common +9 arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h

     8	
   > 9	void __used per_task_common(void)
    10	{
    11	#ifdef CONFIG_THREAD_INFO_IN_TASK
    12		DEF_PER_TASK(ti);
    13	#endif
    14		DEF_PER_TASK(stack);
    15		DEF_PER_TASK(usage);
    16		DEF_PER_TASK(flags);
    17		DEF_PER_TASK(ptrace);
    18	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
