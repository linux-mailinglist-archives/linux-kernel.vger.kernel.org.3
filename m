Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB759A985
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiHSXdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiHSXdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:33:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658D25C9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:33:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so2302433lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y7BwhUziN7Shv1IDBl73QA6DiHDSzdgJ+ZuTLbMJXkA=;
        b=Ns54S2g0WBfzfkVQ7/nUOVRNeJaY6npkvHh5zPjpWOZ2JmKtTcTlturtO5zz/h6fyr
         e354YBuRd+kKsyTy14dJMoQYiD7ll25eIDfcdKLDeq82K7bGN+x/BXRWG4FsL0yhHHkj
         r+WE5mJQpLd9OcYg5Em0yjmJffK7BiDgDa5hiTS+XWT2Qso4P44deem8MyK77H7dTM4c
         r0mb92hdAoDu2oX0yWLCx5/ad3Gg9yHQ2rL0wm24k0guhLoRORzYID1pD3RAZ3hU6mDT
         ycg3m2U0UaA1iJN1rSSwPbjiarcDqYbxCY8/OjcHd2dqsUJSi/6oyQTwuEbg4NXcBzl3
         LCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y7BwhUziN7Shv1IDBl73QA6DiHDSzdgJ+ZuTLbMJXkA=;
        b=TLu2X0nLKYudgWqEPuHKvenejXaMp9C5q1NOceRT6G3oQk9iyYwUANXvsCvg+ixaNy
         hloZF/IMZQTJavyhU1AUWS2zfApreKhwEhtDcFJfLokAenLJxcJGYOhwiRA+iyhSv3HP
         rSqrHB8u5uCjNCdsEIXgt/QU7ePFUghiQraAuwIK90I1idJJTMzRrIZZ9yhpo5MJmi9R
         FNRWy+L4+eFwfDWdl1ipsmBE8E6ULkrbjOyi+/K/gyQDckyBQ5qWI2E0dWTQB+ZUrTm1
         Bj5Btw6AzZdjCR1aoOfs/k2VQVR+JdQgbzL38yIu5gg3vffxQoqBqzxcfnK3Y3Wcys61
         /cHg==
X-Gm-Message-State: ACgBeo3txPCwY3Re8krWbXng4RfCk8BNlAXwKevxSO2X6Kms1CdrzrID
        IPAuNsALmhFMJCcvdz7Twnaag1A3UCvN7CeUv8PuzA==
X-Google-Smtp-Source: AA6agR6S8k2SWNo73q0AqnEABg/vA4UxgEFYZMPy3fg9+zE7sPqCQNmlirz1q5SseKIFDBSMz2y0P8IyMhiFebJK3UM=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr3463711lfr.647.1660951992444; Fri, 19
 Aug 2022 16:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220716081736epcas2p346100e67cf44b1dbb79f6e2a4ab07dbf@epcas2p3.samsung.com>
 <20220716084532.2324050-1-youngmin.nam@samsung.com> <CAK7LNAR3YGoQU6ZTZmC84C1OoH0rPinjoyPDXCD0BDPoRS4NDA@mail.gmail.com>
In-Reply-To: <CAK7LNAR3YGoQU6ZTZmC84C1OoH0rPinjoyPDXCD0BDPoRS4NDA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Aug 2022 16:33:00 -0700
Message-ID: <CAKwvOd=FBDqutQ-6De577GDje=YR32GxDbkgcGeP9J=2Lb3CqQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: add -Wformat-insufficient-args for
 clang build
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Youngmin Nam <youngmin.nam@samsung.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hosung0.kim@samsung.com, d7271.choe@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 9:22 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Jul 16, 2022 at 5:17 PM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > The -Wformat-insufficient-args for clang is useful to detect the situation
> > when the total number is unmatched between format specifiers and arguments.
> >
> > Originally, this option is enabled by default(Link[1]), but it is disabled by
> > -Wno-format explicitly so that we can't detect this unmatched situation.
> >
> > We can enable it by adding this option after -Wno-format.
> >
> > Link[1]: https://releases.llvm.org/13.0.0/tools/clang/docs/DiagnosticsReference.html#wformat-insufficient-args
> > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > ---
>
>
> Please let me hold on this patch because
> I'd rather go straight to the removal of  -Wno-format.
>
> https://lore.kernel.org/linux-kbuild/CAFhGd8pk+0XEz0tMiJcwMM7B3NYF=yF4cHW8A-6-81SgpKFPNw@mail.gmail.com/T/#m4becf6ed91f25217b59a840ed1829f36e49fe347

Let's see what the feedback on
https://reviews.llvm.org/D132266 is. If it lands, I will send a series
with this patch first, then wrap it in the else clause of a
conditional like: if clang version >= 16 then enable -Wformat else
enable -Wformat-insufficient-args.

>
>
>
> >  scripts/Makefile.extrawarn | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index f5f0d6f09053..c23d7c286bad 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -48,6 +48,7 @@ else
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CFLAGS += -Wno-initializer-overrides
> >  KBUILD_CFLAGS += -Wno-format
> > +KBUILD_CFLAGS += -Wformat-insufficient-args
> >  KBUILD_CFLAGS += -Wno-sign-compare
> >  KBUILD_CFLAGS += -Wno-format-zero-length
> >  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
> > --
> > 2.34.0
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Thanks,
~Nick Desaulniers
