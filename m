Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE14DB420
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiCPPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356167AbiCPPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:08:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542CF3A72D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647443258; x=1678979258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1G1Qa2YuwOj9sRe1KimdamuLexuSMptHANTErh9OC80=;
  b=T6nOfl+YUYTxl30yPN8U2f/MWlmzmmspnp7WMTRz4sZ4BTHMFTCylN2l
   vzfDk+scOv5OVhCTJrdUqmML6V56b6CQSBYuMM04dI2dSGp7noK8a9CFz
   IJNavCpXIfjgCiQIUWzK+fKHBUGXW4ZsJ2MNk7tjEQC7CbWF1hDq6OZDk
   Gaz4NCMUTneFUStSNCCeUm7Vv3svrycvevFuC4tIDq0cDj8H5QWNMfi/s
   yfiqqMTMX+Po3Uox7oRYdv9c8rg9CXxLAir9/+wA3oLj5/S15pIn+lVrJ
   mz4wdq/+igsLR0l1QDjumi/Wfp/UfMuH940px1yLEN+POAiOWqMW5MShW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="343057057"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="343057057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="690611035"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2022 08:01:05 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUV96-000CWr-Tf; Wed, 16 Mar 2022 15:01:04 +0000
Date:   Wed, 16 Mar 2022 23:00:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: powerpc64le-linux-ld: warning: orphan section `.stubs' from
 `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
Message-ID: <202203162206.gSuxBqLN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56e337f2cf1326323844927a04e9dbce9a244835
commit: a1867f85e06edacd82956d3422caa2b9074f4321 mfd: Add Renesas Synchronization Management Unit (SMU) support
date:   8 months ago
config: powerpc64-randconfig-r036-20220316 (https://download.01.org/0day-ci/archive/20220316/202203162206.gSuxBqLN-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1867f85e06edacd82956d3422caa2b9074f4321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1867f85e06edacd82956d3422caa2b9074f4321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
