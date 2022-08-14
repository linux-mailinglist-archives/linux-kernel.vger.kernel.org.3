Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859EB591D5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiHNAwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHNAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:52:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6C7C770
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660438358; x=1691974358;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XMq4Ughp8FdxVQO1yotYpeQXSBmpMT1PofJ4VbqyLL4=;
  b=ayDsdyB7xSfshBv/Xpc7on9mC9LqjuefQBMUMPWTzdyMPaPOd+9VA09/
   Lo4MsgESbppmhlkObDCow8m1fbFiFYsEnEe3p3951JNducieYkgRRXMsv
   fwdjmjHcoDDenGgokOOWIFgRrDZrFxn5+JQQfncXDzDhwMUSD/lE76QDz
   iAys+0Gf7Hm0euQzQgwGBytJQOvaSX+QYGLCHEmwy9iaAy//NU6VwSACV
   VPb002JSplLf9gauXx7nxG9O8GVHmUT/yg4maWnCnwioE8spAhMzoZE5A
   0DzYjyWVBcwhk75cpTDfdYUR9LoflmM2pRqCmz1hq3lmpkKtKQP26CuG6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278743049"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278743049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 17:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="709389726"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2022 17:52:35 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN1rn-0002FY-0g;
        Sun, 14 Aug 2022 00:52:35 +0000
Date:   Sun, 14 Aug 2022 08:52:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.10 139/453] Error:
 arch/arm64/boot/dts/qcom/msm8916.dtsi:1267.28-29 syntax error
Message-ID: <202208140831.VHVRO1Ur-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.10
head:   ca8ab62d0916d61415250e7a192f219cd721f2b1
commit: a76ec991da43860d731411dc776a0e1cfe342fff [139/453] arm64: dts: qcom: msm8916: Use power domains for MSS/WCNSS remoteprocs
config: arm64-randconfig-r021-20220814 (https://download.01.org/0day-ci/archive/20220814/202208140831.VHVRO1Ur-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a76ec991da43860d731411dc776a0e1cfe342fff
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.10
        git checkout a76ec991da43860d731411dc776a0e1cfe342fff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/msm8916.dtsi:1267.28-29 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
