Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46AD4733F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbhLMS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:26:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:19194 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231959AbhLMS0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639419961; x=1670955961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z/H8x0BkWmCExP3G1bRSIUm1ujPcxe8wlxiK+3XTMyc=;
  b=DQo5lBHKPVLVmkELt+j5Rbjb/jlBRD/1FEwEFPPqgev0ps0CiYpmCwlV
   O2TQ8SvKob5tqtDzNRrvk2kC76gfo45gKtDIKW07534L56emutUXQh9s6
   EEh9FTupf9RC/W1UkJuwvdIiCZiQqEeYwRVau6qxOhsw/LSis5JD5+c1y
   qUDtCIX7EEJSq75pMBTmp0ccrx8TNEgJRfzi2QAdm9tEZkJBp0c7ofboT
   Z8q0I2d5q7YKmkE3dxAp/pXYIzbJO17q9BL6EbekalGc6Nni3OkfaaL3S
   O6YYTjz9D34nOi2I+t7YNTvPri4Yk4WlpdBjGpP7gLIrORcMl1zcIl6vg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219480039"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="219480039"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="681732223"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2021 10:25:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwq1I-0006vw-B6; Mon, 13 Dec 2021 18:25:52 +0000
Date:   Tue, 14 Dec 2021 02:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, 282827961@qq.com,
        lianzhi chang <changlianzhi@uniontech.com>
Subject: Re: [PATCH v21] tty: Fix the keyboard led light display problem
Message-ID: <202112140229.T4ovO3wp-lkp@intel.com>
References: <20211213124122.25605-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213124122.25605-1-changlianzhi@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lianzhi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on linux/master linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/lianzhi-chang/tty-Fix-the-keyboard-led-light-display-problem/20211213-204404
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: openrisc-randconfig-r033-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140229.T4ovO3wp-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8cc658e5dd82e5d70fa3ac9dace8fe62eaed325f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review lianzhi-chang/tty-Fix-the-keyboard-led-light-display-problem/20211213-204404
        git checkout 8cc658e5dd82e5d70fa3ac9dace8fe62eaed325f
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/vt/vt_ioctl.c:37:
   include/linux/kbd_kern.h:35:34: error: stray '\357' in program
      35 |         unsigned char kbdledctl:1； /* Whether to allow to control the led of the keyboard */
         |                                  ^~
>> include/linux/kbd_kern.h:39:9: error: expected ',', ';' or '}' before 'unsigned'
      39 |         unsigned char ledmode:1;
         |         ^~~~~~~~
   include/linux/kbd_kern.h: In function 'vc_kbd_mode':
>> include/linux/kbd_kern.h:78:21: error: 'struct kbd_struct' has no member named 'modeflags'
      78 |         return ((kbd->modeflags >> flag) & 1);
         |                     ^~
   include/linux/kbd_kern.h: In function 'vc_kbd_led':
>> include/linux/kbd_kern.h:83:21: error: 'struct kbd_struct' has no member named 'ledflagstate'
      83 |         return ((kbd->ledflagstate >> flag) & 1);
         |                     ^~
   include/linux/kbd_kern.h: In function 'set_vc_kbd_mode':
   include/linux/kbd_kern.h:88:12: error: 'struct kbd_struct' has no member named 'modeflags'
      88 |         kbd->modeflags |= 1 << flag;
         |            ^~
   include/linux/kbd_kern.h: In function 'set_vc_kbd_led':
   include/linux/kbd_kern.h:93:12: error: 'struct kbd_struct' has no member named 'ledflagstate'
      93 |         kbd->ledflagstate |= 1 << flag;
         |            ^~
   include/linux/kbd_kern.h: In function 'clr_vc_kbd_mode':
   include/linux/kbd_kern.h:98:12: error: 'struct kbd_struct' has no member named 'modeflags'
      98 |         kbd->modeflags &= ~(1 << flag);
         |            ^~
   include/linux/kbd_kern.h: In function 'clr_vc_kbd_led':
   include/linux/kbd_kern.h:103:12: error: 'struct kbd_struct' has no member named 'ledflagstate'
     103 |         kbd->ledflagstate &= ~(1 << flag);
         |            ^~
   include/linux/kbd_kern.h: In function 'chg_vc_kbd_mode':
   include/linux/kbd_kern.h:118:12: error: 'struct kbd_struct' has no member named 'modeflags'
     118 |         kbd->modeflags ^= 1 << flag;
         |            ^~
   include/linux/kbd_kern.h: In function 'chg_vc_kbd_led':
   include/linux/kbd_kern.h:123:12: error: 'struct kbd_struct' has no member named 'ledflagstate'
     123 |         kbd->ledflagstate ^= 1 << flag;
         |            ^~
