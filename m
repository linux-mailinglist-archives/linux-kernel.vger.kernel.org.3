Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433425A3797
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiH0MVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0MVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:21:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D63B966
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661602909; x=1693138909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eUZxz/z522sUn+AGvgw51Mail8p638/sMS8PlT+g7gg=;
  b=Ici92rqbhS2ZojXif6mMzSqPCbmZ1QhFLOQA1r6gHiSloWxm8ofqrMWP
   yqGUY6rDI/z2vpI5BYejh5Fx6FNZHIEf/Vp8TiDx1997Cwn2TQUnPuGZ1
   CW+Pjy+i8TgVReE4K5vqDg838VNnBA9DA08vAQHGhqDAkiNigKHtN5QSq
   GiFAZcS/DgYPvMImx6ZqhUWLGFzdEClgVGINgsUmsMWMMHwdJofmNhEEx
   9xe0ROd4EPZE5yYK68bzJsqL5mCHoaPGJXYrgya8Gffzlntlhy0jUxoXu
   +6qBhKinqtH/+XpAB7lGBWuNzT3QyxobBRqVsP2by+qnldi8JdjMwLHdw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="275062141"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="275062141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 05:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="587619622"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2022 05:21:47 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRuot-00009X-0d;
        Sat, 27 Aug 2022 12:21:47 +0000
Date:   Sat, 27 Aug 2022 20:21:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:efi-decompressor-v4 6/10]
 drivers/firmware/efi/libstub/zboot.c:161:23: warning: no previous prototype
 for function 'efi_zboot_entry'
Message-ID: <202208272044.kV41yO8J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-decompressor-v4
head:   efcc03a013f2ddbed0ee782e5049b39432dc9db2
commit: d2c8eb1ea770556c25e2b5d884bf6bba32940bf2 [6/10] efi/libstub: implement generic EFI zboot
config: riscv-randconfig-r042-20220825 (https://download.01.org/0day-ci/archive/20220827/202208272044.kV41yO8J-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=d2c8eb1ea770556c25e2b5d884bf6bba32940bf2
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-decompressor-v4
        git checkout d2c8eb1ea770556c25e2b5d884bf6bba32940bf2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/zboot.c:161:23: warning: no previous prototype for function 'efi_zboot_entry' [-Wmissing-prototypes]
   efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
                         ^
   drivers/firmware/efi/libstub/zboot.c:161:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
   ^
   static 
   1 warning generated.


vim +/efi_zboot_entry +161 drivers/firmware/efi/libstub/zboot.c

   160	
 > 161	efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
