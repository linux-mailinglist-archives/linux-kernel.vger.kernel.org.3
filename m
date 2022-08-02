Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCC588351
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiHBVLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiHBVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:11:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783846D95
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659474696; x=1691010696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O6CQ4/+akHY0zLXtWUlJn8qJhxxf6XZ4saFs33fJwUo=;
  b=fvnkdeSRxRQ91HB3jVtqIiYjeg7QEcIW/0D4e5VFXmTB3wxl/i6cHCf+
   auaHyUvvd/eIqustUU3bF9F36sNx+3eDJJKKeyl9iLAuF6sN7isnbN1pA
   z8JJzOqDVJmLSPj2hJVAANqnOf/9KesbVedIPraFE+YCSb2Zf9weRHCcV
   IBmRGoVoD1kwFBH7DAv1SR8v5iaNDElq1KAciZiTjE7CoUwTcvO2l1omL
   zdt8EBrrkcbFY+KLrOpdh0fFmzbzhW3rfzbCq/RVbPjwuLfyi1C1xWMV1
   SvKSgZ36rUUKR2xfFvXF0vfnY1j3/cDeD1+fmNR5KNsSfXbvV35AlmR2k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290294801"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290294801"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="635437353"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 14:11:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIzAr-000GRj-1V;
        Tue, 02 Aug 2022 21:11:33 +0000
Date:   Wed, 3 Aug 2022 05:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: fs/pstore/ram_core.c:556:36: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202208030508.dUAAIOzC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   5 weeks ago
config: arm-randconfig-s051-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030508.dUAAIOzC-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/ drivers/scsi/ drivers/video/fbdev/ fs/pstore/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   fs/pstore/ram_core.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got unsigned char * @@
   fs/pstore/ram_core.c:278:9: sparse:     expected void volatile [noderef] __iomem *to
   fs/pstore/ram_core.c:278:9: sparse:     got unsigned char *
   fs/pstore/ram_core.c:311:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
   fs/pstore/ram_core.c:311:9: sparse:     expected void const volatile [noderef] __iomem *from
   fs/pstore/ram_core.c:311:9: sparse:     got unsigned char *
   fs/pstore/ram_core.c:312:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
   fs/pstore/ram_core.c:312:9: sparse:     expected void const volatile [noderef] __iomem *from
   fs/pstore/ram_core.c:312:9: sparse:     got unsigned char *
   fs/pstore/ram_core.c:466:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:466:20: sparse:     expected void *va
   fs/pstore/ram_core.c:466:20: sparse:     got void [noderef] __iomem *
   fs/pstore/ram_core.c:468:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:468:20: sparse:     expected void *va
   fs/pstore/ram_core.c:468:20: sparse:     got void [noderef] __iomem *
>> fs/pstore/ram_core.c:556:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *vaddr @@
   fs/pstore/ram_core.c:556:36: sparse:     expected void volatile [noderef] __iomem *io_addr
   fs/pstore/ram_core.c:556:36: sparse:     got void *vaddr
   fs/pstore/ram_core.c:69:17: sparse: sparse: context imbalance in 'buffer_start_add' - unexpected unlock
   fs/pstore/ram_core.c:95:17: sparse: sparse: context imbalance in 'buffer_size_add' - unexpected unlock
--
>> drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/megaraid.c:4470:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/megaraid.c:4470:26: sparse:     got void *
   drivers/scsi/megaraid.c:4529:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void * @@
   drivers/scsi/megaraid.c:4529:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/megaraid.c:4529:26: sparse:     got void *
--
   drivers/gpu/drm/drm_bufs.c:227:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:227:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:227:45: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/drm_bufs.c:230:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:230:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:230:45: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/drm_bufs.c:346:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:346:36: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/drm_bufs.c:346:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:363:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:363:36: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/drm_bufs.c:363:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:540:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:540:28: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/drm_bufs.c:540:28: sparse:     got void *handle
