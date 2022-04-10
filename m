Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8844FAFEB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbiDJTy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiDJTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:54:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E449F2F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:52:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k14so12423796pga.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXW0wU6sL+xTUffIXy2C7Ev5QLBh8RLDYuS2RioYZVw=;
        b=FA9BfN7WVP72n6YbEgBrcwEbcdcbxrPgQ49kuHo1RUOXKHWgqEiwV1TbvWccxvIPQ2
         yaaPFBH/SrkGDRJmYkugiD11gY6pWLVQIt9FiDNv98WX6iaEmW7vEePNnVCvMpQkDF7+
         BH8RqmRZK4HIcxhnaticcFapCzIAoSg98PLugFXkyXdg+SCBcNZCkxnN4tvj/mZKldtr
         70jONUbyUQdT/d6kxvbGaK6ARNE5gZsfsZeK7cncnxXRRLH9M6UCDeJN28ytfigcKpIx
         4oNVWBP/i3RC1wZ58Kzh9RHsz9qFJnm+Nl5qbSVD4lf9SM+IJzjtX7axrhcs+s6q2Z5p
         LUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXW0wU6sL+xTUffIXy2C7Ev5QLBh8RLDYuS2RioYZVw=;
        b=ZNi/5/6aaD55o2VPuGJdjMWRxiXu+wrQoY7L2KL/eVlk3U3of+RONPYhYDN7ZwemBV
         wpkjzMpmR1L12LaxSGl1lE16BTkkdAGx0EGAcitvaKpfu9UvotXm3n+gxpQpaFnFkuWL
         0cCyVj6HlpxDTMMvkgNB0v0MuB2RiWByTxMBz2paxl9QHmcCELXH/FqBn/RvviqCwWbA
         eTw+pIvvIcyrZ2E8GycOKbBDKEU6yRBhjPKYwg+959mncgAXLh1yFTtG5L21UlKboTCm
         CoMbqFVPtk/6XcF9WBLjNXnNO9jv326PT9ZIKkklICN8qU7NqZphQACCBxNuvFruw7Zi
         /XBA==
X-Gm-Message-State: AOAM532so86su+xMdQV6lMNd5FlTSVVEJRUxfQXzmwnQiqJhwvCUI7Q6
        4kdkVhjRSuKL2nZ1hSMzvSZ+KxqkOlt3uz4fSws=
X-Google-Smtp-Source: ABdhPJzBEeA12N7T+usRtAyQktRWwo1cbNQ6FobBLbugkem4fWgOJf7iPkSK2Grrf1UVniEG+fFlKVPzXcT9+OTGzNI=
X-Received: by 2002:a63:4f46:0:b0:382:56b2:f8 with SMTP id p6-20020a634f46000000b0038256b200f8mr23829251pgl.90.1649620365218;
 Sun, 10 Apr 2022 12:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com> <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
In-Reply-To: <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Sun, 10 Apr 2022 21:52:33 +0200
Message-ID: <CAMeQTsaM363n5F=--xhSTayFqOMNvjTQjqz_aEhby6i-KRVBKQ@mail.gmail.com>
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

On Sun, Apr 10, 2022 at 9:40 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Sun, Apr 10, 2022 at 1:36 PM Patrik Jakobsson
> <patrik.r.jakobsson@gmail.com> wrote:
> >
> > On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> > >
> > > Select the efi framebuffer if efi is enabled.
> > >
> > > This appears to be needed for video output to function correctly.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > Hi James,
> > EFI_FB is its own driver and not needed by gma500 to drive its
> > hardware. What makes you think it's required?
>
> I wasn't getting any HDMI video output without it enabled for some reason,
> I assume it is doing some sort of initialization needed by gma500
> during startup.

Then it sounds like you might just be using EFI_FB and not gma500. Can
you provide the kernel log with drm.debug=0x1f set on kernel
command-line.

What machine is this? I've seen very few gma500 devices with UEFI.

>
> >
> > -Patrik
> >
> > > ---
> > > Changes v2 -> v3:
> > >   - select EFI_FB instead of depending on it
> > > Changes v1 -> v2:
> > >   - use depends instead of select
> > > ---
> > >  drivers/gpu/drm/gma500/Kconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> > > index 0cff20265f97..a422fa84d53b 100644
> > > --- a/drivers/gpu/drm/gma500/Kconfig
> > > +++ b/drivers/gpu/drm/gma500/Kconfig
> > > @@ -2,11 +2,13 @@
> > >  config DRM_GMA500
> > >         tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> > >         depends on DRM && PCI && X86 && MMU
> > > +       depends on FB
> > >         select DRM_KMS_HELPER
> > >         # GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
> > >         select ACPI_VIDEO if ACPI
> > >         select BACKLIGHT_CLASS_DEVICE if ACPI
> > >         select INPUT if ACPI
> > > +       select FB_EFI if EFI
> > >         help
> > >           Say yes for an experimental 2D KMS framebuffer driver for the
> > >           Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
> > > --
> > > 2.25.1
> > >
