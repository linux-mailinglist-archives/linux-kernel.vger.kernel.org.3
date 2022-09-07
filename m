Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7A5B104E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIGXWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIGXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:22:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DFA030C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662592956; x=1694128956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YYpJ9ON5pejesixYXv1HlxWUGInAAlOXrirYQK2QFlQ=;
  b=Sf75pAIhLZEsrrTeakGBxf4mKeT49QrxfVxQ+HKlclnVJYoWKl1VDOU+
   NozpCKnRZ4tEJkHY/tbxz9KfmAWuef1KSG8jS8aMFxi87ezPtAQDBKgvm
   LfdJd2u/2ogMhhMEmIiayK9H/hgsXg+2T18/4loWP8XFvrBvnCN+tDxcG
   NQlLOUoFsnOZ/fakhARSp++gNDbLkzkvUffe5PRKVIOdGrTEuSP4w3fno
   AeuT/ICzgOk0Ja277YzI1JBn4KBfAGZYEbN7kRe48W1dvKnU7Kjf5rq1I
   YZL35DnhRXm5QocLRlZmSLBY+eeGcf6At7DQIL4l34GP4kP+7smuPtNG+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297826910"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="297826910"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 16:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="644827870"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2022 16:22:35 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW4NO-00073l-21;
        Wed, 07 Sep 2022 23:22:34 +0000
Date:   Thu, 8 Sep 2022 07:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [daveh-devel:testme 1/1] arch/x86/mm/pat/set_memory.c:2254:22:
 error: invalid operands to binary | (have 'pgprot_t' {aka 'struct pgprot'}
 and 'long long unsigned int')
Message-ID: <202209080702.1fD2ZwWW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git testme
head:   081cfdf8062c89d33ee205da299ea36b7e648a5a
commit: 081cfdf8062c89d33ee205da299ea36b7e648a5a [1/1] x86/mm: Set NX bit when making pages present
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220908/202209080702.1fD2ZwWW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?id=081cfdf8062c89d33ee205da299ea36b7e648a5a
        git remote add daveh-devel https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git
        git fetch --no-tags daveh-devel testme
        git checkout 081cfdf8062c89d33ee205da299ea36b7e648a5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/mm/pat/set_memory.c: In function '__set_pages_p':
>> arch/x86/mm/pat/set_memory.c:2254:22: error: invalid operands to binary | (have 'pgprot_t' {aka 'struct pgprot'} and 'long long unsigned int')
    2254 |         cpa.mask_set |= __supported_pte_mask & _PAGE_NX;
         |                      ^~


vim +2254 arch/x86/mm/pat/set_memory.c

  2239	
  2240	static int __set_pages_p(struct page *page, int numpages)
  2241	{
  2242		unsigned long tempaddr = (unsigned long) page_address(page);
  2243		struct cpa_data cpa = { .vaddr = &tempaddr,
  2244					.pgd = NULL,
  2245					.numpages = numpages,
  2246					.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
  2247					.mask_clr = __pgprot(0),
  2248					.flags = 0};
  2249	
  2250		/*
  2251		 * Avoid W^X mappings that occur if the old
  2252		 * mapping was !_PAGE_RW and !_PAGE_NX.
  2253		 */
> 2254		cpa.mask_set |= __supported_pte_mask & _PAGE_NX;
  2255	
  2256		/*
  2257		 * No alias checking needed for setting present flag. otherwise,
  2258		 * we may need to break large pages for 64-bit kernel text
  2259		 * mappings (this adds to complexity if we want to do this from
  2260		 * atomic context especially). Let's keep it simple!
  2261		 */
  2262		return __change_page_attr_set_clr(&cpa, 0);
  2263	}
  2264	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
