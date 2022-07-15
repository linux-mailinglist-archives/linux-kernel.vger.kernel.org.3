Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B243C575948
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiGOB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiGOB4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:56:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9279E3334A;
        Thu, 14 Jul 2022 18:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657850168; x=1689386168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rR8IPq1mihslAZhmwuShlj9puubtP4c7sMcs9BiPYsw=;
  b=IRa4MsvSPXZx5/9BU08+V3QhFku14cGz3HMl+qFdagXnYmdS331hGB49
   pN0EOcrnILddrkjgR5dvAPZH+HeaMUPRVV/VHxBOeIL3qD1d66Pf1IuvV
   cPEGW8D8TwF8O+efPdiyJHM1VDUD+UWoB97vlGCv5nX2Ukh2hVqgU0d9I
   1dMqq9DvttjWjbOy0Kdoz/kzfqFAmOUECFDKXF0ze/sdFvD3R2QvJ2nQ8
   xnIU6I2VulK05eWlpG/J71cWx5xvg7ZrfvtBdmbXRm5kLpnd9Qk/IYFpS
   I3HA8yAMTgJ+hzAi/8bAVOlq20QpG6CAfVQpIMS6O0OwYn3rBQBURth0K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349642815"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="349642815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628924596"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2022 18:55:57 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCAYe-0001Pl-Dk;
        Fri, 15 Jul 2022 01:55:56 +0000
Date:   Fri, 15 Jul 2022 09:55:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:guest-filter 8/28] htmldocs:
 Documentation/admin-guide/tainted-kernels.rst:82: WARNING: Malformed table.
Message-ID: <202207150911.eR0W0c9D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-filter
head:   0a555e67b143701a81612d819e693cf5786de418
commit: 7acbe4e1dcfb9db6c9a886734802ebb13b091e2c [8/28] Add taint flag for TDX overrides
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/tainted-kernels.rst:82: WARNING: Malformed table.

vim +82 Documentation/admin-guide/tainted-kernels.rst

896dd323abbf6a Thorsten Leemhuis         2019-01-08   81  
896dd323abbf6a Thorsten Leemhuis         2019-01-08  @82  ===  ===  ======  ========================================================
896dd323abbf6a Thorsten Leemhuis         2019-01-08   83  Bit  Log  Number  Reason that got the kernel tainted
896dd323abbf6a Thorsten Leemhuis         2019-01-08   84  ===  ===  ======  ========================================================
896dd323abbf6a Thorsten Leemhuis         2019-01-08   85    0  G/P       1  proprietary module was loaded
896dd323abbf6a Thorsten Leemhuis         2019-01-08   86    1  _/F       2  module was force loaded
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02   87    2  _/S       4  kernel running on an out of specification system
896dd323abbf6a Thorsten Leemhuis         2019-01-08   88    3  _/R       8  module was force unloaded
896dd323abbf6a Thorsten Leemhuis         2019-01-08   89    4  _/M      16  processor reported a Machine Check Exception (MCE)
896dd323abbf6a Thorsten Leemhuis         2019-01-08   90    5  _/B      32  bad page referenced or some unexpected page flags
896dd323abbf6a Thorsten Leemhuis         2019-01-08   91    6  _/U      64  taint requested by userspace application
896dd323abbf6a Thorsten Leemhuis         2019-01-08   92    7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
896dd323abbf6a Thorsten Leemhuis         2019-01-08   93    8  _/A     256  ACPI table overridden by user
896dd323abbf6a Thorsten Leemhuis         2019-01-08   94    9  _/W     512  kernel issued warning
896dd323abbf6a Thorsten Leemhuis         2019-01-08   95   10  _/C    1024  staging driver was loaded
896dd323abbf6a Thorsten Leemhuis         2019-01-08   96   11  _/I    2048  workaround for bug in platform firmware applied
896dd323abbf6a Thorsten Leemhuis         2019-01-08   97   12  _/O    4096  externally-built ("out-of-tree") module was loaded
896dd323abbf6a Thorsten Leemhuis         2019-01-08   98   13  _/E    8192  unsigned module was loaded
896dd323abbf6a Thorsten Leemhuis         2019-01-08   99   14  _/L   16384  soft lockup occurred
896dd323abbf6a Thorsten Leemhuis         2019-01-08  100   15  _/K   32768  kernel has been live patched
896dd323abbf6a Thorsten Leemhuis         2019-01-08  101   16  _/X   65536  auxiliary taint, defined for and used by distros
896dd323abbf6a Thorsten Leemhuis         2019-01-08  102   17  _/T  131072  kernel was built with the struct randomization plugin
7acbe4e1dcfb9d Andi Kleen                2021-07-14  103   18  _/Y  262144  confidential guest (like TDX guest) without full lockdown
7acbe4e1dcfb9d Andi Kleen                2021-07-14  104  ===  ===  ======  =========================================================
896dd323abbf6a Thorsten Leemhuis         2019-01-08  105  

:::::: The code at line 82 was first introduced by commit
:::::: 896dd323abbf6a9980d8aca2656b6c4bf5352c3b docs: Revamp tainted-kernels.rst to make it more comprehensible

:::::: TO: Thorsten Leemhuis <linux@leemhuis.info>
:::::: CC: Jonathan Corbet <corbet@lwn.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
