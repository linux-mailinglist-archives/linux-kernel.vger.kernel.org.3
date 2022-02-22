Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7234BF1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiBVGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:01:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiBVGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:01:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077EA8BE2C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645509672; x=1677045672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NP9GtxO3ARoLz1k30qiRBR1BBI2kc5IQQLeUYxqbuZs=;
  b=ihdBIFuJHbpsRjAnTTI3kmjbbJ7wSDJJWEDHfRvqcLMBsauQZJFZa8vT
   nVQyeQhicf5jFKGgACY6fgRW2dGUH46y6bdGhv/ldkI/uoKfcduRrZPui
   AXpNZNOTt8iw/XORkDWOxFwMygStYZfhZyzLZe+ld23Op6wgXzcOqewzI
   bXoLgAeX8GSAKMc2Cun2qDsRnVfI3Zn2YXyuVs3qJYGWskP/D3sw4BHDx
   aCQAtL+M/WUMkaAvaIffVg7qcELvssxWrhrpY8KWjoxycVfbUoVScQa+E
   0WnMPp5S67606XqeXaLFBQ7rJ33YxqW8KSbuD/0L6+chAOEkzTbFTgbMA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231585632"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231585632"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="547594422"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2022 22:00:53 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMOEH-0002OO-5Y; Tue, 22 Feb 2022 06:00:53 +0000
Date:   Tue, 22 Feb 2022 14:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 123/2541]
 arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202202221340.2LmNpMAg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   601144c0da5edfa67a9654158370da19c67e17e2
commit: 70a45c203ea9662140afaa06885c49a69051eb21 [123/2541] headers/deps: per_task, arm64, x86: Convert task_struct::thread to a per_task() field
config: arm64-buildonly-randconfig-r001-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221340.2LmNpMAg-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=70a45c203ea9662140afaa06885c49a69051eb21
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 70a45c203ea9662140afaa06885c49a69051eb21
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:29:
>> arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
--
   In file included from arch/arm64/kernel/asm-offsets.c:29:
>> arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: no previous prototype for '__kernel_clock_gettime' [-Wmissing-prototypes]
       9 | int __kernel_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: no previous prototype for '__kernel_gettimeofday' [-Wmissing-prototypes]
      15 | int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: no previous prototype for '__kernel_clock_getres' [-Wmissing-prototypes]
      21 | int __kernel_clock_getres(clockid_t clock_id,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/per_task_common +13 arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h

ce2d40bf8a7dba Ingo Molnar 2021-09-05  11  
ce2d40bf8a7dba Ingo Molnar 2021-09-05  12  
e6c00629263417 Ingo Molnar 2022-01-04 @13  void __used per_task_common(void)
e6c00629263417 Ingo Molnar 2022-01-04  14  {
e6c00629263417 Ingo Molnar 2022-01-04  15  #include "per_task_area_struct_template.h"
e6c00629263417 Ingo Molnar 2022-01-04  16  }
ce2d40bf8a7dba Ingo Molnar 2021-09-05  17  

:::::: The code at line 13 was first introduced by commit
:::::: e6c00629263417a49fc24ca6c70fad1d182fc3f9 headers/deps: per_task: Implement single template to define 'struct task_struct_per_task' fields and offsets

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
