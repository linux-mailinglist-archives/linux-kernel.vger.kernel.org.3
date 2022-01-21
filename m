Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F72496622
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiAUUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:02:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:46543 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbiAUUCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642795329; x=1674331329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tcaUOdQvwJzJ7+SHpCEZOvyeJ4DqQF/v5vadTiYlz1w=;
  b=n3jIDL15pmbUies2E+xOCjsnOQGTye7bXaU3dqEBZyv1fMMnuVAZ/v5+
   s4pNlUeWXnEBW9Hvtl3db3xxlDrRIVFg6WB+QjDCfeQa352+nypl0eMR5
   hOACL/0QpVgZSdxeazJESjowYyA0vRKhikF5GLfZ4uR69u0lDef29XuBt
   bdCCCTwAUvNvQ3Nz5LsBT4AkhLNvcB53QkS5w5O59utsBXZKXE8JjhUKB
   Rk2mgdr/5k0vC3izTPhV8t0Mz6ANh3J2RNX48CrXAtc7jJmLDF7MZcvWz
   OR1sVWdOgQbO03mK4r7bSOYRY1wt4wB+KQX3bhThUAl21yRDa/roMpTXx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="309060082"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="309060082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 12:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="478358015"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2022 12:02:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB06k-000Fcl-IS; Fri, 21 Jan 2022 20:02:02 +0000
Date:   Sat, 22 Jan 2022 04:01:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        David Dai <daidavid1@codeaurora.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        Shefali Jain <shefjain@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 64/9999] drivers/clk/clk.c:3145:5: warning: no previous prototype for
 'clk_set_flags'
Message-ID: <202201220318.8Dmp8LoU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: 3179a1a38d96f565a2229b9244285c6abf62b10a [64/9999] ANDROID: GKI: clk: Add support for voltage voting
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220122/202201220318.8Dmp8LoU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/3179a1a38d96f565a2229b9244285c6abf62b10a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 3179a1a38d96f565a2229b9244285c6abf62b10a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clk/ drivers/nvmem/ kernel/power/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/clk.c: In function 'clk_update_vdd':
   drivers/clk/clk.c:624:24: warning: variable 'ignore' set but not used [-Wunused-but-set-variable]
     624 |  int level, rc = 0, i, ignore;
         |                        ^~~~~~
   drivers/clk/clk.c: At top level:
>> drivers/clk/clk.c:3145:5: warning: no previous prototype for 'clk_set_flags' [-Wmissing-prototypes]
    3145 | int clk_set_flags(struct clk *clk, unsigned long flags)
         |     ^~~~~~~~~~~~~
>> drivers/clk/clk.c:3157:6: warning: no previous prototype for 'clk_debug_print_hw' [-Wmissing-prototypes]
    3157 | void clk_debug_print_hw(struct clk_core *clk, struct seq_file *f)
         |      ^~~~~~~~~~~~~~~~~~
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
