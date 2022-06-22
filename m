Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7655460C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbiFVKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbiFVKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:07:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72413E04
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655892464; x=1687428464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cc/TCIsEYW1PMEk9yJmil6X0x14+wRVccmqBRFmtOWA=;
  b=AzoHLHPFyCci0ruSquXLql0rjmgDALnqvsfMtI5NYuLPvvJtGxgInPaP
   H61EsVMBFvtr3+7V69sBS1/XeBCJU+zILpOnpMdvi+E2ZjpbxHPdA9tIG
   eKtA4iiDUCNWzwiqtmRCCwQk6Y3qc0i1/oTxYoemPgnZDt2E+da3mMn4z
   F4A0c/N6iCx0MvGC2PFd3yOqbbXR3sWe9Zh6tOIGZ0Fv+l8UQ3pJ9xWFo
   X3gZh7xoYeQNGBJcIaVKKKqGZO/upAWKpCrEBx9SjedvNITzPc+FtCUcE
   GR7MECn7H93kRaz3UuIBHfceuWHYAzrQVgBMuCCh8XUsmTaPWjoyAFSjM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="342061012"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342061012"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834035083"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 03:07:42 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3xGv-00017Z-PR;
        Wed, 22 Jun 2022 10:07:41 +0000
Date:   Wed, 22 Jun 2022 18:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ruijing Dong <ruijing.dong@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 224/274]
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:333:6: warning: no previous
 prototype for function 'amdgpu_vcn_using_unified_queue'
Message-ID: <202206221801.KxFJ3e97-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   eec53143b7fe1ccaace434e03b5959c9117bf9c5
commit: 4ed49c954e35559cb4a34ba049a15f54ec7fccf6 [224/274] drm/amdgpu/vcn: add unified queue ib test
config: s390-buildonly-randconfig-r004-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221801.KxFJ3e97-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 4ed49c954e35559cb4a34ba049a15f54ec7fccf6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/panfrost/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:29:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:29:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:29:
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
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:333:6: warning: no previous prototype for function 'amdgpu_vcn_using_unified_queue' [-Wmissing-prototypes]
   bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
        ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:333:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
   ^
   static 
   13 warnings generated.


vim +/amdgpu_vcn_using_unified_queue +333 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c

   331	
   332	/* from vcn4 and above, only unified queue is used */
 > 333	bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
   334	{
   335		struct amdgpu_device *adev = ring->adev;
   336		bool ret = false;
   337	
   338		if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0))
   339			ret = true;
   340	
   341		return ret;
   342	}
   343	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
