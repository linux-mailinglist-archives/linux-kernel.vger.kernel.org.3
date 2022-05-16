Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E92527C59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiEPDbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiEPDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:31:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD41FCC0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652671900; x=1684207900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Taqd55ooU/2zV6t5eoODzwFpzeEkfUWWOlKx4an6yT8=;
  b=WrkxoqEzB8AL/dEqjt5qoCpsl4tWnbcmcQmZjl19Zw11xZ6xN05wOht/
   MvLPOkJ0uoEYHZsgIdUUCJvAEzMZGYhc/qNIClJN0Bu2L3Q5U5GF3cSnC
   L6RSt3NH3Scl6buZ+AI7JLRhkSyaRYukLgS05gX8gTbWnuCWy5Pk3wi1d
   smlHuxRWPJHCCBRhvQJ7be7d5zV/c5aQcwIiPDr3ef1Yzoe3qybM7Uhwz
   WpPmvQuwKiFwBj/QOS0EYFbE7Bed0ngZNpg+Zzr+cIvKI9Ap61xaxHHuY
   yxQFjLsjmRgLcjbAS4mHL+zsadNmxLdstDoP0sTwMHLh4M3Lj8oLcpG+1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270841201"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270841201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 20:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="672166445"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2022 20:31:38 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqRSL-00028g-W1;
        Mon, 16 May 2022 03:31:37 +0000
Date:   Mon, 16 May 2022 11:31:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Steven Price <steven.price@arm.com>
Subject: fs/proc/task_mmu.c:743:33: warning: 'smaps_shmem_walk_ops' defined
 but not used
Message-ID: <202205161152.pu8S9frR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42226c989789d8da4af1de0c31070c96726d990c
commit: 7b86ac3371b70c3fd8fd95501719beb1faab719f pagewalk: separate function pointers from iterator data
date:   2 years, 8 months ago
config: i386-buildonly-randconfig-r001-20220516 (https://download.01.org/0day-ci/archive/20220516/202205161152.pu8S9frR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b86ac3371b70c3fd8fd95501719beb1faab719f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7b86ac3371b70c3fd8fd95501719beb1faab719f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/task_mmu.c:743:33: warning: 'smaps_shmem_walk_ops' defined but not used [-Wunused-const-variable=]
     743 | static const struct mm_walk_ops smaps_shmem_walk_ops = {
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +/smaps_shmem_walk_ops +743 fs/proc/task_mmu.c

   742	
 > 743	static const struct mm_walk_ops smaps_shmem_walk_ops = {
   744		.pmd_entry		= smaps_pte_range,
   745		.hugetlb_entry		= smaps_hugetlb_range,
   746		.pte_hole		= smaps_pte_hole,
   747	};
   748	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
