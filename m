Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA84D5C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347025AbiCKHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiCKHXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:23:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C89FD1D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646983357; x=1678519357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8g6o6mmzKfeSZyi85GEnzkTpDNKFd0dqka1Dten3mQ=;
  b=AQwizOjrqH7kMY5V3w6EnlZ6dVzJhS/3KPWbaLVW0ibxt+8QNJWhra6H
   Tf4Ee5qHxcLxOM4JMUgeLMFftkuW4bGdGLYK70XG7PQe70UysGH77N0nF
   XW7Raz+JKcPCCiP/REu3CKJB1rtBIYBlVQixTsJEv6DMheJerRZuF6e7W
   E90ODytIwlhcPm0jnfG5FiyrnsZnjUG3yLgsGyt6RCYQLf1kpP335h5VL
   vJZjK15k9hkz9lRA+u+i2RJxSaMDylJ4l2AsfDpm+fCJqHuGaL+wvSMVI
   upzT2SHRabDJ0HrOi73gKcDAEk0DBewl49P/DMg+Dtazb+igWstkmCfKn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255708249"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="255708249"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="644847458"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2022 23:22:35 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSZbe-000626-9J; Fri, 11 Mar 2022 07:22:34 +0000
Date:   Fri, 11 Mar 2022 15:21:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] arch: arm: mach-hpe: Introduce the HPE GXP
 architecture
Message-ID: <202203111516.oSsKrRqX-lkp@intel.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
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

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on soc/for-next robh/for-next linus/master v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/nick-hawkins-hpe-com/arch-arm-mach-hpe-Introduce-the-HPE-GXP-architecture/20220311-035513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220311/202203111516.oSsKrRqX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/9fbfc32473a65e025764e0a1456c421b4706fe8e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review nick-hawkins-hpe-com/arch-arm-mach-hpe-Introduce-the-HPE-GXP-architecture/20220311-035513
        git checkout 9fbfc32473a65e025764e0a1456c421b4706fe8e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-hpe/gxp.c:26:13: warning: no previous prototype for function 'gxp_map_io' [-Wmissing-prototypes]
   void __init gxp_map_io(void)
               ^
   arch/arm/mach-hpe/gxp.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init gxp_map_io(void)
   ^
   static 
   1 warning generated.


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
