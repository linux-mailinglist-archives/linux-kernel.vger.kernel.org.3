Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55347B45E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhLTUaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLTU3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:29:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:29:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 196so6168117pfw.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNspGc3Te6LnfTNYFrCZ2flcwpPDYLrwU6uIeemKSSc=;
        b=pzYtGUmtq1JxqBQ5NTQVWAPH8z2T3dWbhSK5gPoxrSb29QN1fO7ChPFRXmXdh4Eph6
         6VXU2IGW2+dB0QBoSUhHENMZH7iZ91EAtMUpE3okeSwQpFZ+6DI6eh9R25/C1rLGG6aT
         1eNYTfXwwovCrZZMBXn4L0XsJ31a+XUJI+3LXbAa5GldBUhM56yds/bFKG61IguHzzam
         vNjpWLMOB+rC+0V1PyHlZdcS/ymGINGuKL7nslC2oUSPuBES3mhUhoCRvq529X9aGXoe
         mG8jrntSM4hMWkmAgLfLfjYKSrlbm4kHvUp22M1AHSaxl71zAC9IyrRJGb/2B3E4tMwr
         pwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNspGc3Te6LnfTNYFrCZ2flcwpPDYLrwU6uIeemKSSc=;
        b=0Uzlns/lZXIoUXVWlQPWq219Es/nmjf5xqie/sdnvPEHvIah7GOiQcuXGMsbh96BAG
         SThUHgF7frpbEDQ6kJs3dCQ2VETs0MZgNFJZRgL7kyxfgW+kQbcKZvauEbqNjL9czlVi
         /BrY64w7irGFF6Q2jjhPlG6ihN+GdPc+CYloEcvjyeWhO1yB4A3ihnjNzRCesuSLuLUa
         DgiTyG5W4U88+wSuDr2iYt1+dT1cyqJz8bgHxu/FZxWgcGQIaTg/LXwjbzU29hkQNSQp
         x+PEF8Wu/uKjI0OVv70S5SmtGN3T5Sxpq1cyiy+3iaIlR+sa3wr1iseKpvDu6Q0jS9ah
         DoEQ==
X-Gm-Message-State: AOAM530LxeFs8wKnipUZeHxy4U2VEaCkKUrET1XkQUypg5KWmurSTjGG
        mP7kW1fP19OudvZc40vRQSuFRZSjvUZYc/XbmcbgUg==
X-Google-Smtp-Source: ABdhPJxyfauyO61GnUyRQIN3CwY6EYbeDVV2eZNvvE/+KNtRptm/KQwKCWz4c7RzCH4+ZwPxwVLrL3Kk6fZRC5Ur264=
X-Received: by 2002:a63:9:: with SMTP id 9mr16127264pga.136.1640032194595;
 Mon, 20 Dec 2021 12:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20211217202850.1967594-1-rajatja@google.com> <20211217202850.1967594-2-rajatja@google.com>
 <YcDegV8wqljpU3J0@google.com>
In-Reply-To: <YcDegV8wqljpU3J0@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 20 Dec 2021 12:29:18 -0800
Message-ID: <CACK8Z6FyvpjhHqh3PRfRFYAhVaxgkxBT_1SnYH0PkvNv5qwOvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 20, 2021 at 11:50 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Dec 17, 2021 at 12:28:50PM -0800, Rajat Jain wrote:
> > Add a static entry in the x86 table, to detect and wait for
> > privacy-screen on some ChromeOS platforms.
> >
> > Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
> > enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
> > shall return EPROBE_DEFER until a platform driver actually registers the
> > privacy-screen: https://hansdegoede.livejournal.com/25948.html
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: * Use #if instead of #elif
> >     * Reorder the patches in the series.
> >     * Rebased on drm-tip
> >
> >  drivers/gpu/drm/drm_privacy_screen_x86.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> > index a2cafb294ca6..0c5699ad70a3 100644
> > --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> > +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> > @@ -47,6 +47,18 @@ static bool __init detect_thinkpad_privacy_screen(void)
> >  }
> >  #endif
> >
> > +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> > +static bool __init detect_chromeos_privacy_screen(void)
>
> Does marking this __init work in case there is a deferral?

Yes, I have verified that for Chromeos case, it is a deferral.

> Can it happen
> that privacy screen is a module and so will get loaded only after we
> discarded __init sections.

Perhaps. But I do not think that  is a problem. All the functions and
data in this file are in __init sections, and this entry is here to
ensure that the drm probe will wait for the privacy screen driver
(whenever it is loaded). That is the reason, ideally we  would want to
somehow restrict the privacy screen to be built into the kernel so as
to minimize the delay if any.


>
> > +{
> > +     if (!acpi_dev_present("GOOG0010", NULL, -1))
> > +             return false;
> > +
> > +     pr_info("%s: Need to wait for ChromeOS privacy-screen drvr", __func__);
>
> I still do not see how this message is helpful. If it is really desired,
> I'd put something into the code that calls into lookups.
>

Ack. This message highlights that the kernel indeed found privacy
screen device in the ACPI and the drm probe will need to wait for it.
I think I agree that this message is not needed here, I think I'll
tweak the existing message in drm_privacy_screen_lookup_init().

> > +     return true;
> > +
> > +}
> > +#endif
> > +
> >  static const struct arch_init_data arch_init_data[] __initconst = {
> >  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
> >       {
> > @@ -58,6 +70,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
> >               .detect = detect_thinkpad_privacy_screen,
> >       },
> >  #endif
> > +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> > +     {
> > +             .lookup = {
> > +                     .dev_id = NULL,
> > +                     .con_id = NULL,
> > +                     .provider = "privacy_screen-GOOG0010:00",
> > +             },
> > +             .detect = detect_chromeos_privacy_screen,
> > +     },
> > +#endif
> >  };
> >
> >  void __init drm_privacy_screen_lookup_init(void)
> > --
> > 2.34.1.307.g9b7440fafd-goog
> >
>
> Thanks.

Thanks & Best Regards,

Rajat

>
> --
> Dmitry
