Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903724881C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 07:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiAHF5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 00:57:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:40530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbiAHF5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641621460; x=1673157460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MEGEe2TO5CsDXt6MmyOuchwrcEJD4yCS+7s06ztTcaE=;
  b=TJbT+rq4L5N6+I34nc5M5wIm0Q6kDFAW9ihnmVoy1uVL6JDqCuR9ZfTo
   0+ceRy0zS8xxg9F/+LQVwCr4j7b3s8gSEZBCsjEQRnBZwXR3VxeDrWlZ9
   giLb1AbC/OC0zQvZp6zkDNTWc0V22hZZELaxzaOFaFYI0XeUTuXK1qNNu
   AUc0U4Tf/4NTMcsgJaM/PXCCl4pOJ4LONNkhz9hfFDKJG1C+QaP4ZJhfz
   3lzPTvBdDLag4IPb4ktckjWnCltoNnprG/on9REwBZftG/H0SPKoY0XPl
   R1bwcrX3IH0r5XNWYQ4GOG+7TP+m8v9WPcde930dbEa+1FwUZpreuxbyI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240539242"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240539242"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 21:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473573738"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2022 21:57:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n64jS-0000J2-Cg; Sat, 08 Jan 2022 05:57:38 +0000
Date:   Sat, 8 Jan 2022 13:56:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 104/2372] init/main.c:884:13: warning: no
 previous prototype for function 'init_per_task_early'
Message-ID: <202201081348.mrJjpM8b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: eefe4b7749e3afbf9a5cb237cfb3727701126996 [104/2372] headers/deps: cpusets: Move task_struct::mems_allowed_seq to per_task()
config: i386-randconfig-r014-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081348.mrJjpM8b-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=eefe4b7749e3afbf9a5cb237cfb3727701126996
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout eefe4b7749e3afbf9a5cb237cfb3727701126996
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   init/main.c:783:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
>> init/main.c:884:13: warning: no previous prototype for function 'init_per_task_early' [-Wmissing-prototypes]
   void __init init_per_task_early(void)
               ^
   init/main.c:884:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_per_task_early(void)
   ^
   static 
   2 warnings generated.


vim +/init_per_task_early +884 init/main.c

   883	
 > 884	void __init init_per_task_early(void)
   885	{
   886	#ifdef CONFIG_POSIX_TIMERS
   887		per_task(&init_task, posix_cputimers) = (struct posix_cputimers) __INIT_CPU_TIMERS(init_task);
   888	#endif
   889	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
