Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552F57E783
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiGVThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGVThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:37:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2106B5A2CA;
        Fri, 22 Jul 2022 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658518661; x=1690054661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eGASKklxPUMMORdAKbavodrFNdgNugvERNiFn1gNMxc=;
  b=gVJ/v8XKJZi5aYBTDaIcai59QLtYl1oxxAyZc2Pdv4vIP3rK9XcsDG3O
   aCvSG+ISFwDs4EXI6Yu4y4jDgih09HUyMrKcn6mtvDsw19y6CU53XJdFi
   7Q9Px6FajDEb5eiRsWFLFfaK89TbJt3KF3vbGwCPiTzBfK71ssle3mkLd
   wFkLEZZ8R1jeUvqav1hwCCDdRFy6s4psESn6obYk4zev56yWWWH3sNLTw
   tq9BSih7aFTT79b/kIsGS9pzR04D+9MXu7AzCYMBzTKjQjEwnsQUq8QrY
   BWhekkMNNpxWpG0hk1wW5mAxsvC/2smYKakKfj5pLBJJWNU4hZJFJgOp+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="287405644"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="287405644"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 12:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="598954157"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2022 12:37:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEySt-0001l7-0J;
        Fri, 22 Jul 2022 19:37:35 +0000
Date:   Sat, 23 Jul 2022 03:37:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        marex@denx.de, paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 8/8] arm64: dts: imx8mp: add VPU blk ctrl node
Message-ID: <202207230318.E5ye0CU1-lkp@intel.com>
References: <20220722125730.3428017-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722125730.3428017-9-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master v5.19-rc7 next-20220722]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220722-205748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm64-randconfig-r005-20220721 (https://download.01.org/0day-ci/archive/20220723/202207230318.E5ye0CU1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/48de78c570ec370c4fe2dfd6d426fe665416eb21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220722-205748
        git checkout 48de78c570ec370c4fe2dfd6d426fe665416eb21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/imx8mp.dtsi:1181.26-27 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
