Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332604884ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiAHRWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiAHRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:22:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C81C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 09:22:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso16453319pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fj1m2KmOUrIku4T8f3lgj98uSandn+jvuNG7THLdFI=;
        b=c7oZ/vQOfS6g+wsL600ZH9VSMOU9ZpP9pxc+dNwrbG13WPhauEYPubFq4cdxgiMnet
         W8bJpAvZnmQad9aryi6B2WBfrkxoRzPWC71pLGazZdpf0lYTk6uHpbOL7SNDqF2mV8Dt
         9YWvSjFQXZnMjke1RH4SqVw8rmtEy4jNEjuFDWLXXjcW11+M5XRbQ4nOcqSG2wOlfLgv
         POlhDKoP9WG10xsjmouwacSyhQ3rhP86Z2HN1bYttxwmpC5+n4q47Gh1lzXJ3Jijx77e
         FsHO8kwI7+rwGsDl+b0UqIOUVUGASM+ciM9Lv6cid0fExI1pyXWWllFsHPymkgSes1V9
         1Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fj1m2KmOUrIku4T8f3lgj98uSandn+jvuNG7THLdFI=;
        b=1NA3ZGuKPbJo1L1KfqTMCZz5p2QJBp2LZneiSuROgzlphpRhRPXtDsIrQMx9TKOjPs
         1nznkQP33InGTtre7fk0vuJcGNTRJWamflYVDNiNDpp0mgag+OQCCXiEh5U0UtVJ4WNa
         7rFy/a8Y+dz7xFiYImrFO12wXt6RmSfXFq8Fn5+2OM7az5dMOdSgBawBvpmJB+TsnUbR
         OuEZBawjyKIwzK24VF+oYfKnem7sj+Sl5mTaTJTDdfSUyqbltXz3pj08B56IyAYTaLX7
         HlmK8OiC1RnMiz9aHDMUKMBq7+Q5h1NEKWQxFziqEWyq1UJrrapqbljR3KRfifI+x3F0
         tAAQ==
X-Gm-Message-State: AOAM531x1OdITqi25fxHeIJcVpdbxiw/6YyLUJE0TmbVxRi3CC8fely+
        th9pyi3yQgnNEgV4NAZ9sDr8sziAs0agywKem364LA==
X-Google-Smtp-Source: ABdhPJzR1SBeA7+HeM7JwvdHbEXdFO+qjVCAXycudKaXHZqtmWgBHPjrcvRkyg0Zh7cEJ22YUTu6EM7XQ8kaf7r0xm0=
X-Received: by 2002:a17:90a:bb05:: with SMTP id u5mr6390941pjr.64.1641662534915;
 Sat, 08 Jan 2022 09:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20220107190208.95479-1-rajatja@google.com> <20220107190208.95479-3-rajatja@google.com>
 <YdiPOoU1JrqR7N6S@google.com> <d38ec2f9-a21f-d431-235a-9edb59fc40e9@redhat.com>
In-Reply-To: <d38ec2f9-a21f-d431-235a-9edb59fc40e9@redhat.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Sat, 8 Jan 2022 09:21:38 -0800
Message-ID: <CACK8Z6EB1Ji9D6hbWPtXHAa9Wy4jeFvMzXL6R81HBZp6GSYQHw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Benson Leung <bleung@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, dtor@google.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 8:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> On 1/7/22 20:06, Benson Leung wrote:
> > Hi Rajat,
> >
> > Thanks for your changes here.
> >
> > On Fri, Jan 07, 2022 at 11:02:08AM -0800, Rajat Jain wrote:
> >> Add a static entry in the x86 table, to detect and wait for
> >> privacy-screen on some ChromeOS platforms.
> >>
> >> Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
> >> enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
> >> shall return EPROBE_DEFER until a platform driver actually registers the
> >> privacy-screen: https://hansdegoede.livejournal.com/25948.html
> >>
> >> Signed-off-by: Rajat Jain <rajatja@google.com>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Hi Hans,
> >
> > Since this change depends on the privacy screen changes staged for v5.17,
> > I'm OK as platform/chrome maintainer to have this go through the drm tree.
> >
> > Acked-By: Benson Leung <bleung@chromium.org>
>
> Ok, I will merge this into drm-misc-next coming Monday.

Thank you so much for your help!

>
> Note I'm afraid that it is too late for 5.17, the drm-misc maintainers
> have already created the final drm-misc tag for the 5.17 pull-req.

No problem, this works.

Thanks & Best Regards,

Rajat

>
> Regards,
>
> Hans
>
>
> >
> >
> >> ---
> >> v5: * Add Hans' "Reviewed by"
> >> v4: * Simplify the detect_chromeos_privacy_screen() function
> >>     * Don't change the existing print statement
> >> v3: * Remove the pr_info() from detect_chromeos_privacy_screen(), instead
> >>       enhance the one already present in drm_privacy_screen_lookup_init()
> >> v2: * Use #if instead of #elif
> >>     * Reorder the patches in the series.
> >>     * Rebased on drm-tip
> >>
> >>  drivers/gpu/drm/drm_privacy_screen_x86.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> >> index a2cafb294ca6..88802cd7a1ee 100644
> >> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> >> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> >> @@ -47,6 +47,13 @@ static bool __init detect_thinkpad_privacy_screen(void)
> >>  }
> >>  #endif
> >>
> >> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> >> +static bool __init detect_chromeos_privacy_screen(void)
> >> +{
> >> +    return acpi_dev_present("GOOG0010", NULL, -1);
> >> +}
> >> +#endif
> >> +
> >>  static const struct arch_init_data arch_init_data[] __initconst = {
> >>  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
> >>      {
> >> @@ -58,6 +65,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
> >>              .detect = detect_thinkpad_privacy_screen,
> >>      },
> >>  #endif
> >> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> >> +    {
> >> +            .lookup = {
> >> +                    .dev_id = NULL,
> >> +                    .con_id = NULL,
> >> +                    .provider = "privacy_screen-GOOG0010:00",
> >> +            },
> >> +            .detect = detect_chromeos_privacy_screen,
> >> +    },
> >> +#endif
> >>  };
> >>
> >>  void __init drm_privacy_screen_lookup_init(void)
> >> --
> >> 2.34.1.575.g55b058a8bb-goog
> >>
> >
>
