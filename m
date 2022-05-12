Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA75250C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355673AbiELO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355658AbiELO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:58:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9F61623
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652367512; x=1683903512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HHQyiwPlqk0e9BRwZTAegPJZgZasFfmx8ffD3LYyccQ=;
  b=Er4UBdiokcqyiXkD3m3Yr8jxXMXpysaL312K0iQEoUnPrfojOydwaXc9
   HJxDzUNcGHu/E8YrGNayk46edeFkYhzbZnYjiLTX/+70xgyVCr0NXZQKN
   iXzLCtzXQmtP91Ew+mH/z/W8UjlNrhG+VTt8JwOi/ArTDDyOC90mUX81E
   sDVGh+LxwRZ/hw5ztXhdeYNiAbgCLmeJlglaITZJA8IVHCojg2nBFAKqK
   bHR+eqeUY0XBGyAXfhI7XocopjeYilknYnCJyUboKbGWWtcrezRz6ta6H
   ET4H1dSOZUobpyHjwzHtFVsfvvXP+EAMD3oD5w4re9CMfcHVfrEjkweow
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269697173"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="269697173"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="698057289"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2022 07:58:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npAGr-000KbM-QC;
        Thu, 12 May 2022 14:58:29 +0000
Date:   Thu, 12 May 2022 22:57:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 2544/6451]
 drivers/mfd/atmel-flexcom.c:108:32: warning: 'atmel_flexcom_pm_ops' defined
 but not used
Message-ID: <202205122255.WcGtKiOs-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   c9e18547cc55752d0ff283cfeb47d2c556560b17
commit: 6b6e7150c18becf39038245123ee07931149a105 [2544/6451] mfd: atmel-flexcom: Use .resume_noirq
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205122255.WcGtKiOs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=6b6e7150c18becf39038245123ee07931149a105
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 6b6e7150c18becf39038245123ee07931149a105
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mfd/

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
