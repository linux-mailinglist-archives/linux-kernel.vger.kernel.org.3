Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E154FA1F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiDIDcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiDIDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:32:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F02AE9DE;
        Fri,  8 Apr 2022 20:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649474997; x=1681010997;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IOogZbtQVdUydOALD2TY2ZdOngstt4IqBJqKyDVb1ZY=;
  b=mFIpbo4c/WFxL4LJ498HGEusi08usOVTa3TDq4tGSvfzk9Jl5IrLHGBC
   wSD73bX7TL1oaKvSI2QaEB0+GzPDsu1iKHd/UsXJSfsvcFV6xBJvO/oQF
   CkN6gFS26bPY9pcMWkB/+6Ey8ujyPbcWFlwuQRNfGXw6O/oRbe7pQ6SDB
   JHNroj/ldcrpqq27385FmryQUPGQ/rys31TEDJpHx4oR9UuBSoExyBrKB
   gsOCUOu7/BeRKJre4bDtGTfC1idZ1CiXWsGMtShxt/JX2NqeahYPu9R9O
   N4pmxwoXSeec+WIZ32Uu+BWY/kEH/ZHzthLT//+HjaR55Vx5XamSejJyr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="286749461"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="286749461"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 20:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="643185585"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2022 20:29:54 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd1nO-0000qL-6J;
        Sat, 09 Apr 2022 03:29:54 +0000
Date:   Sat, 9 Apr 2022 11:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org
Subject: [kdave:for-next 112/127] fs/btrfs/raid56.c:1000: warning: This
 comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202204091154.PHMWy5ha-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
head:   cc4b66eaf7fbeab15e9c3dd2f2c12e41a1d741eb
commit: a32642fa6cda14b43626226169dc248ccdbdd63d [112/127] btrfs: raid56: make rbio_add_io_page() subpage compatible
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220409/202204091154.PHMWy5ha-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?id=a32642fa6cda14b43626226169dc248ccdbdd63d
        git remote add kdave https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
        git fetch --no-tags kdave for-next
        git checkout a32642fa6cda14b43626226169dc248ccdbdd63d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/ fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
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
