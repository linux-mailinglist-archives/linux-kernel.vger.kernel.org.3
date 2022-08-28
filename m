Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23D5A3D29
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiH1KT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 06:19:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5713FAC
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661681994; x=1693217994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aH3rdrlnfu6yHPTlDNyVCLLXX0V0IGLJm62+sxeXb/I=;
  b=MGbofsdFuLGkM1e6icFttEIdTP5Mr3DHIahB+3jn9YuNvnRHarK07b3O
   ztxQpKxIRpZfKhEy+F8xiHW0lzn1Sxtfi9ROy//tz1D6YxPLbD6PD1RLn
   YextuGoPxT2FDjnbAJZtEatSoDwo070m2JiEkkCf8myfk+cBB5xbku3/e
   ItQwRKqXVxytJXgz7aAFXRl5J23GRWFz4XOuaZ5jn/DKM2hbbBuJ/b3Mq
   cwXEtZTTqLFQv5nXWVNcyKdcwzmzPx9R3b07gSXiALY2iYMj23WeF4RVN
   7sS3Jm4aN2gITw81Pqt7im7F5WTvvKI+er/rb12nN3DjtCNRO4O5AgZiC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="275131170"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="275131170"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 03:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="587828127"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2022 03:19:52 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSFOR-0000zz-2k;
        Sun, 28 Aug 2022 10:19:51 +0000
Date:   Sun, 28 Aug 2022 18:19:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 9/26]
 drivers/firmware/efi/libstub/zboot.c:160:23: warning: no previous prototype
 for function 'efi_zboot_entry'
Message-ID: <202208281813.FLX7bLix-lkp@intel.com>
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
head:   f73ff3c33fc5ad785682e0892d9fb664616cd9c0
commit: 3d0326fd09d1289fb3b1504e65381cae574ea9dc [9/26] efi/libstub: implement generic EFI zboot
config: riscv-randconfig-c006-20220828 (https://download.01.org/0day-ci/archive/20220828/202208281813.FLX7bLix-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=3d0326fd09d1289fb3b1504e65381cae574ea9dc
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 3d0326fd09d1289fb3b1504e65381cae574ea9dc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/ drivers/gpu/drm/bridge/imx/ drivers/gpu/drm/rcar-du/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/zboot.c:90:22: error: call to undeclared function 'get_unaligned_le32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           size = decompress ? get_unaligned_le32(_gzdata_end - 4)
                               ^
   drivers/firmware/efi/libstub/zboot.c:90:22: note: did you mean 'get_unaligned16'?
   drivers/firmware/efi/libstub/../../../../lib/zlib_inflate/inffast.c:20:1: note: 'get_unaligned16' declared here
   get_unaligned16(const unsigned short *p)
   ^
>> drivers/firmware/efi/libstub/zboot.c:160:23: warning: no previous prototype for function 'efi_zboot_entry' [-Wmissing-prototypes]
   efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
                         ^
   drivers/firmware/efi/libstub/zboot.c:160:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
   ^
   static 
   1 warning and 1 error generated.


vim +/efi_zboot_entry +160 drivers/firmware/efi/libstub/zboot.c

    57	
    58	static efi_status_t __efiapi
    59	load_file(efi_load_file_protocol_t *this, efi_device_path_protocol_t *rem,
    60		  bool boot_policy, unsigned long *bufsize, void *buffer)
    61	{
    62		struct efi_vendor_dev_path *vendor_dp;
    63		bool decompress = false;
    64		unsigned long size;
    65		int ret;
    66	
    67		if (rem == NULL || bufsize == NULL)
    68			return EFI_INVALID_PARAMETER;
    69	
    70		if (boot_policy)
    71			return EFI_UNSUPPORTED;
    72	
    73		// Look for our vendor media device node in the remaining file path
    74		if (rem->type == EFI_DEV_MEDIA &&
    75		    rem->sub_type == EFI_DEV_MEDIA_VENDOR) {
    76			vendor_dp = container_of(rem, struct efi_vendor_dev_path, header);
    77			if (!guids_eq(&vendor_dp->vendorguid, &LINUX_EFI_ZBOOT_MEDIA_GUID))
    78				return EFI_NOT_FOUND;
    79	
    80			decompress = true;
    81			rem = (void *)(vendor_dp + 1);
    82		}
    83	
    84		if (rem->type != EFI_DEV_END_PATH ||
    85		    rem->sub_type != EFI_DEV_END_ENTIRE)
    86			return EFI_NOT_FOUND;
    87	
    88		// The uncompressed size of the payload is appended to the raw bit
    89		// stream, and may therefore appear misaligned in memory
  > 90		size = decompress ? get_unaligned_le32(_gzdata_end - 4)
    91				  : (_gzdata_end - _gzdata_start);
    92		if (buffer == NULL || *bufsize < size) {
    93			*bufsize = size;
    94			return EFI_BUFFER_TOO_SMALL;
    95		}
    96	
    97		if (decompress) {
    98			ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start,
    99					   NULL, NULL, buffer, 0, NULL, error);
   100			if (ret	< 0) {
   101				log(L"Decompression failed");
   102				return EFI_DEVICE_ERROR;
   103			}
   104		} else {
   105			memcpy(buffer, _gzdata_start, size);
   106		}
   107	
   108		return EFI_SUCCESS;
   109	}
   110	
   111	// Return the length in bytes of the device path up to the first end node.
   112	static int device_path_length(const efi_device_path_protocol_t *dp)
   113	{
   114		int len = 0;
   115	
   116		while (dp->type != EFI_DEV_END_PATH) {
   117			len += dp->length;
   118			dp = (void *)((u8 *)dp + dp->length);
   119		}
   120		return len;
   121	}
   122	
   123	static void append_rel_offset_node(efi_device_path_protocol_t **dp,
   124					   unsigned long start, unsigned long end)
   125	{
   126		struct efi_rel_offset_dev_path *rodp = (void *)*dp;
   127	
   128		rodp->header.type	= EFI_DEV_MEDIA;
   129		rodp->header.sub_type	= EFI_DEV_MEDIA_REL_OFFSET;
   130		rodp->header.length	= sizeof(struct efi_rel_offset_dev_path);
   131		rodp->reserved		= 0;
   132		rodp->starting_offset	= start;
   133		rodp->ending_offset	= end;
   134	
   135		*dp = (void *)(rodp + 1);
   136	}
   137	
   138	static void append_ven_media_node(efi_device_path_protocol_t **dp,
   139					  efi_guid_t *guid)
   140	{
   141		struct efi_vendor_dev_path *vmdp = (void *)*dp;
   142	
   143		vmdp->header.type	= EFI_DEV_MEDIA;
   144		vmdp->header.sub_type	= EFI_DEV_MEDIA_VENDOR;
   145		vmdp->header.length	= sizeof(struct efi_vendor_dev_path);
   146		vmdp->vendorguid	= *guid;
   147	
   148		*dp = (void *)(vmdp + 1);
   149	}
   150	
   151	static void append_end_node(efi_device_path_protocol_t **dp)
   152	{
   153		(*dp)->type		= EFI_DEV_END_PATH;
   154		(*dp)->sub_type		= EFI_DEV_END_ENTIRE;
   155		(*dp)->length		= sizeof(struct efi_generic_dev_path);
   156	
   157		++*dp;
   158	}
   159	
 > 160	efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
