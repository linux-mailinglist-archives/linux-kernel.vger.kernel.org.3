Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6C51970C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbiEDFwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEDFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:52:36 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1AC2AC4A;
        Tue,  3 May 2022 22:48:59 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2445mbVf030072;
        Wed, 4 May 2022 14:48:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2445mbVf030072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651643317;
        bh=T8bp1SyzelhI1qnKYgaU33N5Pbu8tMye3y+kUusTrk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aktyygebmjSrf1hvWY/HreiZuZSSqtZ2m/4fJdfi9L+cLb7J/5XJgODlErc1EKt7e
         r2g2sStBxulTiIKBJ99pcnEtNwf0j2QMqhLavP7zIA1FFniSqpHcxdESIPw1zjSrF0
         rWskx1ZB+8EchIawTIapLCtHpLXTGdX09yCUZSWNJizFNVhri2YYyHgVdLTECGh7v4
         nfs6A44juOrR1Vbw+uL9NFyKeXnTrpf3i1dtGilSb5GOU1OVwK/kK3MhTCKalZDsWl
         bDrOps9u+haZ2qTn2LVxEKcWZT6I7nXoBTnmzdXDMBBIBxTjoyA+MM/iKWuyjLh8YU
         v11SIZ8S1r5ow==
X-Nifty-SrcIP: [209.85.214.171]
Received: by mail-pl1-f171.google.com with SMTP id i1so514521plg.7;
        Tue, 03 May 2022 22:48:37 -0700 (PDT)
X-Gm-Message-State: AOAM5312DjDbC46gOSDuRJHF1Ay7XCTmN8C9wXh3XrAATmqNIdUcnjIK
        xi6E9hiVme3aCafk1Kn+pLFirR4LzsnIXCQZ52I=
X-Google-Smtp-Source: ABdhPJwqUgU9Oyuqdeyikydu2vvX0zUjmYZyugpVPfGYT6J4leSXuYvASG/EtBt0FtsgpIe8ruEaTZENBgL23UDHI1A=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr19953970plh.99.1651643316418; Tue, 03
 May 2022 22:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220501084032.1025918-1-masahiroy@kernel.org>
 <20220501084032.1025918-2-masahiroy@kernel.org> <CAKwvOdkuWSBShjA2uQEYj5Puyn0bJLdK1JE9Y-P+q9uxNk1A5w@mail.gmail.com>
In-Reply-To: <CAKwvOdkuWSBShjA2uQEYj5Puyn0bJLdK1JE9Y-P+q9uxNk1A5w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 4 May 2022 14:47:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS1ZoTufXU4xwHz5BNyAOX698opRnQvfNR8he7+b+j8vQ@mail.gmail.com>
Message-ID: <CAK7LNAS1ZoTufXU4xwHz5BNyAOX698opRnQvfNR8he7+b+j8vQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/26] modpost: use bool type where appropriate
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 6:43 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sun, May 1, 2022 at 1:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > index 96d6b3a16ca2..7ccfcc8899c1 100644
> > --- a/scripts/mod/modpost.h
> > +++ b/scripts/mod/modpost.h
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <stdarg.h>
> > @@ -111,11 +112,10 @@ struct module {
> >         struct module *next;
> >         int gpl_compatible;
> >         struct symbol *unres;
> > -       int from_dump;  /* 1 if module was loaded from *.symvers */
> > -       int is_vmlinux;
> > -       int seen;
> > -       int has_init;
> > -       int has_cleanup;
> > +       bool from_dump;         /* true if module was loaded from *.symvers */
> > +       bool is_vmlinux;
> > +       bool seen;
> > +       bool has_init, has_cleanup;
>
> Consider keeping these on separate lines. Either way:

OK, I will keep them on separate lines.




> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
