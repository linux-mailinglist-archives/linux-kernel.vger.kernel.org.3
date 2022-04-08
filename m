Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72274F9E10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiDHUMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiDHUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:12:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A078393C1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649448608; x=1680984608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F2DeBM0McJmhWZxPlSYwjjlSeXj/qB5iDbelSASphXk=;
  b=hC88gLK6pXD8QR4VSGGTPMu4f8HwxQuvlCamUn/mTTFS59etcV8Hfo8W
   7Ujz4qluX27ZUZ26neOL+xBB3O4Pf3mo4MbTVj2y30HceiDGyGml9eeZt
   gNC6VEi0NzSVUKxuQtj6b6z9wK9boFu7WNWe3hQOr4UYlLhaKhMMQaQ5c
   1+FGBahMrWM7cexXrjfCHD2K7jrC4FE5nCQR1J9pTmTCFXqqrCc5Tmxol
   UzwzUv7Wyffj4FHdHyBQCedGl2FRhKKxJJ8nhiW4HrgaTGMusSQKRCko4
   GvIHoy2RkuFFQtbEvd03XrFUr8Sthjr1nJwJ9SU147eIU7KHCWaHSVhfN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="243809493"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243809493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="506679683"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2022 13:10:06 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncuvl-0000bN-AU;
        Fri, 08 Apr 2022 20:10:05 +0000
Date:   Sat, 9 Apr 2022 04:09:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: arch/x86/platform/efi/quirks.c:609:5: warning: no previous
 declaration for 'efi_capsule_setup_info'
Message-ID: <202204090417.McieYWb5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1a3b1bba7c7a5eb8a11513cf88427cb9d77bc60a
commit: 2959c95d510cc45b246ba727eb8fdf8b601c6eec efi/capsule: Add support for Quark security header
date:   4 years, 10 months ago
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220409/202204090417.McieYWb5-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2959c95d510cc45b246ba727eb8fdf8b601c6eec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2959c95d510cc45b246ba727eb8fdf8b601c6eec
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/platform/efi/ drivers/net/dsa/ fs/f2fs/ fs/xfs/ net/sunrpc/xprtrdma/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
