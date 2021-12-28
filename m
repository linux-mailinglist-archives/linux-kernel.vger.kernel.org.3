Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC35F4806E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhL1Gw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:52:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:5300 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhL1Gwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640674375; x=1672210375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WuCP8OQYucvFMBKu0gplcWbrWLviARAhqDIPK1yuvVc=;
  b=DnwncEGGjj2MyURiUzmMPZjb2tTTCOVTo7PinA+riC30tyn2ViQ8H+ge
   3/HD08izu9JRLQPJP6riuCnaljmdvNJEDFUxwHOcVUw0eyD9RDNf/lHmO
   Xu0sGpSajOC7P9EqBlzQH2vmhjOfyqsguuQ2tKjmDLye498LCtnF7UG9T
   IJ+DsjHfv54O0lyqGgB3uKucbUy+KLedG8OVZQG272XMnaXjx1zl+y2Ud
   FHM4xdg+ukmRHJi9Xx36ib4hO/ylTw7dw4MGIjdcR9hBjpEHm1+ooWFN3
   NPpIkKjE/S/NikJvY+OrNVJ4dhxO5j2w25PnhPL+xTr51OD/KYTu9RxwL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="265551721"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="265551721"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 22:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="572243871"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2021 22:52:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n26Lt-0007L5-Dx; Tue, 28 Dec 2021 06:52:53 +0000
Date:   Tue, 28 Dec 2021 14:52:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: debug_vm_pgtable.c:undefined reference to `pmd_set_huge'
Message-ID: <202112281428.5oloqFOk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8ad9a2434dc7967ab285437f443cae633b6fc1c
commit: d8a719059b9dc963aa190598778ac804ff3e6a87 Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
date:   5 months ago
config: powerpc-randconfig-c024-20211012 (https://download.01.org/0day-ci/archive/20211228/202112281428.5oloqFOk-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8a719059b9dc963aa190598778ac804ff3e6a87
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8a719059b9dc963aa190598778ac804ff3e6a87
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: mm/debug_vm_pgtable.o: in function `debug_vm_pgtable':
>> debug_vm_pgtable.c:(.init.text+0x9d0): undefined reference to `pmd_set_huge'
>> powerpc-linux-ld: debug_vm_pgtable.c:(.init.text+0xaf4): undefined reference to `pud_set_huge'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
   (.text+0x424): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x4b0): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
   (.text+0x818): undefined reference to `unregister_framebuffer'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   (.text+0x9b8): undefined reference to `fb_dealloc_cmap'
   powerpc-linux-ld: (.text+0x9d8): undefined reference to `framebuffer_release'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
   (.text+0xbe8): undefined reference to `fb_sys_read'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
   (.text+0x34f8): undefined reference to `framebuffer_alloc'
   powerpc-linux-ld: (.text+0x3554): undefined reference to `fb_alloc_cmap'
   powerpc-linux-ld: (.text+0x3618): undefined reference to `fb_dealloc_cmap'
   powerpc-linux-ld: (.text+0x3674): undefined reference to `framebuffer_release'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x37b0): undefined reference to `register_framebuffer'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   (.text+0x4518): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x58f8): undefined reference to `fb_deferred_io_init'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
   (.text+0x644c): undefined reference to `fb_sys_write'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
   (.text+0x6534): undefined reference to `sys_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
   (.text+0x65b4): undefined reference to `sys_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
   (.text+0x6634): undefined reference to `sys_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
   (.text+0x66b4): undefined reference to `cfb_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
   (.text+0x6734): undefined reference to `cfb_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
   (.text+0x67b4): undefined reference to `cfb_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x6c30): undefined reference to `cfb_imageblit'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6c58): undefined reference to `sys_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x6d30): undefined reference to `cfb_copyarea'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6d58): undefined reference to `sys_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
   drm_fb_helper.c:(.text+0x6e30): undefined reference to `cfb_fillrect'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6e58): undefined reference to `sys_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x734c): undefined reference to `fb_deferred_io_cleanup'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
