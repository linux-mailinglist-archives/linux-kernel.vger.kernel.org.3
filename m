Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE6C53E9FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiFFLWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiFFLWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:22:01 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A21DC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:22:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 68so2141168qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTsthcJVQmhF7Xm+0URj3QnPKdLx/8RaDMYR7w133tE=;
        b=ZOewfqDrRLi/wwwz9ymLuAwvXjjYy53E3ClhFkvNdW+qY5vw0HCyp+up9VCzwFAaYC
         TMZMyPxvNTz3csXNIdbs8rsyOHKUCVlnSamtOkI5F6E+zyV50wpCEXQvwX3Vchoobyi7
         oEFLlmugJIZbBqnAwFBO6Jj70E2UYEMPY4tyZ6RIl1lE7paHygqQJIl3SXwoKeKrBZYA
         jB8JdfEshy0LTf9aQq+lrbp36yS2ywNM6/WARXiQodcjG0/HrurVUVIChqTOmFDB6oPq
         1W/cgapZ8twK+qTRv/lhZly7yjV0TCgOfRUkFeaWIQg0kk3I6VDhSs8SX5kgj8n9OUBC
         fFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTsthcJVQmhF7Xm+0URj3QnPKdLx/8RaDMYR7w133tE=;
        b=O9Tv6rlE+YCxHHwYLkNnU+0bMUEKoEQl+noq1wVN3mftuDLAFbhJvG0W+0zOF6FgFW
         3xdVsFZdT3IzoANow0Aj0Sp68tggsUSHrN2IsJRB6Rg3WBxfvGn69Cn47WzwPjXnNRF2
         XOrh1py4uJo9C4mc4hTmiybWVHlCscfmzpVDAgjsVHdwOAEp9Z+P2EzHN/ks9Ew4F8Lh
         SZ/rMEnk2EEmMGUJlBlIvITNLwFYeGVL4Q2WpeX9zfJCz6g7zVBe5YpCBKYeRh44JCDP
         wd3nhdvKjerFx7zdmcuE/AtqJedJIysg9zNPzealIaPkZcj+f8MULqTaHVpTGM0VcjsB
         FVXQ==
X-Gm-Message-State: AOAM531HmZ5r4CmLKVUDLodJ/4tK5L1Cb+gEQxrnWk7aBIOhGqDLZ3a5
        SdDwJ1tUQqoIVTUFrHGiBAkqY7PBLV1MvETRKRg=
X-Google-Smtp-Source: ABdhPJzzrtziPOS1KJw58ikyVeRSCTJtL+zJfPSfWpi98XNxg9V5/7ZCr1rZWPNC30U++ZWvtfSeh1uxvMfo6LMcU18=
X-Received: by 2002:a05:620a:4310:b0:67b:3fc1:86eb with SMTP id
 u16-20020a05620a431000b0067b3fc186ebmr14966019qko.495.1654514519340; Mon, 06
 Jun 2022 04:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220605154731.17362-1-roman.o.stratiienko@globallogic.com>
 <4714286.GXAFRqVoOG@jernej-laptop> <CAGphcdniPFdqgLcpUc88ak9GzNaCvmj_TDVYTOe2bXto-Y12FQ@mail.gmail.com>
 <20220606092006.4bgxibmayv44juox@houat> <20220606092225.yxyw77mtuqpbmd35@houat>
In-Reply-To: <20220606092225.yxyw77mtuqpbmd35@houat>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Mon, 6 Jun 2022 14:21:48 +0300
Message-ID: <CAGphcdmFyK0023cW=UuUWCzqXtkMNBF4t+9CGR13ULaWseJVaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: sun8i: Add support for pixel blend mode property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        wens@csie.org, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz,
        Roman Stratiienko <roman.o.stratiienko@globallogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

=D0=BF=D0=BD, 6 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 12:22, Maxime Ripar=
d <maxime@cerno.tech>:
>
> On Mon, Jun 06, 2022 at 11:20:06AM +0200, Maxime Ripard wrote:
> > On Mon, Jun 06, 2022 at 11:17:20AM +0300, Roman Stratiienko wrote:
> > > Hello Jernej,
> > >
> > > Thank you for having a look.
> > >
> > > =D0=B2=D1=81, 5 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 23:37, Jernej=
 =C5=A0krabec <jernej.skrabec@gmail.com>:
> > > >
> > > > Dne nedelja, 05. junij 2022 ob 17:47:31 CEST je Roman Stratiienko n=
apisal(a):
> > > > > Allwinner DE2 and DE3 hardware support 3 pixel blend modes:
> > > > > "None", "Pre-multiplied", "Coverage"
> > > > >
> > > > > Add the blend mode property and route it to the appropriate regis=
ters.
> > > > >
> > > > > Note:
> > > > > "force_premulti" parameter was added to handle multi-overlay chan=
nel
> > > > > cases in future changes. It must be set to true for cases when mo=
re
> > > > > than 1 overlay layer is used within a channel and at least one of=
 the
> > > > > overlay layers within a group uses premultiplied blending mode.
> > > >
> > > > Please remove this parameter. It's nothing special, so it can be ea=
sily added
> > > > once it's actually needed. For now, it only complicates code.
> > >
> > > I would prefer keeping it if you do not have any strong opinion again=
st it.
> > >
> > > I am working now on exposing all overlays, so it will be needed soon =
anyway.
> >
> > KMS assumes pre-multiplied alpha anyway, so we shouldn't need a
> > parameter to force it: we're always going to force it.
>
> My bad, I got confused with your other patch.
>
> Still, I agree with Jernej, if it's not needed it only complicates the
> code for no particular reason. If you need it at some point in the
> future, add it then. Otherwise, it's hard to reason about, since we
> don't know what are the expectations that those future patches will
> bring.

Well, existing code already has some sort of support for the sub-overlays:
For example 'int overlay, ' parameter is always 0, but it still passed thro=
ugh
the call stack. Therefore this patch is just aligned with already existing
traditions to keep sub-overlays in mind.

>
> Maxime

Regards,
Roman
