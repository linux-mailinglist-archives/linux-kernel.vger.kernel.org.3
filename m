Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679CC4F6344
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiDFPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiDFPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:30:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00764C7F2B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649249258; x=1680785258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LBiWos/7vIQfxzMwmc/gkSDmEHJmLEltysz/kK1siK4=;
  b=DUKlcm0NjfsHjvKqitUX3gOf105L64yCsgzvr/4/BhZe2Huux5AVTtBx
   ySaZ4+fV65cli4nAdUlgllCQn8wXTYWWSx36kOmjrYQpzCaOE9WX77Qt/
   A/W/T8F18ml1kqZDp6eSLY859jQUJhKqly7sddkiLgeQKBBDhr5vQ70+L
   LFoMaY0NmA8UXb4YO9c7epD2hK+hdXmiqtP02aP9KWDyynqNk2NQNVzy9
   ZU8yR8SKrPkFlx9O/kZrPswixd3PwOuNarjTa8sSBwcTy38aUW1VmvSmK
   ejkoVu8BcNlHC2eApqeQTpKXK3IqWoqa6L/QauALZMOn+q0su0Aq9ieK0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324203775"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="324203775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="658511189"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Apr 2022 05:45:02 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc51x-0004Ph-9b;
        Wed, 06 Apr 2022 12:45:01 +0000
Date:   Wed, 6 Apr 2022 20:44:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/macintosh/via-pmu.c:1758: undefined reference to
 `rtc_tm_to_time64'
Message-ID: <202204062028.JBkAuoVN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e732ebf7316ac83e8562db7e64cc68aec390a18
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   13 days ago
config: m68k-randconfig-p001-20220406 (https://download.01.org/0day-ci/archive/20220406/202204062028.JBkAuoVN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9b3cd24578401e7a392974b3353277286e49cee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/macintosh/via-pmu.o: in function `pmu_set_rtc_time':
>> drivers/macintosh/via-pmu.c:1758: undefined reference to `rtc_tm_to_time64'
   m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `input_report_key':
>> include/linux/input.h:425: undefined reference to `input_event'
   m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `input_report_switch':
   include/linux/input.h:445: undefined reference to `input_event'
   m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event_init':
>> drivers/macintosh/via-pmu-event.c:38: undefined reference to `input_allocate_device'
>> m68k-linux-ld: drivers/macintosh/via-pmu-event.c:53: undefined reference to `input_register_device'
>> m68k-linux-ld: drivers/macintosh/via-pmu-event.c:55: undefined reference to `input_free_device'
   m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
   drivers/macintosh/via-cuda.c:796: undefined reference to `rtc_tm_to_time64'


vim +1758 drivers/macintosh/via-pmu.c

0792a2c8e0bbda Finn Thain 2018-09-11  1752  
0792a2c8e0bbda Finn Thain 2018-09-11  1753  int pmu_set_rtc_time(struct rtc_time *tm)
0792a2c8e0bbda Finn Thain 2018-09-11  1754  {
0792a2c8e0bbda Finn Thain 2018-09-11  1755  	u32 now;
0792a2c8e0bbda Finn Thain 2018-09-11  1756  	struct adb_request req;
0792a2c8e0bbda Finn Thain 2018-09-11  1757  
0792a2c8e0bbda Finn Thain 2018-09-11 @1758  	now = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
0792a2c8e0bbda Finn Thain 2018-09-11  1759  	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
0792a2c8e0bbda Finn Thain 2018-09-11  1760  	                now >> 24, now >> 16, now >> 8, now) < 0)
0792a2c8e0bbda Finn Thain 2018-09-11  1761  		return -ENXIO;
0792a2c8e0bbda Finn Thain 2018-09-11  1762  	pmu_wait_complete(&req);
0792a2c8e0bbda Finn Thain 2018-09-11  1763  	if (req.reply_len != 0)
0792a2c8e0bbda Finn Thain 2018-09-11  1764  		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
0792a2c8e0bbda Finn Thain 2018-09-11  1765  	return 0;
0792a2c8e0bbda Finn Thain 2018-09-11  1766  }
0792a2c8e0bbda Finn Thain 2018-09-11  1767  

:::::: The code at line 1758 was first introduced by commit
:::::: 0792a2c8e0bbda3605b8d42c6b9635be7b19982a macintosh: Use common code to access RTC

:::::: TO: Finn Thain <fthain@telegraphics.com.au>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
