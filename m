Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1A48D6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiAMLzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:55:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:11406 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbiAMLzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642074944; x=1673610944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LtGS+dHAlZZ57boP/K9NFFKaU+eEtvp+/DAYNw2stQ8=;
  b=MMa0702hq4CnS6yopQ9NsTx+g7+kYV8oRZrpqlyRvECU8WgPKSXF9Rle
   j9lPH9dKqVziUpDT1+BtIgHXSUPQWSfJIdfvVqnlkNs4G76314oMspOoS
   J9VNGA5SJHS2lhL7M465BSztD+tOUswB7cgGPQyeGRzER07A6hyIfZQSk
   /UeUidF15WsQkl0czj03uUSAwsa2sof3WmEpGBxSOAPsh89nGdfF1UxMm
   /PiDCZxPRy+2bM6s640/muQXwJJVO0XPYc7PUdVRrnik2TNAnaEhF8JKU
   H/6eFHy32K1Z2m6rBiL63ltVpCfXCo67COGg1XWwyrbEvYlmsFg0antij
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="268343669"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="268343669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 03:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="475284808"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 03:55:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7yhi-00079t-8P; Thu, 13 Jan 2022 11:55:42 +0000
Date:   Thu, 13 Jan 2022 19:55:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 571/2382] elf.c:496:18: error: no member
 named 'len' in 'struct section'
Message-ID: <202201131950.VXD05up8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 4e8fb52df12408e936d71ebf34aaa990fd61e736 [571/2382] objtool/kallsyms: Copy the symbol name and offset to the new __kallsyms ELF section
config: x86_64-randconfig-a015-20220109 (https://download.01.org/0day-ci/archive/20220113/202201131950.VXD05up8-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4e8fb52df12408e936d71ebf34aaa990fd61e736
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4e8fb52df12408e936d71ebf34aaa990fd61e736
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 1a880941a087613ed42f77001229edfcf75ea8a5 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> elf.c:496:18: error: no member named 'len' in 'struct section'
                           sec_kallsyms->len += data->d_size;
                           ~~~~~~~~~~~~  ^
   1 error generated.
   make[4]: *** [tools/build/Makefile.build:96: tools/objtool/elf.o] Error 1
   make[4]: *** Waiting for unfinished jobs....
   make[3]: *** [Makefile:56: tools/objtool/objtool-in.o] Error 2
   make[2]: *** [Makefile:69: objtool] Error 2
   make[1]: *** [Makefile:1349: tools/objtool] Error 2
   In file included from arch/x86/kernel/asm-offsets.c:34:
   arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for function 'per_task_common' [-Wmissing-prototypes]
   void __used per_task_common(void)
               ^
   arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __used per_task_common(void)
   ^
   static 
   1 warning generated.
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
