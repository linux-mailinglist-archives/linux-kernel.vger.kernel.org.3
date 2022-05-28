Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD1536946
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355207AbiE1AB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiE1ABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:01:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C3473B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 17:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653696083; x=1685232083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7v3jG27wAN4KIYP8MWL5vK19QbDLe+bpbG4rhQJc1Yc=;
  b=fu+LyMMq9OUThPzKJXI3oFMbEMT9rw88e/u01RleGcGMd5YUkhVxqPqo
   3ugpwFOZAFWWC/fOh5J5SWprKWs7tEJK3qogwKNdwY/LZmsSQnqUQ9OCH
   e9lpOMQErZ4jmfnzXzgljbACryzhs30YdFSL4JWQ50JhDceDT6sQZSy8u
   8uk4So/HErqiLJoDWJNRqptCFEAlC3aEoc4Q7UYJ2F0YCkJH1Oj5YZXuB
   mllAXbAPQUF5eIqEuU9iDu8beZof+UndMWVhFHsXM7uo+NJQC5aliBCE6
   Qq2ANinQyc4+n7R+OoTAJfsdVWp15bKghZ6CFo/9pCArQNl8mA201cXTZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274327443"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274327443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 17:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="561024527"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2022 17:01:20 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nujtP-0005En-Iq;
        Sat, 28 May 2022 00:01:19 +0000
Date:   Sat, 28 May 2022 08:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous
 prototype for function 'gfx_v11_0_rlc_stop'
Message-ID: <202205280743.SW6RoSnw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hawking,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf272460d744112bacd4c4d562592decbf0edf64
commit: 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073 drm/amdgpu: add init support for GFX11 (v2)
date:   3 weeks ago
config: s390-randconfig-r044-20220525 (https://download.01.org/0day-ci/archive/20220528/202205280743.SW6RoSnw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d879e81f0f9ed5d33b5eda0fe5226c884bb8073
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:27:
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
   In file included from drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:27:
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
   In file included from drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:27:
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
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:362:6: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (ring->is_mes_queue) {
               ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:419:30: note: uninitialized use occurs here
           amdgpu_device_wb_free(adev, index);
                                       ^~~~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:362:2: note: remove the 'if' if its condition is always false
           if (ring->is_mes_queue) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:350:16: note: initialize the variable 'index' to silence this warning
           unsigned index;
                         ^
                          = 0
>> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous prototype for function 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes]
   void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:8: error: use of undeclared identifier 'CP_RB0_CNTL__BUF_SWAP_MASK'
           tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
                 ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1180:18: note: expanded from macro 'REG_SET_FIELD'
           (((orig_val) & ~REG_FIELD_MASK(reg, field)) |                   \
                           ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1177:36: note: expanded from macro 'REG_FIELD_MASK'
   #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
                                      ^
   <scratch space>:95:1: note: expanded from here
   CP_RB0_CNTL__BUF_SWAP_MASK
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:8: error: use of undeclared identifier 'CP_RB0_CNTL__BUF_SWAP__SHIFT'
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1181:49: note: expanded from macro 'REG_SET_FIELD'
            (REG_FIELD_MASK(reg, field) & ((field_val) << REG_FIELD_SHIFT(reg, field))))
                                                          ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1176:37: note: expanded from macro 'REG_FIELD_SHIFT'
   #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
                                       ^
   <scratch space>:101:1: note: expanded from here
   CP_RB0_CNTL__BUF_SWAP__SHIFT
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:8: error: use of undeclared identifier 'CP_RB0_CNTL__BUF_SWAP_MASK'
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1181:4: note: expanded from macro 'REG_SET_FIELD'
            (REG_FIELD_MASK(reg, field) & ((field_val) << REG_FIELD_SHIFT(reg, field))))
             ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1177:36: note: expanded from macro 'REG_FIELD_MASK'
   #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
                                      ^
   <scratch space>:98:1: note: expanded from here
   CP_RB0_CNTL__BUF_SWAP_MASK
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:8: error: use of undeclared identifier 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK'
           tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
                 ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1180:18: note: expanded from macro 'REG_SET_FIELD'
           (((orig_val) & ~REG_FIELD_MASK(reg, field)) |                   \
                           ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1177:36: note: expanded from macro 'REG_FIELD_MASK'
   #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
                                      ^
   <scratch space>:83:1: note: expanded from here
   CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:8: error: use of undeclared identifier 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP__SHIFT'
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1181:49: note: expanded from macro 'REG_SET_FIELD'
            (REG_FIELD_MASK(reg, field) & ((field_val) << REG_FIELD_SHIFT(reg, field))))
                                                          ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1176:37: note: expanded from macro 'REG_FIELD_SHIFT'
   #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
                                       ^
   <scratch space>:89:1: note: expanded from here
   CP_HQD_PQ_CONTROL__ENDIAN_SWAP__SHIFT
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:8: error: use of undeclared identifier 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK'
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1181:4: note: expanded from macro 'REG_SET_FIELD'
            (REG_FIELD_MASK(reg, field) & ((field_val) << REG_FIELD_SHIFT(reg, field))))
             ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1177:36: note: expanded from macro 'REG_FIELD_MASK'
   #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
                                      ^
   <scratch space>:86:1: note: expanded from here
   CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK
   ^
   14 warnings and 6 errors generated.


vim +/gfx_v11_0_rlc_stop +1945 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

  1944	
> 1945	void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
  1946	{
  1947		u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
  1948	
  1949		tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
  1950		WREG32_SOC15(GC, 0, regRLC_CNTL, tmp);
  1951	}
  1952	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
