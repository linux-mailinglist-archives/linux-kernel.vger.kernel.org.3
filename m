Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67678591FE7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiHNNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiHNNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:43:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E319C27
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660484581; x=1692020581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ebr5SWpmtIXAfQaqkbZNfQ/Lfm/dAXGXgHY8WLfEXJw=;
  b=XmVBcGd5c3Ee0jzbnnvFCvnBn9i7mjIupVT9H6/rbvAQ/vo7mE7nvxqH
   mQUj7+bnGMjoSIO/q3+q6lHjyLsvn5aI87OCx0TKHYLAOr7G09zkhPoBD
   P8iXGNaov3sOJuu4FqVACnxQSeQny7WSAJIClyqXvs+AEnMzkhox+ZP/+
   ViakQ2Y8H704Sp60xOHkClZ0b0JrkuWKdihRuxlBYD0J+LOLfTLwXeK0z
   3fw4EAqN64dmhTrl4NICYra3TyPgTMJuxb+ljRmgtLdn9RD/qEb0xAn3i
   0ojEW+DiPlcG7W0z0LqLulIx8lYYcydfYPbMN3XyNd5KMPpg5DSJeAowy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274881143"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274881143"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 06:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="582594524"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 06:42:58 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNDtK-00008g-0K;
        Sun, 14 Aug 2022 13:42:58 +0000
Date:   Sun, 14 Aug 2022 21:42:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: irq-loongson-pch-pic.c:undefined reference to `pch_lpc_acpi_init'
Message-ID: <202208142108.qFi7EGi7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: bcdd75c596c89d7925a3438fde2578ca23a62b06 irqchip/loongson-pch-pic: Add ACPI init support
date:   4 weeks ago
config: loongarch-randconfig-r024-20220814 (https://download.01.org/0day-ci/archive/20220814/202208142108.qFi7EGi7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcdd75c596c89d7925a3438fde2578ca23a62b06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bcdd75c596c89d7925a3438fde2578ca23a62b06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: arch/loongarch/kernel/env.o: in function `init_environ':
   env.c:(.init.text+0x130): undefined reference to `efi'
   loongarch64-linux-ld: env.c:(.init.text+0x134): undefined reference to `efi'
   loongarch64-linux-ld: env.c:(.init.text+0x134): undefined reference to `efi'
   loongarch64-linux-ld: env.c:(.init.text+0x164): undefined reference to `efi_get_fdt_params'
   loongarch64-linux-ld: env.c:(.init.text+0x17c): undefined reference to `efi_memmap_init_early'
   loongarch64-linux-ld: arch/loongarch/kernel/setup.o: in function `platform_init':
   setup.c:(.init.text+0x4f0): undefined reference to `efi_init'
   loongarch64-linux-ld: setup.c:(.init.text+0x530): undefined reference to `efi_runtime_init'
   loongarch64-linux-ld: arch/loongarch/kernel/mem.o: in function `memblock_init':
   mem.c:(.init.text+0x24): undefined reference to `efi'
   loongarch64-linux-ld: mem.c:(.init.text+0x28): undefined reference to `efi'
   loongarch64-linux-ld: mem.c:(.init.text+0x28): undefined reference to `efi'
   loongarch64-linux-ld: drivers/irqchip/irq-loongson-pch-pic.o: in function `pch_lpc_parse_madt':
>> irq-loongson-pch-pic.c:(.init.text+0x14): undefined reference to `pch_lpc_acpi_init'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
