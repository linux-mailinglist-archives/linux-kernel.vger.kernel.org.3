Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557444F1E62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiDDWCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380382AbiDDTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:53:33 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE4559A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649101895; x=1680637895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/HVzOeZPMJuBHL5DEIwgDSINs2bBsLD/bwyEI+HlSzE=;
  b=ETb2hV2KrjUxGXEe9MaibqjF7ZFYjbuD56bPZPVBmwHemGczYhQz6stF
   s/LlFHdYtSHoeg+QYAQS2+i2Q6Z96R1Z3nTidE7qxWKZYgUBj0vZQyA8Q
   OrJIrrS9+msYdSvxUwIJrPTR0HAjtOTvLDSDZNCsI06F/rjCcEfFmzrpj
   MWOmFZgjPWJOLdT8Je3ruUNJ2P8uT6vorCiLfAszbfRuqfiSbHBWrfuA9
   LLPIyccgWpFkW9FDsIT2hwJIatVr9+WqsC5SkElC1FlfKT0fN+DZWv3+i
   pn2fr0c6B6Kg1VinZHc9xdFDf4CXAPgEP4KRqaaqbhdIPZkK/AFltNVVU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="321291117"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="321291117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 12:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="505019686"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2022 12:51:32 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbSjb-0002Jb-Qi;
        Mon, 04 Apr 2022 19:51:31 +0000
Date:   Tue, 5 Apr 2022 03:50:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: cc1: warning: result of '-117440512 << 16' requires 44 bits to
 represent, but 'int' only has 32 bits
Message-ID: <202204050337.o0LrtuSN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   3 weeks ago
config: mips-rb532_defconfig (https://download.01.org/0day-ci/archive/20220405/202204050337.o0LrtuSN-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> cc1: warning: result of '-117440512 << 16' requires 44 bits to represent, but 'int' only has 32 bits [-Wshift-overflow=]
   arch/mips/pci/pci-rc32434.c: In function 'rc32434_pcibridge_init':
   arch/mips/pci/pci-rc32434.c:111:22: warning: variable 'dummyread' set but not used [-Wunused-but-set-variable]
     111 |         unsigned int dummyread, pcicntlval;
         |                      ^~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
