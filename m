Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61855F966
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiF2HnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiF2Hmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:42:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6283701C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656488573; x=1688024573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VxcVHOI4WyRQf1u0CtMfKEVzp0ThCoPjKwjMJ7tLxwY=;
  b=hE0hPS7eGbtM6pzIFsYEowzzg3cWyTxnOAs6+71TJcbLHfdLZgEfR+iJ
   51KaTf1OFuouQeZQovCst3OSwSDaRKX+Ya/pfmA+RTXop6TR5FzlccMkZ
   a0KW1seoyxVztdrW2vOqOo73w1txbBizUsqgpajdOR5wK0junVvBCFCvl
   sCP1eRh5EHK6JvKmjogFNtB0M39+hArhzmmMbo0xCGmEZGk1X2MovSygG
   5e6/hEaVj+T5S0s6hzqEr35J2x4nInMbYav8PYWRC8OjQWSbJo8yGv8gS
   HLYLbqeduXXPiPBbbzJ9XImmDn2Bsw78yAzo6uLhfFJiy26m1blvdIxV0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270717441"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270717441"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="837017432"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2022 00:42:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6SLa-000Aza-Fh;
        Wed, 29 Jun 2022 07:42:50 +0000
Date:   Wed, 29 Jun 2022 15:42:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: [ammarfaizi2-block:arm64/linux/for-next/boot 20/21] ld.lld: error:
 undefined hidden symbol: __pi___memmove
Message-ID: <202206291516.Nr0bqPCp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/boot
head:   7559d9f97581654fbd0c3fa21878b6d043bbe439
commit: aacd149b62382c63911060b8f64c1e3d89bd405a [20/21] arm64: head: avoid relocating the kernel twice for KASLR
config: arm64-buildonly-randconfig-r006-20220627 (https://download.01.org/0day-ci/archive/20220629/202206291516.Nr0bqPCp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/aacd149b62382c63911060b8f64c1e3d89bd405a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/boot
        git checkout aacd149b62382c63911060b8f64c1e3d89bd405a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined hidden symbol: __pi___memmove
   >>> referenced by fdt.c:333 (lib/../scripts/dtc/libfdt/fdt.c:333)
   >>> kernel/pi/lib-fdt.pi.o:(__pi_fdt_move) in archive arch/arm64/built-in.a
--
>> ld.lld: error: undefined hidden symbol: __pi___memcpy
   >>> referenced by fdt_ro.c:568 (lib/../scripts/dtc/libfdt/fdt_ro.c:568)
   >>> kernel/pi/lib-fdt_ro.pi.o:(__pi_fdt_get_path) in archive arch/arm64/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
