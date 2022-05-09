Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB0520437
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiEISMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiEISMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:12:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8262AC6ED
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652119732; x=1683655732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8TSlMiX/FE6UJmGXIWDEnhucIoFp0cHoRqbTJX0Gy8Y=;
  b=AKC2kPmEC1sH8EuUVjp37gbjDCr9y8qPu3xYYXcgig4c0ArqPiEbgp2p
   7VVevQe8+xTWDgW4nrcQg8h+OvHwvNBs+UO/3hlt+jkSzLqdYFH2tWJLw
   0GiBIJndU88XdCE1YL5lS4WXpmr00jzTeaDhwFv1mCy8b9iKTLzv7NLq8
   45O7nFL1I5SL4/8mX2ayQr59Y/H57Mz3sWnyJYXRNS69szYnm84L9NFah
   Zb91yFtU9mGcuhG/gRlKyEx+iXDq/D7zDV8Yw+I6LOFNfiCBJogh1WJJx
   tJADYG7YiTPh7hldj2rwPXyWLMm4PC17RhC2xaYs5WGZHoVhJtu6HiDa3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355556316"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="355556316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 11:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="710636651"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2022 11:08:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no7oQ-000Gkq-JN;
        Mon, 09 May 2022 18:08:50 +0000
Date:   Tue, 10 May 2022 02:08:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/trace/stages/init.h:2:23: warning:
 'str__irq_vectors__trace_system_name' defined but not used
Message-ID: <202205100202.Ag0S76wP-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: af6b9668e85ffd1502aada8036ccbf4dbd481708 tracing: Move the defines to create TRACE_EVENTS into their own files
date:   8 weeks ago
config: i386-randconfig-s002-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100202.Ag0S76wP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af6b9668e85ffd1502aada8036ccbf4dbd481708
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout af6b9668e85ffd1502aada8036ccbf4dbd481708
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:27,
                    from include/trace/define_trace.h:102,
                    from arch/x86/include/asm/trace/irq_vectors.h:383,
                    from arch/x86/kernel/irq.c:27:
>> include/trace/stages/init.h:2:23: warning: 'str__irq_vectors__trace_system_name' defined but not used [-Wunused-const-variable=]
       2 | #define __app__(x, y) str__##x##y
         |                       ^~~~~
   include/trace/stages/init.h:3:21: note: in expansion of macro '__app__'
       3 | #define __app(x, y) __app__(x, y)
         |                     ^~~~~~~
   include/trace/stages/init.h:5:29: note: in expansion of macro '__app'
       5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
         |                             ^~~~~
   include/trace/stages/init.h:8:27: note: in expansion of macro 'TRACE_SYSTEM_STRING'
       8 |         static const char TRACE_SYSTEM_STRING[] =       \
         |                           ^~~~~~~~~~~~~~~~~~~
   include/trace/stages/init.h:11:1: note: in expansion of macro 'TRACE_MAKE_SYSTEM_STR'
      11 | TRACE_MAKE_SYSTEM_STR();
         | ^~~~~~~~~~~~~~~~~~~~~


vim +/str__irq_vectors__trace_system_name +2 include/trace/stages/init.h

   > 2	#define __app__(x, y) str__##x##y
     3	#define __app(x, y) __app__(x, y)
     4	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
