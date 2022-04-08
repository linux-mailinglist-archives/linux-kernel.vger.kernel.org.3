Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125404F906F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiDHINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiDHINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:13:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5B3BA51
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649405475; x=1680941475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O8vNjUjdb+YSE+BlMlVSPWKJInDOBFoDacAWhOamg7I=;
  b=lBAeUnsL0cYuBeUgQyP80O5F9SxysgG6ChSDzRfJalCz/lW5hnSJFJ8E
   GmiuPRMjKPhh4ow+soyIlqIAYyiN53v1hJxYgh6Blko57cbwluOQa0Hdg
   H9upi35x+WNWStKkUI89tenQHM4qESvgtv8UCFdOb8Bipvc+qiaLJ2LrH
   yuP9T5mEZW4MhmpajD8HW04klbEezIdA4QfsCjDIR6UswtfARFhzHens6
   kuVTUxUeUqh8ruNiZBJgm+J0F8fsJCmUFh2Btq0DJWscLf8UIIqI+r5JG
   jvOGDemKVBiuk2D8EH+AJV6CpJa0LTMUBbvmiDjC5GHpXgd63oPTlSG76
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286530572"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="286530572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 01:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="589143206"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2022 01:11:12 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncjhz-00002X-Q8;
        Fri, 08 Apr 2022 08:11:07 +0000
Date:   Fri, 8 Apr 2022 16:10:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
Message-ID: <202204081648.gV63Gt0t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1831fed559732b132aef0ea8261ac77e73f7eadf
commit: a0f25a6bb319aa05e04dcf51707c97c2881b4f47 drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled
date:   2 months ago
config: riscv-buildonly-randconfig-r005-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081648.gV63Gt0t-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0f25a6bb319aa05e04dcf51707c97c2881b4f47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a0f25a6bb319aa05e04dcf51707c97c2881b4f47
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L97':
>> ttm_bo_vm.c:(.text+0x81c): undefined reference to `vmf_insert_pfn_prot'
   riscv64-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L0 ':
   ttm_bo_vm.c:(.text+0x9d8): undefined reference to `vmf_insert_pfn_prot'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_TTM_HELPER && HAS_IOMEM && DRM
   - DRM_HISI_HIBMC && HAS_IOMEM && DRM && PCI && (ARM64 || COMPILE_TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
