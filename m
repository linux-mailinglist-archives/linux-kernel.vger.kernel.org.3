Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5747AF10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhLTPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbhLTPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:06:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294DC09CE42
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:53:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so26504357edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osYow0Z4FtarWbqouNAiloIRjz33QJVN/wDnBHpJQAQ=;
        b=u+fWV4AwKoO5nd9qB8ZQzxBYaeIwky2uftlTpeiprAnb70JuhYQ0AGJZh7RnNpefjO
         6Auf7zTSbOJ5MqKZfRX3pV30zvpD74fOkCuRP+9MtoRPgM41/nt3h5e/r/9Hu+GbQo6o
         7OSv1zgjKVNk3gpWPhI42RA9n2iI+aqyUxIT5bzIBXzGz/c3FH0BBH6jGVOXShOzMv5M
         VKB1vYGK3/wp9s5cqx5luRkp6oPfmNlvslb8ZbNF0BeMmPcAm2uiy/XMDfNfQj3Ex19+
         U+Az5RiebfO+kucbZI0v+J9YnIa7zNxyCMeas5BYHSaGYRptWFMcVKhHtf2Wnazlx6kO
         oKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osYow0Z4FtarWbqouNAiloIRjz33QJVN/wDnBHpJQAQ=;
        b=C9gTpHAkCgMOFjvfgdeGRUU6xHESGGln9+Medo5iTL3SoG1I8aKE3RBVum7XcJrXuu
         bGsIK17z2XNFQKuhopARslet6ahBtMr5selE4d2G0Ff8qjghStmsa/hKbjdtr+w7zhoG
         zufjVt/HfYdEAda5ctEywCFBsy98+K0ugkfFqHZukKALJPNvvNaraEhAvAFmRy3OYYTz
         tQMwaz3/AdfQ8G9NPfJv11yf6IkeBUT63aSASqsFKqMdvcqwn+BupcWrasbcevhrkCli
         WZLz/xCO5webujZWntfJ9s7N2zK5WgcP4rETwpFDK9hbtxfsTH8t+Asay5Z0dvyK1tO9
         Fasg==
X-Gm-Message-State: AOAM532XhNPfJAFlUIHhCP+YfuxiyXsk5u9ULrsDANoVEF4W8ispEfV+
        xX2uCW6QrCgVvC1dOKeqhI7YK6+SKx9Q7UKnRqy/7Q==
X-Google-Smtp-Source: ABdhPJxRvigwrIgp8akaTrOk1HwmYqHU28i9Of/EY1zZ1YWSUhhMuMilQfeKVZiftSanmJ7IPRp3+gFTXn8As15Wr6A=
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr2339554ede.365.1640012002871;
 Mon, 20 Dec 2021 06:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20211220132439.1194-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211220132439.1194-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Dec 2021 15:53:12 +0100
Message-ID: <CAMRc=Md3bpCJe_eFBjiKuhCRO_xqnFxSc1sw100fgNmajy6gaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused local OF node pointers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 2:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After the commit 448cf90513d9 ("gpio: Get rid of duplicate of_node
> assignment in the drivers") the OF node local pointers become unused.
> Remove them for good and make compiler happy about.
>
> Fixes: 448cf90513d9 ("gpio: Get rid of duplicate of_node assignment in the drivers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-brcmstb.c | 2 +-
>  drivers/gpio/gpio-gw-pld.c  | 1 -
>  drivers/gpio/gpio-mt7621.c  | 5 ++---
>  drivers/gpio/gpio-rda.c     | 1 -
>  4 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 176c264bb959..74ef89248867 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -704,7 +704,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>                 }
>
>                 gc->owner = THIS_MODULE;
> -               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
> +               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);

This is unrelated though. Can you make it a separate patch?

Bart

>                 if (!gc->label) {
>                         err = -ENOMEM;
>                         goto fail;
> diff --git a/drivers/gpio/gpio-gw-pld.c b/drivers/gpio/gpio-gw-pld.c
> index 77a3fbd46111..2109803ffb38 100644
> --- a/drivers/gpio/gpio-gw-pld.c
> +++ b/drivers/gpio/gpio-gw-pld.c
> @@ -71,7 +71,6 @@ static int gw_pld_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
>         struct device *dev = &client->dev;
> -       struct device_node *np = dev->of_node;
>         struct gw_pld *gw;
>         int ret;
>
> diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> index 52b49e7a0a80..ccaad1cb3c2e 100644
> --- a/drivers/gpio/gpio-mt7621.c
> +++ b/drivers/gpio/gpio-mt7621.c
> @@ -205,8 +205,7 @@ mediatek_gpio_xlate(struct gpio_chip *chip,
>  }
>
>  static int
> -mediatek_gpio_bank_probe(struct device *dev,
> -                        struct device_node *node, int bank)
> +mediatek_gpio_bank_probe(struct device *dev, int bank)
>  {
>         struct mtk *mtk = dev_get_drvdata(dev);
>         struct mtk_gc *rg;
> @@ -310,7 +309,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, mtk);
>
>         for (i = 0; i < MTK_BANK_CNT; i++) {
> -               ret = mediatek_gpio_bank_probe(dev, np, i);
> +               ret = mediatek_gpio_bank_probe(dev, i);
>                 if (ret)
>                         return ret;
>         }
> diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
> index 0d03f525dcd3..62ba18b3a602 100644
> --- a/drivers/gpio/gpio-rda.c
> +++ b/drivers/gpio/gpio-rda.c
> @@ -197,7 +197,6 @@ static void rda_gpio_irq_handler(struct irq_desc *desc)
>
>  static int rda_gpio_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np = pdev->dev.of_node;
>         struct device *dev = &pdev->dev;
>         struct gpio_irq_chip *girq;
>         struct rda_gpio *rda_gpio;
> --
> 2.34.1
>
