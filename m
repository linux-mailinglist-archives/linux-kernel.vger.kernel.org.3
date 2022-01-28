Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7D4A014C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbiA1UCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbiA1UCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:02:00 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909DBC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:02:00 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w133so14375876oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KPQs4BICnK1jcv7Ue8a1i7g7BfJfHr1ekNmdCInY0w=;
        b=l4flimN6Rgf2/XPpkMw15pfJ9RHpjcAibkUIjUJN7f5ACxUodXF5fhtEiLq25oN2nQ
         Ig0/aMHr46/+8YDNpR6y5kh/KWNZZGwl1/RlBB4a7jd41u9I8t4acBrM1vP/w+FGwjuO
         Z1JOz+F9UXZk2roXWX6TIZbw4aK+a1s25EbraaIMhdci7VexsfqRMupQ7nIlFtASA/sh
         /RemWindYWXe6KXXrV+wzRWDOv4L7GiyOql4NLTmLnT2GTsuJyBlFPQbINI742iYYadJ
         vwJ+Iq2U9y6g/xgFXqsycHnHfckiim44vVngighjOBQ14AImYd2odulSZR/M5aQ7ExGg
         Gl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KPQs4BICnK1jcv7Ue8a1i7g7BfJfHr1ekNmdCInY0w=;
        b=bOKlWv5ysewKrRgAvoJ1+xfV8j2b8YZ/2fIX64d4xoA8l3LyRQX6ifQNWEzdmb071l
         zyPj921zAa2AXTDqcduwVriLTAQhtehM6kDQg9RYPPCCdR39evbNTItRwPaOetz3h8uj
         KyDOIV57axoTmc50c9lMiABnCHUk9l1ZcAf8SZNX6yC1El9/Ng80NrU+dWTmYieLe0Em
         6GJMRG4qXwM56ILzxzLesJiVwU4C/i1AMxIlPR9/86su3G2ipHI7CRqPaL3IDTXlNNbd
         /FMcK86cQiE6c8eljxmfNDhQO6YugpN9toLNYcIMLhB76TYFw3WN843wUbRF2WzwPa+u
         azog==
X-Gm-Message-State: AOAM530h9XItuP3HYNHm0YcMAZgeJcaUCxJhU9K/3gqnqGE+hNdmbCgV
        PySKP7wpC2AVNp3PUdxgAD9ap7b+t8TuabKwy8c=
X-Google-Smtp-Source: ABdhPJx/8io+fNHpd9HG9+lbXQhrPgksb6Db7eIuis71AlCHi6W2DtR5mNQ1TzmEz/J12C/wch/XwvvMxMRDXFQAVwE=
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr11252433oib.93.1643400119936;
 Fri, 28 Jan 2022 12:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20220124165856.57022-1-zhou1615@umn.edu> <YfPC3N+H9Fu/gqpz@kroah.com>
 <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
 <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com> <CACO55tt4P+beifvS=jcDsfwybFynngc8DHLR0n3BseeDJNrHyw@mail.gmail.com>
In-Reply-To: <CACO55tt4P+beifvS=jcDsfwybFynngc8DHLR0n3BseeDJNrHyw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Jan 2022 15:01:48 -0500
Message-ID: <CADnq5_MnXG6-jzVZ7sXQjd8zeBKYPimFYOiR=M8=pB02fAxDzA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in nvkm_acr_hsfw_load_bl()
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:58 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Fri, Jan 28, 2022 at 8:54 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
> > >
> > > Sigh-thank you for catching this - I had totally forgot about the umn.edu ban.
> > > I pushed this already but I will go ahead and send a revert for this patch.
> > > Will cc you on it as well.
> >
> > This seems short-sighted.  If the patch is valid I see no reason to
> > not accept it.  I'm not trying to downplay the mess umn got into, but
> > as long as the patch is well scrutinized and fixes a valid issue, it
> > should be applied rather than leaving potential bugs in place.
> >
> > Alex
> >
>
> Even though knowing that malicious code can be introduced via
> perfectly fine looking patches, and sometimes one will never spot the
> problem, this patch isn't all that bad tbh.
>
> So should we reject patches out of "policies" or should we just be
> extra careful? But not addressing the concerns as Greg pointed out is
> also kind of a bad move, but also not knowing what the state of
> resolving this mess is anyway.

I think if the umn mess taught us anything, it's the need for more
careful scrutiny.  But I certainly don't have the time to retype every
valid patch if it comes from a umn source.  There are also ethical
implications to that as well.  You didn't actually write the patch.

Alex

>
> >
> > >
> > > On Fri, 2022-01-28 at 11:18 +0100, Greg KH wrote:
> > > > On Tue, Jan 25, 2022 at 12:58:55AM +0800, Zhou Qingyang wrote:
> > > > > In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
> > > > > passed to memcpy(), which could lead to undefined behavior on failure
> > > > > of kmalloc().
> > > > >
> > > > > Fix this bug by using kmemdup() instead of kmalloc()+memcpy().
> > > > >
> > > > > This bug was found by a static analyzer.
> > > > >
> > > > > Builds with 'make allyesconfig' show no new warnings,
> > > > > and our static analyzer no longer warns about this code.
> > > > >
> > > > > Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace
> > > > > "secure boot"")
> > > > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > > > ---
> > > > > The analysis employs differential checking to identify inconsistent
> > > > > security operations (e.g., checks or kfrees) between two code paths
> > > > > and confirms that the inconsistent operations are not recovered in the
> > > > > current function or the callers, so they constitute bugs.
> > > > >
> > > > > Note that, as a bug found by static analysis, it can be a false
> > > > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > > > the bug.
> > > > >
> > > > >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
> > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > > index 667fa016496e..a6ea89a5d51a 100644
> > > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > > @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const
> > > > > char *name, int ver,
> > > > >
> > > > >         hsfw->imem_size = desc->code_size;
> > > > >         hsfw->imem_tag = desc->start_tag;
> > > > > -       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> > > > > -       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> > > > > -
> > > > > +       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> > > > > GFP_KERNEL);
> > > > >         nvkm_firmware_put(fw);
> > > > > -       return 0;
> > > > > +       if (!hsfw->imem)
> > > > > +               return -ENOMEM;
> > > > > +       else
> > > > > +               return 0;
> > > > >  }
> > > > >
> > > > >  int
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > As stated before, umn.edu is still not allowed to contribute to the
> > > > Linux kernel.  Please work with your administration to resolve this
> > > > issue.
> > > >
> > >
> > > --
> > > Cheers,
> > >  Lyude Paul (she/her)
> > >  Software Engineer at Red Hat
> > >
> >
>
