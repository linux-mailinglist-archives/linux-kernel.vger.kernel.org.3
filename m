Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EB50A916
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbiDUT1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiDUT11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:27:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383D4CD61
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650569077; x=1682105077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dwpA2y5/Mr4NohdMef1IfUlBRaIig6iVEFzC/QrYRZE=;
  b=MuqSlY/rTuWxo5U/qOxh14ZatVT7iCrmEbDFE5Ts5Ecp1+YfaPHL7zKT
   1VhC78UaxFZw7MZoc3IVJRNl05MpAkQ/FDPCrov96U9N8ACRNu+sy7lQl
   ryZ1MwCI6SZwHbDpdI68SCMhLlRueGPyUmHzJot2IDmoUeAt+uOfh3zzB
   2kZNfWLV+G4mkFGzhAOEIoAHTEwl9P7ueLXDmVjxR1owg5x+Qe7+i3uGH
   xcY19iYhD+gNlcSGqn89UjxhrtYhUqBpTyJGm0luq1ptpnIm+TGr2OKR4
   zgLleRfo+qA1/PSsA7Bbc4q4x17J7CF4ZQR0qwgjd5dm+sdgZ95r7o1gj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262057544"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="262057544"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 12:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="671191934"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 12:24:35 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhcPq-0008hr-Jp;
        Thu, 21 Apr 2022 19:24:34 +0000
Date:   Fri, 22 Apr 2022 03:24:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/base/topology.c:158:45: error: 'boot_cpu_data' undeclared;
 did you mean 'boot_cpu_init'?
Message-ID: <202204220317.dri1BV0q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220422-002853/Luck-Tony/topology-sysfs-Fix-allnoconfig-build-breakage/20220421-235053
head:   8aad1c48b8885d9febd55ecbc5915032cfe857bc
commit: 8aad1c48b8885d9febd55ecbc5915032cfe857bc topology/sysfs: Fix allnoconfig build breakage.
date:   3 hours ago
config: microblaze-randconfig-r022-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220317.dri1BV0q-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8aad1c48b8885d9febd55ecbc5915032cfe857bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220422-002853/Luck-Tony/topology-sysfs-Fix-allnoconfig-build-breakage/20220421-235053
        git checkout 8aad1c48b8885d9febd55ecbc5915032cfe857bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from ./arch/microblaze/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from drivers/base/topology.c:11:
   drivers/base/topology.c: In function 'topology_is_visible':
>> drivers/base/topology.c:158:45: error: 'boot_cpu_data' undeclared (first use in this function); did you mean 'boot_cpu_init'?
     158 |         if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
         |                                             ^~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/base/topology.c:158:9: note: in expansion of macro 'if'
     158 |         if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
         |         ^~
   drivers/base/topology.c:158:45: note: each undeclared identifier is reported only once for each function it appears in
     158 |         if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
         |                                             ^~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/base/topology.c:158:9: note: in expansion of macro 'if'
     158 |         if (attr == &dev_attr_ppin.attr && !boot_cpu_data.ppin)
         |         ^~


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
