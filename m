Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C094AE783
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbiBIDC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355043AbiBIC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:58:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4804AC0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644375504; x=1675911504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7k2feXY7Ta35bFj7td4XrK9xId7RM3/gFTXfzgZzAnU=;
  b=K9357VBamjvvxUfoNv7PpiR1r8tFetG7KXXgh5yYHHf+2boCmXbBtKI9
   GJdUGi1uhDQYO6+le1e6GlgwFQCIsm5TYqL/TkcByTibFOZ5dt1Yr7/zY
   mZMGWDKk6JOAkR2dzH9tvzWFots1Db0OA+d1d0I4G56jAn4uK/FpHuEZ/
   8k7/bC7UANDVYmK8KLB0SHDBBNRnnZ+DAwApmYBnpCGx/TAlV5rLGU1Ji
   Kcy0GGVzEfurart+OU+l7PEbSWBkt0n/ZZrQwkQ0d+3O7z3msRwdGcK2W
   HxsKP2RnMdYF/vBWf3yV5NqgZGvDp4qTM0peGcpw5CFcnGAquUruQ77HP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="246691644"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="246691644"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="525800696"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2022 18:58:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHdBW-00017z-1T; Wed, 09 Feb 2022 02:58:22 +0000
Date:   Wed, 9 Feb 2022 10:58:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 21/141]
 arch/x86/include/asm/tdx_host.h:60:35: warning: 'struct tdsysinfo_struct'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202202091001.FUPeNVtq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   58f28b2fcc73d05d6a5a9f70a8fdacefa99acb85
commit: 13dd0fa9c0ba8880c196a8feecd826f4c16b18f8 [21/141] x86/cpu: make init_tdx() system wide info about TDX module
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220209/202202091001.FUPeNVtq-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/13dd0fa9c0ba8880c196a8feecd826f4c16b18f8
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 13dd0fa9c0ba8880c196a8feecd826f4c16b18f8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/cpu/intel.c:30:
>> arch/x86/include/asm/tdx_host.h:60:35: warning: 'struct tdsysinfo_struct' declared inside parameter list will not be visible outside of this definition or declaration
      60 | static inline int init_tdx(struct tdsysinfo_struct *r) { return -ENODEV; }
         |                                   ^~~~~~~~~~~~~~~~


vim +60 arch/x86/include/asm/tdx_host.h

    53	
    54	void detect_tdx_keyids(struct cpuinfo_x86 *c);
    55	int detect_tdx(void);
    56	int init_tdx(struct tdsysinfo_struct *r);
    57	#else
    58	static inline void detect_tdx_keyids(struct cpuinfo_x86 *c) { }
    59	static inline int detect_tdx(void) { return -ENODEV; }
  > 60	static inline int init_tdx(struct tdsysinfo_struct *r) { return -ENODEV; }
    61	#endif /* CONFIG_INTEL_TDX_HOST */
    62	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
