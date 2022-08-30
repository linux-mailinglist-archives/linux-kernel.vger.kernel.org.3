Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52CC5A6CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiH3TQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiH3TP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:15:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D65F11F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661886950; x=1693422950;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ydHkriF8LqwoMcaBcza5YRapw+wbJS6W52lmCva2B2Y=;
  b=fcnpaJcFDre7XEvwerteJ1n7AXPKGNvzqfnfOw/JQYZxKM8UFyw0QCNv
   Tx5iWmUpamh1yqa6b3sJukEq2sI5AgbxwJlaZQneP+JsF7c7Ldypz7Oup
   PUUVCanh/cuys3NI1B60a7PXnKXP281PdgmO9q2Lon9C+1EeY6EP8oHQP
   To15ajfq8jQCDIM6NwzFXYS0YpUlC/grxKNv/FSb/VTp9n84Le3pUSZ8e
   6ZlyWBi4Fr98sitZvHXvtU7htO6tP7d/0jrK4EE3DYbpvO0r0I5n1bYvo
   pfv1SQR1IJ1k9PhwhGVWzLZWBjUadtTtkQ/Uf+lXvp0kPs1avr4Ewxqr5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278296475"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="278296475"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 12:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="940158994"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2022 12:15:28 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT6hs-0000WI-0E;
        Tue, 30 Aug 2022 19:15:28 +0000
Date:   Wed, 31 Aug 2022 03:15:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/gpu/drm/ttm/ttm_bo_util.c:378:28: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202208310339.VpAPg7cT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mAkePtU51f9p4/31"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mAkePtU51f9p4/31
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   9 weeks ago
config: arm-randconfig-s052-20220830
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/ttm/ttm_bo_util.c:292:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:292:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:292:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:298:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:298:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:298:38: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/ttm/ttm_bo_util.c:378:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:378:28: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:378:28: sparse:     got void *virtual
--
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_rom *rom @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse:     expected struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_ram_header *ram_header @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse:     expected struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse:     got struct qxl_ram_header *ram_header
>> drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse:     got struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse:     got struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse:     got struct qxl_rom *rom
--
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *[assigned] emap @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     got void *[assigned] emap
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     expected void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     got void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map
--
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1424:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1424:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1424:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1464:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1464:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1464:20: sparse:     got void *[noderef] mmio
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1466:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1466:28: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1466:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1573:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] mmio @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1573:19: sparse:     expected void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1573:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1580:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] rscc @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1580:27: sparse:     expected void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1580:27: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1611:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1611:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1611:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1613:28: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1613:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@

vim +378 drivers/gpu/drm/ttm/ttm_bo_util.c

ba4e7d973dd09b Thomas Hellstrom 2009-06-10  371  
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  372  void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  373  {
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  374  	if (!map->virtual)
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  375  		return;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  376  	switch (map->bo_kmap_type) {
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  377  	case ttm_bo_map_iomap:
ba4e7d973dd09b Thomas Hellstrom 2009-06-10 @378  		iounmap(map->virtual);
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  379  		break;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  380  	case ttm_bo_map_vmap:
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  381  		vunmap(map->virtual);
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  382  		break;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  383  	case ttm_bo_map_kmap:
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  384  		kunmap(map->page);
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  385  		break;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  386  	case ttm_bo_map_premapped:
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  387  		break;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  388  	default:
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  389  		BUG();
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  390  	}
d3116756a710e3 Christian König  2021-04-12  391  	ttm_mem_io_free(map->bo->bdev, map->bo->resource);
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  392  	map->virtual = NULL;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  393  	map->page = NULL;
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  394  }
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  395  EXPORT_SYMBOL(ttm_bo_kunmap);
ba4e7d973dd09b Thomas Hellstrom 2009-06-10  396  

:::::: The code at line 378 was first introduced by commit
:::::: ba4e7d973dd09b66912ac4c0856add8b0703a997 drm: Add the TTM GPU memory manager subsystem.

:::::: TO: Thomas Hellstrom <thellstrom@vmware.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--mAkePtU51f9p4/31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 5.19.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="arm-linux-gnueabi-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_TIME_KUNIT_TEST=m

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_HAVE_UID16=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_FHANDLE is not set
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_ARM=y
CONFIG_ARM_HAS_SG_CHAIN=y
CONFIG_ARM_DMA_USE_IOMMU=y
CONFIG_ARM_DMA_IOMMU_ALIGNMENT=8
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_HAVE_PROC_CPU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
# CONFIG_ARM_PATCH_PHYS_VIRT is not set
CONFIG_NEED_MACH_MEMORY_H=y
CONFIG_PHYS_OFFSET=0x00000000
CONFIG_GENERIC_BUG=y
CONFIG_PGTABLE_LEVELS=2

#
# System Type
#
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=15
# CONFIG_ARCH_MULTIPLATFORM is not set
CONFIG_ARCH_FOOTBRIDGE=y
# CONFIG_ARCH_SA1100 is not set

#
# Footbridge Implementations
#
CONFIG_ARCH_CATS=y
# CONFIG_ARCH_EBSA285_ADDIN is not set
CONFIG_ARCH_EBSA285_HOST=y
# CONFIG_ARCH_NETWINDER is not set
# end of Footbridge Implementations

CONFIG_FOOTBRIDGE=y
CONFIG_FOOTBRIDGE_HOST=y
CONFIG_ARCH_EBSA285=y

#
# Processor Type
#
CONFIG_CPU_SA110=y
CONFIG_CPU_32v4=y
CONFIG_CPU_ABRT_EV4=y
CONFIG_CPU_PABRT_LEGACY=y
CONFIG_CPU_CACHE_V4WB=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_COPY_V4WB=y
CONFIG_CPU_TLB_V4WB=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y
CONFIG_CPU_USE_DOMAINS=y

#
# Processor Features
#
CONFIG_CPU_LITTLE_ENDIAN=y
# CONFIG_CPU_BIG_ENDIAN is not set
CONFIG_CPU_ICACHE_DISABLE=y
# CONFIG_CPU_DCACHE_DISABLE is not set
CONFIG_NEED_KUSER_HELPERS=y
CONFIG_KUSER_HELPERS=y
CONFIG_ARM_L1_CACHE_SHIFT=5
# end of System Type

#
# Bus support
#
CONFIG_ISA=y
CONFIG_ISA_DMA=y
CONFIG_ISA_DMA_API=y
# end of Bus support

#
# Kernel Features
#
CONFIG_IRQSTACKS=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
CONFIG_VMSPLIT_2G=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_ARCH_NR_GPIO=0
CONFIG_HZ_FIXED=0
# CONFIG_HZ_100 is not set
# CONFIG_HZ_200 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_500 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_AEABI=y
# CONFIG_OABI_COMPAT is not set
# CONFIG_HIGHMEM is not set
# CONFIG_CPU_SW_DOMAIN_PAN is not set
CONFIG_HW_PERF_EVENTS=y
CONFIG_ARM_MODULE_PLTS=y
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_ALIGNMENT_TRAP=y
# CONFIG_UACCESS_WITH_MEMCPY is not set
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
# end of Kernel Features

#
# Boot options
#
CONFIG_USE_OF=y
CONFIG_ATAGS=y
CONFIG_DEPRECATED_PARAM_STRUCT=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
# CONFIG_ARM_ATAG_DTB_COMPAT is not set
CONFIG_CMDLINE=""
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=y
CONFIG_EFI_STUB=y
CONFIG_EFI=y
CONFIG_DMI=y
# end of Boot options

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of CPU Power Management

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# end of Floating point emulation

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_APM_EMULATION=m
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_OF=y
# end of Power management options

# CONFIG_ARM_CRYPTO is not set
CONFIG_AS_VFP_VMRS_FPINST=y

#
# General architecture-dependent options
#
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_KEEPINITRD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_CPU_NO_EFFICIENT_FFS=y
CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
# CONFIG_STRICT_KERNEL_RWX is not set
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_HAVE_ARCH_PFN_VALID=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULE_COMPRESS_ZSTD=y
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=m
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_ELF_FDPIC is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_ARCH_HAS_BINFMT_FLAT=y
# CONFIG_BINFMT_FLAT is not set
CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_FLATMEM=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_RECLAIM=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_DIAG=m
# CONFIG_UNIX is not set
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XFRM_ESPINTCP=y
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_ESPINTCP=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=y
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=m
# CONFIG_DEFAULT_HTCP is not set
CONFIG_DEFAULT_HYBLA=y
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="hybla"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_SYSLOG=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_LABELS=y
# CONFIG_NF_CONNTRACK_FTP is not set
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_BROADCAST=y
CONFIG_NF_CONNTRACK_NETBIOS_NS=y
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_LOG=m
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_XFRM=m
# CONFIG_NFT_SOCKET is not set
CONFIG_NFT_TPROXY=m
# CONFIG_NF_FLOW_TABLE_INET is not set
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CONNSECMARK is not set
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
# CONFIG_NETFILTER_XT_TARGET_MASQUERADE is not set
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_STATE=y
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
# CONFIG_NFT_FIB_IPV4 is not set
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_RAW is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
# CONFIG_NFT_DUP_IPV6 is not set
CONFIG_NFT_FIB_IPV6=m
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_NF_CONNTRACK_BRIDGE=m
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_BPFILTER=y
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

