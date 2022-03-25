Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D624E6B62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356827AbiCYAEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356799AbiCYAEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:04:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3016BB926
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648166555; x=1679702555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y9uapHHYXU+lH1i3kMt8hH9+FyX8blcVIHHU2bAcKas=;
  b=Oe9pY8VV3Jsc0V5Ps3De0rrtBHJXQNK0SrKUxOUpvOI1Pf7kCSbcI18t
   1XXJWrA2xGUNnC3RRS7pvk3ew8E34aQUfP72NXmU4PUw1cZZOH0DXO96T
   4Fx9NUKggQmTEoKx/f5HgVe5O9GpXForcVVSP7kxtzWPMEl0K4XmEV5gj
   4Aw6orRVgdZNSjvURRwBXaeqn79k1rv9gaTaamCvkYDip8hLAsBufTbYY
   r21b1PedbH7o6fzY5IB8zE3bFY/4r0UV9nBeC3OMvJgZUSXB4046SZUKr
   pJOCXCfAt/Zb5rnup9jKOyfmYaJCTiCLqtDaRbO2WV5N1ugHOt7uX2Pl7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="240675013"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="240675013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 17:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="520000315"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2022 17:02:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXXPV-000LZs-5a; Fri, 25 Mar 2022 00:02:33 +0000
Date:   Fri, 25 Mar 2022 08:01:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [tip:x86/urgent 5/5] arch/x86/lib/iomem.c:66:28: sparse: sparse:
 dereference of noderef expression
Message-ID: <202203250750.ghDxLnaB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   fb96320e194066cd9a177989920e8854fa6c1537
commit: fb96320e194066cd9a177989920e8854fa6c1537 [5/5] x86/sev: Unroll string mmio with CC_ATTR_GUEST_UNROLL_STRING_IO
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220325/202203250750.ghDxLnaB-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fb96320e194066cd9a177989920e8854fa6c1537
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/urgent
        git checkout fb96320e194066cd9a177989920e8854fa6c1537
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/lib/iomem.c:39:23: sparse: sparse: cast removes address space '__iomem' of expression
   arch/x86/lib/iomem.c:56:19: sparse: sparse: cast removes address space '__iomem' of expression
   arch/x86/lib/iomem.c:115:25: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/x86/lib/iomem.c:66:28: sparse: sparse: dereference of noderef expression
   arch/x86/lib/iomem.c:76:20: sparse: sparse: dereference of noderef expression
   arch/x86/lib/iomem.c:85:20: sparse: sparse: dereference of noderef expression

vim +66 arch/x86/lib/iomem.c

    58	
    59	static void unrolled_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
    60	{
    61		const volatile char __iomem *in = from;
    62		char *out = to;
    63		int i;
    64	
    65		for (i = 0; i < n; ++i)
  > 66			out[i] = in[i];
    67	}
    68	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
