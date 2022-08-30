Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B20E5A6232
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiH3LkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiH3Ljr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:39:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABE153D1B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661859501; x=1693395501;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZP7S2cGrU/c+7YXSBj6I3/v2Y3j1c0NXw8uPGfW5pRg=;
  b=Y0UU6n6eqM0/j/SUA7q3sDtlj4dMjItzFYWhxw26EW0ecNXKsAc6MtQt
   6Rpmm87uvecU1IE17OLP6FyeB3oIrAiTQTbq3pUhrGEDrJX8YIFk6LUr+
   gF2PBP8h1+kd/pMWFwLwnrYJ/hQbMJdvPtt221vp5KXEjQ0eNMcXkcoyE
   Xx9YeckLtVVrHVoexDgwJP6rkrsN2wT7v1CbX569iWcIEArW6qsNTeNtZ
   cHpqOy44BwHnSLABL98aW8pqmwhcVs0gxdR7ogIev/kIl55ELWFZAeQnH
   OdiL7LY7pWnr1+LO9I9zTi32qZBuCvOG3WLDgqf+uY8Gk7TuywQO24lde
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="292729487"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="292729487"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 04:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="680004077"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2022 04:38:18 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSzZR-0000Fe-1k;
        Tue, 30 Aug 2022 11:38:17 +0000
Date:   Tue, 30 Aug 2022 19:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:virt-to-pfn-v6.0-rc1 24/24]
 arch/x86/xen/setup.c:341:20: sparse: sparse: incorrect type in argument 1
 (different base types)
Message-ID: <202208301933.EfJXBgQg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git virt-to-pfn-v6.0-rc1
head:   fd7709c9f1119794e96665ae423d79d93bfe43fc
commit: fd7709c9f1119794e96665ae423d79d93bfe43fc [24/24] x86/xen: Make virt_to_pfn() a static inline
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220830/202208301933.EfJXBgQg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=fd7709c9f1119794e96665ae423d79d93bfe43fc
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator virt-to-pfn-v6.0-rc1
        git checkout fd7709c9f1119794e96665ae423d79d93bfe43fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/xen/ drivers/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/xen/setup.c:341:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long buf @@
   arch/x86/xen/setup.c:341:20: sparse:     expected void const *v
   arch/x86/xen/setup.c:341:20: sparse:     got unsigned long buf

vim +341 arch/x86/xen/setup.c

