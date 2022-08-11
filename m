Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468FB59059F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiHKRQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiHKRQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:16:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7495AE6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660237619; x=1691773619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w/bzOK+S15jvtdpxHLUfDabNi2Auo+1Tz+FyaFsC2PM=;
  b=DCSH0SOEr7/JyLpYzcbab49E28CS/LHdh3f2X7cWTTeWNpuGvOswumA3
   NHwRcXr7yWGB4FH4dk5uO+rAKbqSZPmoJQ1xKaY4GFaYfn64hRdyf7fJt
   Z7uXkQL1pk4Rz1utJglhqHLdmjeehCws77x+0WaEyD1gkWm9tLtAvRU44
   Ukf9pxcSDhgfyZiWdPbb9ijWXwvFOJG7TyC6CnIhJXZxkZH11LijtjxkU
   IKSrRKmufONLB0B9dcaOdWfen+lfHe/aRP1qEQPoiBQUQPjKHYnLLRCK0
   haxi+ICGpDxKGfjeEwZT5d9aES9N/QekdTCdy8cA190PQp/HXVKM9x7Gz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271182759"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="271182759"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="556209108"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 10:06:57 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMBe5-0000Qz-0H;
        Thu, 11 Aug 2022 17:06:57 +0000
Date:   Fri, 12 Aug 2022 01:06:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "vmf_insert_pfn_prot" [drivers/gpu/drm/ttm/ttm.ko]
 undefined!
Message-ID: <202208120021.YxUbuR3a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21f9c8a13bb2a0c24d9c6b86bc0896542a28c197
commit: a0f25a6bb319aa05e04dcf51707c97c2881b4f47 drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled
date:   7 months ago
config: m68k-buildonly-randconfig-r002-20220811 (https://download.01.org/0day-ci/archive/20220812/202208120021.YxUbuR3a-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0f25a6bb319aa05e04dcf51707c97c2881b4f47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a0f25a6bb319aa05e04dcf51707c97c2881b4f47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vmf_insert_pfn_prot" [drivers/gpu/drm/ttm/ttm.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
   Selected by [m]:
   - DRM_TTM_HELPER [=m] && HAS_IOMEM [=y] && DRM [=y]
   - DRM_HISI_HIBMC [=m] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && (ARM64 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
