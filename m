Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70111550734
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiFRWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiFRWCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:02:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1287C12745
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655589756; x=1687125756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nL7hGF/w4V46xGj3hFkaE491CYtmqPU0oMH6e3JnYto=;
  b=Oz4Kvq6tVen8r98+rsz6zEP6CkK/8tKFBUFEERL92ISzz8cSWysymY6n
   zJ6OTAg0ZLe1A4U0JhGmctLC1F4EQCCaWW565tVFh9MvfhlnvuNfoWYRd
   e4+Z7oV4Glt/yZjPt2cgTsOsH9Hke6zyLOA6u3aE6u+zx3G3QJtWSCr88
   zsFHXr/g9M8PROnHDum9Enl/Bm6uxkkwVB25XyIxpy0PsHQ+BRET2Pw3p
   IXI8jhl4BmSayhxfVNogs/LzLcL5cAUhmfzLAbwd+kSA8QA4/NbLngIbZ
   DDPCVEMejcJQin7O8280y4e7NOnZTTTj82Cc3bG0Ozg52uVfrIHfhsNcv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262721410"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262721410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 15:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688846051"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2022 15:02:34 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2gWX-000Qcr-KY;
        Sat, 18 Jun 2022 22:02:33 +0000
Date:   Sun, 19 Jun 2022 06:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
Message-ID: <202206190523.0Ar6yQF7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: a0f25a6bb319aa05e04dcf51707c97c2881b4f47 drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled
date:   5 months ago
config: riscv-buildonly-randconfig-r006-20220619 (https://download.01.org/0day-ci/archive/20220619/202206190523.0Ar6yQF7-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0f25a6bb319aa05e04dcf51707c97c2881b4f47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a0f25a6bb319aa05e04dcf51707c97c2881b4f47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L84':
>> ttm_bo_vm.c:(.text+0x754): undefined reference to `vmf_insert_pfn_prot'
   riscv64-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L0 ':
   ttm_bo_vm.c:(.text+0x8cc): undefined reference to `vmf_insert_pfn_prot'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_TTM_HELPER && HAS_IOMEM && DRM
   - DRM_HISI_HIBMC && HAS_IOMEM && DRM && PCI && (ARM64 || COMPILE_TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
