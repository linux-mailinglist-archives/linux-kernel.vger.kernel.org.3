Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14C5876A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiHBF2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHBF2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:28:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064C53C8DF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659418102; x=1690954102;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3jKsZEsHt9f7xx//V9WSIWMT3u5ZRt9o9caIaBtky8Q=;
  b=RqeywncEBcExiHdnOGt8a7bDGQ0TXzqnZFHbh3071Ytdq+Olaf3taYK4
   nWzRGleQENnJIqRL672jpBYLxP6RO+gDth6taIhFMsZ6fGDcrcwV7ZnJA
   VMspmHIT/WeJZ1FjvA+md4Bjv12CZ8V2Shcb54148s4yccEE+8LRcDviW
   gV1bMbK/18ILzvjm5I/8zqhwH4DwTWnGJFz+7gKGk6cV0rvXr1aq7yXIA
   D+eIirm70wVSX7iqYgug+alNIFRZt8oQaM/0WrZ2Ct3Sy+uoxGbcjSfA/
   ojnmnFBrvdh/jm0d+PM5KtuOKpDJIWuOT/ZRhceD+qjmO+v+ObCuq43sg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290098778"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="290098778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 22:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="661472792"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 22:28:06 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIkRp-000Fj5-0b;
        Tue, 02 Aug 2022 05:28:05 +0000
Date:   Tue, 2 Aug 2022 13:27:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [thermal:thermal/linux-next 66/68]
 drivers/thermal/samsung/exynos_tmu.c:1002:26: error: initialization of 'int
 (*)(struct thermal_zone_device *, int)' from incompatible pointer type 'int
 (*)(struct thermal_zone *, int)'
Message-ID: <202208021355.EjfjgbFl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/linux-next
head:   340682c9ef87a4e56051c5b20cf2d5f99dec4ce1
commit: 59e5178d0fe913197fe4f5353ee7d788539abc57 [66/68] thermal/drivers/samsung: Switch to new of thermal API
config: sparc64-randconfig-r032-20220801 (https://download.01.org/0day-ci/archive/20220802/202208021355.EjfjgbFl-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?id=59e5178d0fe913197fe4f5353ee7d788539abc57
        git remote add thermal git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
        git fetch --no-tags thermal thermal/linux-next
        git checkout 59e5178d0fe913197fe4f5353ee7d788539abc57
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/thermal/samsung/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/thermal/samsung/exynos_tmu.c:753:44: warning: 'struct thermal_zone' declared inside parameter list will not be visible outside of this definition or declaration
     753 | static int exynos_tmu_set_emulation(struct thermal_zone *tz, int temp)
         |                                            ^~~~~~~~~~~~
>> drivers/thermal/samsung/exynos_tmu.c:1002:26: error: initialization of 'int (*)(struct thermal_zone_device *, int)' from incompatible pointer type 'int (*)(struct thermal_zone *, int)' [-Werror=incompatible-pointer-types]
    1002 |         .set_emul_temp = exynos_tmu_set_emulation,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/samsung/exynos_tmu.c:1002:26: note: (near initialization for 'exynos_sensor_ops.set_emul_temp')
   cc1: some warnings being treated as errors


vim +1002 drivers/thermal/samsung/exynos_tmu.c

cebe7373a7e659d Amit Daniel Kachhap 2013-06-24   999  
59e5178d0fe9131 Daniel Lezcano      2022-08-01  1000  static const struct thermal_zone_device_ops exynos_sensor_ops = {
3b6a1a805f34247 Lukasz Majewski     2015-01-23  1001  	.get_temp = exynos_get_temp,
3b6a1a805f34247 Lukasz Majewski     2015-01-23 @1002  	.set_emul_temp = exynos_tmu_set_emulation,
3b6a1a805f34247 Lukasz Majewski     2015-01-23  1003  };
3b6a1a805f34247 Lukasz Majewski     2015-01-23  1004  

:::::: The code at line 1002 was first introduced by commit
:::::: 3b6a1a805f342472a0e68e2a0eb1decaadf7fa02 thermal: samsung: core: Exynos TMU rework to use device tree for configuration

:::::: TO: Lukasz Majewski <l.majewski@samsung.com>
:::::: CC: Eduardo Valentin <edubezval@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
