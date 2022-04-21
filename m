Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7402A5097B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384919AbiDUGf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384895AbiDUGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:35:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A913F3F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522770; x=1682058770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p7Pr0RllY3TGMORoCPsSyDbl2hdeDDnf2QbiHkn2zhQ=;
  b=jbjR+izAwL7BLnRmd6EBSD3Lxch/htmLZ6RbJexdbcVCPI0+KU4vZg8G
   Z7N90XuUqP5M5wlzm1HMAhh27G6rwwpBYW0ibz9O29B0JeFcTIL7MinVV
   ha//sOhbYoSawtrKVghvH/QWCsVqymZhBVWTY2ABmmmkBzMcmKFJWzql0
   xOCl3Fd2EzR1xubMcTbkfSNxglrgSNMkRwwTt01bcGLZB0BChf0Rp6LFS
   Y2VRWXNiWyMLQR62wr5U3bPDK1yvrekcNbBLg+9db/18qyF1j8aoPJxuu
   LCkCfhkt4kpw23J5weNMpLSJqeCwrmVMMBMyJAK2TmZXaJ227TvFJPafu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246149383"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246149383"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="865389453"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2022 23:32:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQMy-0007wi-D9;
        Thu, 21 Apr 2022 06:32:48 +0000
Date:   Thu, 21 Apr 2022 14:32:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1866/2579]
 drivers/media/platform/atmel/microchip-csi2dc.c:99:41: error: implicit
 declaration of function 'writel_relaxed'
Message-ID: <202204201929.Rar5Dxc9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: d978256196ab999eb303d56234a352604121dab8 [1866/2579] headers/deps: lib/scatterlist: Optimize the <linux/scatterlist_types.h> header, remove <linux/io.h>
config: sparc64-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201929.Rar5Dxc9-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d978256196ab999eb303d56234a352604121dab8
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout d978256196ab999eb303d56234a352604121dab8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/media/platform/atmel/ drivers/media/platform/nxp/ kernel/ sound/soc/qcom/qdsp6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/device.h:9,
                    from include/linux/device.h:33,
                    from include/linux/device_api.h:1,
                    from include/linux/device_api_lock.h:2,
                    from include/linux/fwnode.h:12,
                    from include/linux/property.h:14,
                    from include/linux/of.h:22,
                    from include/linux/of_api.h:1,
                    from drivers/media/platform/atmel/microchip-csi2dc.c:11:
   arch/sparc/include/asm/openprom.h:32:9: error: expected specifier-qualifier-list before 'phandle'
      32 |         phandle (*v2_inst2pkg)(int d);  /* Convert ihandle to phandle */
         |         ^~~~~~~
   arch/sparc/include/asm/openprom.h:174:9: error: expected specifier-qualifier-list before 'phandle'
     174 |         phandle (*no_nextnode)(phandle node);
         |         ^~~~~~~
   drivers/media/platform/atmel/microchip-csi2dc.c: In function 'csi2dc_power':
>> drivers/media/platform/atmel/microchip-csi2dc.c:99:41: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
      99 | #define csi2dc_writel(st, reg, val)     writel_relaxed((val), \
         |                                         ^~~~~~~~~~~~~~
   drivers/media/platform/atmel/microchip-csi2dc.c:332:17: note: in expansion of macro 'csi2dc_writel'
     332 |                 csi2dc_writel(csi2dc, CSI2DC_GCTLR, CSI2DC_GCTLR_SWRST);
         |                 ^~~~~~~~~~~~~
   drivers/media/platform/atmel/microchip-csi2dc.c: In function 'csi2dc_vp_update':
>> drivers/media/platform/atmel/microchip-csi2dc.c:98:41: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
      98 | #define csi2dc_readl(st, reg)           readl_relaxed((st)->base + (reg))
         |                                         ^~~~~~~~~~~~~
   drivers/media/platform/atmel/microchip-csi2dc.c:385:24: note: in expansion of macro 'csi2dc_readl'
     385 |                 gcfg = csi2dc_readl(csi2dc, CSI2DC_GCFG);
         |                        ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/writel_relaxed +99 drivers/media/platform/atmel/microchip-csi2dc.c

2de0b3c0f67842 Eugen Hristev 2021-12-13   96  
2de0b3c0f67842 Eugen Hristev 2021-12-13   97  /* register read/write helpers */
2de0b3c0f67842 Eugen Hristev 2021-12-13  @98  #define csi2dc_readl(st, reg)		readl_relaxed((st)->base + (reg))
2de0b3c0f67842 Eugen Hristev 2021-12-13  @99  #define csi2dc_writel(st, reg, val)	writel_relaxed((val), \
2de0b3c0f67842 Eugen Hristev 2021-12-13  100  					(st)->base + (reg))
2de0b3c0f67842 Eugen Hristev 2021-12-13  101  

:::::: The code at line 99 was first introduced by commit
:::::: 2de0b3c0f678422ef2211760079a27c3cb1404b2 media: atmel: introduce microchip csi2dc driver

:::::: TO: Eugen Hristev <eugen.hristev@microchip.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
