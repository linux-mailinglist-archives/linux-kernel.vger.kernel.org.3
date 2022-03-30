Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30864EBAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiC3Gem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiC3Ge3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:34:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80856747
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648621964; x=1680157964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bnpQGFzpq9naOkvNK34rDVJEaDIOw4S3tixJfFa+j8w=;
  b=ctoHhCaEPr7zOzpZTM/daIke62Q5LDcc7aSiH0HduvrZtUyAjujDrXsn
   O1EsrUfnlxctO2bH7esRLJmmG7O8QNcqfbrpSWfxjfULmAFXsNQIPDbky
   p9eXGwijSzQINuxjNyJj9mnrzLvriuzy1aVtUHo/gSYRLscFrjye76yhR
   KoNRhfRydBn+RMn2ZfauVEtcLVcr+Qs1CW3hE9K/4U8XK1ghjgv+8lo6m
   AHCnCdaTUMUUK73+UCKzEJPUGEt8Q5dl/n2CJP5qY2JHgO3mTLUnOUwJO
   y0GEv9P0aj7EExkU45nMM8Cep8f+rYeE/bscR2WMf0+lVFdklRfvdumUx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259643826"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="259643826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="605275046"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2022 23:32:42 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZRsn-00013d-S8; Wed, 30 Mar 2022 06:32:41 +0000
Date:   Wed, 30 Mar 2022 14:32:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5835/5872] mm/compaction.c:766:15: error: redefinition of
 'isolate_and_split_free_page'
Message-ID: <202203301416.uykWxBeR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: 8cd9aa93b7269460e8d5e4407738f21fe5d6e720 [5835/5872] ANDROID: implement wrapper for reverse migration
config: arm64-randconfig-r036-20220327 (https://download.01.org/0day-ci/archive/20220330/202203301416.uykWxBeR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/8cd9aa93b7269460e8d5e4407738f21fe5d6e720
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 8cd9aa93b7269460e8d5e4407738f21fe5d6e720
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/compaction.c:766:15: error: redefinition of 'isolate_and_split_free_page'
   unsigned long isolate_and_split_free_page(struct page *page,
                 ^
   include/linux/compaction.h:241:22: note: previous definition is here
   static unsigned long isolate_and_split_free_page(struct page *page,
                        ^
   1 error generated.


vim +/isolate_and_split_free_page +766 mm/compaction.c

   765	
 > 766	unsigned long isolate_and_split_free_page(struct page *page,
   767							struct list_head *list)
   768	{
   769		unsigned long isolated;
   770		unsigned int order;
   771	
   772		if (!PageBuddy(page))
   773			return 0;
   774	
   775		order = buddy_order(page);
   776		isolated = __isolate_free_page(page, order);
   777		if (!isolated)
   778			return 0;
   779	
   780		set_page_private(page, order);
   781		list_add(&page->lru, list);
   782	
   783		split_map_pages(list);
   784	
   785		return isolated;
   786	}
   787	EXPORT_SYMBOL_GPL(isolate_and_split_free_page);
   788	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
