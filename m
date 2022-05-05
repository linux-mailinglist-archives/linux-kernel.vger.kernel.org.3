Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD9851B55B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiEEBr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiEEBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:47:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018584C41E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715028; x=1683251028;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zwza5U7NsfaBQi0ChOCEggAFl0x8H9t6iT813UM9/Ck=;
  b=NEmLBxMQgqAzPJ8ev5N2e5a96vbmJKWPaoFDzr6BsRKSmhJeIFBI/j5l
   yNC53T8bDpVwA956oi1+mvaMMQTIZDW+pUtd5z0SbfFD3SDaxWCUcqkyq
   qOhMwTO0HuAVXf+Xf0ce4Uips2ZbcqrUtDQtr07KNFbrRdxxjplxx0gIu
   LuZTkcSBbVaP77Asnv8Iw5vUf4Eo4vcjr8MlsV/dx+fMYi3ON5zAkknNR
   MytabuJsxQFlFxTmWCBopXXhK4pyDQs21uDwjIrSfEWjwLTBZzRdxD9Bh
   Sqv5la97KM9QDXZaOKy9z3+/P88wU0cRsFR0gNd+9sLaflMO3azDiisa9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265548883"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="265548883"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621071506"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2022 18:43:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmQWv-000ByF-HV;
        Thu, 05 May 2022 01:43:45 +0000
Date:   Thu, 5 May 2022 09:43:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [kees:for-next/kspp 21/25] drivers/misc/lkdtm/stackleak.c:17:39:
 error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202205050943.HDgeO9iV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/kspp
head:   d46ac904fd35edfccc5080818e950d4d3b4697c4
commit: f4cfacd92972cc440d534b5156df23d0a2136bab [21/25] lkdtm/stackleak: rework boundary management
config: s390-randconfig-r044-20220502 (https://download.01.org/0day-ci/archive/20220505/202205050943.HDgeO9iV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=f4cfacd92972cc440d534b5156df23d0a2136bab
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/kspp
        git checkout f4cfacd92972cc440d534b5156df23d0a2136bab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/lkdtm/stackleak.c:17:39: error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const unsigned long task_stack_low = stackleak_task_low_bound(current);
                                                ^
>> drivers/misc/lkdtm/stackleak.c:18:40: error: call to undeclared function 'stackleak_task_high_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const unsigned long task_stack_high = stackleak_task_high_bound(current);
                                                 ^
   drivers/misc/lkdtm/stackleak.c:19:22: warning: incompatible pointer to integer conversion initializing 'const unsigned long' with an expression of type 'unsigned long (void)' [-Wint-conversion]
           const unsigned long current_sp = current_stack_pointer;
                               ^            ~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/lkdtm/stackleak.c:20:43: error: no member named 'lowest_stack' in 'struct task_struct'; did you mean 'ret_stack'?
           const unsigned long lowest_sp = current->lowest_stack;
                                                    ^~~~~~~~~~~~
                                                    ret_stack
   include/linux/sched.h:1365:28: note: 'ret_stack' declared here
           struct ftrace_ret_stack         *ret_stack;
                                            ^
   drivers/misc/lkdtm/stackleak.c:20:22: warning: incompatible pointer to integer conversion initializing 'const unsigned long' with an expression of type 'struct ftrace_ret_stack *' [-Wint-conversion]
           const unsigned long lowest_sp = current->lowest_stack;
                               ^           ~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/lkdtm/stackleak.c:42:16: error: call to undeclared function 'stackleak_find_top_of_poison'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);
                         ^
   2 warnings and 4 errors generated.


vim +/stackleak_task_low_bound +17 drivers/misc/lkdtm/stackleak.c

    13	
    14	void lkdtm_STACKLEAK_ERASING(void)
    15	{
    16		const unsigned long task_stack_base = (unsigned long)task_stack_page(current);
  > 17		const unsigned long task_stack_low = stackleak_task_low_bound(current);
  > 18		const unsigned long task_stack_high = stackleak_task_high_bound(current);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