--
   In file included from drivers/tty/vt/keyboard.c:33:
   include/linux/kbd_kern.h:35:34: error: stray '\357' in program
      35 |         unsigned char kbdledctl:1； /* Whether to allow to control the led of the keyboard */
         |                                  ^~
>> include/linux/kbd_kern.h:39:9: error: expected ',', ';' or '}' before 'unsigned'
      39 |         unsigned char ledmode:1;
         |         ^~~~~~~~
   include/linux/kbd_kern.h: In function 'vc_kbd_mode':
>> include/linux/kbd_kern.h:78:21: error: 'struct kbd_struct' has no member named 'modeflags'
      78 |         return ((kbd->modeflags >> flag) & 1);
         |                     ^~
   include/linux/kbd_kern.h: In function 'vc_kbd_led':
>> include/linux/kbd_kern.h:83:21: error: 'struct kbd_struct' has no member named 'ledflagstate'
      83 |         return ((kbd->ledflagstate >> flag) & 1);
         |                     ^~
   include/linux/kbd_kern.h: In function 'set_vc_kbd_mode':
   include/linux/kbd_kern.h:88:12: error: 'struct kbd_struct' has no member named 'modeflags'
      88 |         kbd->modeflags |= 1 << flag;
         |            ^~
   include/linux/kbd_kern.h: In function 'set_vc_kbd_led':
   include/linux/kbd_kern.h:93:12: error: 'struct kbd_struct' has no member named 'ledflagstate'
      93 |         kbd->ledflagstate |= 1 << flag;
         |            ^~
   include/linux/kbd_kern.h: In function 'clr_vc_kbd_mode':
   include/linux/kbd_kern.h:98:12: error: 'struct kbd_struct' has no member named 'modeflags'
      98 |         kbd->modeflags &= ~(1 << flag);
         |            ^~
   include/linux/kbd_kern.h: In function 'clr_vc_kbd_led':
   include/linux/kbd_kern.h:103:12: error: 'struct kbd_struct' has no member named 'ledflagstate'
     103 |         kbd->ledflagstate &= ~(1 << flag);
         |            ^~
   include/linux/kbd_kern.h: In function 'chg_vc_kbd_mode':
   include/linux/kbd_kern.h:118:12: error: 'struct kbd_struct' has no member named 'modeflags'
     118 |         kbd->modeflags ^= 1 << flag;
         |            ^~
   include/linux/kbd_kern.h: In function 'chg_vc_kbd_led':
   include/linux/kbd_kern.h:123:12: error: 'struct kbd_struct' has no member named 'ledflagstate'
     123 |         kbd->ledflagstate ^= 1 << flag;
         |            ^~
   In file included from include/linux/init.h:5,
                    from drivers/tty/vt/keyboard.c:29:
   drivers/tty/vt/keyboard.c: In function 'handle_diacr':
>> drivers/tty/vt/keyboard.c:457:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     457 |         if (kbd->kbdmode == VC_UNICODE)
         |                ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:457:9: note: in expansion of macro 'if'
     457 |         if (kbd->kbdmode == VC_UNICODE)
         |         ^~
>> drivers/tty/vt/keyboard.c:457:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     457 |         if (kbd->kbdmode == VC_UNICODE)
         |                ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:457:9: note: in expansion of macro 'if'
     457 |         if (kbd->kbdmode == VC_UNICODE)
         |         ^~
