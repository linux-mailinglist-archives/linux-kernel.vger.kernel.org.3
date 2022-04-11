Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A8C4FB781
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbiDKJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbiDKJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:30:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF13FDB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:27:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s21so9148709pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUZLnKBxx8VA3OSu2dIqsE8cEUY3AK5vGZQzH6jJ2vo=;
        b=JyOGjkokBa+Aw6qxRAQJ498sUGyUYwxAOiPIEVGS79xAIQhaHmakXcZkILRXU1fOW2
         NVc0WL0w8BYbOkqfCmzChBxCXKDv6gT1+t/+dbygd3zinfwoTxBI6btFBiQRlVizGmDX
         RB7oCRd8YSitvkDPJ4LrpIemvAEqXANu3j9uhcwculIe7oLiojCuItyi223yx6g+RUAt
         SzYGRFIZDaUuTcj3XbAkDJ4KsVqTk1z7LPooAhAA6GrGWXCnU4MG8OLY3qUCN6/JXVs2
         KFKpIvtlpMIfuUokiO3icBC5jp5HjunYGiP1vQcNBH7/xKxKPgKgRRQnwiDdsZBkU1ND
         +mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUZLnKBxx8VA3OSu2dIqsE8cEUY3AK5vGZQzH6jJ2vo=;
        b=W+oYDOZmChqbWBO6hd0ziMlGhr1fPTkdEVXkQUz7RvXSbV62XASxM9IAG+0Qh6+Ttf
         A3Wf6tgMyMGjRBUn9ZMGvNkThq10c2uCbWvVQpDd41JC9dHzvwGIfpQjQ5CWe7J96S10
         UMOmSqtpZyqQhJTkb1wgdAcGYoxJ2hiBiLOxUu4FPlIX2XMOERUftRc91ZHwboAWlAO2
         gHM4CGhbaI8qfaJ+wWxTHh/rz7ROsVYlBf2Tauy6m5ccdI5Ci1vd2DiCaxZSF1vfz+HT
         jVCIVOs2+/BgS+W9Xup2v/Dmd9lLLdXH7ceOaja3QzMUy5gMms+rV7yBaSD29Vf0tkbx
         27Sg==
X-Gm-Message-State: AOAM533L6viBM62TdlMFowXxHZLigaY5exQ8jkb28Et3jWdFVyLHGLwm
        ytTmel6zPVSnvYRfC7FHga8Pn2n/G0bV9yUr/f8=
X-Google-Smtp-Source: ABdhPJxV9ml1CzlL5oo0xAIHD9+A2y+UDXYm1lYeNkcyI8Z7ey1mgEDT7HQb3xEvCQaE4O+y95NuNpdvXwzy8iTz0jY=
X-Received: by 2002:a63:e20:0:b0:385:fe08:52f9 with SMTP id
 d32-20020a630e20000000b00385fe0852f9mr25852698pgl.99.1649669274422; Mon, 11
 Apr 2022 02:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
 <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
 <CAMeQTsaM363n5F=--xhSTayFqOMNvjTQjqz_aEhby6i-KRVBKQ@mail.gmail.com> <CADvTj4o_zyVZxaBz0+kRUF30OW3SKFMuo87r6FE9Qkfn1dVsBw@mail.gmail.com>
In-Reply-To: <CADvTj4o_zyVZxaBz0+kRUF30OW3SKFMuo87r6FE9Qkfn1dVsBw@mail.gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Mon, 11 Apr 2022 11:27:43 +0200
Message-ID: <CAMeQTsbKMxQcDsDRqHsMwqU1BnrcOLwtU7uOrB-1E0z65P79-w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 10:05 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Sun, Apr 10, 2022 at 1:52 PM Patrik Jakobsson
> <patrik.r.jakobsson@gmail.com> wrote:
> >
> > On Sun, Apr 10, 2022 at 9:40 PM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > On Sun, Apr 10, 2022 at 1:36 PM Patrik Jakobsson
> > > <patrik.r.jakobsson@gmail.com> wrote:
> > > >
> > > > On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> > > > >
> > > > > Select the efi framebuffer if efi is enabled.
> > > > >
> > > > > This appears to be needed for video output to function correctly.
> > > > >
> > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > >
> > > > Hi James,
> > > > EFI_FB is its own driver and not needed by gma500 to drive its
> > > > hardware. What makes you think it's required?
> > >
> > > I wasn't getting any HDMI video output without it enabled for some reason,
> > > I assume it is doing some sort of initialization needed by gma500
> > > during startup.
> >
> > Then it sounds like you might just be using EFI_FB and not gma500. Can
> > you provide the kernel log with drm.debug=0x1f set on kernel
> > command-line.
>
> Seems efifb loads first and then hands off to gma500

That is how it normally works but efifb shouldn't change the state of
the currently set mode so shouldn't affect gma500.
From the logs I can see that you have LVDS (internal panel), HDMI and
DP (3 displays in total) connected. This sounds wrong. Your version of
gma500 (Cedarview) doesn't support more than 2 crtcs/pipes. This might
be a problem.
