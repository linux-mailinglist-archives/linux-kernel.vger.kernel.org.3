Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B441356CBA1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGIVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIVuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:50:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF1BF67
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657403419; x=1688939419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RrhGcKv/54t4VLBjw3QwvGwiDb9VdAE58339ZUII6vI=;
  b=dLWl7TkCx160Kl/+X77urcnyTA0WqvH9wCuoxeqK7yLwcYzxF2FLuCBC
   XcFb+aNclBFexLVJzg/dfnR5BRHXewpHA2fiyS36Hw/DfUyGxZ5RyibvI
   wO0EBQ5nypaaAEY++/dTEZNsU9ptNI+/ArMc/WutERbZAMbB7iAqrR0ar
   YL/otdcdyj4MKVkX/rtE+nKlppyl4tuLDwk/MUsjM/fvzZdIueqj0ZGzd
   BCBd/AB9HeTYTEALXbFMDA/rAvoE6ykuOc3CXH+72OPFJ/+jz45bIcpgy
   Ckw95SVkYQLhKyoozJzScs2lqkCYkwUwtXRGVKhh9zIHQzvNoc3b1tpv5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="283216753"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="283216753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="627065624"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2022 14:50:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAILA-000PAG-UC;
        Sat, 09 Jul 2022 21:50:16 +0000
