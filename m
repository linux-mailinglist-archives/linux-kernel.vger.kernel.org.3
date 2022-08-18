Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001F598EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346632AbiHRVJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346280AbiHRVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:08:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9AD51ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660856643; x=1692392643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=enuGV+fx9Yyxk1sFYga4fMlHlv7RgJRfNkf+1q9h01k=;
  b=Rcp6WWUk4/pP9JHk5STW3LnkK+qSJqt3v4tJt9uUak2SIfXxNmNC+F0J
   FIkTcI5LvIV8OIV6sN3/GiDbF/R+f8ggKMGqHYMC6GMsNqdNg55IliFue
   XrwBSzN8H2V3Gg/992th3QkxqK5HzILbm6GCye/jkPD/M2Y7/hPVfeBsc
   iXAXqYX42aqCC8PzPsyjGc3gza1klzUE6HB4Uv+cO/IXewKcWUMM1PS34
   xWijCow0uIkzH9ThNGj06Yeo/j7o9OuenXxAFELgLIgInM94jYsU1KXLW
   bsfI6JdmBRmYvKGCNCeV0dmlijpxyY3iesH4I3tLhGDnk5C7x+HT07TD3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="279830785"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="279830785"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 14:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="935964954"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2022 14:03:10 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOmfW-0000bt-0g;
        Thu, 18 Aug 2022 21:03:10 +0000
Date:   Fri, 19 Aug 2022 05:02:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:objtool/core 4/5] arch/x86/kvm/emulate.c:330:9: error:
 expected ')' before 'IBT_NOSEAL'
