Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CA4EAB09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiC2KKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiC2KKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:10:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABA191424
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648548506; x=1680084506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TTfnxWzRFGrqmES48W+eNnKisc4P2oeFZqM44wRh9lY=;
  b=TXs7a+9vooxE7ZI8Sej5vwWUGjGF7RcmUjUr2oplTcErXxv5j8NTOc8A
   JuSVlDyj1mPC2lmjINnvRiI+jQb97lRwND7S9OZ4HyXZInJH1O0ARjYyg
   rqhjsZDqvMS4vHXLPWVD6PP2gfZEh1jC0TQkdXIgF4rIzEIhHbp7tycG8
   aQRGCvBhV+yiKgDkMQrFrxNZfE5BRdUcGhW6FY69D3znpHhKEnl/6xvS/
   vFMBI2m9v/9n3mUGCjyD2D02DhaYvx3Y3ZonLJw1nYnLt1Ikq7+uXPoWn
   5azPRJhCm8MlB4fmMwlWfO8Krr/Gbnc1umb3fHTCzoNBV70QBik0RdmU8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239808811"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="239808811"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 03:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="564500753"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2022 03:08:24 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ8m0-00005j-32; Tue, 29 Mar 2022 10:08:24 +0000
Date:   Tue, 29 Mar 2022 18:07:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: [agd5f:amd-staging-drm-next 5/6]
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon
Message-ID: <202203291820.47RoPjxh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next
head:   fc0c15fb4751de221eeb82b7a83fe3935f56b931
commit: dcf23795ffe2e1235a22c24260157086d2da38aa [5/6] drm/amdgpu/vcn: Add VCN ras error query support
config: csky-randconfig-c003-20220329 (https://download.01.org/0day-ci/archive/20220329/202203291820.47RoPjxh-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
