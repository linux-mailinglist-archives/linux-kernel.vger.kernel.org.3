Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7D563F1D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGBIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:33:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54E1581A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656750826; x=1688286826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0uRRLXk3JqPCpwhDZFjbqtoL83P8kHLZiPu1OJ3Vu6Y=;
  b=BhZvSPqQAF12/te2a11g0JwaPxG5uDHRBYUYnVR6hgXWqLr6a7nJae4D
   Sw/4LVZ9465j74SEYfqrxeDCCAXY/l13v5p1rpsbvGGioNFw6KUqncwTF
   Ixwz0QpokyPRrSRjPgbCWFPmhkSI/t/iXCOD5Ld4hXIbYWiUM45B04QnX
   IH+hfuKEDDtzhfkxDllGdKWV41Aoi+UyYx0DBoY/l+k3oSp/+ERQCYbsZ
   1my3A9iAvCHcsOWEsT9tqEbxSiPqcCC24o3AJbXFXT3QqeHTX7iiHlSEX
   tyKZs1WoCpiShEVlzlMJASFmrksFi0G58kK1GU2HN1mjXsccCWW2L4Odp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281567033"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="281567033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 01:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="566596676"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2022 01:33:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7YZT-000F2p-PG;
        Sat, 02 Jul 2022 08:33:43 +0000
Date:   Sat, 2 Jul 2022 16:32:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [akpm-mm:mm-unstable 302/323] arch/x86/mm/pgprot.c:26:6: warning: no
 previous prototype for 'add_encrypt_protection_map'
Message-ID: <202207021647.Jb0wNWF5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   706370e5c2ea7bb4544eee6e1172c4d68117a526
commit: d845587c05fd4ae52aaa0cd5c8939e8f4793301f [302/323] x86/mm: move protection_map[] inside the platform
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220702/202207021647.Jb0wNWF5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d845587c05fd4ae52aaa0cd5c8939e8f4793301f
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout d845587c05fd4ae52aaa0cd5c8939e8f4793301f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/pgprot.c:26:6: warning: no previous prototype for 'add_encrypt_protection_map' [-Wmissing-prototypes]
      26 | void add_encrypt_protection_map(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/add_encrypt_protection_map +26 arch/x86/mm/pgprot.c

    25	
  > 26	void add_encrypt_protection_map(void)
    27	{
    28		unsigned int i;
    29	
    30		for (i = 0; i < ARRAY_SIZE(protection_map); i++)
    31			protection_map[i] = pgprot_encrypted(protection_map[i]);
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
