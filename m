Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6D50605D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiDRXws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiDRXwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:52:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878992496B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650325807; x=1681861807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H2IPYrQ/J1W7rRRywVikavrjy8lmgd2w5BCyb81xzHM=;
  b=TSlyc46HMJisvNNoo5qc1GVzTE6AGiNpyC2EPoQiJ0NZwOZ+vIl21mbE
   +ee6jqAPIAHqyF6lb/MQc4AjpvYhdOgl+hdWiNOSqTjc+RPWefP06loAg
   5fSBsz3ITAqcJ/q+Et2u1ROqqRfvhe8BkfBoMOWpgHaW/PLN8yup6e3i8
   R+o9UXrZJIJFcjWT56aUyTPkxrCgO4Ko4fjU6s1fxBKyKxrgYCizgrQ/P
   9ZHgvvkWrTH5Iv5tBUWnCj2ZgSmzqWHnDKABGr3//pZI+amKNW52iqAdG
   Pd0tno8USUMB10DhDhgSUokV0Q6PsvQMoPTdmY2ujhX/C8nmOz88qyrNF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350084327"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350084327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 16:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="613788142"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2022 16:50:06 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngb89-000565-IS;
        Mon, 18 Apr 2022 23:50:05 +0000
Date:   Tue, 19 Apr 2022 07:49:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 84/2356]
 arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202204190747.ud30HF2B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: dcac6390a2220f99834d2d14650fb82f2da9136b [84/2356] headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220419/202204190747.ud30HF2B-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=dcac6390a2220f99834d2d14650fb82f2da9136b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout dcac6390a2220f99834d2d14650fb82f2da9136b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:34:
>> arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
       9 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
