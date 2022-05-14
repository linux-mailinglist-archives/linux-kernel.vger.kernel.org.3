Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9505272BD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiENPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiENPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:53:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B32644
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652543603; x=1684079603;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/hGFrcfZXRmX0ubZwELNVdeYZ1G+P3iKylys426w3Ec=;
  b=Qb/7kEDNszt7FQaifWNsH9WPgNFgbYRV3eUsZvtgN60tVZsCY2zNE5Oj
   +/3ah5/pyKvK18grxsbv7VmKVpy0gJAEDtzh7DrBo21w4sGTcx8Vb1Mhq
   NVHEIEZg+hx6lPqUSANQ0/IXVn/iDa4NuGWzJF9R1/qgzgXFwJWZNCMF9
   Yqc9ZBz/KyaOSJzMumLFrSrm57UZUcZ971DGM/lWjzmFeeZA0fZthW1OG
   Fs7UUjb5ZV4zR+7zsKWCKFtieJPOBmsMOD45PSD4QMBXBMpaKk/T+0ck5
   QQO7prWoo040UadJZQ8odMhaJntw5pjEh9s6DyRs5vRyj6Wz7cPYpv3qo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="333569258"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="333569258"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 08:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="543692066"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2022 08:53:20 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npu51-0000nN-VW;
        Sat, 14 May 2022 15:53:19 +0000
Date:   Sat, 14 May 2022 23:53:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 25/25]
 arch/x86/mm/pat/set_memory.c:351:61: error: 'CONTEXT_WORK_CACHEI' undeclared
Message-ID: <202205142340.HRC7ItUJ-lkp@intel.com>
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
commit: ed63029652239a6befad96dd473b16332913f889 [25/25] context_tracking,x86: Fix Kernel cachei vs NOHZ_FULL
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220514/202205142340.HRC7ItUJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=ed63029652239a6befad96dd473b16332913f889
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout ed63029652239a6befad96dd473b16332913f889
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/mm/pat/set_memory.c: In function '__cpa_flush_all_cond':
   arch/x86/mm/pat/set_memory.c:351:41: error: 'CONTEXT_WORK_TLBI' undeclared (first use in this function)
     351 |                                         CONTEXT_WORK_TLBI | CONTEXT_WORK_CACHEI);
         |                                         ^~~~~~~~~~~~~~~~~
   arch/x86/mm/pat/set_memory.c:351:41: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/mm/pat/set_memory.c:351:61: error: 'CONTEXT_WORK_CACHEI' undeclared (first use in this function)
     351 |                                         CONTEXT_WORK_TLBI | CONTEXT_WORK_CACHEI);
         |                                                             ^~~~~~~~~~~~~~~~~~~
   arch/x86/mm/pat/set_memory.c: In function '__cpa_flush_tlb_cond':
   arch/x86/mm/pat/set_memory.c:373:47: error: 'CONTEXT_WORK_TLBI' undeclared (first use in this function)
     373 |                                               CONTEXT_WORK_TLBI);
         |                                               ^~~~~~~~~~~~~~~~~
   arch/x86/mm/pat/set_memory.c: In function '__cpa_flush_all_cond':
   arch/x86/mm/pat/set_memory.c:352:1: error: control reaches end of non-void function [-Werror=return-type]
     352 | }
         | ^
   arch/x86/mm/pat/set_memory.c: In function '__cpa_flush_tlb_cond':
   arch/x86/mm/pat/set_memory.c:374:1: error: control reaches end of non-void function [-Werror=return-type]
     374 | }
         | ^
   cc1: some warnings being treated as errors


vim +/CONTEXT_WORK_CACHEI +351 arch/x86/mm/pat/set_memory.c

   347	
   348	static bool __cpa_flush_all_cond(int cpu, void *info)
   349	{
   350		return !context_tracking_set_cpu_work(cpu, CONTEXT_USER | CONTEXT_GUEST,
 > 351						CONTEXT_WORK_TLBI | CONTEXT_WORK_CACHEI);
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
