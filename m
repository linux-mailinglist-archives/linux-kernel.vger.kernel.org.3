Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1EF5162C0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbiEAIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiEAIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:36:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0B1AD8D;
        Sun,  1 May 2022 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651394007; x=1682930007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jrNTj0JJ2uvFbhnV20wpOWnX46OpvszfsQI3AOx8Eq0=;
  b=Swenix9YesygIMhDutlaaNcUoEyHcxRCEYfzwrn0RUELVyawNcRuEb7P
   7oLp1fNuhOil3b8fozrgsONI7lqgRKixOSBhhR5itbfviNRHdm6QlMPAe
   r0/GjhLr8FX4BJ1Hx/8K6C/4Gw3e3d3VU7pcCz/te2EYWE35RD4l9PGoR
   poY+T/C8699vTTdyeohV8ngjFY4oXunQZug2lDHJwP671yhM+hEx6i8Mu
   bPcLk8o5TI66lnj+TBzar3zRHJaqbZSxW4x/HdyBkw3azaZFOx84ciLHx
   QhW46gvkQ5U2suJgUNZCqD8pk5G5WnCcr/YyMHs1SxKtsQQfQ0ZT9f7gw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="265830060"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="265830060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 01:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="619433028"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2022 01:33:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nl51A-0008cV-6m;
        Sun, 01 May 2022 08:33:24 +0000
Date:   Sun, 1 May 2022 16:32:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Marty E. Plummer" <hanetzer@startmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org,
        "Marty E. Plummer" <hanetzer@startmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm: hisi: enable Hi3521a soc
Message-ID: <202205011637.T9bZyDaL-lkp@intel.com>
References: <20220501051020.2432338-3-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501051020.2432338-3-hanetzer@startmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Marty,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on soc/for-next robh/for-next krzk/for-next krzk-mem-ctrl/for-next v5.18-rc4 next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Marty-E-Plummer/clk-hisilicon-add-CRG-driver-Hi3521a-SoC/20220501-141036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-randconfig-r001-20220501 (https://download.01.org/0day-ci/archive/20220501/202205011637.T9bZyDaL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6677e373bf0fbceb87ba267fa934df2f4b7dc0ad
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marty-E-Plummer/clk-hisilicon-add-CRG-driver-Hi3521a-SoC/20220501-141036
        git checkout 6677e373bf0fbceb87ba267fa934df2f4b7dc0ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'arch/arm/boot/dts/hi3521a-rs-dm290e.dtb', needed by '__build'.
   make[2]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
