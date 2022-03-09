Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41734D2D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiCIK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiCIK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:59:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B278180
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646823486; x=1678359486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SqqKqJwel56I/p78Nxema8iyKpDbYSQbjl0FOHA7r2I=;
  b=iQQbntChabz9SHjRq++0t5s/cgU2cvmcoohczCoH0Eq6w9w9YiW4cyb1
   zhWch3bRnPhSh8jsMj2LkNCvPf9lgk1p7m2XzlfWn3KMxsSRuRqtdqt7g
   4FcfqoU011iE+unyrgH+zVon96FnJ+sDl8GHuGAT7ItOqsY8eENXIMoH3
   lq7v0IpzFhFY0NoOOTqILzvD7MCT/P4394QoQ9TXHPxJOEtB1ZtL0l8EG
   CFHlQHbfipYG/IOvzSaD65izoUkX8TylcmzWQXOkAdQjazywc6VHt7sZ7
   Cup7DLAuf7NQNlHhZamgDF5ZLntGbK3Al6/Y3k1Ie+QQF7V0v2gg589dz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254678201"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254678201"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 02:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="513486040"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 02:58:04 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRu16-00037j-3K; Wed, 09 Mar 2022 10:58:04 +0000
Date:   Wed, 9 Mar 2022 18:57:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [intel-tdx:kvm 24/193] arch/x86/kernel/cpu/tsx.c:186:5: warning: no
 previous prototype for function 'tsx_ctrl_clear'
Message-ID: <202203091813.vrTfwPUD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Isaku,

FYI, the error/warning still remains.

tree:   https://github.com/intel/tdx.git kvm
head:   7a7d51d52f45bbd82e264c7f940d74491305f5ce
commit: 2c9aac7eef8430d99ae51f243da09dd7892dc9cd [24/193] x86/cpu/tsx: Add helper functions to save/restore IA32_TSX_CTRL MSR
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220309/202203091813.vrTfwPUD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/2c9aac7eef8430d99ae51f243da09dd7892dc9cd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm
        git checkout 2c9aac7eef8430d99ae51f243da09dd7892dc9cd
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
