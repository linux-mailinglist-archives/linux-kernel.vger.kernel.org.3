Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53B257F8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiGYEfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 00:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYEfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 00:35:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B36DDF03
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658723701; x=1690259701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I2SLO4dCpAcfHZlc7mOrl4GrpsEMOZ+vdDC3yry863o=;
  b=dSk9LuZW9xtMsog/u8SKxNr7DtsIsFi+hvMGVLCv/7ctXVgHsAA6wIfB
   sIsdnJh0gjooGqTfJiYCriah1mAk+ktnero2rWizdsWErTD3KHIXkTL37
   fipdVoNL4aBloPqlNoe2oefjw199HUEs7mUiiW3qiXxi7J2EpancpmPE3
   Gd9wfRI44+x/FMlA1ZqwZcmcSsRgNdBMTOeWAKTs7mjDFvvKbWvFrJg88
   hV5M4F5/oZrUZ0s9fMQOdJg1jy9R1J1SzFkuDJJbhxGrlpPZaOoTbNDzb
   F3xo6KM5BoncenhmsO9TPAF/u7ZdMPSm4xilicoLrCl2aN6PiNVc9iRVW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288791062"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288791062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 21:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="741696633"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2022 21:34:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFpo2-0004jV-2b;
        Mon, 25 Jul 2022 04:34:58 +0000
Date:   Mon, 25 Jul 2022 12:34:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-attest 4/6] ebda.c:(.text+0x0): multiple definition
 of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0):
 first defined here
Message-ID: <202207251242.ga7J0oaX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   79bafa5b3cf70766a5a52e4338aa3ed9bc94205f
commit: e0fa61c75620a8b0c0eaf08cefd4023afcf78c8d [4/6] x86/coco: Add cc_decrypted_alloc/free() interfaces
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220725/202207251242.ga7J0oaX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/e0fa61c75620a8b0c0eaf08cefd4023afcf78c8d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout e0fa61c75620a8b0c0eaf08cefd4023afcf78c8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/ebda.o: in function `cc_decrypted_alloc':
>> ebda.c:(.text+0x0): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/ebda.o: in function `cc_decrypted_free':
>> ebda.c:(.text+0x3): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: init/main.o: in function `cc_decrypted_alloc':
   main.c:(.text+0x794): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: init/main.o: in function `cc_decrypted_free':
   main.c:(.text+0x79c): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: init/do_mounts.o: in function `cc_decrypted_alloc':
   do_mounts.c:(.text+0x19d): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: init/do_mounts.o: in function `cc_decrypted_free':
   do_mounts.c:(.text+0x1a5): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: init/do_mounts_initrd.o: in function `cc_decrypted_alloc':
   do_mounts_initrd.c:(.text+0x0): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: init/do_mounts_initrd.o: in function `cc_decrypted_free':
   do_mounts_initrd.c:(.text+0x8): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: init/initramfs.o: in function `cc_decrypted_alloc':
   initramfs.c:(.text+0x55): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: init/initramfs.o: in function `cc_decrypted_free':
   initramfs.c:(.text+0x5d): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: init/init_task.o: in function `cc_decrypted_alloc':
   init_task.c:(.text+0x0): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: init/init_task.o: in function `cc_decrypted_free':
   init_task.c:(.text+0x8): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/entry/syscall_64.o: in function `cc_decrypted_free':
   syscall_64.c:(.text+0x3): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/entry/syscall_64.o: in function `cc_decrypted_alloc':
   syscall_64.c:(.text+0x0): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/entry/common.o: in function `cc_decrypted_free':
   common.c:(.text+0x3): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/entry/common.o: in function `cc_decrypted_alloc':
   common.c:(.text+0x0): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `cc_decrypted_alloc':
   vma.c:(.text+0x2cc): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `cc_decrypted_free':
   vma.c:(.text+0x2cf): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/entry/vdso/extable.o: in function `cc_decrypted_alloc':
   extable.c:(.text+0x0): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/extable.o: in function `cc_decrypted_free':
   extable.c:(.text+0x3): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/entry/vsyscall/vsyscall_64.o: in function `cc_decrypted_alloc':
   vsyscall_64.c:(.text+0x318): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vsyscall/vsyscall_64.o: in function `cc_decrypted_free':
   vsyscall_64.c:(.text+0x320): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/core.o: in function `cc_decrypted_alloc':
   core.c:(.text+0x178e): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/core.o: in function `cc_decrypted_free':
   core.c:(.text+0x1796): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/rapl.o: in function `cc_decrypted_alloc':
   rapl.c:(.text+0x73a): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/rapl.o: in function `cc_decrypted_free':
   rapl.c:(.text+0x742): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/amd/core.o: in function `cc_decrypted_alloc':
   core.c:(.text+0x1243): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/amd/core.o: in function `cc_decrypted_free':
   core.c:(.text+0x124b): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/amd/ibs.o: in function `cc_decrypted_alloc':
   ibs.c:(.text+0x102e): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/amd/ibs.o: in function `cc_decrypted_free':
   ibs.c:(.text+0x1036): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/msr.o: in function `cc_decrypted_alloc':
   msr.c:(.text+0x37e): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/msr.o: in function `cc_decrypted_free':
   msr.c:(.text+0x386): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/core.o: in function `cc_decrypted_alloc':
   core.c:(.text+0x3286): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/core.o: in function `cc_decrypted_free':
   core.c:(.text+0x328e): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/bts.o: in function `cc_decrypted_alloc':
   bts.c:(.text+0xafd): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/bts.o: in function `cc_decrypted_free':
   bts.c:(.text+0xb05): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/ds.o: in function `cc_decrypted_alloc':
   ds.c:(.text+0x23c6): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/ds.o: in function `cc_decrypted_free':
   ds.c:(.text+0x23ce): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/knc.o: in function `cc_decrypted_alloc':
   knc.c:(.text+0x43a): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/knc.o: in function `cc_decrypted_free':
   knc.c:(.text+0x442): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/lbr.o: in function `cc_decrypted_alloc':
   lbr.c:(.text+0xdcd): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/lbr.o: in function `cc_decrypted_free':
   lbr.c:(.text+0xdd5): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/p4.o: in function `cc_decrypted_alloc':
   p4.c:(.text+0xa94): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/p4.o: in function `cc_decrypted_free':
   p4.c:(.text+0xa9c): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/p6.o: in function `cc_decrypted_alloc':
   p6.c:(.text+0x232): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/p6.o: in function `cc_decrypted_free':
   p6.c:(.text+0x23a): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/pt.o: in function `cc_decrypted_alloc':
   pt.c:(.text+0x2321): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/pt.o: in function `cc_decrypted_free':
   pt.c:(.text+0x2329): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/uncore.o: in function `cc_decrypted_alloc':
   uncore.c:(.text+0x112c): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/uncore.o: in function `cc_decrypted_free':
   uncore.c:(.text+0x1134): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here
   ld: arch/x86/events/intel/uncore_nhmex.o: in function `cc_decrypted_alloc':
   uncore_nhmex.c:(.text+0x1a2e): multiple definition of `cc_decrypted_alloc'; arch/x86/kernel/head64.o:head64.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/uncore_nhmex.o: in function `cc_decrypted_free':
   uncore_nhmex.c:(.text+0x1a36): multiple definition of `cc_decrypted_free'; arch/x86/kernel/head64.o:head64.c:(.text+0x3): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
