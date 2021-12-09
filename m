Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6E46E8AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhLINAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhLINAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:00:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D9C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:57:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v15so8925785ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0BtcPSuCBZNOYhnI2qnvhboGSIsrlgHM+V1nqjUds8=;
        b=Z1w9f9FMAhEW6XRAId0RysIH65MLTGwdQfBavHvTgTg5bWdH1lTDU7oX/vHAqhyDEu
         PgWrjBkNG3pIXb8JXze022m1Gk0Y/rQ0QNoEPjC7ENFsAqi71tG2IEudmW1taqa+t4Tz
         wiWRaoQvXHM1de8xqer00XgTu/TIuw8fpSerBQyJZftJTGnrdi6iy81BcZYhrg/NbPgj
         v4MsxL5rafq/lmCQodhOfTBYZwKHRhhw2/ftXaWGlCuTm3dOAcF+vJLdKm/CAsyhOakO
         iBDfo8ysC/Y93/62ouBsydPSgu04uTIEfHYO7JM5Vpnyr1Jd+5xlKhP6vkwqIv01dd3W
         an6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0BtcPSuCBZNOYhnI2qnvhboGSIsrlgHM+V1nqjUds8=;
        b=EzCT0Uv9oA53fjiRui5OwKbIWdXy8m1r5R41aH6fu6B2hFFTn2esD0ooo4QduoBuxs
         W8YZ6RvETqdQr2DnAYQ2QVGVqyvbyDBIvLWOjX4ca8mS/tA9ZC1+jU+c8PUwJzXWQzVm
         q17Fr1X9VQmRwamuq5cvt9O8Lje9vaalsksWhUNVvkg0f9zJvz6Cz649ax0RSjRi1Hlc
         DbSSwYUl8COKlP4dSqMchjR9+Zl4N5mNyKUX0ShQQxTKg9d+hnhSn+AJtiqjP/SU7pkq
         cEZ/T5Afz7vCuogVM0qHYyp2l3zXaX+5HLAQyRxgYmlwNwKXH4AUuYk3UkTqwvWO805h
         LvWQ==
X-Gm-Message-State: AOAM533CJFYhSn2cB3z02svxDJWY++Mx1XBIFYPBJfD4WiiLzMdgyh+s
        qYXTBshSNHVRPS/skvhkLQZWaDEfphjtvGVXoMK5ihIrIQgnqw==
X-Google-Smtp-Source: ABdhPJxFeplZpEbkpi36puU+ZoePzLXj3VK/XGWK4+73QwTS9X8sRxsML8YFI4+OA1EGwOAE6kv11IKAxaf8gFR8H5Y=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr6246609ljm.16.1639054622591;
 Thu, 09 Dec 2021 04:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20211209120157.9552-1-sensor1010@163.com>
In-Reply-To: <20211209120157.9552-1-sensor1010@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 13:56:26 +0100
Message-ID: <CAPDyKFqRsKAo7YtxQxmieMcWRQpxs1vMkFZ9VXWocpH9xneXPw@mail.gmail.com>
Subject: Re: [PATCH] drivers/mmc/core/bus: Remove redundant driver match function
To:     lizhe <sensor1010@163.com>
Cc:     u.kleine-koenig@pengutronix.de,
        srinivas.pandruvada@linux.intel.com, pali@kernel.org,
        TheSven73@gmail.com, lznuaa@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 13:02, lizhe <sensor1010@163.com> wrote:
>
> If there is no driver match function, the driver core assumes
> that each candidate pair (driver, device) matches. See function
> driver_match_device().
>
> Drop the mmc bus's match function that always returned 1 and
> so implements the same behaviour as when there is no match
> function.
>
> Signed-off-by: lizhe <sensor1010@163.com>

I have already applied your previous version. Or is there a change in
this version?

Future wise, please bump the version number between each submission
and highlight what you have changed. See
Documentation/SubmittingPatches.

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index f6b7a9c5bbff..096ae624be9a 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -53,16 +53,6 @@ static struct attribute *mmc_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(mmc_dev);
>
> -/*
> - * This currently matches any MMC driver to any MMC card - drivers
> - * themselves make the decision whether to drive this card in their
> - * probe method.
> - */
> -static int mmc_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -       return 1;
> -}
> -
>  static int
>  mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> @@ -226,7 +216,6 @@ static const struct dev_pm_ops mmc_bus_pm_ops = {
>  static struct bus_type mmc_bus_type = {
>         .name           = "mmc",
>         .dev_groups     = mmc_dev_groups,
> -       .match          = mmc_bus_match,
>         .uevent         = mmc_bus_uevent,
>         .probe          = mmc_bus_probe,
>         .remove         = mmc_bus_remove,
> --
> 2.25.1
>
>
