Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6A4D4C55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiCJOzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346342AbiCJOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:43:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1D413C9C3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646923342; x=1678459342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OJKaj+dkol1FacgiHUcMifV8v9tMiNuuIHX0fa00Bf0=;
  b=cZYxKy9zOUtL4DMKQVD40nTVZPagwdvFwMkC82MsqvwiV81YMSEO/Hpj
   PcZwoOxdR6+JWOniW9KMXA56Au/OXjhomEVHujyhrLvF8oJgBcrsoGrZu
   h7opOcVEaBUNoT5pg4GhPDFL5x9z30n3VvWKVbXM+NdPuuUB7IR3ZvcIT
   iUyPqaYXtvnFzUcdQF9O0s5Tq4NGy+pJtIuaoa1oeap50rQsWyfP3PjCu
   WTzGTnFBLhPS2e7nD6CYGXx0Qvw0iGaglhEpTFI4/DTmDY/0qX7BLYQ0f
   YEzQYcbn2Hp1zrOrznSJ8WNTLMMhqrSj9qBtoRoYLAwCbsdbVR3Oub0Jy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255455234"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="255455234"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="633006274"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2022 06:42:21 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSJzg-00051c-7O; Thu, 10 Mar 2022 14:42:20 +0000
Date:   Thu, 10 Mar 2022 22:42:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>
Subject: arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for
 function 'kvm_compute_final_ctr_el0'
Message-ID: <202203102230.x3TDH4ku-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1db333d9a51f3459fba1bcaa564d95befe79f0b3
commit: 755db23420a1ce4b740186543432983e9bbe713e KVM: arm64: Generate final CTR_EL0 value when running in Protected mode
date:   12 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220310/202203102230.x3TDH4ku-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=755db23420a1ce4b740186543432983e9bbe713e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 755db23420a1ce4b740186543432983e9bbe713e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ arch/arm64/kvm/ drivers/gpu/drm/tegra/ drivers/usb/host/ kernel/debug/kdb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/va_layout.c:188:6: warning: no previous prototype for function 'kvm_patch_vector_branch' [-Wmissing-prototypes]
   void kvm_patch_vector_branch(struct alt_instr *alt,
        ^
   arch/arm64/kvm/va_layout.c:188:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kvm_patch_vector_branch(struct alt_instr *alt,
   ^
   static 
   arch/arm64/kvm/va_layout.c:286:6: warning: no previous prototype for function 'kvm_get_kimage_voffset' [-Wmissing-prototypes]
   void kvm_get_kimage_voffset(struct alt_instr *alt,
        ^
   arch/arm64/kvm/va_layout.c:286:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kvm_get_kimage_voffset(struct alt_instr *alt,
   ^
   static 
>> arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for function 'kvm_compute_final_ctr_el0' [-Wmissing-prototypes]
   void kvm_compute_final_ctr_el0(struct alt_instr *alt,
        ^
   arch/arm64/kvm/va_layout.c:292:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kvm_compute_final_ctr_el0(struct alt_instr *alt,
   ^
   static 
   3 warnings generated.


vim +/kvm_compute_final_ctr_el0 +292 arch/arm64/kvm/va_layout.c

   291	
 > 292	void kvm_compute_final_ctr_el0(struct alt_instr *alt,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
