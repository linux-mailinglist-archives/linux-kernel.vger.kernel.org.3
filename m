Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875AE4F0E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbiDDEgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:35:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0C30574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649046841; x=1680582841;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PlM82ilcyWV+em0tkIVkqDixm5NaYWMzl45Hg+Pc/dw=;
  b=OceOar/bAynpz4bMHCJ2HVwtY2vE6O/p36VFdbk1VrQ8aiEyS11H6HRt
   udP4oKrbjV3yeeoHzZaU74FWFBrY/14BpQILxtjqaQa8mFGBP15+CQQE6
   XkoYj8M+7US7zT4qT492pOICvS/nXyj9JnsPqOhNy19bhPB88AB7uOry2
   nVkCe0HE/wTh7wfonwiahagdtdIErDrbWLRNJ48gr080G3Dzho+bs0n48
   DwMk44KYuefP0ESRkUC+Q3Flz5lDu0iH037Dega07HQEu0zvIhyfXBhCK
   11ezJC2QDhtOCtR0iaTu6rx9l5KVmQ41hOi/MRPI+hwJYVcohco0xpmZh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323610656"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="323610656"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 21:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="721510786"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2022 21:33:59 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbEPf-0001aX-5I;
        Mon, 04 Apr 2022 04:33:59 +0000
Date:   Mon, 4 Apr 2022 12:33:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <202204041241.Hw855BWm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: d31ed5d767c0452b4f49846d80a0bfeafa3a4ded kbuild: Fixup the IBT kbuild changes
date:   12 days ago
config: x86_64-randconfig-a011-20220404 (https://download.01.org/0day-ci/archive/20220404/202204041241.Hw855BWm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d31ed5d767c0452b4f49846d80a0bfeafa3a4ded
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d31ed5d767c0452b4f49846d80a0bfeafa3a4ded
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR: vlv_allow_gt_wake.cold+0x0
   drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: gen6_alloc_va_range.cold()+0x1c6: relocation to !ENDBR: i915_vma_unpin.cold+0x0
>> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: fence_update.cold()+0x14a: relocation to !ENDBR: i915_vma_revoke_fence.cold+0x0
   drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: eb_move_to_gpu.cold()+0x52: relocation to !ENDBR: i915_reset_gen7_sol_offsets.cold+0x0
>> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: __i915_gem_object_release_mmap_gtt.cold()+0xce: relocation to !ENDBR: i915_gem_mmap.cold+0x0
   drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: i915_ttm_io_mem_pfn.cold()+0x52: relocation to !ENDBR: i915_ttm_delayed_free.cold+0x0
>> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: ttm_vm_close.cold()+0x52: relocation to !ENDBR: ttm_vm_open.cold+0x0
   drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: ttm_vm_open.cold()+0x52: relocation to !ENDBR: i915_ttm_shrinker_release_pages.cold+0x0

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
