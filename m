Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61559AA4B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbiHTAzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiHTAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:55:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8591DFAE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660956921; x=1692492921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jQCFueG72K1/IsvlQP1m+Io0jjK+0RV4Mz5A/fOkDSw=;
  b=JNVLMWO46SLWINMCoAA/XBCQli/RHD3txPK53AMVr9A2PWAkbNUos8x8
   DIFM3y1kz5lwBs4bxCY1zAxD6NUGPsXUIypQSv9TOlTqnPSEYkjhbpDGH
   w2oQ863CIeCk4Zt8L9arfh6UaICoM3gpbc0usHwLEYBuoKcQDjVLo0TJO
   4m3qrNs7MKnFkZZ6THdyTXMVBpaTqv1QQ1kat9xKzyh9yS6slT/DjBc7/
   aP6yyXZP47sERO1wR79528XzQChRZdKZPzWRprS3+4FQM5z+RuAxyrtqm
   O7LTbFhdlu8lREWcJ1FD7PPQWB7ZiiU5cyV7P+IV3Nu0uc7EcABIff5Ue
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="293920871"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="293920871"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 17:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="676626196"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2022 17:55:18 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPCli-0001yD-0U;
        Sat, 20 Aug 2022 00:55:18 +0000
Date:   Sat, 20 Aug 2022 08:54:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 13/36]
 arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for function
 'tdx_mmio_readq'
Message-ID: <202208200846.ns0LqPhB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/coco/tdx/tdx.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 0cf382195475412201e134e2925bb276445a8460 [13/36] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220820/202208200846.ns0LqPhB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/0cf382195475412201e134e2925bb276445a8460
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 0cf382195475412201e134e2925bb276445a8460
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for function 'tdx_write_msr' [-Wmissing-prototypes]
   void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
                ^
   arch/x86/coco/tdx/tdx.c:298:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   ^
   static 
>> arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for function 'tdx_mmio_readq' [-Wmissing-prototypes]
   unsigned long tdx_mmio_readq(void __iomem* addr)
                 ^
   arch/x86/coco/tdx/tdx.c:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long tdx_mmio_readq(void __iomem* addr)
   ^
   static 
   2 warnings generated.


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
