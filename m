Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3B56ACB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiGGU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiGGU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:29:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BCBC42
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657225745; x=1688761745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7h/YK2M4KUEnl+cMJFXU/alkNIGoKUABcoVBVl9Xuuc=;
  b=RDb1ll3k4egbRTGoXWslJGU9FG64Vd6zBVVslX/mFeZ3KGuegiKrufI4
   EHjFSBsReTGFNsn0SA+dm6RA56GRaFI42B9b6dAtw9W70/RrXkImDax78
   jxkhZQTqMBsDHEvDX4MgEVSHrllr4KIZs9F/w9T6eN/vB5uQlb4W3AioK
   fNg35Yp9z2MdDpnLGG23QzXZXrKsxf2hxOaB7+8XSu7VhJfrOqbp4Hmpg
   wI/T1JW56gR2uvqi8CbtldSDwdyb4dFUHxuX7TUS6C1VktkuBLFv39liQ
   pXJ3mHRDZDZksZC1CqCFImm+E5LlKgibfhnsiahHbF0D0t6se4GSt8PFy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264529863"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="264529863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 13:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="661522975"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2022 13:29:03 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Y7S-000MS2-Uk;
        Thu, 07 Jul 2022 20:29:02 +0000
Date:   Fri, 8 Jul 2022 04:28:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [qcom:drivers-for-5.20 18/20] kismet: WARNING: unmet direct
 dependencies detected for PM_GENERIC_DOMAINS when selected by QCOM_RPMPD
Message-ID: <202207080430.IujPhnlg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux drivers-for-5.20
head:   b9c2ae6cac403dee3195fda9eb28d8ee733b225b
commit: 7d0221fb59125181a31ef3a561306c70fb238bc7 [18/20] soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
config: (https://download.01.org/0day-ci/archive/20220708/202207080430.IujPhnlg-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?id=7d0221fb59125181a31ef3a561306c70fb238bc7
        git remote add qcom https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux
        git fetch --no-tags qcom drivers-for-5.20
        git checkout 7d0221fb59125181a31ef3a561306c70fb238bc7
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_PM_GENERIC_DOMAINS --selectors CONFIG_QCOM_RPMPD -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS when selected by QCOM_RPMPD
   
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
     Depends on [n]: PM [=n]
     Selected by [y]:
     - QCOM_RPMPD [=y] && QCOM_SMD_RPM [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
