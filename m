Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3872589267
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiHCSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiHCSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:50:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AD12ADB;
        Wed,  3 Aug 2022 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659552621; x=1691088621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PZoNbmA1Fb2MlNefOhZyRwr/P3R3JKvVcAAgZO6IGco=;
  b=eRsHUnH4oCPlrRS4ZgRVjUkoSzVTW7O3D+T5a/Z0MD5FnBK8YoAs63sl
   rAlNhKlx1kTcgj1Js56FUZDKqz5lysA+ovZvheU8y4t2U3kTo8sz1yXiB
   i1uugQg7K/suOmRbruSyWGHFZyICcKPUEK6pmEyH+a+jWYZv23L3d1tuq
   P17+VqjGhTKYc+7oM3yyWCXBKrgUrKLGxSNBtLyxcWyqPNBN/zPG6OkfQ
   wBQJx8/1IZ0jjU1WshI7hq3l3yv29T7uUQPPZbXoGd+cwx7WIIeXj6bf3
   Sa/bg0jJlASV5AIiRE02A67MWEXPhrVPpMbMA6mfMD4gYVoA6Nkm38P2G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="269525474"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="269525474"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578764377"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 11:50:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJJRi-000HZT-1k;
        Wed, 03 Aug 2022 18:50:18 +0000
Date:   Thu, 4 Aug 2022 02:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-doc@vger.kernel.org
Subject: fs/btrfs/raid56.c:1000: warning: This comment starts with '/**', but
 isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202208040217.jYokbVy6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2b542100719a93f8cdf6d90185410d38a57a4c1
commit: 3e77605d6a81efd39278a5ca2ee57737eb2659d2 btrfs: raid56: make rbio_add_io_page() subpage compatible
date:   3 months ago
config: hexagon-randconfig-r002-20220803 (https://download.01.org/0day-ci/archive/20220804/202208040217.jYokbVy6-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e77605d6a81efd39278a5ca2ee57737eb2659d2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3e77605d6a81efd39278a5ca2ee57737eb2659d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/raid56.c:1000: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get a sector pointer specified by its @stripe_nr and @sector_nr


vim +1000 fs/btrfs/raid56.c

   998	
   999	/**
> 1000	 * Get a sector pointer specified by its @stripe_nr and @sector_nr
  1001	 *
  1002	 * @rbio:               The raid bio
  1003	 * @stripe_nr:          Stripe number, valid range [0, real_stripe)
  1004	 * @sector_nr:		Sector number inside the stripe,
  1005	 *			valid range [0, stripe_nsectors)
  1006	 * @bio_list_only:      Whether to use sectors inside the bio list only.
  1007	 *
  1008	 * The read/modify/write code wants to reuse the original bio page as much
  1009	 * as possible, and only use stripe_sectors as fallback.
  1010	 */
  1011	static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
  1012						 int stripe_nr, int sector_nr,
  1013						 bool bio_list_only)
  1014	{
  1015		struct sector_ptr *sector;
  1016		int index;
  1017	
  1018		ASSERT(stripe_nr >= 0 && stripe_nr < rbio->real_stripes);
  1019		ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
  1020	
  1021		index = stripe_nr * rbio->stripe_nsectors + sector_nr;
  1022		ASSERT(index >= 0 && index < rbio->nr_sectors);
  1023	
  1024		spin_lock_irq(&rbio->bio_list_lock);
  1025		sector = &rbio->bio_sectors[index];
  1026		if (sector->page || bio_list_only) {
  1027			/* Don't return sector without a valid page pointer */
  1028			if (!sector->page)
  1029				sector = NULL;
  1030			spin_unlock_irq(&rbio->bio_list_lock);
  1031			return sector;
  1032		}
  1033		spin_unlock_irq(&rbio->bio_list_lock);
  1034	
  1035		return &rbio->stripe_sectors[index];
  1036	}
  1037	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
