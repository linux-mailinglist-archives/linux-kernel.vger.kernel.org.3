Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239257F887
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiGYDyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGYDx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:53:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E890BB875
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 20:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658721238; x=1690257238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v+GceWdXE5UBi2d3q9mLHkHgYn4bHyYCj2SQzQEh+b8=;
  b=DpxJQediFDLEbffBtns5W+Upse2cEZuyWk4TdHI5uJvwNRYWCHYoMqTa
   Z65VCmZVGEkJC0D7ZLdLyyu3icRxoWAu9pF/X9OM3LCfpQxvMIuFcGvQG
   iGZIPz+91AlZc89fIb3Ace21PN6VqY30YyHF/Xq1xpEBDZ6jT37QeIY6J
   SQytFT9HtD/kje8BvzSVDS06aVLKfJGEVCChlZmSXR5tVvn9/E9DDmCF9
   TNRxvE2wAfqfiblJpNo+wgi1fnxzrsLLMTtkv3a/+hROS2axredNMK2p+
   Vr/q9pAzU71rYlB9CHTE3FcAalN2xAiqShd9lx18c4V5x1oVhSlmrCVDZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="286362914"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="286362914"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 20:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="667321886"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2022 20:53:56 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFpAK-0004gx-0A;
        Mon, 25 Jul 2022 03:53:56 +0000
Date:   Mon, 25 Jul 2022 11:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 3768/9999] kismet: WARNING:
 unmet direct dependencies detected for EINT_MTK when selected by
 PINCTRL_MTK_PARIS
Message-ID: <202207251115.h9CdepJb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: ce81cc2139314b111602c95744a88bdb2a25c40a [3768/9999] FROMGIT: pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings
config: (https://download.01.org/0day-ci/archive/20220725/202207251115.h9CdepJb-lkp@intel.com/config)
reproduce:
        # https://github.com/jsarha/linux/commit/ce81cc2139314b111602c95744a88bdb2a25c40a
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout ce81cc2139314b111602c95744a88bdb2a25c40a
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_EINT_MTK --selectors CONFIG_PINCTRL_MTK_PARIS -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for EINT_MTK when selected by PINCTRL_MTK_PARIS
   sound/soc/intel/Kconfig:106:error: recursive dependency detected!
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   sound/soc/intel/Kconfig:106:	symbol SND_SOC_INTEL_SKYLAKE is selected by SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   sound/soc/intel/boards/Kconfig:303:	symbol SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH depends on SND_SOC_INTEL_SKYLAKE
   warning: (PINCTRL_MTK && PINCTRL_MTK_PARIS) selects EINT_MTK which has unmet direct dependencies (PINCTRL && (ARCH_MEDIATEK || COMPILE_TEST) && (PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST))

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
