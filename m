Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F233D54DF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376332AbiFPKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiFPKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:50:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0275DD00
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655376658; x=1686912658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t50xOY5g1xaxtZHzE7OAB+CqWcuyhSiUYsITH+LFj7U=;
  b=Waje5z33w0qL/ZNmxQeIQc9ocJuCEf/vS43urFzkgJOc5cBLo5uyJ2iX
   in4xcBMpXeTpiW5v6yNarGnDI0u6urJpbAfhSu44DDZuq8RM3kzaIbJin
   jl24EanEuIJC+kt3BOMXr4gJCZzw4i/uj3neRQ04/pjShJvKk2AEUJbvm
   OshQlzZVsH/VvmoS0HF6hn2FhUgjC+TEr2fs6ybl3+fIaSED4/b0lZyWh
   aILM7+yzTwdKbNSzQKjGpbO2lsLWao/RmrOkfLpF65pghRDcjumWvWb/g
   LzzGhW3BG7a2RyuREiQ2e86+CRpt/u+gE4MAa8mTr9A/JdklzmorWlYOb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279937045"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="279937045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 03:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="674969936"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2022 03:50:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1n5U-000OIv-5c;
        Thu, 16 Jun 2022 10:50:56 +0000
Date:   Thu, 16 Jun 2022 18:50:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:jump-label-nop-patching-cleanup-v2 6/6]
 kernel/jump_label.c:336:13: error: static declaration of
 'arch_jump_label_transform_static' follows non-static declaration
Message-ID: <202206161816.11vbdgXt-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git jump-label-nop-patching-cleanup-v2
head:   744ed73c1f97ab081fa753030a27d7fe5865f8c4
commit: 744ed73c1f97ab081fa753030a27d7fe5865f8c4 [6/6] jump_label: make initial NOP patching the special case
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220616/202206161816.11vbdgXt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=744ed73c1f97ab081fa753030a27d7fe5865f8c4
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb jump-label-nop-patching-cleanup-v2
        git checkout 744ed73c1f97ab081fa753030a27d7fe5865f8c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/jump_label.c:336:13: error: static declaration of 'arch_jump_label_transform_static' follows non-static declaration
     336 | static void arch_jump_label_transform_static(struct jump_entry *entry,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:584,
                    from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/memory.h:19,
                    from kernel/jump_label.c:9:
   include/linux/jump_label.h:223:13: note: previous declaration of 'arch_jump_label_transform_static' with type 'void(struct jump_entry *, enum jump_label_type)'
     223 | extern void arch_jump_label_transform_static(struct jump_entry *entry,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_jump_label_transform_static +336 kernel/jump_label.c

   334	
   335	#ifndef arch_jump_label_transform_static
 > 336	static void arch_jump_label_transform_static(struct jump_entry *entry,
   337						     enum jump_label_type type)
   338	{
   339		/* nothing to do on most architectures */
   340	}
   341	#endif
   342	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
