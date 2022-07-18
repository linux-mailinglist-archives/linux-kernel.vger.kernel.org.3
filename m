Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA1577928
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiGRBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:14:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D81147C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106866; x=1689642866;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LIxgYK4hpIPP4H96x0zldktrRVfeG45n3WLLDlupRTI=;
  b=kPoeicUH7w2jLWc6h+HkSran0FgxKBxw120bQKGCUSNL4plQFw/BKvLb
   5rEnhqsXpsISkVPeIjGfoDztzBHN5yKvB2PFzwQS2FreAzxIUUJlzGHip
   ZQyye8a6OXryBM3B2HinrXwsFFkdOKPpaJkzB5tf4bhsiyN7urC+DtY+Y
   IXCWWyblx4+wGH+U4jX4AUQ1Gmozx40tkSKaLMsrXnJk16K34dCLZzTC0
   zcYwI/zmDoZPUSBIp2b9HFFND6UPgY9OWXQ2tVoHEXGr+D/ltOT0u/rzS
   xwB/zCVaq7NncP/cMTcS72CVoSikm+AMJMI9FMcVzzDM31sgOyZc3PyPQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347794780"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="347794780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="686562484"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2022 18:14:23 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDFL5-0003r0-A9;
        Mon, 18 Jul 2022 01:14:23 +0000
Date:   Mon, 18 Jul 2022 09:13:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     kbuild-all@lists.01.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: [rw-uml:linux-next 11/16] arch/um/os-Linux/mem.c:28:6: warning: no
 previous prototype for 'kasan_map_memory'
Message-ID: <202207180935.daaJausv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
head:   af3e16101cee95efaa72095fe06c15ec0b8eb195
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 [11/16] UML: add support for KASAN under x86_64
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220718/202207180935.daaJausv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git/commit/?id=5b301409e8bc5d7fad2ee138be44c5c529dd0874
        git remote add rw-uml https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
        git fetch --no-tags rw-uml linux-next
        git checkout 5b301409e8bc5d7fad2ee138be44c5c529dd0874
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for 'kasan_map_memory' [-Wmissing-prototypes]
      28 | void kasan_map_memory(void *start, size_t len)
         |      ^~~~~~~~~~~~~~~~
   arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for 'check_tmpexec' [-Wmissing-prototypes]
     212 | void __init check_tmpexec(void)
         |             ^~~~~~~~~~~~~


vim +/kasan_map_memory +28 arch/um/os-Linux/mem.c

    19	
    20	/*
    21	 * kasan_map_memory - maps memory from @start with a size of @len.
    22	 * The allocated memory is filled with zeroes upon success.
    23	 * @start: the start address of the memory to be mapped
    24	 * @len: the length of the memory to be mapped
    25	 *
    26	 * This function is used to map shadow memory for KASAN in uml
    27	 */
  > 28	void kasan_map_memory(void *start, size_t len)
    29	{
    30		if (mmap(start,
    31			 len,
    32			 PROT_READ|PROT_WRITE,
    33			 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
    34			 -1,
    35			 0) == MAP_FAILED) {
    36			os_info("Couldn't allocate shadow memory: %s\n.",
    37				strerror(errno));
    38			exit(1);
    39		}
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
