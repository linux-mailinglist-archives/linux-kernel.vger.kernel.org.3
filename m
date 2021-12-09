Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444AB46E62E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhLIKKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhLIKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:10:01 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91513C061A32
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:06:28 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id l7so8189454lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKMvGFlBW3AWdPaA2xmuCR4hyEmUTzTC0PY59n64gTk=;
        b=e8OVmzhKr4HtldNf0mMJ4dwaio7Z3ZvJXr7Xkm5IcDOctn2ViN/cwCgTBZZHy0NpDt
         r/QiSN4MBiAnzvwR0O+SqWItG5n7t4pDBsiKO0z50hqDtkGWoyC3XO13YypSygZ9J8FK
         vAPF+N7iihjdPksYzBbvZLXs3/N5PVFDRg7yOMu0aN+DXAUKF5nz2k2NuhzOtAypqTDr
         0QJQ0Gj8DtUPA0eDwdIPzS1snU2X+vKWngyiIHlSKZU9Zp4bVXfuLyJ+Gu1QkQWoPrAx
         HOmj0GgVHmzIONMJfD4FqgYpikJTVjRCMUu5rP+zq835zAUWeME1UtliRcu5QuEHjxOi
         2eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKMvGFlBW3AWdPaA2xmuCR4hyEmUTzTC0PY59n64gTk=;
        b=pTvUUuA4t20K949zKvlOyl9lQM52Hv5vCEsbbplBR+S2OagewO3+mG78ThSRaadNsT
         RPqFszz36y9lJowjUa3cvvgOJNa6hBZ6OnjFEW4/1yU89FhHsKcjJYAKB6fV1lrj/b3L
         RtqXqdqM+8siKNyGeuTilfrn06+BfXrnrFE3AKc6f4OAAfPUmbSVz3cPvm0/zsZl55YP
         0qXv1i/5O3uEP9+xu7XhVGZxkcLsAbrUe+GR/MInjexsOa0PP7X3T6pXuzeqwKT94fXu
         8V7uNwMoIzIJGzt7BmQQ/ivj/zZoLEPIH4TRkANFPBJnYN1KOMuEgjwB0LqRV783HDWP
         W8og==
X-Gm-Message-State: AOAM53287dRe8E/Yg1cI6rqpyhWOcc/MF17am0IsZW0vUvgz2yUYZV1i
        pbN/r2UuPTtFFl6jcZgb/e8w73aJ52geSTobg9Do7A==
X-Google-Smtp-Source: ABdhPJxcWvgf7bImrcCmZVAd+G9GHaJ3NHzEg6XZV2qwHK9WQa+fZcFPznmaKW+e9jytoGVRdzl1gaEasbvMtrhhjP0=
X-Received: by 2002:a2e:b6d1:: with SMTP id m17mr5178113ljo.273.1639044386848;
 Thu, 09 Dec 2021 02:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207095029.96387-1-sensor1010@163.com>
In-Reply-To: <20211207095029.96387-1-sensor1010@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:05:50 +0100
Message-ID: <CAPDyKFriijPB5s6D-jorVj=1+VRzJzh10Mmu6nvMjpoXkfQZrA@mail.gmail.com>
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

On Tue, 7 Dec 2021 at 10:51, lizhe <sensor1010@163.com> wrote:
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

Applied for next, thanks!

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