>> drivers/tty/vt/keyboard.c:457:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     457 |         if (kbd->kbdmode == VC_UNICODE)
         |                ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:457:9: note: in expansion of macro 'if'
     457 |         if (kbd->kbdmode == VC_UNICODE)
         |         ^~
   drivers/tty/vt/keyboard.c: In function 'fn_enter':
   drivers/tty/vt/keyboard.c:474:24: error: 'struct kbd_struct' has no member named 'kbdmode'
     474 |                 if (kbd->kbdmode == VC_UNICODE)
         |                        ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:474:17: note: in expansion of macro 'if'
     474 |                 if (kbd->kbdmode == VC_UNICODE)
         |                 ^~
   drivers/tty/vt/keyboard.c:474:24: error: 'struct kbd_struct' has no member named 'kbdmode'
     474 |                 if (kbd->kbdmode == VC_UNICODE)
         |                        ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:474:17: note: in expansion of macro 'if'
     474 |                 if (kbd->kbdmode == VC_UNICODE)
         |                 ^~
   drivers/tty/vt/keyboard.c:474:24: error: 'struct kbd_struct' has no member named 'kbdmode'
     474 |                 if (kbd->kbdmode == VC_UNICODE)
         |                        ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:474:17: note: in expansion of macro 'if'
     474 |                 if (kbd->kbdmode == VC_UNICODE)
         |                 ^~
   drivers/tty/vt/keyboard.c: In function 'k_spec':
   drivers/tty/vt/keyboard.c:662:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |                 ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c:663:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     663 |              kbd->kbdmode == VC_MEDIUMRAW ||
         |                 ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c:664:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     664 |              kbd->kbdmode == VC_OFF) &&
         |                 ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c:662:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |                 ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c:663:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     663 |              kbd->kbdmode == VC_MEDIUMRAW ||
         |                 ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c:664:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     664 |              kbd->kbdmode == VC_OFF) &&
         |                 ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c:662:17: error: 'struct kbd_struct' has no member named 'kbdmode'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |                 ^~
