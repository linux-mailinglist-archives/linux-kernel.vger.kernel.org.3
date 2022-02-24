Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122514C228D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiBXDod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBXDoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:44:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2555725A31C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645674243; x=1677210243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qKqsPzr9EKnUyvGstoIHQMSxtKsGrG2Jzo6jSirD02U=;
  b=MPTGzSypasCpHfmlMcv18sHHtavnST5WDJGCj2cwd4new4FpNYf0eWVr
   bWYqATjmaAenvrzgGNcsaAWpusuFjeiTI2yzDij9LVwJ7GVb9f+zQ4W1O
   EEZPftRpQdaa4MPkaSvquqcKPEo5xKATj9cT4IXUIQBAJ/maC/rgdijZg
   dnq1mVNyewZn4q7BJoEVyeQlQICzi3VHJU3MmMBI/KwN91umuNmBk6k6m
   04QwCFqPaS54Tf50TkoHHyIaVi4QLNmR0xjQ/Ex1G7bBLJcm//PUf4ql+
   WV1Cc6c3ftEhnEtsx/Y76ElrCFfDKu0Vf4atKLvDf+2Sli6hAMhCSY08Y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315368433"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315368433"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607288288"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 19:44:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN52u-0002Ce-O7; Thu, 24 Feb 2022 03:44:00 +0000
Date:   Thu, 24 Feb 2022 11:43:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thierryreding:for-5.18/work 16/143] ERROR: modpost: "xpcs_write"
 [drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.ko] undefined!
Message-ID: <202202241102.7iu9BQCg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.18/work
head:   1cdb7fffbcf8f949410bfa97c8cca5acc0285a48
commit: 566823063038911bfe7d6a20d1eefcddad91a977 [16/143] WIP MGBE
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220224/202202241102.7iu9BQCg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/thierryreding/linux/commit/566823063038911bfe7d6a20d1eefcddad91a977
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.18/work
        git checkout 566823063038911bfe7d6a20d1eefcddad91a977
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xpcs_write" [drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.ko] undefined!
>> ERROR: modpost: "xpcs_read" [drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
