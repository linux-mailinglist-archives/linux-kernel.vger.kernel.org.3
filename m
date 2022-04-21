Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA59509B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387015AbiDUIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387006AbiDUIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:55:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A26DF49
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650531138; x=1682067138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3EC3KlKKZO/UYyJjPtajH9hjh9GX6FEadOKY32nXFaI=;
  b=dyf3bwqRTHgzusycm2ePIBdNm6oZAhxuErMmoeFhIsxZSd9nV/CWsDPK
   qD99O8QFL8vRuN8b8Gh+aXWM7Is6p8dx3WOls83b+DM+W/C+zh4oETJ8Y
   DoctN13zu9v+Jfwn/bYyfeRd5psq4kKIbMcnA8gK5eFMk3DVyTxkfedwB
   HxXQW4EAhgMuCzUk9hEYuDIh2v2a6BVhM/gpILu58dP1WIX8P46gHsthJ
   TUw7YRDBTkIMIZ+beR4hxgWIjjeYmBkyWCZ5wk+fF/PGeMJaafkWZ7Bmh
   5xoiYX7smuyHg+I7Uuf3+4nq2iCT98Im+XD4V8ED1SPDxljoXjVOExlNE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327188634"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327188634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703002903"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 01:52:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhSXv-000893-S5;
        Thu, 21 Apr 2022 08:52:15 +0000
Date:   Thu, 21 Apr 2022 16:51:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1987/2579]
 arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for
 function 'sysenter_setup'
Message-ID: <202204211627.pSYrSUgt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 3edbef1e72915c9356080e1e09b29bd64b1673ae [1987/2579] headers/deps: x86/elf: Optimize <asm/elf.h> dependencies, split out <asm/elf_api.h>
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204211627.pSYrSUgt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3edbef1e72915c9356080e1e09b29bd64b1673ae
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3edbef1e72915c9356080e1e09b29bd64b1673ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/crypto/ arch/x86/entry/ arch/x86/kernel/cpu/ arch/x86/pci/ kernel/bpf/ kernel/trace/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for function 'sysenter_setup' [-Wmissing-prototypes]
   int __init sysenter_setup(void)
              ^
   arch/x86/entry/vdso/vdso32-setup.c:55:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init sysenter_setup(void)
   ^
   static 
   1 warning generated.


vim +/sysenter_setup +55 arch/x86/entry/vdso/vdso32-setup.c

^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  54  
a6c4e076ee4c1e arch/i386/kernel/sysenter.c        Jeremy Fitzhardinge 2007-05-02 @55  int __init sysenter_setup(void)
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  56  {
0a6d1fa0d2b48f arch/x86/entry/vdso/vdso32-setup.c Andy Lutomirski     2015-10-05  57  	init_vdso_image(&vdso_image_32);
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  58  
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  59  	return 0;
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  60  }
e6e5494cb23d19 arch/i386/kernel/sysenter.c        Ingo Molnar         2006-06-27  61  

:::::: The code at line 55 was first introduced by commit
:::::: a6c4e076ee4c1ea670e4faa55814e63dd08e3f29 [PATCH] i386: clean up identify_cpu

:::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
:::::: CC: Andi Kleen <andi@basil.nowhere.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
