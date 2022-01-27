Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64249E144
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiA0Lh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:37:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:44242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbiA0Lh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643283476; x=1674819476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rmZmudoZZ06IY94rptwHwfIQmDI27hmhXVIqxDXX5VM=;
  b=VhScWBFbzJ8eWtxPzi+ZmjoB3Mu6yAUDLQiASbkqKxTa2cOydGB4GmZq
   Lk6aJI30IhjCUavwNyXqQzAdGJMVedrWizoFpV/QPCBVDO7XeFr8S39sd
   VLT7JZEhb/QIA3ALFw4z25IHlhujcD22XaFHsHYVLr058dTHc7JOOaaqy
   xOK76n8QzjBt1v2qTsTh0qG3FqUWtw5u7hGL7TXbLQ46S/twCkgKw3PYx
   s92pSgcGbXhN2uklWc9wp20Mq6C5bxxLL1bag5veNaPUcY0VJXWED9V0A
   xMctTwQbktGbibDAri8kvwFYm2cijNzWAsKsTiBRT7QPf+duRtPOZ+aht
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246602193"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="246602193"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="696610042"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2022 03:37:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD36A-000MYn-Jg; Thu, 27 Jan 2022 11:37:54 +0000
Date:   Thu, 27 Jan 2022 19:37:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 161/165] drivers/gpu/drm/xe/xe_ggtt.c:138:6: error:
 no previous prototype for 'xe_ggtt_invalidate'
Message-ID: <202201271930.2Cnt0yRu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 97b49f6fa009a5e8c280503c7f33fedb5d3ddf25 [161/165] xe/ggtt: Invalidate the GGTT TLBs after any updates
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201271930.2Cnt0yRu-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 97b49f6fa009a5e8c280503c7f33fedb5d3ddf25
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_ggtt.c:14:
   drivers/gpu/drm/xe/xe_mmio.h: In function 'xe_mmio_read64':
   drivers/gpu/drm/xe/xe_mmio.h:28:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
      28 |  return readq(xe->mmio.regs + reg);
         |         ^~~~~
         |         readl
   drivers/gpu/drm/xe/xe_ggtt.c: In function 'xe_ggtt_set_pte':
   drivers/gpu/drm/xe/xe_ggtt.c:55:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
      55 |  writeq(pte, &ggtt->gsm[addr >> GEN8_PTE_SHIFT]);
         |  ^~~~~~
         |  writel
   drivers/gpu/drm/xe/xe_ggtt.c: At top level:
>> drivers/gpu/drm/xe/xe_ggtt.c:138:6: error: no previous prototype for 'xe_ggtt_invalidate' [-Werror=missing-prototypes]
     138 | void xe_ggtt_invalidate(struct xe_device *xe)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/xe_ggtt_invalidate +138 drivers/gpu/drm/xe/xe_ggtt.c

   137	
 > 138	void xe_ggtt_invalidate(struct xe_device *xe)
   139	{
   140		/* TODO: For GuC, we need to do something different here */
   141	
   142		/* TODO: i915 makes comments about this being uncached and
   143		 * therefore flushing WC buffers.  Is that really true here?
   144		 */
   145		xe_mmio_write32(xe, GFX_FLSH_CNTL_GEN6.reg, GFX_FLSH_CNTL_EN);
   146	}
   147	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
