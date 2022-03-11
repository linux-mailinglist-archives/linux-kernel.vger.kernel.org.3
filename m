Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBFE4D66F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350393AbiCKQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349435AbiCKQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:59:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC966AF9;
        Fri, 11 Mar 2022 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647017921; x=1678553921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBJLDracNIElCTfhPdQSzpk98yuQXkyTtpQr/vOOpJM=;
  b=WSBmZsuM/f3cc9p7eOQf5IM6lZP5okeUicWmWsUIInm58Lc5ivLjXKVv
   GTEu2uqpjPKZAd6zOGBTwrVZEyHvNmYcJ0NBnrPyz8PkWhii5ykYJlG88
   /RpfM2GHCJVoZVvWKonhjeCqxei0mFeXZVMqQg1nwfhjZwGvS5bZ2iIpe
   7evYW1ud6pp7aMmhwdtqcbjJ93Z6O+z2wyohknx7XDp519d6DL1NRw+kf
   L31GUJacEnNiU4GSHrirDCr3UDDUEhugdmZIrUyr2ZXbWRQxQ2FKmjq6n
   8upp2fhe8WOyYbybd38bxCMQl4qIQbcr0EStU2p5fGHJNhyFHjuP5rdDg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255556374"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255556374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 08:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="633467843"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2022 08:58:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSib6-0006nB-Bp; Fri, 11 Mar 2022 16:58:36 +0000
Date:   Sat, 12 Mar 2022 00:57:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: enable vop2 and hdmi tx on
 rock-3a
Message-ID: <202203120049.YIR5IFdM-lkp@intel.com>
References: <20220310210352.451136-4-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310210352.451136-4-michael.riesch@wolfvision.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next xilinx-xlnx/master arm64/for-next/core shawnguo/for-next clk/clk-next kvmarm/next keystone/next v5.17-rc7]
[cannot apply to rockchip/for-next soc/for-next next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Riesch/arm64-dts-rockchip-add-basic-dts-for-the-radxa-rock3-model-a/20220311-050612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r014-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120049.YIR5IFdM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c217f194b7a9cbdb7cbb8149ae1f6e8c2faf6e3f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Riesch/arm64-dts-rockchip-add-basic-dts-for-the-radxa-rock3-model-a/20220311-050612
        git checkout c217f194b7a9cbdb7cbb8149ae1f6e8c2faf6e3f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts:7:10: fatal error: 'dt-bindings/soc/rockchip,vop2.h' file not found
   #include <dt-bindings/soc/rockchip,vop2.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +7 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts

     2	
     3	/dts-v1/;
     4	#include <dt-bindings/gpio/gpio.h>
     5	#include <dt-bindings/leds/common.h>
     6	#include <dt-bindings/pinctrl/rockchip.h>
   > 7	#include <dt-bindings/soc/rockchip,vop2.h>
     8	#include "rk3568.dtsi"
     9	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
