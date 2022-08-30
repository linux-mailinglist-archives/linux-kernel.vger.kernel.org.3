Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F545A6EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiH3Ute (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH3Utc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:49:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0661727
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X7iCSTOWnU9U3NhVrvgeJETd405QeOeiTIOooqNdB1U=; b=gHAz3xYNkI3tRJgVyrayctUNn6
        FVSzD8fJhvqrScQM3uI3z3gV/t9Xe/uqUvA27go4xDvOr2+k0+eJ0tln1Z2/fJ8l1So8kOPQQ/DrW
        o+c1C5yTgE98mfKcMK2h71rRIzLvbgfeGASSIcrUvwIh2SQboMxS54OJKIXTXdCvrCvgI/ZNpESA2
        FgxNpDBwcJlHVD8FIQ1+HhQVn9UVQWl+2GljU8rjXvjDohBYmpmP6xvYGjGtiGik6mPXhE4PKh4lK
        A7S5/S7F95ZS/c+JJcsGumqpCK6IPZpB6oDBbXmokqeBugfwQ/YOlOyP5d9ztO1HdJ9tzRanRpS6m
        4PNfFFzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34010)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oT8Ao-0003NE-Q0; Tue, 30 Aug 2022 21:49:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oT8An-0001qo-F7; Tue, 30 Aug 2022 21:49:25 +0100
Date:   Tue, 30 Aug 2022 21:49:25 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rmk-arm:for-next 5/7] arch/arm/mm/init.c:219: undefined
 reference to `phys_initrd_start'
Message-ID: <Yw531SABnjRQ0ZCK@shell.armlinux.org.uk>
References: <202208310435.G07HW3ZF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208310435.G07HW3ZF-lkp@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:36:48AM +0800, kernel test robot wrote:
> tree:   git://git.armlinux.org.uk/~rmk/linux-arm for-next
> head:   a72b4b3ba681398a3ac1c1384efb949bef3ac846
> commit: b35b2736b43d7124e7da6a8050b8fd9e02f9f734 [5/7] ARM: 9230/1: Support initrd with address in boot alias region

Dropping this patch.

> config: arm-lubbock_defconfig (https://download.01.org/0day-ci/archive/20220831/202208310435.G07HW3ZF-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
>         git fetch --no-tags rmk-arm for-next
>         git checkout b35b2736b43d7124e7da6a8050b8fd9e02f9f734
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
> >> arch/arm/mm/init.c:219: undefined reference to `phys_initrd_start'
> 
> 
> vim +219 arch/arm/mm/init.c
> 
> b35b2736b43d71 Matija Glavinic Pecotic 2022-08-19  197  
> 3928624812dcfa Russell King            2017-01-16  198  void __init arm_memblock_init(const struct machine_desc *mdesc)
> 3928624812dcfa Russell King            2017-01-16  199  {
> 3928624812dcfa Russell King            2017-01-16  200  	/* Register the kernel text, kernel data and initrd with memblock. */
> 3928624812dcfa Russell King            2017-01-16  201  	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
> 3928624812dcfa Russell King            2017-01-16  202  
> b35b2736b43d71 Matija Glavinic Pecotic 2022-08-19  203  	sanitize_initrd_address();
> e46e45f00d9ea5 Wang Kefeng             2021-12-22  204  	reserve_initrd_mem();
> 2778f62056ada4 Russell King            2010-07-09  205  
> 2778f62056ada4 Russell King            2010-07-09  206  	arm_mm_memblock_reserve();
> 2778f62056ada4 Russell King            2010-07-09  207  
> 8d717a52d1b095 Russell King            2010-05-22  208  	/* reserve any platform specific memblock areas */
> 8d717a52d1b095 Russell King            2010-05-22  209  	if (mdesc->reserve)
> 8d717a52d1b095 Russell King            2010-05-22  210  		mdesc->reserve();
> 8d717a52d1b095 Russell King            2010-05-22  211  
> bcedb5f9bd7466 Marek Szyprowski        2014-02-28  212  	early_init_fdt_scan_reserved_mem();
> bcedb5f9bd7466 Marek Szyprowski        2014-02-28  213  
> 99a468d779f685 George G. Davis         2015-01-16  214  	/* reserve memory for DMA contiguous allocations */
> 95b0e655f91488 Marek Szyprowski        2014-10-09  215  	dma_contiguous_reserve(arm_dma_limit);
> c79095092834a1 Marek Szyprowski        2011-12-29  216  
> 716a3dc20084da Russell King            2012-01-13  217  	arm_memblock_steal_permitted = false;
> 2778f62056ada4 Russell King            2010-07-09  218  	memblock_dump_all();
> 2778f62056ada4 Russell King            2010-07-09 @219  }
> 2778f62056ada4 Russell King            2010-07-09  220  
> 
> :::::: The code at line 219 was first introduced by commit
> :::::: 2778f62056ada442414392d7ccd41188bb631619 ARM: initial LMB trial
> 
> :::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
> :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
