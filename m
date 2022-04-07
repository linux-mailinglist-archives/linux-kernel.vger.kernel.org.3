Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05D4F896A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiDGVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiDGVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:15:28 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA0185471
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649366007; x=1680902007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tr79FsVhT0SDcd/3/chhFRDQVCbUp+hAXKvJvfS+W4Y=;
  b=gKgyjEmShqlszTb4N2FrJfnPVz8mbBcxuBJB82pGunl6LhX0y8HdNV9c
   +KwpGq6uYOL49WjK/GDijYAheNHvJPwExx7ZT9uT51Kk3HtKO1r7x/ljm
   Kglu6RJ1ncdTdFnoNeAyCuTPQZfGWhcbY0K3rgI/X8CmUpi5XYT+enTiq
   cR8QFbhyUgtmB8ZLp9CBXXUFRJMoqRpyxyO7YDbfUko6ABzzD12Lov7Uo
   MwamddwWN6DqGuQzy9jETGs6y9OdqvQ9+nt+9d59betkNtq9us+BLlE92
   uyla4SG5xB2xeSd5ANEATatTBvjgxV1CrWKpEJ25BKBA/+pZn77ynCBBh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322131786"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="322131786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659222508"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2022 14:13:26 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncZRV-0005mx-Nu;
        Thu, 07 Apr 2022 21:13:25 +0000
Date:   Fri, 8 Apr 2022 05:12:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 2/5] kallsyms.c:undefined reference to
 `kallsyms_on_each_symbol'
Message-ID: <202204080514.PCPEh2hd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   baa78873a24a7e0f21b0a01e82214ce9a096e147
commit: 3f047c53b0e7e747b76f0b3d032e476efbe1222f [2/5] kallsyms: Add kallsyms_lookup_names function
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220408/202204080514.PCPEh2hd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=3f047c53b0e7e747b76f0b3d032e476efbe1222f
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 3f047c53b0e7e747b76f0b3d032e476efbe1222f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: enter_from_user_mode()+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x1d: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   ld: kernel/kallsyms.o: in function `kallsyms_lookup_names':
>> kallsyms.c:(.text+0xb4e): undefined reference to `kallsyms_on_each_symbol'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
