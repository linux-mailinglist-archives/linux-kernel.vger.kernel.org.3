Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF85271FC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiENOaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiENOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:30:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DB17589
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652538620; x=1684074620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yy9zAdqARHq1GeS30HTCDTvvkxEJgRMqeuKZep2jkFA=;
  b=TNyI4bRqfnOwlc4NQFyUuQ+Rn3LMq+rt9cyelwVND4B2qPFLhSyx1lRv
   4QKfDUZygOumz7JfPzYoegpmKg5Dia/h1yY2Xb7TGSvJVuJgj4vpzFF8u
   eY0nRdaVDQm/blizphTrcwBYE23QRqeQdhBMT/Ay/bYc8/1yMhO9mpEPa
   IuTR4AaVNol/QyNWa7ammahLd5FvT/08AITE8tEO63abetqV/rAVO5FIg
   /g0pFKQ9hODHQBgYmVLKfvvWa+qhCuW/QAzB1m37jcIW30nrZ9Yb6GOBs
   ZFtFmFkmSe4zJfSl/86q9KIkqcz2NelP8deX3vd5NLunE2NGYJhjSzIjk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="270456241"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="270456241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 07:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="604204482"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 May 2022 07:30:17 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npsme-0000jz-Cs;
        Sat, 14 May 2022 14:30:16 +0000
Date:   Sat, 14 May 2022 22:30:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 24/25] arch/x86/mm/tlb.c:1010:47:
 error: 'CONTEXT_WORK_TLBI' undeclared
Message-ID: <202205142239.1IjyYFdD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: ac6fd7356ff9f2e0f040ef337d3eb731454ce49f [24/25] context_tracking,x86: Fix Kernel TLBi vs NOHZ_FULL
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220514/202205142239.1IjyYFdD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=ac6fd7356ff9f2e0f040ef337d3eb731454ce49f
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout ac6fd7356ff9f2e0f040ef337d3eb731454ce49f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/mm/tlb.c: In function 'do_kernel_flush_cond':
>> arch/x86/mm/tlb.c:1010:47: error: 'CONTEXT_WORK_TLBI' undeclared (first use in this function)
    1010 |                                               CONTEXT_WORK_TLBI);
         |                                               ^~~~~~~~~~~~~~~~~
   arch/x86/mm/tlb.c:1010:47: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/mm/tlb.c:1011:1: error: control reaches end of non-void function [-Werror=return-type]
    1011 | }
         | ^
   cc1: some warnings being treated as errors
--
   arch/x86/mm/pat/set_memory.c: In function '__cpa_flush_tlb_cond':
>> arch/x86/mm/pat/set_memory.c:367:47: error: 'CONTEXT_WORK_TLBI' undeclared (first use in this function)
     367 |                                               CONTEXT_WORK_TLBI);
         |                                               ^~~~~~~~~~~~~~~~~
   arch/x86/mm/pat/set_memory.c:367:47: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/mm/pat/set_memory.c:368:1: error: control reaches end of non-void function [-Werror=return-type]
     368 | }
         | ^
   cc1: some warnings being treated as errors


vim +/CONTEXT_WORK_TLBI +1010 arch/x86/mm/tlb.c

  1006	
  1007	static bool do_kernel_flush_cond(int cpu, void *info)
  1008	{
  1009		return !context_tracking_set_cpu_work(cpu, CONTEXT_USER | CONTEXT_GUEST,
> 1010						      CONTEXT_WORK_TLBI);
  1011	}
  1012	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
