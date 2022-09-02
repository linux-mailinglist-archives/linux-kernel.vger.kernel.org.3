Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686F25AA9F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiIBI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiIBI1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:27:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0906F246
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662107271; x=1693643271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=izvktL+HglejP8i3isJHx/CppaZRjOeDF9AtXPCTuzU=;
  b=GYv7EeN0dfdm4nobhAbWSslVi9IPj0m3TObNTfB1J5u+wxzCWiA7RS+D
   Wby+sqccxo7FcDX/wjwg7uZlBFEvHitufJ99lS2Mp1yPSVFsWPW81hJ6R
   uLvwl6zIppQCBcx/YArO9+FMB8Wxb30T2itfJaolxLeiSkUr+qniRx2aV
   eMtPKkTWFtgYtu/dH4h0BOixMDjMi60qpj8MjRhWp66iDQlNi7x3abM09
   gSzEaOXlyasmJiyJpHWwJmtrkFWG7dqOHJa7El/OHshbEowLNTAHGDAJN
   UDp2jWpLXWTUX51Mw2cn8zABCw/V0z25i4xCNp0zhSk0IVEhLLyzariIi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293510564"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="293510564"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="702066971"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2022 01:27:24 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oU21L-0000OF-1K;
        Fri, 02 Sep 2022 08:27:23 +0000
Date:   Fri, 2 Sep 2022 16:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:viro/vfs/next.tty 8/8]
 arch/powerpc/include/asm/uaccess.h:261:13: warning: assignment to 'void *'
 from 'unsigned int' makes pointer from integer without a cast
Message-ID: <202209021643.kq1QkE0a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block viro/vfs/next.tty
head:   6890ade9a0f2c360dbc86f39afc1ef852f4a83c6
commit: 6890ade9a0f2c360dbc86f39afc1ef852f4a83c6 [8/8] saner tty_mode_ioctl() prototype
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220902/202209021643.kq1QkE0a-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6890ade9a0f2c360dbc86f39afc1ef852f4a83c6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block viro/vfs/next.tty
        git checkout 6890ade9a0f2c360dbc86f39afc1ef852f4a83c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from drivers/tty/tty_ioctl.c:13:
   drivers/tty/tty_ioctl.c: In function 'tty_mode_ioctl':
>> arch/powerpc/include/asm/uaccess.h:261:13: warning: assignment to 'void *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
     261 |         (x) = (__typeof__(*(ptr)))__gu_val;                     \
         |             ^
   arch/powerpc/include/asm/uaccess.h:271:19: note: in expansion of macro '__get_user'
     271 |                   __get_user(x, _gu_addr) :                             \
         |                   ^~~~~~~~~~
   drivers/tty/tty_ioctl.c:879:21: note: in expansion of macro 'get_user'
     879 |                 if (get_user(arg, (unsigned int __user *) arg))
         |                     ^~~~~~~~
   drivers/tty/tty_ioctl.c:881:53: warning: passing argument 2 of 'tty_change_softcar' makes integer from pointer without a cast [-Wint-conversion]
     881 |                 return tty_change_softcar(real_tty, arg);
         |                                                     ^~~
         |                                                     |
         |                                                     void *
   drivers/tty/tty_ioctl.c:734:59: note: expected 'int' but argument is of type 'void *'
     734 | static int tty_change_softcar(struct tty_struct *tty, int arg)
         |                                                       ~~~~^~~


vim +261 arch/powerpc/include/asm/uaccess.h

5cd29b1fd3e8f2 arch/powerpc/include/asm/uaccess.h Christophe Leroy   2021-03-10  242  
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  243  /*
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  244   * This is a type: either unsigned long, if the argument fits into
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  245   * that type, or otherwise unsigned long long.
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  246   */
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  247  #define __long_type(x) \
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  248  	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  249  
17f8c0bc21bbb7 arch/powerpc/include/asm/uaccess.h Christophe Leroy   2021-03-10  250  #define __get_user(x, ptr)					\
2df5e8bcca53e5 include/asm-powerpc/uaccess.h      Stephen Rothwell   2005-10-29  251  ({								\
2df5e8bcca53e5 include/asm-powerpc/uaccess.h      Stephen Rothwell   2005-10-29  252  	long __gu_err;						\
f7a6947cd49b7f arch/powerpc/include/asm/uaccess.h Michael Ellerman   2018-07-10  253  	__long_type(*(ptr)) __gu_val;				\
e00d93ac9a1896 arch/powerpc/include/asm/uaccess.h Anton Blanchard    2018-09-14  254  	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
17f8c0bc21bbb7 arch/powerpc/include/asm/uaccess.h Christophe Leroy   2021-03-10  255  	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));	\
d02f6b7dab8228 arch/powerpc/include/asm/uaccess.h Nicholas Piggin    2020-04-07  256  								\
1af1717dbf96eb arch/powerpc/include/asm/uaccess.h Michael S. Tsirkin 2013-05-26  257  	might_fault();					\
e72fcdb26cde72 arch/powerpc/include/asm/uaccess.h Christophe Leroy   2021-03-10  258  	allow_read_from_user(__gu_addr, __gu_size);		\
e72fcdb26cde72 arch/powerpc/include/asm/uaccess.h Christophe Leroy   2021-03-10  259  	__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);	\
e72fcdb26cde72 arch/powerpc/include/asm/uaccess.h Christophe Leroy   2021-03-10  260  	prevent_read_from_user(__gu_addr, __gu_size);		\
2df5e8bcca53e5 include/asm-powerpc/uaccess.h      Stephen Rothwell   2005-10-29 @261  	(x) = (__typeof__(*(ptr)))__gu_val;			\
d02f6b7dab8228 arch/powerpc/include/asm/uaccess.h Nicholas Piggin    2020-04-07  262  								\
2df5e8bcca53e5 include/asm-powerpc/uaccess.h      Stephen Rothwell   2005-10-29  263  	__gu_err;						\
2df5e8bcca53e5 include/asm-powerpc/uaccess.h      Stephen Rothwell   2005-10-29  264  })
2df5e8bcca53e5 include/asm-powerpc/uaccess.h      Stephen Rothwell   2005-10-29  265  

:::::: The code at line 261 was first introduced by commit
:::::: 2df5e8bcca53e528a78ee0e3b114d0d21dd6d043 powerpc: merge uaccess.h

:::::: TO: Stephen Rothwell <sfr@canb.auug.org.au>
:::::: CC: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
