Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE07484139
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiADLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:52:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:20375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbiADLwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641297170; x=1672833170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hcd+m9MOE6DIZiVHypfwzcN57ZrCiLG+mUEBWe8FJ0w=;
  b=DZZq8z/Z7ODCTMLl1XErZew+L+5qebhEoUseSFg+aH22rATHRTxvFnoh
   pWNbbLoHjvdKQ3evb1VK6SNBchG7fHy24IQLdjtjon/ZihcgBtRFdIiRL
   VhqKDokLpBD9Nb6W+6/3OZUb1j+3TRuwsfdTofd+ytph8a6luePPpfE2N
   dA+6mqfoFDjCQuwb9WK/nMkYDnDR7e7yr5aEKnF3ZN7m7HQpWHmdNj6fV
   gdyVDWh/r/K8RbGavCelgim4/nWpKJjj/ysnrb2lsmV0f/S5h4Xda+JCZ
   r2Tdq5QGizG9MQc96GAak0L3EaFLdAHtnej5DIWJ4PKzNm3AuchXFwNty
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242005919"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="242005919"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="620625462"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2022 03:52:47 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4iMx-000FIB-4w; Tue, 04 Jan 2022 11:52:47 +0000
Date:   Tue, 4 Jan 2022 19:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable
 'efifb_dmi_system_table'
