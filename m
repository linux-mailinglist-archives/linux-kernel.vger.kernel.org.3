Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82934A55F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 05:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiBAEsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 23:48:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:12730 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbiBAEsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643690899; x=1675226899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BaEj6VFg+Zreve4ZOSPmGCGxsi/9RiTTu+QNTuTtYmY=;
  b=R1cfnqWG2Muwur9FkY0q0RJdnQJ7RjmQ/UL2dJyQw1K/1fiWjjjpn5rz
   XVzR0Zh+fYR0cxsZdg2LWg/Ki0+cz2vLCh7IwnEC/fRtHNA/gfiGVQs6T
   EelH86lU3Q6OyU7VKt/8hQ/zjXHeKHSLUsYEr+30/meTN9KgdHuDp95ps
   uFk7eALT2IKGe95Da1x4I//J24MMlr5z15/AgzeN1HjWVcICGJME8tML2
   qHD76uBX5KhdSn+0ICUuJ1eWNpGjfqoAv0zcPwLUTEbU7BfHL4AdFJfvT
   tlLRfpenQOZK1nciuYF6PbEJhYuGUHKII/jceN7eBxZ5NMyztSvP39Ktm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245210803"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="245210803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 20:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="698278272"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2022 20:48:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEl5U-000SnB-Rj; Tue, 01 Feb 2022 04:48:16 +0000
Date:   Tue, 1 Feb 2022 12:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [mtd:spi-mem-ecc 17/30] core.c:undefined reference to
 `of_get_nand_ecc_user_config'
Message-ID: <202202011225.0FOJ4kd2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc
head:   6d0fadec1de4434fce145b374ef25c665357fa60
commit: 319169b2a767b293984ae2c5e22268fecfb91864 [17/30] mtd: nand: ecc: Rework Kconfig dependencies
config: nds32-randconfig-r002-20220130 (https://download.01.org/0day-ci/archive/20220201/202202011225.0FOJ4kd2-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=319169b2a767b293984ae2c5e22268fecfb91864
        git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
        git fetch --no-tags mtd spi-mem-ecc
        git checkout 319169b2a767b293984ae2c5e22268fecfb91864
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/mtd/nand/core.o: in function `nanddev_ecc_engine_init':
>> core.c:(.text+0x69c): undefined reference to `of_get_nand_ecc_user_config'
>> nds32le-linux-ld: core.c:(.text+0x6a0): undefined reference to `of_get_nand_ecc_user_config'
>> nds32le-linux-ld: core.c:(.text+0x6c4): undefined reference to `nand_ecc_init_ctx'
   nds32le-linux-ld: core.c:(.text+0x6c8): undefined reference to `nand_ecc_init_ctx'
>> nds32le-linux-ld: core.c:(.text+0x6de): undefined reference to `nand_ecc_put_on_host_hw_engine'
   nds32le-linux-ld: core.c:(.text+0x6e2): undefined reference to `nand_ecc_put_on_host_hw_engine'
>> nds32le-linux-ld: core.c:(.text+0x70e): undefined reference to `nand_ecc_is_strong_enough'
   nds32le-linux-ld: core.c:(.text+0x712): undefined reference to `nand_ecc_is_strong_enough'
>> nds32le-linux-ld: core.c:(.text+0x728): undefined reference to `nand_ecc_get_on_die_hw_engine'
   nds32le-linux-ld: core.c:(.text+0x72c): undefined reference to `nand_ecc_get_on_die_hw_engine'
>> nds32le-linux-ld: core.c:(.text+0x73c): undefined reference to `nand_ecc_get_on_host_hw_engine'
   nds32le-linux-ld: core.c:(.text+0x740): undefined reference to `nand_ecc_get_on_host_hw_engine'
>> nds32le-linux-ld: core.c:(.text+0x758): undefined reference to `nand_ecc_get_sw_engine'
   nds32le-linux-ld: core.c:(.text+0x75c): undefined reference to `nand_ecc_get_sw_engine'
   nds32le-linux-ld: drivers/mtd/nand/core.o: in function `nanddev_ecc_engine_cleanup':
>> core.c:(.text+0x7e4): undefined reference to `nand_ecc_cleanup_ctx'
>> nds32le-linux-ld: core.c:(.text+0x7e8): undefined reference to `nand_ecc_cleanup_ctx'
   nds32le-linux-ld: core.c:(.text+0x804): undefined reference to `nand_ecc_put_on_host_hw_engine'
   nds32le-linux-ld: core.c:(.text+0x808): undefined reference to `nand_ecc_put_on_host_hw_engine'
   nds32le-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_cleanup_ctx':
>> ecc-sw-hamming.c:(.text+0x24): undefined reference to `nand_ecc_cleanup_req_tweaking'
>> nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x28): undefined reference to `nand_ecc_cleanup_req_tweaking'
   nds32le-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_init_ctx':
>> ecc-sw-hamming.c:(.text+0xe6): undefined reference to `nand_ecc_init_req_tweaking'
>> nds32le-linux-ld: ecc-sw-hamming.c:(.text+0xea): undefined reference to `nand_ecc_init_req_tweaking'
>> nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x19c): undefined reference to `nand_get_large_page_hamming_ooblayout'
   nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x1a0): undefined reference to `nand_get_large_page_hamming_ooblayout'
>> nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x1b0): undefined reference to `nand_get_small_page_ooblayout'
   nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x1b4): undefined reference to `nand_get_small_page_ooblayout'
   nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x1c8): undefined reference to `nand_ecc_cleanup_req_tweaking'
   nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x1cc): undefined reference to `nand_ecc_cleanup_req_tweaking'
   nds32le-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_prepare_io_req':
>> ecc-sw-hamming.c:(.text+0x614): undefined reference to `nand_ecc_tweak_req'
>> nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x618): undefined reference to `nand_ecc_tweak_req'
   nds32le-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_finish_io_req':
>> ecc-sw-hamming.c:(.text+0x9ca): undefined reference to `nand_ecc_restore_req'
>> nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x9ce): undefined reference to `nand_ecc_restore_req'
   nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x9ee): undefined reference to `nand_ecc_restore_req'
   nds32le-linux-ld: ecc-sw-hamming.c:(.text+0x9f2): undefined reference to `nand_ecc_restore_req'
   nds32le-linux-ld: net/core/sock.o: in function `sk_destruct':
   sock.c:(.text+0x2430): undefined reference to `__sk_defer_free_flush'
   nds32le-linux-ld: sock.c:(.text+0x2434): undefined reference to `__sk_defer_free_flush'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MTD_NAND_ECC_SW_HAMMING
   Depends on MTD && MTD_NAND_ECC
   Selected by
   - SM_FTL && MTD && BLOCK

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
