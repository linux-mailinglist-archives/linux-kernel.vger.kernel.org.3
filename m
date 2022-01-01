Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDAC482643
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiAABrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 20:47:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:33944 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbiAABrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 20:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641001643; x=1672537643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f0lgi0zZvWQGVZoC+5LrbSnaQl+q3qO3wCx/U3AEeVA=;
  b=HjX0CFd4yBpfMOf5UDoHjXwkIjHqkzVWnDTXOy14X8WqxIzh+ndqBoQ+
   /0DMTZgVqEsSrcF98AXndt7Eq1nHMUC9iBh1p/BHqhyiDMhqWoPE7y1AT
   D4QyfUkrmU5rQGdfly26sMu8EquzQTfgNvNVcnZNc+SKFAxpxi59LyzHR
   SZPf/ivM0g9EsKYa6/jeMHnKyO4PtWELWUQjTlVUWXHIp8GaAiI0yv5Eo
   r47CsSqW/HR28RP8u6+0Fnft0fx6qLeEG+43H/6N5If/X/lhgpMS3EAAa
   GOnAdQ9fbBrpXQBQC6GqM8Co7DXJhKyHa3cbmbhiZPQVNi0cDeQigj6Qo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="305219786"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="305219786"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 17:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="525431420"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 Dec 2021 17:47:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3TUO-000BsS-Tr; Sat, 01 Jan 2022 01:47:20 +0000
Date:   Sat, 1 Jan 2022 09:46:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>
Subject: arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for
 'kvm_compute_final_ctr_el0'
Message-ID: <202201010911.XqBcZAZG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 755db23420a1ce4b740186543432983e9bbe713e KVM: arm64: Generate final CTR_EL0 value when running in Protected mode
date:   9 months ago
config: arm64-randconfig-r035-20211231 (https://download.01.org/0day-ci/archive/20220101/202201010911.XqBcZAZG-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=755db23420a1ce4b740186543432983e9bbe713e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 755db23420a1ce4b740186543432983e9bbe713e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/va_layout.c:188:6: warning: no previous prototype for 'kvm_patch_vector_branch' [-Wmissing-prototypes]
     188 | void kvm_patch_vector_branch(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/va_layout.c:286:6: warning: no previous prototype for 'kvm_get_kimage_voffset' [-Wmissing-prototypes]
     286 | void kvm_get_kimage_voffset(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for 'kvm_compute_final_ctr_el0' [-Wmissing-prototypes]
     292 | void kvm_compute_final_ctr_el0(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kvm_compute_final_ctr_el0 +292 arch/arm64/kvm/va_layout.c

   291	
 > 292	void kvm_compute_final_ctr_el0(struct alt_instr *alt,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
