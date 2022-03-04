Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C14CCBF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiCDCt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiCDCt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:49:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1C286C6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646362121; x=1677898121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+8hY6DbHBYhSkDcIK+vjORSYWoPOrAD5VjPkQfWTxC4=;
  b=jBfyhTUYWDfvY3dPDwa19xHi2jI2RnmJu4Aj5qRbQbnRliAnOn5rpMfy
   PSD5aImBP4sT4eF0VhTY4SKDKmNnDTwGL86zKn7yUp6b7KwY6qx9saH1y
   +ZQOgkzfTZbTFkFPQdAgwnKmFQBIu/onrxwrv28shBqlhIOEQEh8sgH9p
   2foezgedEQ0O3TPzPcMoCDNSm58ZLEHKAZRpqnyJqVrnwxn+UjyuYeCC6
   O47E0Y7qDN6siT8sgtB0XLmVlgOD/M72WNCHY+ass0JqMd8vyQv450IDC
   dS++DXAkqVR7HCqXgMyGsaEYmaQbWLzogOsWyJgeMc2DseJylHSjap3+I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="251453753"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="251453753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 18:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="576743561"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 18:48:38 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPxzi-0001CI-1h; Fri, 04 Mar 2022 02:48:38 +0000
Date:   Fri, 4 Mar 2022 10:47:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: arch/x86/platform/efi/quirks.c:609:5: warning: no previous
 declaration for 'efi_capsule_setup_info'
Message-ID: <202203040947.9FLycm7z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b08968f196d498b19e9d0841d76a03862258f2d8
commit: 2959c95d510cc45b246ba727eb8fdf8b601c6eec efi/capsule: Add support for Quark security header
date:   4 years, 9 months ago
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220304/202203040947.9FLycm7z-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2959c95d510cc45b246ba727eb8fdf8b601c6eec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2959c95d510cc45b246ba727eb8fdf8b601c6eec
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/platform/efi/ drivers/gpu/drm/i915/ kernel/power/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/platform/efi/quirks.c:242:13: warning: no previous declaration for 'efi_arch_mem_reserve' [-Wmissing-declarations]
    void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
                ^~~~~~~~~~~~~~~~~~~~
>> arch/x86/platform/efi/quirks.c:609:5: warning: no previous declaration for 'efi_capsule_setup_info' [-Wmissing-declarations]
    int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
        ^~~~~~~~~~~~~~~~~~~~~~


vim +/efi_capsule_setup_info +609 arch/x86/platform/efi/quirks.c

   608	
 > 609	int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
   610				   size_t hdr_bytes)
   611	{
   612		int (*quirk_handler)(struct capsule_info *, void **, size_t);
   613		const struct x86_cpu_id *id;
   614		int ret;
   615	
   616		if (hdr_bytes < sizeof(efi_capsule_header_t))
   617			return 0;
   618	
   619		cap_info->total_size = 0;
   620	
   621		id = x86_match_cpu(efi_capsule_quirk_ids);
   622		if (id) {
   623			/*
   624			 * The quirk handler is supposed to return
   625			 *  - a value > 0 if the setup should continue, after advancing
   626			 *    kbuff as needed
   627			 *  - 0 if not enough hdr_bytes are available yet
   628			 *  - a negative error code otherwise
   629			 */
   630			quirk_handler = (typeof(quirk_handler))id->driver_data;
   631			ret = quirk_handler(cap_info, &kbuff, hdr_bytes);
   632			if (ret <= 0)
   633				return ret;
   634		}
   635	
   636		memcpy(&cap_info->header, kbuff, sizeof(cap_info->header));
   637	
   638		cap_info->total_size += cap_info->header.imagesize;
   639	
   640		return __efi_capsule_setup_info(cap_info);
   641	}
   642	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
