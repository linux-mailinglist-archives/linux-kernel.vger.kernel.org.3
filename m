Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F34C3568
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiBXTLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBXTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:11:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB7F20DB1F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645729833; x=1677265833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OFXhX5BHPoiyCzftDXmBe7qGYMY+MXINhMiZIOvCd2k=;
  b=KaTh5GIJK4VW+kWcmi7AoE8kaWZa+44vBFU9WTekenlTT8+t/POWdHpi
   zKlBt0WxPaJjvY7syOwHqAhGYZtMxNWNda178SAugu5654XN0frxvKCGs
   9F8fPInZfoOkIGxfSpx8TF1ODa4Lii7HJS7Yxajpisc3nVrN+PrPL/Kmo
   YufOLoxtVYGbacW9QorO5WchzcrUQzxBYfNWMJbIk5OPIsRdzlkP1LKbA
   vLCY2mxJ3bqiYlw7rdVsSschXaJ7kxql7LL6D5GCBO9M8vmIqmTTV5Mh4
   /UCxS9bppgs1Q18JLePb7oCmjaR7TP4iaQHtF/+/lGl1miXCUT8OJMILq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251155234"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251155234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="684388990"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 11:10:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNJVX-0003Ob-ME; Thu, 24 Feb 2022 19:10:31 +0000
Date:   Fri, 25 Feb 2022 03:09:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [csky-linux:riscv_compat_v6 17/20] arch/riscv/kernel/vdso.c:221:15:
 error: use of undeclared identifier 'compat_vdso_info'
Message-ID: <202202250133.pL6WVC3v-lkp@intel.com>
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
config: riscv-buildonly-randconfig-r003-20220223 (https://download.01.org/0day-ci/archive/20220225/202202250133.pL6WVC3v-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/77ed3d205a86f67815d8d074ff26e73ac1905772
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6
        git checkout 77ed3d205a86f67815d8d074ff26e73ac1905772
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/vdso.c:221:15: error: use of undeclared identifier 'compat_vdso_info'
           __vdso_init(&compat_vdso_info);
                        ^
   1 error generated.


vim +/compat_vdso_info +221 arch/riscv/kernel/vdso.c

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
