Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592ED584B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiG2GUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiG2GUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:20:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB77AC02
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659075630; x=1690611630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O6OYbm2gxM1GLdwFs8plDdKvmt+/5iVzkbxo7ZIcVPA=;
  b=oHnkRwxFC448xj83AoLN8BscEeaO0DEo5nwxtL1stE+Ema9xHH2kZ2ym
   sMV7Ek3Sn8dfs1R/lpP3+Kd4PEw/P5QkRJ2mSuYnCcHeEK9GNt1shnMyU
   3JMyeWCjt6h8jqCZmY0AeCjBAiFvkPVuz4ERUd7BWi3iAJz5ZLjqt9m1a
   j7jHdaJdmMiXxSKBKrVPRKN2zoY7EjZRyI4n1464MTDlEuQ/QS3RrzyCx
   L4IUYOt294ZXjYvOj6rLfTUPHrx+WAVlR0e2vDkAjYw2BmSOsEJwzWFUA
   89JRWto2IjtILCwKMEqIU76dR0Xg7qTOhANaO97/3UEKyfIheENxGbIz2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="352701407"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="352701407"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="743429195"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2022 23:20:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHJMI-000BBj-09;
        Fri, 29 Jul 2022 06:20:26 +0000
Date:   Fri, 29 Jul 2022 14:19:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: [ammarfaizi2-block:palmer/linux/riscv-zicbom 5/5]
 arch/riscv/mm/dma-noncoherent.c:25:3: error: expected ')'
Message-ID: <202207291449.lbTs6gOb-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-zicbom
head:   1631ba1259d6d7f49b6028f2a1a0fa02be1c522a
commit: 1631ba1259d6d7f49b6028f2a1a0fa02be1c522a [5/5] riscv: Add support for non-coherent devices using zicbom extension
config: riscv-randconfig-r004-20220728 (https://download.01.org/0day-ci/archive/20220729/202207291449.lbTs6gOb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/1631ba1259d6d7f49b6028f2a1a0fa02be1c522a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-zicbom
        git checkout 1631ba1259d6d7f49b6028f2a1a0fa02be1c522a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/dma-noncoherent.c:25:3: error: expected ')'
                   ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
                   ^
   arch/riscv/include/asm/errata_list.h:99:2: note: expanded from macro 'ALT_CMO_OP'
           __nops(5),                                                      \
           ^
   arch/riscv/mm/dma-noncoherent.c:28:3: error: expected ')'
                   ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
                   ^
   arch/riscv/include/asm/errata_list.h:99:2: note: expanded from macro 'ALT_CMO_OP'
           __nops(5),                                                      \
           ^
   arch/riscv/mm/dma-noncoherent.c:31:3: error: expected ')'
                   ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
                   ^
   arch/riscv/include/asm/errata_list.h:99:2: note: expanded from macro 'ALT_CMO_OP'
           __nops(5),                                                      \
           ^
   arch/riscv/mm/dma-noncoherent.c:48:3: error: expected ')'
                   ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
                   ^
   arch/riscv/include/asm/errata_list.h:99:2: note: expanded from macro 'ALT_CMO_OP'
           __nops(5),                                                      \
           ^
   arch/riscv/mm/dma-noncoherent.c:59:2: error: expected ')'
           ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
           ^
   arch/riscv/include/asm/errata_list.h:99:2: note: expanded from macro 'ALT_CMO_OP'
           __nops(5),                                                      \
           ^
   5 errors generated.


vim +25 arch/riscv/mm/dma-noncoherent.c

    17	
    18	void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
    19				      enum dma_data_direction dir)
    20	{
    21		void *vaddr = phys_to_virt(paddr);
    22	
    23		switch (dir) {
    24		case DMA_TO_DEVICE:
  > 25			ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
    26			break;
    27		case DMA_FROM_DEVICE:
    28			ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
    29			break;
    30		case DMA_BIDIRECTIONAL:
    31			ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
    32			break;
    33		default:
    34			break;
    35		}
    36	}
    37	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
