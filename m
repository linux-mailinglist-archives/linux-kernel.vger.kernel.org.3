Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C459B0DF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiHTXLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 19:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiHTXLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 19:11:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD9237CA
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661037081; x=1692573081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wTaLSnTJZskNtbA3we2yJzXGr0HHv8Et/7E/JrVADbw=;
  b=Gui9ApIEsD+frk/wy1hEUe/fi4RnTVC7dPa/UtQdOq7jz1J4fzf9Ik08
   svQVO04SHbdjy50A633FX179l9IWK3Zc7yOScGcQd/MMQIy35E795T0PN
   6RxoRbVZG44j7r2mFvbuHfUUiQBsR3h6b05r91nFZgDzxMUA3wKknz9Pc
   xI2I/rtd4yOZuzCNgrTiMpyZlBIxGDzOTtjN5C7pfAOjregCsBuQqwTVC
   hVD4Rjzhpg0Zuj65/38bOz2ieoaTk9id9y05ckLejISTbSHtTnkXMBCXI
   yjVuQ7miU/DPVsMcASsmlVoDfbFVZwuyMRQk9pfVXFgZ6pwOUKKIwZjbC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="293208106"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="293208106"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 16:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="676802659"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2022 16:11:19 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPXcc-0003KR-15;
        Sat, 20 Aug 2022 23:11:18 +0000
Date:   Sun, 21 Aug 2022 07:10:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202208210716.LwAfK7xH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cc1807b9158a909ffe829a5e222be756c57c9a90
commit: b3ed524f84f573ece1aa2f26e9db3c34a593e0d1 drm/msm: allow compile_test on !ARM
date:   11 months ago
config: mips-randconfig-s042-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210716.LwAfK7xH-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3ed524f84f573ece1aa2f26e9db3c34a593e0d1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3ed524f84f573ece1aa2f26e9db3c34a593e0d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c: note: in included file:
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:104:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:98:34: sparse: sparse: dereference of noderef expression
--
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1412:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1412:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1412:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:858:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:860:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1066:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1458:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1458:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1458:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1460:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1460:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1460:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1560:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] mmio @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1560:19: sparse:     expected void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1560:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] rscc @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:27: sparse:     expected void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:27: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1598:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1598:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1598:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1600:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1600:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1600:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:93:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@

vim +104 drivers/gpu/drm/msm/adreno/a6xx_hfi.c

