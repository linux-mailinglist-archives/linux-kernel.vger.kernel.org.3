Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B55892A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiHCTUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiHCTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:20:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA7BFF0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659554421; x=1691090421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rl2R1qjRCRU+vzbaaCeJiDEaUiNnBfejz426x45jxV8=;
  b=FZvEXcJ0xSJmlhzLrJjpEG4BywsdV+7nIZGgXVhyBIh5UiOrsJ30sgQr
   WPiRYxJec/pdSMKiTd3AEWeJPxZoNfw+Kub/g7Dlc5601aNUiG0IDWGfL
   igML+cw2UrL9UL33us8iQunv6t3embHaRq/elRT+cyLVktkkKEfP6jbzH
   xWWxfo48nnT8reIDzD5NfiZtexUAaJAV0/cgr5cGFU3jchxpIYXj82LPW
   W64A7Fd+jCRSMWsk1LY9qJjsNcnAhF/UYMM9XaaFq0tKmHwPSUopYQH+p
   0+DHh0UIg24rq/AJo3zndHt3JEPe+w4D+CyLRrlNDSJhcCMmLqdZS9xs+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="270140882"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="270140882"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 12:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631274932"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 12:20:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJJul-000Had-0x;
        Wed, 03 Aug 2022 19:20:19 +0000
Date:   Thu, 4 Aug 2022 03:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202208040356.e8qCh15B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2b542100719a93f8cdf6d90185410d38a57a4c1
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: powerpc-randconfig-s031-20220803 (https://download.01.org/0day-ci/archive/20220804/202208040356.e8qCh15B-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/512x/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/512x/mpc512x_shared.c:239:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:239:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:239:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:245:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:245:38: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:245:38: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
>> arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:256:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:256:24: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:256:24: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:264:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:264:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:264:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:277:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:277:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:277:19: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:278:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:278:32: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:278:32: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:279:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:279:32: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:279:32: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:280:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:280:32: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:280:32: sparse:     got restricted __be32 [noderef] __iomem *

vim +251 arch/powerpc/platforms/512x/mpc512x_shared.c

4b5006ec7bb73c Anatolij Gustschin 2010-07-23  208  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  209  /*
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  210   * Check if DIU was pre-initialized. If so, perform steps
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  211   * needed to continue displaying through the whole boot process.
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  212   * Move area descriptor and gamma table elsewhere, they are
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  213   * destroyed by bootmem allocator otherwise. The frame buffer
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  214   * address range will be reserved in setup_arch() after bootmem
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  215   * allocator is up.
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  216   */
7e198197ec878c Brian Norris       2013-10-11  217  static void __init mpc512x_init_diu(void)
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  218  {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  219  	struct device_node *np;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  220  	struct diu __iomem *diu_reg;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  221  	phys_addr_t desc;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  222  	void __iomem *vaddr;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  223  	unsigned long mode, pix_fmt, res, bpp;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  224  	unsigned long dst;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  225  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  226  	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  227  	if (!np) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  228  		pr_err("No DIU node\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  229  		return;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  230  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  231  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  232  	diu_reg = of_iomap(np, 0);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  233  	of_node_put(np);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  234  	if (!diu_reg) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  235  		pr_err("Can't map DIU\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  236  		return;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  237  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  238  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23 @239  	mode = in_be32(&diu_reg->diu_mode);
c4e5a0232763db Timur Tabi         2011-09-28  240  	if (mode == MFB_MODE0) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  241  		pr_info("%s: DIU OFF\n", __func__);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  242  		goto out;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  243  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  244  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  245  	desc = in_be32(&diu_reg->desc[0]);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  246  	vaddr = ioremap(desc, sizeof(struct diu_ad));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  247  	if (!vaddr) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  248  		pr_err("Can't map DIU area desc.\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  249  		goto out;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  250  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23 @251  	memcpy(&diu_shared_fb.ad0, vaddr, sizeof(struct diu_ad));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  252  	/* flush fb area descriptor */
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  253  	dst = (unsigned long)&diu_shared_fb.ad0;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  254  	flush_dcache_range(dst, dst + sizeof(struct diu_ad) - 1);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  255  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  256  	res = in_be32(&diu_reg->disp_size);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  257  	pix_fmt = in_le32(vaddr);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  258  	bpp = ((pix_fmt >> 16) & 0x3) + 1;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  259  	diu_shared_fb.fb_phys = in_le32(vaddr + 4);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  260  	diu_shared_fb.fb_len = ((res & 0xfff0000) >> 16) * (res & 0xfff) * bpp;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  261  	diu_shared_fb.in_use = true;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  262  	iounmap(vaddr);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  263  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  264  	desc = in_be32(&diu_reg->gamma);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  265  	vaddr = ioremap(desc, sizeof(diu_shared_fb.gamma));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  266  	if (!vaddr) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  267  		pr_err("Can't map DIU area desc.\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  268  		diu_shared_fb.in_use = false;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  269  		goto out;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  270  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  271  	memcpy(&diu_shared_fb.gamma, vaddr, sizeof(diu_shared_fb.gamma));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  272  	/* flush gamma table */
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  273  	dst = (unsigned long)&diu_shared_fb.gamma;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  274  	flush_dcache_range(dst, dst + sizeof(diu_shared_fb.gamma) - 1);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  275  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  276  	iounmap(vaddr);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  277  	out_be32(&diu_reg->gamma, virt_to_phys(&diu_shared_fb.gamma));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  278  	out_be32(&diu_reg->desc[1], 0);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  279  	out_be32(&diu_reg->desc[2], 0);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  280  	out_be32(&diu_reg->desc[0], virt_to_phys(&diu_shared_fb.ad0));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  281  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  282  out:
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  283  	iounmap(diu_reg);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  284  }
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  285  

:::::: The code at line 251 was first introduced by commit
:::::: 4b5006ec7bb73cd9d4c8a723d484b4c87fad4123 powerpc/5121: shared DIU framebuffer support

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Grant Likely <grant.likely@secretlab.ca>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
