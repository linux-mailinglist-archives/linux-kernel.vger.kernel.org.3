Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE55A704D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiH3WCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiH3WCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:02:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E290817
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661896719; x=1693432719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0QchS3pToVSk2fYaF5BA3KmAYs9eoRF9CtFUbxdGHBw=;
  b=AX1+gRhejoK5ncibeDGERIInK75BDrT58U1rHdz7sfKij459BrcxGF+b
   MUuWo/YshSeHIfK72vg6QBHUholVK8OnWyDPxSgopF2mjfoQM43gxoHqk
   4+7UwIeoM3COjtQI5s5fjCyQE5e8tg4uG4NdjmfBzZMXXkeQup9U+j6wt
   8cG4z+Z/3WVYQG0BlnYHVR9UOb5QV3m9M1/7FqlEaWg3quJ4ms19yvlQL
   WPJzFNOArF7zNDSImBzqolVyqUt6B4cXwmBHFUT9OWERaxftrwHPQCVUx
   y5CFO6ByYMrcRa2NqUWz3iI6T2hrPB781TOQc7WsDpxNR+tCoa9iP73TE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296093117"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="296093117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 14:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562819004"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 14:58:34 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9Fh-0000fG-1R;
        Tue, 30 Aug 2022 21:58:33 +0000
Date:   Wed, 31 Aug 2022 05:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     wuchi <wuchi.zero@gmail.com>, paul@paul-moore.com,
        eparis@redhat.com
Cc:     kbuild-all@lists.01.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: remove obvious unnecessary header files
Message-ID: <202208310549.y7u0iX8g-lkp@intel.com>
References: <20220830105001.68478-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830105001.68478-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-randconfig-r015-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310549.y7u0iX8g-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f693f8ef00782656e1a94129e11611d410914905
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wuchi/audit-remove-obvious-unnecessary-header-files/20220830-185249
        git checkout f693f8ef00782656e1a94129e11611d410914905
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/prefetch.h:15,
                    from arch/arm/include/asm/atomic.h:12,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arm/include/asm/bitops.h:245,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from kernel/auditsc.c:36:
   kernel/auditsc.c: In function 'audit_seccomp':
>> arch/arm/include/asm/processor.h:90:47: error: implicit declaration of function 'task_stack_page'; did you mean 'task_stack_vm_area'? [-Werror=implicit-function-declaration]
      90 |         ((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
         |                                               ^~~~~~~~~~~~~~~
   arch/arm/include/asm/processor.h:92:25: note: in expansion of macro 'task_pt_regs'
      92 | #define KSTK_EIP(tsk)   task_pt_regs(tsk)->ARM_pc
         |                         ^~~~~~~~~~~~
   kernel/auditsc.c:2987:47: note: in expansion of macro 'KSTK_EIP'
    2987 |                          in_compat_syscall(), KSTK_EIP(current), code);
         |                                               ^~~~~~~~
   cc1: some warnings being treated as errors


vim +90 arch/arm/include/asm/processor.h

^1da177e4c3f41 include/asm-arm/processor.h Linus Torvalds 2005-04-16  88  
815d5ec86eb8d5 include/asm-arm/processor.h Al Viro        2006-01-12  89  #define task_pt_regs(p) \
32d39a9355780b include/asm-arm/processor.h Al Viro        2006-01-12 @90  	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
815d5ec86eb8d5 include/asm-arm/processor.h Al Viro        2006-01-12  91  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
