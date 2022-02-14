Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAC4B5E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiBNX7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:59:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiBNX7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:59:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418B3E5DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644883165; x=1676419165;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hXIeqUPMnAbRI0lDJsfcrAloUYkm5YLSaI9flvJx2Dk=;
  b=aMmH/kZ2cTgWEdc3HhSzEOElxPeaPeFK5iSJy258DCttYXLbFOjLWNyN
   NxlvKiVpSvIRtvDG3u+TtShnu2Okkv5+m20upTWC6qaN8y+TyMOYyASkE
   mo5FgeEuJ3nfLIJnLOg+c+q4KiRVtsqj6ZqBXG37iaJEu3HYvjW6RjK1Y
   LeGW0nfFR/KqEmwkDwZztkkmM93TinN4csHeeRkK8JjSHEnHzKitd78rV
   ILvEsL9VN01tGWVMk1jNif0ScglT9Q77aJPXDzCfyzk0K8GOOn2/1LqmY
   kpxPKpWmvxM5DFeGkbIX+BBpZ+oNhU4U7QN/9EbOGo/Tmw/RQ8rE3duVj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249043895"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249043895"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="570539661"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2022 15:59:23 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJlFa-00093U-GB; Mon, 14 Feb 2022 23:59:22 +0000
Date:   Tue, 15 Feb 2022 07:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:fs-folio 44/58] fs/hostfs/hostfs_kern.c:507:17:
 error: 'filemap_dirty_folio' undeclared here (not in a function); did you
 mean 'filemap_get_folio'?
Message-ID: <202202150745.y8wccCv3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache fs-folio
head:   2a1113b30dfe1f84d065830fc837dfa8737ba380
commit: 117ba9cd89727cdc7262cb6088ea070ae1ef2a98 [44/58] fs: Convert trivial uses of __set_page_dirty_nobuffers to filemap_dirty_folio
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220215/202202150745.y8wccCv3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache fs-folio
        git checkout 117ba9cd89727cdc7262cb6088ea070ae1ef2a98
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/hostfs/hostfs_kern.c:507:17: error: 'filemap_dirty_folio' undeclared here (not in a function); did you mean 'filemap_get_folio'?
     507 |  .dirty_folio = filemap_dirty_folio,
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 filemap_get_folio


vim +507 fs/hostfs/hostfs_kern.c

   503	
   504	static const struct address_space_operations hostfs_aops = {
   505		.writepage 	= hostfs_writepage,
   506		.readpage	= hostfs_readpage,
 > 507		.dirty_folio	= filemap_dirty_folio,
   508		.write_begin	= hostfs_write_begin,
   509		.write_end	= hostfs_write_end,
   510	};
   511	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
