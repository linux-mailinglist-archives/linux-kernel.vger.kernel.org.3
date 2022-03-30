Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B964EB7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiC3BRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiC3BRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:17:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50744BFCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648602939; x=1680138939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uw3QPbfkSvOGkeRUPgMIPEZEG6KqyZe9J9f0TJchJXM=;
  b=lraApc3z7qD3z6eSlnrXonn3GlFYh9HA5MYWsKlQcmbAzuNxDlBlOe4A
   zd2iocQ9dOO2OccbovMNblhtIJ5bzf3auf/L2K2kdyk70el1/pLaBXH0n
   jKwY+HxLK5QZx+OoE9E76yBBRPu2ZOgEA8zuXylHCzBbMVAMgIkty96O1
   wkbGCv2pXYcLJD+UwH0ttlsLRGaccF0iGww7GdVYHxi0QCKkGgnWMK4/f
   uA/z0TIFZ97IlG+4NVXDieb3KfO34Ilxd6UWdX+r6pUeam1Wnk14XHxk6
   aMao6CMGki7LkbSFB/mZWQcGZToy+IpSvzUMeNruPxc8bUMB+UOAW0ICQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322599309"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322599309"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="836107212"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2022 18:15:36 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZMvv-0000qF-Ox; Wed, 30 Mar 2022 01:15:35 +0000
Date:   Wed, 30 Mar 2022 09:15:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 3280/5872] drivers/hwtracing/coresight/coresight-etm4x-core.c:118:5:
 warning: no previous prototype for function 'ete_sysreg_read'
Message-ID: <202203300915.vUQ47LCW-lkp@intel.com>
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
head:   b60d55f33484d855a546f7cfc59a28a5771e8bee
commit: 82ce4a8af88d25d3f75de6e8437de3d2f049cac3 [3280/5872] FROMLIST: coresight: ete: Add support for ETE sysreg access
config: arm64-randconfig-r036-20220327 (https://download.01.org/0day-ci/archive/20220330/202203300915.vUQ47LCW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/82ce4a8af88d25d3f75de6e8437de3d2f049cac3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 82ce4a8af88d25d3f75de6e8437de3d2f049cac3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm4x-core.c:118:5: warning: no previous prototype for function 'ete_sysreg_read' [-Wmissing-prototypes]
   u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
       ^
   drivers/hwtracing/coresight/coresight-etm4x-core.c:118:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
   ^
   static 
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:135:6: warning: no previous prototype for function 'ete_sysreg_write' [-Wmissing-prototypes]
   void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
        ^
   drivers/hwtracing/coresight/coresight-etm4x-core.c:135:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
   ^
   static 
   2 warnings generated.


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