# CONFIG_IP_SCTP is not set
CONFIG_RDS=y
# CONFIG_RDS_TCP is not set
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
# CONFIG_TIPC_DIAG is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
# CONFIG_COPS is not set
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
CONFIG_X25=y
CONFIG_LAPB=m
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=m
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_NET_NSH=y
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
CONFIG_SCC=y
CONFIG_SCC_DELAY=y
# CONFIG_SCC_TRXECHO is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=m
CONFIG_CAN_J1939=y
CONFIG_CAN_ISOTP=y

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
# CONFIG_BT_RFCOMM_TTY is not set
CONFIG_BT_BNEP=y
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
CONFIG_BT_HIDP=y
# CONFIG_BT_HS is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
# CONFIG_BT_DEBUGFS is not set
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
# CONFIG_BT_HCIUART_BCSP is not set
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_LL is not set
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
# CONFIG_BT_HCIUART_BCM is not set
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
# CONFIG_BT_QCOMSMD is not set
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
# CONFIG_NET_9P_VIRTIO is not set
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=m
CONFIG_NFC_VIRTUAL_NCI=m
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_PN532_UART=m
# CONFIG_NFC_MRVL_UART is not set
# CONFIG_NFC_ST_NCI_I2C is not set
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=m
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
# CONFIG_ETHTOOL_NETLINK is not set
# CONFIG_NETDEV_ADDR_LIST_TEST is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_QUIRKS is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_BRIDGE_EMUL=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_AARDVARK=y
# CONFIG_PCIE_XILINX_NWL is not set
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_IXP4XX=y
# CONFIG_PCI_TEGRA is not set
# CONFIG_PCI_RCAR_GEN2 is not set
# CONFIG_PCIE_RCAR_HOST is not set
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
# CONFIG_PCI_XGENE_MSI is not set
# CONFIG_PCI_V3_SEMI is not set
CONFIG_PCI_VERSATILE=y
CONFIG_PCIE_IPROC=m
# CONFIG_PCIE_IPROC_PLATFORM is not set
CONFIG_PCIE_IPROC_BCMA=m
# CONFIG_PCIE_IPROC_MSI is not set
CONFIG_PCIE_ALTERA=m
# CONFIG_PCIE_ALTERA_MSI is not set
# CONFIG_PCI_HOST_THUNDER_PEM is not set
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCIE_ROCKCHIP_HOST is not set
CONFIG_PCIE_MEDIATEK=y
CONFIG_PCIE_MEDIATEK_GEN3=y
# CONFIG_PCIE_BRCMSTB is not set
# CONFIG_PCIE_MICROCHIP_HOST is not set
CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR=0xfffff000
CONFIG_PCIE_APPLE=m
# CONFIG_PCIE_MT7621 is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCI_DRA7XX_HOST is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCI_EXYNOS=y
CONFIG_PCI_IMX6=y
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
CONFIG_PCI_LAYERSCAPE=y
CONFIG_PCI_HISI=y
# CONFIG_PCIE_QCOM is not set
CONFIG_PCIE_ARMADA_8K=y
CONFIG_PCIE_ARTPEC6=y
CONFIG_PCIE_ARTPEC6_HOST=y
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
CONFIG_PCIE_INTEL_GW=y
# CONFIG_PCIE_KEEMBAY_HOST is not set
CONFIG_PCIE_KIRIN=y
CONFIG_PCIE_HISI_STB=y
# CONFIG_PCI_MESON is not set
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
# CONFIG_PCIE_VISCONTI_HOST is not set
# CONFIG_PCIE_UNIPHIER is not set
CONFIG_PCIE_AL=y
CONFIG_PCIE_FU740=y
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
CONFIG_PCIE_MOBIVEIL_PLAT=y
CONFIG_PCIE_LAYERSCAPE_GEN4=y
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
# CONFIG_YENTA_ENE_TUNE is not set
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_I82365=m
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
# CONFIG_OMAP_CF is not set
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=m
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
CONFIG_BRCMSTB_GISB_ARB=y
CONFIG_BT1_APB=y
# CONFIG_BT1_AXI is not set
CONFIG_HISILICON_LPC=y
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_VEXPRESS_CONFIG=m
# CONFIG_FSL_MC_BUS is not set
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=m
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_ARM_SCPI_POWER_DOMAIN=m
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_TURRIS_MOX_RWTM=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_CS_DSP=m
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
CONFIG_GOOGLE_VPD=y

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB=y
# CONFIG_EFI_ARMSTUB_DTB_LOADER is not set
# CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is not set
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=y
CONFIG_RESET_ATTACK_MITIGATION=y
# CONFIG_EFI_RCI2_TABLE is not set
CONFIG_EFI_DISABLE_PCI_DMA=y
CONFIG_EFI_DISABLE_RUNTIME=y
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=m
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_BCM63XX_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_PARSER_IMAGETAG=m
CONFIG_MTD_AFS_PARTS=m
CONFIG_MTD_PARSER_TRX=m
CONFIG_MTD_SHARPSL_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SC520CDP=m
# CONFIG_MTD_NETSC520 is not set
CONFIG_MTD_TS5500=m
# CONFIG_MTD_DC21285 is not set
# CONFIG_MTD_IMPA7 is not set
CONFIG_MTD_PCI=m
# CONFIG_MTD_PCMCIA is not set
CONFIG_MTD_INTEL_VR_NOR=m
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SPEAR_SMI=m
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OMAP2 is not set
CONFIG_MTD_ONENAND_SAMSUNG=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
CONFIG_MTD_NAND_DENALI_DT=m
CONFIG_MTD_NAND_AMS_DELTA=m
CONFIG_MTD_NAND_SHARPSL=m
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_ATMEL=m
# CONFIG_MTD_NAND_MARVELL is not set
CONFIG_MTD_NAND_SLC_LPC32XX=m
CONFIG_MTD_NAND_MLC_LPC32XX=m
CONFIG_MTD_NAND_TMIO=m
CONFIG_MTD_NAND_BRCMNAND=m
CONFIG_MTD_NAND_BRCMNAND_BCMA=m
# CONFIG_MTD_NAND_BCM47XXNFLASH is not set
CONFIG_MTD_NAND_OXNAS=m
CONFIG_MTD_NAND_FSL_IFC=m
# CONFIG_MTD_NAND_VF610_NFC is not set
CONFIG_MTD_NAND_MXC=m
CONFIG_MTD_NAND_SH_FLCTL=m
CONFIG_MTD_NAND_DAVINCI=m
CONFIG_MTD_NAND_TXX9NDFMC=m
CONFIG_MTD_NAND_JZ4780=m
CONFIG_MTD_NAND_INGENIC_ECC=y
CONFIG_MTD_NAND_JZ4740_ECC=m
CONFIG_MTD_NAND_JZ4725B_BCH=m
CONFIG_MTD_NAND_JZ4780_BCH=m
CONFIG_MTD_NAND_FSMC=m
# CONFIG_MTD_NAND_SUNXI is not set
CONFIG_MTD_NAND_HISI504=m
# CONFIG_MTD_NAND_QCOM is not set
CONFIG_MTD_NAND_MTK=m
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_TEGRA=m
# CONFIG_MTD_NAND_STM32_FMC2 is not set
# CONFIG_MTD_NAND_MESON is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m
# CONFIG_MTD_NAND_INTEL_LGM is not set
# CONFIG_MTD_NAND_RENESAS is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
CONFIG_MTD_NAND_ECC_MEDIATEK=m
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
CONFIG_MTD_LPDDR2_NVM=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=m
# CONFIG_HBMC_AM654 is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
CONFIG_PARIDE=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
# CONFIG_PARIDE_PG is not set

#
# Parallel IDE protocol modules
#
# CONFIG_PARIDE_ATEN is not set
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
# CONFIG_PARIDE_COMM is not set
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
# CONFIG_PARIDE_FIT3 is not set
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
# CONFIG_PARIDE_FRPW is not set
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
# CONFIG_PARIDE_ON20 is not set
CONFIG_PARIDE_ON26=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
# CONFIG_ZRAM_DEF_COMP_LZORLE is not set
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
CONFIG_ZRAM_DEF_COMP_LZO=y
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
CONFIG_ZRAM_DEF_COMP="lzo"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_BLK_DEV_LOOP is not set
CONFIG_BLK_DEV_DRBD=y
CONFIG_DRBD_FAULT_INJECTION=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=y
CONFIG_NVME_APPLE=m
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ATMEL_SSC=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_QCOM_COINCELL=m
CONFIG_QCOM_FASTRPC=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
CONFIG_PCI_ENDPOINT_TEST=m
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=y
CONFIG_OPEN_DICE=y
CONFIG_C2PORT=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_ECHO is not set
CONFIG_BCM_VK=m
CONFIG_BCM_VK_TTY=y
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=m
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
# CONFIG_SCSI is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING=y
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=m
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_EBS=y
# CONFIG_DM_ERA is not set
CONFIG_DM_CLONE=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=m
# CONFIG_DM_ZERO is not set
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_QL is not set
# CONFIG_DM_MULTIPATH_ST is not set
CONFIG_DM_MULTIPATH_HST=m
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=y
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=y
CONFIG_ARCNET_CAP=y
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=y
# CONFIG_ARCNET_COM20020 is not set
# CONFIG_ATM_DRIVERS is not set
# CONFIG_CAIF_DRIVERS is not set
# CONFIG_ETHERNET is not set
CONFIG_FDDI=m
# CONFIG_DEFXX is not set
# CONFIG_SKFP is not set
CONFIG_HIPPI=y
# CONFIG_ROADRUNNER is not set
CONFIG_NET_SB1000=m
CONFIG_PHYLIB=m
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=m

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
CONFIG_MESON_GXL_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_BCM54140_PHY=m
# CONFIG_BCM63XX_PHY is not set
CONFIG_BCM7XXX_PHY=m
CONFIG_BCM84881_PHY=m
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
# CONFIG_LXT_PHY is not set
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MARVELL_88X2222_PHY=m
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=m
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=m
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
CONFIG_NXP_C45_TJA11XX_PHY=m
CONFIG_NXP_TJA11XX_PHY=m
CONFIG_AT803X_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=m
CONFIG_DP83869_PHY=m
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MDIO_DEVICE=m
CONFIG_MDIO_BUS=m
CONFIG_FWNODE_MDIO=m
CONFIG_OF_MDIO=m
CONFIG_MDIO_DEVRES=m
CONFIG_MDIO_SUN4I=m
# CONFIG_MDIO_XGENE is not set
CONFIG_MDIO_ASPEED=m
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_IPROC is not set
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_CAVIUM=m
CONFIG_MDIO_HISI_FEMAC=m
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_MDIO_MOXART=m
CONFIG_MDIO_OCTEON=m
CONFIG_MDIO_IPQ4019=m
# CONFIG_MDIO_IPQ8064 is not set

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=m
CONFIG_MDIO_BUS_MUX_MESON_G12A=m
CONFIG_MDIO_BUS_MUX_BCM6368=m
CONFIG_MDIO_BUS_MUX_BCM_IPROC=m
CONFIG_MDIO_BUS_MUX_GPIO=m
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=m
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

CONFIG_PLIP=m
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
CONFIG_IEEE802154_HWSIM=m

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
# CONFIG_WWAN_HWSIM is not set
CONFIG_QCOM_BAM_DMUX=m
CONFIG_RPMSG_WWAN_CTRL=m
CONFIG_MTK_T7XX=y
# end of Wireless WAN