Message-ID: <202208190440.YNgyh4sX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
head:   56097f45807c0c230bc02116328732e85da8b0b0
commit: 69e297b0cf20139a1684d61420a78911776ebe55 [4/5] x86/kvm: Fix "missing ENDBR" BUG for fastop functions
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220819/202208190440.YNgyh4sX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=69e297b0cf20139a1684d61420a78911776ebe55
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue objtool/core
        git checkout 69e297b0cf20139a1684d61420a78911776ebe55
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:333:9: note: in expansion of macro '__FOP_FUNC'
     333 |         __FOP_FUNC(#name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:451:9: note: in expansion of macro 'FOP_FUNC'
     451 |         FOP_FUNC(op) \
         |         ^~~~~~~~
   arch/x86/kvm/emulate.c:456:1: note: in expansion of macro 'FOP_SETCC'
     456 | FOP_SETCC(seto)
         | ^~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:455:1: note: in expansion of macro 'FOP_START'
     455 | FOP_START(setcc)
         | ^~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:333:9: note: in expansion of macro '__FOP_FUNC'
     333 |         __FOP_FUNC(#name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:475:1: note: in expansion of macro 'FOP_FUNC'
     475 | FOP_FUNC(salc)
         | ^~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:474:1: note: in expansion of macro 'FOP_START'
     474 | FOP_START(salc)
         | ^~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1005:1: note: in expansion of macro 'FASTOP2'
    1005 | FASTOP2(add);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1005:1: note: in expansion of macro 'FASTOP2'
    1005 | FASTOP2(add);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1006:1: note: in expansion of macro 'FASTOP2'
    1006 | FASTOP2(or);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1006:1: note: in expansion of macro 'FASTOP2'
    1006 | FASTOP2(or);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1007:1: note: in expansion of macro 'FASTOP2'
    1007 | FASTOP2(adc);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1007:1: note: in expansion of macro 'FASTOP2'
    1007 | FASTOP2(adc);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1008:1: note: in expansion of macro 'FASTOP2'
    1008 | FASTOP2(sbb);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1008:1: note: in expansion of macro 'FASTOP2'
    1008 | FASTOP2(sbb);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1009:1: note: in expansion of macro 'FASTOP2'
    1009 | FASTOP2(and);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1009:1: note: in expansion of macro 'FASTOP2'
    1009 | FASTOP2(and);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1010:1: note: in expansion of macro 'FASTOP2'
    1010 | FASTOP2(sub);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1010:1: note: in expansion of macro 'FASTOP2'
    1010 | FASTOP2(sub);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1011:1: note: in expansion of macro 'FASTOP2'
    1011 | FASTOP2(xor);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1011:1: note: in expansion of macro 'FASTOP2'
    1011 | FASTOP2(xor);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1012:1: note: in expansion of macro 'FASTOP2'
    1012 | FASTOP2(cmp);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1012:1: note: in expansion of macro 'FASTOP2'
    1012 | FASTOP2(cmp);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:402:9: note: in expansion of macro 'FOP2E'
     402 |         FOP2E(op##b, al, dl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1013:1: note: in expansion of macro 'FASTOP2'
    1013 | FASTOP2(test);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:401:9: note: in expansion of macro 'FOP_START'
     401 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1013:1: note: in expansion of macro 'FASTOP2'
    1013 | FASTOP2(test);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:380:9: note: in expansion of macro 'FOP1E'
     380 |         FOP1E(op, cl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1015:1: note: in expansion of macro 'FASTOP1SRC2'
    1015 | FASTOP1SRC2(mul, mul_ex);
         | ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:379:9: note: in expansion of macro 'FOP_START'
     379 |         FOP_START(name) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1015:1: note: in expansion of macro 'FASTOP1SRC2'
    1015 | FASTOP1SRC2(mul, mul_ex);
         | ^~~~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:380:9: note: in expansion of macro 'FOP1E'
     380 |         FOP1E(op, cl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1016:1: note: in expansion of macro 'FASTOP1SRC2'
    1016 | FASTOP1SRC2(imul, imul_ex);
         | ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:379:9: note: in expansion of macro 'FOP_START'
     379 |         FOP_START(name) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1016:1: note: in expansion of macro 'FASTOP1SRC2'
    1016 | FASTOP1SRC2(imul, imul_ex);
         | ^~~~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:367:9: note: in expansion of macro 'FOP1E'
     367 |         FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %%esi)
         |         ^~~~~
   arch/x86/kvm/emulate.c:389:9: note: in expansion of macro 'FOP1EEX'
     389 |         FOP1EEX(op, cl) \
         |         ^~~~~~~
   arch/x86/kvm/emulate.c:1017:1: note: in expansion of macro 'FASTOP1SRC2EX'
    1017 | FASTOP1SRC2EX(div, div_ex);
         | ^~~~~~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:388:9: note: in expansion of macro 'FOP_START'
     388 |         FOP_START(name) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1017:1: note: in expansion of macro 'FASTOP1SRC2EX'
    1017 | FASTOP1SRC2EX(div, div_ex);
         | ^~~~~~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:367:9: note: in expansion of macro 'FOP1E'
     367 |         FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %%esi)
         |         ^~~~~
   arch/x86/kvm/emulate.c:389:9: note: in expansion of macro 'FOP1EEX'
     389 |         FOP1EEX(op, cl) \
         |         ^~~~~~~
   arch/x86/kvm/emulate.c:1018:1: note: in expansion of macro 'FASTOP1SRC2EX'
    1018 | FASTOP1SRC2EX(idiv, idiv_ex);
         | ^~~~~~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:388:9: note: in expansion of macro 'FOP_START'
     388 |         FOP_START(name) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1018:1: note: in expansion of macro 'FASTOP1SRC2EX'
    1018 | FASTOP1SRC2EX(idiv, idiv_ex);
         | ^~~~~~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:355:9: note: in expansion of macro '__FOP_FUNC'
     355 |         __FOP_FUNC(name) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:359:9: note: in expansion of macro '__FOPNOP'
     359 |         __FOPNOP(__stringify(__UNIQUE_ID(nop)))
         |         ^~~~~~~~
   arch/x86/kvm/emulate.c:443:9: note: in expansion of macro 'FOPNOP'
     443 |         FOPNOP() \
         |         ^~~~~~
   arch/x86/kvm/emulate.c:1020:1: note: in expansion of macro 'FASTOP3WCL'
    1020 | FASTOP3WCL(shld);
         | ^~~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:442:9: note: in expansion of macro 'FOP_START'
     442 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1020:1: note: in expansion of macro 'FASTOP3WCL'
    1020 | FASTOP3WCL(shld);
         | ^~~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:355:9: note: in expansion of macro '__FOP_FUNC'
     355 |         __FOP_FUNC(name) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:359:9: note: in expansion of macro '__FOPNOP'
     359 |         __FOPNOP(__stringify(__UNIQUE_ID(nop)))
         |         ^~~~~~~~
   arch/x86/kvm/emulate.c:443:9: note: in expansion of macro 'FOPNOP'
     443 |         FOPNOP() \
         |         ^~~~~~
   arch/x86/kvm/emulate.c:1021:1: note: in expansion of macro 'FASTOP3WCL'
    1021 | FASTOP3WCL(shrd);
         | ^~~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:442:9: note: in expansion of macro 'FOP_START'
     442 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1021:1: note: in expansion of macro 'FASTOP3WCL'
    1021 | FASTOP3WCL(shrd);
         | ^~~~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:355:9: note: in expansion of macro '__FOP_FUNC'
     355 |         __FOP_FUNC(name) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:359:9: note: in expansion of macro '__FOPNOP'
     359 |         __FOPNOP(__stringify(__UNIQUE_ID(nop)))
         |         ^~~~~~~~
   arch/x86/kvm/emulate.c:411:9: note: in expansion of macro 'FOPNOP'
     411 |         FOPNOP() \
         |         ^~~~~~
   arch/x86/kvm/emulate.c:1023:1: note: in expansion of macro 'FASTOP2W'
    1023 | FASTOP2W(imul);
         | ^~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:410:9: note: in expansion of macro 'FOP_START'
     410 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1023:1: note: in expansion of macro 'FASTOP2W'
    1023 | FASTOP2W(imul);
         | ^~~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:371:9: note: in expansion of macro 'FOP1E'
     371 |         FOP1E(op##b, al) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1025:1: note: in expansion of macro 'FASTOP1'
    1025 | FASTOP1(not);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:370:9: note: in expansion of macro 'FOP_START'
     370 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1025:1: note: in expansion of macro 'FASTOP1'
    1025 | FASTOP1(not);
         | ^~~~~~~
>> arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:371:9: note: in expansion of macro 'FOP1E'
     371 |         FOP1E(op##b, al) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1026:1: note: in expansion of macro 'FASTOP1'
    1026 | FASTOP1(neg);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:370:9: note: in expansion of macro 'FOP_START'
     370 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1026:1: note: in expansion of macro 'FASTOP1'
    1026 | FASTOP1(neg);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:371:9: note: in expansion of macro 'FOP1E'
     371 |         FOP1E(op##b, al) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1027:1: note: in expansion of macro 'FASTOP1'
    1027 | FASTOP1(inc);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:370:9: note: in expansion of macro 'FOP_START'
     370 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1027:1: note: in expansion of macro 'FASTOP1'
    1027 | FASTOP1(inc);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:362:9: note: in expansion of macro '__FOP_FUNC'
     362 |         __FOP_FUNC(#op "_" #dst) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:371:9: note: in expansion of macro 'FOP1E'
     371 |         FOP1E(op##b, al) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1028:1: note: in expansion of macro 'FASTOP1'
    1028 | FASTOP1(dec);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:370:9: note: in expansion of macro 'FOP_START'
     370 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1028:1: note: in expansion of macro 'FASTOP1'
    1028 | FASTOP1(dec);
         | ^~~~~~~
   arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:420:9: note: in expansion of macro 'FOP2E'
     420 |         FOP2E(op##b, al, cl) \
         |         ^~~~~
   arch/x86/kvm/emulate.c:1030:1: note: in expansion of macro 'FASTOP2CL'
    1030 | FASTOP2CL(rol);
         | ^~~~~~~~~
   arch/x86/kvm/emulate.c:344:12: note: to match this '('
     344 |         asm(".pushsection .text, \"ax\" \n\t" \
         |            ^
   arch/x86/kvm/emulate.c:349:23: note: in expansion of macro '__FOP_START'
     349 | #define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
         |                       ^~~~~~~~~~~
   arch/x86/kvm/emulate.c:419:9: note: in expansion of macro 'FOP_START'
     419 |         FOP_START(op) \
         |         ^~~~~~~~~
   arch/x86/kvm/emulate.c:1030:1: note: in expansion of macro 'FASTOP2CL'
    1030 | FASTOP2CL(rol);
         | ^~~~~~~~~
   arch/x86/kvm/emulate.c:330:9: error: expected ')' before 'IBT_NOSEAL'
     330 |         IBT_NOSEAL(name)
         |         ^~~~~~~~~~
   arch/x86/kvm/emulate.c:396:9: note: in expansion of macro '__FOP_FUNC'
     396 |         __FOP_FUNC(#op "_" #dst "_" #src) \


vim +330 arch/x86/kvm/emulate.c

   324	
   325	#define __FOP_FUNC(name) \
   326		".align " __stringify(FASTOP_SIZE) " \n\t" \
   327		".type " name ", @function \n\t" \
   328		name ":\n\t" \
   329		ASM_ENDBR \
 > 330		IBT_NOSEAL(name)
   331	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
