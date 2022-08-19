Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71459A8FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiHSWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHSWvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:51:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE210B510
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660949476; x=1692485476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iAbt2fZFK4weP/KnMpyVYr3VoWOhfHdjkNTwzc12SOg=;
  b=Uzuthm921u7jj/Ypqo0VDIHOBTaSGpg7IPgnwIUQKOrcoE0obgPOl0y+
   P+xXSraC/ytNzuMJEBm8iEkYxoy98dViXNTw3w6FYCwADTyiZrKlsMShc
   QnJ31vldlv0ANUE2zyTaoftWphCHmAM7BaQDLYZq4tSl5AKUO9k1Qfky+
   uwCDupNKmp2xMerD2NRNvLv+8nuEe6MEx5LowAHhhVnOcn9InaV4OI6rM
   FqF4Xls1G2w65I3unAv5nThVQRRxezgIzMHWhHXtg8v6C6z8CkbMj3IqP
   olAgsFO7morqjUcq/JnKYVad6b8j1gwZtXG5X7vZwUE5WhjQJ0rsS6h62
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="319148785"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="319148785"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 15:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="637447816"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2022 15:51:14 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPApe-0001sh-0L;
        Fri, 19 Aug 2022 22:51:14 +0000
Date:   Sat, 20 Aug 2022 06:51:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype
 for 'feroceon_copy_user_highpage'
Message-ID: <202208200632.qCY00XWl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm/configs/am200epdkit_defconfig
arch/arm/configs/cm_x300_defconfig
arch/arm/configs/colibri_pxa270_defconfig
arch/arm/configs/colibri_pxa300_defconfig
arch/arm/configs/corgi_defconfig
arch/arm/configs/eseries_pxa_defconfig
arch/arm/configs/ezx_defconfig
arch/arm/configs/h5000_defconfig
arch/arm/configs/imote2_defconfig
arch/arm/configs/lpd270_defconfig
arch/arm/configs/lubbock_defconfig
arch/arm/configs/magician_defconfig
arch/arm/configs/mainstone_defconfig
arch/arm/configs/palmz72_defconfig
arch/arm/configs/pcm027_defconfig
arch/arm/configs/pxa255-idp_defconfig
arch/arm/configs/pxa3xx_defconfig
arch/arm/configs/pxa_defconfig
arch/arm/configs/spitz_defconfig
arch/arm/configs/trizeps4_defconfig
arch/arm/configs/viper_defconfig
arch/arm/configs/xcep_defconfig
arch/arm/configs/zeus_defconfig
arch/arm/mach-pxa/Makefile.boot
arch/arm/mach-pxa/include/mach/uncompress.h
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   3 months ago
config: arm-randconfig-c032-20220820 (https://download.01.org/0day-ci/archive/20220820/202208200632.qCY00XWl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-lpc32xx/ arch/arm/mach-versatile/ arch/arm/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from arch/arm/mm/copypage-feroceon.c:11:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/arm/mm/copypage-feroceon.c: At top level:
>> arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype for 'feroceon_copy_user_highpage' [-Wmissing-prototypes]
      65 | void feroceon_copy_user_highpage(struct page *to, struct page *from,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/copypage-feroceon.c:78:6: warning: no previous prototype for 'feroceon_clear_user_highpage' [-Wmissing-prototypes]
      78 | void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/topology.h:33,
                    from include/linux/irq.h:19,
                    from include/asm-generic/hardirq.h:17,
                    from arch/arm/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/serial_core.h:13,
                    from arch/arm/mach-lpc32xx/serial.c:13:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/arm/mach-lpc32xx/serial.c: At top level:
>> arch/arm/mach-lpc32xx/serial.c:63:6: warning: no previous prototype for 'lpc32xx_loopback_set' [-Wmissing-prototypes]
      63 | void lpc32xx_loopback_set(resource_size_t mapbase, int state)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/feroceon_copy_user_highpage +65 arch/arm/mm/copypage-feroceon.c

d73e60b7144a86 Russell King  2008-10-31   64  
063b0a4207e43a Russell King  2008-10-31  @65  void feroceon_copy_user_highpage(struct page *to, struct page *from,
f00a75c094c340 Russell King  2009-10-05   66  	unsigned long vaddr, struct vm_area_struct *vma)
063b0a4207e43a Russell King  2008-10-31   67  {
063b0a4207e43a Russell King  2008-10-31   68  	void *kto, *kfrom;
063b0a4207e43a Russell King  2008-10-31   69  
5472e862de2bc4 Cong Wang     2011-11-25   70  	kto = kmap_atomic(to);
5472e862de2bc4 Cong Wang     2011-11-25   71  	kfrom = kmap_atomic(from);
2725898fc9bb21 Russell King  2009-10-05   72  	flush_cache_page(vma, vaddr, page_to_pfn(from));
063b0a4207e43a Russell King  2008-10-31   73  	feroceon_copy_user_page(kto, kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   74  	kunmap_atomic(kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   75  	kunmap_atomic(kto);
063b0a4207e43a Russell King  2008-10-31   76  }
063b0a4207e43a Russell King  2008-10-31   77  
303c6443659bc1 Russell King  2008-10-31  @78  void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
d73e60b7144a86 Russell King  2008-10-31   79  {
5472e862de2bc4 Cong Wang     2011-11-25   80  	void *ptr, *kaddr = kmap_atomic(page);
43ae286b7d4d8c Nicolas Pitre 2008-11-04   81  	asm volatile ("\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   82  	mov	r1, %2				\n\
d73e60b7144a86 Russell King  2008-10-31   83  	mov	r2, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   84  	mov	r3, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   85  	mov	r4, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   86  	mov	r5, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   87  	mov	r6, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   88  	mov	r7, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   89  	mov	ip, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   90  	mov	lr, #0				\n\
303c6443659bc1 Russell King  2008-10-31   91  1:	stmia	%0, {r2-r7, ip, lr}		\n\
d73e60b7144a86 Russell King  2008-10-31   92  	subs	r1, r1, #1			\n\
303c6443659bc1 Russell King  2008-10-31   93  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   94  	add	%0, %0, #32			\n\
d73e60b7144a86 Russell King  2008-10-31   95  	bne	1b				\n\
303c6443659bc1 Russell King  2008-10-31   96  	mcr	p15, 0, r1, c7, c10, 4		@ drain WB"
43ae286b7d4d8c Nicolas Pitre 2008-11-04   97  	: "=r" (ptr)
43ae286b7d4d8c Nicolas Pitre 2008-11-04   98  	: "0" (kaddr), "I" (PAGE_SIZE / 32)
303c6443659bc1 Russell King  2008-10-31   99  	: "r1", "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
5472e862de2bc4 Cong Wang     2011-11-25  100  	kunmap_atomic(kaddr);
d73e60b7144a86 Russell King  2008-10-31  101  }
d73e60b7144a86 Russell King  2008-10-31  102  

:::::: The code at line 65 was first introduced by commit
:::::: 063b0a4207e43acbeff3d4b09f43e750e0212b48 [ARM] copypage: provide our own copy_user_highpage()

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