4b565ca5a2cbbb Jordan Crouse  2018-08-06   95  
df0dff13290597 Jordan Crouse  2018-09-20   96  static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
df0dff13290597 Jordan Crouse  2018-09-20   97  		u32 *payload, u32 payload_size)
df0dff13290597 Jordan Crouse  2018-09-20   98  {
df0dff13290597 Jordan Crouse  2018-09-20   99  	struct a6xx_hfi_queue *queue = &gmu->queues[HFI_RESPONSE_QUEUE];
df0dff13290597 Jordan Crouse  2018-09-20  100  	u32 val;
df0dff13290597 Jordan Crouse  2018-09-20  101  	int ret;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  102  
df0dff13290597 Jordan Crouse  2018-09-20  103  	/* Wait for a response */
df0dff13290597 Jordan Crouse  2018-09-20 @104  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
df0dff13290597 Jordan Crouse  2018-09-20  105  		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
4b565ca5a2cbbb Jordan Crouse  2018-08-06  106  
df0dff13290597 Jordan Crouse  2018-09-20  107  	if (ret) {
6a41da17e87dee Mamta Shukla   2018-10-20  108  		DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  109  			"Message %s id %d timed out waiting for response\n",
df0dff13290597 Jordan Crouse  2018-09-20  110  			a6xx_hfi_msg_id[id], seqnum);
df0dff13290597 Jordan Crouse  2018-09-20  111  		return -ETIMEDOUT;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  112  	}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  113  
df0dff13290597 Jordan Crouse  2018-09-20  114  	/* Clear the interrupt */
df0dff13290597 Jordan Crouse  2018-09-20  115  	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_CLR,
df0dff13290597 Jordan Crouse  2018-09-20  116  		A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ);
4b565ca5a2cbbb Jordan Crouse  2018-08-06  117  
df0dff13290597 Jordan Crouse  2018-09-20  118  	for (;;) {
df0dff13290597 Jordan Crouse  2018-09-20  119  		struct a6xx_hfi_msg_response resp;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  120  
df0dff13290597 Jordan Crouse  2018-09-20  121  		/* Get the next packet */
8167e6fa76c8f7 Jonathan Marek 2020-04-23  122  		ret = a6xx_hfi_queue_read(gmu, queue, (u32 *) &resp,
df0dff13290597 Jordan Crouse  2018-09-20  123  			sizeof(resp) >> 2);
df0dff13290597 Jordan Crouse  2018-09-20  124  
df0dff13290597 Jordan Crouse  2018-09-20  125  		/* If the queue is empty our response never made it */
df0dff13290597 Jordan Crouse  2018-09-20  126  		if (!ret) {
6a41da17e87dee Mamta Shukla   2018-10-20  127  			DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  128  				"The HFI response queue is unexpectedly empty\n");
df0dff13290597 Jordan Crouse  2018-09-20  129  
df0dff13290597 Jordan Crouse  2018-09-20  130  			return -ENOENT;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  131  		}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  132  
df0dff13290597 Jordan Crouse  2018-09-20  133  		if (HFI_HEADER_ID(resp.header) == HFI_F2H_MSG_ERROR) {
df0dff13290597 Jordan Crouse  2018-09-20  134  			struct a6xx_hfi_msg_error *error =
df0dff13290597 Jordan Crouse  2018-09-20  135  				(struct a6xx_hfi_msg_error *) &resp;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  136  
6a41da17e87dee Mamta Shukla   2018-10-20  137  			DRM_DEV_ERROR(gmu->dev, "GMU firmware error %d\n",
df0dff13290597 Jordan Crouse  2018-09-20  138  				error->code);
df0dff13290597 Jordan Crouse  2018-09-20  139  			continue;
df0dff13290597 Jordan Crouse  2018-09-20  140  		}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  141  
df0dff13290597 Jordan Crouse  2018-09-20  142  		if (seqnum != HFI_HEADER_SEQNUM(resp.ret_header)) {
6a41da17e87dee Mamta Shukla   2018-10-20  143  			DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  144  				"Unexpected message id %d on the response queue\n",
df0dff13290597 Jordan Crouse  2018-09-20  145  				HFI_HEADER_SEQNUM(resp.ret_header));
df0dff13290597 Jordan Crouse  2018-09-20  146  			continue;
df0dff13290597 Jordan Crouse  2018-09-20  147  		}
df0dff13290597 Jordan Crouse  2018-09-20  148  
df0dff13290597 Jordan Crouse  2018-09-20  149  		if (resp.error) {
6a41da17e87dee Mamta Shukla   2018-10-20  150  			DRM_DEV_ERROR(gmu->dev,
df0dff13290597 Jordan Crouse  2018-09-20  151  				"Message %s id %d returned error %d\n",
df0dff13290597 Jordan Crouse  2018-09-20  152  				a6xx_hfi_msg_id[id], seqnum, resp.error);
df0dff13290597 Jordan Crouse  2018-09-20  153  			return -EINVAL;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  154  		}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  155  
df0dff13290597 Jordan Crouse  2018-09-20  156  		/* All is well, copy over the buffer */
df0dff13290597 Jordan Crouse  2018-09-20  157  		if (payload && payload_size)
df0dff13290597 Jordan Crouse  2018-09-20  158  			memcpy(payload, resp.payload,
df0dff13290597 Jordan Crouse  2018-09-20  159  				min_t(u32, payload_size, sizeof(resp.payload)));
4b565ca5a2cbbb Jordan Crouse  2018-08-06  160  
df0dff13290597 Jordan Crouse  2018-09-20  161  		return 0;
4b565ca5a2cbbb Jordan Crouse  2018-08-06  162  	}
4b565ca5a2cbbb Jordan Crouse  2018-08-06  163  }
4b565ca5a2cbbb Jordan Crouse  2018-08-06  164  

:::::: The code at line 104 was first introduced by commit
:::::: df0dff132905974697e2a19aa8bcc0ecc447c00e drm/msm/a6xx: Poll for HFI responses

:::::: TO: Jordan Crouse <jcrouse@codeaurora.org>
:::::: CC: Rob Clark <robdclark@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
