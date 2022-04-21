Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7574F5097F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385097AbiDUGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385051AbiDUGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:46:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10E1582C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523373; x=1682059373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hl7kolajufFLBeeRU3y7HbnhUIm8/i+Vz+gX+teYA+A=;
  b=ArKSMojSdQjxYtDMm1eSPrExgHsYn0lxwQoaNDEwhHOgXIM4q3MF1STw
   neV7Vr6WgDUPqXKlLF8plb+8JEFQXtp7Nns680011zoETbd1/vqq54FYg
   QQmI4tg1t6Z6da/n8MeVHEyf/Epe2UBfd6Zpuf+8mTiGqv0XkVvipixkb
   gj9SJL5DfizBGGtvct9gyvyRFGgppJO+xBETy0rakRYIeGVFaVMUUu06p
   JyvEO3U2Ze3+DOOGz9fltHnam3OLErAXW4Exbzg6+a2tKkYHSCDFfLeFq
   j3q1DLAynikSsWncoeXQVProo2v7X3bHtXw87RPlkYZMZ1E5tiO5DdTn4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246151501"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246151501"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="555608793"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2022 23:42:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQWg-000800-NH;
        Thu, 21 Apr 2022 06:42:50 +0000
Date:   Thu, 21 Apr 2022 14:42:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rich Felker <dalias@libc.org>, Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 1067/5978]
 arch/sh/include/asm/sfp-machine.h:17: warning: "__BYTE_ORDER" redefined
