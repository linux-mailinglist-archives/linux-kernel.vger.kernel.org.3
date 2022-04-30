Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759E3515C60
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiD3LLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiD3LLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:11:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3F2183C;
        Sat, 30 Apr 2022 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651316871; x=1682852871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iufLhP9T3YBGfqs3kmQxcaVhrknn6J13wPNVqrqCmBk=;
  b=hfTqScxLnOL4sBG5kLp3EbrGNATr51EEBlfVvbjiVeknWPdPp+CX6r2J
   +pn72zbMCyDJsLKKP9g0KHD4zmcfpZ9wM9UceGF5hc+BSPyC2roe7zeWG
   /wHKuZll+DBYfXTqfqxBhlslM6Zj9JV9ly++cI/YnynZ2gdYiaVNa1RQ0
   YIxsRPa+ceJnujBoL/hSA76UaTHKAISP6mJvNSWbk/G+qvgYuBRF8MwB9
   7dYo5ywGLpSjtPmoOePABzJYLqspIXGGKPuvaGBbpAdDsQuC12sdVk2TD
   fkPk/hPtIaBVx+BSWO8TTMHdEjt70NxgX/SBTmZDgP2dnO+4aiduJ8hf+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="254273616"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="254273616"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 04:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="543773406"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2022 04:07:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkkx1-00079v-Fc;
        Sat, 30 Apr 2022 11:07:47 +0000
Date:   Sat, 30 Apr 2022 19:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Furkan Kardame <f.kardame@manjaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: rockchip: add dts for Firefly Station
 M2 rk3566
Message-ID: <202204301929.bZ7P8lrZ-lkp@intel.com>
References: <20220429115252.2360496-8-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429115252.2360496-8-pgwipeout@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next shawnguo/for-next soc/for-next v5.18-rc4]
[cannot apply to rockchip/for-next xilinx-xlnx/master keystone/next next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r021-20220428 (https://download.01.org/0day-ci/archive/20220430/202204301929.bZ7P8lrZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8e40f3685ab414fc5e5e003d51b62065a3880b6c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
        git checkout 8e40f3685ab414fc5e5e003d51b62065a3880b6c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts:566.1-16 Label or path usb_host0_xhci not found
>> Error: arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts:570.1-16 Label or path usb_host1_xhci not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
