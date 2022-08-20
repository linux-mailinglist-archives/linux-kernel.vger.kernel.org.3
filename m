Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1739959A9F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbiHTAOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244923AbiHTAOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:14:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427D5F10A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660954458; x=1692490458;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iSU5B286wvSIq0QHjmGxNjuVlvWHlra8gctAd4LAcHA=;
  b=bwE40cctzfR1jynJlUd20gjxGtjginR4JiJImmwu7CxInrwZ6uqQHa/w
   f9J7Ar+bI/qllfCVI4EsULE2+w1fsCOSlUXbJs+jN59HUM3KgmPusjX9t
   kd5/G5OfdESOGNe/cxjBmfzFHMWXrBlYIcJI+j3JzsFbnx2iqwt2svjOn
   11rowto9j4Y0K+mlId1INwSCax/4QMWXMyWqmLBicTibdtJDU/obgf7Ze
   jObz1fmDkYIqlQmOEovnPBykrUmWUZb3DhxPAVd0DeZM0m3EfixGPo8DA
   aBf15qjHN/vJTitw3vabNOwNUQR1zTzvzl/DnadoT33t18EU48F+OylLt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="276161358"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="276161358"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 17:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="936397589"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2022 17:14:16 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPC80-0001wZ-0s;
        Sat, 20 Aug 2022 00:14:16 +0000
Date:   Sat, 20 Aug 2022 08:13:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 13/36]
 arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for
 'tdx_mmio_readq'
Message-ID: <202208200852.sY5wUNQo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/coco/tdx/tdx.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 0cf382195475412201e134e2925bb276445a8460 [13/36] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220820/202208200852.sY5wUNQo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/0cf382195475412201e134e2925bb276445a8460
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 0cf382195475412201e134e2925bb276445a8460
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     298 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~
>> arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for 'tdx_mmio_readq' [-Wmissing-prototypes]
     531 | unsigned long tdx_mmio_readq(void __iomem* addr)
         |               ^~~~~~~~~~~~~~


vim +/tdx_mmio_readq +531 arch/x86/coco/tdx/tdx.c

   530	
 > 531	unsigned long tdx_mmio_readq(void __iomem* addr)
   532	{
   533		unsigned long val;
   534	
   535		if (tdx_virt_mmio(8, false, (unsigned long)addr, &val))
   536			return 0xffffffffffffffff;
   537		return val;
   538	}
   539	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
