Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C85A3F05
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiH1SN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1SNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:13:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1912124971
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661710404; x=1693246404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Hlns22LZWE3p+FQ++/dik+d3S1XaBFdn56EUsUSG4A=;
  b=EvJA0qXA4fBZE+ShPpQiyw2SQee2u+p41B7+jyo43izBVRbyGHjt126+
   sC8R6MUT0GGDjeOBL0cSJi5wyiPyUDgISRWnF7W6IHt0tHnltzfAWu0c2
   UiNDtXqDkHTlOoazuZXeKroAzFnnW2fsp6ARg36LGPHzo3wpWcm2BPYfr
   fSDgOqQMdwudbxOeEgVQbtd66SYpEcWP5slH0DzH72AcASa1UurK5Rkyc
   WcjBn/xIXnfKiIN3/9cMAuE2/3Una6LPHIwNGXxM7L74THA+LDXskn0xJ
   hXdYJ0C3bMtBGVFbIOC/RxBDmGxt0sFf61ce5V+exGY9XS+F2O4TLKLGs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="275161575"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="275161575"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 11:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="679399684"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2022 11:13:22 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSMmf-0001Sx-35;
        Sun, 28 Aug 2022 18:13:21 +0000
Date:   Mon, 29 Aug 2022 02:12:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/slimbus-qcom 3/25] kismet: WARNING: unmet direct
 dependencies detected for REGMAP_I2C when selected by SND_SOC_RK817
Message-ID: <202208290211.nIH8FxEa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/slimbus-qcom
head:   c3fe3d44a059ab640d70ca99a990c7b52d5ae60b
commit: f445f200c75e208c44dff7292a57fe2f21090555 [3/25] ASoC: codecs: allow compile testing without MFD drivers
config: x86_64-kismet-CONFIG_REGMAP_I2C-CONFIG_SND_SOC_RK817-0-0 (https://download.01.org/0day-ci/archive/20220829/202208290211.nIH8FxEa-lkp@intel.com/config)
reproduce:
        # https://github.com/krzk/linux/commit/f445f200c75e208c44dff7292a57fe2f21090555
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/slimbus-qcom
        git checkout f445f200c75e208c44dff7292a57fe2f21090555
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_REGMAP_I2C --selectors CONFIG_SND_SOC_RK817 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for REGMAP_I2C when selected by SND_SOC_RK817
   
   WARNING: unmet direct dependencies detected for REGMAP_I2C
     Depends on [n]: I2C [=n]
     Selected by [y]:
     - SND_SOC_RK817 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (MFD_RK808 [=n] || COMPILE_TEST [=y])
   
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
     Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
     Selected by [y]:
     - QCOM_RPMPD [=y] && PM [=y] && QCOM_SMD_RPM [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
