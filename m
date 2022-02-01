Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657E34A5AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiBAKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:53:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:21862 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbiBAKxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643712819; x=1675248819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Rc2R13X+A0ZPea4Zk2j4TFu+lNn7nqVaeohaqOLnM8=;
  b=gK4U29KBWCceNK8FP32sd1c4l7dwiCu2xk/GHeJhPNE/82Z2sXfawhfi
   FqdA7LjhcDjH8ESB0eR2jj0drubVFvi7v0tjZYOq8FtzgUtrhA7sV+baH
   mSDSeSDo3kcIMKckS4rz2zqAmGqwfQsMwc1Sv/O2yBWFFopWZSKhUm49A
   j6/c94R3SdkBURRx5H0wCHNwaVZ7W0oCAXJyL8h6xhWZMEE3wKkmTpyYZ
   0vZSt1F3QKkC9bmrnPOwd6biX9YyMIjkrZkCHCxv1WCYsIpstL9UHjVol
   PLKDALceUAsjJxOfmXka0xrn2HdswDDvnA9FjB932b/G+13bWcOfI0jQ7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247436326"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247436326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:53:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="768894443"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2022 02:53:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEqmx-000TAB-Gz; Tue, 01 Feb 2022 10:53:31 +0000
Date:   Tue, 1 Feb 2022 18:52:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        David Dai <daidavid1@codeaurora.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        Shefali Jain <shefjain@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 61/9999] drivers/clk/clk.c:3145:5: warning: no previous prototype for
 function 'clk_set_flags'
Message-ID: <202202011809.jx2dKFgs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   b45c5eeda8dea785e3d411380b486a209768f6b2
commit: 3179a1a38d96f565a2229b9244285c6abf62b10a [61/9999] ANDROID: GKI: clk: Add support for voltage voting
config: x86_64-randconfig-r026-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011809.jx2dKFgs-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3179a1a38d96f565a2229b9244285c6abf62b10a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 3179a1a38d96f565a2229b9244285c6abf62b10a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clk/ drivers/nvmem/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/clk.c:624:24: warning: variable 'ignore' set but not used [-Wunused-but-set-variable]
           int level, rc = 0, i, ignore;
                                 ^
>> drivers/clk/clk.c:3145:5: warning: no previous prototype for function 'clk_set_flags' [-Wmissing-prototypes]
   int clk_set_flags(struct clk *clk, unsigned long flags)
       ^
   drivers/clk/clk.c:3145:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int clk_set_flags(struct clk *clk, unsigned long flags)
   ^
   static 
>> drivers/clk/clk.c:3157:6: warning: no previous prototype for function 'clk_debug_print_hw' [-Wmissing-prototypes]
   void clk_debug_print_hw(struct clk_core *clk, struct seq_file *f)
        ^
   drivers/clk/clk.c:3157:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void clk_debug_print_hw(struct clk_core *clk, struct seq_file *f)
   ^
   static 
   3 warnings generated.
   drivers/clk/clk.c:4257: warning: Function parameter or member 'dev' not described in 'devm_clk_unregister'
   drivers/clk/clk.c:4455: warning: Function parameter or member 'get_hw' not described in 'of_clk_provider'


vim +/clk_set_flags +3145 drivers/clk/clk.c

  3144	
> 3145	int clk_set_flags(struct clk *clk, unsigned long flags)
  3146	{
  3147		if (!clk)
  3148			return 0;
  3149	
  3150		if (!clk->core->ops->set_flags)
  3151			return -EINVAL;
  3152	
  3153		return clk->core->ops->set_flags(clk->core->hw, flags);
  3154	}
  3155	EXPORT_SYMBOL_GPL(clk_set_flags);
  3156	
> 3157	void clk_debug_print_hw(struct clk_core *clk, struct seq_file *f)
  3158	{
  3159	}
  3160	EXPORT_SYMBOL(clk_debug_print_hw);
  3161	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
