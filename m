Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279A4B150C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiBJSOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:14:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiBJSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:14:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A02391
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644516845; x=1676052845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cjWNlMS7wsBHr1pOlccUMjg3bQrDdW47IbfyLA88hpY=;
  b=OxrAIhutNUp3biQtQHekxN9T/MOb6uwZ9bxBTOg/pTs1t3WLJx/LjlGT
   Q/GV3CsV7P8vA9wP6nIAxltIi8m0B4OxUxCpvu5iovZowYoEINjM2CNaR
   K/AG1xgk3fFGnOpGeXpNUUN7QLb+YUKpYOeJzZwnXPSgK53aOg2SLvMCQ
   rvSe1l4Of8OiIldAQ9E6oRwlgSvPSNSae8yA4bYlynk2NbWfCsAHUrC9D
   0TGyfvTWZM5TOL48sJfyh1HlYetNpDAcEx0p5YUD+5jcFuJghptI3H5qm
   prmnhfIuTz9+fH95aEax/szs+KoypM/w1BcOdI4Ff3gIIXdJBKa3DGD7t
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="236958974"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="236958974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="586040968"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2022 10:14:02 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIDxC-0003Zn-7o; Thu, 10 Feb 2022 18:14:02 +0000
Date:   Fri, 11 Feb 2022 02:13:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:riscv_compat_v6_svpbmt-v6 10/35]
 arch/riscv/kernel/cpufeature.c:185:6: warning: variable 'cpu_apply_feature'
 set but not used
Message-ID: <202202110204.3m29JCRv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_svpbmt-v6
head:   54acb36c958fc990cc59889f79c8ddca7386c295
commit: 9a8cf89570e893738c501551591b03bd868c825c [10/35] riscv: add cpufeature handling via alternatives
config: riscv-randconfig-r042-20220208 (https://download.01.org/0day-ci/archive/20220211/202202110204.3m29JCRv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project aa845d7a245d85c441d0bd44fc7b6c3be8f3de8d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/9a8cf89570e893738c501551591b03bd868c825c
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_svpbmt-v6
        git checkout 9a8cf89570e893738c501551591b03bd868c825c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/mm/ drivers/base/firmware_loader/ drivers/pci/ drivers/target/ fs/erofs/ fs/pstore/ kernel/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpufeature.c:185:6: warning: variable 'cpu_apply_feature' set but not used [-Wunused-but-set-variable]
           u32 cpu_apply_feature = 0;
               ^
   1 warning generated.


vim +/cpu_apply_feature +185 arch/riscv/kernel/cpufeature.c

   180	
   181	void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
   182					 unsigned int stage)
   183	{
   184		u32 cpu_req_feature = cpufeature_probe(stage);
 > 185		u32 cpu_apply_feature = 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
