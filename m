Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7253C16E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 02:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiFCA2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiFCA2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:28:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A3167ED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654216079; x=1685752079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vU1nJMXXTXKHedGcCpyD8EeoPuKqkJR5BHcP5RCD+KQ=;
  b=Q3ipl8jrnxFOZq5MD8mQwQ6NmeXPLrsdxrl4XEE38IYcn6oLxUBPMYUW
   fyHMhigKVLnKRKtAXFhyUjM5yZSZ8dg3l//EkoZGfDADE1ythfSKWEU8v
   RUvoVYKQpvv0qtcYwt3pDluKF3w6KFZilgRsS3HJxsPiZQ0KLs8i5wfcg
   TuelVNmwyYxV0vGRZcd+LReXF6PxWt+TzAqhJ1Uj+i+VGacZEgbycsZ6a
   TH6UJqfN+/DLTbjwNs6YKtFD/6DlP2ORCk4YsKb8/PAQwWscM+XFtINot
   rFcA2P8lIJVsy/FrFyBTJIo+58z56NwP+cnTKGuyd4QT8bmj3rb/4ih8A
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276195739"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="276195739"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 17:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="563564317"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2022 17:27:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwvAQ-0005Y9-O1;
        Fri, 03 Jun 2022 00:27:54 +0000
Date:   Fri, 3 Jun 2022 08:27:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 154/159] mm/memory-failure.c:1538:9: error:
 implicit declaration of function 'hugetlb_set_page_hwpoison'
Message-ID: <202206030829.0eS2kZa0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   1bdf44dbc966e31c635199d413ee064a7d320844
commit: d4edf38ab95397f32ae017848deeeb3b6d2c5bb7 [154/159] mm, hwpoison, hugetlb: introduce SUBPAGE_INDEX_HWPOISON to save raw error page
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220603/202206030829.0eS2kZa0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d4edf38ab95397f32ae017848deeeb3b6d2c5bb7
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout d4edf38ab95397f32ae017848deeeb3b6d2c5bb7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/memory-failure.c: In function '__get_huge_page_for_hwpoison':
>> mm/memory-failure.c:1538:9: error: implicit declaration of function 'hugetlb_set_page_hwpoison' [-Werror=implicit-function-declaration]
    1538 |         hugetlb_set_page_hwpoison(head, page);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/hugetlb_set_page_hwpoison +1538 mm/memory-failure.c

  1498	
  1499	/*
  1500	 * Called from hugetlb code with hugetlb_lock held.
  1501	 *
  1502	 * Return values:
  1503	 *   0             - free hugepage
  1504	 *   1             - in-use hugepage
  1505	 *   2             - not a hugepage
  1506	 *   -EBUSY        - the hugepage is busy (try to retry)
  1507	 *   -EHWPOISON    - the hugepage is already hwpoisoned
  1508	 */
  1509	int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
  1510	{
  1511		struct page *page = pfn_to_page(pfn);
  1512		struct page *head = compound_head(page);
  1513		int ret = 2;	/* fallback to normal page handling */
  1514		bool count_increased = false;
  1515	
  1516		if (!PageHeadHuge(head))
  1517			goto out;
  1518	
  1519		if (flags & MF_COUNT_INCREASED) {
  1520			ret = 1;
  1521			count_increased = true;
  1522		} else if (HPageFreed(head)) {
  1523			ret = 0;
  1524		} else if (HPageMigratable(head)) {
  1525			ret = get_page_unless_zero(head);
  1526			if (ret)
  1527				count_increased = true;
  1528		} else {
  1529			ret = -EBUSY;
  1530			goto out;
  1531		}
  1532	
  1533		if (TestSetPageHWPoison(head)) {
  1534			ret = -EHWPOISON;
  1535			goto out;
  1536		}
  1537	
> 1538		hugetlb_set_page_hwpoison(head, page);
  1539	
  1540		return ret;
  1541	out:
  1542		if (count_increased)
  1543			put_page(head);
  1544		return ret;
  1545	}
  1546	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
