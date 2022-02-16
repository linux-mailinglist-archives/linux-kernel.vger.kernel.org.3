Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897764B7C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245287AbiBPBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:11:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245488AbiBPBK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:10:56 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0EEFA203
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:10:16 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c6so1411228ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEAvnISlAgpQaUg6TOaHvEbXUrTyCqH15xyEbDSJWp0=;
        b=ZUZR+o7NNuMwO1tDYO+QNJg+NoAX33xWhrua8Z8KDMfC2GLtSZdyUBrn9hqmZc011V
         H9AOPKO1ShSUjtslz814QmDGdWyq4XsFxbPx9NTsbv9s9VZzqH4Rb7d+mDBITNARApIB
         ztT+jp2GyBVb3rGGQap/Dk+L7wisatjFXx0T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEAvnISlAgpQaUg6TOaHvEbXUrTyCqH15xyEbDSJWp0=;
        b=2iRWlLTsci7+WWENUG/tBXl4rU5fgYqlNRVZQq9wET+Gq4XECv/J3RlDX1kcDsZavz
         faN8AnclH6gCQkmmseO6G26VqFHeRdfjT9I5n+vDJzKaLksi7dXrLfGMejKBa4yTvDHS
         Y8Z6g7ghjqEpuHk7h2NKZFdT+xRph5HaUvqd6ZXKctej5zf2py/hIGPk13wk5iV1ww1B
         ndWQCZMlmBVzF7PUodLrywmrd+zaB5JXhaHUWkNdJEA9Ea8e1GXk9gWRsgN11DMtVfy2
         abqMdoZPGzgZF3vNRuLNFip3raGNKfARMeiEaYM6cUytXnygBrfBFvWaPHPPOQvSTEIZ
         lO2g==
X-Gm-Message-State: AOAM5331NJkM/T+huQdFu+z+2Mev8JfD/+09vwPfIBHGxFvscUfuJ3I8
        dGqpsPd7Mj+REbm5k+RwKNSVL2hJBdPvlGr9j0qIrA==
X-Google-Smtp-Source: ABdhPJyS++e5nIEG75PGyCAX0dVZV5d5K6bZd+I14kU4jBkU/7L3RVTaVSVHXVvfqzU4/OQusykc2yuGOrZm/jYCf0Y=
X-Received: by 2002:a05:6902:108:b0:621:165e:5c1e with SMTP id
 o8-20020a056902010800b00621165e5c1emr307818ybh.204.1644973815876; Tue, 15 Feb
 2022 17:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20220214053646.3088298-1-tzungbi@google.com> <20220214053646.3088298-5-tzungbi@google.com>
In-Reply-To: <20220214053646.3088298-5-tzungbi@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 15 Feb 2022 17:10:04 -0800
Message-ID: <CACeCKac+b1Rp6bZFALn=sbh8gkJbWeKTC=8bdzp+-90pgq=wSw@mail.gmail.com>
Subject: Re: [PATCH 4/5] platform/chrome: cros_kbd_led_backlight: support OF match
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 9:37 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  .../platform/chrome/cros_kbd_led_backlight.c    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index 814f2b74c602..ba853e55d29a 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> @@ -128,8 +129,11 @@ static int keyboard_led_probe(struct platform_device *pdev)
>         int error;
>
>         drvdata = acpi_device_get_match_data(&pdev->dev);
> -       if (!drvdata)
> -               return -EINVAL;
> +       if (!drvdata) {
> +               drvdata = of_device_get_match_data(&pdev->dev);
> +               if (!drvdata)
> +                       return -EINVAL;
> +       }

I'm not familiar with this driver, so can't do a full review, but
shouldn't device_get_match_data()
from property.h [1] be able to handle both DT and ACPI cases?

[1]: https://elixir.bootlin.com/linux/v5.17-rc4/source/include/linux/property.h

>
>         if (drvdata->init) {
>                 error = drvdata->init(pdev);
> @@ -161,10 +165,19 @@ static const struct acpi_device_id keyboard_led_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
>
> +static const struct of_device_id keyboard_led_of_match[] = {
> +       {
> +               .compatible = "google,cros-kbd-led-backlight",
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
> +
>  static struct platform_driver keyboard_led_driver = {
>         .driver         = {
>                 .name   = "chromeos-keyboard-leds",
>                 .acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
> +               .of_match_table = of_match_ptr(keyboard_led_of_match),
>         },
>         .probe          = keyboard_led_probe,
>  };
> --
> 2.35.1.265.g69c8d7142f-goog
>
>
