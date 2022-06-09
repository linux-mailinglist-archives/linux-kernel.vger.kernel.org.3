Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94422544E60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbiFIOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbiFIOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:08:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD357107
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654783731; x=1686319731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RZ9GC9G4NzHs8ag0KtTu585ebRykJCiuVVNCZInBXc0=;
  b=PoKOeJ80CLaxPvwnco0U/qLptuJB+P2aNvn5EU0IWEH7Q7eXUpHINjdG
   2dUPeAx2ccAOCz6dmxg9ZFT+OfeV6QARUETpWGEGCQn7uK3aJOIY+OcHD
   PZu0W/BZXTHoaD7bKQ4jguzPwmFQKT9psSDm8SG7ACSO67iLo1YBsj5KM
   z/Ge9SReouB6WOXsZZmHsgKEfFrVCCqUgGJtqzD/UKK4VcWJlUV14VOEj
   olCe7wNtzMGBZA1itUiKSKtETUk8CpXoqgXe+6++usTi1lhrc7zan7//0
   CWBxVIwP0kG6pH7lMSMgJbvMpBoepiQeCLYcylJTMHISIFFbZWYGZRnjx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="274816114"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="274816114"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 07:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="671331825"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2022 07:08:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzIpv-000G3F-0b;
        Thu, 09 Jun 2022 14:08:35 +0000
Date:   Thu, 9 Jun 2022 22:07:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/clk 48/48] drivers/opp/core.c:430:6: warning: no
 previous prototype for function '_invalid_freq_op'
Message-ID: <202206092215.7H70yWMv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/clk
head:   3c6c953fd159e8e0a31b2b0ba71f6e783a183b81
commit: 3c6c953fd159e8e0a31b2b0ba71f6e783a183b81 [48/48] OPP: Allow multiple clocks for a device
config: arm64-randconfig-r012-20220609 (https://download.01.org/0day-ci/archive/20220609/202206092215.7H70yWMv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=3c6c953fd159e8e0a31b2b0ba71f6e783a183b81
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/clk
        git checkout 3c6c953fd159e8e0a31b2b0ba71f6e783a183b81
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/opp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/opp/core.c:430:6: warning: no previous prototype for function '_invalid_freq_op' [-Wmissing-prototypes]
   bool _invalid_freq_op(struct opp_table *opp_table)
        ^
   drivers/opp/core.c:430:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool _invalid_freq_op(struct opp_table *opp_table)
   ^
   static 
   drivers/opp/core.c:1635:43: warning: variable 'clk_size' set but not used [-Wunused-but-set-variable]
           int supply_count, supply_size, icc_size, clk_size;
                                                    ^
   2 warnings generated.


vim +/_invalid_freq_op +430 drivers/opp/core.c

   428	
   429	/* Helpers for invalid operations */
 > 430	bool _invalid_freq_op(struct opp_table *opp_table)
   431	{
   432		return WARN_ON(opp_table->clk_count != 1);
   433	}
   434	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
