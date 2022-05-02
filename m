Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CF517290
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385771AbiEBPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385858AbiEBPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:34:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C222662
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651505433; x=1683041433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MFyYkuxo2mFwhPKvZ+EpXkdFdu9niadcwP2ScO6lZmA=;
  b=jmTEMzzvkfe8c4cM8V62u4y6VhUKqp4fHxmimJf7Gt2NrxNeNIO7mx2e
   TcDIJkFo0bOfnRDvHsNvlc6jDmSD7AnpZBVQ5puOVvq37TegipPel/G+s
   doQ6A8UqfZLRQvLB8a5kkCoZwmRRqdHyvzEAB/HxyNNk8GzFdRVqKe3YI
   DkIbyVHUC3nOZ/FeTaiHrKlJmObGdeGogx7D6XH+bbKpv7QIJJ+Mf0im8
   YxtFmOgDEpencMnmvSJZ3gdHCSOfY/j2gzKhXWYErmkiIa6F9FBaRTLBu
   RYrvEUa7ueP782GXIDTZcV0a+U9eJGPGVufetctKbWfV6B9H67MVq0mbb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="292419439"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="292419439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="535890502"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 May 2022 08:30:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlY0N-0009eJ-7s;
        Mon, 02 May 2022 15:30:31 +0000
Date:   Mon, 2 May 2022 23:30:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:efi-decompressor 14/15]
 drivers/firmware/efi/libstub/zboot-header.S:15: Error: cannot represent
 BFD_RELOC_16 relocation in object file
Message-ID: <202205022351.rnmZ1h8i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-decompressor
head:   72c24d14cadb10e6debf20a1c82657095ebb09dc
commit: b04842cf015d233b0ab70338b131eccca070cc86 [14/15] efi: stub: implement generic EFI zboot
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205022351.rnmZ1h8i-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=b04842cf015d233b0ab70338b131eccca070cc86
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-decompressor
        git checkout b04842cf015d233b0ab70338b131eccca070cc86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/firmware/efi/libstub/zboot-header.S: Assembler messages:
>> drivers/firmware/efi/libstub/zboot-header.S:15: Error: cannot represent BFD_RELOC_16 relocation in object file


vim +15 drivers/firmware/efi/libstub/zboot-header.S

     4	
     5		.section	".head", "a"
     6		.globl		__efistub_efi_zboot_header
     7	__efistub_efi_zboot_header:
     8	.Ldoshdr:
     9		.long		MZ_MAGIC
    10		.org		.Ldoshdr + 0x3c
    11		.long		.Lpehdr - .Ldoshdr
    12	
    13	.Lpehdr:
    14		.long		PE_MAGIC
  > 15		.short		pe_machine_type
    16		.short		.Lsection_count
    17		.long		0
    18		.long		0
    19		.long		0
    20		.short		.Lsection_table - .Loptional_header
    21		.short		IMAGE_FILE_DEBUG_STRIPPED | \
    22				IMAGE_FILE_EXECUTABLE_IMAGE | \
    23				IMAGE_FILE_LINE_NUMS_STRIPPED
    24	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
