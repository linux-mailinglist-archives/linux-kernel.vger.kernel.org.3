Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98BF5A6F09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiH3VSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiH3VSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:18:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77487690
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661894314; x=1693430314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qmvV2s1yLqwtqBTQphFmhYUl/NjklmPS7cnDSGzXynk=;
  b=T1VV0U4JSYM4vLhTBiRCe083JBjcloYjlMH/4r6xivqnffPLlGerFHa6
   X+1ZEhEpGomaGFRWXxu+Ubthg7iWvFwcJAc4OUFbGZyabGQXQ1k9P47bR
   SoajYb4b/F1qkA67kOc/SzDuZ8IslIBi4Fb8yl8oD/tDynSM7KK3+ezUB
   lBX95UQUPF3prEVZGXXD3ROBpcw4SOoctF9N5F+aSNWdhiZLhs8f54OyW
   mK2vtnTzOHGflVt/yyXqbKoohRQq4pRXfuB8DozcUEJKa95I1IABbiJiM
   rIRjown9zfUzfRnfmbLoilcYGU91TKO1y/X5PkadSmWmH+qR8ujS1ga0Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275050796"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275050796"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 14:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="644991490"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 14:18:32 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT8cx-0000c1-1F;
        Tue, 30 Aug 2022 21:18:31 +0000
Date:   Wed, 31 Aug 2022 05:17:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     wuchi <wuchi.zero@gmail.com>, paul@paul-moore.com,
        eparis@redhat.com
Cc:     kbuild-all@lists.01.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: remove obvious unnecessary header files
Message-ID: <202208310505.EyxcPqGV-lkp@intel.com>
References: <20220830105001.68478-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830105001.68478-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi wuchi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wuchi/audit-remove-obvious-unnecessary-header-files/20220830-185249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: sh-randconfig-m041-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310505.EyxcPqGV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f693f8ef00782656e1a94129e11611d410914905
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wuchi/audit-remove-obvious-unnecessary-header-files/20220830-185249
        git checkout f693f8ef00782656e1a94129e11611d410914905
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched/signal.h:14,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from kernel/auditsc.c:36:
   kernel/auditsc.c: In function 'audit_seccomp':
>> arch/sh/include/asm/ptrace.h:127:30: error: implicit declaration of function 'task_stack_page'; did you mean 'task_stack_vm_area'? [-Werror=implicit-function-declaration]
     127 |         ((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
         |                              ^~~~~~~~~~~~~~~
   arch/sh/include/asm/processor_32.h:185:25: note: in expansion of macro 'task_pt_regs'
     185 | #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->pc)
         |                         ^~~~~~~~~~~~
   kernel/auditsc.c:2987:47: note: in expansion of macro 'KSTK_EIP'
    2987 |                          in_compat_syscall(), KSTK_EIP(current), code);
         |                                               ^~~~~~~~
   cc1: some warnings being treated as errors


vim +127 arch/sh/include/asm/ptrace.h

34d0b5af50a063 arch/sh/include/asm/ptrace.h Paul Mundt     2009-12-28  122  
c84b51e65ea2f2 arch/sh/include/asm/ptrace.h Paul Gortmaker 2011-07-31  123  extern void ptrace_triggered(struct perf_event *bp,
34d0b5af50a063 arch/sh/include/asm/ptrace.h Paul Mundt     2009-12-28  124  		      struct perf_sample_data *data, struct pt_regs *regs);
34d0b5af50a063 arch/sh/include/asm/ptrace.h Paul Mundt     2009-12-28  125  
3cf0f4ece9f168 include/asm-sh/ptrace.h      Al Viro        2006-01-12  126  #define task_pt_regs(task) \
4f099ebb27211d arch/sh/include/asm/ptrace.h Magnus Damm    2009-02-23 @127  	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
3cf0f4ece9f168 include/asm-sh/ptrace.h      Al Viro        2006-01-12  128  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
