Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD54B99D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiBQH1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:27:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiBQH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:27:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628032A0D56
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645082837; x=1676618837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oYRBuw5HsK9HF1K5n9Z3Vf4OSxxcpndsyK0hbjom6hM=;
  b=L64gVS3Vx9lJ2aaMELT2egazvJ51/YwwUUkft2L7u8+GL4vJVTT2KsZo
   MytE9zBbrO98WByQry6N2WPdTrrWVYYApMEcKNHzVPn/OQjPXa+mpAFmF
   7pfzp6xYWvvMI+B/voPDAuK7GBX6RibbnVyA2fbLc4CcZZzv5PZF98Fi4
   umtl4jh/rI4G76wW75CjfLxGgtcRVOuPqsayXWar+1/Cl3KCc6ME+r6KP
   GrO8cizeRWX1VmiRZBG5/44sQ5vQ+Nj4HuJN6fOtO/xel8vfN+1SC2KtW
   51wkFdG2/H/yJnr9yJD0rAQyOJ/3o/SAiJSDjgZrHqDOePtDKE4VJ6GNp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231437386"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="231437386"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="681841992"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2022 23:27:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKbBv-000BZH-E2; Thu, 17 Feb 2022 07:27:03 +0000
Date:   Thu, 17 Feb 2022 15:26:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     yipechai <YiPeng.Chai@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: [agd5f:drm-next 17/66]
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:7: warning: variable 'ras_obj'
 is used uninitialized whenever '||' condition is true
