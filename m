Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5244EB73D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbiC2X4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiC2X4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:56:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617D10BA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648598075; x=1680134075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nZCupvGOMdRKGS2B/ZmHcaF82OaDndyuxV8JykzLiVw=;
  b=maAsw2cicMvMCKKh2OI4SQk/wH455XdWX1+g7YxgEroh1ridAkRP5l59
   smmp0pDKnE7sm6jy+JA2r4TeBX22GYOj8BNRWzWHeC43DJQDttFiP9Ft4
   8QZ/trk4bLCMoYWHtPp/oaWVIhlZxB1Qh4Bfe1MrZcZjCB1C7+Df2b7FR
   U/tYTXkZmGoSiDCwv8uMpJb/1BktoLTfhdiAi4CuOzMSf+wdv2SVQSTGU
   Lnk1hV+AHnfDUgCBZP8rjOud8WzkifCiPX/z/bl3h3j5vp8M6yOoQ8Ck9
   eHDeDu8HNAZqgovfvokqthMDBPvqT9A5/FxU53jnuRoiaR+WX1k4fq3vf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322587264"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="322587264"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 16:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="585792390"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2022 16:54:33 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZLfU-0000me-9D; Tue, 29 Mar 2022 23:54:32 +0000
Date:   Wed, 30 Mar 2022 07:53:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 3280/5872] drivers/hwtracing/coresight/coresight-etm4x-core.c:118:5:
 warning: no previous prototype for 'ete_sysreg_read'
Message-ID: <202203300748.xYUXZJT9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: 82ce4a8af88d25d3f75de6e8437de3d2f049cac3 [3280/5872] FROMLIST: coresight: ete: Add support for ETE sysreg access
config: arm64-randconfig-r015-20220329 (https://download.01.org/0day-ci/archive/20220330/202203300748.xYUXZJT9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/82ce4a8af88d25d3f75de6e8437de3d2f049cac3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 82ce4a8af88d25d3f75de6e8437de3d2f049cac3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm4x-core.c:118:5: warning: no previous prototype for 'ete_sysreg_read' [-Wmissing-prototypes]
     118 | u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
         |     ^~~~~~~~~~~~~~~
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:135:6: warning: no previous prototype for 'ete_sysreg_write' [-Wmissing-prototypes]
     135 | void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
         |      ^~~~~~~~~~~~~~~~


vim +/ete_sysreg_read +118 drivers/hwtracing/coresight/coresight-etm4x-core.c

   117	
 > 118	u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
   119	{
   120		u64 res = 0;
   121	
   122		switch (offset) {
   123		ETE_READ_CASES(res)
   124		default :
   125			pr_warn_ratelimited("ete: trying to read unsupported register @%x\n",
   126					    offset);
   127		}
   128	
   129		if (!_relaxed)
   130			__iormb(res);	/* Imitate the !relaxed I/O helpers */
   131	
   132		return res;
   133	}
   134	
 > 135	void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
   136	{
   137		if (!_relaxed)
   138			__iowmb();	/* Imitate the !relaxed I/O helpers */
   139		if (!_64bit)
   140			val &= GENMASK(31, 0);
   141	
   142		switch (offset) {
   143		ETE_WRITE_CASES(val)
   144		default :
   145			pr_warn_ratelimited("ete: trying to write to unsupported register @%x\n",
   146					    offset);
   147		}
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
