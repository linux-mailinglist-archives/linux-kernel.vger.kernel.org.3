Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA99C4CAB86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbiCBR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbiCBR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:26:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAACA31A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646241923; x=1677777923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ml4z14gnzaIGJdVw3o8U+TjTp+O57mAV5Dmp1JCgn0E=;
  b=VLrOVXFB1XW/7dSeWHV7ZoAW80g1dgJUxYBO3EGH9zAjGKKume8EHVxE
   wkIGkZVNrPoHMkiib6QpOJcAUKwXmhbIZcbOIACUJOp6itScx2D5iO8nL
   Brs4WpHCm9jan1aqz03loNJi3+QM4oE0cEUZUQ6pQl1uS4gc8ZzWRan0s
   wP23qzjFb/Nr1TegRdRWUQ5f8YSHpebPS6yM8RZz3NtJgZIZLJpy52RiW
   n8J2ROjqJgdJueQ8RoTs42PwhwGDkO8FbRQeaZNRTIY67AZzNRZpJ2dEb
   z8d+Bqse66DAAttklxVKfhu9VhHfFuVgbPhbbBXmJxdt/qzaNEr4NpUkD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252289101"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="252289101"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="641775600"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 09:25:18 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPSiz-0001ee-Jx; Wed, 02 Mar 2022 17:25:17 +0000
Date:   Thu, 3 Mar 2022 01:24:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Kiryanov <rkir@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.4-p-release
 9213/9922] drivers/platform/goldfish/goldfish_pipe_v2.c:1161:15: warning:
 right shift count >= width of type
Message-ID: <202203030136.g7Nn5d2S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.4-p-release
head:   c159ade87311501e4e4b40eb2f35aa5607732957
commit: 7e3a6fc483350235bf3446492133d60c292d487c [9213/9922] goldfish: pipe: ANDROID: address must be written as __pa(x), not x
config: i386-randconfig-r005-20211118 (https://download.01.org/0day-ci/archive/20220303/202203030136.g7Nn5d2S-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/7e3a6fc483350235bf3446492133d60c292d487c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.4-p-release
        git checkout 7e3a6fc483350235bf3446492133d60c292d487c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/goldfish/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/goldfish/goldfish_pipe_v2.c: In function 'write_pa_addr':
>> drivers/platform/goldfish/goldfish_pipe_v2.c:1161:15: warning: right shift count >= width of type [-Wshift-count-overflow]
     writel(paddr >> 32, porth);
                  ^~
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:206: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'


vim +1161 drivers/platform/goldfish/goldfish_pipe_v2.c

  1155	
  1156	
  1157	static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
  1158	{
  1159		const unsigned long paddr = __pa(addr);
  1160	
> 1161		writel(paddr >> 32, porth);
  1162		writel((u32)paddr, portl);
  1163	}
  1164	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