CONFIG_VMXNET3=m
# CONFIG_USB4_NET is not set
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set
CONFIG_INPUT_APMPOWER=m

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=m
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=m
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=m
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=m
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_JOYSTICK_QWIIC=m
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_JOYSTICK_SENSEHAT=y
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=y
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_IPROC is not set
CONFIG_TOUCHSCREEN_S6SY761=m
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MSG2638=m
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMAGIS=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=m
# CONFIG_TOUCHSCREEN_HTCPEN is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_RASPBERRYPI_FW is not set
# CONFIG_TOUCHSCREEN_MIGOR is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
# CONFIG_TOUCHSCREEN_MXS_LRADC is not set
CONFIG_TOUCHSCREEN_MX25=m
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TS4800=y
CONFIG_TOUCHSCREEN_TSC_SERIO=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_SUN4I=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=m
# CONFIG_INPUT_AD714X_I2C is not set
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
CONFIG_INPUT_ATC260X_ONKEY=y
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_PM8941_PWRKEY is not set
# CONFIG_INPUT_PM8XXX_VIBRATOR is not set
# CONFIG_INPUT_PMIC8XXX_PWRKEY is not set
CONFIG_INPUT_MAX77650_ONKEY=m
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_REGULATOR_HAPTIC=m
# CONFIG_INPUT_RETU_PWRBUTTON is not set
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_AXP20X_PEK is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=m
# CONFIG_INPUT_PCF50633_PMU is not set
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_IQS269A=m
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_INPUT_HISI_POWERKEY=y
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
CONFIG_INPUT_SC27XX_VIBRA=y
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=m
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=m
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_SUN4I_PS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_AMBA_PL010 is not set
CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST=y
# CONFIG_SERIAL_ATMEL is not set
# CONFIG_SERIAL_MESON is not set
# CONFIG_SERIAL_CLPS711X is not set
CONFIG_SERIAL_SAMSUNG=m
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
CONFIG_SERIAL_SAMSUNG_CONSOLE=y
# CONFIG_SERIAL_TEGRA is not set
# CONFIG_SERIAL_TEGRA_TCU is not set
# CONFIG_SERIAL_21285 is not set
CONFIG_SERIAL_IMX=m
CONFIG_SERIAL_IMX_CONSOLE=m
CONFIG_SERIAL_IMX_EARLYCON=y
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_SH_SCI_CONSOLE=y
# CONFIG_SERIAL_SH_SCI_EARLYCON is not set
CONFIG_SERIAL_SH_SCI_DMA=y
CONFIG_SERIAL_HS_LPC32XX=m
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_ICOM is not set
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_MSM is not set
CONFIG_SERIAL_QCOM_GENI=y
CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
# CONFIG_SERIAL_VT8500 is not set
CONFIG_SERIAL_OMAP=y
# CONFIG_SERIAL_OMAP_CONSOLE is not set
CONFIG_SERIAL_SIFIVE=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_QE is not set
CONFIG_SERIAL_SCCNXP=m
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_TIMBERDALE=m
CONFIG_SERIAL_BCM63XX=y
# CONFIG_SERIAL_BCM63XX_CONSOLE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=m
CONFIG_SERIAL_MXS_AUART=m
CONFIG_SERIAL_XILINX_PS_UART=m
# CONFIG_SERIAL_MPS2_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
# CONFIG_SERIAL_ST_ASC is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_STM32 is not set
# CONFIG_SERIAL_MVEBU_UART is not set
# CONFIG_SERIAL_OWL is not set
# CONFIG_SERIAL_RDA is not set
# CONFIG_SERIAL_MILBEAUT_USIO is not set
CONFIG_SERIAL_LITEUART=m
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# CONFIG_SERIAL_SUNPLUS is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_N_GSM=y
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_DCC=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
CONFIG_ASPEED_BT_IPMI_BMC=m
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_ATMEL=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
# CONFIG_HW_RANDOM_IXP4XX is not set
# CONFIG_HW_RANDOM_OMAP is not set
CONFIG_HW_RANDOM_OMAP3_ROM=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_IMX_RNGC is not set
CONFIG_HW_RANDOM_NOMADIK=m
CONFIG_HW_RANDOM_STM32=m
CONFIG_HW_RANDOM_POLARFIRE_SOC=m
# CONFIG_HW_RANDOM_MESON is not set
CONFIG_HW_RANDOM_MTK=y
# CONFIG_HW_RANDOM_EXYNOS is not set
# CONFIG_HW_RANDOM_NPCM is not set
# CONFIG_HW_RANDOM_KEYSTONE is not set
CONFIG_HW_RANDOM_CCTRNG=m
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_DTLK=y
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_DEVMEM is not set
# CONFIG_DEVPORT is not set
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
# CONFIG_TCG_TIS_SYNQUACER is not set
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=m
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=y
CONFIG_I2C_HIX5HD2=m
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=m
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
# CONFIG_I2C_ASPEED is not set
# CONFIG_I2C_AT91 is not set
# CONFIG_I2C_AXXIA is not set
CONFIG_I2C_BCM2835=m
# CONFIG_I2C_BCM_IPROC is not set
CONFIG_I2C_BCM_KONA=m
CONFIG_I2C_BRCMSTB=m
CONFIG_I2C_CADENCE=y
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DAVINCI=m
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_I2C_DIGICOLOR=m
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_EXYNOS5 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_HIGHLANDER=m
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=y
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=m
CONFIG_I2C_IOP3XX=m
CONFIG_I2C_JZ4780=y
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_LPC2K=m
CONFIG_I2C_MESON=y
# CONFIG_I2C_MT65XX is not set
CONFIG_I2C_MT7621=y
CONFIG_I2C_MV64XXX=m
CONFIG_I2C_MXS=m
# CONFIG_I2C_NPCM7XX is not set
CONFIG_I2C_OCORES=m
# CONFIG_I2C_OMAP is not set
CONFIG_I2C_OWL=y
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_PNX=m
CONFIG_I2C_PXA=m
# CONFIG_I2C_PXA_SLAVE is not set
CONFIG_I2C_QCOM_CCI=y
# CONFIG_I2C_QCOM_GENI is not set
CONFIG_I2C_QUP=m
CONFIG_I2C_RIIC=m
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=m
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_SPRD=m
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=y
CONFIG_I2C_STM32F7=y
CONFIG_I2C_SUN6I_P2WI=m
# CONFIG_I2C_SYNQUACER is not set
CONFIG_I2C_TEGRA=y
CONFIG_I2C_TEGRA_BPMP=m
CONFIG_I2C_UNIPHIER=y
CONFIG_I2C_UNIPHIER_F=m
CONFIG_I2C_VERSATILE=m
# CONFIG_I2C_WMT is not set
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_PCA_ISA=m
# CONFIG_I2C_FSI is not set
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=m
CONFIG_SPMI_MSM_PMIC_ARB=m
CONFIG_SPMI_MTK_PMIF=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
CONFIG_PTP_1588_CLOCK_DTE=y
CONFIG_PTP_1588_CLOCK_QORIQ=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_IDT82P33=m
CONFIG_PTP_1588_CLOCK_IDTCM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AT91PIO4 is not set
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_BM1880=y
CONFIG_PINCTRL_DA850_PUPD=m
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_INGENIC=y
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_STARFIVE=m
CONFIG_PINCTRL_STMFX=m
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_OWL is not set
CONFIG_PINCTRL_ASPEED=y
# CONFIG_PINCTRL_ASPEED_G4 is not set
CONFIG_PINCTRL_ASPEED_G5=y
# CONFIG_PINCTRL_ASPEED_G6 is not set
CONFIG_PINCTRL_BCM281XX=y
CONFIG_PINCTRL_BCM2835=y
# CONFIG_PINCTRL_BCM4908 is not set
CONFIG_PINCTRL_BCM63XX=y
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
CONFIG_PINCTRL_BCM6358=y
CONFIG_PINCTRL_BCM6362=y
# CONFIG_PINCTRL_BCM6368 is not set
CONFIG_PINCTRL_BCM63268=y
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
CONFIG_PINCTRL_NS=y
CONFIG_PINCTRL_NSP_GPIO=y
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
# CONFIG_PINCTRL_AS370 is not set
CONFIG_PINCTRL_BERLIN_BG4CT=y
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
CONFIG_PINCTRL_MT7623=y
CONFIG_PINCTRL_MT7629=y
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT2712 is not set
CONFIG_PINCTRL_MT6765=y
CONFIG_PINCTRL_MT6779=y
# CONFIG_PINCTRL_MT6795 is not set
CONFIG_PINCTRL_MT6797=y
# CONFIG_PINCTRL_MT7622 is not set
CONFIG_PINCTRL_MT7986=y
# CONFIG_PINCTRL_MT8167 is not set
CONFIG_PINCTRL_MT8173=y
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8192 is not set
CONFIG_PINCTRL_MT8195=y
# CONFIG_PINCTRL_MT8365 is not set
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

# CONFIG_PINCTRL_MESON is not set
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=m
CONFIG_PINCTRL_PXA27X=m
CONFIG_PINCTRL_MSM=m
CONFIG_PINCTRL_APQ8064=m
# CONFIG_PINCTRL_APQ8084 is not set
CONFIG_PINCTRL_IPQ4019=m
CONFIG_PINCTRL_IPQ8064=m
# CONFIG_PINCTRL_IPQ8074 is not set
CONFIG_PINCTRL_IPQ6018=m
# CONFIG_PINCTRL_MSM8226 is not set
CONFIG_PINCTRL_MSM8660=m
CONFIG_PINCTRL_MSM8960=m
# CONFIG_PINCTRL_MDM9607 is not set
CONFIG_PINCTRL_MDM9615=m
CONFIG_PINCTRL_MSM8X74=m
CONFIG_PINCTRL_MSM8916=m
# CONFIG_PINCTRL_MSM8953 is not set
CONFIG_PINCTRL_MSM8976=m
CONFIG_PINCTRL_MSM8994=m
CONFIG_PINCTRL_MSM8996=m
CONFIG_PINCTRL_MSM8998=m
CONFIG_PINCTRL_QCM2290=m
# CONFIG_PINCTRL_QCS404 is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=m
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7180=m
# CONFIG_PINCTRL_SC7280 is not set
# CONFIG_PINCTRL_SC8180X is not set
# CONFIG_PINCTRL_SC8280XP is not set
# CONFIG_PINCTRL_SDM660 is not set
CONFIG_PINCTRL_SDM845=m
CONFIG_PINCTRL_SDX55=m
# CONFIG_PINCTRL_SM6115 is not set
CONFIG_PINCTRL_SM6125=m
CONFIG_PINCTRL_SM6350=m
CONFIG_PINCTRL_SDX65=m
CONFIG_PINCTRL_SM8150=m
# CONFIG_PINCTRL_SM8250 is not set
CONFIG_PINCTRL_SM8350=m
CONFIG_PINCTRL_SM8450=m
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
# CONFIG_PINCTRL_PFC_R8A77990 is not set
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
CONFIG_PINCTRL_PFC_R8A77950=y
# CONFIG_PINCTRL_PFC_R8A77951 is not set
CONFIG_PINCTRL_PFC_R8A7778=y
CONFIG_PINCTRL_PFC_R8A7793=y
CONFIG_PINCTRL_PFC_R8A7791=y
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
CONFIG_PINCTRL_PFC_R8A7792=y
CONFIG_PINCTRL_PFC_R8A77980=y
CONFIG_PINCTRL_PFC_R8A77970=y
CONFIG_PINCTRL_PFC_R8A779A0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
CONFIG_PINCTRL_RZA1=y
CONFIG_PINCTRL_RZA2=y
CONFIG_PINCTRL_RZG2L=y
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
CONFIG_PINCTRL_PFC_R8A7742=y
# CONFIG_PINCTRL_PFC_R8A7743 is not set
CONFIG_PINCTRL_PFC_R8A7744=y
CONFIG_PINCTRL_PFC_R8A774C0=y
CONFIG_PINCTRL_PFC_R8A774E1=y
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
CONFIG_PINCTRL_PFC_SH7720=y
CONFIG_PINCTRL_PFC_SH7722=y
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
CONFIG_PINCTRL_PFC_SH7785=y
CONFIG_PINCTRL_PFC_SH7786=y
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
CONFIG_PINCTRL_STM32=y
# CONFIG_PINCTRL_STM32F429 is not set
CONFIG_PINCTRL_STM32F469=y
CONFIG_PINCTRL_STM32F746=y
CONFIG_PINCTRL_STM32F769=y
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
CONFIG_PINCTRL_TI_IODELAY=y
CONFIG_PINCTRL_UNIPHIER=y
CONFIG_PINCTRL_UNIPHIER_LD4=y
CONFIG_PINCTRL_UNIPHIER_PRO4=y
CONFIG_PINCTRL_UNIPHIER_SLD8=y
# CONFIG_PINCTRL_UNIPHIER_PRO5 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
# CONFIG_PINCTRL_UNIPHIER_LD6B is not set
# CONFIG_PINCTRL_UNIPHIER_LD11 is not set
CONFIG_PINCTRL_UNIPHIER_LD20=y
CONFIG_PINCTRL_UNIPHIER_PXS3=y
CONFIG_PINCTRL_UNIPHIER_NX1=y
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=m
# CONFIG_GPIO_BCM_KONA is not set
CONFIG_GPIO_BCM_XGS_IPROC=m
CONFIG_GPIO_BRCMSTB=y
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_CLPS711X is not set
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EIC_SPRD=y
CONFIG_GPIO_EM=y
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HISI is not set
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_IOP=y
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_LPC18XX=y
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
# CONFIG_GPIO_OMAP is not set
CONFIG_GPIO_PMIC_EIC_SPRD=m
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_RDA is not set
CONFIG_GPIO_ROCKCHIP=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SNPS_CREG=y
CONFIG_GPIO_SPRD=m
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=m
CONFIG_GPIO_TEGRA186=m
CONFIG_GPIO_TS4800=y
CONFIG_GPIO_UNIPHIER=y
CONFIG_GPIO_VISCONTI=m
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_WCD934X is not set
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XILINX=m
CONFIG_GPIO_XLP=m
# CONFIG_GPIO_ZEVIO is not set
# CONFIG_GPIO_AMD_FCH is not set
CONFIG_GPIO_IDT3243X=m
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
CONFIG_GPIO_TS4900=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD71815 is not set
# CONFIG_GPIO_BD71828 is not set
CONFIG_GPIO_DA9055=y
# CONFIG_HTC_EGPIO is not set
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=m
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_SL28CPLD=m
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VIRTIO=m
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=m

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_MXC=m
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=y
CONFIG_POWER_RESET_BRCMKONA=y
# CONFIG_POWER_RESET_BRCMSTB is not set
CONFIG_POWER_RESET_GEMINI_POWEROFF=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LINKSTATION=m
# CONFIG_POWER_RESET_OCELOT_RESET is not set
CONFIG_POWER_RESET_PIIX4_POWEROFF=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
CONFIG_POWER_RESET_VERSATILE=y
# CONFIG_POWER_RESET_KEYSTONE is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_POWER_RESET_RMOBILE is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_RESET_SC27XX=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
# CONFIG_APM_POWER is not set
CONFIG_IP5XXX_POWER=m
# CONFIG_MAX8925_POWER is not set
CONFIG_TEST_POWER=m
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=m
# CONFIG_CHARGER_MT6360 is not set
# CONFIG_CHARGER_QCOM_SMBB is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_SC2731=m
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_ARM_SCMI is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_BT1_PVT=m
CONFIG_SENSORS_BT1_PVT_ALARMS=y
CONFIG_SENSORS_CORSAIR_CPRO=m
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_SPARX5=m
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LAN966X=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=y
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_NSA320=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC_P9_SBE=m
CONFIG_SENSORS_OCC=y
CONFIG_SENSORS_PCF8591=m
# CONFIG_SENSORS_PECI_CPUTEMP is not set
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=m
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE152=m
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_RASPBERRYPI_HWMON=y
CONFIG_SENSORS_SL28CPLD=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VEXPRESS=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
CONFIG_BCMA_NFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_ATMEL_SMC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_MFD_ASIC3=y
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_ENE_KB3930=m
# CONFIG_MFD_EXYNOS_LPASS is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
CONFIG_MFD_HI655X_PMIC=m
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_PM8XXX=m
CONFIG_MFD_SPMI_PMIC=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TMIO=y
# CONFIG_MFD_T7L66XB is not set
# CONFIG_MFD_TC6387XB is not set
CONFIG_MFD_TC6393XB=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STW481X=m
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_STM32_LPTIMER=y
CONFIG_MFD_STM32_TIMERS=m
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_KHADAS_MCU=y
# CONFIG_MFD_ACER_A500_EC is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_VEXPRESS_SYSREG=m
CONFIG_RAVE_SP_CORE=m
# CONFIG_MFD_RSMU_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=m
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_ARM_SCMI=m
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD71815=m
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD957XMUF=m
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9121=m
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_HI655X=m
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LOCHNAGAR=m
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MP886X=m
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=m
CONFIG_REGULATOR_MT6359=y
# CONFIG_REGULATOR_MT6360 is not set
CONFIG_REGULATOR_MT6380=m
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PBIAS=y
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=m
# CONFIG_REGULATOR_PF8X00 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_RPMH=m
# CONFIG_REGULATOR_QCOM_SMD_RPM is not set
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=m
# CONFIG_REGULATOR_STM32_VREFBUF is not set
CONFIG_REGULATOR_STM32_PWR=y
CONFIG_REGULATOR_STPMIC1=m
CONFIG_REGULATOR_TI_ABB=y
CONFIG_REGULATOR_STW481X_VMMC=y
CONFIG_REGULATOR_SY7636A=m
CONFIG_REGULATOR_SY8106A=m
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
# CONFIG_REGULATOR_TPS65910 is not set
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_VEXPRESS is not set
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_RC_CORE=m
# CONFIG_LIRC is not set
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
# CONFIG_DVB_NET is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=m
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_SI4713=m
CONFIG_RADIO_SI476X=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_TIMBERDALE=m
CONFIG_RADIO_WL1273=m
CONFIG_RADIO_SI470X=m
# CONFIG_I2C_SI470X is not set
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
# CONFIG_V4L_RADIO_ISA_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_SONY_BTF_MPX=m
CONFIG_VIDEO_TDA1997X=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_TLV320AIC23B=m
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
CONFIG_VIDEO_ADV7183=m
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=m
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_ISL7998X=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_MAX9286=m
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TC358743=m
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=m
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_ADV7170=m
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_ST_MIPID02=m
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_CX24123=m
# CONFIG_DVB_DS3000 is not set
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
# CONFIG_DVB_TDA10071 is not set
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_CXD2820R is not set
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
# CONFIG_DVB_DIB7000P is not set
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
# CONFIG_DVB_RTL2832 is not set
CONFIG_DVB_S5H1432=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
# CONFIG_DVB_ZL10353 is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_STV0297 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=m
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=m
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_TDA665x=m
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_TEGRA_HOST1X_CONTEXT_BUS=y
CONFIG_TEGRA_HOST1X=y
CONFIG_TEGRA_HOST1X_FIREWALL=y
CONFIG_IMX_IPUV3_CORE=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_HDLCD=y
CONFIG_DRM_HDLCD_SHOW_UNDERRUN=y
CONFIG_DRM_MALI_DISPLAY=m
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_HDCP=y
# end of Display Engine Configuration

