Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF1536490
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351094AbiE0PSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiE0PSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:18:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC734652
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653664697; x=1685200697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=37tz8zFSZQvEayi90XO9ga6Kw5o8083R/MK9RA/ED7o=;
  b=OpJsBaYWbWJGAGVKqG9sz0JK5iT25NZBYan4Sqj1AAsPgOraW6M2Eqax
   aQ2hKxs7Gnyz97YxTLCdPAeOdv1rafFmsdTxmDA1Bud6kCodQeT4Ei63b
   74FQmR8bqc5LTmHHqrlHbB8qfMBVtBBi2wnGPCl69odxkHj/WoukX7IbE
   +QfuMdDE20fgU0u1onUGHjJpNU1YOAnE/MNIw0R3aCWCM7xSKo3EVge/M
   n/yqgingt9fEp/r8G6gz7c+qxzVt0HYMPnVf0hMDyoWL1Q97A81GtrqPU
   3ioW16YYGWtzbFgXvmm1rfy7baVQ6DZhjV1UX8tEBmmnWByWcZrZlbqS7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274231426"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="274231426"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 08:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="560809582"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2022 08:18:15 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nubjC-0004sO-NP;
        Fri, 27 May 2022 15:18:14 +0000
Date:   Fri, 27 May 2022 23:17:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:63 amdgpu_gem_fault() warn:
 inconsistent indenting
Message-ID: <202205272322.o7pvBJIF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 71df0368e9b66afeb1fdb92a88be1a98cc25f310 drm/amdgpu: Implement mmap as GEM object function
date:   1 year ago
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220527/202205272322.o7pvBJIF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:63 amdgpu_gem_fault() warn: inconsistent indenting

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:824 amdgpu_gem_op_ioctl() warn: should 'robj->tbo.page_alignment << 14' be a 64 bit type?

vim +63 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c

    44	
    45	static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
    46	{
    47		struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
    48		struct drm_device *ddev = bo->base.dev;
    49		vm_fault_t ret;
    50		int idx;
    51	
    52		ret = ttm_bo_vm_reserve(bo, vmf);
    53		if (ret)
    54			return ret;
    55	
    56		if (drm_dev_enter(ddev, &idx)) {
    57			ret = amdgpu_bo_fault_reserve_notify(bo);
    58			if (ret) {
    59				drm_dev_exit(idx);
    60				goto unlock;
    61			}
    62	
  > 63			 ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
    64							TTM_BO_VM_NUM_PREFAULT, 1);
    65	
    66			 drm_dev_exit(idx);
    67		} else {
    68			ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
    69		}
    70		if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
    71			return ret;
    72	
    73	unlock:
    74		dma_resv_unlock(bo->base.resv);
    75		return ret;
    76	}
    77	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
