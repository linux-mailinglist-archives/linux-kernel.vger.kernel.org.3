Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4A52FF06
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiEUTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiEUTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:43:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04262103
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653162233; x=1684698233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cYahxWvZSh7BIqLBOyBc88a9vSBQ+F76/craa0fcL5A=;
  b=F9Ps7bhw7KKJlWM2hJUaaL3zVoNzdCE9icoP/Oyw5FyespBjY7rRNtC/
   QQWTXJeND8VJxTG4mDGNQJ7ZaGiQfqMfCsdZayb/bgdznGCinwS+5m3NU
   eA1UE37HPImzhLKsGeYW5e5xfrrReN9oZRSYVA3s/qUe4xg73wvWlJWR0
   cCpjZfmoz1O/mE/OeNAZX9J6DRwDjIf31cYyEF4B3Nf4eN4ZujcdQqYAp
   yeRm/dZNXDMn1pGAs17nnPMEbmlUU8OmaR207khFXZmqthJubCL6WPc6K
   GIHxbLqA7LlsNeZfmBCxp2+heN7oVv0L0KntzSH9b8bf8bpKYpbRAFZR6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="298215117"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="298215117"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 12:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="599877480"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2022 12:43:51 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsV0x-0006Zg-06;
        Sat, 21 May 2022 19:43:51 +0000
Date:   Sun, 22 May 2022 03:43:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [palmer:riscv-kexec 5/6] arch/riscv/purgatory/entry.S:29: Error:
 unrecognized opcode `ld a2,riscv_kernel_entry'
Message-ID: <202205220336.fndQjLb9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git riscv-kexec
head:   daae2fd41212953aeccd56f0a84546394cd00dfb
commit: 781a15320381cb50ae9e85f66da123aa5b8c3d2f [5/6] RISC-V: Add purgatory
config: riscv-randconfig-c003-20220522 (https://download.01.org/0day-ci/archive/20220522/202205220336.fndQjLb9-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=781a15320381cb50ae9e85f66da123aa5b8c3d2f
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-kexec
        git checkout 781a15320381cb50ae9e85f66da123aa5b8c3d2f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/purgatory/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/purgatory/entry.S: Assembler messages:
>> arch/riscv/purgatory/entry.S:29: Error: unrecognized opcode `ld a2,riscv_kernel_entry'


vim +29 arch/riscv/purgatory/entry.S

    16	
    17	.globl purgatory_start
    18	purgatory_start:
    19	
    20		lla	sp, .Lstack
    21		mv	s0, a0	/* The hartid of the current hart */
    22		mv	s1, a1	/* Phys address of the FDT image */
    23	
    24		jal	purgatory
    25	
    26		/* Start new image. */
    27		mv	a0, s0
    28		mv	a1, s1
  > 29		ld	a2, riscv_kernel_entry
    30		jr	a2
    31	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
