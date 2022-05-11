Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D2523F80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348246AbiEKVgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348221AbiEKVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:36:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23586369FF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652304985; x=1683840985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HzjNOurWeSBIuFt076q8UcoyxyCPznKjLZ/kwEEI8Dg=;
  b=cl1sj1NvJKA4Mr4Zu1Z5OAFZ0mwJ5UrVZ5J/K1VfH7VWpCK8E+efzWu7
   cMOEh6LPsdC+4hCNZh5Gw5mjsMJFCvvCLYb1YRHRBnae3PWTGLPCMgbFH
   Pxfq6bkeyf+OM2/p0QMWRM1chwIrmG9LJ02kcZf60fYW8G9NYqGMIgZxj
   m23kaaX5kPmMirpvY0ZZ5V2CmeEIOvfhTDankLcxPgbRyippEFj/5JQPg
   F5yQJUE7vGAm2QEI80h8zcSTh+Z/bry1/Bv+Sc4IFodKCsPXmqXtWrrpx
   vvLI6CdlLpa8SVvNF9ZPY/6BjrKIVjr3L3kGGFqaDiyp/nn4lknt0NtQn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356245311"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="356245311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="624128100"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2022 14:36:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nou0L-000Jbg-DR;
        Wed, 11 May 2022 21:36:21 +0000
