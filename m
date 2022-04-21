Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98350A109
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386655AbiDUNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359071AbiDUNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:46:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06963703C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650548598; x=1682084598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LqxG6CMNpCvDoph0giZ6h8fUSlEMss2zdZD880HZ9G0=;
  b=Q6Pp0B27szSSimYtx4MTLnFq37RrQJMsV13XuBBPchUOQkq6HE/1KQ98
   IJwibTjqx+j46kcGXMtUjFip2XxquDcELPO6gTi+Bcdyfw1cKxEoq9Xtl
   RVemP+/W9HRSldJ0P4IUZb8fcYeSBHCi0lSVR+dgayEtOoJyHlU8cO0vc
   A9I4RYD7KvAYM82lKb7FY85l+Prp53QPzO2kxzxEuNvRWm5JcsDSZNWhc
   KqJgO7F55T6yANpF97dEMcnKsAmfY2sEcynSpsHpw7ym5EbTNg/UwuYAZ
   LX/3bdl/7Ffb0v0mMwPXS1pJk5xzASkL0nJ+UVSu/EyY3TAO/M/4JcjuM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="261952433"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="261952433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="670748383"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 06:43:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhX5X-0008RT-Ng;
        Thu, 21 Apr 2022 13:43:15 +0000
Date:   Thu, 21 Apr 2022 21:43:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.4 1/5]
 include/linux/string.h:294:33: warning: '__builtin_strncpy' output truncated
 copying 8 bytes from a string of length 27
Message-ID: <202204212124.c4Cz1ERW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.4
head:   e613962787e504da4b594e69c524e003c1267ebd
commit: 71b7d7ee19a794811e8a70d7407d79197f5b930f [1/5] etherdevice: Adjust ether_addr* prototypes to silence -Wstringop-overead
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204212124.c4Cz1ERW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/71b7d7ee19a794811e8a70d7407d79197f5b930f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.4
        git checkout 71b7d7ee19a794811e8a70d7407d79197f5b930f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:21,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:39,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/nvme/target/discovery.c:7:
   In function 'strncpy',
       inlined from 'nvmet_execute_identify_disc_ctrl' at drivers/nvme/target/discovery.c:243:2:
>> include/linux/string.h:294:33: warning: '__builtin_strncpy' output truncated copying 8 bytes from a string of length 27 [-Wstringop-truncation]
     294 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/string.h:304:16: note: in expansion of macro '__underlying_strncpy'
     304 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~


vim +/__builtin_strncpy +294 include/linux/string.h

b008ae4cc74d3a Daniel Axtens 2020-06-03  272  
b008ae4cc74d3a Daniel Axtens 2020-06-03  273  #ifdef CONFIG_KASAN
b008ae4cc74d3a Daniel Axtens 2020-06-03  274  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
b008ae4cc74d3a Daniel Axtens 2020-06-03  275  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
b008ae4cc74d3a Daniel Axtens 2020-06-03  276  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
b008ae4cc74d3a Daniel Axtens 2020-06-03  277  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
b008ae4cc74d3a Daniel Axtens 2020-06-03  278  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
b008ae4cc74d3a Daniel Axtens 2020-06-03  279  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
b008ae4cc74d3a Daniel Axtens 2020-06-03  280  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
b008ae4cc74d3a Daniel Axtens 2020-06-03  281  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
b008ae4cc74d3a Daniel Axtens 2020-06-03  282  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
b008ae4cc74d3a Daniel Axtens 2020-06-03  283  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
b008ae4cc74d3a Daniel Axtens 2020-06-03  284  #else
b008ae4cc74d3a Daniel Axtens 2020-06-03  285  #define __underlying_memchr	__builtin_memchr
b008ae4cc74d3a Daniel Axtens 2020-06-03  286  #define __underlying_memcmp	__builtin_memcmp
b008ae4cc74d3a Daniel Axtens 2020-06-03  287  #define __underlying_memcpy	__builtin_memcpy
b008ae4cc74d3a Daniel Axtens 2020-06-03  288  #define __underlying_memmove	__builtin_memmove
b008ae4cc74d3a Daniel Axtens 2020-06-03  289  #define __underlying_memset	__builtin_memset
b008ae4cc74d3a Daniel Axtens 2020-06-03  290  #define __underlying_strcat	__builtin_strcat
b008ae4cc74d3a Daniel Axtens 2020-06-03  291  #define __underlying_strcpy	__builtin_strcpy
b008ae4cc74d3a Daniel Axtens 2020-06-03  292  #define __underlying_strlen	__builtin_strlen
b008ae4cc74d3a Daniel Axtens 2020-06-03  293  #define __underlying_strncat	__builtin_strncat
b008ae4cc74d3a Daniel Axtens 2020-06-03 @294  #define __underlying_strncpy	__builtin_strncpy
b008ae4cc74d3a Daniel Axtens 2020-06-03  295  #endif
b008ae4cc74d3a Daniel Axtens 2020-06-03  296  

:::::: The code at line 294 was first introduced by commit
:::::: b008ae4cc74d3ab43074099746f6c32d353e01aa string.h: fix incompatibility between FORTIFY_SOURCE and KASAN

:::::: TO: Daniel Axtens <dja@axtens.net>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
