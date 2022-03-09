Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932634D2738
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiCICSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiCICSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:18:51 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DBB12A99;
        Tue,  8 Mar 2022 18:17:41 -0800 (PST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2292HRcQ025536;
        Wed, 9 Mar 2022 11:17:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2292HRcQ025536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646792247;
        bh=yrz8MJgeMKuvnz33SMeYLZ7Cine73+llQkRSU7j3OeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QdLV+YuJnE3AuI25L44qDcEFha7V2tJikwuAbHrYtTptepmqS8wiUbtBjtqUKfiAe
         GrVcq0Nf1zqBNYDN27k7DKPnorO++0pTgwRsKM/FmO+CaVio1dVjjmRHjNh7nvdN12
         mnq8a/cyE3WVGk8FBI3Js7IexJIJXuXDmwovsVnUovEf7ioR8AbYSywB/qFq1Cly01
         cLWX0DcMiW6S9JNVwcNjC5r7LbbjKr9K8LGSQJPy/07z/ZATjmEjMCk0Cd/RwvjwhZ
         w/j0JU9CtFQ1+eQpoaJt6iY4/UdfEYRQ5jGuAiwMPNLt97UzDe1YtJpEAyhtL4FNAx
         ZJAQuF3XM469w==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso3948310pjb.0;
        Tue, 08 Mar 2022 18:17:27 -0800 (PST)
X-Gm-Message-State: AOAM532cCXb1Lapn2tEZkEfzwpTyWd29qv3iaHi6klddHoAzQD3TQ7fa
        4u6egYTHGbd8TGeN7LysFrpEoNM8HdQO+30SNrw=
X-Google-Smtp-Source: ABdhPJyMpYSk5zXrKpcgek+899vxIgkJpkfAkc4Uc5APGsnHYk6hCj+dOoi9kSCk2xTpgtEh31/JWnYw2PXFOhrKljg=
X-Received: by 2002:a17:902:eb84:b0:151:f80e:e98b with SMTP id
 q4-20020a170902eb8400b00151f80ee98bmr9234067plg.99.1646792246518; Tue, 08 Mar
 2022 18:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20220308215615.14183-1-arnd@kernel.org> <CAHk-=wjsCrVxToP0Zx+cUAVZmSKi=Y6NP1+VnBcoPyPPEBfonQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsCrVxToP0Zx+cUAVZmSKi=Y6NP1+VnBcoPyPPEBfonQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Mar 2022 11:16:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQoFFVLfkhA7FC9vDbvc4wdLginYeRHL0xHVAumu6p=uw@mail.gmail.com>
Message-ID: <CAK7LNAQoFFVLfkhA7FC9vDbvc4wdLginYeRHL0xHVAumu6p=uw@mail.gmail.com>
Subject: Re: [PATCH 0/4] [v4] Kbuild: std=gnu11 changes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Alex Shi <alexs@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 9:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 8, 2022 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I've incorporated the feedback from Masahiro Yamada in this
> > version, splitting out one more patch, rebasing on top of
> > the kbuild tree, and changing the order of the patches.
> >
> > Please apply to the kbuild tree.
>
> I'd actually like to see this as a separate branch, so that I can
> merge it early - or other peoples git branches end up depending on it.


OK, I can apply this to a separate branch, kbuild-gnu11.
(and I will queue this up shortly because it is already -rc7)

Then, I will send two pull reqs in the next MW,
but please note they will conflict with each other,
between this gnu11 patch set and the following
one in my usual kbuild branch:

https://patchwork.kernel.org/project/linux-kbuild/patch/20220201213542.2808035-1-quic_eberman@quicinc.com/


I hope this is not a complex conflict, but please let me know
if you have any requests to me.





> Yeah, it shouldn't change anything on its own, but since it allows for
> new syntax, we might have other things depending on it (I'm obviously
> thinking of the list_for_each_entry() series that keeps getting
> posted).
>
>                       Linus



-- 
Best Regards
Masahiro Yamada
