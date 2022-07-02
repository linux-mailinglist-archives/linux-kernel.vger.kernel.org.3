Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83364563F1E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiGBIdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 04:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGBIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:33:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D315817
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656750826; x=1688286826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2uiYBZ9p3nrHThaimZfM3RJOpyi3lU62pQ40lunIWIY=;
  b=daQSwrch69BGg2t9SszC4lZu+8Gv8uAVtKEJEb4rWxgJdSrWJrNfvxYo
   SW7mSQWAkmwq53O4Hfrb4/nqoecVCexGIsfK5RZurINi6KrRwuuNc67mX
   nDswIyGPU7eMM148IwW0EO+kTTPs6yB2F2FEPx2Y6ZcfRBkf2Cht8ZIvG
   T6u4iD4xf1iR2X1iI0UTiZ38kNXvNBmtJYMHMl11FkIzFJr5nKU/w5wEE
   0Ffynx6z8u6SE2FT2O6JaY1ilvS2rlYoBl4XPJJjjCDkF5Lpm9KbtPFyb
   0f3q8QTURC0pM2xUo1kvOEP/FLHxGBL45BuUUtQtN+t75eIjQuwsprrGl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="265842596"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="265842596"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 01:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="589584110"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Jul 2022 01:33:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7YZT-000F2r-Pu;
        Sat, 02 Jul 2022 08:33:43 +0000
Date:   Sat, 2 Jul 2022 16:32:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [akpm-mm:mm-unstable 302/323] arch/x86/mm/pgprot.c:26:6: warning: no
 previous prototype for 'add_encrypt_protection_map'
Message-ID: <202207021641.cClg5oDA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   706370e5c2ea7bb4544eee6e1172c4d68117a526
commit: d845587c05fd4ae52aaa0cd5c8939e8f4793301f [302/323] x86/mm: move protection_map[] inside the platform
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220702/202207021641.cClg5oDA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d845587c05fd4ae52aaa0cd5c8939e8f4793301f
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout d845587c05fd4ae52aaa0cd5c8939e8f4793301f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/pgprot.c:26:6: warning: no previous prototype for 'add_encrypt_protection_map' [-Wmissing-prototypes]
      26 | void add_encrypt_protection_map(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/add_encrypt_protection_map +26 arch/x86/mm/pgprot.c

    25	
  > 26	void add_encrypt_protection_map(void)
    27	{
    28		unsigned int i;
    29	
    30		for (i = 0; i < ARRAY_SIZE(protection_map); i++)
    31			protection_map[i] = pgprot_encrypted(protection_map[i]);
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