CONFIG_DRM_NOUVEAU=m
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_KMB_DISPLAY=m
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_EXYNOS is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_ARMADA is not set
CONFIG_DRM_ATMEL_HLCDC=m
CONFIG_DRM_RCAR_DU=m
# CONFIG_DRM_RCAR_USE_CMM is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
CONFIG_DRM_RCAR_MIPI_DSI=m
# CONFIG_DRM_SHMOBILE is not set
# CONFIG_DRM_SUN4I is not set
# CONFIG_DRM_TILCDC is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_MSM=m
CONFIG_DRM_MSM_GPU_STATE=y
# CONFIG_DRM_MSM_GPU_SUDO is not set
CONFIG_DRM_MSM_MDP4=y
# CONFIG_DRM_MSM_MDP5 is not set
# CONFIG_DRM_MSM_DPU is not set
CONFIG_DRM_MSM_DP=y
# CONFIG_DRM_MSM_DSI is not set
# CONFIG_DRM_MSM_HDMI is not set
# CONFIG_DRM_FSL_DCU is not set
# CONFIG_DRM_TEGRA is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_DSI_CM=y
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_EDP=y
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_JDI_R63452=m
CONFIG_DRM_PANEL_KHADAS_TS050=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
CONFIG_DRM_PANEL_NOVATEK_NT35950=m
CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=m
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHIPONE_ICN6211=y
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_CROS_EC_ANX7688=m
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_FSL_LDB=y
CONFIG_DRM_ITE_IT6505=m
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9211=y
CONFIG_DRM_LONTIUM_LT9611=y
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=m
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NWL_MIPI_DSI is not set
CONFIG_DRM_NXP_PTN3460=y
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_SIMPLE_BRIDGE=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=m
# CONFIG_DRM_TOSHIBA_TC358775 is not set
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI83=y
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=m
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7511_AUDIO=y
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_CDNS_MHDP8546=m
# CONFIG_DRM_CDNS_MHDP8546_J721E is not set
CONFIG_DRM_DW_HDMI=m
# CONFIG_DRM_DW_HDMI_AHB_AUDIO is not set
CONFIG_DRM_DW_HDMI_I2S_AUDIO=m
CONFIG_DRM_DW_HDMI_GP_AUDIO=m
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

CONFIG_DRM_IMX=m
CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
CONFIG_DRM_IMX_TVE=m
CONFIG_DRM_IMX_LDB=m
CONFIG_DRM_IMX_HDMI=m
# CONFIG_DRM_INGENIC is not set
CONFIG_DRM_V3D=m
# CONFIG_DRM_VC4 is not set
CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_MESON=y
CONFIG_DRM_MESON_DW_HDMI=m
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_PL111 is not set
# CONFIG_DRM_TVE200 is not set
CONFIG_DRM_LIMA=m
CONFIG_DRM_PANFROST=y
CONFIG_DRM_ASPEED_GFX=y
CONFIG_DRM_MCDE=m
# CONFIG_DRM_TIDSS is not set
CONFIG_DRM_ZYNQMP_DPSUB=m
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_SPRD is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_R128=y
CONFIG_DRM_MGA=y
# CONFIG_DRM_VIA is not set
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CLPS711X is not set
CONFIG_FB_IMX=y
CONFIG_FB_CYBER2000=m
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_CONTROL is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_EFI=y
CONFIG_FB_GBE=y
CONFIG_FB_GBE_MEM=4
CONFIG_FB_PVR2=m
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_ATMEL=m
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_WM8505 is not set
CONFIG_FB_PXA168=y
CONFIG_FB_W100=y
CONFIG_FB_SH_MOBILE_LCDC=y
# CONFIG_FB_TMIO is not set
CONFIG_FB_S3C=m
# CONFIG_FB_S3C_DEBUG_REGWRITE is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
CONFIG_FB_DA8XX=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# CONFIG_FB_OMAP is not set
CONFIG_FB_OMAP2=m
# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=m
# CONFIG_FB_OMAP2_DSS_DEBUG is not set
# CONFIG_FB_OMAP2_DSS_DEBUGFS is not set
CONFIG_FB_OMAP2_DSS_DPI=y
# CONFIG_FB_OMAP2_DSS_VENC is not set
CONFIG_FB_OMAP2_DSS_HDMI_COMMON=y
# CONFIG_FB_OMAP4_DSS_HDMI is not set
CONFIG_FB_OMAP5_DSS_HDMI=y
CONFIG_FB_OMAP2_DSS_SDI=y
# CONFIG_FB_OMAP2_DSS_DSI is not set
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y

#
# OMAPFB Panel and Encoder Drivers
#
CONFIG_FB_OMAP2_ENCODER_OPA362=m
CONFIG_FB_OMAP2_ENCODER_TFP410=m
CONFIG_FB_OMAP2_ENCODER_TPD12S015=m
CONFIG_FB_OMAP2_CONNECTOR_DVI=m
# CONFIG_FB_OMAP2_CONNECTOR_HDMI is not set
CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=m
CONFIG_FB_OMAP2_PANEL_DPI=m
CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=m
# end of OMAPFB Panel and Encoder Drivers

# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_ATMEL_LCDC=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_OMAP1=m
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=m
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_MDA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_SERIAL_GENERIC=m
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_ISA is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
# CONFIG_SND_HDA_CODEC_CA0110 is not set
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_ARM=y
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=m
# CONFIG_SND_SOC_UTILS_KUNIT_TEST is not set
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_AMD_ACP_CONFIG=m
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_ATMEL_SOC_PDC=y
CONFIG_SND_ATMEL_SOC_DMA=y
CONFIG_SND_ATMEL_SOC_SSC=m
CONFIG_SND_ATMEL_SOC_SSC_PDC=m
CONFIG_SND_ATMEL_SOC_SSC_DMA=m
CONFIG_SND_AT91_SOC_SAM9G20_WM8731=m
# CONFIG_SND_ATMEL_SOC_WM8904 is not set
# CONFIG_SND_AT91_SOC_SAM9X5_WM8731 is not set
CONFIG_SND_ATMEL_SOC_CLASSD=m
CONFIG_SND_ATMEL_SOC_PDMIC=m
CONFIG_SND_ATMEL_SOC_I2S=m
CONFIG_SND_SOC_MIKROE_PROTO=m
# CONFIG_SND_MCHP_SOC_I2S_MCC is not set
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
CONFIG_SND_MCHP_SOC_SPDIFRX=m
# CONFIG_SND_MCHP_SOC_PDMC is not set
CONFIG_SND_BCM2835_SOC_I2S=m
CONFIG_SND_SOC_CYGNUS=m
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
# CONFIG_SND_EP93XX_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
# CONFIG_SND_SOC_FSL_SAI is not set
CONFIG_SND_SOC_FSL_AUDMIX=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=m
CONFIG_SND_SOC_FSL_EASRC=m
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_AUD2HTX=m
CONFIG_SND_SOC_FSL_RPMSG=m
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# CONFIG_SND_IMX_SOC is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_JZ4740_SOC_I2S=m
# CONFIG_SND_KIRKWOOD_SOC is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_KEEMBAY=m
CONFIG_SND_SOC_INTEL_AVS=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
# CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
# CONFIG_SND_SOC_INTEL_BROADWELL_MACH is not set
CONFIG_SND_SOC_MEDIATEK=m
CONFIG_SND_SOC_MTK_BTCVSD=m
CONFIG_SND_SOC_MT8195=m
# CONFIG_SND_SOC_MT8195_MT6359 is not set

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
CONFIG_SND_MESON_AXG_FIFO=m
CONFIG_SND_MESON_AXG_FRDDR=m
CONFIG_SND_MESON_AXG_TODDR=m
CONFIG_SND_MESON_AXG_TDM_FORMATTER=m
CONFIG_SND_MESON_AXG_TDM_INTERFACE=m
CONFIG_SND_MESON_AXG_TDMIN=m
CONFIG_SND_MESON_AXG_TDMOUT=m
CONFIG_SND_MESON_AXG_SOUND_CARD=m
# CONFIG_SND_MESON_AXG_SPDIFOUT is not set
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
CONFIG_SND_MESON_AXG_PDM=m
CONFIG_SND_MESON_CARD_UTILS=m
CONFIG_SND_MESON_GX_SOUND_CARD=m
# CONFIG_SND_MESON_G12A_TOACODEC is not set
# CONFIG_SND_MESON_G12A_TOHDMITX is not set
CONFIG_SND_SOC_MESON_T9015=m
# end of ASoC support for Amlogic platforms

CONFIG_SND_MXS_SOC=m
CONFIG_SND_SOC_MXS_SGTL5000=m
# CONFIG_SND_PXA2XX_SOC is not set
# CONFIG_SND_SOC_QCOM is not set
CONFIG_SND_SOC_ROCKCHIP=m
CONFIG_SND_SOC_ROCKCHIP_I2S=m
# CONFIG_SND_SOC_ROCKCHIP_I2S_TDM is not set
CONFIG_SND_SOC_ROCKCHIP_PDM=m
CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
# CONFIG_SND_SOC_ROCKCHIP_MAX98090 is not set
# CONFIG_SND_SOC_ROCKCHIP_RT5645 is not set
CONFIG_SND_SOC_RK3288_HDMI_ANALOG=m
CONFIG_SND_SOC_SAMSUNG=m
CONFIG_SND_SAMSUNG_PCM=m
CONFIG_SND_SAMSUNG_SPDIF=m
CONFIG_SND_SAMSUNG_I2S=m
# CONFIG_SND_SOC_SAMSUNG_SMDK_WM8580 is not set
# CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994 is not set
CONFIG_SND_SOC_SMARTQ=m
# CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF is not set
CONFIG_SND_SOC_SMDK_WM8994_PCM=m
CONFIG_SND_SOC_TOBERMORY=m
CONFIG_SND_SOC_LOWLAND=m
# CONFIG_SND_SOC_LITTLEMILL is not set
CONFIG_SND_SOC_SNOW=m
CONFIG_SND_SOC_ODROID=m
CONFIG_SND_SOC_ARNDALE=m
# CONFIG_SND_SOC_SAMSUNG_MIDAS_WM1811 is not set

