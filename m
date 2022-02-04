Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A24A91FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356493AbiBDB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:29:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:52439 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356158AbiBDB3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938186; x=1675474186;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fvSAzagU7qo3TmtZ5MOZxHVhOlTt+JXuxo4SJqzrNbs=;
  b=Qv9SzIR+eSY8u5Cy1+rktc5f3BYwdR6RIjr0C56nPx8aLgkAcU6O9mRD
   mjSLs4EYHI01UlJj8joCvZuQQ95MuVjB85cizwazWTNzwwcQxt96GJqzd
   wev08mf8RVOrZsfaUWe9LUftRM3t79MhEwTNmHxeXtEjbjlxG5bv1k3sf
   kbZJ5i0J2CIwmZcjGRFqpSxp1mwhWaTk3je/fnA2e+S2q5KGPuY2jVaNO
   FiBXaTssg6DsAQYpBMsQGoT6jWDnDGqw/LUbiByfun43h9GskxtwxiA4G
   8j2yrSETy2w7WWuwgsdZuMvKr0YiWF3LXXp13JqnTWF8z7zhV1GcvXCRR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228264536"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228264536"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:29:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="498346665"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2022 17:29:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnQ0-000WtT-9t; Fri, 04 Feb 2022 01:29:44 +0000
Date:   Fri, 4 Feb 2022 09:29:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     He Ying <heying24@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/4.14 7697/9999] warning: (ARCH_QCOM && ..)
 selects QCOM_SCM which has unmet direct dependencies ((ARM || ..) && ..)
Message-ID: <202202040349.C1iRZSbh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi He,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
head:   b96afa2028a168dc8132d413b0646562dab53287
commit: 089e8c136cda08dd418e82a475c870b844e59261 [7697/9999] firmware: qcom-scm: Fix QCOM_SCM configuration
config: arm-randconfig-r033-20220130 (https://download.01.org/0day-ci/archive/20220204/202202040349.C1iRZSbh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=089e8c136cda08dd418e82a475c870b844e59261
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.14
        git checkout 089e8c136cda08dd418e82a475c870b844e59261
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=arm distclean

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> warning: (ARCH_QCOM && VIDEO_QCOM_VENUS && DRM_MSM && QCOM_ADSP_PIL && QCOM_Q6V5_PIL && QCOM_WCNSS_PIL && QCOM_MDT_LOADER && QCOM_PM) selects QCOM_SCM which has unmet direct dependencies ((ARM || ARM64) && HAVE_ARM_SMCCC)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
