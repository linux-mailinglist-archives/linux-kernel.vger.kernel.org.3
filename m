Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3C5AA9EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiIBI1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiIBI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:27:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BBA72689
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662107269; x=1693643269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l+2HdTQyQnhLRptMYm8iUYbsJXK1WnyHw8b4HtZvMA0=;
  b=UPpBcqnywyi/ZrNPduQeK1ISyUVGmqRzPZIwGAS7NFdtT5mEuAGKJtI7
   NNWhmsxQr8CjYnB76NaYBFWQ6tXXXxk0ZV/zhBhEMgT/f5FpVzxAFvzQv
   t/x37ZXwbSrhMYTp2W6c6fmyRAbMkU+LzK9LdBYzBCJMfj2dhMOiyW80u
   i9rEdLdXcncRep5lT7mxEGYwStnxgeW7Z1LYwjsqvjLJW/VK7iwgSuJoY
   X7ECbb3dFvVe+MeJvgqR8/zIhZoQ+1BOQaThAUZMGZnN/kFoFnqopx7ZN
   zydqtAZR2WoHb8y90KzDpfRPOHGllM+FmidC+S97RzIsMI+ONQJGLZ0id
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295939539"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="295939539"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="788585272"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2022 01:27:24 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oU21L-0000OH-1T;
        Fri, 02 Sep 2022 08:27:23 +0000
Date:   Fri, 2 Sep 2022 16:27:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:viro/vfs/next.tty 8/8]
 arch/parisc/include/asm/uaccess.h:89:15: warning: assignment to 'void *'
 from 'unsigned int' makes pointer from integer without a cast
Message-ID: <202209021628.FSjVTR8L-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220902/202209021628.FSjVTR8L-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6890ade9a0f2c360dbc86f39afc1ef852f4a83c6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block viro/vfs/next.tty
        git checkout 6890ade9a0f2c360dbc86f39afc1ef852f4a83c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from drivers/tty/tty_ioctl.c:13:
   drivers/tty/tty_ioctl.c: In function 'tty_mode_ioctl':
>> arch/parisc/include/asm/uaccess.h:89:15: warning: assignment to 'void *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      89 |         (val) = (__force __typeof__(*(ptr))) __gu_val;  \
         |               ^
   arch/parisc/include/asm/uaccess.h:64:17: note: in expansion of macro '__get_user_asm'
      64 |         case 1: __get_user_asm(sr, val, "ldb", ptr); break; \
         |                 ^~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:76:9: note: in expansion of macro '__get_user_internal'
      76 |         __get_user_internal(SR_USER, val, ptr); \
         |         ^~~~~~~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:19:18: note: in expansion of macro '__get_user'
      19 | #define get_user __get_user
         |                  ^~~~~~~~~~
   drivers/tty/tty_ioctl.c:879:21: note: in expansion of macro 'get_user'
     879 |                 if (get_user(arg, (unsigned int __user *) arg))
         |                     ^~~~~~~~
>> arch/parisc/include/asm/uaccess.h:89:15: warning: assignment to 'void *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      89 |         (val) = (__force __typeof__(*(ptr))) __gu_val;  \
         |               ^
   arch/parisc/include/asm/uaccess.h:65:17: note: in expansion of macro '__get_user_asm'
      65 |         case 2: __get_user_asm(sr, val, "ldh", ptr); break; \
         |                 ^~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:76:9: note: in expansion of macro '__get_user_internal'
      76 |         __get_user_internal(SR_USER, val, ptr); \
         |         ^~~~~~~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:19:18: note: in expansion of macro '__get_user'
      19 | #define get_user __get_user
         |                  ^~~~~~~~~~
   drivers/tty/tty_ioctl.c:879:21: note: in expansion of macro 'get_user'
     879 |                 if (get_user(arg, (unsigned int __user *) arg))
         |                     ^~~~~~~~
>> arch/parisc/include/asm/uaccess.h:89:15: warning: assignment to 'void *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      89 |         (val) = (__force __typeof__(*(ptr))) __gu_val;  \
         |               ^
   arch/parisc/include/asm/uaccess.h:66:17: note: in expansion of macro '__get_user_asm'
      66 |         case 4: __get_user_asm(sr, val, "ldw", ptr); break; \
         |                 ^~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:76:9: note: in expansion of macro '__get_user_internal'
      76 |         __get_user_internal(SR_USER, val, ptr); \
         |         ^~~~~~~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:19:18: note: in expansion of macro '__get_user'
      19 | #define get_user __get_user
         |                  ^~~~~~~~~~
   drivers/tty/tty_ioctl.c:879:21: note: in expansion of macro 'get_user'
     879 |                 if (get_user(arg, (unsigned int __user *) arg))
         |                     ^~~~~~~~
   arch/parisc/include/asm/uaccess.h:122:15: warning: assignment to 'void *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
     122 |         (val) = __gu_tmp.t;                             \
         |               ^
   arch/parisc/include/asm/uaccess.h:22:33: note: in expansion of macro '__get_user_asm64'
      22 | #define LDD_USER(sr, val, ptr)  __get_user_asm64(sr, val, ptr)
         |                                 ^~~~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:67:17: note: in expansion of macro 'LDD_USER'
      67 |         case 8: LDD_USER(sr, val, ptr); break;          \
         |                 ^~~~~~~~
   arch/parisc/include/asm/uaccess.h:76:9: note: in expansion of macro '__get_user_internal'
      76 |         __get_user_internal(SR_USER, val, ptr); \
         |         ^~~~~~~~~~~~~~~~~~~
   arch/parisc/include/asm/uaccess.h:19:18: note: in expansion of macro '__get_user'
      19 | #define get_user __get_user
         |                  ^~~~~~~~~~
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


vim +89 arch/parisc/include/asm/uaccess.h

3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16  78  
671028728083e8 arch/parisc/include/asm/uaccess.h Helge Deller   2021-09-09  79  #define __get_user_asm(sr, val, ldx, ptr)		\
3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16  80  {							\
3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16  81  	register long __gu_val;				\
3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16  82  							\
5613a930857ecf arch/parisc/include/asm/uaccess.h Helge Deller   2022-02-16  83  	__asm__("1: " ldx " 0(%%sr%2,%3),%0\n"		\
d19f5e41b344a0 arch/parisc/include/asm/uaccess.h Helge Deller   2017-03-25  84  		"9:\n"					\
d19f5e41b344a0 arch/parisc/include/asm/uaccess.h Helge Deller   2017-03-25  85  		ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 9b)	\
dbd0b42350d571 arch/parisc/include/asm/uaccess.h Helge Deller   2022-02-13  86  		: "=r"(__gu_val), "+r"(__gu_err)        \
5613a930857ecf arch/parisc/include/asm/uaccess.h Helge Deller   2022-02-16  87  		: "i"(sr), "r"(ptr));			\
3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16  88  							\
3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16 @89  	(val) = (__force __typeof__(*(ptr))) __gu_val;	\
3f795cef0ecdf9 arch/parisc/include/asm/uaccess.h Helge Deller   2017-04-16  90  }
^1da177e4c3f41 include/asm-parisc/uaccess.h      Linus Torvalds 2005-04-16  91  

:::::: The code at line 89 was first introduced by commit
:::::: 3f795cef0ecdf9bc980dd058d49bdab4b19af1d3 parisc: Fix get_user() for 64-bit value on 32-bit kernel

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
