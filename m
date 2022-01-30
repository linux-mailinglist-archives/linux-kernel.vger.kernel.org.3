Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAED4A32C6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353471AbiA3ATR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:19:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:46569 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237062AbiA3ATN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643501953; x=1675037953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RMLtXCrrnl0r0X3V3Z5LNdqAk4LiJSv63hxZt/wDrms=;
  b=RQ6Kc1fmel5hGeOPcHxgeh5Pzm9XLf5+/MiJU0LNHFYQMCkoZH/ZcuTT
   z1D3i4aX0ciVl1tw5I7k1+wyD50r1BV3CEhgFqDDT3Y0EwnFXog//nGIq
   9BO6TqarbFSz/y9X2Djya4Vr8MCZKRm6fXY238m4XiNJRbV1onGCfgT/u
   /dfeuh99N7VcFpo5xS/h6ExbqqT3aVZSLfeJy0AvMg/FegDbLivtUUT1m
   BrdopA7AshJ0GOoV1V1insdh/t0g7FeZE/LKmBd61f/MQkqYj2RnlYE/A
   5cutDIilVKLNMpqc2BlND0dOmtYG73Ury3IHgD9hO98B5S3nDP2FXCGow
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="227279237"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="227279237"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 16:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="768231364"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2022 16:19:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDxvx-000Pnu-2I; Sun, 30 Jan 2022 00:19:09 +0000
Date:   Sun, 30 Jan 2022 08:19:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 3280/5869] drivers/hwtracing/coresight/coresight-etm4x-core.c:118:5:
 warning: no previous prototype for function 'ete_sysreg_read'
Message-ID: <202201300813.TO5y2Xbm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   94a36a1374e79fb3aa3539f8b99aa110fdc7b7a0
commit: 82ce4a8af88d25d3f75de6e8437de3d2f049cac3 [3280/5869] FROMLIST: coresight: ete: Add support for ETE sysreg access
config: arm64-buildonly-randconfig-r006-20220130 (https://download.01.org/0day-ci/archive/20220130/202201300813.TO5y2Xbm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