Message-ID: <202202171534.A4Lb31Xv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   5bbebaae14913a4180ff0cc7ddccfa177dba9705
commit: 563285c85ecaa1fcecf304dabf87cbeee1ddbc3f [17/66] drm/amdgpu: Merge amdgpu_ras_late_init/amdgpu_ras_late_fini to amdgpu_ras_block_late_init/amdgpu_ras_block_late_fini
config: s390-randconfig-r003-20220216 (https://download.01.org/0day-ci/archive/20220217/202202171534.A4Lb31Xv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 563285c85ecaa1fcecf304dabf87cbeee1ddbc3f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:32:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:32:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:32:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:7: warning: variable 'ras_obj' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (adev->in_suspend || amdgpu_in_reset(adev)) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2453:6: note: uninitialized use occurs here
           if (ras_obj->ras_cb)
               ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:3: note: remove the 'if' if its condition is always false
                   if (adev->in_suspend || amdgpu_in_reset(adev)) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:7: warning: variable 'ras_obj' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
                   if (adev->in_suspend || amdgpu_in_reset(adev)) {
                       ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2453:6: note: uninitialized use occurs here
           if (ras_obj->ras_cb)
               ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:7: note: remove the '||' if its condition is always false
                   if (adev->in_suspend || amdgpu_in_reset(adev)) {
                       ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2403:41: note: initialize the variable 'ras_obj' to silence this warning
           struct amdgpu_ras_block_object *ras_obj;
                                                  ^
                                                   = NULL
   14 warnings generated.


vim +2416 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c

e43488493cbb46 Tao Zhou      2021-09-17  2398  
b293e891b05701 Hawking Zhang 2019-08-30  2399  /* helper function to handle common stuff in ip late init phase */
563285c85ecaa1 yipechai      2022-02-09  2400  int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
563285c85ecaa1 yipechai      2022-02-09  2401  			 struct ras_common_if *ras_block)
b293e891b05701 Hawking Zhang 2019-08-30  2402  {
563285c85ecaa1 yipechai      2022-02-09  2403  	struct amdgpu_ras_block_object *ras_obj;
05adfd80cc52e0 Luben Tuikov  2021-05-21  2404  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
05adfd80cc52e0 Luben Tuikov  2021-05-21  2405  	unsigned long ue_count, ce_count;
b293e891b05701 Hawking Zhang 2019-08-30  2406  	int r;
b293e891b05701 Hawking Zhang 2019-08-30  2407  
b293e891b05701 Hawking Zhang 2019-08-30  2408  	/* disable RAS feature per IP block if it is not supported */
b293e891b05701 Hawking Zhang 2019-08-30  2409  	if (!amdgpu_ras_is_supported(adev, ras_block->block)) {
b293e891b05701 Hawking Zhang 2019-08-30  2410  		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
b293e891b05701 Hawking Zhang 2019-08-30  2411  		return 0;
b293e891b05701 Hawking Zhang 2019-08-30  2412  	}
b293e891b05701 Hawking Zhang 2019-08-30  2413  
b293e891b05701 Hawking Zhang 2019-08-30  2414  	r = amdgpu_ras_feature_enable_on_boot(adev, ras_block, 1);
b293e891b05701 Hawking Zhang 2019-08-30  2415  	if (r) {
9080a18fc554ce Candice Li    2021-09-15 @2416  		if (adev->in_suspend || amdgpu_in_reset(adev)) {
b293e891b05701 Hawking Zhang 2019-08-30  2417  			/* in resume phase, if fail to enable ras,
b293e891b05701 Hawking Zhang 2019-08-30  2418  			 * clean up all ras fs nodes, and disable ras */
b293e891b05701 Hawking Zhang 2019-08-30  2419  			goto cleanup;
b293e891b05701 Hawking Zhang 2019-08-30  2420  		} else
b293e891b05701 Hawking Zhang 2019-08-30  2421  			return r;
b293e891b05701 Hawking Zhang 2019-08-30  2422  	}
b293e891b05701 Hawking Zhang 2019-08-30  2423  
134d16d50f0948 John Clements 2021-03-25  2424  	/* check for errors on warm reset edc persisant supported ASIC */
134d16d50f0948 John Clements 2021-03-25  2425  	amdgpu_persistent_edc_harvesting(adev, ras_block);
134d16d50f0948 John Clements 2021-03-25  2426  
b293e891b05701 Hawking Zhang 2019-08-30  2427  	/* in resume phase, no need to create ras fs node */
53b3f8f40e6cff Dennis Li     2020-08-19  2428  	if (adev->in_suspend || amdgpu_in_reset(adev))
b293e891b05701 Hawking Zhang 2019-08-30  2429  		return 0;
b293e891b05701 Hawking Zhang 2019-08-30  2430  
563285c85ecaa1 yipechai      2022-02-09  2431  	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
563285c85ecaa1 yipechai      2022-02-09  2432  	if (ras_obj->ras_cb) {
9252d33df597a6 yipechai      2022-02-09  2433  		r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
b293e891b05701 Hawking Zhang 2019-08-30  2434  		if (r)
b293e891b05701 Hawking Zhang 2019-08-30  2435  			goto interrupt;
b293e891b05701 Hawking Zhang 2019-08-30  2436  	}
b293e891b05701 Hawking Zhang 2019-08-30  2437  
9252d33df597a6 yipechai      2022-02-09  2438  	r = amdgpu_ras_sysfs_create(adev, ras_block);
b293e891b05701 Hawking Zhang 2019-08-30  2439  	if (r)
b293e891b05701 Hawking Zhang 2019-08-30  2440  		goto sysfs;
b293e891b05701 Hawking Zhang 2019-08-30  2441  
05adfd80cc52e0 Luben Tuikov  2021-05-21  2442  	/* Those are the cached values at init.
05adfd80cc52e0 Luben Tuikov  2021-05-21  2443  	 */
4d9f771e111ee0 Luben Tuikov  2021-07-02  2444  	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) == 0) {
05adfd80cc52e0 Luben Tuikov  2021-05-21  2445  		atomic_set(&con->ras_ce_count, ce_count);
05adfd80cc52e0 Luben Tuikov  2021-05-21  2446  		atomic_set(&con->ras_ue_count, ue_count);
4d9f771e111ee0 Luben Tuikov  2021-07-02  2447  	}
05adfd80cc52e0 Luben Tuikov  2021-05-21  2448  
b293e891b05701 Hawking Zhang 2019-08-30  2449  	return 0;
b293e891b05701 Hawking Zhang 2019-08-30  2450  cleanup:
b293e891b05701 Hawking Zhang 2019-08-30  2451  	amdgpu_ras_sysfs_remove(adev, ras_block);
b293e891b05701 Hawking Zhang 2019-08-30  2452  sysfs:
563285c85ecaa1 yipechai      2022-02-09  2453  	if (ras_obj->ras_cb)
9252d33df597a6 yipechai      2022-02-09  2454  		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
b293e891b05701 Hawking Zhang 2019-08-30  2455  interrupt:
b293e891b05701 Hawking Zhang 2019-08-30  2456  	amdgpu_ras_feature_enable(adev, ras_block, 0);
b293e891b05701 Hawking Zhang 2019-08-30  2457  	return r;
b293e891b05701 Hawking Zhang 2019-08-30  2458  }
b293e891b05701 Hawking Zhang 2019-08-30  2459  

:::::: The code at line 2416 was first introduced by commit
:::::: 9080a18fc554cea0858fae6692a7003c5f0365fc drm/amdgpu: Remove all code paths under the EAGAIN path in RAS late init

:::::: TO: Candice Li <candice.li@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
