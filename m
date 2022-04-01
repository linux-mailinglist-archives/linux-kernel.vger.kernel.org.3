Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227824EE536
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbiDAAVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbiDAAVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:21:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5336E2F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:19:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2587324wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=topTsn3BbDfEubVD1cikcVfyc0RXu7k2rZg0bc7HcHo=;
        b=kvy8iUb1fFHIuiK+XjgqcekL+X6UMxEzYpsrUiZ8Stm1VLlUJIAam6VAhMQAdmAbk6
         bsSEg1aUauNnoglAjYIxKaP44MwOs+4OT4XmY7G2oqXPdj84UhOfYQ5Y08GbxveQbkvz
         4A6Jy7qjdcj50NkLOrU34POwuYAJMBy0IPJa6ro2Gy1LkwjtLESG305tN64Rn9BcXZM1
         amKusHf8M9dHjLnKptYtkvVO3FjH0xMZxBOuCDyPsHJK+2wK/wHwWIPCBVXdEMCTyWXt
         ysi8ByznGhqNnsBdZySNf279wyWen3egCdQgHfElynmekbwZNfLEP9ZqBYZXFpS4AmDy
         xuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=topTsn3BbDfEubVD1cikcVfyc0RXu7k2rZg0bc7HcHo=;
        b=e1bD7ZlVTRjMEDfYWdBuy9JPxnx/y0J9Mjd7TjGo6wKqKBLIBsGDOAJ6oZl9yesR+B
         DkHikcE1PzGtk/NC96sIg66lMxHti0GdhR4d9fwa2EqvI7qbT+flrtaOeDnT4xW3xa6w
         5tmqj9azjb9l8R5dA4kiScr/6QkbhsQOfBUZ9HUSnxlOt3rPL3nZioEDDc8PFYwm3HAr
         uGFxVa2HuTFuG0DSAtLhDQiYytAB4WawUc1bb8gWAgwj61D99o5EVX7p4dqsGRL0CE7H
         wl2YRSv2XXP4mmnOMdbGjRvwrXuy/lXHkWmZQQcEFxPpX5GXQKhU6jo3OEnKmtUxEBZs
         23qw==
X-Gm-Message-State: AOAM532mXnM+0EGRVLK+LqN/MkZgJylpyYcrX8GiEj3d4QeSuUVMB15g
        3f0ZcuMi7FgelpqM95sBSgbI4xCVNtxq6ncCXRAINQ==
X-Google-Smtp-Source: ABdhPJyU3aKfRMYGV4rQcmjJvbX4vx4GEoEzj2qPFt8IMYkbdKqPXLe0iMTVT88ha5fBbWcwRUdML5nEDifkS+vkK+w=
X-Received: by 2002:a05:600c:6004:b0:38c:6c00:4316 with SMTP id
 az4-20020a05600c600400b0038c6c004316mr6700826wmb.6.1648772350645; Thu, 31 Mar
 2022 17:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com> <YkSv1eUfS9MxotOz@marsc.168.1.7>
In-Reply-To: <YkSv1eUfS9MxotOz@marsc.168.1.7>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Apr 2022 08:18:59 +0800
Message-ID: <CABVgOSnP0OXjyX5x=F4L9okDnxUYuhWuf--LZ7fcmVmg2MDmLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
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

On Thu, Mar 31, 2022 at 3:30 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 03/30, David Gow wrote:
> > On Wed, Mar 30, 2022 at 7:23 AM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Enhance the static analysis tools section with a discussion on when to
> > > use each of them.
> > >
> > > This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> > > the previous documentation patch for static analysis tools.
> > >
> > > Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
> > >
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Cc: Julia Lawall <julia.lawall@inria.fr>
> > > ---
> >
> > Thanks: this sort of "when to use which tool" information is really
> > what the testing guide page needs.
> >
> > I'm not familiar enough with these tools that I can really review the
> > details properly, but nothing stands out as obviously wrong to me.
> > I've made a few comments below regardless, but feel free to ignore
> > them if they're not quite right.
> >
> > Acked-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> > >  Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > > index b5e02dd3fd94..91e479045d3a 100644
> > > --- a/Documentation/dev-tools/testing-overview.rst
> > > +++ b/Documentation/dev-tools/testing-overview.rst
> > > @@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
> > >
> > >  Beware, though, that static analysis tools suffer from **false positives**.
> > >  Errors and warns need to be evaluated carefully before attempting to fix them.
> > > +
> > > +When to use Sparse and Smatch
> > > +-----------------------------
> > > +
> > > +Sparse is useful for type checking, detecting places that use ``__user``
> > > +pointers improperly, or finding endianness bugs. Sparse runs much faster than
> > > +Smatch.
> >
> > Given that the __user pointer and endianness stuff is found as a
> > result of Sparse's type checking support, would rewording this as
> > "Sparse does type checking, such as [detecting places...]" or similar
> > be more clear?
>
> Myabe. I tried changing it a little while adding a bit of information from
> https://lwn.net/Articles/689907/
>
> "Sparse does type checking, such as verifying that annotated variables do not
> cause endianness bugs, detecting places that use ``__user`` pointers improperly,
> and analyzing the compatibility of symbol initializers."
>
> Does it sound better?
>

Yeah: that sounds much better to me. Thanks!

> >
> > > +
> > > +Smatch does flow analysis and, if allowed to build the function database, it
> > > +also does cross function analysis. Smatch tries to answer questions like where
> > > +is this buffer allocated? How big is it? Can this index be controlled by the
> > > +user? Is this variable larger than that variable?
> > > +
> > > +It's generally easier to write checks in Smatch than it is to write checks in
> > > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > > +because there is no reason for re-implementing Sparse's check in Smatch.
> >
> > This last sentence isn't totally clear to me. Should this "because" be "so"?
>
> Smatch uses (is shipped with) a modified Sparse implementation which it uses as
> a C parser. Apparently, Sparse does some checkings while parsing the code for
> Smatch so that's why we have some overlapping between the checks made when we
> run Smatch and the ones made when we run Sparse alone.
>
> I didn't dig into the code, but I guess further modifying Sparse to prevent it
> from doing some types of cheks wouldn't add much to Smatch. That last saying
> should've reflected this fact, but it seems to cause confusion without a proper
> context. Reading the sentence back again, I think we could just drop the last
> part:
>
> "Nevertheless, there are some overlaps between Sparse and Smatch checks."
>

Yeah, I do think that makes more sense. I don't think the fact that
some of the checks overlap causes any problems at all, to be honest,
so you _could_ get rid of the whole sentence without losing too much,
but I'm also happy with it as it is in v3.


> >
> > > +
> > > +Strong points of Smatch and Coccinelle
> > > +--------------------------------------
> > > +
> > > +Coccinelle is probably the easiest for writing checks. It works before the
> > > +pre-compiler so it's easier to check for bugs in macros using Coccinelle.
> > > +Coccinelle also writes patches fixes for you which no other tool does.
> > > +
> > > +With Coccinelle you can do a mass conversion from
> >
> > (Maybe start this with "For example," just to make it clear that this
> > paragraph is mostly following on from how useful it is that Coccinelle
> > produces fixes, not just warnings.)
>
> Will do
>
> >
> > > +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> > > +that's really useful. If you just created a Smatch warning and try to push the
> > > +work of converting on to the maintainers they would be annoyed. You'd have to
> > > +argue about each warning if can really overflow or not.
> > > +
> > > +Coccinelle does no analysis of variable values, which is the strong point of
> > > +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> > > +way.
> > > --
> > > 2.35.1
> > >
