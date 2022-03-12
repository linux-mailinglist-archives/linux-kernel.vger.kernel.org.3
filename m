Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF44D6C31
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiCLDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLDLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:11:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B45281474
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647054612; x=1678590612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JvgF/c68/WSEKmQ5X7h4AZh4hTU1wmY0RrK/K+Z/EhM=;
  b=hhFcP9I+2CdJe1t4rDyzRqXqrsOoepJHpUhKwAxeq8B9UNDt6ptQSdqi
   dTd5WOlePHaFTTEqktI5BZsKT80ttpoghjfXulds4O8oX5ClUk9A/JNsE
   xXHkGRjr99/3akXjoDkYmaM0kBtI+tKCZYrLItb7wNsgon/UDjP+1hKm6
   GDYILJX0z4LGQnXecwvdmMCHHUirw0T3Gr0rUdsyjcoXYJheUhppscPbm
   5oZ07hYhh/ionxtv+F+FjHqagahVooJl4MzN27tGdbuLXEy5XGgRCJToG
   0Nifemnr1ZLJ/GO6YG+P0+TcLSg37j1P2QcliQOfuSSa9QOQLW6kK61+O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255915370"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255915370"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 19:10:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="713085989"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 19:10:10 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSs8v-0007S7-Mc; Sat, 12 Mar 2022 03:10:09 +0000
Date:   Sat, 12 Mar 2022 11:09:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:asahi 37/158] drivers/clk/clk-apple-nco.c:139:16: error:
 implicit declaration of function 'FIELD_PREP'
Message-ID: <202203121139.Zs11G62M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   a90a4472ece3167409168aab7c5010fe0eba8bb9
commit: 5e7b59cb6fe99a81dcedffcf5be74e9267b4d969 [37/158] clk: clk-apple-nco: Add driver for Apple NCO
config: h8300-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203121139.Zs11G62M-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/5e7b59cb6fe99a81dcedffcf5be74e9267b4d969
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 5e7b59cb6fe99a81dcedffcf5be74e9267b4d969
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate':
>> drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     139 |         return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
         |                ^~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate_inv':
>> drivers/clk/clk-apple-nco.c:147:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     147 |         coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
         |                           ^~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +/FIELD_PREP +139 drivers/clk/clk-apple-nco.c

   131	
   132	static u32 applnco_div_translate(struct applnco_tables *tbl, unsigned int div)
   133	{
   134		unsigned int coarse = div / 4;
   135	
   136		if (WARN_ON(applnco_div_out_of_range(div)))
   137			return 0;
   138	
 > 139		return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
   140				FIELD_PREP(DIV_FINE, div % 4);
   141	}
   142	
   143	static unsigned int applnco_div_translate_inv(struct applnco_tables *tbl, u32 regval)
   144	{
   145		unsigned int coarse, fine;
   146	
 > 147		coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
   148		fine = FIELD_GET(DIV_FINE, regval);
   149	
   150		return coarse * 4 + fine;
   151	}
   152	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
