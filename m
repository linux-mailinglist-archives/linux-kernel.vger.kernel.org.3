Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9CC48F5A8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiAOHbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 02:31:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:56176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbiAOHbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 02:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642231909; x=1673767909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1oUULl2+pZo/eWRUTBNn4f22ShUKxXWI6Y03z2SYvMg=;
  b=VfxLI+5pafaIwbwW6Nx0bv1ONUhvIKind7JsNHY9h5RraKntGI6nRFmy
   c/fTRasVb/SWfEydlNCFTs6q9oUB0KrvG/DpPaHkCbYheyfOKOhHsRzto
   6UaqYw0bv4oEh1wrUo/ieAnN3UFQNAOZTjCD1DL87+I9fqHTPyds/04Kh
   WZUitoAqBZgJV5FQHPSX+5PROAjnLNMpa8mkNQ4kM3MYpnMO82mHXdH3D
   tVs+19EkEBccehy23HuVyEt7pjhWHr8mtzhhTKaPRAJRBzTpfYCc/g4pf
   UnsioCzCJ0ZQ3r0LuW8O1ZG39ZTrHNV98KiWB811F9mYaJe7eSdPpLuto
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="330734577"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="330734577"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 23:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="559734366"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2022 23:31:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8dXO-0009VA-MY; Sat, 15 Jan 2022 07:31:46 +0000
Date:   Sat, 15 Jan 2022 15:31:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 7/15] arch/x86/kernel/setup.c:65:1:
 warning: 'nocf_check' attribute ignored; use -fcf-protection to enable the
 attribute
Message-ID: <202201151505.wRwvYlwh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   7b31f08c5f3fb5f3cfd75deb24787569f35315d5
commit: e4b4623dc6a99968ab59ea14cdae2c7a09924838 [7/15] x86: Don't generate ENDBR in .discard.text
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220115/202201151505.wRwvYlwh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82c8aca93488730ce8f66101e0f3538f14b551dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=e4b4623dc6a99968ab59ea14cdae2c7a09924838
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout e4b4623dc6a99968ab59ea14cdae2c7a09924838
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/setup.c:65:1: warning: 'nocf_check' attribute ignored; use -fcf-protection to enable the attribute [-Wignored-attributes]
   RESERVE_BRK(dmi_alloc, 65536);
   ^
   arch/x86/include/asm/setup.h:122:56: note: expanded from macro 'RESERVE_BRK'
           static void __section(".discard.text") __attribute__((nocf_check)) __used notrace               \
                                                                 ^
   1 warning generated.
--
>> arch/x86/mm/init.c:178:1: warning: 'nocf_check' attribute ignored; use -fcf-protection to enable the attribute [-Wignored-attributes]
   RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
   ^
   arch/x86/include/asm/setup.h:122:56: note: expanded from macro 'RESERVE_BRK'
           static void __section(".discard.text") __attribute__((nocf_check)) __used notrace               \
                                                                 ^
   1 warning generated.


vim +/nocf_check +65 arch/x86/kernel/setup.c

2b72394e408964 Pekka Enberg                  2009-04-28  63  
e808bae2407a08 Thadeu Lima de Souza Cascardo 2010-02-09  64  #ifdef CONFIG_DMI
796216a57fe45c Jeremy Fitzhardinge           2009-03-12 @65  RESERVE_BRK(dmi_alloc, 65536);
e808bae2407a08 Thadeu Lima de Souza Cascardo 2010-02-09  66  #endif
796216a57fe45c Jeremy Fitzhardinge           2009-03-12  67  
c0b5842a457d44 Ingo Molnar                   2009-01-27  68  

:::::: The code at line 65 was first introduced by commit
:::::: 796216a57fe45c04adc35bda1f0782efec78a713 x86: allow extend_brk users to reserve brk space

:::::: TO: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