83d51ab473dddd David Vrabel  2012-05-03  316  
83d51ab473dddd David Vrabel  2012-05-03  317  /*
4fbb67e3c87b80 Matt Rushton  2014-08-11  318   * This function updates the p2m and m2p tables with an identity map from
1f3ac86b4c45a1 Juergen Gross 2014-11-28  319   * start_pfn to start_pfn+size and prepares remapping the underlying RAM of the
1f3ac86b4c45a1 Juergen Gross 2014-11-28  320   * original allocation at remap_pfn. The information needed for remapping is
1f3ac86b4c45a1 Juergen Gross 2014-11-28  321   * saved in the memory itself to avoid the need for allocating buffers. The
1f3ac86b4c45a1 Juergen Gross 2014-11-28  322   * complete remap information is contained in a list of MFNs each containing
1f3ac86b4c45a1 Juergen Gross 2014-11-28  323   * up to REMAP_SIZE MFNs and the start target PFN for doing the remap.
1f3ac86b4c45a1 Juergen Gross 2014-11-28  324   * This enables us to preserve the original mfn sequence while doing the
1f3ac86b4c45a1 Juergen Gross 2014-11-28  325   * remapping at a time when the memory management is capable of allocating
1f3ac86b4c45a1 Juergen Gross 2014-11-28  326   * virtual and physical memory in arbitrary amounts, see 'xen_remap_memory' and
1f3ac86b4c45a1 Juergen Gross 2014-11-28  327   * its callers.
83d51ab473dddd David Vrabel  2012-05-03  328   */
1f3ac86b4c45a1 Juergen Gross 2014-11-28  329  static void __init xen_do_set_identity_and_remap_chunk(
4fbb67e3c87b80 Matt Rushton  2014-08-11  330          unsigned long start_pfn, unsigned long size, unsigned long remap_pfn)
4fbb67e3c87b80 Matt Rushton  2014-08-11  331  {
1f3ac86b4c45a1 Juergen Gross 2014-11-28  332  	unsigned long buf = (unsigned long)&xen_remap_buf;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  333  	unsigned long mfn_save, mfn;
4fbb67e3c87b80 Matt Rushton  2014-08-11  334  	unsigned long ident_pfn_iter, remap_pfn_iter;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  335  	unsigned long ident_end_pfn = start_pfn + size;
4fbb67e3c87b80 Matt Rushton  2014-08-11  336  	unsigned long left = size;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  337  	unsigned int i, chunk;
e201bfcc5c4fe6 David Vrabel  2013-07-22  338  
4fbb67e3c87b80 Matt Rushton  2014-08-11  339  	WARN_ON(size == 0);
e201bfcc5c4fe6 David Vrabel  2013-07-22  340  
1f3ac86b4c45a1 Juergen Gross 2014-11-28 @341  	mfn_save = virt_to_mfn(buf);
4fbb67e3c87b80 Matt Rushton  2014-08-11  342  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  343  	for (ident_pfn_iter = start_pfn, remap_pfn_iter = remap_pfn;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  344  	     ident_pfn_iter < ident_end_pfn;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  345  	     ident_pfn_iter += REMAP_SIZE, remap_pfn_iter += REMAP_SIZE) {
1f3ac86b4c45a1 Juergen Gross 2014-11-28  346  		chunk = (left < REMAP_SIZE) ? left : REMAP_SIZE;
4fbb67e3c87b80 Matt Rushton  2014-08-11  347  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  348  		/* Map first pfn to xen_remap_buf */
1f3ac86b4c45a1 Juergen Gross 2014-11-28  349  		mfn = pfn_to_mfn(ident_pfn_iter);
1f3ac86b4c45a1 Juergen Gross 2014-11-28  350  		set_pte_mfn(buf, mfn, PAGE_KERNEL);
4fbb67e3c87b80 Matt Rushton  2014-08-11  351  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  352  		/* Save mapping information in page */
1f3ac86b4c45a1 Juergen Gross 2014-11-28  353  		xen_remap_buf.next_area_mfn = xen_remap_mfn;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  354  		xen_remap_buf.target_pfn = remap_pfn_iter;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  355  		xen_remap_buf.size = chunk;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  356  		for (i = 0; i < chunk; i++)
1f3ac86b4c45a1 Juergen Gross 2014-11-28  357  			xen_remap_buf.mfns[i] = pfn_to_mfn(ident_pfn_iter + i);
4fbb67e3c87b80 Matt Rushton  2014-08-11  358  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  359  		/* Put remap buf into list. */
1f3ac86b4c45a1 Juergen Gross 2014-11-28  360  		xen_remap_mfn = mfn;
4fbb67e3c87b80 Matt Rushton  2014-08-11  361  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  362  		/* Set identity map */
bc7142cf798ae7 David Vrabel  2015-01-07  363  		set_phys_range_identity(ident_pfn_iter, ident_pfn_iter + chunk);
4fbb67e3c87b80 Matt Rushton  2014-08-11  364  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  365  		left -= chunk;
1f3ac86b4c45a1 Juergen Gross 2014-11-28  366  	}
4fbb67e3c87b80 Matt Rushton  2014-08-11  367  
1f3ac86b4c45a1 Juergen Gross 2014-11-28  368  	/* Restore old xen_remap_buf mapping */
1f3ac86b4c45a1 Juergen Gross 2014-11-28  369  	set_pte_mfn(buf, mfn_save, PAGE_KERNEL);
4fbb67e3c87b80 Matt Rushton  2014-08-11  370  }
4fbb67e3c87b80 Matt Rushton  2014-08-11  371  

:::::: The code at line 341 was first introduced by commit
:::::: 1f3ac86b4c45a146e090d24bf66c49b95e72f071 xen: Delay remapping memory of pv-domain

:::::: TO: Juergen Gross <jgross@suse.com>
:::::: CC: David Vrabel <david.vrabel@citrix.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
