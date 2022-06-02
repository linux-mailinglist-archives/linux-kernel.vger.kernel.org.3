Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C194E53B892
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiFBMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiFBMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:02:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684FEA8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654171346; x=1685707346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TesyJ3a5vi+Ne4ngaTWX9TvJ0deEipl3mdqT/hu1DN0=;
  b=h+GhJf/X0Xe4Dl4dwYqPjx3RgKDprbJXxGUTuPmbct3T7dCK+UX48593
   tNPJIUpl1PJe+S3vBWnmT7H5s9v5y6Y+Be6N71tVIx+WzxML2/iLjrhXu
   5uCmK3y9k8tQm7fSy0arTwyqY90ajjahk2J8Buf5K3nVIGalrb9bXkXxw
   dStUW0SCFjPJJF6XKFA3z3cjFnrS3N9xG9iWWsqv0xxBgVyppQxt+h5J7
   Tq2nLJmkBnOVxPfFgW3O7KH/tiHnI1IY7f+AiKv97J3BjWJ+K4yvSCw79
   UDMDTxA+7oXsstXpRguJyQXarzntUBDz0lad+vvBbQn6Wa0AYc0y//H7W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="336584386"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="336584386"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="721275416"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2022 05:02:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwjWy-00052f-6x;
        Thu, 02 Jun 2022 12:02:24 +0000
Date:   Thu, 2 Jun 2022 20:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Shych <michaelsh@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: drivers/platform/mellanox/nvsw-sn2201.c:329:42: sparse: sparse:
 symbol 'nvsw_sn2201_i2c_data' was not declared. Should it be static?
Message-ID: <202206021946.HcEMyEHG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1dc87763f406d4e67caf16dbe438a5647692395
commit: 662f24826f954d49d56211822bcd7b3109287961 platform/mellanox: Add support for new SN2201 system
date:   3 weeks ago
config: s390-randconfig-s031-20220602 (https://download.01.org/0day-ci/archive/20220602/202206021946.HcEMyEHG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=662f24826f954d49d56211822bcd7b3109287961
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 662f24826f954d49d56211822bcd7b3109287961
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/platform/mellanox/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/mellanox/nvsw-sn2201.c:329:42: sparse: sparse: symbol 'nvsw_sn2201_i2c_data' was not declared. Should it be static?

vim +/nvsw_sn2201_i2c_data +329 drivers/platform/mellanox/nvsw-sn2201.c

   327	
   328	/* SN2201 I2C platform data. */
 > 329	struct mlxreg_core_hotplug_platform_data nvsw_sn2201_i2c_data = {
   330		.irq = NVSW_SN2201_CPLD_SYSIRQ,
   331	};
   332	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
