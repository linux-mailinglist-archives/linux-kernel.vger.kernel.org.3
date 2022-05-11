Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC219522A76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiEKDcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiEKDcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:32:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D2B87A07
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652239937; x=1683775937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FiCMab+ZLojIctV6N13AsokbDZNq2W9ALPtuQ8i2vZU=;
  b=LAgrSd8aQ/deujuwi3Aga1pta9o2qMMLgX5ZzRemzaMQScvj9n+TVhGo
   w/Ciy1/3qFSooTz9g+qRgUjtw9Ix58ZCIoywE8ig4Fcf6PVDr2035Bfzr
   UUGqTBmsQZshZoNgQElvz9LW3vWeGIxVJitsdVcL6UcOW6LFPx2DSP9Hv
   egKKNwfMae+eKPk55NU1fyIthum1IPScbGEoIc1Qoc8GwZFDz3MDv/zMz
   jHiUp3FAzWflhX4rPpfBtnMik+F6uwwof19fj4TqZu+aBpPizKk4FHJO+
   jITB+qVPDbvCaDNFiSmqgl3Xep9nG4YrY5nb7HgFwmIK33hDrrnIGRegT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332606980"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332606980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 20:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="697380868"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2022 20:32:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nod5C-000Ig1-Ef;
        Wed, 11 May 2022 03:32:14 +0000
Date:   Wed, 11 May 2022 11:31:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/regulator/mp8859.c:131:34: warning: 'mp8859_dt_id' defined
 but not used
Message-ID: <202205111110.NZWaV5qs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: c66f1cbad53a61f00f8b6273e737d5e560b69ec7 regulator: mp8859: add config option and build entry
date:   2 years, 4 months ago
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220511/202205111110.NZWaV5qs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c66f1cbad53a61f00f8b6273e737d5e560b69ec7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c66f1cbad53a61f00f8b6273e737d5e560b69ec7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/bridge/analogix/ drivers/regulator/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/regulator/mp8859.c:131:34: warning: 'mp8859_dt_id' defined but not used [-Wunused-const-variable=]
     131 | static const struct of_device_id mp8859_dt_id[] = {
         |                                  ^~~~~~~~~~~~


vim +/mp8859_dt_id +131 drivers/regulator/mp8859.c

4444a1c10069e2f Markus Reichl 2020-01-06  130  
4444a1c10069e2f Markus Reichl 2020-01-06 @131  static const struct of_device_id mp8859_dt_id[] = {
4444a1c10069e2f Markus Reichl 2020-01-06  132  	{.compatible =  "mps,mp8859"},
4444a1c10069e2f Markus Reichl 2020-01-06  133  	{},
4444a1c10069e2f Markus Reichl 2020-01-06  134  };
4444a1c10069e2f Markus Reichl 2020-01-06  135  MODULE_DEVICE_TABLE(of, mp8859_dt_id);
4444a1c10069e2f Markus Reichl 2020-01-06  136  

:::::: The code at line 131 was first introduced by commit
:::::: 4444a1c10069e2f371fa497ba22feafafed5aada regulator: mp8859: add driver

:::::: TO: Markus Reichl <m.reichl@fivetechno.de>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
