Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7EE489884
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiAJMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:23:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:45866 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245353AbiAJMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641817372; x=1673353372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gmL3tKEUDF2ZwVHFtsNVYcZn2op8HEU3muwCY7UW7MI=;
  b=kgQWlMj0ktvyzG1cepOQZiNBRAlxy1oi7uhc81GY8Ljs5b73KECPdhGv
   asWxIWnTzfVYVICEAwg3KK18MvBRuByCCY6dSGxBShnE/1d0zC3ipc7nT
   pXkDveB3h5oeEStMzyNmUvIIBdgoq5T3w//pyn0b0QWEjdhyrDmRDMEc9
   xVP4tipvl2zukm/aisjO4vhu7LbUevLl3VVWSjEzysNnKbKwznjwbYsJR
   1AhJQ6h9zB6gcE4buBot1R06hibaiol4IYYlDD3xmSIu5hP4tdjfUVAGe
   1favtSJhEiSVzC2vMs7VYtY7bGj1P20RwDih8NsAjkqZ+7MIZqHg3wi2y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="242025013"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242025013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 04:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="669436824"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2022 04:21:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6tgI-0003JN-16; Mon, 10 Jan 2022 12:21:46 +0000
Date:   Mon, 10 Jan 2022 20:21:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Colin Xu <colin.xu@intel.com>
Subject: drivers/gpu/drm/i915/gvt/gtt.c:1152: warning: This comment starts
 with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202201102031.xPWND4ZH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenyu,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   df0cc57e057f18e44dac8e6c18aba47ab53202f9
commit: 145e06b58f8625becc61792a0554726314297a85 drm/i915/gvt: Move mdev attribute groups into kvmgt module
date:   8 months ago
config: x86_64-randconfig-a016-20210927 (https://download.01.org/0day-ci/archive/20220110/202201102031.xPWND4ZH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=145e06b58f8625becc61792a0554726314297a85
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 145e06b58f8625becc61792a0554726314297a85
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gvt/gtt.c:1152: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Check if can do 2M page
   drivers/gpu/drm/i915/gvt/gtt.c:2209: warning: expecting prototype for intel_vgpu_emulate_gtt_mmio_read(). Prototype was for intel_vgpu_emulate_ggtt_mmio_read() instead


vim +1152 drivers/gpu/drm/i915/gvt/gtt.c

2707e44466881d Zhi Wang          2016-03-28  1150  
b901b252b6cf5c Changbin Du       2018-05-15  1151  /**
a752b070a67823 Zhenyu Wang       2018-07-31 @1152   * Check if can do 2M page
a752b070a67823 Zhenyu Wang       2018-07-31  1153   * @vgpu: target vgpu
a752b070a67823 Zhenyu Wang       2018-07-31  1154   * @entry: target pfn's gtt entry
a752b070a67823 Zhenyu Wang       2018-07-31  1155   *
9317f356df83a5 Bhaskar Chowdhury 2021-02-22  1156   * Return 1 if 2MB huge gtt shadowing is possible, 0 if miscondition,
9317f356df83a5 Bhaskar Chowdhury 2021-02-22  1157   * negative if found err.
b901b252b6cf5c Changbin Du       2018-05-15  1158   */
b901b252b6cf5c Changbin Du       2018-05-15  1159  static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
b901b252b6cf5c Changbin Du       2018-05-15  1160  	struct intel_gvt_gtt_entry *entry)
b901b252b6cf5c Changbin Du       2018-05-15  1161  {
b901b252b6cf5c Changbin Du       2018-05-15  1162  	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
b901b252b6cf5c Changbin Du       2018-05-15  1163  	unsigned long pfn;
b901b252b6cf5c Changbin Du       2018-05-15  1164  
a61ac1e75105a0 Chris Wilson      2020-03-06  1165  	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
b901b252b6cf5c Changbin Du       2018-05-15  1166  		return 0;
b901b252b6cf5c Changbin Du       2018-05-15  1167  
b901b252b6cf5c Changbin Du       2018-05-15  1168  	pfn = intel_gvt_hypervisor_gfn_to_mfn(vgpu, ops->get_pfn(entry));
b901b252b6cf5c Changbin Du       2018-05-15  1169  	if (pfn == INTEL_GVT_INVALID_ADDR)
b901b252b6cf5c Changbin Du       2018-05-15  1170  		return -EINVAL;
b901b252b6cf5c Changbin Du       2018-05-15  1171  
b901b252b6cf5c Changbin Du       2018-05-15  1172  	return PageTransHuge(pfn_to_page(pfn));
b901b252b6cf5c Changbin Du       2018-05-15  1173  }
b901b252b6cf5c Changbin Du       2018-05-15  1174  

:::::: The code at line 1152 was first introduced by commit
:::::: a752b070a67823174565322cc48b2668daf9a8da drm/i915/gvt: Fix function comment doc errors

:::::: TO: Zhenyu Wang <zhenyuw@linux.intel.com>
:::::: CC: Zhenyu Wang <zhenyuw@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
