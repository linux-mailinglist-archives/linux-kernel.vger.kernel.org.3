Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC249B524
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577316AbiAYNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:31:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:29555 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1576948AbiAYN13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643117245; x=1674653245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=peUlmQKoI3YaY4Z7s9fLNbwiNiZpCSukj/4sETQHY2k=;
  b=KEht3x7SjvS1Ndy2+mh45ON/scKgCfq9U/Vxl6HbvUGyJmWrwQbqnumg
   z4Y0EveDoh6p2oD3OyNdU5lWGKGd62nu9C2oqX559+34lTZnIKaLG4+q3
   rcbZwgx8+leVpGbRlMn/rzMTcfqdEV5r2FxVHyFfJvdZO6JVOWG6h+cqR
   uyJrZcWV+jvZfkAAC7WpzgVJn/UB8mrz3sQBlTuE4mqWq1vlM+CE6hKdX
   UYPkLpc12NLJDajeqDebuXtGpTWWl1qHtgf3IDPQ+EPuUGnjwkp7B/xOv
   uI1HICzOX3ONQMH7QXuyWJgKz97AjIdrdTG9o8Fwb0rTxzYxdZIRENt1M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="307012506"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="307012506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479488395"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 05:21:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCLlj-000Jvn-5g; Tue, 25 Jan 2022 13:21:55 +0000
Date:   Tue, 25 Jan 2022 21:21:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 25/165] drivers/gpu/drm/xe/xe_vm.c:124:15: error: no
 previous prototype for 'xe_pt_create'
Message-ID: <202201252146.Y5Mz2bte-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 51863276ebe41e455cac1388eae8b3f2fc33fe0b [25/165] We've got something that looks like page tables
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201252146.Y5Mz2bte-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 51863276ebe41e455cac1388eae8b3f2fc33fe0b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_vm.c:124:15: error: no previous prototype for 'xe_pt_create' [-Werror=missing-prototypes]
     124 | struct xe_pt *xe_pt_create(struct xe_device *xe, struct xe_vm *vm,
         |               ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_vm.c:273:12: error: 'xe_pt_populate' defined but not used [-Werror=unused-function]
     273 | static int xe_pt_populate(struct xe_device *xe, struct xe_vm *vm,
         |            ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_vm.c:228:13: error: 'xe_pt_clear' defined but not used [-Werror=unused-function]
     228 | static void xe_pt_clear(struct xe_pt *pt, uint64_t start, uint64_t end,
         |             ^~~~~~~~~~~
   drivers/gpu/drm/xe/xe_vm.c:114:13: error: 'xe_pt_0_set_live' defined but not used [-Werror=unused-function]
     114 | static bool xe_pt_0_set_live(struct xe_pt_0 *pt, unsigned int idx)
         |             ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_vm.c:49:17: error: 'gen8_pte_encode' defined but not used [-Werror=unused-function]
      49 | static uint64_t gen8_pte_encode(dma_addr_t addr,
         |                 ^~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_vm.c:36:17: error: 'gen8_pde_encode' defined but not used [-Werror=unused-function]
      36 | static uint64_t gen8_pde_encode(const dma_addr_t addr,
         |                 ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/xe_pt_create +124 drivers/gpu/drm/xe/xe_vm.c

   123	
 > 124	struct xe_pt *xe_pt_create(struct xe_device *xe, struct xe_vm *vm,
   125				   unsigned int level)
   126	{
   127		struct xe_pt *pt;
   128		struct xe_bo *bo;
   129		size_t size;
   130	
   131		size = level ? sizeof(struct xe_pt_dir) : sizeof(struct xe_pt_0);
   132		pt = kzalloc(size, GFP_KERNEL);
   133		if (!pt)
   134			return NULL;
   135	
   136		bo = xe_bo_create(xe, SZ_4K, vm, ttm_bo_type_kernel, 0);
   137		if (IS_ERR(bo)) {
   138			kfree(pt);
   139			return ERR_CAST(bo);
   140		}
   141	
   142		pt->bo = bo;
   143		pt->level = level;
   144		pt->num_live = 0;
   145	
   146		return pt;
   147	}
   148	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
