Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6AC54ED2C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378813AbiFPWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFPWRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:17:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F15640F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417841; x=1686953841;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DG7ij0akZlfheq7gBv50KZjX2DwXbyq1iuxXFk3wasY=;
  b=gQCDk5kRS/LfwLSUITeN+hzLI6XOPDl7KSxwbDli44ZBHosIjm1BaFtk
   lYni3tSl5/ovIkJR9K7ge4IP10vh37QaqGopluPc0PiLmX5PH2zDU/P7G
   y9roERv5MjBmCBgTnsO8yMRioTRrm4b/OHVA5TOcgUVut3Btbo7oqtiG1
   xItQMWXQYUzwQKSW6V4Zp3Gk7FHgW973OVa2zcn30kVSkyROh8omVmnDW
   mqoym04fmksODaZRmou7TgckhU30tAZEPTo9jXJYmiWVBsBKz+AhebnmR
   287Av/Q69PviRa5kxjV4VthH7t8AbUFhnbOj2hxuGPH+XLADXPVQdNbhj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341019168"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341019168"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="583806160"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 15:17:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1xng-000Oof-Dc;
        Thu, 16 Jun 2022 22:17:16 +0000
Date:   Fri, 17 Jun 2022 06:17:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: [jkirsher-next-queue:master 1/5] kismet: WARNING: unmet direct
 dependencies detected for QCOM_SOCINFO when selected by DWMAC_IPQ806X
Message-ID: <202206170615.6N5Xn5zs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git master
head:   5dcb50c009c9f8ec1cfca6a81a05c0060a5bbf68
commit: 9ec092d2feb69045dd289845024301fb91c064ee [1/5] net: ethernet: stmmac: add missing sgmii configure for ipq806x
config: (https://download.01.org/0day-ci/archive/20220617/202206170615.6N5Xn5zs-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=9ec092d2feb69045dd289845024301fb91c064ee
        git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
        git fetch --no-tags jkirsher-next-queue master
        git checkout 9ec092d2feb69045dd289845024301fb91c064ee
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_QCOM_SOCINFO --selectors CONFIG_DWMAC_IPQ806X -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for QCOM_SOCINFO when selected by DWMAC_IPQ806X
   
   WARNING: unmet direct dependencies detected for QCOM_SOCINFO
     Depends on [n]: QCOM_SMEM [=n]
     Selected by [y]:
     - DWMAC_IPQ806X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_STMICRO [=y] && STMMAC_ETH [=y] && STMMAC_PLATFORM [=y] && OF [=y] && (ARCH_QCOM [=y] || COMPILE_TEST [=n])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
