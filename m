Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8F49DAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiA0Gks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:40:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:27408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbiA0Gkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643265646; x=1674801646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UJZ92gRwFjIrh0Y3dn9NkNka8TYkZ0m1wkY6LYNxTp4=;
  b=L/8hdIDVtLxle911dXwMifw8kmU63UvBuTsme0AF/z+1clyweWQKPJBK
   9SSpqnnkelZc5LDqx7Yq74BNY5E62wNvw6h3IuFvpMFwQ7W0TRb7YJm2O
   aHa2V6p0eiDJlTmKhX8lgV/zzkqD2XT5TzDdLn6rla1LU6q8v58Y1edmJ
   rS1ISV6/L6plpO6LHAtdNCXsaRl78+NGxPKn9d9XjsjJMPjxDezbjxubO
   GBzBFeQP5YQ/uskNnd580W/Eb101rQwxLIioW39yOFIjASQgvU675YRWv
   Xdbr8XXscADirPvYbO90ywB4CsbzI1AI3/PAM7wr9YyILa09CbtPxL/2O
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310078996"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="310078996"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="477755215"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 22:40:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCySZ-000MEV-Fj; Thu, 27 Jan 2022 06:40:43 +0000
Date:   Thu, 27 Jan 2022 14:40:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 3280/5866] drivers/hwtracing/coresight/coresight-etm4x-core.c:118:5:
 warning: no previous prototype for 'ete_sysreg_read'
Message-ID: <202201271425.6ykSQC3p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   52cdd137fae0b001197a51646289e3cbdda921d5
commit: 82ce4a8af88d25d3f75de6e8437de3d2f049cac3 [3280/5866] FROMLIST: coresight: ete: Add support for ETE sysreg access
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201271425.6ykSQC3p-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
