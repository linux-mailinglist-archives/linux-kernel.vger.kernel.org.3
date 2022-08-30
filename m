Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903A5A7165
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiH3XLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3XLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:11:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC8469F53
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661901098; x=1693437098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ffrZBgQF7S1zzrjei1u08INkL/XLWtnrWSoX3H2iz20=;
  b=euUrtzlFKHQZu1w/HReE4bfo/DWz768vfZdh/wuNA9y0OyyS0DDrc+og
   CkAQ+u9MVol0r/77b8jhZ1YAG2BYpdQcRf6T4sENNKY/8HOzy9DsfP7WE
   polhgWnPdQBhwo9vkwfLsrq/5yoDq+Oi3GAzV929nDNaRWtPxucauPKq8
   tjBvdhFibgVFK9OGW5MGQXRd3FaRDy+lK+4eAnhzO69aNcsrax+UMwKa+
   iHNdFVk9kqBCkTATGRlmTODzC/gNk1RhIFIsYONZBnYlcVBOTClD6/diS
   nm+IkFpi4XgdyNxio1E1pGFeg68qDPuPL0Bd+LE4kT+wNk40NWZmO+owk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275728816"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275728816"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 16:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="940228965"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2022 16:11:36 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTAON-0000iw-3C;
        Tue, 30 Aug 2022 23:11:35 +0000
Date:   Wed, 31 Aug 2022 07:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/powerpc/math-emu/math_efp.c:927:1: error: type specifier
 missing, defaults to 'int'; ISO C99 and later do not support implicit int
Message-ID: <202208310702.3iydJVg0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   6 months ago
config: powerpc-tqm8560_defconfig (https://download.01.org/0day-ci/archive/20220831/202208310702.3iydJVg0-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/math-emu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/math-emu/math_efp.c:927:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   module_init(spe_mathemu_init);
   ^
   int
   arch/powerpc/math-emu/math_efp.c:927:13: error: a parameter list without types is only allowed in a function definition
   module_init(spe_mathemu_init);
               ^
   2 errors generated.


vim +/int +927 arch/powerpc/math-emu/math_efp.c

ac6f120369ffe6 Liu Yu 2011-01-25  926  
ac6f120369ffe6 Liu Yu 2011-01-25 @927  module_init(spe_mathemu_init);

:::::: The code at line 927 was first introduced by commit
:::::: ac6f120369ffe66058518fabf90cdd53b2503a82 powerpc/85xx: Workaroudn e500 CPU erratum A005

:::::: TO: Liu Yu <yu.liu@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
