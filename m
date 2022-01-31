Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316A34A4050
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358255AbiAaKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:35:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:16405 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358198AbiAaKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643625322; x=1675161322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ps3THcmasrGsnJuJcpK5UxxsYkVWGxZa/gZhdYbC9Y=;
  b=D67WdBm1GLleSpYC9sKtHpKzh2yrkKrpgHmdQvC/Cgcvcil0rg5RJKuN
   S9HzeMrnK2XPYnG7BJECAY1EGVLeqizcysBCEO09wrI6Dop5oDhUtonYe
   Ghz2MCyEXBPVcodUeZI4IpBKXG+fGrwFsfQASFsUh9D9bNZy7fdNjemj7
   Ybn/Nr8l8FqIUR6gu4nLaQ52K2H6NyPgU1XzWi/mHJ0ksOxyNZ8/QmlY4
   kmJYbjcs1Qo+LuUl8g478tZ81sjXLxydzQKPXYr3o6CjY3cYJed1JMzie
   +oCi47tPx9OVLUTQrQQqjZhnnL/Jdpl59MQcPSFM4SQCaSu+VQrDzrwfI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="271903968"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="271903968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="626328621"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2022 02:35:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEU1n-000Rmi-1M; Mon, 31 Jan 2022 10:35:19 +0000
Date:   Mon, 31 Jan 2022 18:35:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Nguyen Dinh Phi <phind.uet@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: make a couple of functions static
Message-ID: <202201311820.inNbCM0H-lkp@intel.com>
References: <20220131071006.1764343-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131071006.1764343-1-phind.uet@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nguyen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Nguyen-Dinh-Phi/staging-vc04_services-make-a-couple-of-functions-static/20220131-151209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 64b2d6ffff862c0e7278198b4229e42e1abb3bb1
config: x86_64-buildonly-randconfig-r004-20220131 (https://download.01.org/0day-ci/archive/20220131/202201311820.inNbCM0H-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1b64825a2b5b3312ae309c1714239df049b018ac
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nguyen-Dinh-Phi/staging-vc04_services-make-a-couple-of-functions-static/20220131-151209
        git checkout 1b64825a2b5b3312ae309c1714239df049b018ac
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/staging/vc04_services/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
   In function 'memcpy',
       inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:4,
       inlined from 'vchiq_complete_bulk' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:650:3:
>> include/linux/fortify-string.h:41:29: warning: argument 2 null where non-null expected [-Wnonnull]
      41 | #define __underlying_memcpy __builtin_memcpy
         |                             ^
   include/linux/fortify-string.h:225:9: note: in expansion of macro '__underlying_memcpy'
     225 |  return __underlying_memcpy(p, q, size);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function 'vchiq_complete_bulk':
   include/linux/fortify-string.h:41:29: note: in a call to built-in function '__builtin_memcpy'
      41 | #define __underlying_memcpy __builtin_memcpy
         |                             ^
   include/linux/fortify-string.h:225:9: note: in expansion of macro '__underlying_memcpy'
     225 |  return __underlying_memcpy(p, q, size);
         |         ^~~~~~~~~~~~~~~~~~~


vim +41 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  26  
a28a6e860c6cf2 Francis Laniel 2021-02-25  27  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  28  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  29  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  30  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  31  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  32  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  33  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25 @41  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  46  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25  47  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
