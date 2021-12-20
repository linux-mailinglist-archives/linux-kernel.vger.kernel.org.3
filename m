Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403C747B1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhLTRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhLTRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:10:29 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB677C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:10:29 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d10so30880619ybe.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5TtUkHNUfSsL6Hv1/iMYQYUcs6/zThRgbIsxMTzAeY=;
        b=AYMbNNQp1HO4KUCmi6JvoIwDozOquSxaq7AweS43tfflT10+6Qtp0FN6lU1J2WE+nv
         7c+MYY5cgKEZS64RUbPXewu6hb4UOPwKneYoSL8lIUSw1n16FhmfyJ74qkKsg0kan9S0
         Itgqik0YsJ5VwNOvKkTQL04bsTr4wgV0DXhgw3nhN+v2rLOJtJiWgK5HA7KtsMHYosvO
         4uDWbzgA8qUIV1nA/NYeeZpxhxQmOS5vcR/bpv5Sp5y+dOZ3vZuDTBZYb1CpWioedOB6
         pJQXBWsqpcnWIS8XTyreIzRo926OiwoXXHgSGC6GPNffH/w+iR7m04GYaXDfzp29xoNh
         FlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5TtUkHNUfSsL6Hv1/iMYQYUcs6/zThRgbIsxMTzAeY=;
        b=MuxY2gWGyXQYMm0I8m0YV/ZOUmq01fGaTeRACcnSk2U0fXzgdfxoAFlR9eZ+PUPjRI
         F4i/xGY4IaYJ9eIz7tJZTAGNl06uv/vIpqwm/ePQpVhHSzbinPUwZAnBYXUUzydmW7yT
         crbNeI/Ux1mY+IC744yVhI7KfLxOjcJz1L7LuUUi/hzK3dWR6KL0Tgwt35sXeZyCvdo7
         BLTVoFOBkATO9LWwjN49s5FcGJFYkcObPD5fO5iTgZaxfh+zYHSUJzxb+yQVZDwX30gY
         MVigr84WHJGtrkJ4AqNBwpZTENT5zEMXbCtCHxO2T/4Oww0yJdWRzS0aC0Hv8riD3I7m
         mr8g==
X-Gm-Message-State: AOAM531sjIoxoBY6SFaZkQPWvaNi+6/seIfGvJaBLEUJw08ic6tHZHOX
        r6u1sX6WzwN2yoGlRjuzkxO0mbnS76NePnvXBoE=
X-Google-Smtp-Source: ABdhPJxpgvquokTu7tmTAwjs/SYr5+0sj4VrALBT7mEpv38OzVrWiv3Yml8/4bHiDqaVqaAyDlTkpsy986gItJJw0d0=
X-Received: by 2002:a25:3fc3:: with SMTP id m186mr24287539yba.562.1640020228766;
 Mon, 20 Dec 2021 09:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20211217003752.3946210-1-javierm@redhat.com> <20211217003752.3946210-25-javierm@redhat.com>
In-Reply-To: <20211217003752.3946210-25-javierm@redhat.com>
From:   Deepak Rawat <drawat.floss@gmail.com>
Date:   Mon, 20 Dec 2021 09:10:18 -0800
Message-ID: <CAHFnvW3owW38B31SdYWcjCf2jLqUmGnCZ4m_iS1rPW2M9HUrMg@mail.gmail.com>
Subject: Re: [PATCH v2 24/37] drm/hyperv: Add support for the nomodeset kernel parameter
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 4:38 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
>
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the system framebuffer will be available if it was set-up.
>
> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Acked-by: Deepak Rawat <drawat.floss@gmail.com>

>
> (no changes since v1)
>
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 00e53de4812b..4a8941fa0815 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -305,6 +305,9 @@ static int __init hyperv_init(void)
>  {
>         int ret;
>
> +       if (drm_firmware_drivers_only())
> +               return -ENODEV;
> +
>         ret = pci_register_driver(&hyperv_pci_driver);
>         if (ret != 0)
>                 return ret;
> --
> 2.33.1
>
