Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2334EC63C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbiC3ONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiC3ONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:13:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD45F55
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648649528; x=1680185528;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eLF+XXHUgT7NzuiiRHrlFPBMcUsMSvrfiAEVcwfcrFY=;
  b=Zb2iESUgdeRqVxCfs65CwD+DhsUBdvNs/d4K4tWq6PeT70xHcnZkfSgn
   JMb3+f47AiPBwuLr1cZJyvBJhfELiBpncsuXATRaIP5SapAC77JxNVqhb
   SocqI4XyM8KXghiEEE9POjg+Dsa7N7INNq9bzG2pvaXJNVLLe0cdSYInl
   KUniz7WpjMC0PsIbBQ9/jbyS9F94AeyrXFpBbk1/x9FT6BGFhLX/hAPYO
   huvRyTFd729CxDpYNHEX4T2PgR1qiRA+LZfhz3PSfQFxfyRseqkK95bMM
   WlHDDYGx79+fVyI4ITksmpFdqBGgiWwrOzo2ZclqcYqzBdVhGTaVZVQQ0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241706969"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="241706969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="719988992"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2022 07:12:06 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZZ3O-00003c-AA;
        Wed, 30 Mar 2022 14:12:06 +0000
Date:   Wed, 30 Mar 2022 22:11:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:arm64/linux/devel/kmalloc-minalign 10/11]
 arch/arm64/kernel/cacheinfo.c:101:14: warning: no previous prototype for
 function 'arch_kmalloc_minalign'
Message-ID: <202203302215.5KhCA08Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/devel/kmalloc-minalign
head:   2810d5be00a60d5996cd955c2485c17ef1e1e7af
commit: 6c3838f40cf6a9b31bbb3d78059a81ca03fb2cfc [10/11] arm64: Enable dynamic kmalloc() minimum alignment
config: arm64-randconfig-r005-20220330 (https://download.01.org/0day-ci/archive/20220330/202203302215.5KhCA08Y-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/6c3838f40cf6a9b31bbb3d78059a81ca03fb2cfc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/devel/kmalloc-minalign
        git checkout 6c3838f40cf6a9b31bbb3d78059a81ca03fb2cfc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/cacheinfo.c:101:14: warning: no previous prototype for function 'arch_kmalloc_minalign' [-Wmissing-prototypes]
   unsigned int arch_kmalloc_minalign(void)
                ^
   arch/arm64/kernel/cacheinfo.c:101:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int arch_kmalloc_minalign(void)
   ^
   static 
   1 warning generated.


vim +/arch_kmalloc_minalign +101 arch/arm64/kernel/cacheinfo.c

   100	
 > 101	unsigned int arch_kmalloc_minalign(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
