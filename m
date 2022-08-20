Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1559AA27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbiHTAf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245389AbiHTAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:35:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD191159BE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660955720; x=1692491720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u+jKNMAv2QBjpgVGIu1QRH5JUvIQU87P1I7YhJ8b/3k=;
  b=NgMtlHmSIfCqho9cAKyYVPA7EOiRbOY2U7w/ecJe+Pkf3GjFFJKjv+Fd
   zrL4ndNYRGwls1yM/wbbXmkyOpDYWLRLxfYmXj1FONl/IkLUgBGO4EIId
   +WzjqjaPB0cx8rqfYVR/+qFIz2plHu/PGgQgwBVY7FHRvjMfK8stXAz1V
   dyPHbPb0ZwjEwSkUHl0wICDuA3hbZmeGAK8myBjv9vgc+48tThwjZ4vxw
   5b5FoDP7KoCBSksHlEdacMAOV0MJAVrIWeZe877CZXz0l8FLQodUnCB1C
   aPuzlk/RyrPBJhFX6n2FLNYboLYoxENE0MPy8FvHzA/kz0hv5YEC33MxS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="319161082"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="319161082"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 17:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="559124265"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2022 17:35:18 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPCSL-0001xL-1x;
        Sat, 20 Aug 2022 00:35:17 +0000
Date:   Sat, 20 Aug 2022 08:34:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 14/36]
 arch/x86/mm/mem_encrypt_amd.c:218:13: warning: no previous prototype for
 'sev_setup_arch'
Message-ID: <202208200810.iwA9Ntvg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/include/asm/mem_encrypt.h
arch/x86/kernel/setup.c
arch/x86/mm/mem_encrypt.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 2549eea318a696f39dcf080dd7143de849c530d0 [14/36] x86/swiotlb: Adjust SWIOTLB bounce buffer size for TDX guests
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220820/202208200810.iwA9Ntvg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/2549eea318a696f39dcf080dd7143de849c530d0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 2549eea318a696f39dcf080dd7143de849c530d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/mem_encrypt_amd.c:218:13: warning: no previous prototype for 'sev_setup_arch' [-Wmissing-prototypes]
     218 | void __init sev_setup_arch(void)
         |             ^~~~~~~~~~~~~~


vim +/sev_setup_arch +218 arch/x86/mm/mem_encrypt_amd.c

b9d05200bc1244 arch/x86/mm/mem_encrypt.c     Tom Lendacky  2017-07-17  217  
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10 @218  void __init sev_setup_arch(void)
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  219  {
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  220  	phys_addr_t total_mem = memblock_phys_mem_size();
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  221  	unsigned long size;
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  222  
4d96f9109109be arch/x86/mm/mem_encrypt.c     Tom Lendacky  2021-09-08  223  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  224  		return;
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  225  
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  226  	/*
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  227  	 * For SEV, all DMA has to occur via shared/unencrypted pages.
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  228  	 * SEV uses SWIOTLB to make this happen without changing device
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  229  	 * drivers. However, depending on the workload being run, the
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  230  	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  231  	 * run out of buffers for DMA, resulting in I/O errors and/or
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  232  	 * performance degradation especially with high I/O workloads.
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  233  	 *
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  234  	 * Adjust the default size of SWIOTLB for SEV guests using
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  235  	 * a percentage of guest memory for SWIOTLB buffers.
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  236  	 * Also, as the SWIOTLB bounce buffer memory is allocated
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  237  	 * from low memory, ensure that the adjusted size is within
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  238  	 * the limits of low available memory.
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  239  	 *
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  240  	 * The percentage of guest memory used here for SWIOTLB buffers
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  241  	 * is more of an approximation of the static adjustment which
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  242  	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  243  	 */
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  244  	size = total_mem * 6 / 100;
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  245  	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  246  	swiotlb_adjust_size(size);
3f9dfbebdc48ce arch/x86/mm/mem_encrypt_amd.c Juergen Gross 2022-06-06  247  
3f9dfbebdc48ce arch/x86/mm/mem_encrypt_amd.c Juergen Gross 2022-06-06  248  	/* Set restricted memory access for virtio. */
a603002eea8213 arch/x86/mm/mem_encrypt_amd.c Juergen Gross 2022-06-22  249  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  250  }
e998879d4fb799 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  251  

:::::: The code at line 218 was first introduced by commit
:::::: e998879d4fb7991856916972168cf27c0d86ed12 x86,swiotlb: Adjust SWIOTLB bounce buffer size for SEV guests

:::::: TO: Ashish Kalra <ashish.kalra@amd.com>
:::::: CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
