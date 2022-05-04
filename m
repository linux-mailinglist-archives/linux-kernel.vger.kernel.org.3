Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F751A290
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351618AbiEDOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351497AbiEDOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:54:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1813120A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651675868; x=1683211868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4PNYnoDcRNW0W0S3itkdcE27uH1+HMSjcwyYOAIa93M=;
  b=RcyxcWcdJJHDw5R948YWGfKMakFR28n4tBdJKwlb0PAWShHnsjqR3xkb
   82Zd/gioyibQBc935Dlu/G5rV9ez6pU14dJgOac7tgf0wCZT1UHl6iy9f
   vwSxA6yWzmRkbKiiwzijgupECkfMpNvaq37OYP99Qd5riGoO6E1Qp3th/
   9iuQlM3ESOSfxPzzwcbobcU27/Ubm4/KM8pE8ffN2Fz7Y1qwu34NssTuf
   +jqYIO5thAdjXEA06Ho7PZ1joch5rbFjiwJNDtyaSaKgkkA385mfSltDl
   GBtEe854aSMb63qGjAEw6K9S57Tj+5AQ3bpGhABs9VoDpy7+gAxw17Z9T
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248327059"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="248327059"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 07:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="694119470"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 07:51:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmGLJ-000BSN-AK;
        Wed, 04 May 2022 14:51:05 +0000
Date:   Wed, 4 May 2022 22:51:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 57/73] include/linux/consolemap.h:50:16: error: 'c'
 undeclared; did you mean 'vc'?
Message-ID: <202205042242.hQmWKqlu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   fab642eca5e0ca41e656c8a0685cadf975b7ff88
commit: b2c621c008e401176daf2b3a1ca78fa8d6ff01af [57/73] consolemap.h: convert macros to static inlines
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220504/202205042242.hQmWKqlu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=b2c621c008e401176daf2b3a1ca78fa8d6ff01af
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout b2c621c008e401176daf2b3a1ca78fa8d6ff01af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/vt_kern.h:16,
                    from kernel/panic.c:19:
   include/linux/consolemap.h: In function 'conv_uni_to_8bit':
>> include/linux/consolemap.h:50:16: error: 'c' undeclared (first use in this function); did you mean 'vc'?
      50 |         return c & 0xff;
         |                ^
         |                vc
   include/linux/consolemap.h:50:16: note: each undeclared identifier is reported only once for each function it appears in
   kernel/panic.c: In function '__warn':
   kernel/panic.c:617:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     617 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:662:6: warning: no previous prototype for '__warn_printk' [-Wmissing-prototypes]
     662 | void __warn_printk(const char *fmt, ...)
         |      ^~~~~~~~~~~~~
   kernel/panic.c: In function '__warn_printk':
   kernel/panic.c:669:9: warning: function '__warn_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     669 |         vprintk(fmt, args);
         |         ^~~~~~~
--
   In file included from include/linux/vt_kern.h:16,
                    from lib/bust_spinlocks.c:17:
   include/linux/consolemap.h: In function 'conv_uni_to_8bit':
>> include/linux/consolemap.h:50:16: error: 'c' undeclared (first use in this function); did you mean 'vc'?
      50 |         return c & 0xff;
         |                ^
         |                vc
   include/linux/consolemap.h:50:16: note: each undeclared identifier is reported only once for each function it appears in


vim +50 include/linux/consolemap.h

    47	
    48	static inline int conv_uni_to_8bit(u32 uni)
    49	{
  > 50		return c & 0xff;
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
