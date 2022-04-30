Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81746515E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbiD3O0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiD3O0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:26:52 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD1814BE;
        Sat, 30 Apr 2022 07:23:27 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 23UEMtVo003583;
        Sat, 30 Apr 2022 23:22:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 23UEMtVo003583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651328576;
        bh=Ckw4iP89ZovaYc0nDj+DdgU81G8QQAB4FPZP64CfHi8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2fOAKv3v4aXLwI3K7CujtO63Lx7jb9H85a0K7DOmIUgtf9hxts56xnaDRbjuZ5cP1
         gnetjkmhg2L/DA6DoMAX3oH4JtE8n/JcJe2NdXF3t5vme1xmaVyYu8TvFkeaSw1jZ1
         059Jzbmhpkbmt2hMhMndstCNuqLa4+UeM48CNa6gT9RZQ12QJ4LBxd6UNI7jI2EDQ5
         E0SN7fbXxnipf2ACDELprXW7KtilI+hgc2f6xXwtDTr0mDPE6da/N9mIewVSh0q4jv
         rdbcet34Piz4dXKPCVY6F0Q6F49Afbe5o8Xt63ZE/Neix9ytXGz3zMfefSaDJJZAuN
         /76ygZybz/CNQ==
X-Nifty-SrcIP: [209.85.215.170]
Received: by mail-pg1-f170.google.com with SMTP id 7so4684103pga.12;
        Sat, 30 Apr 2022 07:22:55 -0700 (PDT)
X-Gm-Message-State: AOAM531/GyVMi6OnddxeS9l4xA1INLaXNO0SGPckqPiDHBRYDcxv/eQk
        Nozf3GOixZ/Eo8ZEOIXFofCQLYZ/JIIbsnDEiwc=
X-Google-Smtp-Source: ABdhPJxyAxpOIViOlXQzQBzGNmvqAH9dhAcw/CgLvU6x7li3jTwrdarvZwsB3G8uSNrsC0h2vOY3agEdYMJ5+WVxQbs=
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id
 d12-20020a056a0024cc00b0050d58bf5104mr3917450pfv.36.1651328575184; Sat, 30
 Apr 2022 07:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-8-masahiroy@kernel.org> <CAKwvOd=Q5WK1790WZP7fj=jY8b2+u-rEnF6XC3uObYwTtYp_eA@mail.gmail.com>
In-Reply-To: <CAKwvOd=Q5WK1790WZP7fj=jY8b2+u-rEnF6XC3uObYwTtYp_eA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Apr 2022 23:21:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbcadJqQqhNAOzDBVFNS-kgAACmSGJ69VkY+ew7MFaxg@mail.gmail.com>
Message-ID: <CAK7LNASbcadJqQqhNAOzDBVFNS-kgAACmSGJ69VkY+ew7MFaxg@mail.gmail.com>
Subject: Re: [PATCH 07/27] modpost: import include/linux/list.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 1:30 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Import include/linux/list.h to use convenient list macros in modpost.
> >
> > I dropped kernel-space code such as {WRITE,READ}_ONCE etc. and unneeded
> > macros.
> >
> > I also imported container_of() from include/linux/container_of.h and
> > type definitions from include/linux/types.h.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Ok then, just two small nits about two comments, which may have been
> just copied over from the sources.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >
> >  scripts/mod/list.h | 336 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 336 insertions(+)
> >  create mode 100644 scripts/mod/list.h
> >
> > diff --git a/scripts/mod/list.h b/scripts/mod/list.h
> > new file mode 100644
> > index 000000000000..c87583a71714
> > --- /dev/null
> > +++ b/scripts/mod/list.h
> > @@ -0,0 +1,336 @@
>
> <snip>
>
> > +/**
> > + * list_for_each_entry -       iterate over list of given type
>
> ^ Excessive whitespace after the `-`
>
> > + * @pos:       the type * to use as a loop cursor.
> > + * @head:      the head for your list.
> > + * @member:    the name of the list_head within the struct.
> > + */
> > +#define list_for_each_entry(pos, head, member)                         \
> > +       for (pos = list_first_entry(head, typeof(*pos), member);        \
> > +            !list_entry_is_head(pos, head, member);                    \
> > +            pos = list_next_entry(pos, member))
> > +
> > +/**
> > + * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
>
> ^ This sounds like two sentences and looks like it's missing
> punctuation separating them?
>
> "iterate over list of given type. Safe against removal of list entry"


OK, I will fold your suggestions.

If you have a chance to fix up include/linux/list.h in the same way,
that would be appreciated.

./scripts/checkpatch.pl  -f  include/linux/list.h

might be useful to find out style issues.



-- 
Best Regards
Masahiro Yamada
