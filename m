Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D830B47F117
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbhLXUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhLXUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:38:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2103C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 12:38:12 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id o7so10195058ioo.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTcZcXn3gMOw5s9nKkpc/pq0+6ofltOh101RdlFXywg=;
        b=GCfk2ROsvayGIwCXiI69gTj0R65gRZ8uuaQ1bckvSFzeB5k+g5bwM65L60y39tzbNM
         80WJ9XfaWcbA0pCSh5gtKwD0xPB7E/vUYoznJEyvWPPy7VS0dieiZwmIGCJNFqwO7g+6
         QDv0fNgnNDvxYQIxO9I1ITFjB7ef3IwQ7LbEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTcZcXn3gMOw5s9nKkpc/pq0+6ofltOh101RdlFXywg=;
        b=BvLAhSU5WRwQqm0WDPWC58TMHFZ9HQGf6Qc0mrUPOcVcCUX9CpWqsA0Wu/Efbj0lyV
         i1x+UoEfQiyGi8B0OLdi5gnSUIoFvmnS5kKXqRRlMUr0MKD9p4gdLkEgtBZYEhCFXWm9
         hsKCcm6B8Sg6KXupIDS/OKmyyocUmqO9RHNNmbgkqOvxuGL0KreGCH6lPmWxspKFG6Cw
         RkizSJ0mgiemo9CTcWXT1ZalaTUxV4Z2Ys+ovjCuX1P4D45iv2ikemjakA/XQE1Lk9VB
         k20NT2N9o/4664FqoZZ5zW+0uWqRLObY2jckRa9+Rk8s4pbnb+vNJSI898jHOrRmRzgP
         T3Bg==
X-Gm-Message-State: AOAM5328z6zVrbdOKyprDFaHNjxH8AYe3B/ynK+FzXiYloVr8HZFyypk
        hdsH7+uEUenZ2QH8rK0tCJB5mXangx70Gd28puvAVw==
X-Google-Smtp-Source: ABdhPJxq4MyJjI5Utf9Da7ShlxsZIGegUECocbNEUBmjAAFvHRo+/7Q9uwmH+JzSc/QtRg5T+NT7D0yLMBrqkW1i3S4=
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr3676343iob.130.1640378292291;
 Fri, 24 Dec 2021 12:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20211224145903.368999-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211224145903.368999-1-kai.heng.feng@canonical.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 24 Dec 2021 12:37:59 -0800
Message-ID: <CAJCx=gmPB_nqNt-OQXTEiKKaPh6sw1y6deUON3-t=QUJOQ3nNg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Lesiak <chris.lesiak@licor.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 6:59 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "HDC1010" to for hdc100x device.
>
> So add an ACPI match table for that accordingly.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 9e0fce917ce4c..ad1dfac543c52 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -417,10 +417,18 @@ static const struct of_device_id hdc100x_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
>
> +static const struct acpi_device_id hdc100x_acpi_match[] = {
> +       {"HDC1010"},
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
> +
>  static struct i2c_driver hdc100x_driver = {
>         .driver = {
>                 .name   = "hdc100x",
>                 .of_match_table = hdc100x_dt_ids,
> +               .acpi_match_table = ACPI_PTR(hdc100x_acpi_match),
>         },
>         .probe = hdc100x_probe,
>         .id_table = hdc100x_id,
> --
> 2.33.1
>
