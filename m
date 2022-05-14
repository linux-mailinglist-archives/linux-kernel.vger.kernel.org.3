Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928CF526F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiENHuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiENHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 03:50:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0758108
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652514630; x=1684050630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IMNK+cEfcC39oj9PRrtqbPP060A/x33AwMsn6Uzg1/8=;
  b=PIsGe9h5X22jLOXAbxDSr4P9RsPv9ftMzTy9y0dl9MNXXaKflf87DBJV
   nbQoSxqmZSUrTgFCmOaCNXlJ//R0oTNrDOvuSV+QSFyWPByXAJkCl74/n
   zyAyA9/SHh+wXvXvdMoCmgFugsDrBuexLjxwNaQ416481ZLy59jVSBrvh
   MJptexqqD9sIuzz2/LkpbuyoSW4321v2H79TFX+Axtd4a5S8u7BPaed9o
   nlzJxvE9BrTOHs4A/ixbfpR/0UOeYA/mFCMnh8gksHQkXXXt97nvwQowA
   zEy+6QhevhEi7NdQYnH3eBljTtPBiBiJ5/+7a48ntBMA9CBRJ4o2g0u2f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="258039374"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="258039374"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 00:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="554526425"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2022 00:50:27 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npmXi-0000Mb-KB;
        Sat, 14 May 2022 07:50:26 +0000
Date:   Sat, 14 May 2022 15:49:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 24/25] tlb.c:undefined reference to
 `context_tracking_set_cpu_work'
Message-ID: <202205141530.ZGM2bat1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: ac6fd7356ff9f2e0f040ef337d3eb731454ce49f [24/25] context_tracking,x86: Fix Kernel TLBi vs NOHZ_FULL
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220514/202205141530.ZGM2bat1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=ac6fd7356ff9f2e0f040ef337d3eb731454ce49f
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout ac6fd7356ff9f2e0f040ef337d3eb731454ce49f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: enter_from_user_mode+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x1d: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   ld: arch/x86/kernel/alternative.o: in function `do_sync_core_cond':
   alternative.c:(.text+0x68e): undefined reference to `context_tracking_set_cpu_work'
   ld: arch/x86/mm/tlb.o: in function `do_kernel_flush_cond':
>> tlb.c:(.text+0x297): undefined reference to `context_tracking_set_cpu_work'
   ld: arch/x86/mm/pat/set_memory.o: in function `__cpa_flush_tlb_cond':
>> set_memory.c:(.text+0x888): undefined reference to `context_tracking_set_cpu_work'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
