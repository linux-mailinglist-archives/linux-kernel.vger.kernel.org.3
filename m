Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D37597000
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiHQNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiHQNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:33:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A868F95F;
        Wed, 17 Aug 2022 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660743144; x=1692279144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4dmBBRSG7eMGt8juxKy2hs5MyorJMiVbbfoy6JIX9XY=;
  b=J30HLQRxAP5Y7+9J/YrkGqugy6BRCwS4rNuBcWvgWxWkd69iQwOPFS9h
   /nxyRmK51K00UR2DAaTq+yZFbbMi/2i9oATusMp1qnYiPQMY5Uhd2O0P8
   nEUmueQl1KPMh7MQg14VlPORt+oyMmhIZME+y5vtpM4wlVM2LuivzJUKM
   WdalFBhisdQTXz0wuW3vXxufSyFbc5j+Z4WrDenbh9wzI2i2QXLtCeVs4
   PHPweeSz4y5gfjX2b7kPEnuA6JhPIR9mr84adZ/WXMUvAgfgTgexmyuEw
   v6ExysqknQ9qqQ7j63O6ObpfE32WGO8me34wDZJMYUEnsyMq8ml9xD+vF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="318500695"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="318500695"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="583769626"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 06:32:21 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOJ9g-0000yc-29;
        Wed, 17 Aug 2022 13:32:20 +0000
Date:   Wed, 17 Aug 2022 21:31:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <202208172150.rEZ2HEYS-lkp@intel.com>
References: <20220816120829.719749-4-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816120829.719749-4-conor.dooley@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc1]
[cannot apply to thierry-reding-pwm/for-next robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Conor-Dooley/Microchip-soft-ip-corePWM-driver/20220816-201744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220817/202208172150.rEZ2HEYS-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/961e375a245186c8ec2c40e48e5baf40a112f14a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Conor-Dooley/Microchip-soft-ip-corePWM-driver/20220816-201744
        git checkout 961e375a245186c8ec2c40e48e5baf40a112f14a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x234): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x254): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/pwm/pwm-microchip-core.o: in function `mchp_core_pwm_enable':
>> pwm-microchip-core.c:(.text.mchp_core_pwm_enable+0x1cc): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
