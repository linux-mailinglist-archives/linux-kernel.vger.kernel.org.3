Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74FD4FAFD7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242645AbiDJTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDJTnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:43:04 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDC4D63B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:40:52 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso9951395otp.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUl8Qd04XCFc9FE72bNsCtMOh/C1JcO2xYzOigY3DOQ=;
        b=Fs8J9GIrPrs0yfIjawm/mukc4LqbyZydY837wCeZzQMbyYw+qUDHoOB4d4Dnf5BCqn
         GUoWZYgF2SzH9ngNhAo5FBXK+x28VGcmjgeDbXEiKismueXnZ98WF1olWpE4hTCpAuEI
         qCPGER4oR27g8qXzEegktq8aKzNsmo7ic1QFf+Fay2R9P9L0wJ4Izc7fp4NtUlfVRgzk
         LqsWFpcTBiMOGuLDxJqkYGcXhkWzcKa5YiS7cpTTpS457B8+Dsa62BD3AtRnNP0A5x+m
         xdJ/ZDJ2gWuA+xs0rIzU3eypS35hhU5wOSEkq4euPEtkvBDwKcbI1tdugX3ZHTdH86Ko
         6IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUl8Qd04XCFc9FE72bNsCtMOh/C1JcO2xYzOigY3DOQ=;
        b=7CgMSqKWknMTPNuXUlNMRA4hoHTKNiwR/nfbKAiVu8kWIPtqzlc4zZO4rWVjsAIgGc
         dCszwEQxobaB1r91AiVe8KKA4K+l5kb/fj1E5ifnQOnNTK8ck6QjsVNy4+pElsyL0hjU
         b3ktYvePQNGPpTCssAGC+YZYEbIbdPk67ZWfZRpzMAAXw5qtbCEvxTY5MaNz0clCuJJw
         HolcqqKnq9gSTrMuxS6EhLVCkb3zPNDAIN15lS5NqsJ9ocxvjVxXRmuDLTxGzGapE6SU
         O0ugYKjF2TCgKCo+8ulOlA/CxUzDEYn94R4mAXlSY0vgoPNab/Ci5cO+tZxPOyRX7/xT
         GRVg==
X-Gm-Message-State: AOAM531KESHs9YsWvzRN0auIFi4uvK/mqPu6+w2AH4DTvNfynBixTtDX
        Ksai2+CgbPs9wVUkpmxnGyPNnsZa2kPOA+7lU8LwZNeVQGg=
X-Google-Smtp-Source: ABdhPJyYr3ENb63/2H2lblSxQ8S9ju20aVO7Z+CEMkVpE7y12Suji93mEHkrGh9UDB/WuPnf43Uh7+G/gqpgpiDV1qk=
X-Received: by 2002:a05:6830:4d3:b0:5cb:73f0:2f1a with SMTP id
 s19-20020a05683004d300b005cb73f02f1amr9833533otd.30.1649619652273; Sun, 10
 Apr 2022 12:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com> <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
In-Reply-To: <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sun, 10 Apr 2022 13:40:40 -0600
Message-ID: <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 1:36 PM Patrik Jakobsson
<patrik.r.jakobsson@gmail.com> wrote:
>
> On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> >
> > Select the efi framebuffer if efi is enabled.
> >
> > This appears to be needed for video output to function correctly.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> Hi James,
> EFI_FB is its own driver and not needed by gma500 to drive its
> hardware. What makes you think it's required?

I wasn't getting any HDMI video output without it enabled for some reason,
I assume it is doing some sort of initialization needed by gma500
during startup.

>
> -Patrik
>
> > ---
> > Changes v2 -> v3:
> >   - select EFI_FB instead of depending on it
> > Changes v1 -> v2:
> >   - use depends instead of select
> > ---
> >  drivers/gpu/drm/gma500/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> > index 0cff20265f97..a422fa84d53b 100644
> > --- a/drivers/gpu/drm/gma500/Kconfig
> > +++ b/drivers/gpu/drm/gma500/Kconfig
> > @@ -2,11 +2,13 @@
> >  config DRM_GMA500
> >         tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> >         depends on DRM && PCI && X86 && MMU
> > +       depends on FB
> >         select DRM_KMS_HELPER
> >         # GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
> >         select ACPI_VIDEO if ACPI
> >         select BACKLIGHT_CLASS_DEVICE if ACPI
> >         select INPUT if ACPI
> > +       select FB_EFI if EFI
> >         help
> >           Say yes for an experimental 2D KMS framebuffer driver for the
> >           Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
> > --
> > 2.25.1
> >
