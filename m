Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907DB4C30EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiBXQEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiBXQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:03:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B517777E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718590; x=1677254590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CikHhdwgHdtPqnudt43yAg36czZOtO0MpmU+eZcVf1M=;
  b=e3hOpVpJpXFZBNq5PJiVTQlzUPjE01WHxDV4CkJTdrfRcegSBW74MVAV
   nZxPgDjCuCF82LQrV5FYIJawiPZrCzIVl4qlJf1eTLSuFfTAJlB9UJ9ZD
   xQ7QEPIlZFHEZJEE9qVbs5Kym/YprwJTXBnX0BVxnQGoRJDuMHiMW0I1g
   OXWBQeq+DuAdvk32ecDymPhKOu0C5vxiHxly+L4F82bnaztCSlx1lTuHB
   rIx/IyOR5FIyvTszUD/VsyQtZA9UfQy/N3zfEgjaghmasZrX9co3V8jFI
   7xSwZWheeNbZZiMRoWLh4VNCDKFGAsyBq9e64ZFYHDLBTCW+cXNfIv/hE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252188669"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252188669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="508917107"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2022 08:02:28 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNGZW-0003HH-MJ; Thu, 24 Feb 2022 16:02:26 +0000
Date:   Fri, 25 Feb 2022 00:01:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [csky-linux:riscv_compat_v6 17/20] arch/riscv/kernel/vdso.c:221:22:
 error: 'compat_vdso_info' undeclared; did you mean 'compat_sysinfo'?
Message-ID: <202202242326.94v18Tal-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6
head:   4aafa1859382d5a159bdafe2956453feafd38845
commit: 77ed3d205a86f67815d8d074ff26e73ac1905772 [17/20] riscv: compat: vdso: Add setup additional pages implementation
config: riscv-buildonly-randconfig-r006-20220224 (https://download.01.org/0day-ci/archive/20220224/202202242326.94v18Tal-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/77ed3d205a86f67815d8d074ff26e73ac1905772
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6
        git checkout 77ed3d205a86f67815d8d074ff26e73ac1905772
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/vdso.c: In function 'vdso_init':
>> arch/riscv/kernel/vdso.c:221:22: error: 'compat_vdso_info' undeclared (first use in this function); did you mean 'compat_sysinfo'?
     221 |         __vdso_init(&compat_vdso_info);
         |                      ^~~~~~~~~~~~~~~~
         |                      compat_sysinfo
   arch/riscv/kernel/vdso.c:221:22: note: each undeclared identifier is reported only once for each function it appears in


vim +221 arch/riscv/kernel/vdso.c

   217	
   218	static int __init vdso_init(void)
   219	{
   220		__vdso_init(&vdso_info);
 > 221		__vdso_init(&compat_vdso_info);
   222	
   223		return 0;
   224	}
   225	arch_initcall(vdso_init);
   226	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
