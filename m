Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81E520C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiEJDdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiEJDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:33:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729A5DE60;
        Mon,  9 May 2022 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652153376; x=1683689376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t1klwIoGWv+OQ2Kpjn1hI1nlgV8+p4LfkRBvxm2srP4=;
  b=iapAqaTfuThO3gLSBXbq97bS1pHUb6hilDismWV+6Ga4xts31ONJ6VB7
   CQLYhV42o04vM0iC+twHLvtjyILWF8TrWNYKJXOeSL6aaFA3Q9IXN/emf
   XJSgRD7i8q6n87+R1Zejhq6cwqJtNDNykb2nMi8C+fU3s6uOfp2RupmZh
   lV+UAoavr3h+zR1VXxjvRLM873h+APnN1J8O5yVwK3OQRA27OK9fj2WCp
   48RRo/YId0bQfEETkH4VIcRnJUi8/ZKlnuiJCvEgduAj7Bv1Xzu2k4QlH
   ThO50Lh1sS1w27Rqh1g3CuRXI4bdjqA54YmmJpbj6TXN4jFI4aXA9xk+B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329841522"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="329841522"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 20:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="552513212"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 20:29:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noGZ1-000HFG-Uh;
        Tue, 10 May 2022 03:29:31 +0000
Date:   Tue, 10 May 2022 11:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        Manohar.Puri@microchip.com, Kavyasree.Kotagiri@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Message-ID: <202205101102.ozG8p9Tv-lkp@intel.com>
References: <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kavyasree,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on robh/for-next]
[cannot apply to soc/for-next linus/master v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220509-171104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: arm64-randconfig-r013-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101102.ozG8p9Tv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6b77ec16441906d1aa067b60cf97807111abdd72
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220509-171104
        git checkout 6b77ec16441906d1aa067b60cf97807111abdd72
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/mfd/atmel-flexcom.o: in function `atmel_flexcom_probe':
   atmel-flexcom.c:(.text+0x178): undefined reference to `devm_mux_control_get'
>> aarch64-linux-ld: atmel-flexcom.c:(.text+0x1e0): undefined reference to `mux_control_select_delay'
>> aarch64-linux-ld: atmel-flexcom.c:(.text+0x1f4): undefined reference to `mux_control_deselect'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