--
   drivers/gpu/drm/drm_memory.c:115:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_memory.c:115:29: sparse:     expected void *handle
   drivers/gpu/drm/drm_memory.c:115:29: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/drm_memory.c:124:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_memory.c:124:29: sparse:     expected void *handle
   drivers/gpu/drm/drm_memory.c:124:29: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/drm_memory.c:136:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *handle @@
   drivers/gpu/drm/drm_memory.c:136:28: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/drm_memory.c:136:28: sparse:     got void *handle
--
>> drivers/gpu/drm/drm_vm.c:270:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *handle @@
   drivers/gpu/drm/drm_vm.c:270:44: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/drm_vm.c:270:44: sparse:     got void *handle
--
   drivers/video/fbdev/imsttfb.c:1513:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/imsttfb.c:1513:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char [usertype] * @@
   drivers/video/fbdev/imsttfb.c:1513:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/imsttfb.c:1513:27: sparse:     got unsigned char [usertype] *
   drivers/video/fbdev/imsttfb.c:1522:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/imsttfb.c:1548:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got unsigned char [usertype] *cmap_regs @@
   drivers/video/fbdev/imsttfb.c:1548:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/video/fbdev/imsttfb.c:1548:20: sparse:     got unsigned char [usertype] *cmap_regs
   drivers/video/fbdev/imsttfb.c:1360:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/imsttfb.c:1361:16: sparse: sparse: cast removes address space '__iomem' of expression
--
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
>> drivers/gpu/drm/armada/armada_gem.c:63:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *addr @@
   drivers/gpu/drm/armada/armada_gem.c:63:37: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/armada/armada_gem.c:63:37: sparse:     got void *addr
   drivers/gpu/drm/armada/armada_gem.c:185:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/armada/armada_gem.c:185:28: sparse:     expected void *addr
   drivers/gpu/drm/armada/armada_gem.c:185:28: sparse:     got void [noderef] __iomem *
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

vim +556 fs/pstore/ram_core.c

bb4206f2042d950 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  545  
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  546  void persistent_ram_free(struct persistent_ram_zone *prz)
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  547  {
beeb94321a7a6d4 fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  548  	if (!prz)
beeb94321a7a6d4 fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  549  		return;
beeb94321a7a6d4 fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  550  
beeb94321a7a6d4 fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  551  	if (prz->vaddr) {
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  552  		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
831b624df1b420c fs/pstore/ram_core.c                     Bin Yang        2018-09-12  553  			/* We must vunmap() at page-granularity. */
831b624df1b420c fs/pstore/ram_core.c                     Bin Yang        2018-09-12  554  			vunmap(prz->vaddr - offset_in_page(prz->paddr));
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  555  		} else {
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11 @556  			iounmap(prz->vaddr);
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  557  			release_mem_region(prz->paddr, prz->size);
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  558  		}
beeb94321a7a6d4 fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  559  		prz->vaddr = NULL;
beeb94321a7a6d4 fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  560  	}
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  561  	if (prz->rs_decoder) {
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  562  		free_rs(prz->rs_decoder);
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  563  		prz->rs_decoder = NULL;
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  564  	}
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  565  	kfree(prz->ecc_info.par);
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  566  	prz->ecc_info.par = NULL;
f2531f1976d98a7 fs/pstore/ram_core.c                     Kees Cook       2018-03-07  567  
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  568  	persistent_ram_free_old(prz);
1227daa43bce131 fs/pstore/ram_core.c                     Kees Cook       2018-10-17  569  	kfree(prz->label);
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  570  	kfree(prz);
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  571  }
d3b487695120b53 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  572  

:::::: The code at line 556 was first introduced by commit
:::::: d3b487695120b5342067244253697eabb121436d staging: android: persistent_ram: Introduce persistent_ram_free()

:::::: TO: Anton Vorontsov <anton.vorontsov@linaro.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