#
# SoC Audio support for Renesas SoCs
#
# CONFIG_SND_SOC_SH4_FSI is not set
# CONFIG_SND_SOC_RCAR is not set
CONFIG_SND_SOC_RZ=m
# end of SoC Audio support for Renesas SoCs

CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=m
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
CONFIG_SND_SOC_SOF_OF=m
CONFIG_SND_SOC_SOF_DEBUG_PROBES=m
CONFIG_SND_SOC_SOF_CLIENT=m
# CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=m
CONFIG_SND_SOC_SOF_AMD_COMMON=m
CONFIG_SND_SOC_SOF_AMD_RENOIR=m
# CONFIG_SND_SOC_SOF_IMX_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_INTEL_APL=m
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_INTEL_CNL=m
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE=m
CONFIG_SND_SOC_SOF_INTEL_ICL=m
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_JASPERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_TGL=m
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ALDERLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
# CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC is not set
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
# CONFIG_SND_SOC_SOF_MTK_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_XTENSA=m
# CONFIG_SND_SOC_SPRD is not set
# CONFIG_SND_SOC_STI is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_STM32_SAI=m
# CONFIG_SND_SOC_STM32_I2S is not set
CONFIG_SND_SOC_STM32_SPDIFRX=m
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
# CONFIG_SND_SUN4I_CODEC is not set
# CONFIG_SND_SUN8I_CODEC is not set
CONFIG_SND_SUN8I_CODEC_ANALOG=m
CONFIG_SND_SUN50I_CODEC_ANALOG=m
# CONFIG_SND_SUN4I_I2S is not set
CONFIG_SND_SUN4I_SPDIF=m
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=m
# end of Allwinner SoC Audio support

CONFIG_SND_SOC_TEGRA=m
CONFIG_SND_SOC_TEGRA20_AC97=m
CONFIG_SND_SOC_TEGRA20_DAS=m
# CONFIG_SND_SOC_TEGRA20_I2S is not set
CONFIG_SND_SOC_TEGRA20_SPDIF=m
CONFIG_SND_SOC_TEGRA30_AHUB=m
CONFIG_SND_SOC_TEGRA30_I2S=m
CONFIG_SND_SOC_TEGRA210_AHUB=m
CONFIG_SND_SOC_TEGRA210_DMIC=m
CONFIG_SND_SOC_TEGRA210_I2S=m
# CONFIG_SND_SOC_TEGRA186_ASRC is not set
CONFIG_SND_SOC_TEGRA186_DSPK=m
# CONFIG_SND_SOC_TEGRA210_ADMAIF is not set
# CONFIG_SND_SOC_TEGRA210_MVC is not set
CONFIG_SND_SOC_TEGRA210_SFC=m
CONFIG_SND_SOC_TEGRA210_AMX=m
# CONFIG_SND_SOC_TEGRA210_ADX is not set
CONFIG_SND_SOC_TEGRA210_MIXER=m
CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
CONFIG_SND_SOC_TEGRA_MACHINE_DRV=m
CONFIG_SND_SOC_TEGRA_RT5640=m
CONFIG_SND_SOC_TEGRA_WM8753=m
# CONFIG_SND_SOC_TEGRA_WM8903 is not set
# CONFIG_SND_SOC_TEGRA_WM9712 is not set
CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
CONFIG_SND_SOC_TEGRA_ALC5632=m
# CONFIG_SND_SOC_TEGRA_MAX98090 is not set
CONFIG_SND_SOC_TEGRA_RT5677=m
CONFIG_SND_SOC_TEGRA_SGTL5000=m

#
# Audio support for Texas Instruments SoCs
#
CONFIG_SND_SOC_TI_EDMA_PCM=m
CONFIG_SND_SOC_TI_SDMA_PCM=m
CONFIG_SND_SOC_TI_UDMA_PCM=m

#
# Texas Instruments DAI support for:
#
CONFIG_SND_SOC_DAVINCI_ASP=m
CONFIG_SND_SOC_DAVINCI_MCASP=m
CONFIG_SND_SOC_DAVINCI_VCIF=m
CONFIG_SND_SOC_OMAP_DMIC=m
CONFIG_SND_SOC_OMAP_MCBSP=m
# CONFIG_SND_SOC_OMAP_MCPDM is not set

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP_HDMI is not set
CONFIG_SND_SOC_J721E_EVM=m
# end of Audio support for Texas Instruments SoCs

