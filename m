Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886124CE589
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiCEPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 10:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiCEPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 10:31:41 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D0229CAA;
        Sat,  5 Mar 2022 07:30:50 -0800 (PST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 225FUbpw005976;
        Sun, 6 Mar 2022 00:30:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 225FUbpw005976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646494238;
        bh=YsXmMDnzP2QV2OZWk2RMV7uW5hpJkgm10xK1lFneifg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+2MGq6eak/H4/O5haArec0peEc3O/L4BRi/GUHC4e/an+5GLBARhjuR16l4I/Z/f
         vB1F/tVPKaKtHYi5qxxgh3v4MrIc/8eFUo0LC1vUpapvj/Bu2hSxcAcnVP/k6O+Pc2
         oHVoD0Z8nny/xHcI8+TEZp1X1lDJvD7LjhQutCCUz1+3b6h0DvpZf2hpr/kHOW9pRA
         2iHZAok2P5LSShz/rw1wRf1O2tR02IOTY68qIucnJ1QWsU7wCdz8n6AimlxG21GB9l
         je1NG6uQWObcjioyJahwKFNdLrQlbC5/1+g6RIz+A0qVwmWRD8bbY83+zD1rRtN3QL
         vUD9/d9av/UqA==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id z4so9947397pgh.12;
        Sat, 05 Mar 2022 07:30:38 -0800 (PST)
X-Gm-Message-State: AOAM5339dD8pPoqguPq6xHrO0+GHJZo9dkNPwXFihC6Zqu1CPaHYl5M4
        upTQXtdGtYnAr93APrPFKMfVbJrhN23b76irF5Y=
X-Google-Smtp-Source: ABdhPJx0u9LSOAf+oXrCA4QHWPtRWFjUN0G77UHdiuLqLXjiTzDlEl22WVJRIiGKDDsFe3MjYAOay8OUZpjtqjwfqMo=
X-Received: by 2002:a05:6a00:c90:b0:4bd:22a:bb1d with SMTP id
 a16-20020a056a000c9000b004bd022abb1dmr4158681pfv.32.1646494237396; Sat, 05
 Mar 2022 07:30:37 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdkd3vHMRNAJABho7Ok9HOofBZKeXTzjW0ZZku_+5GvtYQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkd3vHMRNAJABho7Ok9HOofBZKeXTzjW0ZZku_+5GvtYQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Mar 2022 00:29:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARJcPLT-OW20OE4+-c_B3azQRWoPPApqXSpBH5Pjdhq6g@mail.gmail.com>
Message-ID: <CAK7LNARJcPLT-OW20OE4+-c_B3azQRWoPPApqXSpBH5Pjdhq6g@mail.gmail.com>
Subject: Re: UAPI_HEADER_TEST and CC_CAN_LINK dependency
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev, Elliot Berman <quic_eberman@quicinc.com>,
        Elliot Berman <eberman@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Trilok Soni <tsoni@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 4:49 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Hello Masahiro,
>
> We'd like to be able to better test UAPI headers via
> CONFIG_UAPI_HEAD_TEST=y with clang builds during cross compiling.

I missed to add the target triple to usr/include/Makefile.
You might have thought you were cross-compiling the headers, but actually not.


Let me fix this first.
https://patchwork.kernel.org/project/linux-kbuild/patch/20220305125605.149913-1-masahiroy@kernel.org/




> We're finding that CC_CAN_LINK=y is not enabled because clang (unlike
> gcc) isn't configured with a cross libc in hand, and one may not be
> available in the environment. This is a similar constraint to the
> prebuilt GCC images distributed on kernel.org.
>
> Looking at
> commit d6fc9fcbaa65 ("kbuild: compile-test exported headers to ensure
> they are self-contained")
>
> Simply removing the dependency on CC_CAN_LINK=y allows us to run the
> UAPI header tests, which pass on ARCH=arm64 and native x86_64 builds.
> https://android-review.googlesource.com/c/kernel/common/+/1991156


Is it the right thing to cross-compile "#include <stdio.h>"
by using /usr/include/stdio.h ?


[with libc6-dev-arm64-cross package]

masahiro@grover:~/workspace$ clang --target=aarch64-linux-gnu  -c -o
test.o -Wp,-MD,\tmp.mk  test.c && grep stdio.h tmp.mk
  /usr/bin/../lib/gcc-cross/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/include/stdio.h
\

[without libc6-dev-arm64-cross package]

masahiro@grover:~/workspace$ clang --target=aarch64-linux-gnu  -c -o
test.o -Wp,-MD,\tmp.mk  test.c && grep stdio.h tmp.mk
test.o: test.c /usr/include/stdio.h /usr/include/bits/libc-header-start.h \


The header search path is like this:
 /usr/lib/llvm-13/lib/clang/13.0.0/include
 /usr/local/include
 /usr/bin/../lib/gcc-cross/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/include
 /usr/include


Even if the aarch64 libc is not installed,
you can cross-compile it because
clang finds stdio.h in /usr/include/.

Using the host's system headers for cross-compilation
looks wrong to me.



> I assume there may be some additional constraints perhaps for other
> architectures or certain configs?

No, I do not think so.
This is common for all architectures.


> Another suggestion from the bionic maintainer to ensure the tests are
> more hermetic/self-contained would be to add -ffreestanding to the
> compiler invocations of these tests.

I do not think so.

UAPI headers are part of hosted environments.
-ffreestanding does not make sense.



> Do you have thoughts on how we might be able to eliminate the
> dependency on CC_CAN_LINK for UAPI_HEADER_TEST? Otherwise, I suspect
> we will have to use `USERCFLAGS=--sysroot=/path/to/sysroot` to make
> CC_CAN_LINK work for clang cross compilation. See also:
> commit f67695c9962e ("kbuild: Add environment variables for userprogs flags")


If you want to use libc installed in a non-standard path,
yes, you can use --sysroot.

On debian or ubuntu for example, it is unneeded.
With "sudo apt install gcc-aarch64-linux-gnu", you can
enable CC_CAN_LINIK for clang without using --sysroot.


-- 
Best Regards
Masahiro Yamada
