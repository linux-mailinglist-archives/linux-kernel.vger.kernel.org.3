Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9290528D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiEPSkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiEPSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:40:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B703DED2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652726448; x=1684262448;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q0YlLGz6Lc6XFeos3tLUyC3v/jJ8CqKxGoAb/fzI9f8=;
  b=hoUDO+TKVNEg02YU0vpHZy3L6een98Q41Zp8bLPuY4PckNxPoobn18og
   hHJqul66QQyYiBQcGpNH5TxQbNkkwGTFm/M5CUUsDsYZ6VXWEZEFMX1dN
   mkf20tOcma/S5ljQu8aQ/FrFDRMe5P8OEEcpJop3Aagpx2EbZxMjWTw0c
   v6IKlJpt5frpQD1UCS9bkjDJ0tdOAMGhfyoo4AXFk0UTSQXgXaDzBs5Qp
   yenLaWvj8NH9pFQOysvODfzgQu/K6dSH+8RZPV5lW85ZQNLnRefkzUWBO
   OuGa6f6Ux4iI5oxlg14fydR36J2LFCg6FAjbw5mA4U73QJwKu7JtB1ApM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="333974734"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="333974734"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="555387914"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2022 11:40:44 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqfe7-0000GT-Q3;
        Mon, 16 May 2022 18:40:43 +0000
Date:   Tue, 17 May 2022 02:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Meena Shanmugam <meenashanmugam@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.10 60/64]
 arch/arm/include/asm/bitops.h:183:41: warning: this statement may fall
 through
Message-ID: <202205170208.3xcnwB0O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   678760868882a1b8dd7f45e9b6058f2c0ce109a3
commit: 419aeb75528619e8bfedecb70c70abcc72464e71 [60/64] SUNRPC: Don't call connect() more than once on a TCP socket
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220517/202205170208.3xcnwB0O-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=419aeb75528619e8bfedecb70c70abcc72464e71
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout 419aeb75528619e8bfedecb70c70abcc72464e71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:29,
                    from include/linux/kernel.h:12,
                    from include/asm-generic/bug.h:20,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from net/sunrpc/xprtsock.c:24:
   net/sunrpc/xprtsock.c: In function 'xs_tcp_setup_socket':
>> arch/arm/include/asm/bitops.h:183:41: warning: this statement may fall through [-Wimplicit-fallthrough=]
     183 | #define ATOMIC_BITOP(name,nr,p)         _##name(nr,p)
         |                                         ^~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:189:41: note: in expansion of macro 'ATOMIC_BITOP'
     189 | #define set_bit(nr,p)                   ATOMIC_BITOP(set_bit,nr,p)
         |                                         ^~~~~~~~~~~~
   net/sunrpc/xprtsock.c:2301:17: note: in expansion of macro 'set_bit'
    2301 |                 set_bit(XPRT_SOCK_CONNECT_SENT, &transport->sock_state);
         |                 ^~~~~~~
   net/sunrpc/xprtsock.c:2302:9: note: here
    2302 |         case -EALREADY:
         |         ^~~~


vim +183 arch/arm/include/asm/bitops.h

^1da177e4c3f415 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  175  
e7ec02938dbe8ca include/asm-arm/bitops.h      Russell King   2005-07-28  176  #ifndef CONFIG_SMP
^1da177e4c3f415 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  177  /*
^1da177e4c3f415 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  178   * The __* form of bitops are non-atomic and may be reordered.
^1da177e4c3f415 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  179   */
6323f0ccedf756d arch/arm/include/asm/bitops.h Russell King   2011-01-16  180  #define ATOMIC_BITOP(name,nr,p)			\
6323f0ccedf756d arch/arm/include/asm/bitops.h Russell King   2011-01-16  181  	(__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
e7ec02938dbe8ca include/asm-arm/bitops.h      Russell King   2005-07-28  182  #else
6323f0ccedf756d arch/arm/include/asm/bitops.h Russell King   2011-01-16 @183  #define ATOMIC_BITOP(name,nr,p)		_##name(nr,p)
e7ec02938dbe8ca include/asm-arm/bitops.h      Russell King   2005-07-28  184  #endif
^1da177e4c3f415 include/asm-arm/bitops.h      Linus Torvalds 2005-04-16  185  

:::::: The code at line 183 was first introduced by commit
:::::: 6323f0ccedf756dfe5f46549cec69a2d6d97937b ARM: bitops: switch set/clear/change bitops to use ldrex/strex

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
