Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865C858854F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiHCBQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:16:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C2558CC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659489403; x=1691025403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S4FrL8dGMuHIj7Th2f0eB4F0KnVVDKrax3h1wxVa1nY=;
  b=UF7EJpcPGFIUPVFcK/96JuZqSU9Wu+TondFB6zkL1ruC64IFvbuak8ub
   jD8TQwj5vnGheAuUJNDo2Sc1RXGMJaumbGPdIOwpeGmHy/sXu3uiNjG58
   tBpTyl81ZMWjYmR8uf2O6dfBa3ELsnL2BNpjH4wGCP8tAjc37r9FHXKCM
   83ONrtdYSToSCYusH127gt7b5NGYWpBdC784ZcQiNpozG1JAQcAg4GVe1
   Lygy3Aay10PVpKcUY2bXtBPhm+Y4Eg2fJunR+WqP58bJsRRuX7cn1dZG9
   d1k1rLLb2+NUZZrqRtpfrPDVpSb/0KBKtOq+uTLv5GH/kpixKd8UZWQTG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287116405"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="287116405"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 18:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="670665347"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2022 18:16:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ305-000Ge1-0t;
        Wed, 03 Aug 2022 01:16:41 +0000
Date:   Wed, 3 Aug 2022 09:16:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [steev:linux-v5.19.0 69/198] ERROR: modpost:
 "typec_switch_get_drvdata" [drivers/phy/qualcomm/phy-qcom-qmp.ko] undefined!
Message-ID: <202208030957.PlLylDr3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0
head:   a4510d0cef54eda304739679db13f1f17abe4125
commit: 52c2355f918241ce43caf2fbceb8aff380038507 [69/198] phy: qcom-qmp: Register as a typec switch for orientation detection
config: openrisc-randconfig-r023-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030957.PlLylDr3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/52c2355f918241ce43caf2fbceb8aff380038507
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0
        git checkout 52c2355f918241ce43caf2fbceb8aff380038507
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "typec_switch_get_drvdata" [drivers/phy/qualcomm/phy-qcom-qmp.ko] undefined!
>> ERROR: modpost: "typec_switch_register" [drivers/phy/qualcomm/phy-qcom-qmp.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
