Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643DC547267
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiFKGpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFKGpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:45:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8B11A2C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654929906; x=1686465906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gyhR+XQc4oYQwpd8NWOJe4EvQUSd9I4pxPmy27Nk1PA=;
  b=NLI+E1WkkBWllyhAIhyyx7pkXeDwXc3Qm7z9PpNB0LJKPlOzqWQpOXJy
   iWkZ38EWPpxEcWFV4SSrvPAJ2POR6RIwV1G18RUnkKH05v1VzayUiF1T9
   cWYg5938ogMefuNmzPR5Kh3W0HJG2kLTuU4a7GwVNigVFr1BKHxP7sTID
   gGyFk+//6dUCWySsX0YjvgVArIzCZOJkrSUXfX2JWWZKqXYy8gEkWkf86
   3OJQ13KSU0kuQ+hKiaDbg0KRpBTXsHzpfJDVcQU3fMOsJvDy1kBbg7P+D
   h8iId3TeY2LUMY3jgUMZKVUirVUY3pMxBv02JEwIc4BXF5mkbRWh3fmle
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="277878582"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="277878582"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 23:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="684986935"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2022 23:45:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzuro-000Ich-DT;
        Sat, 11 Jun 2022 06:45:04 +0000
Date:   Sat, 11 Jun 2022 14:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 29/57]
 include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument
 1 (different modifiers)
Message-ID: <202206111452.dJUSUYyl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
commit: f951c9604853872cf088bb3dbf7d49e3f96b090d [29/57] mm: Make some folio function arguments const
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220611/202206111452.dJUSUYyl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/f951c9604853872cf088bb3dbf7d49e3f96b090d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout f951c9604853872cf088bb3dbf7d49e3f96b090d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/netfs/direct_read.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/netfs/misc.c: note: in included file (through include/linux/mmzone.h, include/linux/swap.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/netfs/buffered_read.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/netfs/io.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page

vim +788 include/linux/page-flags.h

e7d324850bfcb3 Muchun Song   2022-03-22  785  
f951c960485387 David Howells 2022-06-08  786  static __always_inline int PageHead(const struct page *page)
e7d324850bfcb3 Muchun Song   2022-03-22  787  {
e7d324850bfcb3 Muchun Song   2022-03-22 @788  	PF_POISONED_CHECK(page);
e7d324850bfcb3 Muchun Song   2022-03-22  789  	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
e7d324850bfcb3 Muchun Song   2022-03-22  790  }
e7d324850bfcb3 Muchun Song   2022-03-22  791  

:::::: The code at line 788 was first introduced by commit
:::::: e7d324850bfcb30df563d144c0363cc44595277d mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page

:::::: TO: Muchun Song <songmuchun@bytedance.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
