Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9D84DD3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 05:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiCRES3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 00:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiCRESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 00:18:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C7118EEAE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647577025; x=1679113025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2MxLCCYcRMZsv9nSvPUgSb/KtDdbPIPTc7PZ1d97GB8=;
  b=keQ8Eg2fNggk0jKvsV7tCk+op9ROmQb19yA5OIpUjEhZmu1WQlSIETSc
   mJZ929bpA27xNh9L/XEScuBs7MoRZ+isJnVdXxM8XXDpI/7h3wxqdfHpy
   /glcdB4IWrTy90x4L6IOJjuBFTb43GLwXaL35G+xC+Zul4b7ymkPvV6A5
   HQkJkXksofdm4ot0slUe5pEx1lOFOcM2/CqU1ZL6DAJ2j1Xjb52Ox4v3J
   6jTV4lfIQRbhHPpger+2k1WrrspVvppWiMyAprt1sVpYgTeYWAkk7VtCa
   74xM4A+8NTvqlXkn2abYD/8iq62QajBV2iZtsqPcPcbk/MDiRcREpsmD8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343478504"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="343478504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 21:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="517030987"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 21:17:03 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV42w-000EQ1-My; Fri, 18 Mar 2022 04:17:02 +0000
Date:   Fri, 18 Mar 2022 12:16:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:asahi 28/174] include/linux/soc/apple/rtkit.h:223:5:
 warning: no previous prototype for 'apple_rtkit_poll'
Message-ID: <202203181210.tL0yqraP-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux asahi
head:   c1fcb91bbcc8fd1b1f874e45f55cbba682351f3c
commit: 73ad3599aa16b102655fbd9aa1576ae3c63466a3 [28/174] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: powerpc-randconfig-m031-20220318 (https://download.01.org/0day-ci/archive/20220318/202203181210.tL0yqraP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/73ad3599aa16b102655fbd9aa1576ae3c63466a3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 73ad3599aa16b102655fbd9aa1576ae3c63466a3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/apple.c:32:
>> include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for 'apple_rtkit_poll' [-Wmissing-prototypes]
     223 | int apple_rtkit_poll(struct apple_rtkit *rtk)
         |     ^~~~~~~~~~~~~~~~


vim +/apple_rtkit_poll +223 include/linux/soc/apple/rtkit.h

b0aec24ea7a8e79 Hector Martin 2022-02-08  222  
16b8a4a8997d359 Hector Martin 2022-02-08 @223  int apple_rtkit_poll(struct apple_rtkit *rtk)
16b8a4a8997d359 Hector Martin 2022-02-08  224  {
16b8a4a8997d359 Hector Martin 2022-02-08  225  	return -ENODEV;
16b8a4a8997d359 Hector Martin 2022-02-08  226  }
16b8a4a8997d359 Hector Martin 2022-02-08  227  

:::::: The code at line 223 was first introduced by commit
:::::: 16b8a4a8997d359639caf9b641cea8466e68c717 soc: apple: rtkit: Add recv_message_early callback and apple_rtkit_poll

:::::: TO: Hector Martin <marcan@marcan.st>
:::::: CC: Hector Martin <marcan@marcan.st>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
