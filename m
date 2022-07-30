Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D6585933
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiG3IgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiG3IgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:36:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3832C13EB7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659170160; x=1690706160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q1yUwiF4wpL++puTylr9syqtyGC5KFVkzaS3swaErXE=;
  b=BvXZmVa4vwFMlmR4EpfhfDpSeE/EEDL8lEjCSfnM6ovD+qDHpz4NDApU
   BSpn7RlBc+YolC9uh6OXxJ1yZt6PYvDFJgOXYb7Ym63oGZUJPGfgjuurn
   Oz243cYrFVE+mityZ2VeAuXzhIEmKVry+5Zuc1InrLeTJYxbBRLU4Ll5g
   DHfHAFsLk0lPdricoJJ+s+ZBhPg8svsCrwBZMs9nV/rR6XlAQGffTS69T
   uBhf7NfWDj8jdGH331INbNUWa9YQim/g9oXhHJ5Fiff25OtNb3Pw5BsSP
   pEDUCff/4/a3HEinoHrr5nFac8WnC6xObZGoEe1dhjHn6QeuP7WAELfCN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287659703"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="287659703"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 01:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="551983376"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2022 01:35:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHhwz-000CeH-0e;
        Sat, 30 Jul 2022 08:35:57 +0000
Date:   Sat, 30 Jul 2022 16:35:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 6418/9999] cc1: error:
 arch/sh/include/mach-rsk: No such file or directory
Message-ID: <202207301643.B4B5Etah-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 4fae0a1dc645742f2ecd6238813b2d30d4fb31cd [6418/9999] UPSTREAM: kbuild: add some extra warning flags unconditionally
config: sh-rsk7201_defconfig (https://download.01.org/0day-ci/archive/20220730/202207301643.B4B5Etah-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/4fae0a1dc645742f2ecd6238813b2d30d4fb31cd
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 4fae0a1dc645742f2ecd6238813b2d30d4fb31cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/lib/lshrdi3.c:6:11: error: no previous prototype for '__lshrdi3' [-Werror=missing-prototypes]
       6 | long long __lshrdi3(long long u, word_type b)
         |           ^~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/lib/ashldi3.c:6:11: error: no previous prototype for '__ashldi3' [-Werror=missing-prototypes]
       6 | long long __ashldi3(long long u, word_type b)
         |           ^~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/lib/ashrdi3.c:6:11: error: no previous prototype for '__ashrdi3' [-Werror=missing-prototypes]
       6 | long long __ashrdi3(long long u, word_type b)
         |           ^~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/idle.c:35:6: error: no previous prototype for 'arch_cpu_idle_dead' [-Werror=missing-prototypes]
      35 | void arch_cpu_idle_dead(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/sh/kernel/idle.c:40:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
      40 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/sh/kernel/idle.c:45:13: error: no previous prototype for 'select_idle_routine' [-Werror=missing-prototypes]
      45 | void __init select_idle_routine(void)
         |             ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/machvec.c: In function 'early_parse_mv':
   arch/sh/kernel/machvec.c:46:15: error: variable 'mv_comma' set but not used [-Werror=unused-but-set-variable]
      46 |         char *mv_comma;
         |               ^~~~~~~~
   arch/sh/kernel/machvec.c: In function 'sh_mv_setup':
   arch/sh/kernel/machvec.c:107:33: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]
     107 |                         sh_mv = *(struct sh_machine_vector *)&__machvec_start;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sh/kernel/machvec.c:16:
   arch/sh/include/asm/sections.h:7:13: note: object '__machvec_start' of size 4
       7 | extern long __machvec_start, __machvec_end;
         |             ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/ptrace_32.c: In function 'arch_ptrace':
   arch/sh/kernel/ptrace_32.c:383:40: error: comparison of unsigned expression in '< 0' is always false [-Werror=type-limits]
     383 |                 if ((addr & 3) || addr < 0 ||
         |                                        ^
   arch/sh/kernel/ptrace_32.c:423:40: error: comparison of unsigned expression in '< 0' is always false [-Werror=type-limits]
     423 |                 if ((addr & 3) || addr < 0 ||
         |                                        ^
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/return_address.c:52:7: error: no previous prototype for 'return_address' [-Werror=missing-prototypes]
      52 | void *return_address(unsigned int depth)
         |       ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/sys_sh.c:58:16: error: no previous prototype for 'sys_cacheflush' [-Werror=missing-prototypes]
      58 | asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
         |                ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/traps.c: In function 'is_valid_bugaddr':
   arch/sh/kernel/traps.c:119:18: error: comparison of unsigned expression in '< 0' is always false [-Werror=type-limits]
     119 |         if (addr < PAGE_OFFSET)
         |                  ^
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-rsk: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/traps_32.c:734:6: error: no previous prototype for 'per_cpu_trap_init' [-Werror=missing-prototypes]
     734 | void per_cpu_trap_init(void)
         |      ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
