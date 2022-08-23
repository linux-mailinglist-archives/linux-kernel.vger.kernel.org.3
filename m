Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A859CD31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiHWAZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiHWAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:25:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741B3DF19
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661214318; x=1692750318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fkeBvW7wEWYE/VzZlsGg0wlgclDocOR11D+xmWygH/Y=;
  b=NWjpzD9VfHcodlR8Es1hKWjjHuhBsZd7hmeUPmE9UAyiK+9/VmPZZCoY
   NkMY1A67uQ5TYeYwYAsSnbYPFy9KLF+IbU6dpf1OB9h1gukOF6OKmJ0Jg
   3AVjWZawDUl+P2ScVXgLXdEiXTScxdn01i1nOTh+tB8t/TGTgpK9m2h+s
   SG5phBCqOCaBSe4IFM86UFXJJvkOMYnjUjU36uSRnLE+h27yazu2JNMc8
   cLig9voYPCqFTgSe8faKxa/8WY5n/6/hBglqip0a3oMSZVM7vRPBxfarv
   okKn7OnNootBxtGChAsuvkcN64s/8LIuoEa9Waj4qCrPAvKrzAXTB/Zdp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292296577"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="292296577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 17:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="559953698"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 17:25:17 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQHjI-0000tX-1J;
        Tue, 23 Aug 2022 00:25:16 +0000
Date:   Tue, 23 Aug 2022 08:25:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 7/7]
 drivers/firmware/efi/libstub/arm64-stub.c:178:32: warning: passing argument
 1 of 'caches_clean_inval_pou' makes integer from pointer without a cast
Message-ID: <202208230842.EzmDcJSE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   6aca304c2ee44597ad1f6989d4905ed9f52ad16b
commit: 6aca304c2ee44597ad1f6989d4905ed9f52ad16b [7/7] arm64: efi/libstub: enter with the MMU on
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220823/202208230842.EzmDcJSE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=6aca304c2ee44597ad1f6989d4905ed9f52ad16b
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 6aca304c2ee44597ad1f6989d4905ed9f52ad16b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/arm64-stub.c: In function 'handle_kernel_image':
>> drivers/firmware/efi/libstub/arm64-stub.c:178:32: warning: passing argument 1 of 'caches_clean_inval_pou' makes integer from pointer without a cast [-Wint-conversion]
     178 |         caches_clean_inval_pou((void *)*image_addr,
         |                                ^~~~~~~~~~~~~~~~~~~
         |                                |
         |                                void *
   In file included from arch/arm64/include/asm/mmu_context.h:19,
                    from arch/arm64/include/asm/efi.h:10,
                    from drivers/firmware/efi/libstub/arm64-stub.c:11:
   arch/arm64/include/asm/cacheflush.h:72:50: note: expected 'long unsigned int' but argument is of type 'void *'
      72 | extern void caches_clean_inval_pou(unsigned long start, unsigned long end);
         |                                    ~~~~~~~~~~~~~~^~~~~
   drivers/firmware/efi/libstub/arm64-stub.c:179:52: warning: passing argument 2 of 'caches_clean_inval_pou' makes integer from pointer without a cast [-Wint-conversion]
     179 |                                (void *)*image_addr + kernel_codesize);
         |                                ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    void *
   arch/arm64/include/asm/cacheflush.h:72:71: note: expected 'long unsigned int' but argument is of type 'void *'
      72 | extern void caches_clean_inval_pou(unsigned long start, unsigned long end);
         |                                                         ~~~~~~~~~~~~~~^~~


vim +/caches_clean_inval_pou +178 drivers/firmware/efi/libstub/arm64-stub.c

    81	
    82	efi_status_t handle_kernel_image(unsigned long *image_addr,
    83					 unsigned long *image_size,
    84					 unsigned long *reserve_addr,
    85					 unsigned long *reserve_size,
    86					 efi_loaded_image_t *image,
    87					 efi_handle_t image_handle)
    88	{
    89		efi_status_t status;
    90		unsigned long kernel_size, kernel_codesize, kernel_memsize = 0;
    91		u32 phys_seed = 0;
    92	
    93		/*
    94		 * Although relocatable kernels can fix up the misalignment with
    95		 * respect to MIN_KIMG_ALIGN, the resulting virtual text addresses are
    96		 * subtly out of sync with those recorded in the vmlinux when kaslr is
    97		 * disabled but the image required relocation anyway. Therefore retain
    98		 * 2M alignment if KASLR was explicitly disabled, even if it was not
    99		 * going to be activated to begin with.
   100		 */
   101		u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : SEGMENT_ALIGN;
   102	
   103		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
   104			efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
   105			void *p;
   106	
   107			if (efi_nokaslr) {
   108				efi_info("KASLR disabled on kernel command line\n");
   109			} else if (efi_bs_call(handle_protocol, image_handle,
   110					       &li_fixed_proto, &p) == EFI_SUCCESS) {
   111				efi_info("Image placement fixed by loader\n");
   112			} else {
   113				status = efi_get_random_bytes(sizeof(phys_seed),
   114							      (u8 *)&phys_seed);
   115				if (status == EFI_NOT_FOUND) {
   116					efi_info("EFI_RNG_PROTOCOL unavailable\n");
   117					efi_nokaslr = true;
   118				} else if (status != EFI_SUCCESS) {
   119					efi_err("efi_get_random_bytes() failed (0x%lx)\n",
   120						status);
   121					efi_nokaslr = true;
   122				}
   123			}
   124		}
   125	
   126		if (image->image_base != _text)
   127			efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
   128	
   129		if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
   130			efi_err("FIRMWARE BUG: kernel image not aligned on %dk boundary\n",
   131				SEGMENT_ALIGN >> 10);
   132	
   133		kernel_size = _edata - _text;
   134		kernel_codesize = __inittext_end - _text;
   135		kernel_memsize = kernel_size + (_end - _edata);
   136		*reserve_size = kernel_memsize;
   137	
   138		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
   139			/*
   140			 * If KASLR is enabled, and we have some randomness available,
   141			 * locate the kernel at a randomized offset in physical memory.
   142			 */
   143			status = efi_random_alloc(*reserve_size, min_kimg_align,
   144						  reserve_addr, phys_seed,
   145						  EFI_LOADER_CODE);
   146			if (status != EFI_SUCCESS)
   147				efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
   148		} else {
   149			status = EFI_OUT_OF_RESOURCES;
   150		}
   151	
   152		if (status != EFI_SUCCESS) {
   153			if (!check_image_region((u64)_text, kernel_memsize)) {
   154				efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
   155			} else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
   156				/*
   157				 * Just execute from wherever we were loaded by the
   158				 * UEFI PE/COFF loader if the alignment is suitable.
   159				 */
   160				*image_addr = (u64)_text;
   161				*reserve_size = 0;
   162				return EFI_SUCCESS;
   163			}
   164	
   165			status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
   166							    ULONG_MAX, min_kimg_align,
   167							    EFI_LOADER_CODE);
   168	
   169			if (status != EFI_SUCCESS) {
   170				efi_err("Failed to relocate kernel\n");
   171				*reserve_size = 0;
   172				return status;
   173			}
   174		}
   175	
   176		*image_addr = *reserve_addr;
   177		memcpy((void *)*image_addr, _text, kernel_size);
 > 178		caches_clean_inval_pou((void *)*image_addr,
   179				       (void *)*image_addr + kernel_codesize);
   180	
   181		return EFI_SUCCESS;
   182	}
   183	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
