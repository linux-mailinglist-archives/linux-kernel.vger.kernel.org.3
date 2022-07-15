Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE8576735
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiGOTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:12:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755BC75383
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657912364; x=1689448364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XfwouPmwTLbI79ezqCZC7kdBPw5k3IkMAvqUubBKi4A=;
  b=Jxzkcg/Pt9OGREVGctTnBNDSYIA4qyV6Rmxxq/+Inbi6Cu2U5My54UCm
   pY8cKoMoe71XTeGCnMKTjDui7UwITPTAe73B2Xk1AgrIQ71WQ/Jl8pWom
   YpU0mAuIQtiWIFJ0mzG1JqcawW0+k/GgrNhZtDjxXf2qOpFTP/79m1Gmm
   PTWZfSDhsTECCTP4mzMZyeOtfzljZbEmC4OMJnJq0Lea+63t6raTcUB4s
   A1ajMDymrMBdzgvWMEhzfPpis/iGpIKfFsXHVHw9opdaVbvI2N/x1D4Pv
   D9kMQWsGb7DRp4z/ygAOpMQAdUD3hSDpDN26y1+c+BoGF19T1ggsVwwP+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372195580"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="372195580"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="623974808"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2022 12:12:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCQjy-0000fg-3M;
        Fri, 15 Jul 2022 19:12:42 +0000
Date:   Sat, 16 Jul 2022 03:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stafford Horne <shorne@gmail.com>
Subject: fs/pstore/ram_core.c:542:36: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202207160349.IPT6QfVO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 031c7a8cd6fc565e90320bf08f22ee6e70f9d969 openrisc: io: Add missing __iomem annotation to iounmap()
date:   1 year, 6 months ago
config: openrisc-randconfig-s033-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160349.IPT6QfVO-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=031c7a8cd6fc565e90320bf08f22ee6e70f9d969
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 031c7a8cd6fc565e90320bf08f22ee6e70f9d969
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash fs/pstore/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/pstore/ram_core.c:278:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   fs/pstore/ram_core.c:278:34: sparse:     expected void volatile [noderef] __iomem *addr
   fs/pstore/ram_core.c:278:34: sparse:     got unsigned char *
   fs/pstore/ram_core.c:311:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char * @@
   fs/pstore/ram_core.c:311:50: sparse:     expected void const volatile [noderef] __iomem *addr
   fs/pstore/ram_core.c:311:50: sparse:     got unsigned char *
   fs/pstore/ram_core.c:312:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char * @@
   fs/pstore/ram_core.c:312:65: sparse:     expected void const volatile [noderef] __iomem *addr
   fs/pstore/ram_core.c:312:65: sparse:     got unsigned char *
   fs/pstore/ram_core.c:452:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:452:20: sparse:     expected void *va
   fs/pstore/ram_core.c:452:20: sparse:     got void [noderef] __iomem *
   fs/pstore/ram_core.c:454:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:454:20: sparse:     expected void *va
   fs/pstore/ram_core.c:454:20: sparse:     got void [noderef] __iomem *
>> fs/pstore/ram_core.c:542:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *vaddr @@
   fs/pstore/ram_core.c:542:36: sparse:     expected void [noderef] __iomem *addr
   fs/pstore/ram_core.c:542:36: sparse:     got void *vaddr
   fs/pstore/ram_core.c:69:17: sparse: sparse: context imbalance in 'buffer_start_add' - unexpected unlock
   fs/pstore/ram_core.c:95:17: sparse: sparse: context imbalance in 'buffer_size_add' - unexpected unlock

vim +542 fs/pstore/ram_core.c

bb4206f2042d95 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  531  
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  532  void persistent_ram_free(struct persistent_ram_zone *prz)
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  533  {
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  534  	if (!prz)
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  535  		return;
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  536  
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  537  	if (prz->vaddr) {
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  538  		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
831b624df1b420 fs/pstore/ram_core.c                     Bin Yang        2018-09-12  539  			/* We must vunmap() at page-granularity. */
831b624df1b420 fs/pstore/ram_core.c                     Bin Yang        2018-09-12  540  			vunmap(prz->vaddr - offset_in_page(prz->paddr));
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  541  		} else {
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11 @542  			iounmap(prz->vaddr);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  543  			release_mem_region(prz->paddr, prz->size);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  544  		}
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  545  		prz->vaddr = NULL;
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  546  	}
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  547  	if (prz->rs_decoder) {
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  548  		free_rs(prz->rs_decoder);
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  549  		prz->rs_decoder = NULL;
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  550  	}
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  551  	kfree(prz->ecc_info.par);
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  552  	prz->ecc_info.par = NULL;
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  553  
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  554  	persistent_ram_free_old(prz);
1227daa43bce13 fs/pstore/ram_core.c                     Kees Cook       2018-10-17  555  	kfree(prz->label);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  556  	kfree(prz);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  557  }
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  558  

:::::: The code at line 542 was first introduced by commit
:::::: d3b487695120b5342067244253697eabb121436d staging: android: persistent_ram: Introduce persistent_ram_free()

:::::: TO: Anton Vorontsov <anton.vorontsov@linaro.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
