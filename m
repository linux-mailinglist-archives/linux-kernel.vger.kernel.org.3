Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621224A575D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiBAGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 01:51:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:29618 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233800AbiBAGvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643698284; x=1675234284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TtE+PZc+j+Iz2bV8AGmpAKEOz9pdg8QEJ0yuPv7zzKg=;
  b=AlZwZ6JgcLn+un3nCfDUVfE91QPK9IVSar9LLLzE+nUxh+hO8w5U59q2
   FNi+6+ReCr0wQQVFkkpKlkRBP1g7mNdiqAVVjRgRx4iZDavxAJj8RrIpc
   dwqzGWBXg5LzoPNTIHEwKoreOUPBiJpKpslxjwR0xyF4LRhgvYklLFKTB
   revFUyLMDmvzEQIVFbh6z43hC15kP1VmxLzFtz+hW7j8yBCwDRnW2bFqP
   yR8arhhZtJiN7+ETcPJO1kC61C8kre09cKoPyFR1FZCnvtpQTKI0X2Xy5
   FSdl5ylRfGV2P9qFKleQivAl6iiUJcmPdfnANhI2Kb3mInAcPMAXho6hH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308364058"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="308364058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 22:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="565502927"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2022 22:51:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEn0c-000Su3-5z; Tue, 01 Feb 2022 06:51:22 +0000
Date:   Tue, 1 Feb 2022 14:50:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [mtd:spi-mem-ecc 17/30] nios2-linux-ld: core.c:undefined reference
 to `nand_ecc_get_on_die_hw_engine'
Message-ID: <202202011416.yZ7MuZxH-lkp@intel.com>
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
config: nios2-randconfig-c004-20220130 (https://download.01.org/0day-ci/archive/20220201/202202011416.yZ7MuZxH-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=319169b2a767b293984ae2c5e22268fecfb91864
        git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
        git fetch --no-tags mtd spi-mem-ecc
        git checkout 319169b2a767b293984ae2c5e22268fecfb91864
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/mtd/nand/core.o: in function `nanddev_ecc_engine_init':
   core.c:(.text+0x88c): undefined reference to `of_get_nand_ecc_user_config'
   core.c:(.text+0x88c): relocation truncated to fit: R_NIOS2_CALL26 against `of_get_nand_ecc_user_config'
>> nios2-linux-ld: core.c:(.text+0x8cc): undefined reference to `nand_ecc_get_on_die_hw_engine'
   core.c:(.text+0x8cc): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_get_on_die_hw_engine'
>> nios2-linux-ld: core.c:(.text+0x8dc): undefined reference to `nand_ecc_init_ctx'
   core.c:(.text+0x8dc): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_init_ctx'
>> nios2-linux-ld: core.c:(.text+0x904): undefined reference to `nand_ecc_put_on_host_hw_engine'
   core.c:(.text+0x904): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_put_on_host_hw_engine'
>> nios2-linux-ld: core.c:(.text+0x918): undefined reference to `nand_ecc_get_sw_engine'
   core.c:(.text+0x918): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_get_sw_engine'
>> nios2-linux-ld: core.c:(.text+0x928): undefined reference to `nand_ecc_is_strong_enough'
   core.c:(.text+0x928): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_is_strong_enough'
>> nios2-linux-ld: core.c:(.text+0x960): undefined reference to `nand_ecc_get_on_host_hw_engine'
   core.c:(.text+0x960): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_get_on_host_hw_engine'
   nios2-linux-ld: drivers/mtd/nand/core.o: in function `nanddev_ecc_engine_cleanup':
   core.c:(.text+0x9cc): undefined reference to `nand_ecc_cleanup_ctx'
   core.c:(.text+0x9cc): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_cleanup_ctx'
   nios2-linux-ld: core.c:(.text+0x9f8): undefined reference to `nand_ecc_put_on_host_hw_engine'
   core.c:(.text+0x9f8): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_put_on_host_hw_engine'
   nios2-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_cleanup_ctx':
   ecc-sw-hamming.c:(.text+0x18): undefined reference to `nand_ecc_cleanup_req_tweaking'
   ecc-sw-hamming.c:(.text+0x18): relocation truncated to fit: R_NIOS2_CALL26 against `nand_ecc_cleanup_req_tweaking'
   nios2-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_init_ctx':
   ecc-sw-hamming.c:(.text+0xbc): undefined reference to `nand_ecc_init_req_tweaking'
   ecc-sw-hamming.c:(.text+0xbc): additional relocation overflows omitted from the output
>> nios2-linux-ld: ecc-sw-hamming.c:(.text+0x178): undefined reference to `nand_get_small_page_ooblayout'
>> nios2-linux-ld: ecc-sw-hamming.c:(.text+0x194): undefined reference to `nand_get_large_page_hamming_ooblayout'
>> nios2-linux-ld: ecc-sw-hamming.c:(.text+0x1a4): undefined reference to `nand_ecc_cleanup_req_tweaking'
   nios2-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_prepare_io_req':
   ecc-sw-hamming.c:(.text+0x7a8): undefined reference to `nand_ecc_tweak_req'
   nios2-linux-ld: drivers/mtd/nand/ecc-sw-hamming.o: in function `nand_ecc_sw_hamming_finish_io_req':
   ecc-sw-hamming.c:(.text+0xb7c): undefined reference to `nand_ecc_restore_req'
>> nios2-linux-ld: ecc-sw-hamming.c:(.text+0xc78): undefined reference to `nand_ecc_restore_req'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MTD_NAND_ECC_SW_HAMMING
   Depends on MTD && MTD_NAND_ECC
   Selected by
   - SM_FTL && MTD && BLOCK

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
