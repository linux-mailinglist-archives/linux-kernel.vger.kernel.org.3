Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BED49FB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiA1Nyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiA1Nyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:54:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67605C06173B;
        Fri, 28 Jan 2022 05:54:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ah7so16283284ejc.4;
        Fri, 28 Jan 2022 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+HVO9pfWKvtQNPEDK/I430Md9WsgnnHul3CbcaOVZQ=;
        b=Z2ELedQwJYz39tK4+PNoaYeMbVIHl7NAlHepJHX0f7jqb5+GMp+mf1tg2GNnP7C1WZ
         AHvHlEcwz6rBoSieI4EmTZ6u1n6KIDvT7iNSLfNhbXSiIqVqAljN/0AyE2MO2RgRV563
         n4/nSeaaWcguzSZUJlyZ8Lp2FqktAq8YkOW1btwKrlF8BceAf7vV06B91ouOZUW2OBdG
         KuFaS1Cn6qs+j4shaT3eVGbo5pbU91z/JjDScOfI5eHu7Hg/ChZqtKAZUgoo4qUSFFvZ
         cOiGLb+EvRHD4Rt15nI2IUiKiyOzV70Hm0IDPILXk66hlPiYCoBuM61WPjVDmj/6ixQb
         prUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+HVO9pfWKvtQNPEDK/I430Md9WsgnnHul3CbcaOVZQ=;
        b=H0rRRCXtzP+ZpIGJbzWU+BB/YNpISS4AdZQ50SAU8w4G+sdSFK3PcZzHZsXsgaABgz
         QAPW9bNvteLHGZlf+cIPd5AgSaOq2pWgIW8kljupLPfrh/kjopxLdWTqW31DYY7aFHnE
         77uhPWbbFtKILJV+YJKlpTPzIubLyM5wDDkIzd7RZIvWnq/GyCBcIrI7ArXch5FhQbMz
         K7y2yWxmEPhAamRrB85crMiXR7vHkZI6TQ4HrhfVnuFCCDz5K/g7otnapTaoZrICVGue
         nbJbN65InOwud0N50mVHlpPSbX9FRI+U7WyuWwlOGFrOS460qcV70o2IX3yXCumE5q+n
         z7DA==
X-Gm-Message-State: AOAM533JAOSLuY4Lq0Kobn/991+BpL7aWIQk88gQ6Rfid4nz+TML1Toe
        ILWjVLenWHk77IdqUF0EOJtYll8t18h73qYRECs=
X-Google-Smtp-Source: ABdhPJyxCcBk99rUQp6U3SzpQdyerpPcALccJkGIBAlJSRaoWZdv2CoAwgPjTfHSCh/AG6gJHd0h1//AZ6QidA+nU+A=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr6852057ejo.636.1643378088706;
 Fri, 28 Jan 2022 05:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20220128042054.2062060-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220128042054.2062060-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jan 2022 15:53:11 +0200
Message-ID: <CAHp75VfC873djcc4Z2+HhzR8z3Uaute3g0Fgr1dvOs_v=gD3Lw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: humidity: hdc100x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Your Name <you@example.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 6:21 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "TXNW1010" for the hdc100x device.
>
> TI told us "The ACPI ID for TI is: https://uefi.org/node/1028 (TXNW),
> therefore it would most likely be appropriate to use TXNW1010."

So, they basically agree on using it, did I get it right?

> So add an ACPI match table for that accordingly.

Assuming TI is aware of the ID,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - Add info from vendor
>  - Drop redundant line and comma.
>  - Wording change.
>
> v2:
>  - Change the ID to follow ACPI Spec
>  - Add __maybe_unused to avoid compiler warning
>
>  drivers/iio/humidity/hdc100x.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 9e0fce917ce4c..47f8e8ef56d68 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -417,10 +417,17 @@ static const struct of_device_id hdc100x_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
>
> +static const struct acpi_device_id hdc100x_acpi_match[] = {
> +       { "TXNW1010" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
> +
>  static struct i2c_driver hdc100x_driver = {
>         .driver = {
>                 .name   = "hdc100x",
>                 .of_match_table = hdc100x_dt_ids,
> +               .acpi_match_table = hdc100x_acpi_match,
>         },
>         .probe = hdc100x_probe,
>         .id_table = hdc100x_id,
> --
> 2.33.1
>


-- 
With Best Regards,
Andy Shevchenko
