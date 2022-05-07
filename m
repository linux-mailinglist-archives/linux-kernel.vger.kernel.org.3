Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3251E68F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384598AbiEGLDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 07:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384556AbiEGLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 07:03:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6433884
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651921161; x=1683457161;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Q9ZR2WPq17IEpVjTM0ufuyrgY5m5GmzbpV6xPimnk0=;
  b=hAvjA3T9vw02RGmhPqKUh92A9348STYR1CBMd8QSxw0XkhsAUVYhsHgL
   X51HvZ9jhryuAMbg6n0OW0L3Dyvdk9qwA7ml/+hwYW7aOCR4iLgRAuYdj
   qZn3N4YaCJPv2igX3ZM9FUXXzyk3hUvaRFC0mwUqiuCL9Fqdz+HKIjhEC
   mBptn+cFScs+cUw2Omh9r3FAIVDJpc3lLPOSluJFv8a33AyrI7DFIP4qd
   4K6GTwVKK7JZm1tV8IopT5c0hXR+Un8++s5klUDolU0vihD9Yn+Vg2mR7
   V2T6QRpNEispVmVU52jrFUC0bmL4XbsKEEGZNYx5ZWEkB4xuajQObvadv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="355128388"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="355128388"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 03:59:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="538290335"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2022 03:59:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnI9f-000EUZ-3i;
        Sat, 07 May 2022 10:59:19 +0000
Date:   Sat, 7 May 2022 18:58:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:efi-decompressor-v2 54/54]
 drivers/firmware/efi/libstub/zboot-header.S:26:2: error: #error
Message-ID: <202205071806.AV3wjnoe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-decompressor-v2
head:   544dc8b63197f7556a1fedba73aef92081257895
commit: 544dc8b63197f7556a1fedba73aef92081257895 [54/54] fixup! efi: stub: implement generic EFI zboot
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220507/202205071806.AV3wjnoe-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=544dc8b63197f7556a1fedba73aef92081257895
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-decompressor-v2
        git checkout 544dc8b63197f7556a1fedba73aef92081257895
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/zboot-header.S:26:2: error: #error 
      26 | #error
         |  ^~~~~


vim +26 drivers/firmware/efi/libstub/zboot-header.S

    16	
    17		.section	".head", "a"
    18		.globl		__efistub_efi_zboot_header
    19	__efistub_efi_zboot_header:
    20	.Ldoshdr:
    21		.long		MZ_MAGIC
    22		.org		.Ldoshdr + 0x38
    23	#if defined(CONFIG_ARM64)
    24		.ascii		"ARM\x64"
    25	#else
  > 26	#error
    27	#endif
    28		.long		.Lpehdr - .Ldoshdr
    29	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
