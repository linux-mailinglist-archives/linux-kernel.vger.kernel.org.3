Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F326F520B37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiEJCcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiEJCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:32:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF81A8E39
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652149707; x=1683685707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w4IbXm7Oa8+fhoEJNZICLRMnTk1Uzu3E9Gvfc4VP7e0=;
  b=D9SjVeesGJeD8nnHgZfNF5oaOBRtcVTIEtLfghoMDWgDwowLn2Gxcx0j
   8LAVCt6szpFjSaR/sP1RCUEYGcral4bZpkS5YTPQSuv9Eia+4XbVVYzrC
   lAJp3FZrYhRf3hg2frKxcfMXl3ZGKCx5is8FuPD3b+wUnwvYEE+3Ka+wr
   AdAThoGDNRbbRRnU/ntj+J3QqVAXxdXv6ODSU+Aax13aJj9zWRtVJWorG
   XgfN0HR96rh/44SJ0L+f/I2TG9N0QYLiK/IkWG1f0iHxYhZ/hcWHoZ7pu
   fyZwnN4oRCM9gybKPOImVkutU01J12+PEAe/ccZNpELY5ol3gGA6B2Yxs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268900875"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="268900875"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 19:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="696860975"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2022 19:28:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noFbr-000HBm-Lh;
        Tue, 10 May 2022 02:28:23 +0000
Date:   Tue, 10 May 2022 10:27:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 3130/5595]
 drivers/mfd/atmel-flexcom.c:108:32: warning: 'atmel_flexcom_pm_ops' defined
 but not used
Message-ID: <202205101006.WQSxaIjZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   3dca4fac0d16d15d15f9fe909372b7503ed5ac73
commit: ad52b9890b83ffa7602a23949c2cb0c0d94681e9 [3130/5595] mfd: atmel-flexcom: Use .resume_noirq
config: i386-randconfig-m021-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101006.WQSxaIjZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=ad52b9890b83ffa7602a23949c2cb0c0d94681e9
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout ad52b9890b83ffa7602a23949c2cb0c0d94681e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/atmel-flexcom.c:108:32: warning: 'atmel_flexcom_pm_ops' defined but not used [-Wunused-const-variable=]
     108 | static const struct dev_pm_ops atmel_flexcom_pm_ops = {
         |                                ^~~~~~~~~~~~~~~~~~~~


vim +/atmel_flexcom_pm_ops +108 drivers/mfd/atmel-flexcom.c

   107	
 > 108	static const struct dev_pm_ops atmel_flexcom_pm_ops = {
   109		.resume_noirq = atmel_flexcom_resume_noirq,
   110	};
   111	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
