Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287DF547131
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiFKB5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKB5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:57:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A959344E6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654912621; x=1686448621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+dzU/oEkxwHWZfdVf8TncKmDuQ9JVAC/MDL6+ESJ2gE=;
  b=NQUNEHoCB6d2XWByDTDsSw9fnfvbBfVqFNWFI8ZbQqXWEkTYbl7iLaQq
   +6Emh1cM05bw/HXMCMF84ZMythUx9trz6uBnKDAfV2JnLeZrnfqST1sx0
   qUjAddlSKGYr8SoKGu3UmsQBdbqS3ElTQ83I6teqC0qCwlCpD+i9tDlA7
   NbCN6OupT+kQ7hYNI/mc0txMzwQUDmlgSemazzdXSyfdDp6yTJlK/eHG4
   w/nw4nYh+mR9jybbIZuJ3ZRr8Dp5ad8lcFLgphFxNtXTR8AXAz+GDwTAh
   s8Nv/zY3rH4GprcG6rJaNF6B1pJDtPvXrX5lx8JH8nNFkPZ4xF4icW9Nl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278599927"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="278599927"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 18:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="638449957"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 18:56:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzqN0-000ISV-Ex;
        Sat, 11 Jun 2022 01:56:58 +0000
Date:   Sat, 11 Jun 2022 09:56:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: [gregkh-spdx:spdx-linus 16/26] arch/x86/crypto/crc32-pclmul_asm.S:2:
 Error: junk at end of line, first unrecognized character is `*'
Message-ID: <202206110936.UIMGLIoN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git spdx-linus
head:   ce3f3ccc90b8207946a4eea45c4bd539e35cbe2c
commit: 2eb72d6696c685369fca7cd63cb4b76d1be099e0 [16/26] treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_179.RULE
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220611/202206110936.UIMGLIoN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git/commit/?id=2eb72d6696c685369fca7cd63cb4b76d1be099e0
        git remote add gregkh-spdx https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
        git fetch --no-tags gregkh-spdx spdx-linus
        git checkout 2eb72d6696c685369fca7cd63cb4b76d1be099e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/crypto/crc32-pclmul_asm.S: Assembler messages:
>> arch/x86/crypto/crc32-pclmul_asm.S:2: Error: junk at end of line, first unrecognized character is `*'


vim +2 arch/x86/crypto/crc32-pclmul_asm.S

78c37d191dd689 Alexander Boyko 2013-01-10 @2   */
78c37d191dd689 Alexander Boyko 2013-01-10  3  

:::::: The code at line 2 was first introduced by commit
:::::: 78c37d191dd6899d8c219fee597a17d6e3c5d288 crypto: crc32 - add crc32 pclmulqdq implementation and wrappers for table implementation

:::::: TO: Alexander Boyko <alexander_boyko@xyratex.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
