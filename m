Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47B049C208
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiAZDYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:24:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:22002 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbiAZDYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643167473; x=1674703473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7GsL5XJhtGNW/LXU8XAp6ySgVoNVcmklsGFkoTfafyE=;
  b=QVTJrc6gCKvieQCCRzsUZrbYTaSnBEx/QAHIXhBeQb72/WanK/Bbt843
   r7TCUfBeytuR7N8WNhG0eZWwzhpcda6NddLdj4M7V1lyNoUUs22tCpV1z
   WVPl/gEmMir1p1KjfUOoy0+JYWs2BM3lFywpdh7wbtaEAXpDKx8lxFM5N
   UXwpW0Cc4Xp4HfArR03tSwha0wtOrJTwlTL5xtwkdjHDLYIyho80+8HXC
   A+IgdCzPu/LObqi20bd10psQiNwvV+/TaOXNsIr9rWhHSNfCm/NMp3CH2
   pKwaFd9Psr/N/ck6GGz/39F1HR9AUCCbFlCN50OnOf/1THtN9QbczX98Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227146779"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="227146779"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 19:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="617842798"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2022 19:24:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCYv9-000Kjl-4v; Wed, 26 Jan 2022 03:24:31 +0000
Date:   Wed, 26 Jan 2022 11:24:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 9/137]
 arch/x86/kernel/cpu/resctrl/core.c:400:6: warning: no previous prototype for
 function 'setup_default_ctrlval'
Message-ID: <202201261106.qSo1MG6L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 1763d5f108c2b9e4fd2e055884b8e290b75fa5f0 [9/137] x86/resctrl: Remove architecture copy of mbps_val
config: i386-randconfig-a011-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261106.qSo1MG6L-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=1763d5f108c2b9e4fd2e055884b8e290b75fa5f0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 1763d5f108c2b9e4fd2e055884b8e290b75fa5f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/core.c:400:6: warning: no previous prototype for function 'setup_default_ctrlval' [-Wmissing-prototypes]
   void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
        ^
   arch/x86/kernel/cpu/resctrl/core.c:400:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
   ^
   static 
   arch/x86/kernel/cpu/resctrl/core.c:414:6: warning: no previous prototype for function 'domain_free' [-Wmissing-prototypes]
   void domain_free(struct rdt_hw_domain *hw_dom)
        ^
   arch/x86/kernel/cpu/resctrl/core.c:414:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void domain_free(struct rdt_hw_domain *hw_dom)
   ^
   static 
   2 warnings generated.


vim +/setup_default_ctrlval +400 arch/x86/kernel/cpu/resctrl/core.c

   399	
 > 400	void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
   401	{
   402		struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
   403		int i;
   404	
   405		/*
   406		 * Initialize the Control MSRs to having no control.
   407		 * For Cache Allocation: Set all bits in cbm
   408		 * For Memory Allocation: Set b/w requested to 100%
   409		 */
   410		for (i = 0; i < hw_res->num_closid; i++, dc++)
   411			*dc = r->default_ctrl;
   412	}
   413	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
