Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A824FC6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiDKVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350224AbiDKVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:48:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A51A3B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649713558; x=1681249558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jH/xwVkzJjWE9BpFJGOWfNIJMfg8Pt1j2t/mFRNvmWQ=;
  b=KftRdnT9Tx6si+IbA5i9fX9HMF5ErnEvw/b4ANgaqYhjr2suigUhQW5x
   dtABov9Dz1e3SgAieZ96OWyk/779+cGvDR6YJcC2ZezEgj+TpISx+U/3R
   DKd1cpZVYKoV3fQtswe2/yUBYSylCahOm8vR2S8XL7SR1QTZ24Z15XwLu
   tRQTByojWYwMRvedGDETW4yXFdbXoW5JSY2bGO6YAi3T5L6UMXSLj/wGB
   sjzvcj4XTXXi19GFPmWN267Gs7pFueDcdr+Kr8vQjfPlYZ4x9h3RaEdEC
   sVD7bT7hn/pn3VhjFsa2aKhzuWmqcorS4sbS04FdDsTaFiL9t2x8Xq+Hh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348660387"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="348660387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 14:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="699552975"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2022 14:45:55 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne1r9-0002EP-8o;
        Mon, 11 Apr 2022 21:45:55 +0000
Date:   Tue, 12 Apr 2022 05:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 4/4] ARM: at91: pm: use kernel documentation style
Message-ID: <202204120552.PLev1dS4-lkp@intel.com>
References: <20220411112057.35369-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411112057.35369-5-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu-Beznea/ARM-at91-pm-add-quirks-for-ethernet/20220411-191956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-sama7_defconfig (https://download.01.org/0day-ci/archive/20220412/202204120552.PLev1dS4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/0d5dd0bc2c021263d5e0c3b27fb073830ef4aa54
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Claudiu-Beznea/ARM-at91-pm-add-quirks-for-ethernet/20220411-191956
        git checkout 0d5dd0bc2c021263d5e0c3b27fb073830ef4aa54
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-at91/pm.c:62: warning: expecting prototype for struct at91_pm_sfrbu_offsets. Prototype was for struct at91_pm_sfrbu_regs instead


vim +62 arch/arm/mach-at91/pm.c

f19dd1df9e71da Claudiu Beznea 2021-04-15  50  
0d5dd0bc2c0212 Claudiu Beznea 2022-04-11  51  /**
0d5dd0bc2c0212 Claudiu Beznea 2022-04-11  52   * struct at91_pm_sfrbu_offsets - registers mapping for SFRBU
ac809e7879b156 Claudiu Beznea 2021-08-30  53   * @pswbu: power switch BU control registers
ac809e7879b156 Claudiu Beznea 2021-08-30  54   */
ac809e7879b156 Claudiu Beznea 2021-08-30  55  struct at91_pm_sfrbu_regs {
ac809e7879b156 Claudiu Beznea 2021-08-30  56  	struct {
ac809e7879b156 Claudiu Beznea 2021-08-30  57  		u32 key;
ac809e7879b156 Claudiu Beznea 2021-08-30  58  		u32 ctrl;
ac809e7879b156 Claudiu Beznea 2021-08-30  59  		u32 state;
ac809e7879b156 Claudiu Beznea 2021-08-30  60  		u32 softsw;
ac809e7879b156 Claudiu Beznea 2021-08-30  61  	} pswbu;
ac809e7879b156 Claudiu Beznea 2021-08-30 @62  };
ac809e7879b156 Claudiu Beznea 2021-08-30  63  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
