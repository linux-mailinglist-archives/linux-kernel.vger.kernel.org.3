Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E3F4D5127
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiCJSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiCJSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:04:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609A16A593
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:03:34 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id v28so8849228ljv.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sewcILj5Hgqgc/p3+j6rdWNPFy2y6AzVwiotFOvY4yc=;
        b=m7wznu50BSxBw109KDmlsWDtbXZiyL2S4kwCCbOzEg94n0UP4XPcchmJfg00Gt1l27
         znOzxDEt2O2j5KEW6Qkxl7NWSv8Cj9Bal51/vc+0AO3VP7zaRNwblhh2DVt4RPKHvE9v
         YgrAiVTIFw3ZMsU4QVmCa0180lhuugm+sw+HtSLDMbis7HbiSy8UFniuhhLM7aQXQcvk
         F3nGwM6GurKb7ZGnA0N914GG/Az9+8LMJZ/2I80LODG8abHUpn9CeNsTP1JHLBOxbftj
         Bzn8c9UF849MkvndqsJQfUSnHISgVfHjZmOdHVlrHlhhFtEvCu8vJkkc0rVgiyK4TmvN
         WduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sewcILj5Hgqgc/p3+j6rdWNPFy2y6AzVwiotFOvY4yc=;
        b=C+6A+2NTROyD+McSAr4OTs2ST2EjZ91jPGjBoq4GehzH13SWLo30ZBNESBdzMyqxi2
         0Lb0C71b0fKU4VLsnjq6gwN7W8MCfU6wiFvBj48e6Gesse3/hUENf15bGa27Wv32pkCI
         3Ny3NN+q3QQEKX3fEAHs6CUGC4zjkQq02t7rivw8ANY0//YNyGKmn1oE43HtzDnJJoa3
         dcPK8RzYyh2kps+8zKTMLwGh5FV7xcBuI0qAXmMAxzjV0C6ggKv4Ve8iyiFuFpxnEIvw
         Jqyu9Z7kOVZiG9+ZVtGCw5P/Z0bjxBaLKCLi4EZC4+EOBvD4clCJODnG4M6eP5hrUZ09
         EgVw==
X-Gm-Message-State: AOAM533zXxY9K0RfRkkv01XKz0v3sOlbBpa3GhRCWBKzhr+cOUuT2FLc
        ABK9A9wofFQwcrMm+cuRBnjKOjGj/Ezaxp4zWF7ctg==
X-Google-Smtp-Source: ABdhPJxuMB8mfWqFxdvyX5eemz4jhBgtWXpPOsEl6AoYQ8uROHouV0dPQW3FC4zSb7U4NAvh8fc1ZDiYRhSbX9S3XGo=
X-Received: by 2002:a2e:bf24:0:b0:246:801e:39d3 with SMTP id
 c36-20020a2ebf24000000b00246801e39d3mr3700795ljr.472.1646935412585; Thu, 10
 Mar 2022 10:03:32 -0800 (PST)
