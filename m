Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F664E2378
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbiCUJlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbiCUJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:41:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C371044A3A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647855627; x=1679391627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=46zPOcGkyW6Eo2Ri3C8hctKEdvTtcpCrYAuST6cSXTo=;
  b=IeTObTt5CxUyUBtClt8troNYYNt4vTMWspvAO74vYdISoGcyhsS4Ksao
   p53niZzgLJ+g6y3zIXo4CRi5EvRq8nnx5UgVZuuhhJm3/XiN5uHle6p3G
   LtZEoUyG5RW/PcxgZxfsOKoqNM9MQ8IGlcekvrDMXXwusuwu6wbVzzvTj
   urGM+KM8MBrfSdEvmKaVNfEFXPqAMfP6lwBNqRSB8yYYUAf0fjx2XdJji
   9o7hmjTCu6++KEvrX+wIQTF+MxPF2VV6ifJdSvvf1rSohv9KRbsvsgp2O
   en2LpoglgYBMS2qFot4F7NP+mXfOvuCfNyqgVvS3Z7XAKtkvGyFYY11Y3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320714585"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="320714585"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="600429789"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2022 02:40:25 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWEWW-000HgW-ND; Mon, 21 Mar 2022 09:40:24 +0000
Date:   Mon, 21 Mar 2022 17:39:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-d1-merge 19/20]
 arch/riscv/errata/thead/errata.c:61:6: warning: variable 'cpu_apply_errata'
 set but not used
Message-ID: <202203211709.nW1Uc4Zs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-d1-merge
head:   93a6d3583d613a2ff1c6d28060c78af8631e0d21
commit: 5acf4c1828afd2b357b001c796fbbbaad5461ba4 [19/20] riscv: add memory-type errata for T-Head
config: riscv-randconfig-c006-20220321 (https://download.01.org/0day-ci/archive/20220321/202203211709.nW1Uc4Zs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/5acf4c1828afd2b357b001c796fbbbaad5461ba4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-d1-merge
        git checkout 5acf4c1828afd2b357b001c796fbbbaad5461ba4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/errata/thead/errata.c:61:6: warning: variable 'cpu_apply_errata' set but not used [-Wunused-but-set-variable]
           u32 cpu_apply_errata = 0;
               ^
   1 warning generated.


vim +/cpu_apply_errata +61 arch/riscv/errata/thead/errata.c

    54	
    55	void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
    56						      unsigned long archid, unsigned long impid,
    57						      unsigned int stage)
    58	{
    59		struct alt_entry *alt;
    60		u32 cpu_req_errata = thead_errata_probe(stage, archid, impid);
  > 61		u32 cpu_apply_errata = 0;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
