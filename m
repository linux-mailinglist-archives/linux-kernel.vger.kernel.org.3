Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D24A02E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351407AbiA1VfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:35:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:1082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348182AbiA1VfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643405704; x=1674941704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5L8PtVuNcJNPUwHCrWwWpztf9DMAfAdHQf7RvS+tIdE=;
  b=R8KrekLSOMjtgUHHaItoAYcfXQxzljXZv7gFY9fYW77oK32WkY8KQEaO
   N+siBuRRot48pkHUY8RaVFdKzTYCrx0A75KjtOQE0y5vk1PpDLn8K+IOY
   1ugx+Q7aNd+QdXcgkGCVqTmUyf/bXZPZAwHlqc5sY2xM8JC+CcrPalYJs
   KSfqCLJWNh1+lwu85Kwzw3ugy0CGr1GJ18Q0ySEmZ1B2ubadHJVY43YKI
   GDTZEDvPIHdQrzOCiAXLjAyayYnmU9LvN/L7Mld0TDJj3kNoS+kWPPJId
   j0t/cON0nDEgD81mO1fulM4pi5NOWvgCGT+yyEnQQ8lbWAGepQbTsRvm0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="234586240"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="234586240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="629254069"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2022 13:35:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDYta-000OM4-Lx; Fri, 28 Jan 2022 21:35:02 +0000
Date:   Sat, 29 Jan 2022 05:34:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso.c:58:38: warning: variable 'vdso_mapping_len' set
 but not used
Message-ID: <202201290517.FYpZzkIz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.17-vdso-mini-3
head:   8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
commit: 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16 [1/1] parisc: Add vDSO support
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201290517.FYpZzkIz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.17-vdso-mini-3
        git checkout 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/parisc/kernel/vdso.c: In function 'arch_setup_additional_pages':
>> arch/parisc/kernel/vdso.c:58:38: warning: variable 'vdso_mapping_len' set but not used [-Wunused-but-set-variable]
      58 |         unsigned long vdso_text_len, vdso_mapping_len;
         |                                      ^~~~~~~~~~~~~~~~


vim +/vdso_mapping_len +58 arch/parisc/kernel/vdso.c

    57	
  > 58		unsigned long vdso_text_len, vdso_mapping_len;
    59		unsigned long vdso_text_start;
    60		struct vm_special_mapping *vdso_mapping;
    61		struct mm_struct *mm = current->mm;
    62		struct vm_area_struct *vma;
    63		int rc;
    64	
    65		if (mmap_write_lock_killable(mm))
    66			return -EINTR;
    67	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