MIME-Version: 1.0
References: <202203101914.axpeuY5Y-lkp@intel.com>
In-Reply-To: <202203101914.axpeuY5Y-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Mar 2022 10:03:20 -0800
Message-ID: <CAKwvOdkDnZfbG6TKqe6VVzcNBcm=6efDA5m9i5ORuSGk=PjxYw@mail.gmail.com>
Subject: Re: [masahiroy:for-next 3/5] lib/raid6/neon1.c:39:9: warning: mixing
 declarations and code is incompatible with standards before C99
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 3:40 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> head:   cf4a68247a204c9d46768fabaf7de68a39d8b7c9
> commit: 6992f0b3f0fd879b31095263986ba1aedb27c83b [3/5] Kbuild: move to -std=gnu11
> config: arm64-randconfig-r026-20220310 (https://download.01.org/0day-ci/archive/20220310/202203101914.axpeuY5Y-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=6992f0b3f0fd879b31095263986ba1aedb27c83b
>         git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>         git fetch --no-tags masahiroy for-next
>         git checkout 6992f0b3f0fd879b31095263986ba1aedb27c83b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash lib/raid6/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> lib/raid6/neon1.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return vshlq_n_u8(v, 1);
>                   ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'

^ this header is generated by clang. We'll fix it in clang.
https://github.com/ClangBuiltLinux/linux/issues/1603

>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
>                              ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
>      int8x16_t __ret; \
>                ^
>    lib/raid6/neon1.c:56:6: warning: no previous prototype for function 'raid6_neon1_gen_syndrome_real' [-Wmissing-prototypes]
>    void raid6_neon1_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>         ^
>    lib/raid6/neon1.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void raid6_neon1_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>    ^
>    static
>    lib/raid6/neon1.c:117:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:118:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:126:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:127:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 3);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:133:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 6);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:134:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 2);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon1.c:86:6: warning: no previous prototype for function 'raid6_neon1_xor_syndrome_real' [-Wmissing-prototypes]
>    void raid6_neon1_xor_syndrome_real(int disks, int start, int stop,
>         ^
>    lib/raid6/neon1.c:86:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void raid6_neon1_xor_syndrome_real(int disks, int start, int stop,
>    ^
>    static
>    10 warnings generated.
> --
> >> lib/raid6/neon2.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return vshlq_n_u8(v, 1);
>                   ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
>                              ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
>      int8x16_t __ret; \
>                ^
>    lib/raid6/neon2.c:56:6: warning: no previous prototype for function 'raid6_neon2_gen_syndrome_real' [-Wmissing-prototypes]
>    void raid6_neon2_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>         ^
>    lib/raid6/neon2.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void raid6_neon2_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>    ^
>    static
>    lib/raid6/neon2.c:138:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:139:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w21 = vshrq_n_u8(wq1, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:140:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:141:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w11 = vshlq_n_u8(wq1, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:151:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:152:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w21 = vshrq_n_u8(wq1, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:153:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 3);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:154:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w11 = vshlq_n_u8(wq1, 3);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:162:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 6);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:163:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w21 = vshrq_n_u8(wq1, 6);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:164:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 2);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:165:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w11 = vshlq_n_u8(wq1, 2);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon2.c:97:6: warning: no previous prototype for function 'raid6_neon2_xor_syndrome_real' [-Wmissing-prototypes]
>    void raid6_neon2_xor_syndrome_real(int disks, int start, int stop,
>         ^
>    lib/raid6/neon2.c:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void raid6_neon2_xor_syndrome_real(int disks, int start, int stop,
>    ^
>    static
>    16 warnings generated.
> --
> >> lib/raid6/neon4.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return vshlq_n_u8(v, 1);
>                   ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
>                              ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
>      int8x16_t __ret; \
>                ^
>    lib/raid6/neon4.c:56:6: warning: no previous prototype for function 'raid6_neon4_gen_syndrome_real' [-Wmissing-prototypes]
>    void raid6_neon4_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>         ^
>    lib/raid6/neon4.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void raid6_neon4_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>    ^
>    static
>    lib/raid6/neon4.c:180:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:181:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w21 = vshrq_n_u8(wq1, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:182:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w22 = vshrq_n_u8(wq2, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:183:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w23 = vshrq_n_u8(wq3, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:184:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:185:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w11 = vshlq_n_u8(wq1, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:186:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w12 = vshlq_n_u8(wq2, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:187:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w13 = vshlq_n_u8(wq3, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:201:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:202:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w21 = vshrq_n_u8(wq1, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:203:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w22 = vshrq_n_u8(wq2, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:204:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w23 = vshrq_n_u8(wq3, 5);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:205:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 3);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon4.c:206:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w11 = vshlq_n_u8(wq1, 3);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
> --
> >> lib/raid6/neon8.c:39:9: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return vshlq_n_u8(v, 1);
>                   ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:48:20: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>            return (unative_t)vshrq_n_s8((int8x16_t)v, 7);
>                              ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25303:13: note: expanded from macro 'vshrq_n_s8'
>      int8x16_t __ret; \
>                ^
>    lib/raid6/neon8.c:56:6: warning: no previous prototype for function 'raid6_neon8_gen_syndrome_real' [-Wmissing-prototypes]
>    void raid6_neon8_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>         ^
>    lib/raid6/neon8.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void raid6_neon8_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>    ^
>    static
>    lib/raid6/neon8.c:264:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w20 = vshrq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:265:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w21 = vshrq_n_u8(wq1, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:266:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w22 = vshrq_n_u8(wq2, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:267:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w23 = vshrq_n_u8(wq3, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:268:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w24 = vshrq_n_u8(wq4, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:269:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w25 = vshrq_n_u8(wq5, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:270:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w26 = vshrq_n_u8(wq6, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:271:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w27 = vshrq_n_u8(wq7, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:272:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w10 = vshlq_n_u8(wq0, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:273:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w11 = vshlq_n_u8(wq1, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:274:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w12 = vshlq_n_u8(wq2, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:275:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w13 = vshlq_n_u8(wq3, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:276:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w14 = vshlq_n_u8(wq4, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
>      uint8x16_t __ret; \
>                 ^
>    lib/raid6/neon8.c:277:10: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>                            w15 = vshlq_n_u8(wq5, 4);
>                                  ^
>    /opt/cross/clang-276ca87382/lib/clang/15.0.0/include/arm_neon.h:24823:14: note: expanded from macro 'vshlq_n_u8'
> ..
>
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
