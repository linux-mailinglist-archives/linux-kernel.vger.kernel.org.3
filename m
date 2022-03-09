Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414B4D2D18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiCIK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiCIK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:28:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A78156C69
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646821625; x=1678357625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1RtcjiPKars0DUovoo5BiTa0g/dRvTO5f8Y5QaVXTDA=;
  b=DZei64nOxFAn8JF/yCa9ycr1TzYKcCr0p9sDo2Jy5VZqZ4UHidLWKwIP
   aAWTTrlaG5LlMdvh+8JJkNh7rCrV37lsuhZ2R/kX24oAOcrz/LVpYUzs+
   ijmzzYBP1olTAZtGNnwBr5RXw4ElvhcbMRZeo3ZVQlznA++Y+AEyqfIPI
   XfFLwmaT2hHlabIZ8yFgIU9fZHygfD2QmIKObux4KxiqyDr8gYKa8zfKC
   0lzPd10XfWSpDPa7wQlckraVWF5+pMl8sJ3PwdzpYofh8gfN0TrtaxZGr
   11uDipJTGiOvVKAYn25+tv97c+rSvzTwbne2r3F0m8W9uxtg0d7QzvgSB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341371223"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="341371223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 02:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="711894688"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 02:27:03 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRtX5-00035Z-1m; Wed, 09 Mar 2022 10:27:03 +0000
Date:   Wed, 9 Mar 2022 18:26:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [intel-tdx:kvm 24/193] arch/x86/kernel/cpu/tsx.c:186:5: warning: no
 previous prototype for 'tsx_ctrl_clear'
Message-ID: <202203091850.dfwae6UT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm
head:   7a7d51d52f45bbd82e264c7f940d74491305f5ce
commit: 2c9aac7eef8430d99ae51f243da09dd7892dc9cd [24/193] x86/cpu/tsx: Add helper functions to save/restore IA32_TSX_CTRL MSR
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220309/202203091850.dfwae6UT-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/2c9aac7eef8430d99ae51f243da09dd7892dc9cd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm
        git checkout 2c9aac7eef8430d99ae51f243da09dd7892dc9cd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/tsx.c:186:5: warning: no previous prototype for 'tsx_ctrl_clear' [-Wmissing-prototypes]
     186 | u64 tsx_ctrl_clear(void)
         |     ^~~~~~~~~~~~~~
>> arch/x86/kernel/cpu/tsx.c:199:6: warning: no previous prototype for 'tsx_ctrl_restore' [-Wmissing-prototypes]
     199 | void tsx_ctrl_restore(u64 tsx_ctrl)
         |      ^~~~~~~~~~~~~~~~


vim +/tsx_ctrl_clear +186 arch/x86/kernel/cpu/tsx.c

   184	
   185	/* Clear the MSR_TSX_CTRL and return the old value if supported */
 > 186	u64 tsx_ctrl_clear(void)
   187	{
   188		u64 tsx_ctrl = 0;
   189	
   190		if (ia32_tsx_ctrl_supported) {
   191			rdmsrl(MSR_IA32_TSX_CTRL, tsx_ctrl);
   192			if (tsx_ctrl & MSR_TSX_CTRL_MASK)
   193				wrmsrl(MSR_IA32_TSX_CTRL, tsx_ctrl & ~MSR_TSX_CTRL_MASK);
   194		}
   195		return tsx_ctrl;
   196	}
   197	EXPORT_SYMBOL_GPL(tsx_ctrl_clear);
   198	
 > 199	void tsx_ctrl_restore(u64 tsx_ctrl)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
