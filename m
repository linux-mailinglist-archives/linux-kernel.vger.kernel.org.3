Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2216489FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiAJTNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiAJTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:13:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6567C06173F;
        Mon, 10 Jan 2022 11:12:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i5so4041987edf.9;
        Mon, 10 Jan 2022 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tP1DYjTazDNhmeXD8dNs23ff5eYfzUdaz2RizxuPk+g=;
        b=jmZ6ew2muTWHayV8vBZloY72n7uiUNgy5h0ju4ySco7V1KIFwY6w5rI88LjoO9gKYm
         kYPwiYhhDjYd4V3TUTEktX8SY/qLjoJfx6yXZ3zhZ9oW7OJeyls74b0REMgRMTlivIwf
         yPNxjcF9BcPUW18HnuffsyiTl8MyYE7xF8pygl91nOGNDQJMndhuqiApmDGUyK9NiWDg
         E6WFzI6vKyfvdj3w+KKlz5XnOk0mHWrViftN8oIVrtufFe5Km6zGETZ45mitDaebSTnw
         nIJPZYfeEK+wtXehcvp5yskvbMlF8VmMBCEUceMiHdt6E7gAYp5GCXcJEr7YKMiPy+ps
         Xr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tP1DYjTazDNhmeXD8dNs23ff5eYfzUdaz2RizxuPk+g=;
        b=2mvuZWTnVetr7n/uZHnX9AD0bYGZdwYrZPhVPJ+ZrndEE76zFzYayQe6EfChpLvxOR
         Yl96Jjs5vVmCv28gJuWQuHB3Wy7zU31r+3PGahXylltiqDORRgxe9JuhOyYrsSsDYaXM
         V2z+Q4thmmDEfocpa724TJBrfDxTE98JIq4FG8IA0STAygJXBDWdpMf5hncAMk9Mo8Ik
         Njsf6g2yBRet36X+Ix8kN17abZT+LKzr3iGumiVkZeUbf1G0qshDDkjLVKZjiBdX/TSO
         tVGumk1QPZ15llD5Mdv3cQxQqEgeCGg4jAtEKFum6oOOpvNnRUn2KWnsqrUEY6EbLvwN
         f3gA==
X-Gm-Message-State: AOAM531kP4R2YpRY97eUViNONh+eM/RfhjF9GkkHLzxseuI1WZJYrrGt
        89pvsCCvrH6HQ7mY0LkyFF80QD0CHWLZmeieQXM=
X-Google-Smtp-Source: ABdhPJxeyS/zQUQAjbwRj8OtDYsQaTcKmu9d212+t8YlQYcqRtYq2Q+lGd6EOtx6DxwZ3Axc/jd2CLW6nMMfiSX+Nj8=
X-Received: by 2002:a05:6402:424c:: with SMTP id g12mr646441edb.4.1641841978110;
 Mon, 10 Jan 2022 11:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20220107190208.95479-1-rajatja@google.com> <4ef79dee-b9d5-ee0c-56c5-0b3058b49ad5@redhat.com>
In-Reply-To: <4ef79dee-b9d5-ee0c-56c5-0b3058b49ad5@redhat.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 10 Jan 2022 11:12:46 -0800
Message-ID: <CAA93t1rPSN482KnDj2tmEztu=yzrDO=1pWh7o7cG_Jr_gM=Nsw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drm/privacy_screen: Add drvdata in drm_privacy_screen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Sean Paul <seanpaul@google.com>, marcheu@google.com,
        Dmitry Torokhov <dtor@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 3:24 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> On 1/7/22 20:02, Rajat Jain wrote:
> > Allow a privacy screen provider to stash its private data pointer in the
> > drm_privacy_screen, and update the drm_privacy_screen_register() call to
> > accept that. Also introduce a *_get_drvdata() so that it can retrieved
> > back when needed.
> >
> > This also touches the IBM Thinkpad platform driver, the only user of
> > privacy screen today, to pass NULL for now to the updated API.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> I've pushed this series to drm-misc-next now.