--
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:662:9: note: in expansion of macro 'if'
     662 |         if ((kbd->kbdmode == VC_RAW ||
         |         ^~
   drivers/tty/vt/keyboard.c: In function 'k_unicode':
   drivers/tty/vt/keyboard.c:688:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     688 |         if (kbd->kbdmode == VC_UNICODE)
         |                ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:688:9: note: in expansion of macro 'if'
     688 |         if (kbd->kbdmode == VC_UNICODE)
         |         ^~
   drivers/tty/vt/keyboard.c:688:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     688 |         if (kbd->kbdmode == VC_UNICODE)
         |                ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:688:9: note: in expansion of macro 'if'
     688 |         if (kbd->kbdmode == VC_UNICODE)
         |         ^~
   drivers/tty/vt/keyboard.c:688:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     688 |         if (kbd->kbdmode == VC_UNICODE)
         |                ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:688:9: note: in expansion of macro 'if'
     688 |         if (kbd->kbdmode == VC_UNICODE)
         |         ^~
   drivers/tty/vt/keyboard.c: In function 'k_shift':
   drivers/tty/vt/keyboard.c:885:24: error: 'struct kbd_struct' has no member named 'kbdmode'
     885 |                 if (kbd->kbdmode == VC_UNICODE)
         |                        ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:885:17: note: in expansion of macro 'if'
     885 |                 if (kbd->kbdmode == VC_UNICODE)
         |                 ^~
   drivers/tty/vt/keyboard.c:885:24: error: 'struct kbd_struct' has no member named 'kbdmode'
     885 |                 if (kbd->kbdmode == VC_UNICODE)
         |                        ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:885:17: note: in expansion of macro 'if'
     885 |                 if (kbd->kbdmode == VC_UNICODE)
         |                 ^~
   drivers/tty/vt/keyboard.c:885:24: error: 'struct kbd_struct' has no member named 'kbdmode'
     885 |                 if (kbd->kbdmode == VC_UNICODE)
         |                        ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:885:17: note: in expansion of macro 'if'
     885 |                 if (kbd->kbdmode == VC_UNICODE)
         |                 ^~
   drivers/tty/vt/keyboard.c: In function 'k_brl':
   drivers/tty/vt/keyboard.c:983:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     983 |         if (kbd->kbdmode != VC_UNICODE) {
         |                ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:983:9: note: in expansion of macro 'if'
     983 |         if (kbd->kbdmode != VC_UNICODE) {
         |         ^~
   drivers/tty/vt/keyboard.c:983:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     983 |         if (kbd->kbdmode != VC_UNICODE) {
         |                ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:983:9: note: in expansion of macro 'if'
     983 |         if (kbd->kbdmode != VC_UNICODE) {
         |         ^~
   drivers/tty/vt/keyboard.c:983:16: error: 'struct kbd_struct' has no member named 'kbdmode'
     983 |         if (kbd->kbdmode != VC_UNICODE) {
         |                ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:983:9: note: in expansion of macro 'if'
     983 |         if (kbd->kbdmode != VC_UNICODE) {
         |         ^~
   drivers/tty/vt/keyboard.c: In function 'setledstate':
>> drivers/tty/vt/keyboard.c:1156:19: error: 'struct kbd_struct' has no member named 'ledmode'
    1156 |                 kb->ledmode = LED_SHOW_IOCTL;
         |                   ^~
   drivers/tty/vt/keyboard.c:1158:19: error: 'struct kbd_struct' has no member named 'ledmode'
    1158 |                 kb->ledmode = LED_SHOW_FLAGS;
         |                   ^~
   In file included from include/linux/init.h:5,
                    from drivers/tty/vt/keyboard.c:29:
   drivers/tty/vt/keyboard.c: In function 'getleds':
   drivers/tty/vt/keyboard.c:1168:15: error: 'struct kbd_struct' has no member named 'ledmode'
    1168 |         if (kb->ledmode == LED_SHOW_IOCTL)
         |               ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:1168:9: note: in expansion of macro 'if'
    1168 |         if (kb->ledmode == LED_SHOW_IOCTL)
         |         ^~
   drivers/tty/vt/keyboard.c:1168:15: error: 'struct kbd_struct' has no member named 'ledmode'
    1168 |         if (kb->ledmode == LED_SHOW_IOCTL)
         |               ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:1168:9: note: in expansion of macro 'if'
    1168 |         if (kb->ledmode == LED_SHOW_IOCTL)
         |         ^~
   drivers/tty/vt/keyboard.c:1168:15: error: 'struct kbd_struct' has no member named 'ledmode'
    1168 |         if (kb->ledmode == LED_SHOW_IOCTL)
         |               ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:1168:9: note: in expansion of macro 'if'
    1168 |         if (kb->ledmode == LED_SHOW_IOCTL)
         |         ^~
>> drivers/tty/vt/keyboard.c:1171:18: error: 'struct kbd_struct' has no member named 'ledflagstate'
    1171 |         return kb->ledflagstate;
         |                  ^~
   In file included from include/linux/init.h:5,
                    from drivers/tty/vt/keyboard.c:29:
   drivers/tty/vt/keyboard.c: In function 'kbd_rawcode':
   drivers/tty/vt/keyboard.c:1398:16: error: 'struct kbd_struct' has no member named 'kbdmode'
    1398 |         if (kbd->kbdmode == VC_RAW)
         |                ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:1398:9: note: in expansion of macro 'if'
    1398 |         if (kbd->kbdmode == VC_RAW)
         |         ^~
   drivers/tty/vt/keyboard.c:1398:16: error: 'struct kbd_struct' has no member named 'kbdmode'
    1398 |         if (kbd->kbdmode == VC_RAW)
         |                ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:1398:9: note: in expansion of macro 'if'
    1398 |         if (kbd->kbdmode == VC_RAW)
         |         ^~
   drivers/tty/vt/keyboard.c:1398:16: error: 'struct kbd_struct' has no member named 'kbdmode'
    1398 |         if (kbd->kbdmode == VC_RAW)
         |                ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:1398:9: note: in expansion of macro 'if'
    1398 |         if (kbd->kbdmode == VC_RAW)
         |         ^~
   drivers/tty/vt/keyboard.c: In function 'kbd_keycode':
   drivers/tty/vt/keyboard.c:1429:24: error: 'struct kbd_struct' has no member named 'kbdmode'
    1429 |         raw_mode = (kbd->kbdmode == VC_RAW);
         |                        ^~
   In file included from include/linux/init.h:5,
                    from drivers/tty/vt/keyboard.c:29:
   drivers/tty/vt/keyboard.c:1443:16: error: 'struct kbd_struct' has no member named 'kbdmode'
    1443 |         if (kbd->kbdmode == VC_MEDIUMRAW) {
         |                ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:1443:9: note: in expansion of macro 'if'
    1443 |         if (kbd->kbdmode == VC_MEDIUMRAW) {
         |         ^~
   drivers/tty/vt/keyboard.c:1443:16: error: 'struct kbd_struct' has no member named 'kbdmode'
    1443 |         if (kbd->kbdmode == VC_MEDIUMRAW) {
         |                ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:1443:9: note: in expansion of macro 'if'
    1443 |         if (kbd->kbdmode == VC_MEDIUMRAW) {
         |         ^~
   drivers/tty/vt/keyboard.c:1443:16: error: 'struct kbd_struct' has no member named 'kbdmode'
    1443 |         if (kbd->kbdmode == VC_MEDIUMRAW) {
         |                ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:1443:9: note: in expansion of macro 'if'
    1443 |         if (kbd->kbdmode == VC_MEDIUMRAW) {
         |         ^~
   drivers/tty/vt/keyboard.c:1477:29: error: 'struct kbd_struct' has no member named 'ledflagstate'
    1477 |         param.ledstate = kbd->ledflagstate;
         |                             ^~
   In file included from include/linux/init.h:5,
                    from drivers/tty/vt/keyboard.c:29:
   drivers/tty/vt/keyboard.c:1526:29: error: 'struct kbd_struct' has no member named 'kbdmode'
    1526 |         if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
         |                             ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/tty/vt/keyboard.c:1526:9: note: in expansion of macro 'if'
    1526 |         if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
         |         ^~
   drivers/tty/vt/keyboard.c:1526:29: error: 'struct kbd_struct' has no member named 'kbdmode'
    1526 |         if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
         |                             ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/tty/vt/keyboard.c:1526:9: note: in expansion of macro 'if'
    1526 |         if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
         |         ^~
   drivers/tty/vt/keyboard.c:1526:29: error: 'struct kbd_struct' has no member named 'kbdmode'
    1526 |         if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
         |                             ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:1526:9: note: in expansion of macro 'if'
    1526 |         if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
         |         ^~
   drivers/tty/vt/keyboard.c:1531:29: error: 'struct kbd_struct' has no member named 'ledflagstate'
    1531 |         param.ledstate = kbd->ledflagstate;
         |                             ^~
   drivers/tty/vt/keyboard.c: In function 'kbd_init':
   drivers/tty/vt/keyboard.c:1664:29: error: 'struct kbd_struct' has no member named 'ledflagstate'
    1664 |                 kbd_table[i].ledflagstate = kbd_defleds();
         |                             ^
>> drivers/tty/vt/keyboard.c:1665:29: error: 'struct kbd_struct' has no member named 'default_ledflagstate'
    1665 |                 kbd_table[i].default_ledflagstate = kbd_defleds();
         |                             ^
   drivers/tty/vt/keyboard.c:1666:29: error: 'struct kbd_struct' has no member named 'ledmode'
    1666 |                 kbd_table[i].ledmode = LED_SHOW_FLAGS;
         |                             ^
>> drivers/tty/vt/keyboard.c:1669:29: error: 'struct kbd_struct' has no member named 'modeflags'
    1669 |                 kbd_table[i].modeflags = KBD_DEFMODE;
         |                             ^
   drivers/tty/vt/keyboard.c:1670:29: error: 'struct kbd_struct' has no member named 'kbdmode'
    1670 |                 kbd_table[i].kbdmode = default_utf8 ? VC_UNICODE : VC_XLATE;
         |                             ^
   drivers/tty/vt/keyboard.c: In function 'vt_do_kdskbmode':
   drivers/tty/vt/keyboard.c:1854:19: error: 'struct kbd_struct' has no member named 'kbdmode'
    1854 |                 kb->kbdmode = VC_RAW;
         |                   ^~
   drivers/tty/vt/keyboard.c:1857:19: error: 'struct kbd_struct' has no member named 'kbdmode'
    1857 |                 kb->kbdmode = VC_MEDIUMRAW;
         |                   ^~
   drivers/tty/vt/keyboard.c:1860:19: error: 'struct kbd_struct' has no member named 'kbdmode'
    1860 |                 kb->kbdmode = VC_XLATE;
         |                   ^~
   drivers/tty/vt/keyboard.c:1864:19: error: 'struct kbd_struct' has no member named 'kbdmode'
    1864 |                 kb->kbdmode = VC_UNICODE;
         |                   ^~
   drivers/tty/vt/keyboard.c:1868:19: error: 'struct kbd_struct' has no member named 'kbdmode'
    1868 |                 kb->kbdmode = VC_OFF;
         |                   ^~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/input.h:20,
                    from drivers/tty/vt/keyboard.c:30:
   drivers/tty/vt/keyboard.c: In function 'vt_do_kdsk_ioctl':
   drivers/tty/vt/keyboard.c:2067:47: error: 'struct kbd_struct' has no member named 'kbdmode'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                                               ^~
   arch/openrisc/include/asm/uaccess.h:146:23: note: in definition of macro '__put_user_asm'
     146 |                 : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err))
         |                       ^
   arch/openrisc/include/asm/uaccess.h:106:17: note: in expansion of macro '__put_user_size'
     106 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
         |                 ^~~~~~~~~~~~~~~
   arch/openrisc/include/asm/uaccess.h:85:9: note: in expansion of macro '__put_user_check'
      85 |         __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:2067:24: note: in expansion of macro 'put_user'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                        ^~~~~~~~
   drivers/tty/vt/keyboard.c:2067:47: error: 'struct kbd_struct' has no member named 'kbdmode'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                                               ^~
   arch/openrisc/include/asm/uaccess.h:146:23: note: in definition of macro '__put_user_asm'
     146 |                 : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err))
         |                       ^
   arch/openrisc/include/asm/uaccess.h:106:17: note: in expansion of macro '__put_user_size'
     106 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
         |                 ^~~~~~~~~~~~~~~
   arch/openrisc/include/asm/uaccess.h:85:9: note: in expansion of macro '__put_user_check'
      85 |         __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:2067:24: note: in expansion of macro 'put_user'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                        ^~~~~~~~
   drivers/tty/vt/keyboard.c:2067:47: error: 'struct kbd_struct' has no member named 'kbdmode'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                                               ^~
   arch/openrisc/include/asm/uaccess.h:146:23: note: in definition of macro '__put_user_asm'
     146 |                 : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err))
         |                       ^
   arch/openrisc/include/asm/uaccess.h:106:17: note: in expansion of macro '__put_user_size'
     106 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
         |                 ^~~~~~~~~~~~~~~
   arch/openrisc/include/asm/uaccess.h:85:9: note: in expansion of macro '__put_user_check'
      85 |         __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:2067:24: note: in expansion of macro 'put_user'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                        ^~~~~~~~
   drivers/tty/vt/keyboard.c:2067:47: error: 'struct kbd_struct' has no member named 'kbdmode'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                                               ^~
   arch/openrisc/include/asm/uaccess.h:164:23: note: in definition of macro '__put_user_asm2'
     164 |                 : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err))
         |                       ^
   arch/openrisc/include/asm/uaccess.h:106:17: note: in expansion of macro '__put_user_size'
     106 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
         |                 ^~~~~~~~~~~~~~~
   arch/openrisc/include/asm/uaccess.h:85:9: note: in expansion of macro '__put_user_check'
      85 |         __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/vt/keyboard.c:2067:24: note: in expansion of macro 'put_user'
    2067 |                 return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
         |                        ^~~~~~~~
   drivers/tty/vt/keyboard.c:2073:38: error: 'struct kbd_struct' has no member named 'kbdmode'
    2073 |                 return vt_kdskbent(kb->kbdmode, kbe.kb_index, kbe.kb_table,
         |                                      ^~
   drivers/tty/vt/keyboard.c: In function 'vt_do_kdskled':
   drivers/tty/vt/keyboard.c:2157:27: error: 'struct kbd_struct' has no member named 'ledflagstate'
    2157 |                 ucval = kb->ledflagstate | (kb->default_ledflagstate << 4);
         |                           ^~
   drivers/tty/vt/keyboard.c:2157:47: error: 'struct kbd_struct' has no member named 'default_ledflagstate'
    2157 |                 ucval = kb->ledflagstate | (kb->default_ledflagstate << 4);
         |                                               ^~


vim +/357 +35 include/linux/kbd_kern.h

    21	
    22		unsigned char lockstate;
    23	/* 8 modifiers - the names do not have any meaning at all;
    24	   they can be associated to arbitrarily chosen keys */
    25	#define VC_SHIFTLOCK	KG_SHIFT	/* shift lock mode */
    26	#define VC_ALTGRLOCK	KG_ALTGR	/* altgr lock mode */
    27	#define VC_CTRLLOCK	KG_CTRL 	/* control lock mode */
    28	#define VC_ALTLOCK	KG_ALT  	/* alt lock mode */
    29	#define VC_SHIFTLLOCK	KG_SHIFTL	/* shiftl lock mode */
    30	#define VC_SHIFTRLOCK	KG_SHIFTR	/* shiftr lock mode */
    31	#define VC_CTRLLLOCK	KG_CTRLL 	/* ctrll lock mode */
    32	#define VC_CTRLRLOCK	KG_CTRLR 	/* ctrlr lock mode */
    33		unsigned char slockstate; 	/* for `sticky' Shift, Ctrl, etc. */
    34	
  > 35		unsigned char kbdledctl:1； /* Whether to allow to control the led of the keyboard */
    36	#define VC_LEDCTL_ON  0	/* VT can set the keyboard light */
    37	#define VC_LEDCTL_OFF 1	/* Prohibit VT to set the keyboard light */
    38	
  > 39		unsigned char ledmode:1;
    40	#define LED_SHOW_FLAGS 0        /* traditional state */
    41	#define LED_SHOW_IOCTL 1        /* only change leds upon ioctl */
    42	
    43		unsigned char ledflagstate:4;	/* flags, not lights */
    44		unsigned char default_ledflagstate:4;
    45	#define VC_SCROLLOCK	0	/* scroll-lock mode */
    46	#define VC_NUMLOCK	1	/* numeric lock mode */
    47	#define VC_CAPSLOCK	2	/* capslock mode */
    48	#define VC_KANALOCK	3	/* kanalock mode */
    49	
    50		unsigned char kbdmode:3;	/* one 3-bit value */
    51	#define VC_XLATE	0	/* translate keycodes using keymap */
    52	#define VC_MEDIUMRAW	1	/* medium raw (keycode) mode */
    53	#define VC_RAW		2	/* raw (scancode) mode */
    54	#define VC_UNICODE	3	/* Unicode mode */
    55	#define VC_OFF		4	/* disabled mode */
    56	
    57		unsigned char modeflags:5;
    58	#define VC_APPLIC	0	/* application key mode */
    59	#define VC_CKMODE	1	/* cursor key mode */
    60	#define VC_REPEAT	2	/* keyboard repeat */
    61	#define VC_CRLF		3	/* 0 - enter sends CR, 1 - enter sends CRLF */
    62	#define VC_META		4	/* 0 - meta, 1 - meta=prefix with ESC */
    63	};
    64	
    65	extern int kbd_init(void);
    66	
    67	extern void setledstate(struct kbd_struct *kbd, unsigned int led);
    68	
    69	extern int do_poke_blanked_console;
    70	
    71	extern void (*kbd_ledfunc)(unsigned int led);
    72	
    73	extern int set_console(int nr);
    74	extern void schedule_console_callback(void);
    75	
    76	static inline int vc_kbd_mode(struct kbd_struct * kbd, int flag)
    77	{
  > 78		return ((kbd->modeflags >> flag) & 1);
    79	}
    80	
    81	static inline int vc_kbd_led(struct kbd_struct * kbd, int flag)
    82	{
  > 83		return ((kbd->ledflagstate >> flag) & 1);
    84	}
    85	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