Date:   Thu, 12 May 2022 05:35:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 141/150] ld:
 arch/x86/entry/vsyscall/vsyscall_64.o:undefined reference to
 `__x86_indirect_alt_call_rbp'
Message-ID: <202205120544.3A1KXfVz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   305e905f70311e1b49cc730931a19c3e364f4d8c
commit: e489fafb822841cfbc89b389757f81e14ede0fd8 [141/150] x86/retpoline: Remove unused replacement symbols
config: x86_64-randconfig-a011-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120544.3A1KXfVz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/e489fafb822841cfbc89b389757f81e14ede0fd8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout e489fafb822841cfbc89b389757f81e14ede0fd8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: init/main.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: init/main.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: init/main.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: init/main.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/entry/entry_64.o:(.altinstructions+0xb8): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: arch/x86/entry/common.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
>> ld: arch/x86/entry/vsyscall/vsyscall_64.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/events/core.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x58): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x64): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x70): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x7c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x88): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x94): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0xa0): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/events/core.o:(.altinstructions+0xb8): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0xc4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0xd0): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0xdc): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0xe8): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0xf4): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x100): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x10c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x118): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x124): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x130): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x13c): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x148): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x154): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x160): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x16c): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x178): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x184): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x190): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x19c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x1a8): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x1b4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x1c0): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x1cc): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/events/core.o:(.altinstructions+0x214): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x220): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x22c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x238): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x244): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x250): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/core.o:(.altinstructions+0x25c): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/events/core.o:(.altinstructions+0x274): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/core.o:(.altinstructions+0x280): undefined reference to `__x86_indirect_alt_call_rdx'
>> ld: arch/x86/events/probe.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/amd/core.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rdx'
>> ld: arch/x86/events/amd/core.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/amd/ibs.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: arch/x86/events/amd/ibs.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x58): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x64): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x88): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0x94): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0xa0): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0xac): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0xb8): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0xc4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/events/intel/core.o:(.altinstructions+0xd0): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x58): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/irq.o:(.altinstructions+0x64): more undefined references to `__x86_indirect_alt_call_rax' follow
>> ld: arch/x86/kernel/x86_init.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/irq_work.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/irq_work.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/irq_work.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/tsc.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/tsc.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/rtc.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/rtc.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/process.o:(.altinstructions+0x124): undefined reference to `__x86_indirect_alt_jmp_rax'
>> ld: arch/x86/kernel/fpu/core.o:(.altinstructions+0xd0): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/fpu/core.o:(.altinstructions+0xdc): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/fpu/core.o:(.altinstructions+0xe8): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/fpu/core.o:(.altinstructions+0xf4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/fpu/core.o:(.altinstructions+0x100): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/fpu/core.o:(.altinstructions+0x10c): more undefined references to `__x86_indirect_alt_call_rbp' follow
>> ld: arch/x86/kernel/ptrace.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_r10'
   ld: arch/x86/kernel/ptrace.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_r10'
   ld: arch/x86/kernel/stacktrace.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: arch/x86/kernel/stacktrace.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: arch/x86/kernel/stacktrace.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rbx'
>> ld: arch/x86/kernel/stacktrace.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_r12'
   ld: arch/x86/kernel/stacktrace.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_r12'
   ld: arch/x86/kernel/cpu/common.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/common.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/common.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
>> ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x64): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x70): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x7c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x88): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x94): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xa0): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xac): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xb8): undefined reference to `__x86_indirect_alt_call_r15'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xc4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xd0): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xdc): undefined reference to `__x86_indirect_alt_call_r15'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xe8): undefined reference to `__x86_indirect_alt_call_r15'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0xf4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x100): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x10c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x118): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x124): undefined reference to `__x86_indirect_alt_call_rax'
>> ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x130): undefined reference to `__x86_indirect_alt_call_r14'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x13c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x148): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x154): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x160): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x16c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/mce/core.o:(.altinstructions+0x178): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_r12'
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/cpu/microcode/core.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/acpi/boot.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/acpi/boot.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/acpi/boot.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x40): more undefined references to `__x86_indirect_alt_jmp_rax' follow
>> ld: arch/x86/kernel/reboot.o:(.altinstructions+0x70): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x7c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/reboot.o:(.altinstructions+0x88): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/apic.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/apic.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/apic.o:(.altinstructions+0x1c): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/kernel/apic/ipi.o:(.altinstructions+0x64): undefined reference to `__x86_indirect_alt_call_r13'
>> ld: arch/x86/kernel/apic/ipi.o:(.altinstructions+0x70): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/ipi.o:(.altinstructions+0x7c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/ipi.o:(.altinstructions+0x88): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/vector.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/vector.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_r12'
   ld: arch/x86/kernel/apic/vector.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/vector.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/vector.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/hw_nmi.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/io_apic.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/apic/io_apic.o:(.altinstructions+0x10): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/kernel/crash.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbx'
>> ld: arch/x86/kernel/kprobes/core.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/kprobes/core.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/kprobes/core.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
>> ld: arch/x86/kernel/module.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/module.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/module.o:(.altinstructions+0x1c): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: arch/x86/kernel/early_printk.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/early_printk.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/hpet.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/hpet.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/kernel/kvm.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: arch/x86/kernel/kvm.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/mm/init.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/mm/init_64.o:(.altinstructions+0x244): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/mm/init_64.o:(.altinstructions+0x250): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/mm/init_64.o:(.altinstructions+0x25c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/mm/fault.o:(.altinstructions+0xac): more undefined references to `__x86_indirect_alt_call_rax' follow
>> ld: arch/x86/crypto/aegis128-aesni-glue.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_r15'
>> ld: arch/x86/crypto/aegis128-aesni-glue.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbx'
>> ld: arch/x86/crypto/sha1_ssse3_glue.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/crypto/sha1_ssse3_glue.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/crypto/sha1_ssse3_glue.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/crypto/sha1_ssse3_glue.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
>> ld: arch/x86/crypto/sha1_ssse3_glue.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: arch/x86/crypto/sha1_ssse3_glue.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: arch/x86/crypto/sm4_aesni_avx_glue.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/crypto/sm4_aesni_avx_glue.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: arch/x86/crypto/sm4_aesni_avx_glue.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
>> ld: kernel/fork.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/fork.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/fork.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/fork.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/fork.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/fork.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/panic.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/panic.o:(.altinstructions+0x10): more undefined references to `__x86_indirect_alt_call_rax' follow
>> ld: kernel/cpu.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/cpu.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/cpu.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/cpu.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_r14'
   ld: kernel/cpu.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_r14'
   ld: kernel/cpu.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_r14'
   ld: kernel/cpu.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: kernel/softirq.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/softirq.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/softirq.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/softirq.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/softirq.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/softirq.o:(.altinstructions+0x40): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: kernel/resource.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_r14'
>> ld: kernel/resource.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/resource.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/resource.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/resource.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_r12'
   ld: kernel/sysctl.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sysctl.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sysctl.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sysctl.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/ptrace.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_r14'
   ld: kernel/signal.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/signal.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/signal.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/umh.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/umh.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/umh.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/umh.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/workqueue.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/workqueue.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/workqueue.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/workqueue.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/workqueue.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: kernel/workqueue.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/task_work.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/task_work.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_r12'
   ld: kernel/params.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x58): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x64): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/params.o:(.altinstructions+0x70): undefined reference to `__x86_indirect_alt_call_rbp'
   ld: kernel/kthread.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/kthread.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/kthread.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: kernel/nsproxy.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/nsproxy.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/nsproxy.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/notifier.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/notifier.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/notifier.o:(.altinstructions+0x1c): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: kernel/async.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_r12'
   ld: kernel/async.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/smpboot.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_r12'
   ld: kernel/smpboot.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/smpboot.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_r12'
   ld: kernel/smpboot.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_r12'
   ld: kernel/smpboot.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: kernel/smpboot.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/regset.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_jmp_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x40): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x4c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x58): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x64): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x70): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: kernel/sched/core.o:(.altinstructions+0x25c): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: kernel/sched/core.o:(.altinstructions+0x268): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x274): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x280): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x28c): undefined reference to `__x86_indirect_alt_call_rcx'
   ld: kernel/sched/core.o:(.altinstructions+0x298): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: kernel/sched/core.o:(.altinstructions+0x2a4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x2b0): undefined reference to `__x86_indirect_alt_call_r13'
   ld: kernel/sched/core.o:(.altinstructions+0x2bc): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x2c8): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x2d4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x2e0): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: kernel/sched/core.o:(.altinstructions+0x2ec): undefined reference to `__x86_indirect_alt_call_rbx'
   ld: kernel/sched/core.o:(.altinstructions+0x2f8): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x304): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x310): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x31c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x328): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: kernel/sched/core.o:(.altinstructions+0x334): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x340): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x34c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x358): undefined reference to `__x86_indirect_alt_call_r10'
   ld: kernel/sched/core.o:(.altinstructions+0x364): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: kernel/sched/core.o:(.altinstructions+0x370): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x37c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x388): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x394): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x3a0): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/core.o:(.altinstructions+0x3ac): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: kernel/sched/core.o:(.altinstructions+0x3e8): undefined reference to `__x86_indirect_alt_call_rdx'
   ld: kernel/sched/fair.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/fair.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/fair.o:(.altinstructions+0x1c): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/fair.o:(.altinstructions+0x28): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/fair.o:(.altinstructions+0x34): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/rt.o:(.altinstructions+0x4): more undefined references to `__x86_indirect_alt_call_rax' follow
   ld: kernel/sched/wait_bit.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_r15'
   ld: kernel/sched/wait_bit.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_r15'
   ld: kernel/sched/psi.o:(.altinstructions+0x4): undefined reference to `__x86_indirect_alt_call_rax'
   ld: kernel/sched/psi.o:(.altinstructions+0x10): undefined reference to `__x86_indirect_alt_call_rax'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
