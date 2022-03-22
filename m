Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F84E39FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiCVIAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCVIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:00:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764B2AE0B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:59:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u3so22970711ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stargateuniverse.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8xEWsgco5xTqJ0ks3d+Mzi8OyfjypHWj0+7G0BsF+HE=;
        b=RcY6h3mx/Oiq9hXIF+jzlZP2T94Xcu8vhlN9Damzp7Ee4Qd8xyVUHcd7yFq2ZudPEK
         JUCFHsjWjt1Ndg8eDhqCqrX9lZXY0cxns0YIeNgOn7SaxLfp+2pU/DWA7IiynDdV8cfu
         NBus//E2qVIWmf2BcVduaGHSF3qGo4BIXbL3e17FwIAIxZsAvAz4kbJjAyPEAzhfHf1o
         86YA2nuQ6eIQHVDMfV/erJx4ir6PqEKjvp65921+t3Ylwes6m2JcjHo3zl9+50kNAFfp
         +lGrSu1Fo8JCOaghBcFPRBEAKiP0d1efCMkd9Dq4vI0dT4sT0qpryr8AYokwbbnGvKwb
         UxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8xEWsgco5xTqJ0ks3d+Mzi8OyfjypHWj0+7G0BsF+HE=;
        b=DPyqHAR2a9NTl3HC4VPOTk8VM91YpL8V1fR/EwRF/tZJYES57R9M/e2YrcNLMMB0sz
         zgJHDPRHSLR8xHfWReWOZgvD7DA+uL7y4Y7BC5jFWZRk9EwLv6mqKAqKTfR74ZVuq5/6
         92BmQf4OoghZolmtyk+ZBeY6DSZ/u14EoUDLhtGrkFxfGZcD8O9LyKBVSizLJmkNRGOX
         HzLhiTrk6CTyluhQROdkm44VWy4/ea2VtTjA/eDUjY5ZViNDrQaMV6jTrEfD94TSgb9D
         07NbmiHpFqUuVNVl5F9aRqbmnirluXjtskxtyVeAED81ivRdtVABUEKSphhAV2QR0tgK
         O0xg==
X-Gm-Message-State: AOAM531fIuuT8Lxfcf9kgCaDHj1CB6ZRsbPcJjW3SJixsnG4Lz3nKZbj
        JLtMFYsMZjlVwS1p7dw7Je9GVpoxu3Da0K6DeIuhOg==
X-Google-Smtp-Source: ABdhPJzWGaANaNeJQX7Zsg97tvJK53H6U6xjPAFYN3ZyHLkntIv2GqdVBpLfRR1rpfwz8VgSsr16wfjgfF5qpCDHAhk=
X-Received: by 2002:a2e:6808:0:b0:249:1738:5cd0 with SMTP id
 c8-20020a2e6808000000b0024917385cd0mr17779972lja.174.1647935957041; Tue, 22
 Mar 2022 00:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <YjBr10JXLGHfEFfi@gmail.com>
In-Reply-To: <YjBr10JXLGHfEFfi@gmail.com>
From:   Kari Argillander <kari.argillander@stargateuniverse.net>
Date:   Tue, 22 Mar 2022 09:59:06 +0200
Message-ID: <CAKBF=pvWzuPx0JB3XZ-v+i7KGbhMQTgH6xtii_Bed+qKRFx+ww@mail.gmail.com>
Subject: Re: [TREE] "Fast Kernel Headers" Tree -v3
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kari.argillander@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.3.2022 12.35 Ingo Molnar (mingo@kernel.org) wrote:
>
> This is -v3 of the "Fast Kernel Headers" tree, which is an ongoing rework
> of the Linux kernel's header hierarchy & header dependencies, with the du=
al
> goals of:
>
>  - speeding up the kernel build (both absolute and incremental build time=
s)
>
>  - decoupling subsystem type & API definitions from each other
>
> The fast-headers tree consists of over 25 sub-trees internally, spanning
> over 2,300 commits, which can be found at:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master

I have had problems to build master branch (defconfig) with gcc9
    gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

I did also test v2 and problems where there too. I have no problem with gcc=
10 or
Clang11. Error I get is:

In file included from ./include/linux/rcuwait_api.h:7,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/irq_work.h:7,
                 from ./include/linux/perf_event_types.h:44,
                 from ./include/linux/perf_event_api.h:17,
                 from arch/x86/kernel/kprobes/opt.c:8:
./include/linux/rcuwait_api.h: In function =E2=80=98rcuwait_active=E2=80=99=
:
./include/linux/rcupdate.h:328:9: error: dereferencing pointer to
incomplete type =E2=80=98struct task_struct=E2=80=99
  328 |  typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
      |         ^
./include/linux/rcupdate.h:439:31: note: in expansion of macro
=E2=80=98__rcu_access_pointer=E2=80=99
  439 | #define rcu_access_pointer(p) __rcu_access_pointer((p),
__UNIQUE_ID(rcu), __rcu)
      |                               ^~~~~~~~~~~~~~~~~~~~
./include/linux/rcuwait_api.h:15:11: note: in expansion of macro
=E2=80=98rcu_access_pointer=E2=80=99
   15 |  return !!rcu_access_pointer(w->task);

    Argillander

> There's various changes in -v3, and it's now ported to the latest kernel
> (v5.17-rc8).
>
> Diffstat difference:
>
>  -v2: 25332 files changed, 178498 insertions(+), 74790 deletions(-)
>  -v3: 25513 files changed, 180947 insertions(+), 74572 deletions(-)
>
> Thanks,
>
>         Ingo
