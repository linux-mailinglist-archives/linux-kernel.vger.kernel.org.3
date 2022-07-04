Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350C6564D99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiGDGQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGDGQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:16:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E85FD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656915388; x=1688451388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ekt4uuf7ImTYKF5SqdRh/F45p4fyH9LxbUlnTNYyGuM=;
  b=aNuJs+kKTVAyYUQtaFzs1wSfabT063cT8fvffmUR3O5Uc47Z8zChW34w
   IT9W2FXB5KR6iR/nWNtDKXv08qmup36I/jR8RBXzQ/5EoGZ2DbnA59OlA
   HGSAISddoN13PafIcs0nrdM9LnO/o4B6WaREMclqcezm0eJsVdcxkaB2+
   A5RKAt15TxLXUkDeQlbGDX57lb6HmBfiaOFASFbttFoAysR76ST/3Buw0
   2DQcFI/cUPz+czY1ZKbsluMlhAuENzTaB/RWoEPNyjYpwI2u143U8jAGX
   YmMdUFWU6/nYjkz/OO6DgmfxKLdjyeBDwP16Qb6QJgKmFf7c8//Dod2Iq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283074105"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283074105"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 23:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="542462170"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Jul 2022 23:16:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8FNh-000Hbf-Mo;
        Mon, 04 Jul 2022 06:16:25 +0000
Date:   Mon, 4 Jul 2022 14:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 244/249] mm/memory-failure.c:1679:59: error:
 'SUBPAGE_INDEX_HWPOISON' undeclared
Message-ID: <202207041434.cdFm3q6k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   ce4dc6b0378ef1bd305c37c94fb8aabee4c5be04
commit: 43906a2b9553df7799daed304529a6920e97f9e8 [244/249] mm, hwpoison, hugetlb: support saving mechanism of raw error pages
config: parisc-randconfig-r014-20220703 (https://download.01.org/0day-ci/archive/20220704/202207041434.cdFm3q6k-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=43906a2b9553df7799daed304529a6920e97f9e8
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 43906a2b9553df7799daed304529a6920e97f9e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from mm/memory-failure.c:37:
   mm/memory-failure.c: In function 'raw_hwp_list_head':
>> mm/memory-failure.c:1679:59: error: 'SUBPAGE_INDEX_HWPOISON' undeclared (first use in this function)
    1679 |         return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
         |                                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types.h:334:43: note: in definition of macro 'page_private'
     334 | #define page_private(page)              ((page)->private)
         |                                           ^~~~
   mm/memory-failure.c:1679:59: note: each undeclared identifier is reported only once for each function it appears in
    1679 |         return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
         |                                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types.h:334:43: note: in definition of macro 'page_private'
     334 | #define page_private(page)              ((page)->private)
         |                                           ^~~~
   mm/memory-failure.c:1680:1: error: control reaches end of non-void function [-Werror=return-type]
    1680 | }
         | ^
   cc1: some warnings being treated as errors


vim +/SUBPAGE_INDEX_HWPOISON +1679 mm/memory-failure.c

  1676	
  1677	static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
  1678	{
> 1679		return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
  1680	}
  1681	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
