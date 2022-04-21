Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF550A9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392341AbiDUU2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392320AbiDUU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:28:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382240A2C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650572746; x=1682108746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FYYzJZzfaIjWKITlVmYza/shkm39C6ztxFFIrYwFKzk=;
  b=mTPZmSyuHNiK4udZ1XtYpZBN4gh9J1bfvmbSmK+cPeEXVkelcBVOiubR
   L0Iq0GTjHpsY6la2dT8eYoB/kCadHmbLxKaeFT3oNgX+lliNNuYVTL5VY
   g/uXJn7ThSqxqrqYG7PwXdkdsa9ClYP5cLdDi/n47sdAfnVEyXPQkX4mQ
   FtwHUCK3DevNtCR43zEFCuEUSFE5Y42XtDe8jMyJai1Lk4hVRgx1TrJPP
   r8FFlW4dQHMMAPX5WfUdsX5z/YQU29fgMwjVcxi8X3j8Zv4K2vtvjJ3mQ
   4htX3FgmUwaX7HMZvmFAPfKy2B4mLrTQOe0gEDvJTNcARDgm3nNCznDnL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263319200"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="263319200"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 13:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="728170133"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2022 13:25:44 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhdN1-0008kl-Ef;
        Thu, 21 Apr 2022 20:25:43 +0000
Date:   Fri, 22 Apr 2022 04:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/base/topology.c:158:52: error: no member named 'ppin' in
 'struct cpuinfo_mips'
Message-ID: <202204220441.m1i9vjYa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220422-002853/Luck-Tony/topology-sysfs-Fix-allnoconfig-build-breakage/20220421-235053
head:   8aad1c48b8885d9febd55ecbc5915032cfe857bc
commit: 8aad1c48b8885d9febd55ecbc5915032cfe857bc topology/sysfs: Fix allnoconfig build breakage.
date:   4 hours ago
config: mips-randconfig-r025-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220441.m1i9vjYa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8aad1c48b8885d9febd55ecbc5915032cfe857bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220422-002853/Luck-Tony/topology-sysfs-Fix-allnoconfig-build-breakage/20220421-235053
        git checkout 8aad1c48b8885d9febd55ecbc5915032cfe857bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/topology.c:158:52: error: no member named 'ppin' in 'struct cpuinfo_mips'
           if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
                                               ~~~~~~~~~~~~~ ^
   1 error generated.


vim +158 drivers/base/topology.c

   154	
   155	static umode_t topology_is_visible(struct kobject *kobj,
   156					   struct attribute *attr, int unused)
   157	{
 > 158		if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
   159			return 0;
   160	
   161		return attr->mode;
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
