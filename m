Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5765453FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbiFIST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiFISTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:19:52 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F784AE06;
        Thu,  9 Jun 2022 11:19:49 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 259IJRIT004743;
        Fri, 10 Jun 2022 03:19:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 259IJRIT004743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654798769;
        bh=fcsfs2qoDl2ZO8fQQcwgnKeipVZccVxwxhSME/g7iys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LjOl2745KlAOJiiN0tYiYPmzVxSeNpDtGIIpcdHpTC60dGeTSPB4C5RJs2Yt1JpKR
         liIVtq2xOCRq5coPf6xO0nRWs0MsCFtwvvDgV+GZ1I6LwzvPI0Yf2sSAnPw2LbbGVT
         /aY7xpdInXhU4wcskA1UEpsMGxFjoy8/WqaXfxDFnfCp2oXWixi9FYmtL2pAQMsfoL
         BjCa5t7oyBDWIpqQGDrD/mdj82kzi+cz7B+gzXMgK/A4jpV0YFnlp+0+QSX+mfXOO6
         qyrPvKUJZqj074pmQCHkQ4oklINwYw4vTK+oCIhUfCmcOP1jOu5foVncndVldtrU+N
         kAdw2CRVozoBA==
X-Nifty-SrcIP: [209.85.128.47]
Received: by mail-wm1-f47.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so25958wms.5;
        Thu, 09 Jun 2022 11:19:28 -0700 (PDT)
X-Gm-Message-State: AOAM533NtNx1zfBlll1/CpRRAYNUobzMwD0mlEiL9rA2+Nx0riPVH1ny
        zL9xGg/fxSSIA6NghEueCCmmpCz2JW5WuZakIJg=
X-Google-Smtp-Source: ABdhPJxYKL/6QBVHu2cEepuTWiW+yV2L980p4ZI5s1s4uuEZn2aFWuTs7EjC0VmIgiBrb5TNOlXTtQayJM2MPp6P6+4=
X-Received: by 2002:a7b:ce04:0:b0:394:1f46:213 with SMTP id
 m4-20020a7bce04000000b003941f460213mr4570297wmc.157.1654798767012; Thu, 09
 Jun 2022 11:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
 <486b1b80-9932-aab6-138d-434c541c934a@digikod.net>
In-Reply-To: <486b1b80-9932-aab6-138d-434c541c934a@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jun 2022 03:18:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9R3OXzZXUWywR5EJf6n9tRp3QeJuo7UsS3pfDTzOvig@mail.gmail.com>
Message-ID: <CAK7LNAR9R3OXzZXUWywR5EJf6n9tRp3QeJuo7UsS3pfDTzOvig@mail.gmail.com>
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:05 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
> On 06/06/2022 14:31, David Howells wrote:
> > There's a rule in certs/Makefile for which the command begins with eigh=
t
> > spaces.  This results in:
> >
> >       ../certs/Makefile:21: FORCE prerequisite is missing
> >       ../certs/Makefile:21: *** missing separator.  Stop.
> >
> > Fix this by turning the spaces into a tab.
>
> These spaces were not part of my patch but they are indeed in this file
> now: https://lore.kernel.org/r/20210712170313.884724-3-mic@digikod.net
>
> Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>


Indeed, you used a tab,
but the applied code (commit addf466389d9) uses 8 spaces.

I think something bad happened
when the committer locally modified the code.






--
Best Regards
Masahiro Yamada
