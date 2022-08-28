Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06C25A3BA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 06:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiH1Edk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 00:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Edh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 00:33:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDACA4F6AC
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 21:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661661216; x=1693197216;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L0HWA6o5kX4X2iWvskmdGkc/A7c5SWQjNumMFWfU+5g=;
  b=gNvzCdisX7wvGzAbSYNfD9EBukKP6MeDOBNKcP8iJBHK5GPxGvbGgltf
   DjAq+u/O39gMUiIsA5m2QlbnAaK/v9H9kfi1QR5sKOmgFATlLWXwAlBlx
   LlbW61lh43ZpXafChuFITltTmOhP7glkapjSQD9r+NOJyBR1H3TrHTR9y
   Tz2YF2mN97n4PXKG3zYfplTEvDVMJxcIjzEowXTFF5JTPawHSH3CuJI1L
   4hfN4XEKgWjitmhMGs5BSbpQ4EOYKBu2FoJzJljCrgX2/s0W17AEdh93r
   KjrxzM5Iu/mr+QkKgbO92lha+e91vfLeMzx6qgSAqDFlz2t4TjkIl7qVH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="277725271"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="277725271"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 21:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="587774136"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2022 21:33:34 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS9zK-0000nH-0I;
        Sun, 28 Aug 2022 04:33:34 +0000
Date:   Sun, 28 Aug 2022 12:32:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: arch/arm/mm/copypage-fa.c:38:6: sparse: sparse: symbol
 'fa_copy_user_highpage' was not declared. Should it be static?
Message-ID: <202208281252.U8zOEcHO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   10d4879f9ef01cc6190fafe4257d06f375bab92c
commit: 3d427228f7370894680580fcd0381c0349624fa1 ARM: ixp4xx: enable multiplatform support
date:   5 months ago
config: arm-randconfig-s031-20220828 (https://download.01.org/0day-ci/archive/20220828/202208281252.U8zOEcHO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d427228f7370894680580fcd0381c0349624fa1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d427228f7370894680580fcd0381c0349624fa1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/ drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mm/copypage-fa.c:38:6: sparse: sparse: symbol 'fa_copy_user_highpage' was not declared. Should it be static?
>> arch/arm/mm/copypage-fa.c:55:6: sparse: sparse: symbol 'fa_clear_user_highpage' was not declared. Should it be static?
--
>> arch/arm/mm/copypage-xscale.c:84:6: sparse: sparse: symbol 'xscale_mc_copy_user_highpage' was not declared. Should it be static?
>> arch/arm/mm/copypage-xscale.c:107:1: sparse: sparse: symbol 'xscale_mc_clear_user_highpage' was not declared. Should it be static?

vim +/fa_copy_user_highpage +38 arch/arm/mm/copypage-fa.c

28853ac8fe5221 Paulius Zaleckas 2009-03-25  37  
28853ac8fe5221 Paulius Zaleckas 2009-03-25 @38  void fa_copy_user_highpage(struct page *to, struct page *from,
a3be6327163c22 Hans Ulli Kroll  2010-04-27  39  	unsigned long vaddr, struct vm_area_struct *vma)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  40  {
28853ac8fe5221 Paulius Zaleckas 2009-03-25  41  	void *kto, *kfrom;
28853ac8fe5221 Paulius Zaleckas 2009-03-25  42  
5472e862de2bc4 Cong Wang        2011-11-25  43  	kto = kmap_atomic(to);
5472e862de2bc4 Cong Wang        2011-11-25  44  	kfrom = kmap_atomic(from);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  45  	fa_copy_user_page(kto, kfrom);
5472e862de2bc4 Cong Wang        2011-11-25  46  	kunmap_atomic(kfrom);
5472e862de2bc4 Cong Wang        2011-11-25  47  	kunmap_atomic(kto);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  48  }
28853ac8fe5221 Paulius Zaleckas 2009-03-25  49  
28853ac8fe5221 Paulius Zaleckas 2009-03-25  50  /*
28853ac8fe5221 Paulius Zaleckas 2009-03-25  51   * Faraday optimised clear_user_page
28853ac8fe5221 Paulius Zaleckas 2009-03-25  52   *
28853ac8fe5221 Paulius Zaleckas 2009-03-25  53   * Same story as above.
28853ac8fe5221 Paulius Zaleckas 2009-03-25  54   */
28853ac8fe5221 Paulius Zaleckas 2009-03-25 @55  void fa_clear_user_highpage(struct page *page, unsigned long vaddr)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  56  {
5472e862de2bc4 Cong Wang        2011-11-25  57  	void *ptr, *kaddr = kmap_atomic(page);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  58  	asm volatile("\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  59  	mov	r1, %2				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  60  	mov	r2, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  61  	mov	r3, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  62  	mov	ip, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  63  	mov	lr, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  64  1:	stmia	%0, {r2, r3, ip, lr}		@ 4\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  65  	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  66  	add	%0, %0, #16			@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  67  	stmia	%0, {r2, r3, ip, lr}		@ 4\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  68  	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  69  	add	%0, %0, #16			@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  70  	subs	r1, r1, #1			@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  71  	bne	1b				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  72  	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB"
28853ac8fe5221 Paulius Zaleckas 2009-03-25  73  	: "=r" (ptr)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  74  	: "0" (kaddr), "I" (PAGE_SIZE / 32)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  75  	: "r1", "r2", "r3", "ip", "lr");
5472e862de2bc4 Cong Wang        2011-11-25  76  	kunmap_atomic(kaddr);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  77  }
28853ac8fe5221 Paulius Zaleckas 2009-03-25  78  

:::::: The code at line 38 was first introduced by commit
:::::: 28853ac8fe5221de74a14f1182d7b2b383dfd85c ARM: Add support for FA526 v2

:::::: TO: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
:::::: CC: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
