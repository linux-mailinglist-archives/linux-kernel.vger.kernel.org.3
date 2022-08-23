Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0880759D109
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiHWGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiHWGKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:10:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752158B56
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661235014; x=1692771014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NoZ36EAx5ccntdaDWrxrTT7Iigt1WKbWdoZsQR0GDG8=;
  b=Ciz+dbk4ZXGySffWzqtxKbpi1HfMD6iGlFc+0hF0Nn7DaITgkMnVfVA9
   IAJgjbNV0r5qXJR8RCuYrVQHQh3aO/gZqmEe48PWC+gTX+afIxtGfOgLo
   lBJdMhtlqmKo3PUVaAERZBoaF6koCf9/5rDXRJN3DYtFGvDbppi8QyW11
   3FvpLLBew/rkcLgWr1wtMljuMDbxEY5SIU5f4UYm4BLLlMxS8WKfMKZNj
   aaJ7U4uRuairGGSBwuZaFTkiEup4xMsX0eW6dmyvawvlbRApPVOrBlmCI
   6Mj1OTpGsNAMbb9Lq+4V9MWNJpJtZH3ndH50bAGM8qAnShZZ9BbJUOk6t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293600220"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="293600220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="560037010"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 23:10:12 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQN75-00005P-2n;
        Tue, 23 Aug 2022 06:10:11 +0000
Date:   Tue, 23 Aug 2022 14:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 8/12]
 arch/arm64/include/asm/alternative-macros.h:224:2: error: call to undeclared
 function 'BUILD_BUG_ON'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202208231413.qMjHMepE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   c6f1e900bb0e1c5932f9995feaf4acb70cf6f62e
commit: 1696b807a602e836898825b7fff3691438b90f39 [8/12] arm64: alternative: add alternative_has_feature_*()
config: arm64-randconfig-r026-20220821 (https://download.01.org/0day-ci/archive/20220823/202208231413.qMjHMepE-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project b04d01c009d7f66bcca9138d2ce40999eedf104d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=1696b807a602e836898825b7fff3691438b90f39
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout 1696b807a602e836898825b7fff3691438b90f39
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:10:
   In file included from include/linux/page-flags.h:10:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm64/include/asm/bug.h:26:
   In file included from include/asm-generic/bug.h:5:
   In file included from include/linux/compiler.h:248:
   In file included from arch/arm64/include/asm/rwonce.h:11:
>> arch/arm64/include/asm/alternative-macros.h:224:2: error: call to undeclared function 'BUILD_BUG_ON'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           BUILD_BUG_ON(feature >= ARM64_NCAPS);
           ^
   arch/arm64/include/asm/alternative-macros.h:241:2: error: call to undeclared function 'BUILD_BUG_ON'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           BUILD_BUG_ON(feature >= ARM64_NCAPS);
           ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1205: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/BUILD_BUG_ON +224 arch/arm64/include/asm/alternative-macros.h

   220	
   221	static __always_inline bool
   222	alternative_has_feature_likely(unsigned long feature)
   223	{
 > 224		BUILD_BUG_ON(feature >= ARM64_NCAPS);
   225	
   226		asm_volatile_goto(
   227		ALTERNATIVE("b	%l[l_no]", "nop", %[feature])
   228		:
   229		: [feature] "i" (feature)
   230		:
   231		: l_no);
   232	
   233		return true;
   234	l_no:
   235		return false;
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
