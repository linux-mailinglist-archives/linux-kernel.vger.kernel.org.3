Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECE564B05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiGDBAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:00:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E616248
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656896447; x=1688432447;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jUfxmu0jfOfWTd/5sfOZtP1kowzWgjVW1u//Dau02Yo=;
  b=EFVcK1Q97ct6uWgGiN0Lm3zLm9/LiJAWKhg3C5aR6/HTQd4yqH6ZkLwz
   lrWym7/pXg0wQARZ0emSDhjsJtSrrPQEZB98v/OWlYYAdLQRSg5rhg+Ao
   wEe1f7jZc5bX4SMlk1PJsqIDhDV3cg6eG6y070P+YYPoLFO4/wiqUg8Oi
   ZOaKDGIRX2M5CmxAu6W2erWub403ZVnQKbSUL1GWQkAc0VewEn0eFabfX
   JFuTFt5u+9miQv3+BqWOzkRBoLaACdZ0cJQ7yio5st0skYN2+QEEtlrvT
   wDaZYi7NO6ah/xxvDYLuoRm7gBpj4Uk/oGDt/nIResUDX9aqJ50L9gfYC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="266029086"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266029086"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 18:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660018662"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2022 18:00:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8ASC-000HFZ-LE;
        Mon, 04 Jul 2022 01:00:44 +0000
Date:   Mon, 4 Jul 2022 09:00:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [andersson:ci-next 145/256]
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:13:10: fatal
 error: sc8280xp-pmics.dtsi: No such file or directory
Message-ID: <202207040851.iAfEmFaX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel ci-next
head:   9b3ce87d4ca378dcc682c816050abac245606df2
commit: 2d8e34c9946251a82f06d0d877baa35d9b291954 [145/256] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220704/202207040851.iAfEmFaX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/2d8e34c9946251a82f06d0d877baa35d9b291954
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson ci-next
        git checkout 2d8e34c9946251a82f06d0d877baa35d9b291954
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:13:10: fatal error: sc8280xp-pmics.dtsi: No such file or directory
      13 | #include "sc8280xp-pmics.dtsi"
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +13 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts

    11	
    12	#include "sc8280xp.dtsi"
  > 13	#include "sc8280xp-pmics.dtsi"
    14	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