CONFIG_SND_SOC_UNIPHIER=m
CONFIG_SND_SOC_UNIPHIER_AIO=m
# CONFIG_SND_SOC_UNIPHIER_LD11 is not set
CONFIG_SND_SOC_UNIPHIER_PXS2=m
CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC=m
CONFIG_SND_SOC_XILINX_I2S=m
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=m
CONFIG_SND_SOC_88PM860X=m
CONFIG_SND_SOC_ARIZONA=m
CONFIG_SND_SOC_WM_HUBS=m
CONFIG_SND_SOC_WM_ADSP=m
# CONFIG_SND_SOC_AB8500_CODEC is not set
CONFIG_SND_SOC_AC97_CODEC=m
# CONFIG_SND_SOC_AD1836 is not set
CONFIG_SND_SOC_AD193X=m
# CONFIG_SND_SOC_AD193X_SPI is not set
CONFIG_SND_SOC_AD193X_I2C=m
CONFIG_SND_SOC_AD1980=m
CONFIG_SND_SOC_AD73311=m
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1373=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU1781=m
CONFIG_SND_SOC_ADAU1781_I2C=m
# CONFIG_SND_SOC_ADAU1781_SPI is not set
CONFIG_SND_SOC_ADAU1977=m
# CONFIG_SND_SOC_ADAU1977_SPI is not set
CONFIG_SND_SOC_ADAU1977_I2C=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_ADAV80X=m
# CONFIG_SND_SOC_ADAV801 is not set
CONFIG_SND_SOC_ADAV803=m
CONFIG_SND_SOC_ADS117X=m
# CONFIG_SND_SOC_AK4104 is not set
CONFIG_SND_SOC_AK4118=m
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4535=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4641=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK4671=m
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_ALC5632=m
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CQ0093VC=m
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
# CONFIG_SND_SOC_CS35L41_SPI is not set
CONFIG_SND_SOC_CS35L41_I2C=m
CONFIG_SND_SOC_CS35L45_TABLES=m
CONFIG_SND_SOC_CS35L45=m
# CONFIG_SND_SOC_CS35L45_SPI is not set
CONFIG_SND_SOC_CS35L45_I2C=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=m
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
# CONFIG_SND_SOC_CS4271_SPI is not set
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
# CONFIG_SND_SOC_CS43130 is not set
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
# CONFIG_SND_SOC_CS47L15 is not set
CONFIG_SND_SOC_CS47L24=m
CONFIG_SND_SOC_CS47L35=m
CONFIG_SND_SOC_CS47L85=m
# CONFIG_SND_SOC_CS47L90 is not set
CONFIG_SND_SOC_CS47L92=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_CX20442=m
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_JZ4740_CODEC=m
CONFIG_SND_SOC_JZ4725B_CODEC=m
CONFIG_SND_SOC_JZ4760_CODEC=m
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_L3=m
CONFIG_SND_SOC_DA7210=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7218=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DA732X=m
CONFIG_SND_SOC_DA9055=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_ES8328_SPI is not set
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_ISABELLE=m
CONFIG_SND_SOC_LM49453=m
CONFIG_SND_SOC_LOCHNAGAR_SC=m
CONFIG_SND_SOC_MADERA=m
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98095=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98371=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98925=m
CONFIG_SND_SOC_MAX98926=m
# CONFIG_SND_SOC_MAX98927 is not set
CONFIG_SND_SOC_MAX98520=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
# CONFIG_SND_SOC_MAX98373_SDW is not set
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX98396=m
CONFIG_SND_SOC_MAX9850=m
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3008=m
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_PCM512x_SPI is not set
CONFIG_SND_SOC_RK3328=m
CONFIG_SND_SOC_RK817=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT274=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1011=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
CONFIG_SND_SOC_RT1016=m
CONFIG_SND_SOC_RT1019=m
CONFIG_SND_SOC_RT1305=m
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5665=m
CONFIG_SND_SOC_RT5668=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT5682S=m
# CONFIG_SND_SOC_RT700_SDW is not set
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
CONFIG_SND_SOC_RT9120=m
# CONFIG_SND_SOC_SDW_MOCKUP is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STA529=m
CONFIG_SND_SOC_STAC9766=m
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=m
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC26 is not set
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
CONFIG_SND_SOC_TLV320DAC33=m
CONFIG_SND_SOC_TLV320ADCX140=m
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=m
# CONFIG_SND_SOC_TWL4030 is not set
# CONFIG_SND_SOC_TWL6040 is not set
CONFIG_SND_SOC_UDA1334=m
CONFIG_SND_SOC_UDA134X=m
CONFIG_SND_SOC_UDA1380=m
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WCD_MBHC=m
CONFIG_SND_SOC_WCD934X=m
CONFIG_SND_SOC_WCD938X=m
CONFIG_SND_SOC_WCD938X_SDW=m
CONFIG_SND_SOC_WL1273=m
# CONFIG_SND_SOC_WM0010 is not set
CONFIG_SND_SOC_WM1250_EV1=m
CONFIG_SND_SOC_WM2000=m
CONFIG_SND_SOC_WM2200=m
CONFIG_SND_SOC_WM5100=m
# CONFIG_SND_SOC_WM5102 is not set
# CONFIG_SND_SOC_WM5110 is not set
# CONFIG_SND_SOC_WM8350 is not set
CONFIG_SND_SOC_WM8400=m
# CONFIG_SND_SOC_WM8510 is not set
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8727=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
# CONFIG_SND_SOC_WM8731_SPI is not set
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
# CONFIG_SND_SOC_WM8804_SPI is not set
CONFIG_SND_SOC_WM8900=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
CONFIG_SND_SOC_WM8940=m
CONFIG_SND_SOC_WM8955=m
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8961=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8971=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8983=m
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_WM8988=m
CONFIG_SND_SOC_WM8990=m
CONFIG_SND_SOC_WM8991=m
CONFIG_SND_SOC_WM8993=m
CONFIG_SND_SOC_WM8994=m
CONFIG_SND_SOC_WM8995=m
CONFIG_SND_SOC_WM8996=m
# CONFIG_SND_SOC_WM8997 is not set
CONFIG_SND_SOC_WM8998=m
CONFIG_SND_SOC_WM9081=m
CONFIG_SND_SOC_WM9090=m
CONFIG_SND_SOC_WM9705=m
CONFIG_SND_SOC_WM9712=m
CONFIG_SND_SOC_WM9713=m
CONFIG_SND_SOC_WSA881X=m
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_LM4857=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MAX9768=m
CONFIG_SND_SOC_MAX9877=m
# CONFIG_SND_SOC_MC13783 is not set
CONFIG_SND_SOC_ML26124=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6359=m
# CONFIG_SND_SOC_MT6359_ACCDET is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
CONFIG_SND_SOC_NAU8540=m
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8821=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
CONFIG_SND_SOC_LPASS_VA_MACRO=m
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_AUDIO_GRAPH_CARD=m
CONFIG_SND_AUDIO_GRAPH_CARD2=m
CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=m
CONFIG_SND_TEST_COMPONENT=m
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=m
# CONFIG_NINTENDO_FF is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SEMITEK=m
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=m
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_MESON_GX=m
CONFIG_MMC_MESON_MX_SDHC=m
CONFIG_MMC_MESON_MX_SDIO=m
CONFIG_MMC_MOXART=m
CONFIG_MMC_OMAP_HS=m
CONFIG_MMC_WBSD=m
# CONFIG_MMC_ALCOR is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_MVSDIO=m
CONFIG_MMC_DAVINCI=m
CONFIG_MMC_S3C=m
# CONFIG_MMC_S3C_HW_SDIO_IRQ is not set
# CONFIG_MMC_S3C_PIO is not set
CONFIG_MMC_S3C_DMA=y
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_TMIO_CORE=m
# CONFIG_MMC_TMIO is not set
CONFIG_MMC_SDHI=m
# CONFIG_MMC_SDHI_SYS_DMAC is not set
CONFIG_MMC_SDHI_INTERNAL_DMAC=m
# CONFIG_MMC_UNIPHIER is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_DW=m
CONFIG_MMC_DW_PLTFM=m
# CONFIG_MMC_DW_BLUEFIELD is not set
CONFIG_MMC_DW_EXYNOS=m
# CONFIG_MMC_DW_HI3798CV200 is not set
CONFIG_MMC_DW_K3=m
# CONFIG_MMC_DW_PCI is not set
CONFIG_MMC_SH_MMCIF=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_SUNXI=m
# CONFIG_MMC_CQHCI is not set
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_BCM2835 is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_OWL is not set
# CONFIG_MMC_LITEX is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_ARIEL is not set
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_TURRIS_OMNIA=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_S3C24XX=m
CONFIG_LEDS_COBALT_QUBE=m
CONFIG_LEDS_COBALT_RAQ=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_DA903X=m
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_ASIC3=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_PM8058 is not set
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
# CONFIG_LEDS_IP30 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MAX77693=m
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
# CONFIG_INFINIBAND_ON_DEMAND_PAGING is not set
# CONFIG_INFINIBAND_ADDR_TRANS is not set
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AL_MC=m
# CONFIG_EDAC_XGENE is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_AXI_DMAC=y
# CONFIG_BCM_SBA_RAID is not set
CONFIG_DMA_JZ4780=m
CONFIG_DMA_SA11X0=m
# CONFIG_DMA_SUN6I is not set
# CONFIG_DW_AXI_DMAC is not set
CONFIG_EP93XX_DMA=y
# CONFIG_FSL_EDMA is not set
CONFIG_FSL_QDMA=m
# CONFIG_HISI_DMA is not set
# CONFIG_IMG_MDC_DMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IOP_ADMA is not set
CONFIG_K3_DMA=m
CONFIG_MCF_EDMA=m
# CONFIG_MILBEAUT_HDMAC is not set
# CONFIG_MILBEAUT_XDMAC is not set
CONFIG_MMP_PDMA=m
CONFIG_MMP_TDMA=y
CONFIG_MV_XOR=y
# CONFIG_MXS_DMA is not set
CONFIG_NBPFAXI_DMA=y
CONFIG_PCH_DMA=m
CONFIG_PLX_DMA=y
CONFIG_STM32_DMA=y
CONFIG_STM32_DMAMUX=y
# CONFIG_STM32_MDMA is not set
# CONFIG_SPRD_DMA is not set
# CONFIG_S3C24XX_DMAC is not set
# CONFIG_TEGRA20_APB_DMA is not set
CONFIG_TEGRA210_ADMA=y
CONFIG_TIMB_DMA=y
# CONFIG_UNIPHIER_MDMAC is not set
CONFIG_UNIPHIER_XDMAC=y
CONFIG_XGENE_DMA=m
CONFIG_XILINX_ZYNQMP_DMA=y
CONFIG_XILINX_ZYNQMP_DPDMA=m
CONFIG_MTK_HSDMA=y
CONFIG_MTK_CQDMA=y
# CONFIG_QCOM_ADM is not set
# CONFIG_QCOM_BAM_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_RZN1_DMAMUX=m
CONFIG_DW_DMAC_PCI=y
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=m
CONFIG_SF_PDMA=m
CONFIG_RENESAS_DMA=y
CONFIG_SH_DMAE_BASE=y
CONFIG_SH_DMAE=m
CONFIG_RCAR_DMAC=m
CONFIG_RENESAS_USB_DMAC=y
CONFIG_RZ_DMAC=y
CONFIG_TI_EDMA=y
CONFIG_DMA_OMAP=m
CONFIG_TI_DMA_CROSSBAR=y
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=y
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=m
# CONFIG_COMEDI_PCL818 is not set
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=m
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=m
# CONFIG_COMEDI_DT2811 is not set
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=y
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=y
CONFIG_COMEDI_ADDI_APCI_1032=m
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=y
# CONFIG_COMEDI_ADL_PCI8164 is not set
# CONFIG_COMEDI_ADL_PCI9111 is not set
# CONFIG_COMEDI_ADL_PCI9118 is not set
CONFIG_COMEDI_ADV_PCI1710=y
CONFIG_COMEDI_ADV_PCI1720=m
# CONFIG_COMEDI_ADV_PCI1723 is not set
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=y
# CONFIG_COMEDI_AMPLC_PC263_PCI is not set
CONFIG_COMEDI_AMPLC_PCI224=y
CONFIG_COMEDI_AMPLC_PCI230=y
CONFIG_COMEDI_CONTEC_PCI_DIO=y
# CONFIG_COMEDI_DAS08_PCI is not set
# CONFIG_COMEDI_DT3000 is not set
CONFIG_COMEDI_DYNA_PCI10XX=m
# CONFIG_COMEDI_GSC_HPDI is not set
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=y
# CONFIG_COMEDI_JR3_PCI is not set
# CONFIG_COMEDI_KE_COUNTER is not set
# CONFIG_COMEDI_CB_PCIDAS64 is not set
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
CONFIG_COMEDI_CB_PCIMDAS=m
# CONFIG_COMEDI_CB_PCIMDDA is not set
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=y
CONFIG_COMEDI_NI_65XX=y
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
CONFIG_COMEDI_S626=y
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=m
CONFIG_COMEDI_TESTS_NI_ROUTES=y
# CONFIG_STAGING is not set
# CONFIG_GOLDFISH is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
# CONFIG_OLPC_XO175 is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
CONFIG_CLK_ICST=y
CONFIG_CLK_SP810=y
# CONFIG_CLK_VEXPRESS_OSC is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_HI655X=y
CONFIG_COMMON_CLK_SCMI=y
# CONFIG_COMMON_CLK_SCPI is not set
CONFIG_COMMON_CLK_SI5341=m
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_EN7523 is not set
CONFIG_COMMON_CLK_FSL_FLEXSPI=m
# CONFIG_COMMON_CLK_FSL_SAI is not set
CONFIG_COMMON_CLK_GEMINI=y
CONFIG_COMMON_CLK_LAN966X=y
# CONFIG_COMMON_CLK_ASPEED is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_COMMON_CLK_AXI_CLKGEN=m
# CONFIG_CLK_QORIQ is not set
CONFIG_CLK_LS1028A_PLLDIG=y
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_OXNAS=y
CONFIG_COMMON_CLK_RS9_PCIE=y
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
# CONFIG_COMMON_CLK_BD718XX is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_ACTIONS=y
# CONFIG_CLK_OWL_S500 is not set
# CONFIG_CLK_OWL_S700 is not set
# CONFIG_CLK_OWL_S900 is not set
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
# CONFIG_CLK_BT1_CCU_DIV is not set
CONFIG_CLK_BCM2711_DVP=m
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
# CONFIG_CLK_BCM_HR2 is not set
CONFIG_CLK_BCM_NSP=y
CONFIG_CLK_BCM_NS2=y
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
CONFIG_COMMON_CLK_HI3516CV300=y
CONFIG_COMMON_CLK_HI3519=y
CONFIG_COMMON_CLK_HI3559A=y
CONFIG_COMMON_CLK_HI3660=y
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
# CONFIG_CLK_IMX8MN is not set
CONFIG_CLK_IMX8MP=y
CONFIG_CLK_IMX8MQ=y
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=m
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
# CONFIG_COMMON_CLK_MT2701_MMSYS is not set
CONFIG_COMMON_CLK_MT2701_IMGSYS=y
CONFIG_COMMON_CLK_MT2701_VDECSYS=y
# CONFIG_COMMON_CLK_MT2701_HIFSYS is not set
CONFIG_COMMON_CLK_MT2701_ETHSYS=y
CONFIG_COMMON_CLK_MT2701_BDPSYS=y
# CONFIG_COMMON_CLK_MT2701_AUDSYS is not set
# CONFIG_COMMON_CLK_MT2701_G3DSYS is not set
CONFIG_COMMON_CLK_MT2712=y
# CONFIG_COMMON_CLK_MT2712_BDPSYS is not set
CONFIG_COMMON_CLK_MT2712_IMGSYS=y
CONFIG_COMMON_CLK_MT2712_JPGDECSYS=y
CONFIG_COMMON_CLK_MT2712_MFGCFG=y
# CONFIG_COMMON_CLK_MT2712_MMSYS is not set
# CONFIG_COMMON_CLK_MT2712_VDECSYS is not set
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
CONFIG_COMMON_CLK_MT6765=y
# CONFIG_COMMON_CLK_MT6765_AUDIOSYS is not set
CONFIG_COMMON_CLK_MT6765_CAMSYS=y
# CONFIG_COMMON_CLK_MT6765_GCESYS is not set
# CONFIG_COMMON_CLK_MT6765_MMSYS is not set
# CONFIG_COMMON_CLK_MT6765_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6765_VCODECSYS is not set
CONFIG_COMMON_CLK_MT6765_MFGSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0BSYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI1ASYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI1BSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI2ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI2BSYS is not set
CONFIG_COMMON_CLK_MT6779=y
CONFIG_COMMON_CLK_MT6779_MMSYS=m
# CONFIG_COMMON_CLK_MT6779_IMGSYS is not set
CONFIG_COMMON_CLK_MT6779_IPESYS=m
CONFIG_COMMON_CLK_MT6779_CAMSYS=m
CONFIG_COMMON_CLK_MT6779_VDECSYS=y
# CONFIG_COMMON_CLK_MT6779_VENCSYS is not set
# CONFIG_COMMON_CLK_MT6779_MFGCFG is not set
CONFIG_COMMON_CLK_MT6779_AUDSYS=m
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
CONFIG_COMMON_CLK_MT7629=y
# CONFIG_COMMON_CLK_MT7629_ETHSYS is not set
# CONFIG_COMMON_CLK_MT7629_HIFSYS is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
# CONFIG_COMMON_CLK_MT8167_AUDSYS is not set
CONFIG_COMMON_CLK_MT8167_IMGSYS=y
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8167_MMSYS is not set
CONFIG_COMMON_CLK_MT8167_VDECSYS=y
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
CONFIG_COMMON_CLK_MT8183=y
CONFIG_COMMON_CLK_MT8183_AUDIOSYS=y
CONFIG_COMMON_CLK_MT8183_CAMSYS=y
CONFIG_COMMON_CLK_MT8183_IMGSYS=y
# CONFIG_COMMON_CLK_MT8183_IPU_CORE0 is not set
CONFIG_COMMON_CLK_MT8183_IPU_CORE1=y
# CONFIG_COMMON_CLK_MT8183_IPU_ADL is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CONN is not set
# CONFIG_COMMON_CLK_MT8183_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8183_MMSYS is not set
# CONFIG_COMMON_CLK_MT8183_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8183_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
CONFIG_COMMON_CLK_MT8195=y
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
CONFIG_COMMON_CLK_MESON_REGMAP=y
CONFIG_COMMON_CLK_MESON_MPLL=y
CONFIG_COMMON_CLK_MESON_PLL=y
CONFIG_COMMON_CLK_MESON8B=y
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_COMMON_CLK_PISTACHIO=y
# CONFIG_COMMON_CLK_QCOM is not set
CONFIG_CLK_MT7621=y
CONFIG_CLK_RENESAS=y
# CONFIG_CLK_EMEV2 is not set
CONFIG_CLK_RZA1=y
CONFIG_CLK_R7S9210=y
CONFIG_CLK_R8A73A4=y
# CONFIG_CLK_R8A7740 is not set
# CONFIG_CLK_R8A7742 is not set
CONFIG_CLK_R8A7743=y
# CONFIG_CLK_R8A7745 is not set
# CONFIG_CLK_R8A77470 is not set
CONFIG_CLK_R8A774A1=y
CONFIG_CLK_R8A774B1=y
CONFIG_CLK_R8A774C0=y
CONFIG_CLK_R8A774E1=y
# CONFIG_CLK_R8A7778 is not set
# CONFIG_CLK_R8A7779 is not set
# CONFIG_CLK_R8A7790 is not set
CONFIG_CLK_R8A7791=y
# CONFIG_CLK_R8A7792 is not set
CONFIG_CLK_R8A7794=y
# CONFIG_CLK_R8A7795 is not set
# CONFIG_CLK_R8A77960 is not set
CONFIG_CLK_R8A77961=y
# CONFIG_CLK_R8A77965 is not set
CONFIG_CLK_R8A77970=y
CONFIG_CLK_R8A77980=y
CONFIG_CLK_R8A77990=y
CONFIG_CLK_R8A77995=y
CONFIG_CLK_R8A779A0=y
# CONFIG_CLK_R8A779F0 is not set
# CONFIG_CLK_R8A779G0 is not set
CONFIG_CLK_R9A06G032=y
# CONFIG_CLK_R9A07G043 is not set
# CONFIG_CLK_R9A07G044 is not set
CONFIG_CLK_R9A07G054=y
# CONFIG_CLK_R9A09G011 is not set
CONFIG_CLK_SH73A0=y
CONFIG_CLK_RCAR_CPG_LIB=y
CONFIG_CLK_RCAR_GEN2_CPG=y
CONFIG_CLK_RCAR_GEN3_CPG=y
CONFIG_CLK_RCAR_GEN4_CPG=y
CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
CONFIG_CLK_RZG2L=y
CONFIG_CLK_RENESAS_CPG_MSSR=y
CONFIG_CLK_RENESAS_CPG_MSTP=y
CONFIG_CLK_RENESAS_DIV6=y
CONFIG_COMMON_CLK_SAMSUNG=y
# CONFIG_S3C64XX_COMMON_CLK is not set
CONFIG_S5PV210_COMMON_CLK=y
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
CONFIG_EXYNOS_4_COMMON_CLK=y
CONFIG_EXYNOS_5250_COMMON_CLK=y
CONFIG_EXYNOS_5260_COMMON_CLK=y
CONFIG_EXYNOS_5410_COMMON_CLK=y
CONFIG_EXYNOS_5420_COMMON_CLK=y
# CONFIG_EXYNOS_ARM64_COMMON_CLK is not set
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
CONFIG_EXYNOS_CLKOUT=m
CONFIG_S3C2410_COMMON_CLK=y
# CONFIG_S3C2412_COMMON_CLK is not set
CONFIG_S3C2443_COMMON_CLK=y
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
CONFIG_CLK_INTEL_SOCFPGA32=y
# CONFIG_CLK_INTEL_SOCFPGA64 is not set
# CONFIG_SPRD_COMMON_CLK is not set
CONFIG_CLK_STARFIVE_JH7100=y
# CONFIG_CLK_STARFIVE_JH7100_AUDIO is not set
CONFIG_CLK_SUNXI=y
# CONFIG_CLK_SUNXI_CLOCKS is not set
# CONFIG_CLK_SUNXI_PRCM_SUN6I is not set
CONFIG_CLK_SUNXI_PRCM_SUN8I=y
CONFIG_CLK_SUNXI_PRCM_SUN9I=y
CONFIG_SUNXI_CCU=y
CONFIG_SUNIV_F1C100S_CCU=m
# CONFIG_SUN20I_D1_CCU is not set
CONFIG_SUN20I_D1_R_CCU=m
# CONFIG_SUN50I_A64_CCU is not set
CONFIG_SUN50I_A100_CCU=m
CONFIG_SUN50I_A100_R_CCU=m
CONFIG_SUN50I_H6_CCU=m
CONFIG_SUN50I_H616_CCU=y
CONFIG_SUN50I_H6_R_CCU=m
# CONFIG_SUN4I_A10_CCU is not set
CONFIG_SUN5I_CCU=y
CONFIG_SUN6I_A31_CCU=y
CONFIG_SUN6I_RTC_CCU=m
CONFIG_SUN8I_A23_CCU=m
CONFIG_SUN8I_A33_CCU=y
CONFIG_SUN8I_A83T_CCU=m
CONFIG_SUN8I_H3_CCU=y
CONFIG_SUN8I_V3S_CCU=m
# CONFIG_SUN8I_DE2_CCU is not set
# CONFIG_SUN8I_R40_CCU is not set
CONFIG_SUN9I_A80_CCU=y
CONFIG_SUN8I_R_CCU=m
# CONFIG_COMMON_CLK_TI_ADPLL is not set
CONFIG_CLK_UNIPHIER=y
CONFIG_COMMON_CLK_VISCONTI=y
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_CLK_KUNIT_TEST=m
CONFIG_CLK_GATE_KUNIT_TEST=m
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=y
# CONFIG_HWSPINLOCK_QCOM is not set
# CONFIG_HWSPINLOCK_SPRD is not set
CONFIG_HWSPINLOCK_STM32=m
CONFIG_HWSPINLOCK_SUN6I=m
CONFIG_HSEM_U8500=m

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
CONFIG_DIGICOLOR_TIMER=y
# CONFIG_DW_APB_TIMER is not set
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
CONFIG_ROCKCHIP_TIMER=y
CONFIG_ARMADA_370_XP_TIMER=y
# CONFIG_MESON6_TIMER is not set
CONFIG_ORION_TIMER=y
CONFIG_OWL_TIMER=y
CONFIG_RDA_TIMER=y
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
CONFIG_TEGRA_TIMER=y
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
# CONFIG_CADENCE_TTC_TIMER is not set
CONFIG_ASM9260_TIMER=y
CONFIG_CLKSRC_NOMADIK_MTU=y
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
CONFIG_MXS_TIMER=y
CONFIG_NSPIRE_TIMER=y
# CONFIG_KEYSTONE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_LPC32XX=y
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_TI_32K is not set
# CONFIG_CLKSRC_STM32 is not set
# CONFIG_CLKSRC_STM32_LP is not set
CONFIG_CLKSRC_MPS2=y
CONFIG_ARC_TIMERS=y
# CONFIG_ARC_TIMERS_64BIT is not set
CONFIG_ARM_GLOBAL_TIMER=y
CONFIG_ARM_GT_INITIAL_PRESCALER_VAL=1
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK=y
CONFIG_ARMV7M_SYSTICK=y
CONFIG_ATMEL_PIT=y
CONFIG_ATMEL_ST=y
CONFIG_ATMEL_TCB_CLKSRC=y
CONFIG_CLKSRC_EXYNOS_MCT=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
CONFIG_OXNAS_RPS_TIMER=y
CONFIG_MTK_TIMER=y
CONFIG_SPRD_TIMER=y
CONFIG_CLKSRC_JCORE_PIT=y
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
CONFIG_RENESAS_OSTM=y
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_CLKSRC_QCOM=y
CONFIG_CLKSRC_VERSATILE=y
# CONFIG_CLKSRC_PXA is not set
CONFIG_CLKSRC_IMX_GPT=y
# CONFIG_CLKSRC_IMX_TPM is not set
CONFIG_TIMER_IMX_SYS_CTR=y
# CONFIG_CLKSRC_ST_LPC is not set
CONFIG_GXP_TIMER=y
CONFIG_MILBEAUT_TIMER=y
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
CONFIG_INGENIC_SYSOST=y
# CONFIG_INGENIC_OST is not set
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
CONFIG_PLATFORM_MHU=y
CONFIG_ARMADA_37XX_RWTM_MBOX=y
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_ALTERA_MBOX=m
CONFIG_HI3660_MBOX=m
# CONFIG_HI6220_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_POLARFIRE_SOC_MAILBOX=y
# CONFIG_QCOM_APCS_IPC is not set
CONFIG_BCM_PDC_MBOX=y
# CONFIG_STM32_IPCC is not set
# CONFIG_MTK_ADSP_MBOX is not set
CONFIG_MTK_CMDQ_MBOX=m
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=m
CONFIG_QCOM_IPCC=m
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
# CONFIG_MSM_IOMMU is not set
# CONFIG_OMAP_IOMMU is not set
# CONFIG_ROCKCHIP_IOMMU is not set
CONFIG_SUN50I_IOMMU=y
CONFIG_EXYNOS_IOMMU=y
CONFIG_EXYNOS_IOMMU_DEBUG=y
# CONFIG_ARM_SMMU is not set
CONFIG_S390_CCW_IOMMU=y
# CONFIG_S390_AP_IOMMU is not set
CONFIG_MTK_IOMMU=y
CONFIG_MTK_IOMMU_V1=m
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# CONFIG_INGENIC_VPU_RPROC is not set
CONFIG_MTK_SCP=y
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=m
# CONFIG_RCAR_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_MTK_SCP=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_QCOM=m

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=m
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_GX_PM_DOMAINS is not set
CONFIG_MESON_EE_PM_DOMAINS=y
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_PMGR_PWRSTATE is not set
CONFIG_APPLE_RTKIT=m
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
CONFIG_ASPEED_LPC_SNOOP=y
# CONFIG_ASPEED_UART_ROUTING is not set
CONFIG_ASPEED_P2A_CTRL=m
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
CONFIG_SOC_BCM63XX=y
CONFIG_SOC_BRCMSTB=y
CONFIG_BCM63XX_POWER=y
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
CONFIG_QUICC_ENGINE=y
# CONFIG_DPAA2_CONSOLE is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
CONFIG_IMX_GPCV2_PM_DOMAINS=y
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=m
CONFIG_MTK_DEVAPC=m
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=m
CONFIG_MTK_SCPSYS=y
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

