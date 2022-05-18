Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFD52B8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiERLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiERLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:24:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274915F6D1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652873072; x=1684409072;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3CBOJtm3SCudVVLJTJ5TbdSvyogWDi0s+IflUKxLS+Q=;
  b=cgFeyiBuLLscWCIDxvJcNJQJxeakQ0klcX9DOaVg1BxpYuAXwfL8muum
   AfnePTb8Fn4U1nNyuRcxDBJoMToHxG2vKOh0wVRmZ/dG3kEYx1mo8czvR
   sydBOlaIw739Ml5Qu6+J7YVGtuIjlpbkpq4/uBI3gHzdH1e4Ihbti0x2M
   E/qjXQ/mCePUPIMZYMbLNPbn05bLHCtNROMJlBO3INFyH52vfN1Jr1Y65
   N818RkRk6vG6hlYDawO0ES3DI+EUVamvbHR92BVRbcLuPAn8Y95h2BvbK
   gjyIM+tVeV4jHNjoW5QS+KiNM3RZw2QUCGttTMnDRt5XfLY8lUJwyBumq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332242728"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="332242728"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="556273512"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2022 04:24:31 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrHn4-00026T-OF;
        Wed, 18 May 2022 11:24:30 +0000
Date:   Wed, 18 May 2022 19:24:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e
Message-ID: <6284d767.k5M94a7OjidK2rYi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e  x86/sgx: Ensure no data in PCMD page after truncate

elapsed time: 970m

configs tested: 33
configs skipped: 94

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-c001-20220516
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a016-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a011-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a016-20220516
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
x86_64               randconfig-a002-20220516
x86_64               randconfig-a001-20220516
i386                 randconfig-a005-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a002-20220516
i386                 randconfig-a006-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
