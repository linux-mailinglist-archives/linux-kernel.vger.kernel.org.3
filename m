Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55256C8FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGIK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGIK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:28:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A263F62F5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657362519; x=1688898519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WZElXWkwnsvvLgaOgTPBGW/Fe0tNjl1kqPKDdzq+PEM=;
  b=DyuVgARZrvM5UpWpCXFyUblcOJfxkYVr91H3Ev+pvYxuEUbW4ZQ0aN9h
   UOyddkt95iKa5lYnhY4Sg+NnKDrWYVVk9yu3da1atSuryK6ZgnZFPCINU
   gkI1WW8hMLV17/CiFeh2fmzpBUH1P7z5hBPfEQCOXoC0zh3KAgt2F6C6L
   qOaaIU55pCiftUIynqff7WoEhIPUDqlNZMPggR9ORHiXNR7Qnr8bhFhBX
   7I3JY0q3dunHA4GUly7kUzat7XWJE94sunN5GlODB/fqFEAWfgltsLklL
   r6MTofvAigea/B+Ot1Dg+ZkWayUhkbqU9OVqgyuG8APbMeVlazxOQpY4l
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="310017147"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="310017147"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 03:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="662034848"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2022 03:28:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA7hV-000OeW-K8;
        Sat, 09 Jul 2022 10:28:37 +0000
Date:   Sat, 9 Jul 2022 18:28:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive()
 warn: inconsistent indenting
Message-ID: <202207091801.DlXsv8UQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5524c2a1fc4002a52e16236659e779767617a4f
commit: 1d7f6932c522ea95668e14265175ce3d753d0c24 riscv: atomic: Optimize dec_if_positive functions
date:   7 weeks ago
config: riscv-randconfig-m031-20220709 (https://download.01.org/0day-ci/archive/20220709/202207091801.DlXsv8UQ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive() warn: inconsistent indenting

Old smatch warnings:
fs/btrfs/zoned.c:167 sb_zone_number() error: uninitialized symbol 'zone'.
fs/btrfs/zoned.c:1494 btrfs_load_block_group_zone_info() error: uninitialized symbol 'ret'.

vim +317 arch/riscv/include/asm/atomic.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  312  
1d7f6932c522ea Guo Ren        2022-05-05  313  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
fab957c11efe2f Palmer Dabbelt 2017-07-10  314  {
fab957c11efe2f Palmer Dabbelt 2017-07-10  315         int prev, rc;
fab957c11efe2f Palmer Dabbelt 2017-07-10  316  
fab957c11efe2f Palmer Dabbelt 2017-07-10 @317  	__asm__ __volatile__ (
5ce6c1f3535fa8 Andrea Parri   2018-03-09  318  		"0:	lr.w     %[p],  %[c]\n"
1d7f6932c522ea Guo Ren        2022-05-05  319  		"	addi     %[rc], %[p], -1\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  320  		"	bltz     %[rc], 1f\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  321  		"	sc.w.rl  %[rc], %[rc], %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  322  		"	bnez     %[rc], 0b\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  323  		"	fence    rw, rw\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  324  		"1:\n"
fab957c11efe2f Palmer Dabbelt 2017-07-10  325  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
1d7f6932c522ea Guo Ren        2022-05-05  326  		:
fab957c11efe2f Palmer Dabbelt 2017-07-10  327  		: "memory");
1d7f6932c522ea Guo Ren        2022-05-05  328  	return prev - 1;
fab957c11efe2f Palmer Dabbelt 2017-07-10  329  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  330  

:::::: The code at line 317 was first introduced by commit
:::::: fab957c11efe2f405e08b9f0d080524bc2631428 RISC-V: Atomic and Locking Code

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