Thank you so much. I see it.

Thanks & Best Regards,

Rajat


>
> Regards,
>
> Hans
>
>
>
> > ---
> > v5: Same as v4
> > v4: Added "Reviewed-by" from Hans
> > v3: Initial version. Came up due to review comments on v2 of other patches.
> > v2: No v2
> > v1: No v1
> >
> >  drivers/gpu/drm/drm_privacy_screen.c    |  5 ++++-
> >  drivers/platform/x86/thinkpad_acpi.c    |  2 +-
> >  include/drm/drm_privacy_screen_driver.h | 13 ++++++++++++-
> >  3 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
> > index beaf99e9120a..03b149cc455b 100644
> > --- a/drivers/gpu/drm/drm_privacy_screen.c
> > +++ b/drivers/gpu/drm/drm_privacy_screen.c
> > @@ -387,7 +387,8 @@ static void drm_privacy_screen_device_release(struct device *dev)
> >   * * An ERR_PTR(errno) on failure.
> >   */
> >  struct drm_privacy_screen *drm_privacy_screen_register(
> > -     struct device *parent, const struct drm_privacy_screen_ops *ops)
> > +     struct device *parent, const struct drm_privacy_screen_ops *ops,
> > +     void *data)
> >  {
> >       struct drm_privacy_screen *priv;
> >       int ret;
> > @@ -404,6 +405,7 @@ struct drm_privacy_screen *drm_privacy_screen_register(
> >       priv->dev.parent = parent;
> >       priv->dev.release = drm_privacy_screen_device_release;
> >       dev_set_name(&priv->dev, "privacy_screen-%s", dev_name(parent));
> > +     priv->drvdata = data;
> >       priv->ops = ops;
> >
> >       priv->ops->get_hw_state(priv);
> > @@ -439,6 +441,7 @@ void drm_privacy_screen_unregister(struct drm_privacy_screen *priv)
> >       mutex_unlock(&drm_privacy_screen_devs_lock);
> >
> >       mutex_lock(&priv->lock);
> > +     priv->drvdata = NULL;
> >       priv->ops = NULL;
> >       mutex_unlock(&priv->lock);
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 341655d711ce..ccbfda2b0095 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -9782,7 +9782,7 @@ static int tpacpi_lcdshadow_init(struct ibm_init_struct *iibm)
> >               return 0;
> >
> >       lcdshadow_dev = drm_privacy_screen_register(&tpacpi_pdev->dev,
> > -                                                 &lcdshadow_ops);
> > +                                                 &lcdshadow_ops, NULL);
> >       if (IS_ERR(lcdshadow_dev))
> >               return PTR_ERR(lcdshadow_dev);
> >
> > diff --git a/include/drm/drm_privacy_screen_driver.h b/include/drm/drm_privacy_screen_driver.h
> > index 24591b607675..4ef246d5706f 100644
> > --- a/include/drm/drm_privacy_screen_driver.h
> > +++ b/include/drm/drm_privacy_screen_driver.h
> > @@ -73,10 +73,21 @@ struct drm_privacy_screen {
> >        * for more info.
> >        */
> >       enum drm_privacy_screen_status hw_state;
> > +     /**
> > +      * @drvdata: Private data owned by the privacy screen provider
> > +      */
> > +     void *drvdata;
> >  };
> >
> > +static inline
> > +void *drm_privacy_screen_get_drvdata(struct drm_privacy_screen *priv)
> > +{
> > +     return priv->drvdata;
> > +}
> > +
> >  struct drm_privacy_screen *drm_privacy_screen_register(
> > -     struct device *parent, const struct drm_privacy_screen_ops *ops);
> > +     struct device *parent, const struct drm_privacy_screen_ops *ops,
> > +     void *data);
> >  void drm_privacy_screen_unregister(struct drm_privacy_screen *priv);
> >
> >  void drm_privacy_screen_call_notifier_chain(struct drm_privacy_screen *priv);
> >
>
