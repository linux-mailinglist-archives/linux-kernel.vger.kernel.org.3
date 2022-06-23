Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C875585AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiFWSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiFWR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:58:58 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A9993DB;
        Thu, 23 Jun 2022 10:16:12 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 25NHFruH009674;
        Fri, 24 Jun 2022 02:15:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25NHFruH009674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656004554;
        bh=PFMCdlXbalpZFV18Es/vk2cklPdZH8cwyXNb6XthAtM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PGzfKulegRNZxR2tbL3yTm1lM0mxjmLymAvvDYwdtqaJ1Wlxof/aOiJOgXgvUeSie
         IqeRfm9m4aVrRqmeKraWU1fbwbbiAfMNG3VSPHP8cyzit7eNNDbBPA+PbdL+PAIkyh
         wU6D5X6/u0x4mcMo7ouQN6j1XEVK02wVWjlRzsJDdynSpxdgvGjVMo+XBHyyMh38T9
         7I965GY+H49vFWdFYgV9MeKyftpcrZtv+6dEcqaqKM+yi7Qh0PxrvAIE51r8+LVoNA
         SScyNDkuCWDtzRjQl2KJWnlo44d7lI5SdXhG/ZxBVAUnSPkyE1ibA4PyC4J3d8OmuH
         Ex0oRKe5rZ1Ow==
X-Nifty-SrcIP: [209.85.221.50]
Received: by mail-wr1-f50.google.com with SMTP id v14so28885383wra.5;
        Thu, 23 Jun 2022 10:15:54 -0700 (PDT)
X-Gm-Message-State: AJIora/Qy2Q7QGBhTnB1mllCMCxbAHrH2eqzK8rT2xlPpigcIphZ6og+
        kZd98hqFqVZhd0cKwxt3r7aTCDCtac6OOZ0z+qg=
X-Google-Smtp-Source: AGRyM1u5H7gMkGpAckFdpl8BPR/XeZ+9/LZ/rWTFIyiIiwjHNpr74i/u6/TtqTiQVwJ/IOx+s6IKcIftpmxZRC4G5eY=
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id
 ck18-20020a5d5e92000000b0021a278cb901mr9327218wrb.461.1656004552543; Thu, 23
 Jun 2022 10:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <2817735.mvXUDI8C0e@sakura.myxoz.lan>
 <CAK7LNAQqJc74MGFyU6fvhM9VkDKYUXyCt0NF1qAr1RmfUqC0=w@mail.gmail.com> <2650588.mvXUDI8C0e@sakura.myxoz.lan>
In-Reply-To: <2650588.mvXUDI8C0e@sakura.myxoz.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Jun 2022 02:15:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_4QUfBxRu2HpPS99Ay7JTcqFTHsrBmrPk+d8So5tjOQ@mail.gmail.com>
Message-ID: <CAK7LNAQ_4QUfBxRu2HpPS99Ay7JTcqFTHsrBmrPk+d8So5tjOQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 2:00 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
>
> On Thursday, 23 June 2022 17:44:57 CEST Masahiro Yamada wrote:
> > On Fri, Jun 24, 2022 at 12:42 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
> > > On Wednesday, 22 June 2022 03:57:34 CEST Masahiro Yamada wrote:
> > > > If you want to say "use this option carefully",
> > > > EXPERT might be another option.
> > > >
> > > >     depends on ARC || EXPERT
> > >
> > > Yeah, this would be a fair compromise, though I think it would be
> > > better to use "visible if" instead of "depends on". I can get a v2 of
> > > the series together if this is desired.
> >
> > Why is "visible if" better than "depends on"?
> >
>
> Technically it most likely doesn't matter, but logically it makes more
> sense, since we'd make CC_OPTIMIZE_FOR_PERFORMANCE_O3 be visible if
> we're on ARC or if we have EXPERT enabled, instead of depending on
> them. But yeah, it probably doesn't matter.


Did you write and test the code?


"visible if" is only supported for "menu".
This is clearly documented at line 207
of Documentation/kbuild/kconfig-language.rst


Using "visible if" for config entry will just
result in the syntax error.





> --
> ~miko
>
>
>


--
Best Regards
Masahiro Yamada
