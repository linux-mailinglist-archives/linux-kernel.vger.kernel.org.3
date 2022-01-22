Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B05496AA2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiAVHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:31:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:17637 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbiAVHb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642836687; x=1674372687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aDISvBZXMUfO0SORADaUXKCHNtIiOsJ9nERw1/1sykQ=;
  b=aC9jW2oxm8kXl2ZFMzg1Bs1IE3JlEeW2Q5+cMq+X2A3es8UqU7smiYSa
   3+KZVW+JMEbYMgr639iiRMrOd9qERCtKTQQGHfy6tEahLqssI14xOAq/v
   GGgRkJNDv4KDgCzre3u0s7V7fQG6SA+uMI8VijQbYhO+6aGxJwEiVexWF
   xCPiXT9NveqPCpWlf1thjNaJd6Lx9KCdWs18sdfafAJlsjALfY3SAtq9j
   c6XNSRdHCpvK0oG2c0yxgX5G6rHpww24j5rJSQqDOwCm1zy/ASNt+1H2N
   DrQcv0df3wfKXRczZjGUeVtoPLAjQatUKo/px6Fi0z7R0AeChng8gbrc7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244622083"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="244622083"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 23:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="562137549"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2022 23:31:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBArs-000GAQ-M3; Sat, 22 Jan 2022 07:31:24 +0000
Date:   Sat, 22 Jan 2022 15:31:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [intel-tdx:kvm-upstream 24/135] arch/x86/kernel/cpu/tsx.c:186:5:
 warning: no previous prototype for function 'tsx_ctrl_clear'
Message-ID: <202201221535.WyckJlw0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   cf0e0f3ada8796602d986a2b3b5c91bb2d6126e3
commit: b4ba4adc54d3790157953208dc4deecc7d24005c [24/135] x86/cpu/tsx: Add helper functions to save/restore IA32_TSX_CTRL MSR
config: i386-randconfig-a001-20220117 (https://download.01.org/0day-ci/archive/20220122/202201221535.WyckJlw0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/b4ba4adc54d3790157953208dc4deecc7d24005c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout b4ba4adc54d3790157953208dc4deecc7d24005c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/tsx.c:186:5: warning: no previous prototype for function 'tsx_ctrl_clear' [-Wmissing-prototypes]
   u64 tsx_ctrl_clear(void)
       ^
   arch/x86/kernel/cpu/tsx.c:186:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 tsx_ctrl_clear(void)
   ^
   static 
>> arch/x86/kernel/cpu/tsx.c:199:6: warning: no previous prototype for function 'tsx_ctrl_restore' [-Wmissing-prototypes]
   void tsx_ctrl_restore(u64 tsx_ctrl)
        ^
   arch/x86/kernel/cpu/tsx.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tsx_ctrl_restore(u64 tsx_ctrl)
   ^
   static 
   2 warnings generated.


vim +/tsx_ctrl_clear +186 arch/x86/kernel/cpu/tsx.c

   184	
   185	/* Clear the MSR_TSX_CTRL and return the old value if supported */
 > 186	u64 tsx_ctrl_clear(void)
   187	{
   188		u64 tsx_ctrl = 0;
   189	
   190		if (ia32_tsx_ctrl_supported) {
   191			rdmsrl(MSR_IA32_TSX_CTRL, tsx_ctrl);
   192			if (tsx_ctrl & MSR_TSX_CTRL_MASK)
   193				wrmsrl(MSR_IA32_TSX_CTRL, tsx_ctrl & ~MSR_TSX_CTRL_MASK);
   194		}
   195		return tsx_ctrl;
   196	}
   197	EXPORT_SYMBOL_GPL(tsx_ctrl_clear);
   198	
 > 199	void tsx_ctrl_restore(u64 tsx_ctrl)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
