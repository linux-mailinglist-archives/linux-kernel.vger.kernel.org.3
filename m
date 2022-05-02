Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82651716D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383666AbiEBOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEBOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:23:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C017049
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651501171; x=1683037171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pbqeGrwfX0uCdNZ7PJqfmAS/kR7zYiy6N5fkrfdSjnA=;
  b=NXu/g+NzChq2NzF6OQ9VvdmcURHBPPwTyj05Q4lrtG469iHi6rNAN0jm
   PX71G3WW3KjNyaPhoHyhHUqk4GHVJnSFuiBLowAH+CgaFiYd+j9S4rtnD
   frHPdYSFFzJVDvNhD5tFc2mIBv0X+pu+pSbiMUDUqnszTeEpdJUM43fU/
   wsRBi/ImKxbUh4FeZoCe7msYHWfsfeNT7CQrVv9574Ncjyb8KuSggtKEk
   VI7D+VBaaabkdEffU70INrp9/WpfcqYuJwgeLvEH6mS98dQJCEVQ/Bdq2
   z3GoRng9WX8oK4+gcs3xCcCRYGpKDC/ZanFubfF/4SilsydpRUFj6BtL+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="266805658"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="266805658"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 07:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="619912934"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2022 07:19:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlWtc-0009bM-LI;
        Mon, 02 May 2022 14:19:28 +0000
Date:   Mon, 2 May 2022 22:19:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Michael Roth <michael.roth@amd.com>
Subject: [tip:x86/sev 55/55] arch/x86/kernel/sev.c:605:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202205022233.XgNDR7WR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
head:   c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
commit: c2106a231c2ba36ff9af50cdf2867b9a5f8150a6 [55/55] x86/sev: Get the AP jump table address from secrets page
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205022233.XgNDR7WR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/sev
        git checkout c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/sev.c:605:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct snp_secrets_page_layout *[assigned] layout @@
   arch/x86/kernel/sev.c:605:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/x86/kernel/sev.c:605:17: sparse:     got struct snp_secrets_page_layout *[assigned] layout

vim +605 arch/x86/kernel/sev.c

   588	
   589	static u64 __init get_snp_jump_table_addr(void)
   590	{
   591		struct snp_secrets_page_layout *layout;
   592		u64 pa, addr;
   593	
   594		pa = get_secrets_page();
   595		if (!pa)
   596			return 0;
   597	
   598		layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
   599		if (!layout) {
   600			pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
   601			return 0;
   602		}
   603	
   604		addr = layout->os_area.ap_jump_table_pa;
 > 605		iounmap(layout);
   606	
   607		return addr;
   608	}
   609	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
