Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75A94D61B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348627AbiCKMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCKMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:42:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF71A8058
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647002465; x=1678538465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tmONhBIbZRxB1/USQ1+lPAWM5ks9zBRpbaCdGRjHaJ4=;
  b=ZE3WmOGSSjJqkVqEBGsXYxzDEOWr5loMnYdXQ6up1YxzEvdZlFzoiygj
   B0wx943DBa6SdyNHKUiDzxL6dKqJAP8Q/I2plxc9rNRKcfK3PI2wRFTIB
   8IAvV5oEOrA8GuUFspThuOI594GmDGzdFoQ0CJ+U/Rl7b6U6eBUpJEBW1
   LnPCnHuv48IYizPhANpdfIUmtesdz+tuieXvwf78aPoAAWRa8VGCP3fDB
   N5eslCnw3Gbe0+rFW6mnXE0Od9b4sOOrsAiQ7H5WDlOEG4gVTNIHTMAcp
   rTCYPbDWpYu95HND/ZMK/zmDIrZ/gx4gOnXD/4qSW0ZF6VzI4S5IQL1bQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253127686"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="253127686"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 04:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="579275163"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 04:41:03 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSeZr-0006Op-0Q; Fri, 11 Mar 2022 12:41:03 +0000
Date:   Fri, 11 Mar 2022 20:40:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     kbuild-all@lists.01.org, Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] arch: arm: mach-hpe: Introduce the HPE GXP
 architecture
Message-ID: <202203112000.DIc9zr62-lkp@intel.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on soc/for-next robh/for-next linus/master v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/nick-hawkins-hpe-com/arch-arm-mach-hpe-Introduce-the-HPE-GXP-architecture/20220311-035513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220311/202203112000.DIc9zr62-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9fbfc32473a65e025764e0a1456c421b4706fe8e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review nick-hawkins-hpe-com/arch-arm-mach-hpe-Introduce-the-HPE-GXP-architecture/20220311-035513
        git checkout 9fbfc32473a65e025764e0a1456c421b4706fe8e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-hpe/gxp.c:26:13: warning: no previous prototype for 'gxp_map_io' [-Wmissing-prototypes]
      26 | void __init gxp_map_io(void)
         |             ^~~~~~~~~~


vim +/gxp_map_io +26 arch/arm/mach-hpe/gxp.c

    25	
  > 26	void __init gxp_map_io(void)
    27	{
    28		iotable_init(gxp_io_desc, ARRAY_SIZE(gxp_io_desc));
    29	}
    30	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
