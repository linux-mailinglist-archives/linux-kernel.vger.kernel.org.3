Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A249E76A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiA0QYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbiA0QYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:24:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429BC061714;
        Thu, 27 Jan 2022 08:24:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n10so4404029edv.2;
        Thu, 27 Jan 2022 08:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvzGa+d3pEOk5jowiJ1tauyPSEQZQMAnnb+dgzwhi5Q=;
        b=UbYfgMYW+e7IrDtwoNUq3nS3ZVyc8EH2yhKJ06Zb8k9tqd3QaA7XxISQ9XWSwIAmur
         T4UjurUOvA0w+8yJyfJFfA6NNxQArDEgJuja5U8P0yfyu+Y50bxqqJqkx8gRaonjnMRr
         k4M51aKKT3WOg4EjjH002l9sHkIS9Dm1poGsA7KkCp43UNLpSqCxEY73POY2gMxTUxib
         5HpVvFPBqAPJUy53WtZMOsLVJXjqarzgiQED4DvyjQ8MF0cLpMrY3YEGdUEF6zoLZldo
         ObnVZDan93c0zU2gCV4TH7JKMZGNlITS7VbVFDqGNtmdvK9VN18oNEy7zAhKbwCGJy7w
         PFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvzGa+d3pEOk5jowiJ1tauyPSEQZQMAnnb+dgzwhi5Q=;
        b=kGts+vpI64KIZiq9AjjtiKspFNfdV//IIDLvskgjLlX3rO+mkcJyS9gKUY0nJ3nCX5
         WlmqcynLScPZRMFaMoNs6V4e1tpoxHiQ8wCy2UfUYShaBhxrSuqkTslXRbMtKrZAVJuY
         /wGhpGZLSGRhnlV48jXZgB981pMmfcOqHgkIPGfBxLE7XMvlAkI9haeyMp0CaY5B7mPH
         pUCuEeQdZQnqGJn8NuJFsMuAU1XloksBPzkniCJ6TQyaL45vhfqKFnMzh6+5x/IHPAPi
         VFoNEOm5gEbr7R4Ki+P8U7sRhTCZ8S+SiGZORkhpVtykjgf4+We+U8mrgRf6Vde+VF8J
         7bLA==
X-Gm-Message-State: AOAM532rRMY2x2D5YTAeb3Eg1xczz/Y9I9XuRkpEpH6rFtIDgTk9tKlg
        n5dkLCr5GILWHBMaEESeNjGas5sMCNZ9WJvSa9Ru3cfItSo=
X-Google-Smtp-Source: ABdhPJzyLxuaisYU2RcziP4cIyLbzq5LxDYjBuQ8B6O5K4c7x1AY3KjeItleHhBDm43LVq7UIcGcLN/UW5sDvUSlFYs=
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr4369555edb.158.1643300641544;
 Thu, 27 Jan 2022 08:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20220127143828.2033838-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220127143828.2033838-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Jan 2022 18:22:23 +0200
Message-ID: <CAHp75Vetc62kz7VtEgWR2Jn_UsmYtzR1WM0n4pxycfKCN3h3+Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dps310: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:38 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "IFX3100" for dps310 device.

the dps310

> Vendor told us feel free to add the ID and contact
> "Saumitra.Chafekar@infineon.com" for any further question.

questions

> So add an ACPI match table for that accordingly.

I have checked the official PNP registry and may confirm IFX is for
Infineon, since they are aware
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for all your efforts, appreciate it!

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Drop ACPI_PTR().
>  - Add info from vendor.
>
>  drivers/iio/pressure/dps310.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 0730380ceb692..7e6fcb32212a2 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -812,9 +812,17 @@ static const struct i2c_device_id dps310_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
>
> +static const struct acpi_device_id dps310_acpi_match[] = {
> +       { "IFX3100" },
> +       { },
> +};

> +

This is redundant, I hope Jonathan may remove it when applying.

> +MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
> +
>  static struct i2c_driver dps310_driver = {
>         .driver = {
>                 .name = DPS310_DEV_NAME,
> +               .acpi_match_table = dps310_acpi_match,
>         },
>         .probe = dps310_probe,
>         .id_table = dps310_id,
> --
> 2.33.1
>


-- 
With Best Regards,
Andy Shevchenko
