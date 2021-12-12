Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37B4719FE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLLMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhLLMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:25:36 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD95C061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 04:25:36 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so3527918ooi.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 04:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pqm3MEzw/SRtYgeO+FRlV/4S62E3FDVXFyeRzA9lmc0=;
        b=ay8OnbLKKlHJYs8GFlVyYWdZMg1+g46qwd44EkxjDzKYWI7sTfIK7ctd4Bta2WjGC5
         GRNICdkvZIraY1uO9vdZn0zALqODSCiZonjbB/hhgdda7ZwCD0Gu8DyqPyi/jZLvETDs
         dgYV2Af83mrZGrxKaTRdgglmpTOY0o9CZ4KaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pqm3MEzw/SRtYgeO+FRlV/4S62E3FDVXFyeRzA9lmc0=;
        b=jejTD6hr8brROOrpEXQp48LP/xusw8cv/is47uweSpmxvnzZH/gzpRjUWL0T7sTA3D
         sUM3ymBSKY63zPEOsoAFRqlGvGkKmhRX8AjHidJeSM7Ck1CMLeOSlPIasY8F3DmChGoW
         NrOQe4mxFpr8MMeKVd0mXVsx9jBjYoGLlP4twEkQsHyIpcysi+p6ZDL0o1eHYt/2bdge
         soCszPFMMKQBlldQfdbhXMDoA3EhrDFeyHKATudFEoktB4H1bdrljZN40zWQWfUzvUGc
         n7MMMzu+b5rXaSa4NjWFj4thqicUdLPz25UYym41RCXkxl5oh8vAvhjTojp97MWQhLQR
         mIFw==
X-Gm-Message-State: AOAM5331gybYmdnA1Htf+YLaQ2sGmvgGyVoluPPIk7ffuWLW9gWFK4P/
        FxvSFLqgoAGdzHNPpX1RD92q+yLP9RQDgQ==
X-Google-Smtp-Source: ABdhPJwtxZ/PggFxF3ZvsfxusV/RlK2xo7dWyjUsjfjiOK341U30i23lo/Z0ZYgQ90kpvcJMeTECYQ==
X-Received: by 2002:a05:6820:445:: with SMTP id p5mr15612711oou.9.1639311935758;
        Sun, 12 Dec 2021 04:25:35 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id w17sm1611003oth.17.2021.12.12.04.25.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 04:25:35 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id u74so19674585oie.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 04:25:34 -0800 (PST)
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr22413735oic.174.1639311934148;
 Sun, 12 Dec 2021 04:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20211212114929.264905-1-jose.exposito89@gmail.com>
In-Reply-To: <20211212114929.264905-1-jose.exposito89@gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 12 Dec 2021 13:25:23 +0100
X-Gmail-Original-Message-ID: <CANiDSCu==Z6xaFD0hM_gYj5fv+55FPe=rRvW1a7aQZO7p-wt9Q@mail.gmail.com>
Message-ID: <CANiDSCu==Z6xaFD0hM_gYj5fv+55FPe=rRvW1a7aQZO7p-wt9Q@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix memory leak in uvc_gpio_parse
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jos=C3=A9

Thanks for your patch

On Sun, 12 Dec 2021 at 12:49, Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmai=
l.com> wrote:
>
> Previously the unit buffer was allocated before checking the IRQ for
> privacy GPIO.
> In case of error, the unit buffer was leaked.
>
> Allocate the unit buffer after the IRQ to avoid it.
>
> Addresses-Coverity-ID: 1474639 ("Resource leak")
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 7c007426e082..9e83e2002710 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1533,10 +1533,6 @@ static int uvc_gpio_parse(struct uvc_device *dev)
>         if (IS_ERR_OR_NULL(gpio_privacy))
>                 return PTR_ERR_OR_ZERO(gpio_privacy);
>
> -       unit =3D uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID=
, 0, 1);
> -       if (!unit)
> -               return -ENOMEM;
> -
>         irq =3D gpiod_to_irq(gpio_privacy);
>         if (irq < 0) {
>                 if (irq !=3D EPROBE_DEFER)
> @@ -1545,6 +1541,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
>                 return irq;
>         }
>
> +       unit =3D uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID=
, 0, 1);
> +       if (!unit)
> +               return -ENOMEM;
> +
>         unit->gpio.gpio_privacy =3D gpio_privacy;
>         unit->gpio.irq =3D irq;
>         unit->gpio.bControlSize =3D 1;
> --
> 2.25.1
>


--=20
Ricardo Ribalda
