Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5646C078
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhLGQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:16:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:46025 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhLGQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:16:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237418822"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237418822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 08:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="600217848"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2021 08:12:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mud4Z-000Ml5-8M; Tue, 07 Dec 2021 16:12:07 +0000
Date:   Wed, 8 Dec 2021 00:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gaurav Kashyap <quic_gaurkash@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [fscrypt:wip-wrapped-keys 7/13]
 drivers/soc/qcom/qti-ice-hwkm.c:111:16: error: expected declaration
 specifiers or '...' before string constant
Message-ID: <202112080049.6zargMrt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git wip-wrapped-keys
head:   542d99089e0c7a68b7743697390dafa96f4960b1
commit: 832a5757ce98f0f3e739ffaa6434bf8e8cdc5e0a [7/13] soc: qcom: add HWKM library for storage encryption
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080049.6zargMrt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git/commit/?id=832a5757ce98f0f3e739ffaa6434bf8e8cdc5e0a
        git remote add fscrypt https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
        git fetch --no-tags fscrypt wip-wrapped-keys
        git checkout 832a5757ce98f0f3e739ffaa6434bf8e8cdc5e0a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

      64 |                 qti_ice_hwkm_writel(mmio->ice_hwkm_mmio, 0x7,
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/swab.h:5,
                    from arch/arm/include/asm/opcodes.h:86,
                    from arch/arm/include/asm/bug.h:7,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from arch/arm/include/asm/current.h:50,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/qti-ice-common.h:10,
                    from drivers/soc/qcom/qti-ice-hwkm.c:8:
   drivers/soc/qcom/qti-ice-hwkm.c:80:35: error: 'const struct ice_mmio_data' has no member named 'ice_hwkm_mmio'; did you mean 'ice_mmio'?
      80 |         qti_ice_hwkm_clearb(mmio->ice_hwkm_mmio, QTI_HWKM_ICE_RG_TZ_KM_CTL,
         |                                   ^~~~~~~~~~~~~
   include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-regs.h:239:10: note: in expansion of macro 'readl_relaxed'
     239 |         (readl_relaxed(hwkm_mmio + (reg)))
         |          ^~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-regs.h:248:19: note: in expansion of macro 'qti_ice_hwkm_readl'
     248 |         u32 val = qti_ice_hwkm_readl(hwkm_mmio, reg);   \
         |                   ^~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-hwkm.c:80:9: note: in expansion of macro 'qti_ice_hwkm_clearb'
      80 |         qti_ice_hwkm_clearb(mmio->ice_hwkm_mmio, QTI_HWKM_ICE_RG_TZ_KM_CTL,
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from drivers/soc/qcom/qti-ice-regs.h:9,
                    from drivers/soc/qcom/qti-ice-hwkm.c:9:
   drivers/soc/qcom/qti-ice-hwkm.c:80:35: error: 'const struct ice_mmio_data' has no member named 'ice_hwkm_mmio'; did you mean 'ice_mmio'?
      80 |         qti_ice_hwkm_clearb(mmio->ice_hwkm_mmio, QTI_HWKM_ICE_RG_TZ_KM_CTL,
         |                                   ^~~~~~~~~~~~~
   arch/arm/include/asm/io.h:300:75: note: in definition of macro 'writel_relaxed'
     300 | #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
         |                                                                           ^
   drivers/soc/qcom/qti-ice-regs.h:250:9: note: in expansion of macro 'qti_ice_hwkm_writel'
     250 |         qti_ice_hwkm_writel(hwkm_mmio, val, reg);       \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-hwkm.c:80:9: note: in expansion of macro 'qti_ice_hwkm_clearb'
      80 |         qti_ice_hwkm_clearb(mmio->ice_hwkm_mmio, QTI_HWKM_ICE_RG_TZ_KM_CTL,
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/swab.h:5,
                    from arch/arm/include/asm/opcodes.h:86,
                    from arch/arm/include/asm/bug.h:7,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from arch/arm/include/asm/current.h:50,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/qti-ice-common.h:10,
                    from drivers/soc/qcom/qti-ice-hwkm.c:8:
   drivers/soc/qcom/qti-ice-hwkm.c:84:33: error: 'const struct ice_mmio_data' has no member named 'ice_hwkm_mmio'; did you mean 'ice_mmio'?
      84 |         qti_ice_hwkm_setb(mmio->ice_hwkm_mmio,
         |                                 ^~~~~~~~~~~~~
   include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-regs.h:239:10: note: in expansion of macro 'readl_relaxed'
     239 |         (readl_relaxed(hwkm_mmio + (reg)))
         |          ^~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-regs.h:243:19: note: in expansion of macro 'qti_ice_hwkm_readl'
     243 |         u32 val = qti_ice_hwkm_readl(hwkm_mmio, reg);   \
         |                   ^~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-hwkm.c:84:9: note: in expansion of macro 'qti_ice_hwkm_setb'
      84 |         qti_ice_hwkm_setb(mmio->ice_hwkm_mmio,
         |         ^~~~~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from drivers/soc/qcom/qti-ice-regs.h:9,
                    from drivers/soc/qcom/qti-ice-hwkm.c:9:
   drivers/soc/qcom/qti-ice-hwkm.c:84:33: error: 'const struct ice_mmio_data' has no member named 'ice_hwkm_mmio'; did you mean 'ice_mmio'?
      84 |         qti_ice_hwkm_setb(mmio->ice_hwkm_mmio,
         |                                 ^~~~~~~~~~~~~
   arch/arm/include/asm/io.h:300:75: note: in definition of macro 'writel_relaxed'
     300 | #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
         |                                                                           ^
   drivers/soc/qcom/qti-ice-regs.h:245:9: note: in expansion of macro 'qti_ice_hwkm_writel'
     245 |         qti_ice_hwkm_writel(hwkm_mmio, val, reg);       \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-hwkm.c:84:9: note: in expansion of macro 'qti_ice_hwkm_setb'
      84 |         qti_ice_hwkm_setb(mmio->ice_hwkm_mmio,
         |         ^~~~~~~~~~~~~~~~~
   drivers/soc/qcom/qti-ice-hwkm.c: In function 'qti_ice_hwkm_init':
   drivers/soc/qcom/qti-ice-hwkm.c:104:20: error: 'const struct ice_mmio_data' has no member named 'ice_hwkm_mmio'; did you mean 'ice_mmio'?
     104 |         if (!mmio->ice_hwkm_mmio)
         |                    ^~~~~~~~~~~~~
         |                    ice_mmio
   drivers/soc/qcom/qti-ice-hwkm.c: At top level:
>> drivers/soc/qcom/qti-ice-hwkm.c:111:16: error: expected declaration specifiers or '...' before string constant
     111 | MODULE_LICENSE("GPL v2");
         |                ^~~~~~~~


vim +111 drivers/soc/qcom/qti-ice-hwkm.c

   110	
 > 111	MODULE_LICENSE("GPL v2");

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
