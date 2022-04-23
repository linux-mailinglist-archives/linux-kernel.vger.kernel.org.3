Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3150CA58
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiDWNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiDWNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:08:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB7F1BE83
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650719155; x=1682255155;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+na3yLK7i1dr4u7EY7pE0nZJ2rWx9pUL5s0RqRpdp6c=;
  b=hyqJIzvXB01JSeayiLLs3l2mbbXkreYHUFMGD7waSV2vvV9OkDy8XS1c
   ak3UFthSAHIhLg5SVsNgdOMX9hJnS3X4ByWunufgY+Zi+sjTYWl/itxwu
   Y9/VsbuDZcslzES/eQ+XgZLw2vOvatQATRwnMUDbQEUGqxqH08Q5XTyA1
   O+9A0RsdfO04pUFQq0zSXOyyk/Ryop+M9fB54ffbbywyv53pUvg3AvTcF
   vBQfsZTv8q3LVW4zSj47olS1O2fFhrDAW4Q8rhWsuuxp4FYxav9f8CiJf
   5cY/7HyfMJYmKq/Pa9SBawqdd8JvVbh/5xwguGh+0p5aDuiy3cDzSehLd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244820511"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="244820511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 06:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="556861846"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2022 06:05:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niFSS-00002i-St;
        Sat, 23 Apr 2022 13:05:52 +0000
Date:   Sat, 23 Apr 2022 21:05:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [kdave-btrfs-devel:misc-next 67/136] fs/btrfs/extent_io.c:5952:7:
 warning: Local variable 'ret' shadows outer variable [shadowVariable]
Message-ID: <202204232126.HLpn2Rg5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   446e59dd6c55d120dc09444a1f086e5a81898665
commit: 55093e751296ec57c65374e1e0378f6d32946389 [67/136] btrfs: factor out allocating an array of pages
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 55093e751296ec57c65374e1e0378f6d32946389
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
        ^
>> fs/btrfs/extent_io.c:5952:7: warning: Local variable 'ret' shadows outer variable [shadowVariable]
     int ret;
         ^
   fs/btrfs/extent_io.c:5931:6: note: Shadowed declaration
    int ret;
        ^
   fs/btrfs/extent_io.c:5952:7: note: Shadow variable
     int ret;
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

        ^
   fs/btrfs/extent_io.c:369:26: warning: Parameter 'p_in' can be declared with const [constParameter]
          struct rb_node ***p_in,
                            ^
   fs/btrfs/extent_io.c:370:25: warning: Parameter 'parent_in' can be declared with const [constParameter]
          struct rb_node **parent_in)
                           ^
   fs/btrfs/extent_io.c:1823:30: warning: Parameter 'mapping' can be declared with const [constParameter]
          struct address_space *mapping,
                                ^
   fs/btrfs/extent_io.c:1824:40: warning: Parameter 'locked_page' can be declared with const [constParameter]
          struct page *page, struct page *locked_page,
                                          ^
   fs/btrfs/extent_io.c:6052:16: warning: Parameter 'accessed' can be declared with const [constParameter]
     struct page *accessed)
                  ^

vim +/ret +5952 fs/btrfs/extent_io.c

  5925	
  5926	struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
  5927	{
  5928		int i;
  5929		struct extent_buffer *new;
  5930		int num_pages = num_extent_pages(src);
  5931		int ret;
  5932	
  5933		new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
  5934		if (new == NULL)
  5935			return NULL;
  5936	
  5937		/*
  5938		 * Set UNMAPPED before calling btrfs_release_extent_buffer(), as
  5939		 * btrfs_release_extent_buffer() have different behavior for
  5940		 * UNMAPPED subpage extent buffer.
  5941		 */
  5942		set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
  5943	
  5944		memset(new->pages, 0, sizeof(*new->pages) * num_pages);
  5945		ret = btrfs_alloc_page_array(num_pages, new->pages);
  5946		if (ret) {
  5947			btrfs_release_extent_buffer(new);
  5948			return NULL;
  5949		}
  5950	
  5951		for (i = 0; i < num_pages; i++) {
> 5952			int ret;
  5953			struct page *p = new->pages[i];
  5954	
  5955			ret = attach_extent_buffer_page(new, p, NULL);
  5956			if (ret < 0) {
  5957				btrfs_release_extent_buffer(new);
  5958				return NULL;
  5959			}
  5960			WARN_ON(PageDirty(p));
  5961			copy_page(page_address(p), page_address(src->pages[i]));
  5962		}
  5963		set_extent_buffer_uptodate(new);
  5964	
  5965		return new;
  5966	}
  5967	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
