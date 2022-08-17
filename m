Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC132597A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbiHQX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiHQX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:27:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4E9A98C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660778862; x=1692314862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bF8RhQapM9aMltjQD5Fv7KZEqa5L4QRLLLTgNQOxoOc=;
  b=GBYfqUb11Rd4dC/GTx0UtTlgcm0aelnwXUqrp6Wswh2laNQpJBewzk3B
   uO7E3JTr/9Z8uuk4fJJU0+CyvFrGQ7CWngfK+I2hD9va+JI7eeGSWuCrE
   +Ji9RVyZr2zmgZWauAmyVryrQNe6bgH+uvVXHzqVWz/jTkQXMzaYbc1kP
   66Yf/MO8rBbo75NRkdQUCjD8cD0v4V1s5CC9OVtjvmPH1sN1zX+T/u8G+
   QNcRKkFOXzjzMI+gQDfJmmnPVaY0OAp1UqWFEOWuoRxLU2nFuZFIKnxwp
   nJQF9ukSXG35gNU9snqvqCk5Xzhg7MLIIzdCZUjoMgwwPgk0P7eAWcOp6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293900116"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="293900116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="636575820"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 16:27:41 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOSRo-0001TF-1g;
        Wed, 17 Aug 2022 23:27:40 +0000
Date:   Thu, 18 Aug 2022 07:27:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [rppt:crash-kernel/arm64-remap/v0.1 4/5] arch/arm64/mm/init.c:133:3:
 error: use of undeclared identifier 'crashkres_protection_possible'
Message-ID: <202208180702.BgAbSr7d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git crash-kernel/arm64-remap/v0.1
head:   083629d699170f5a86078d0a7afbe647c3a571cb
commit: 3aaa4a222ab056611236c4c42499d24c8317bc96 [4/5] arm64/mm: remap crash kernel with base pages even if rodata_full disabled
config: arm64-randconfig-r034-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180702.BgAbSr7d-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=3aaa4a222ab056611236c4c42499d24c8317bc96
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt crash-kernel/arm64-remap/v0.1
        git checkout 3aaa4a222ab056611236c4c42499d24c8317bc96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/mm/init.c:133:3: error: use of undeclared identifier 'crashkres_protection_possible'
                   crashkres_protection_possible = true;
                   ^
   arch/arm64/mm/init.c:151:2: error: use of undeclared identifier 'crashkres_protection_possible'
           crashkres_protection_possible = true;
           ^
   2 errors generated.


vim +/crashkres_protection_possible +133 arch/arm64/mm/init.c

   119	
   120	static unsigned long long __init
   121	reserve_remap_crashkernel(unsigned long long crash_base,
   122				  unsigned long long crash_size,
   123				  unsigned long long crash_max)
   124	{
   125		unsigned long long size;
   126	
   127		/*
   128		 * If linear map uses base pages or there is no ZONE_DMA/ZONE_DMA32
   129		 * the crashk_res will be mapped with PTEs in mmu::map_mem()
   130		 */
   131		if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE) ||
   132		    !have_zone_dma()) {
 > 133			crashkres_protection_possible = true;
   134			return 0;
   135		}
   136	
   137		if (crash_base)
   138			return 0;
   139	
   140		size = ALIGN(crash_size, PUD_SIZE);
   141	
   142		crash_base = memblock_phys_alloc_range(size, PUD_SIZE, 0, crash_max);
   143		if (!crash_base)
   144			return 0;
   145	
   146		if (remap_crashkernel(crash_base, crash_size, size)) {
   147			memblock_phys_free(crash_base, size);
   148			return 0;
   149		}
   150	
   151		crashkres_protection_possible = true;
   152		memblock_phys_free(crash_base + crash_size, size - crash_size);
   153	
   154		return crash_base;
   155	}
   156	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