Message-ID: <202204210320.mV4dGGk4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   81d8d30c35edf29c5c70186ccb14dac4a5ca38a8
commit: 3d937f901cea25765a3dea5f54c4a04322790f6e [1067/5978] sh: define __BIG_ENDIAN for math-emu
config: sh-buildonly-randconfig-r005-20220420 (https://download.01.org/0day-ci/archive/20220421/202204210320.mV4dGGk4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=3d937f901cea25765a3dea5f54c4a04322790f6e
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 3d937f901cea25765a3dea5f54c4a04322790f6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/math-emu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/math-emu/soft-fp.h:27,
                    from arch/sh/math-emu/math.c:22:
>> arch/sh/include/asm/sfp-machine.h:17: warning: "__BYTE_ORDER" redefined
      17 | #define __BYTE_ORDER __BIG_ENDIAN
         | 
   In file included from arch/sh/math-emu/math.c:21:
   arch/sh/math-emu/sfp-util.h:71: note: this is the location of the previous definition
      71 | #define __BYTE_ORDER __LITTLE_ENDIAN
         | 
   arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
      54 | #define WRITE(d,a)      ({if(put_user(d, (typeof (d)*)a)) return -EFAULT;})
         | 
   In file included from arch/sh/math-emu/math.c:10:
   include/linux/kernel.h:38: note: this is the location of the previous definition
      38 | #define WRITE                   1
         | 
   arch/sh/math-emu/math.c:55: warning: "READ" redefined
      55 | #define READ(d,a)       ({if(get_user(d, (typeof (d)*)a)) return -EFAULT;})
         | 
   In file included from arch/sh/math-emu/math.c:10:
   include/linux/kernel.h:37: note: this is the location of the previous definition
      37 | #define READ                    0
         | 
   In file included from include/math-emu/soft-fp.h:187,
                    from arch/sh/math-emu/math.c:22:
   arch/sh/math-emu/math.c: In function 'fcmp_gt':
   arch/sh/math-emu/math.c:69:40: warning: variable 'Fn_c' set but not used [-Wunused-but-set-variable]
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                                        ^~
   include/math-emu/op-common.h:28:14: note: in definition of macro '_FP_DECL'
      28 |   _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
         |              ^
   arch/sh/math-emu/math.c:69:27: note: in expansion of macro 'FP_DECL_D'
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                           ^~~~~~~~
   arch/sh/math-emu/math.c:66:34: note: in expansion of macro 'CMP_X'
      66 |         FP_DECL_EX; if(FPSCR_PR) op(D,x,DRm,DRn); else op(S,x,FRm,FRn);
         |                                  ^~
   arch/sh/math-emu/math.c:76:27: note: in expansion of macro 'BOTH_PRmn'
      76 | #define CMP(OP) ({ int r; BOTH_PRmn(OP##_X,r); r; })
         |                           ^~~~~~~~~
   arch/sh/math-emu/math.c:81:13: note: in expansion of macro 'CMP'
      81 |         if (CMP(CMP) > 0)
         |             ^~~
   arch/sh/math-emu/math.c:69:22: warning: variable 'Fm_c' set but not used [-Wunused-but-set-variable]
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                      ^~
   include/math-emu/op-common.h:28:14: note: in definition of macro '_FP_DECL'
      28 |   _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
         |              ^
   arch/sh/math-emu/math.c:69:9: note: in expansion of macro 'FP_DECL_D'
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |         ^~~~~~~~
   arch/sh/math-emu/math.c:66:34: note: in expansion of macro 'CMP_X'
      66 |         FP_DECL_EX; if(FPSCR_PR) op(D,x,DRm,DRn); else op(S,x,FRm,FRn);
         |                                  ^~
   arch/sh/math-emu/math.c:76:27: note: in expansion of macro 'BOTH_PRmn'
      76 | #define CMP(OP) ({ int r; BOTH_PRmn(OP##_X,r); r; })
         |                           ^~~~~~~~~
   arch/sh/math-emu/math.c:81:13: note: in expansion of macro 'CMP'
      81 |         if (CMP(CMP) > 0)
         |             ^~~
   arch/sh/math-emu/math.c:69:40: warning: variable 'Fn_c' set but not used [-Wunused-but-set-variable]
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                                        ^~
   include/math-emu/op-common.h:28:14: note: in definition of macro '_FP_DECL'
      28 |   _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
         |              ^
   arch/sh/math-emu/math.c:69:27: note: in expansion of macro 'FP_DECL_S'
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                           ^~~~~~~~
   arch/sh/math-emu/math.c:66:56: note: in expansion of macro 'CMP_X'
      66 |         FP_DECL_EX; if(FPSCR_PR) op(D,x,DRm,DRn); else op(S,x,FRm,FRn);
         |                                                        ^~
   arch/sh/math-emu/math.c:76:27: note: in expansion of macro 'BOTH_PRmn'
      76 | #define CMP(OP) ({ int r; BOTH_PRmn(OP##_X,r); r; })
         |                           ^~~~~~~~~
   arch/sh/math-emu/math.c:81:13: note: in expansion of macro 'CMP'
      81 |         if (CMP(CMP) > 0)
         |             ^~~
   arch/sh/math-emu/math.c:69:22: warning: variable 'Fm_c' set but not used [-Wunused-but-set-variable]
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                      ^~
   include/math-emu/op-common.h:28:14: note: in definition of macro '_FP_DECL'
      28 |   _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
         |              ^
   arch/sh/math-emu/math.c:69:9: note: in expansion of macro 'FP_DECL_S'
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |         ^~~~~~~~
   arch/sh/math-emu/math.c:66:56: note: in expansion of macro 'CMP_X'
      66 |         FP_DECL_EX; if(FPSCR_PR) op(D,x,DRm,DRn); else op(S,x,FRm,FRn);
         |                                                        ^~
   arch/sh/math-emu/math.c:76:27: note: in expansion of macro 'BOTH_PRmn'
      76 | #define CMP(OP) ({ int r; BOTH_PRmn(OP##_X,r); r; })
         |                           ^~~~~~~~~
   arch/sh/math-emu/math.c:81:13: note: in expansion of macro 'CMP'
      81 |         if (CMP(CMP) > 0)
         |             ^~~
   arch/sh/math-emu/math.c: In function 'fcmp_eq':
   arch/sh/math-emu/math.c:69:40: warning: variable 'Fn_c' set but not used [-Wunused-but-set-variable]
      69 |         FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
         |                                        ^~
   include/math-emu/op-common.h:28:14: note: in definition of macro '_FP_DECL'


vim +/__BYTE_ORDER +17 arch/sh/include/asm/sfp-machine.h

    15	
    16	#ifdef __BIG_ENDIAN__
  > 17	#define __BYTE_ORDER __BIG_ENDIAN
    18	#define __LITTLE_ENDIAN 0
    19	#else
    20	#define __BYTE_ORDER __LITTLE_ENDIAN
    21	#define __BIG_ENDIAN 0
    22	#endif
    23	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
