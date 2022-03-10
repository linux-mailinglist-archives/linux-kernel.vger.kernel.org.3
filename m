Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F415E4D45EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiCJLlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiCJLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:41:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40E144F4E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646912399; x=1678448399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wpca4C65XdKLmfSnIgeeBjDyTO0VYFF8iimFhIYI9rY=;
  b=eiX1hn+/2VOHBQQIUj5aUYRJeJTfQYugVfAnukcaRvFyZnic6axnNJO0
   /UlraSlYK+Ahv0xFt/vrldK8x9ai43wNCTmlGtB1wzIaQ7MC5yPy5f3eY
   x6os3J6UKgj8meCRajDBlb2XR7jK70p8L7Pw5l/LEEt9qdpwJXbrZ65ah
   Ecp6IyahOkESNKzO60JhSP6ZKp4R6Wv9Ku6KWClTnISGLrF1uVYzD/1zq
   QKl/awnNx5kKD5wFLO/ew1UfrH31PXKWUyaMqzjYozNrn8AZ8O9VQIB5x
   E61P3nAIz4+xnzp/mZtvP23sdZfLjRi/4X9KWTADs9cvDGFY4bU+rPSfI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254057571"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="254057571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 03:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="781431401"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2022 03:39:55 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSH99-0004rb-7p; Thu, 10 Mar 2022 11:39:55 +0000
Date:   Thu, 10 Mar 2022 19:39:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [masahiroy:for-next 3/5] lib/raid6/neon1.c:39:9: warning: mixing
 declarations and code is incompatible with standards before C99
Message-ID: <202203101914.axpeuY5Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
head:   cf4a68247a204c9d46768fabaf7de68a39d8b7c9
commit: 6992f0b3f0fd879b31095263986ba1aedb27c83b [3/5] Kbuild: move to -std=gnu11
config: arm64-randconfig-r026-20220310 (https://download.01.org/0day-ci/archive/20220310/202203101914.axpeuY5Y-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=6992f0b3f0fd879b31095263986ba1aedb27c83b
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy for-next
        git checkout 6992f0b3f0fd879b31095263986ba1aedb27c83b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash lib/raid6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/raid6/neon1.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return vshlq_n_u8(v, 1);
                  ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
                             ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
     int8x16_t __ret; \
               ^
   lib/raid6/neon1.c:56:6: warning: no previous prototype for function 'raid6_neon1_gen_syndrome_real' [-Wmissing-prototypes]
   void raid6_neon1_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
        ^
   lib/raid6/neon1.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void raid6_neon1_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
   ^
   static 
   lib/raid6/neon1.c:117:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:118:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:126:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:127:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 3);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:133:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 6);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:134:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 2);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon1.c:86:6: warning: no previous prototype for function 'raid6_neon1_xor_syndrome_real' [-Wmissing-prototypes]
   void raid6_neon1_xor_syndrome_real(int disks, int start, int stop,
        ^
   lib/raid6/neon1.c:86:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void raid6_neon1_xor_syndrome_real(int disks, int start, int stop,
   ^
   static 
   10 warnings generated.
--
>> lib/raid6/neon2.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return vshlq_n_u8(v, 1);
                  ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
                             ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
     int8x16_t __ret; \
               ^
   lib/raid6/neon2.c:56:6: warning: no previous prototype for function 'raid6_neon2_gen_syndrome_real' [-Wmissing-prototypes]
   void raid6_neon2_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
        ^
   lib/raid6/neon2.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void raid6_neon2_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
   ^
   static 
   lib/raid6/neon2.c:138:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:139:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w21 = vshrq_n_u8(wq1, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:140:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:141:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w11 = vshlq_n_u8(wq1, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:151:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:152:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w21 = vshrq_n_u8(wq1, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:153:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 3);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:154:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w11 = vshlq_n_u8(wq1, 3);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:162:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 6);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:163:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w21 = vshrq_n_u8(wq1, 6);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:164:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 2);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:165:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w11 = vshlq_n_u8(wq1, 2);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon2.c:97:6: warning: no previous prototype for function 'raid6_neon2_xor_syndrome_real' [-Wmissing-prototypes]
   void raid6_neon2_xor_syndrome_real(int disks, int start, int stop,
        ^
   lib/raid6/neon2.c:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void raid6_neon2_xor_syndrome_real(int disks, int start, int stop,
   ^
   static 
   16 warnings generated.
--
>> lib/raid6/neon4.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return vshlq_n_u8(v, 1);
                  ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
                             ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
     int8x16_t __ret; \
               ^
   lib/raid6/neon4.c:56:6: warning: no previous prototype for function 'raid6_neon4_gen_syndrome_real' [-Wmissing-prototypes]
   void raid6_neon4_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
        ^
   lib/raid6/neon4.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void raid6_neon4_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
   ^
   static 
   lib/raid6/neon4.c:180:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:181:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w21 = vshrq_n_u8(wq1, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:182:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w22 = vshrq_n_u8(wq2, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:183:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w23 = vshrq_n_u8(wq3, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:184:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:185:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w11 = vshlq_n_u8(wq1, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:186:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w12 = vshlq_n_u8(wq2, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:187:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w13 = vshlq_n_u8(wq3, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:201:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:202:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w21 = vshrq_n_u8(wq1, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:203:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w22 = vshrq_n_u8(wq2, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:204:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w23 = vshrq_n_u8(wq3, 5);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:205:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 3);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon4.c:206:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w11 = vshlq_n_u8(wq1, 3);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
--
>> lib/raid6/neon8.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return vshlq_n_u8(v, 1);
                  ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
                             ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
     int8x16_t __ret; \
               ^
   lib/raid6/neon8.c:56:6: warning: no previous prototype for function 'raid6_neon8_gen_syndrome_real' [-Wmissing-prototypes]
   void raid6_neon8_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
        ^
   lib/raid6/neon8.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void raid6_neon8_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
   ^
   static 
   lib/raid6/neon8.c:264:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w20 = vshrq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:265:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w21 = vshrq_n_u8(wq1, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:266:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w22 = vshrq_n_u8(wq2, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:267:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w23 = vshrq_n_u8(wq3, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:268:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w24 = vshrq_n_u8(wq4, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:269:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w25 = vshrq_n_u8(wq5, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:270:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w26 = vshrq_n_u8(wq6, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:271:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w27 = vshrq_n_u8(wq7, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:272:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w10 = vshlq_n_u8(wq0, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:273:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w11 = vshlq_n_u8(wq1, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:274:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w12 = vshlq_n_u8(wq2, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:275:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w13 = vshlq_n_u8(wq3, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:276:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w14 = vshlq_n_u8(wq4, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
     uint8x16_t __ret; \
                ^
   lib/raid6/neon8.c:277:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                           w15 = vshlq_n_u8(wq5, 4);
                                 ^
   /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
..

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
