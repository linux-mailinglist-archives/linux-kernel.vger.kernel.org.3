Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E354790E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 07:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiFLF7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 01:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiFLF7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 01:59:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C269483
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655013539; x=1686549539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r7/0lsTnpQOb688epw5xyluPD/RdlD9/+iiRYQXpl0I=;
  b=fjicdIYNNBs9dG7c4XEL88F3i6VQq6Uh65sU7xrr/AOUGmU5TX7q/+jC
   +4/d67v2RpklWhCazrM0UdFAFEx0gn2/9kEQvuAQkE/QTP7H2kBseZfAA
   fYa8ObAfzMffw7/j0tfptdRll6aiHJPrJa2+A7Y7D434VD0tqhas2VTqb
   u/Eqsi5f/by1bVBdDCdlBBQqkT3g+26Uw8XmQeoMl4t0BVPjlGnn2MCEg
   pu0h6GZ0SSxtXo3fMPD+1tXiIW2MFWKpptmr33+IrVlcZm8QEV9ZKhIq4
   TYsH9w40sBSgEap12U8EobUfd/blJnUOpfQZoxUAfP4iLiwZ0ime/RVHc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="342002852"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="342002852"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 22:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="587113275"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2022 22:58:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0Gci-000JeH-Hu;
        Sun, 12 Jun 2022 05:58:56 +0000
Date:   Sun, 12 Jun 2022 13:58:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 36/52]
 include/linux/fortify-string.h:374:63: error: expected identifier or '('
 before '{' token
Message-ID: <202206121354.mdOkwo61-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: 312a993799c081eda5135198ad59b691211d14fe [36/52] riscv: optimized memcpy
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220612/202206121354.mdOkwo61-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/312a993799c081eda5135198ad59b691211d14fe
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout 312a993799c081eda5135198ad59b691211d14fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/riscv/lib/string.c:10:
>> include/linux/fortify-string.h:374:63: error: expected identifier or '(' before '{' token
     374 |                              p_size_field, q_size_field, op) ({         \
         |                                                               ^
   include/linux/fortify-string.h:385:26: note: in expansion of macro '__fortify_memcpy_chk'
     385 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   arch/riscv/lib/string.c:89:7: note: in expansion of macro 'memcpy'
      89 | void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
         |       ^~~~~~


vim +374 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  372  
f68f2ff91512c1 Kees Cook      2021-04-20  373  #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
f68f2ff91512c1 Kees Cook      2021-04-20 @374  			     p_size_field, q_size_field, op) ({		\
f68f2ff91512c1 Kees Cook      2021-04-20  375  	size_t __fortify_size = (size_t)(size);				\
f68f2ff91512c1 Kees Cook      2021-04-20  376  	fortify_memcpy_chk(__fortify_size, p_size, q_size,		\
f68f2ff91512c1 Kees Cook      2021-04-20  377  			   p_size_field, q_size_field, #op);		\
f68f2ff91512c1 Kees Cook      2021-04-20  378  	__underlying_##op(p, q, __fortify_size);			\
f68f2ff91512c1 Kees Cook      2021-04-20  379  })
f68f2ff91512c1 Kees Cook      2021-04-20  380  

:::::: The code at line 374 was first introduced by commit
:::::: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
