Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FE575949
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiGOB4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiGOB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:56:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618367584;
        Thu, 14 Jul 2022 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657850160; x=1689386160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KChe3YiLWvtfY16v3Wrv+LYGFrMr3lG5eJioM1UXoK8=;
  b=il5Kj2cMJEioQPWJOWQZq8uTKoDKdaGbdn5ssUDYVq6DhOD2fStruUVL
   g5Gi7LKgymdCsDfP9Ooe6nTojPMblDn+IK7WvGfXDKcDz+gA26E65q4C+
   Z9eCpO0MxAMdtpbNEQEGsqW3T4yCAwyqdsU1EKoPpO3tKKxoHvlnzO6V1
   StB1BJ6LCoy062BcZNxHPStdGb1v1n31gedBEJY28OKi1d+A4ceEHsLk0
   vPCj578z57yBsPIOBf+xXg9tISG5MlkltRxvr1bH+N4gz+Mx82pxeUsqJ
   MxIrd1lmjpefj6MIs7w5epKx63t5pqYTpw1iZtJsUL8r/dyKa/9YaLnrn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371993857"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371993857"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="600335169"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2022 18:55:57 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCAYe-0001Pp-Fp;
        Fri, 15 Jul 2022 01:55:56 +0000
Date:   Fri, 15 Jul 2022 09:55:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Shih <vincent.sunplus@gmail.com>, kishon@ti.com,
        vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, Vincent Shih <vincent.sunplus@gmail.com>
Subject: Re: [PATCH v3 1/2] phy: usb: Add USB2.0 phy driver for Sunplus SP7021
Message-ID: <202207150959.Pamg8oYO-lkp@intel.com>
References: <1657529403-18084-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657529403-18084-2-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on pza/reset/next linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Shih/Add-USB2-0-phy-driver-for-Sunplus-SP7021/20220711-165347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: (https://download.01.org/0day-ci/archive/20220715/202207150959.Pamg8oYO-lkp@intel.com/config)
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/7370e305e24f576291c9f474664b068188d6de57
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Shih/Add-USB2-0-phy-driver-for-Sunplus-SP7021/20220711-165347
        git checkout 7370e305e24f576291c9f474664b068188d6de57
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_NVMEM_SUNPLUS_OCOTP --selectors CONFIG_PHY_SUNPLUS_USB -a=i386
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=i386 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NVMEM_SUNPLUS_OCOTP when selected by PHY_SUNPLUS_USB
   
   WARNING: unmet direct dependencies detected for NVMEM_SUNPLUS_OCOTP
     Depends on [n]: NVMEM [=n] && (SOC_SP7021 || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
     Selected by [y]:
     - PHY_SUNPLUS_USB [=y] && OF [=y] && (SOC_SP7021 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
