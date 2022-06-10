Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1F5466C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiFJMqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFJMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:46:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676618E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654865200; x=1686401200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2fPRffznqP3QJikn1bGV+biqojxGyPlNiUoj0REL35Q=;
  b=YcNbvXQBZmCA4aV6zuiHYOkTqxPHP0jzVvifaDSg7lPJH6IaqI8Hs2R7
   ztavY5TXAT9sYOvj7s5YglVp0zsmgh5SG0F7BvEpkw+p0CHhuQEHaGIjL
   ftTn3adq9Uz65zoxvziYl6hz8MGcJApLVpLrV/+EX7JNa5Hpxh+MBtCsA
   pxhxAnTazVxhw9TRVzXYEWNBrlzpOEpPjo8nW738yrsUAgC1k9RQlYDex
   j+KdrWqtHQlEv/P2calnWzTtDZcJMrKsAXECL2zrry34aCR6KsfTA51t8
   wqDWMyIsj91hTNwET3xCVvQh5tNtgT7mGoxgLHAeWXvtLvlRTV9uZzkMB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257452818"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="257452818"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="671831932"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2022 05:46:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nze2A-000Hwf-U6;
        Fri, 10 Jun 2022 12:46:38 +0000
Date:   Fri, 10 Jun 2022 20:46:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/linux-next 51/52] drivers/opp/core.c:97:6: warning:
 no previous prototype for function 'assert_single_clk'
Message-ID: <202206102000.LY9iR2Ek-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
head:   76c4db9b37866c60306d39ed982cba56af15ff00
commit: a62471a6205813e478c21edb405d62285ea6be6e [51/52] OPP: Assert clk_count == 1 for single clk helpers
config: arm64-randconfig-r025-20220610 (https://download.01.org/0day-ci/archive/20220610/202206102000.LY9iR2Ek-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 70d35fe1257e429266b83025997b400e9f79110e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=a62471a6205813e478c21edb405d62285ea6be6e
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/linux-next
        git checkout a62471a6205813e478c21edb405d62285ea6be6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/opp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/opp/core.c:97:6: warning: no previous prototype for function 'assert_single_clk' [-Wmissing-prototypes]
   bool assert_single_clk(struct opp_table *opp_table)
        ^
   drivers/opp/core.c:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool assert_single_clk(struct opp_table *opp_table)
   ^
   static 
   drivers/opp/core.c:1634:43: warning: variable 'clk_size' set but not used [-Wunused-but-set-variable]
           int supply_count, supply_size, icc_size, clk_size;
                                                    ^
   2 warnings generated.


vim +/assert_single_clk +97 drivers/opp/core.c

    95	
    96	/* Returns true for single clock, false with WARN otherwise */
  > 97	bool assert_single_clk(struct opp_table *opp_table)
    98	{
    99		return !WARN_ON(opp_table->clk_count != 1);
   100	}
   101	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
