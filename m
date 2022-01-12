Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07248CCFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357419AbiALURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:17:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:56843 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350686AbiALUQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642018615; x=1673554615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HXPrLKJowCfeCnB9zoarH5HpzOBs10cvTFKPDQBim2o=;
  b=klotnpYo/PE8S5W+w1IRLP3khxojND3bmLiqZ+0BHtsNv66M1Mu20QjA
   P/A9/r8dmCYBurPUf/tw3AnIYme1v7A2FyZk+oLQ4BKRlYTw7KUlQ1GUp
   nRXgbGTmPPMiBSvZoPhmz4aLJJYh4080GndGyzg3jvQqoK9/e4LYYIk8W
   6ENIWoZl3bzpjUI39L7yYJJ8cSis44snOxm7h+0USKchxgrhS64VPs0b9
   8hflntxEEGtx5AyrBc5cfl/gK1fbOu7blc8OCzrGrWTh602R0ZxLyOjAk
   cYnVZ86Gz1ZTsyv6duXv1BAGk4G+1Pu3esMq6Cmj31JtswGQ6xLb9rVN9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224538064"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="224538064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="472966624"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2022 12:16:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7k2U-0006MB-Kt; Wed, 12 Jan 2022 20:16:10 +0000
Date:   Thu, 13 Jan 2022 04:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.4.y 2563/9999]
 arch/ia64/kernel/kprobes.c:401:24: error: implicit declaration of function
 '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'?
Message-ID: <202201130408.tdm9swhk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   0a4ce4977bbeea4560a1f32632650b388c834c8a
commit: 77fa5e15c933a1ec812de61ad709c00aa51e96ae [2563/9999] ia64: kprobes: Use generic kretprobe trampoline handler
config: ia64-randconfig-r002-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130408.tdm9swhk-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=77fa5e15c933a1ec812de61ad709c00aa51e96ae
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout 77fa5e15c933a1ec812de61ad709c00aa51e96ae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/ia64/kernel/kprobes.c: In function 'get_kprobe_inst':
   arch/ia64/kernel/kprobes.c:325:22: warning: variable 'template' set but not used [-Wunused-but-set-variable]
     325 |         unsigned int template;
         |                      ^~~~~~~~
   arch/ia64/kernel/kprobes.c: At top level:
   arch/ia64/kernel/kprobes.c:399:15: warning: no previous prototype for 'trampoline_probe_handler' [-Wmissing-prototypes]
     399 | int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/ia64/kernel/kprobes.c: In function 'trampoline_probe_handler':
>> arch/ia64/kernel/kprobes.c:401:24: error: implicit declaration of function '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'? [-Werror=implicit-function-declaration]
     401 |         regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        kretprobe_trampoline
   cc1: some warnings being treated as errors


vim +401 arch/ia64/kernel/kprobes.c

   398	
   399	int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
   400	{
 > 401		regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
   402		/*
   403		 * By returning a non-zero value, we are telling
   404		 * kprobe_handler() that we don't want the post_handler
   405		 * to run (and have re-enabled preemption)
   406		 */
   407		return 1;
   408	}
   409	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
