Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294F151594B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359141AbiD3AUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 20:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbiD3AUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 20:20:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8601281657;
        Fri, 29 Apr 2022 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651277850; x=1682813850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kAcWmtvMs86EJf0sId+GTZ326TwVr2sRH2tRpBuMGfI=;
  b=bHzDtvlknTYMCb68St7RFkM9cAkhNLeShSSqimm2roMTP6vYV1V0ax8b
   u8jhDFhYQ/n3slQ3WmY6QIDeB+PR0O446gFCwvJJH2WEDJQuoy4wuer9B
   rOfcztIv+WHv2K48fcGCCvsAzMIDZ3tFoDk82IiMGrRv3N3XhfEibEnd2
   iFii5MIV9psjZnYC+NORHvxFuJbTd42yqAPz51EpC38HA/kSwYx/cgEtP
   7CMY2Wc29kR3zLpiOyS5dr40i0E/nQ8e2yeEPoniPCIx038CB6fp4VV/7
   VfN1nPmPWQ2gwE6oBRqse+buzMIE9a2KPPsfyVcQ3iESZRyS/AF5BqwiV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="327306783"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="327306783"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="630301471"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2022 17:17:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkane-0006iN-OV;
        Sat, 30 Apr 2022 00:17:26 +0000
Date:   Sat, 30 Apr 2022 08:16:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B
 device tree
Message-ID: <202204300850.X97CRcO6-lkp@intel.com>
References: <20220429115252.2360496-6-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429115252.2360496-6-pgwipeout@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next shawnguo/for-next soc/for-next v5.18-rc4]
[cannot apply to rockchip/for-next xilinx-xlnx/master keystone/next next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r021-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300850.X97CRcO6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d933bfeea016da20a99bce012bbf071f9d86e2bf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
        git checkout d933bfeea016da20a99bce012bbf071f9d86e2bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts:601.1-16 Label or path usb_host0_xhci not found
>> Error: arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts:605.1-16 Label or path usb_host1_xhci not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