Message-ID: <202201041920.mOzzco4D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 15d27b15de965043d6f8e23bc7f34386fcd1a772 efi: sysfb_efi: fix build when EFI is not set
date:   5 months ago
config: x86_64-randconfig-a016-20210927 (https://download.01.org/0day-ci/archive/20220104/202201041920.mOzzco4D-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15d27b15de965043d6f8e23bc7f34386fcd1a772
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 15d27b15de965043d6f8e23bc7f34386fcd1a772
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/firmware/efi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/sysfb_efi.c:72:6: warning: no previous prototype for function 'efifb_setup_from_dmi' [-Wmissing-prototypes]
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
        ^
   drivers/firmware/efi/sysfb_efi.c:72:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
   ^
   static 
>> drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable 'efifb_dmi_system_table' [-Wunused-const-variable]
   static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
                                     ^
>> drivers/firmware/efi/sysfb_efi.c:240:35: warning: unused variable 'efifb_dmi_swap_width_height' [-Wunused-const-variable]
   static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
                                     ^
>> drivers/firmware/efi/sysfb_efi.c:331:39: warning: unused variable 'efifb_fwnode_ops' [-Wunused-const-variable]
   static const struct fwnode_operations efifb_fwnode_ops = {
                                         ^
   4 warnings generated.


vim +/efifb_dmi_system_table +190 drivers/firmware/efi/sysfb_efi.c

2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   71  
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25  @72  void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   73  {
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   74  	int i;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   75  
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   76  	for (i = 0; i < M_UNKNOWN; i++) {
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   77  		if (efifb_dmi_list[i].base != 0 &&
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   78  		    !strcmp(opt, efifb_dmi_list[i].optname)) {
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   79  			si->lfb_base = efifb_dmi_list[i].base;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   80  			si->lfb_linelength = efifb_dmi_list[i].stride;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   81  			si->lfb_width = efifb_dmi_list[i].width;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   82  			si->lfb_height = efifb_dmi_list[i].height;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   83  		}
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   84  	}
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   85  }
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c      Ard Biesheuvel           2016-04-25   86  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   87  #define choose_value(dmivalue, fwvalue, field, flags) ({	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   88  		typeof(fwvalue) _ret_ = fwvalue;		\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   89  		if ((flags) & (field))				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   90  			_ret_ = dmivalue;			\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   91  		else if ((fwvalue) == 0)			\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   92  			_ret_ = dmivalue;			\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   93  		_ret_;						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   94  	})
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   95  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   96  static int __init efifb_set_system(const struct dmi_system_id *id)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   97  {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   98  	struct efifb_dmi_info *info = id->driver_data;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02   99  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  100  	if (info->base == 0 && info->height == 0 && info->width == 0 &&
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  101  	    info->stride == 0)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  102  		return 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  103  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  104  	/* Trust the bootloader over the DMI tables */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  105  	if (screen_info.lfb_base == 0) {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  106  #if defined(CONFIG_PCI)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  107  		struct pci_dev *dev = NULL;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  108  		int found_bar = 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  109  #endif
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  110  		if (info->base) {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  111  			screen_info.lfb_base = choose_value(info->base,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  112  				screen_info.lfb_base, OVERRIDE_BASE,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  113  				info->flags);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  114  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  115  #if defined(CONFIG_PCI)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  116  			/* make sure that the address in the table is actually
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  117  			 * on a VGA device's PCI BAR */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  118  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  119  			for_each_pci_dev(dev) {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  120  				int i;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  121  				if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  122  					continue;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  123  				for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  124  					resource_size_t start, end;
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  125  					unsigned long flags;
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  126  
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  127  					flags = pci_resource_flags(dev, i);
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  128  					if (!(flags & IORESOURCE_MEM))
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  129  						continue;
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  130  
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  131  					if (flags & IORESOURCE_UNSET)
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  132  						continue;
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  133  
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  134  					if (pci_resource_len(dev, i) == 0)
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  135  						continue;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  136  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  137  					start = pci_resource_start(dev, i);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  138  					end = pci_resource_end(dev, i);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  139  					if (screen_info.lfb_base >= start &&
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  140  					    screen_info.lfb_base < end) {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  141  						found_bar = 1;
c10fcb14c7afd6 arch/x86/kernel/sysfb_efi.c      Wang YanQing             2016-05-05  142  						break;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  143  					}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  144  				}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  145  			}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  146  			if (!found_bar)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  147  				screen_info.lfb_base = 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  148  #endif
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  149  		}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  150  	}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  151  	if (screen_info.lfb_base) {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  152  		screen_info.lfb_linelength = choose_value(info->stride,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  153  			screen_info.lfb_linelength, OVERRIDE_STRIDE,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  154  			info->flags);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  155  		screen_info.lfb_width = choose_value(info->width,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  156  			screen_info.lfb_width, OVERRIDE_WIDTH,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  157  			info->flags);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  158  		screen_info.lfb_height = choose_value(info->height,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  159  			screen_info.lfb_height, OVERRIDE_HEIGHT,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  160  			info->flags);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  161  		if (screen_info.orig_video_isVGA == 0)
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  162  			screen_info.orig_video_isVGA = VIDEO_TYPE_EFI;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  163  	} else {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  164  		screen_info.lfb_linelength = 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  165  		screen_info.lfb_width = 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  166  		screen_info.lfb_height = 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  167  		screen_info.orig_video_isVGA = 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  168  		return 0;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  169  	}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  170  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  171  	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at 0x%08x "
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  172  			 "(%dx%d, stride %d)\n", id->ident,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  173  			 screen_info.lfb_base, screen_info.lfb_width,
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  174  			 screen_info.lfb_height, screen_info.lfb_linelength);
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  175  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  176  	return 1;
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  177  }
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  178  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  179  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  180  	{							\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  181  		efifb_set_system,				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  182  		name,						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  183  		{						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  184  			DMI_MATCH(DMI_BIOS_VENDOR, vendor),	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  185  			DMI_MATCH(DMI_PRODUCT_NAME, name)	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  186  		},						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  187  		&efifb_dmi_list[enumid]				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  188  	}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  189  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02 @190  static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  191  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac4,1", M_I17),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  192  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  193  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac5,1", M_I20),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  194  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac5,1", M_I20),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  195  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  196  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac6,1", M_I24),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  197  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac6,1", M_I24),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  198  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac7,1", M_I20_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  199  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac8,1", M_I24_8_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  200  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac10,1", M_I24_10_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  201  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac11,1", M_I27_11_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  202  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "Macmini1,1", M_MINI),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  203  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "Macmini3,1", M_MINI_3_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  204  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "Macmini4,1", M_MINI_4_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  205  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook1,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  206  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  207  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook2,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  208  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook2,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  209  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  210  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook3,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  211  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook3,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  212  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook4,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  213  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook5,1", M_MB_5_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  214  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook6,1", M_MB_6_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  215  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook7,1", M_MB_7_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  216  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir1,1", M_MBA),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  217  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir3,1", M_MBA_3),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  218  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro1,1", M_MBP),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  219  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,1", M_MBP_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  220  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,2", M_MBP_2_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  221  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro2,1", M_MBP_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  222  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro3,1", M_MBP_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  223  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro3,1", M_MBP_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  224  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro4,1", M_MBP_4),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  225  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,1", M_MBP_5_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  226  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,2", M_MBP_5_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  227  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,3", M_MBP_5_3),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  228  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro6,1", M_MBP_6_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  229  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro6,2", M_MBP_6_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  230  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro7,1", M_MBP_7_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  231  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro8,2", M_MBP_8_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  232  	{},
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  233  };
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  234  
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  235  /*
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  236   * Some devices have a portrait LCD but advertise a landscape resolution (and
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  237   * pitch). We simply swap width and height for these devices so that we can
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  238   * correctly deal with some of them coming with multiple resolutions.
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  239   */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21 @240  static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  241  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  242  		/*
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  243  		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  244  		 * 800x1280 portrait screen. Luckily the portrait version has
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  245  		 * its own BIOS version, so we match on that.
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  246  		 */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  247  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  248  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  249  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  250  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  251  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  252  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  253  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  254  		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  255  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  256  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  257  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  258  					"Lenovo MIIX 320-10ICR"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  259  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  260  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  261  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  262  		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  263  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  264  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  265  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  266  					"Lenovo ideapad D330-10IGM"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  267  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  268  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  269  	{},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  270  };
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  271  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  272  static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  273  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  274  	u64 fb_base = screen_info.lfb_base;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  275  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  276  	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  277  		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  278  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  279  	return fb_base >= range->cpu_addr &&
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  280  	       fb_base < (range->cpu_addr + range->size);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  281  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  282  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  283  static struct device_node *find_pci_overlap_node(void)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  284  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  285  	struct device_node *np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  286  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  287  	for_each_node_by_type(np, "pci") {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  288  		struct of_pci_range_parser parser;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  289  		struct of_pci_range range;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  290  		int err;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  291  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  292  		err = of_pci_range_parser_init(&parser, np);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  293  		if (err) {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  294  			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  295  			continue;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  296  		}
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  297  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  298  		for_each_of_pci_range(&parser, &range)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  299  			if (efifb_overlaps_pci_range(&range))
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  300  				return np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  301  	}
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  302  	return NULL;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  303  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  304  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  305  /*
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  306   * If the efifb framebuffer is backed by a PCI graphics controller, we have
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  307   * to ensure that this relation is expressed using a device link when
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  308   * running in DT mode, or the probe order may be reversed, resulting in a
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  309   * resource reservation conflict on the memory window that the efifb
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  310   * framebuffer steals from the PCIe host bridge.
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  311   */
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  312  static int efifb_add_links(struct fwnode_handle *fwnode)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  313  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  314  	struct device_node *sup_np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  315  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  316  	sup_np = find_pci_overlap_node();
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  317  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  318  	/*
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  319  	 * If there's no PCI graphics controller backing the efifb, we are
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  320  	 * done here.
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  321  	 */
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  322  	if (!sup_np)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  323  		return 0;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  324  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  325  	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  326  	of_node_put(sup_np);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  327  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  328  	return 0;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  329  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  330  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25 @331  static const struct fwnode_operations efifb_fwnode_ops = {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  332  	.add_links = efifb_add_links,
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  333  };
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  334  

:::::: The code at line 190 was first introduced by commit
:::::: 2995e506276bfdc7311eb02db8b2aa1a61a4b849 x86: sysfb: move EFI quirks from efifb to sysfb

:::::: TO: David Herrmann <dh.herrmann@gmail.com>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