Date:   Sun, 10 Jul 2022 05:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [stffrdhrn:or1k-virt 4/6]
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202207100516.wKdfxTDy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/stffrdhrn/linux.git or1k-virt
head:   4ef380ab481d455f20014d29adca44003cc90b97
commit: e46f42dfd92ca0d298b2aa87fe84b3f0e82d8ab0 [4/6] openrisc: Add pci bus support
config: openrisc-randconfig-s031-20220710 (https://download.01.org/0day-ci/archive/20220710/202207100516.wKdfxTDy-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/stffrdhrn/linux/commit/e46f42dfd92ca0d298b2aa87fe84b3f0e82d8ab0
        git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
        git fetch --no-tags stffrdhrn or1k-virt
        git checkout e46f42dfd92ca0d298b2aa87fe84b3f0e82d8ab0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void const [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[assigned] emap @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void [noderef] __iomem *addr
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
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map
--
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_rom *rom @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse:     expected struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_ram_header *ram_header @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse:     expected struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse:     got struct qxl_ram_header *ram_header
>> drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse:     got struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse:     got struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse:     got struct qxl_rom *rom

vim +157 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c

07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  100  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  101  static void
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  102  nv50_instobj_wr32(struct nvkm_memory *memory, u64 offset, u32 data)
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  103  {
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01 @104  	iowrite32_native(data, nv50_instobj(memory)->map + offset);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  105  }
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  106  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  107  static u32
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  108  nv50_instobj_rd32(struct nvkm_memory *memory, u64 offset)
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  109  {
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  110  	return ioread32_native(nv50_instobj(memory)->map + offset);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  111  }
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  112  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  113  static const struct nvkm_memory_ptrs
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  114  nv50_instobj_fast = {
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  115  	.rd32 = nv50_instobj_rd32,
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  116  	.wr32 = nv50_instobj_wr32,
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  117  };
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  118  
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  119  static void
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  120  nv50_instobj_kmap(struct nv50_instobj *iobj, struct nvkm_vmm *vmm)
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  121  {
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  122  	struct nv50_instmem *imem = iobj->imem;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  123  	struct nv50_instobj *eobj;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  124  	struct nvkm_memory *memory = &iobj->base.memory;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  125  	struct nvkm_subdev *subdev = &imem->base.subdev;
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  126  	struct nvkm_device *device = subdev->device;
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  127  	struct nvkm_vma *bar = NULL, *ebar;
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  128  	u64 size = nvkm_memory_size(memory);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  129  	void *emap;
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  130  	int ret;
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  131  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  132  	/* Attempt to allocate BAR2 address-space and map the object
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  133  	 * into it.  The lock has to be dropped while doing this due
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  134  	 * to the possibility of recursion for page table allocation.
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  135  	 */
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  136  	mutex_unlock(&imem->base.mutex);
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  137  	while ((ret = nvkm_vmm_get(vmm, 12, size, &bar))) {
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  138  		/* Evict unused mappings, and keep retrying until we either
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  139  		 * succeed,or there's no more objects left on the LRU.
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  140  		 */
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  141  		mutex_lock(&imem->base.mutex);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  142  		eobj = list_first_entry_or_null(&imem->lru, typeof(*eobj), lru);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  143  		if (eobj) {
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  144  			nvkm_debug(subdev, "evict %016llx %016llx @ %016llx\n",
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  145  				   nvkm_memory_addr(&eobj->base.memory),
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  146  				   nvkm_memory_size(&eobj->base.memory),
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  147  				   eobj->bar->addr);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  148  			list_del_init(&eobj->lru);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  149  			ebar = eobj->bar;
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  150  			eobj->bar = NULL;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  151  			emap = eobj->map;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  152  			eobj->map = NULL;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  153  		}
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  154  		mutex_unlock(&imem->base.mutex);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  155  		if (!eobj)
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  156  			break;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01 @157  		iounmap(emap);
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  158  		nvkm_vmm_put(vmm, &ebar);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  159  	}
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  160  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  161  	if (ret == 0)
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  162  		ret = nvkm_memory_map(memory, 0, vmm, bar, NULL, 0);
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  163  	mutex_lock(&imem->base.mutex);
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  164  	if (ret || iobj->bar) {
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  165  		/* We either failed, or another thread beat us. */
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  166  		mutex_unlock(&imem->base.mutex);
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  167  		nvkm_vmm_put(vmm, &bar);
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  168  		mutex_lock(&imem->base.mutex);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  169  		return;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  170  	}
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  171  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  172  	/* Make the mapping visible to the host. */
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  173  	iobj->bar = bar;
dfcbd5506817c7 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  174  	iobj->map = ioremap_wc(device->func->resource_addr(device, 3) +
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  175  			       (u32)iobj->bar->addr, size);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  176  	if (!iobj->map) {
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  177  		nvkm_warn(subdev, "PRAMIN ioremap failed\n");
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  178  		nvkm_vmm_put(vmm, &iobj->bar);
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  179  	}
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  180  }
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  181  
19a82e492c3d71 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  182  static int
19a82e492c3d71 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  183  nv50_instobj_map(struct nvkm_memory *memory, u64 offset, struct nvkm_vmm *vmm,
19a82e492c3d71 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  184  		 struct nvkm_vma *vma, void *argv, u32 argc)
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  185  {
7f4f82af6e48c2 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  186  	memory = nv50_instobj(memory)->ram;
7f4f82af6e48c2 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  187  	return nvkm_memory_map(memory, offset, vmm, vma, argv, argc);
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  188  }
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  189  
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  190  static void
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  191  nv50_instobj_release(struct nvkm_memory *memory)
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  192  {
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  193  	struct nv50_instobj *iobj = nv50_instobj(memory);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  194  	struct nv50_instmem *imem = iobj->imem;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  195  	struct nvkm_subdev *subdev = &imem->base.subdev;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  196  
dfcbd5506817c7 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  197  	wmb();
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  198  	nvkm_bar_flush(subdev->device->bar);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  199  
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  200  	if (refcount_dec_and_mutex_lock(&iobj->maps, &imem->base.mutex)) {
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  201  		/* Add the now-unused mapping to the LRU instead of directly
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  202  		 * unmapping it here, in case we need to map it again later.
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  203  		 */
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  204  		if (likely(iobj->lru.next) && iobj->map) {
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  205  			BUG_ON(!list_empty(&iobj->lru));
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  206  			list_add_tail(&iobj->lru, &imem->lru);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  207  		}
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  208  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  209  		/* Switch back to NULL accessors when last map is gone. */
ffd937bbd21933 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  210  		iobj->base.memory.ptrs = NULL;
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  211  		mutex_unlock(&imem->base.mutex);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  212  	}
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  213  }
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  214  
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  215  static void __iomem *
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  216  nv50_instobj_acquire(struct nvkm_memory *memory)
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  217  {
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  218  	struct nv50_instobj *iobj = nv50_instobj(memory);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  219  	struct nvkm_instmem *imem = &iobj->imem->base;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  220  	struct nvkm_vmm *vmm;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  221  	void __iomem *map = NULL;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  222  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  223  	/* Already mapped? */
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  224  	if (refcount_inc_not_zero(&iobj->maps))
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01 @225  		return iobj->map;
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  226  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  227  	/* Take the lock, and re-check that another thread hasn't
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  228  	 * already mapped the object in the meantime.
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  229  	 */
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  230  	mutex_lock(&imem->mutex);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  231  	if (refcount_inc_not_zero(&iobj->maps)) {
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  232  		mutex_unlock(&imem->mutex);
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  233  		return iobj->map;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  234  	}
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  235  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  236  	/* Attempt to get a direct CPU mapping of the object. */
69b136f200006e drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  237  	if ((vmm = nvkm_bar_bar2_vmm(imem->subdev.device))) {
69b136f200006e drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  238  		if (!iobj->map)
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  239  			nv50_instobj_kmap(iobj, vmm);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  240  		map = iobj->map;
69b136f200006e drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  241  	}
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  242  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  243  	if (!refcount_inc_not_zero(&iobj->maps)) {
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  244  		/* Exclude object from eviction while it's being accessed. */
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  245  		if (likely(iobj->lru.next))
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  246  			list_del_init(&iobj->lru);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  247  
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  248  		if (map)
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  249  			iobj->base.memory.ptrs = &nv50_instobj_fast;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  250  		else
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  251  			iobj->base.memory.ptrs = &nv50_instobj_slow;
81a24b9ae8eea9 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-12-07  252  		refcount_set(&iobj->maps, 1);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  253  	}
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  254  
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  255  	mutex_unlock(&imem->mutex);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  256  	return map;
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  257  }
6ee738610f41b5 drivers/gpu/drm/nouveau/nv50_instmem.c             Ben Skeggs   2009-12-11  258  
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  259  static void
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  260  nv50_instobj_boot(struct nvkm_memory *memory, struct nvkm_vmm *vmm)
6ee738610f41b5 drivers/gpu/drm/nouveau/nv50_instmem.c             Ben Skeggs   2009-12-11  261  {
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  262  	struct nv50_instobj *iobj = nv50_instobj(memory);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  263  	struct nvkm_instmem *imem = &iobj->imem->base;
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  264  
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  265  	/* Exclude bootstrapped objects (ie. the page tables for the
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  266  	 * instmem BAR itself) from eviction.
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  267  	 */
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  268  	mutex_lock(&imem->mutex);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  269  	if (likely(iobj->lru.next)) {
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  270  		list_del_init(&iobj->lru);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  271  		iobj->lru.next = NULL;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  272  	}
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  273  
f584bde6095af4 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  274  	nv50_instobj_kmap(iobj, vmm);
b00b8430468d29 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  275  	nvkm_instmem_boot(imem);
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  276  	mutex_unlock(&imem->mutex);
6ee738610f41b5 drivers/gpu/drm/nouveau/nv50_instmem.c             Ben Skeggs   2009-12-11  277  }
6ee738610f41b5 drivers/gpu/drm/nouveau/nv50_instmem.c             Ben Skeggs   2009-12-11  278  
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  279  static u64
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  280  nv50_instobj_size(struct nvkm_memory *memory)
6ee738610f41b5 drivers/gpu/drm/nouveau/nv50_instmem.c             Ben Skeggs   2009-12-11  281  {
7f4f82af6e48c2 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  282  	return nvkm_memory_size(nv50_instobj(memory)->ram);
3863c9bc887e96 drivers/gpu/drm/nouveau/core/subdev/instmem/nv50.c Ben Skeggs   2012-07-14  283  }
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  284  
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  285  static u64
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  286  nv50_instobj_addr(struct nvkm_memory *memory)
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  287  {
7f4f82af6e48c2 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  288  	return nvkm_memory_addr(nv50_instobj(memory)->ram);
3863c9bc887e96 drivers/gpu/drm/nouveau/core/subdev/instmem/nv50.c Ben Skeggs   2012-07-14  289  }
3863c9bc887e96 drivers/gpu/drm/nouveau/core/subdev/instmem/nv50.c Ben Skeggs   2012-07-14  290  
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  291  static u64
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  292  nv50_instobj_bar2(struct nvkm_memory *memory)
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  293  {
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  294  	struct nv50_instobj *iobj = nv50_instobj(memory);
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  295  	u64 addr = ~0ULL;
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  296  	if (nv50_instobj_acquire(&iobj->base.memory)) {
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  297  		iobj->lru.next = NULL; /* Exclude from eviction. */
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  298  		addr = iobj->bar->addr;
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  299  	}
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  300  	nv50_instobj_release(&iobj->base.memory);
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  301  	return addr;
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  302  }
1786bf56e4180d drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2018-12-11  303  
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  304  static enum nvkm_memory_target
07bbc1c5f49b64 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  305  nv50_instobj_target(struct nvkm_memory *memory)
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  306  {
7f4f82af6e48c2 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  307  	return nvkm_memory_target(nv50_instobj(memory)->ram);
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  308  }
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  309  
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  310  static void *
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  311  nv50_instobj_dtor(struct nvkm_memory *memory)
ab606194d1f582 drivers/gpu/drm/nouveau/core/subdev/instmem/nv50.c Ben Skeggs   2013-12-23  312  {
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  313  	struct nv50_instobj *iobj = nv50_instobj(memory);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  314  	struct nvkm_instmem *imem = &iobj->imem->base;
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  315  	struct nvkm_vma *bar;
2046e733e125fa drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Guo Zhengkui 2022-02-28  316  	void *map;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  317  
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  318  	mutex_lock(&imem->mutex);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  319  	if (likely(iobj->lru.next))
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  320  		list_del(&iobj->lru);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  321  	map = iobj->map;
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  322  	bar = iobj->bar;
e5bf9a5ce5da32 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2020-12-02  323  	mutex_unlock(&imem->mutex);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  324  
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  325  	if (map) {
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  326  		struct nvkm_vmm *vmm = nvkm_bar_bar2_vmm(imem->subdev.device);
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01 @327  		iounmap(map);
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  328  		if (likely(vmm)) /* Can be NULL during BAR destructor. */
9202d732e6bc3b drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  329  			nvkm_vmm_put(vmm, &bar);
ab606194d1f582 drivers/gpu/drm/nouveau/core/subdev/instmem/nv50.c Ben Skeggs   2013-12-23  330  	}
03edf1b31a0912 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  331  
7f4f82af6e48c2 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  332  	nvkm_memory_unref(&iobj->ram);
be55287aa5ba68 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2017-11-01  333  	nvkm_instobj_dtor(imem, &iobj->base);
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  334  	return iobj;
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  335  }
d8e83994aaf674 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c Ben Skeggs   2015-08-20  336  

:::::: The code at line 157 was first introduced by commit
:::::: 03edf1b31a091254e95793a688abf02b96cfdd85 drm/nouveau/imem/nv50: support eviction of BAR2 mappings

:::::: TO: Ben Skeggs <bskeggs@redhat.com>
:::::: CC: Ben Skeggs <bskeggs@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
