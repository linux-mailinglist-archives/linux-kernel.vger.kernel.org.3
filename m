Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2929C49FB2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiA1ODW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiA1ODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:03:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577B7C061714;
        Fri, 28 Jan 2022 06:03:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id s5so16403176ejx.2;
        Fri, 28 Jan 2022 06:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LJkgBxQZGz+DBCDqTCv/zlH6Pf6EPJaEcwYrjb9pWI=;
        b=J5JhoCWcxWO7nN7IEpEBYaQzLhmcZpmAIVyRqe6sm45L7acqIKxsXW/mE29spAU3UN
         yuGsRZnGQQZEM3PFzAfP8ric79ObM7f69lRlimzVuSmYrRafJpAfy8NHi4eh3rKKW15P
         SjdfbfH0YUJGG405tVNPbMpInHh0izSvR18GsXoqMpc6wnNUMTfOGWsHdsFQO8k8CWRr
         bGfyBBa1xBS3byorg1zARbW0dQ5zpszNET8vkVl6+/NQ2x1iI2Q48+njzcoYh6Eh+dlE
         36syofIRL27r6YJ4PdDzie8Uc133DkoDzGomYvdobj3L8LKzdvA8pwKc/+rM5mw1/eE2
         Fzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LJkgBxQZGz+DBCDqTCv/zlH6Pf6EPJaEcwYrjb9pWI=;
        b=OmQlxaC4YrnPLK2vbiMX2r/BUD4UjLQtGyrGBBpu4IWGitfQKXSgCpr1QE/DeITgSa
         TV56qzJO3dTmOWgurZc0EaB/OsuYaBILCBNkJ0PdclQ25pdJ/gK6adxgh/vQ3za2xGte
         Q2KLRsGgKm0sme39mzAKju7ooyfsK6TyCAvbf4IHAHlqrB+oCXTjXQ9+XhU6gxJuoYh9
         z/fJK5P374lg4ZGxI8ERt/830Ab9Gnxhimoz+kpCeVgm/hSdhQLJaXJlazLjWT/lBwvC
         kGE4neWgJYKF2dfdJKP/DFmKMWIjJzDmQGgAZ6QI+Md+c76gJbzoMFPuSdsMqUTfOrhv
         gXFg==
X-Gm-Message-State: AOAM531u8rf26EhfT+qf4dx0FORhPIPoCbNJb6MFVeBhusGdf70+32uJ
        epHMDGPyN/+b7X9iC2bvcwrrCnKX9XWkAvYiYac=
X-Google-Smtp-Source: ABdhPJwDNhPs1YDqEHAdWX84zLhRjEXZ+jIj1Fk6pGf01xg1LP+H0kz88ItE8Gkigt8fi+9typWdCYl8rVFF4VPEwis=
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr7325773ejc.77.1643378599791;
 Fri, 28 Jan 2022 06:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20220128055604.2077738-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220128055604.2077738-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jan 2022 16:01:42 +0200
Message-ID: <CAHp75Vcz01FwHUF5NAUhn4mfTgzoHBMEBkqPbfPHU=tNr_9Zdw@mail.gmail.com>
Subject: Re: [PATCH v2] Input: adxl34x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 7:56 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "ADS0345" for adxl34x device.

the adxl34x

> Analog replied:
> "ADS034X is not a valid PNP ID. ADS0345 would be.
> I'm not aware that this ID is already taken.
> Feel free to submit a mainline Linux input mailing list patch."
>
> So add an ACPI match table for that accordingly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Drop ACPI_PTR()
>  - Drop redundant empty line and comma
>  - Add info from vendor
>
>  drivers/input/misc/adxl34x-i2c.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
> index a3b5f88d2bd16..b9af581cde800 100644
> --- a/drivers/input/misc/adxl34x-i2c.c
> +++ b/drivers/input/misc/adxl34x-i2c.c
> @@ -155,11 +155,18 @@ static const struct of_device_id adxl34x_of_id[] = {
>
>  MODULE_DEVICE_TABLE(of, adxl34x_of_id);
>
> +static const struct acpi_device_id adxl34x_acpi_match[] = {
> +       { "ADS0345" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, adxl34x_acpi_match);
> +
>  static struct i2c_driver adxl34x_driver = {
>         .driver = {
>                 .name = "adxl34x",
>                 .pm = &adxl34x_i2c_pm,
>                 .of_match_table = adxl34x_of_id,
> +               .acpi_match_table = adxl34x_acpi_match,
>         },
>         .probe    = adxl34x_i2c_probe,
>         .remove   = adxl34x_i2c_remove,
> --
> 2.33.1
>


-- 
With Best Regards,
Andy Shevchenko
