Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA79F4703A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbhLJPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbhLJPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:21:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769FEC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:18:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so31758689edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVfBZF4b7PCVXGGMXQB4an91HWPl0H694xX8OXVaV7E=;
        b=Ts5ywsiHxF2TIg5i2hVbjlLk9dy3fGgcAaUE6HahQhIRszjes9xv50m3bid5KWBuFA
         AocSKzQpm1irjtIDMUd+M2xlD+dCrurPG0yenzIy8UAhDi8E9b+TqOoFrQACAsJrC3Ic
         Vzpu8C9lGQpGUmctUGAqkfunlDq9i8lFwSDGyhPnRnV/tdUWPI0oMlRwjVVaA5496AqC
         hlaCi2np5KCvXLpgR19/gLS4StkFxTi009Nu2hnPS58XpyANt4G/PlBnKEGR7QZkr1yR
         lCkkXRKeWKGOdJkQfcawPz6lNO/n0pOnxV7TouSqmf8naoXUA7PgRrDwa61B0Hd0F6d6
         XUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVfBZF4b7PCVXGGMXQB4an91HWPl0H694xX8OXVaV7E=;
        b=Wf48+Sd/A6EoiL42+jRqtPkHpCkQAhbQPMwKd0QxVb3S86ftu0FVXTVR5TRayX9mRr
         UygNT+57prSv3mZtDKbl42/+nHPtNFn5cqRPw6SfpYJ9XjZ1BFbb+mW12gcLZIuUULYh
         nhFh89qLVad96IXdAQMXhrdnmEOyWBMrIr7i2pR/gwcBFdSlpNDubIBYgfn0gRyLFFxb
         85E5CmQ0tX0wgB7xYkPuB4JFp7+jVuCOngIj4/JuF4qtxNaF+vsQIgjCiUwxwFFxrr1u
         f5VhGFHJif7uAzZD8cgqjFq3pNC2X7msbtsPa9w4p+KSTbSgvC88DPuuXu/Lnq7KW2l+
         HZsQ==
X-Gm-Message-State: AOAM531a4mKlGEj0vIB6pmoOGzvAqBUzB1v1kuhm5bdDlKXPaoRlDSDZ
        gRPnRcxqqKRtd1fi9JKAS0aCSDpOnPTtb68/SZYX+g==
X-Google-Smtp-Source: ABdhPJzTeRrBSoNTNmm2l3wySatjt5c3tDJAW1i3UEGpMsuLDID2SOY6ttzqfD6TlyxBzi9dYTmyMbvlSDkHwfNKv9s=
X-Received: by 2002:a50:cdd9:: with SMTP id h25mr38348547edj.0.1639149457727;
 Fri, 10 Dec 2021 07:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20211210135527.28194-1-wangxiang@cdjrlc.com>
In-Reply-To: <20211210135527.28194-1-wangxiang@cdjrlc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Dec 2021 16:17:27 +0100
Message-ID: <CAMRc=MdXxh58zB10jXKO30JmLjXS+yna8kKDPGtip9BfQ9Pg7A@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: bcm-kona: add const to of_device_id
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 2:57 PM Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> struct of_device_id should normally be const.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>
> Changes since v1
> * Change subject log
>
>  drivers/gpio/gpio-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index d329a143f5ec..9cb3587d1441 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -505,7 +505,7 @@ static struct irq_chip bcm_gpio_irq_chip = {
>         .irq_release_resources = bcm_kona_gpio_irq_relres,
>  };
>
> -static struct of_device_id const bcm_kona_gpio_of_match[] = {
> +static const struct of_device_id const bcm_kona_gpio_of_match[] = {
>         { .compatible = "brcm,kona-gpio" },
>         {}
>  };
> --
> 2.20.1
>

Applied, thanks!

Bart

PS: next time please include any ack/review tags already left under
the previous version
