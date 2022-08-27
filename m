Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544C5A371D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiH0K6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH0K6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:58:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD08A6DB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661597926; x=1693133926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wN9xsmFVwLCstqiqyFXXlK0qP6XUkjS6D9tu2gae3lI=;
  b=ekuk9M36+S46h4gQwccJj94EZz5ZmQjTV9jJstV0H/L2G17RJUnMRn2w
   NoRNu4rPG5D3i1o3gWIuvfhf19BsB2M8opSLioMbTMzQrypBpa4iG2eli
   M0vzWWMOQbAb10a4Cumk2eWquXlnTq1iil/MNQN6QAysrTOERZSHc2F3V
   L0rfgcfvgWdFKf0Vc5wI0uRaK5dYmT7vajJdPOeXBlBh7cMY+pet/6sQt
   3HWcIr5Edup7UlnqzPloqotDfjFyjKTPxyaIEQg2QdrVzpBk66mRPIxSV
   MndWudC1DL97gNVHOxIsrfS4SHYqfNoEHICO/5/bQIaPJ7lB67Vcdfeeh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295925536"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="295925536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 03:58:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="640367081"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 03:58:45 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRtWW-00006t-12;
        Sat, 27 Aug 2022 10:58:44 +0000
Date:   Sat, 27 Aug 2022 18:58:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 13/36]
 arch/x86/coco/tdx/tdx.c:531:15: sparse: sparse: symbol 'tdx_mmio_readq' was
 not declared. Should it be static?
Message-ID: <202208271821.QFK7WLzo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 0cf382195475412201e134e2925bb276445a8460 [13/36] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220827/202208271821.QFK7WLzo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/0cf382195475412201e134e2925bb276445a8460
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 0cf382195475412201e134e2925bb276445a8460
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/x86/coco/tdx/tdx.c:298:14: sparse: sparse: symbol 'tdx_write_msr' was not declared. Should it be static?
>> arch/x86/coco/tdx/tdx.c:531:15: sparse: sparse: symbol 'tdx_mmio_readq' was not declared. Should it be static?

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