CONFIG_POLARFIRE_SOC_SYS_CTRL=y

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_AOSS_QMP=y
CONFIG_QCOM_COMMAND_DB=y
CONFIG_QCOM_GENI_SE=y
# CONFIG_QCOM_GSBI is not set
CONFIG_QCOM_LLCC=m
CONFIG_QCOM_PDR_HELPERS=y
CONFIG_QCOM_QMI_HELPERS=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_RPMHPD is not set
CONFIG_QCOM_RPMPD=m
# CONFIG_QCOM_SMEM is not set
CONFIG_QCOM_SMD_RPM=m
CONFIG_QCOM_SPM=m
CONFIG_QCOM_WCNSS_CTRL=m
CONFIG_QCOM_APR=y
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
# CONFIG_RST_RCAR is not set
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_RCAR_GEN4=y
CONFIG_SYSC_R8A77995=y
# CONFIG_SYSC_R8A7794 is not set
CONFIG_SYSC_R8A77990=y
CONFIG_SYSC_R8A7779=y
# CONFIG_SYSC_R8A7790 is not set
CONFIG_SYSC_R8A7795=y
CONFIG_SYSC_R8A7791=y
CONFIG_SYSC_R8A77965=y
CONFIG_SYSC_R8A77960=y
# CONFIG_SYSC_R8A77961 is not set
CONFIG_SYSC_R8A779F0=y
CONFIG_SYSC_R8A7792=y
CONFIG_SYSC_R8A77980=y
CONFIG_SYSC_R8A77970=y
# CONFIG_SYSC_R8A779A0 is not set
CONFIG_SYSC_R8A779G0=y
# CONFIG_SYSC_RMOBILE is not set
# CONFIG_SYSC_R8A77470 is not set
CONFIG_SYSC_R8A7745=y
CONFIG_SYSC_R8A7742=y
# CONFIG_SYSC_R8A7743 is not set
CONFIG_SYSC_R8A774C0=y
# CONFIG_SYSC_R8A774E1 is not set
# CONFIG_SYSC_R8A774A1 is not set
CONFIG_SYSC_R8A774B1=y
CONFIG_ROCKCHIP_GRF=y
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_ROCKCHIP_PM_DOMAINS=y
# CONFIG_SOC_SAMSUNG is not set
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
CONFIG_ARM_TEGRA_DEVFREQ=m
CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=m
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_QCOM_SPMI_MISC=m
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_ATMEL_SDRAMC is not set
CONFIG_ATMEL_EBI=y
CONFIG_BRCMSTB_DPFE=m
CONFIG_BT1_L2_CTL=y
# CONFIG_TI_AEMIF is not set
CONFIG_TI_EMIF=m
# CONFIG_OMAP_GPMC is not set
CONFIG_FPGA_DFL_EMIF=m
CONFIG_MVEBU_DEVBUS=y
CONFIG_FSL_CORENET_CF=m
CONFIG_FSL_IFC=y
CONFIG_JZ4780_NEMC=y
CONFIG_MTK_SMI=y
# CONFIG_DA8XX_DDRCTL is not set
CONFIG_RENESAS_RPCIF=m
# CONFIG_STM32_FMC2_EBI is not set
# CONFIG_SAMSUNG_MC is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=y
CONFIG_TEGRA30_EMC=y
# CONFIG_TEGRA124_EMC is not set
CONFIG_TEGRA210_EMC_TABLE=y
CONFIG_TEGRA210_EMC=y
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_ATMEL is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=m
CONFIG_PWM_ATMEL_TCB=m
CONFIG_PWM_BCM_IPROC=m
CONFIG_PWM_BCM_KONA=m
CONFIG_PWM_BCM2835=m
CONFIG_PWM_BERLIN=m
# CONFIG_PWM_BRCMSTB is not set
CONFIG_PWM_CLPS711X=m
CONFIG_PWM_DWC=y
CONFIG_PWM_EP93XX=y
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_HIBVT=m
# CONFIG_PWM_IMG is not set
CONFIG_PWM_IMX1=m
CONFIG_PWM_IMX27=y
CONFIG_PWM_IMX_TPM=m
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_JZ4740 is not set
CONFIG_PWM_KEEMBAY=y
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPC18XX_SCT=y
CONFIG_PWM_LPC32XX=m
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_MESON=y
CONFIG_PWM_MTK_DISP=m
CONFIG_PWM_MEDIATEK=m
CONFIG_PWM_MXS=m
CONFIG_PWM_OMAP_DMTIMER=y
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_PXA is not set
CONFIG_PWM_RASPBERRYPI_POE=y
CONFIG_PWM_RCAR=y
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=m
CONFIG_PWM_SAMSUNG=m
CONFIG_PWM_SIFIVE=m
CONFIG_PWM_SL28CPLD=m
# CONFIG_PWM_SPEAR is not set
# CONFIG_PWM_SPRD is not set
# CONFIG_PWM_STI is not set
CONFIG_PWM_STM32=m
CONFIG_PWM_STM32_LP=m
# CONFIG_PWM_SUN4I is not set
CONFIG_PWM_SUNPLUS=y
CONFIG_PWM_TEGRA=m
# CONFIG_PWM_TIECAP is not set
CONFIG_PWM_TIEHRPWM=m
CONFIG_PWM_VISCONTI=y
CONFIG_PWM_VT8500=y
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
CONFIG_JCORE_AIC=y
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=m
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=m
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_LOONGSON_PCH_MSI is not set
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_ATH79=y
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=m
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_K210=y
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
CONFIG_RESET_MCHP_SPARX5=y
CONFIG_RESET_MESON=m
# CONFIG_RESET_MESON_AUDIO_ARB is not set
CONFIG_RESET_NPCM=y
CONFIG_RESET_PISTACHIO=y
# CONFIG_RESET_QCOM_AOSS is not set
# CONFIG_RESET_QCOM_PDC is not set
CONFIG_RESET_RASPBERRYPI=m
CONFIG_RESET_RZG2L_USBPHY_CTRL=m
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNXI=y
CONFIG_RESET_TI_SCI=m
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
CONFIG_RESET_UNIPHIER_GLUE=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_COMMON_RESET_HI3660 is not set
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
# CONFIG_PHY_PISTACHIO_USB is not set
CONFIG_PHY_XGENE=m
CONFIG_PHY_CAN_TRANSCEIVER=m
CONFIG_PHY_SUN6I_MIPI_DPHY=m
CONFIG_PHY_SUN50I_USB3=m
CONFIG_PHY_MESON8_HDMI_TX=y
CONFIG_PHY_MESON_G12A_USB2=m
CONFIG_PHY_MESON_G12A_USB3_PCIE=m
CONFIG_PHY_MESON_AXG_PCIE=m
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=m
# CONFIG_PHY_CYGNUS_PCIE is not set
CONFIG_PHY_BCM_SR_USB=m
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_BCM_NS_USB2=y
# CONFIG_PHY_BCM_NS_USB3 is not set
CONFIG_PHY_NS2_PCIE=m
CONFIG_PHY_NS2_USB_DRD=y
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
CONFIG_PHY_BCM_SR_PCIE=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_CADENCE_SALVO=m
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
CONFIG_PHY_HI3660_USB=y
# CONFIG_PHY_HI3670_USB is not set
CONFIG_PHY_HI3670_PCIE=m
CONFIG_PHY_HISTB_COMBPHY=y
CONFIG_PHY_HISI_INNO_USB2=m
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
CONFIG_PHY_LANTIQ_RCU_USB2=m
CONFIG_ARMADA375_USBCLUSTER_PHY=y
CONFIG_PHY_BERLIN_SATA=m
CONFIG_PHY_BERLIN_USB=y
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
CONFIG_PHY_MVEBU_A38X_COMPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=y
CONFIG_PHY_MMP3_HSIC=y
CONFIG_PHY_MTK_TPHY=m
CONFIG_PHY_MTK_UFS=m
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
CONFIG_PHY_MTK_MIPI_DSI=m
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_ATH79_USB=y
CONFIG_PHY_QCOM_EDP=y
CONFIG_PHY_QCOM_IPQ4019_USB=y
# CONFIG_PHY_QCOM_PCIE2 is not set
CONFIG_PHY_QCOM_QMP=y
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
CONFIG_PHY_QCOM_USB_HS_28NM=m
CONFIG_PHY_QCOM_USB_SS=y
CONFIG_PHY_QCOM_IPQ806X_USB=y
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
CONFIG_PHY_RCAR_GEN3_USB3=y
CONFIG_PHY_ROCKCHIP_DPHY_RX0=m
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=y
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
# CONFIG_PHY_ROCKCHIP_PCIE is not set
CONFIG_PHY_ROCKCHIP_TYPEC=m
CONFIG_PHY_EXYNOS_DP_VIDEO=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
CONFIG_PHY_EXYNOS_PCIE=y
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_UNIPHIER_USB2=m
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
CONFIG_PHY_UNIPHIER_AHCI=y
CONFIG_PHY_ST_SPEAR1310_MIPHY=m
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
# CONFIG_PHY_STIH407_USB is not set
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=m
# CONFIG_PHY_AM654_SERDES is not set
CONFIG_PHY_J721E_WIZ=y
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
CONFIG_PHY_INTEL_KEEMBAY_USB=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
CONFIG_PHY_INTEL_THUNDERBAY_EMMC=m
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_ARM_CCN=y
CONFIG_ARM_CMN=m
CONFIG_ARM_PMU=y
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_ARM_DMC620_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_KUNIT_TEST is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=y
# CONFIG_NVMEM_IMX_OCOTP is not set
CONFIG_JZ4780_EFUSE=y
CONFIG_NVMEM_LPC18XX_EEPROM=y
CONFIG_NVMEM_LPC18XX_OTP=m
CONFIG_NVMEM_MXS_OCOTP=y
CONFIG_MTK_EFUSE=m
# CONFIG_NVMEM_NINTENDO_OTP is not set
CONFIG_QCOM_QFPROM=m
CONFIG_NVMEM_SPMI_SDAM=m
# CONFIG_ROCKCHIP_EFUSE is not set
CONFIG_ROCKCHIP_OTP=y
CONFIG_NVMEM_BCM_OCOTP=m
CONFIG_NVMEM_STM32_ROMEM=m
CONFIG_UNIPHIER_EFUSE=y
CONFIG_NVMEM_VF610_OCOTP=m
# CONFIG_MESON_MX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=m
CONFIG_RAVE_SP_EEPROM=m
CONFIG_SC27XX_EFUSE=m
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=m
CONFIG_NVMEM_BRCM_NVRAM=y
CONFIG_NVMEM_LAYERSCAPE_SFP=m
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_FPGA_MGR_SOCFPGA=m
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
# CONFIG_FPGA_DFL_FME_REGION is not set
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
CONFIG_FPGA_DFL_PCI=m
CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
CONFIG_FPGA_MGR_VERSAL_FPGA=m
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_ASPEED is not set
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
# CONFIG_INTERCONNECT_IMX8MM is not set
CONFIG_INTERCONNECT_IMX8MN=m
# CONFIG_INTERCONNECT_IMX8MQ is not set
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
CONFIG_INTERCONNECT_SAMSUNG=y
CONFIG_INTERCONNECT_EXYNOS=m
CONFIG_COUNTER=m
CONFIG_104_QUAD_8=m
CONFIG_INTERRUPT_CNT=m
# CONFIG_STM32_TIMER_CNT is not set
CONFIG_STM32_LPTIMER_CNT=m
CONFIG_TI_EQEP=m
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=m
CONFIG_MOST=y
CONFIG_MOST_CDEV=m
CONFIG_MOST_SND=m
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_PECI_ASPEED=m
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
# CONFIG_F2FS_FS_LZ4 is not set
# CONFIG_F2FS_FS_ZSTD is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS_BLOCK_OPS=y
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_FAT_KUNIT_TEST=m
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_SYSCTL is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_CEPH_FS=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=y
# CONFIG_9P_FS_POSIX_ACL is not set
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
# CONFIG_CRYPTO_DEV_SL3516 is not set
CONFIG_CRYPTO_DEV_HIFN_795X=y
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
CONFIG_CRYPTO_DEV_EXYNOS_RNG=m
CONFIG_CRYPTO_DEV_S5P=y
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_QCE=m
CONFIG_CRYPTO_DEV_QCE_SKCIPHER=y
CONFIG_CRYPTO_DEV_QCE_SHA=y
CONFIG_CRYPTO_DEV_QCE_AEAD=y
CONFIG_CRYPTO_DEV_QCE_ENABLE_ALL=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SKCIPHER is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SHA is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_AEAD is not set
CONFIG_CRYPTO_DEV_QCE_SW_MAX_LEN=512
CONFIG_CRYPTO_DEV_QCOM_RNG=y
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
CONFIG_CRYPTO_DEV_ZYNQMP_AES=m
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_CRYPTO_DEV_ARTPEC6=y
CONFIG_CRYPTO_DEV_CCREE=m
CONFIG_CRYPTO_DEV_HISI_SEC=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_CRYPTO_DEV_SA2UL=m
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_HAS_DMA_WRITE_COMBINE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS=y
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=16
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
CONFIG_DMA_API_DEBUG=y
# CONFIG_DMA_API_DEBUG_SG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_LRU_CACHE=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
# CONFIG_DEBUG_BUGVERBOSE is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
CONFIG_NET_NS_REFCNT_TRACKER=y
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_WX=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
# CONFIG_KFENCE_DEFERRABLE is not set
# CONFIG_KFENCE_STATIC_KEYS is not set
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# CONFIG_KFENCE_KUNIT_TEST is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_LATENCYTOP is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_STACK_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
CONFIG_FTRACE_SELFTEST=y
CONFIG_FTRACE_STARTUP_TEST=y
# CONFIG_EVENT_TRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# arm Debugging
#
CONFIG_ARM_PTDUMP_CORE=y
# CONFIG_ARM_PTDUMP_DEBUGFS is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_ARM is not set
# CONFIG_BACKTRACE_VERBOSE is not set
# CONFIG_DEBUG_USER is not set
CONFIG_DEBUG_LL=y
# CONFIG_DEBUG_DC21285_PORT is not set
# CONFIG_DEBUG_FOOTBRIDGE_COM1 is not set
# CONFIG_DEBUG_ICEDCC is not set
# CONFIG_DEBUG_SEMIHOSTING is not set
CONFIG_DEBUG_LL_UART_8250=y
# CONFIG_DEBUG_LL_UART_PL01X is not set
CONFIG_DEBUG_UART_FLOW_CONTROL=y
CONFIG_DEBUG_LL_INCLUDE="debug/palmchip.S"
CONFIG_DEBUG_UART_PHYS=0
CONFIG_DEBUG_UART_VIRT=0
CONFIG_DEBUG_UART_8250_SHIFT=2
CONFIG_DEBUG_UART_8250_WORD=y
CONFIG_DEBUG_UART_8250_PALMCHIP=y
CONFIG_UNCOMPRESS_INCLUDE="mach/uncompress.h"
CONFIG_EARLY_PRINTK=y
# CONFIG_CORESIGHT is not set
# end of arm Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_SORT=m
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_TEST_REF_TRACKER=m
CONFIG_RBTREE_TEST=m
CONFIG_REED_SOLOMON_TEST=m
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=m
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
CONFIG_STRING_SELFTEST=y
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_STRSCPY=y
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=y
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
CONFIG_TEST_XARRAY=y
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_SIPHASH=y
CONFIG_TEST_IDA=y
# CONFIG_TEST_LKM is not set
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=m
# CONFIG_BITFIELD_KUNIT is not set
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
# CONFIG_LIST_KUNIT_TEST is not set
# CONFIG_LINEAR_RANGES_TEST is not set
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_RATIONAL_KUNIT_TEST=m
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
CONFIG_TEST_UDELAY=y
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_DEBUG_VIRTUAL=m
CONFIG_TEST_MEMCAT_P=y
CONFIG_TEST_MEMINIT=y
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--mAkePtU51f9p4/31--
