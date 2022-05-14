Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50299526F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiENFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiENFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 01:36:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757E219D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652506584; x=1684042584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=72lCvlTZXVdT2hQRKVWIpIRbn5DvknpqGg6IQjllo4k=;
  b=P76xfe4ou9phiUoZSDohniHMMIDyc6ZYP9MEoCF6evAv1drlydbxlAJR
   LaskoHISGMeQoDg9YyKHONNTAxt21geHCH3fvKzXWqvzc8y6nZ2ThmLUP
   Mont8ub8Vy/wOrxXjEW+vc78B3qZKWCCkMtA4e+Run/zUo6i0Ydf7u4/j
   RVhQin97ltnEmf7XtZl+oDeF/ntxvYWPt3U22mmgsMp6+TVcRR79nr8u2
   GQNscGv61TlkzvuI/rwuFScdJw6822y7RGfC6UYVVaPTnG4AJP6CzrTV4
   wFKnba15HTiQ9tO27PrPY0uYRCUKl8i8tQK5nCtSkLITe527Vt7pgUTmn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="331079020"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="331079020"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 22:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="659405674"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2022 22:36:20 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npkRv-0000G1-VM;
        Sat, 14 May 2022 05:36:19 +0000
Date:   Sat, 14 May 2022 13:36:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [nsaenz-rpi:ct-work-defer-wip 23/25]
 arch/x86/kernel/alternative.c:1186:47: error: 'CONTEXT_WORK_SYNC' undeclared
Message-ID: <202205141328.mnihXHJe-lkp@intel.com>
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
commit: d79e9aa1c1e3f664fff9d4e83500d7884777cad9 [23/25] context_tracking,x86: Fix text_poke_sync() vs NOHZ_FULL
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220514/202205141328.mnihXHJe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=d79e9aa1c1e3f664fff9d4e83500d7884777cad9
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout d79e9aa1c1e3f664fff9d4e83500d7884777cad9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/alternative.c: In function 'do_sync_core_cond':
>> arch/x86/kernel/alternative.c:1186:47: error: 'CONTEXT_WORK_SYNC' undeclared (first use in this function)
    1186 |                                               CONTEXT_WORK_SYNC);
         |                                               ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/alternative.c:1186:47: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kernel/alternative.c:1187:1: error: control reaches end of non-void function [-Werror=return-type]
    1187 | }
         | ^
   cc1: some warnings being treated as errors


vim +/CONTEXT_WORK_SYNC +1186 arch/x86/kernel/alternative.c

  1182	
  1183	static bool do_sync_core_cond(int cpu, void *info)
  1184	{
  1185		return !context_tracking_set_cpu_work(cpu, CONTEXT_USER | CONTEXT_GUEST,
> 1186						      CONTEXT_WORK_SYNC);
  1187	}
  1188	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
