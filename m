Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25E53919A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiEaNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiEaNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:14:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C9D91595
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654002855; x=1685538855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R6vRQO4G/trEQEVdtkATTxro2c90VkitZkvcda9bzQ4=;
  b=jt725hFbPj4q9AW1MqioJT+tHAVC4ktfcOWu8goYKy+JV/p0oohu28Hy
   6fVk7i5TdKG7pbhybI0XYvOSNbZCgoeAIvE/v6vrz2taXabTtf2kPLHWw
   IMF2OXqMW6f6dt0Zh3JzoMGzSgLXbB/4bfg1ZP1boFlfGqRGxMmqyMl7I
   BmsbaBXyZaz//7f8BG+DFqsMVh/ydhehPCxdRDq2WYp9jfmQSmoUhEsj4
   IkUGXMGq76c83ZUUIrQA+XYgFWZY84pxXKO8F2W+T/sM2jzrt6wt2BsA8
   wogBay8SbCvZqN13Mv6HmYO/hisV2kP/AQSW51VpV/FIn71yWHyBF2wHO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="338291788"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="338291788"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 06:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="823268574"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2022 06:14:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw1hM-0002k6-LG;
        Tue, 31 May 2022 13:14:12 +0000
Date:   Tue, 31 May 2022 21:13:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>, gerg@linux-m68k.org
Cc:     kbuild-all@lists.01.org, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH] m68k: coldfire:Add const to clk_ops
Message-ID: <202205312132.iaViCBtV-lkp@intel.com>
References: <20220530025312.55057-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530025312.55057-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on gerg-m68knommu/for-next]
[also build test ERROR on geert-m68k/for-next v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiang-wangx/m68k-coldfire-Add-const-to-clk_ops/20220530-105531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20220531/202205312132.iaViCBtV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e44f3b73f214f99802c9a010145922eb0a126933
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiang-wangx/m68k-coldfire-Add-const-to-clk_ops/20220530-105531
        git checkout e44f3b73f214f99802c9a010145922eb0a126933
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/coldfire/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/m68k/coldfire/clk.c:53:8: error: expected '{' before 'const'
      53 | struct const clk_ops clk_ops0 = {
         |        ^~~~~
   arch/m68k/coldfire/clk.c:48:13: warning: '__clk_disable0' defined but not used [-Wunused-function]
      48 | static void __clk_disable0(struct clk *clk)
         |             ^~~~~~~~~~~~~~
   arch/m68k/coldfire/clk.c:43:13: warning: '__clk_enable0' defined but not used [-Wunused-function]
      43 | static void __clk_enable0(struct clk *clk)
         |             ^~~~~~~~~~~~~


vim +53 arch/m68k/coldfire/clk.c

    52	
  > 53	struct const clk_ops clk_ops0 = {
    54		.enable		= __clk_enable0,
    55		.disable	= __clk_disable0,
    56	};
    57	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
