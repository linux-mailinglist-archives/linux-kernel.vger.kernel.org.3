Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13FD472DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhLMNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhLMNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:48:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFECC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:48:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so52661854eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wu/ZxCGSsJ+oivX8kkncERiBTBwcaObKtaxtxVxyM6E=;
        b=Hd9RksSv2OCCKj1GLzBeT3a30JYz5Savl/39eqYLE/ED3ZHJk+/+Pea/sj0tHNnf+o
         Qu2gZI9YgCWCiTKIgzzEX/E413jC0KZCgLx6oCA9nH68us/bh2W5TvM5E7pNRNAH2J1w
         V1k+kNyv3U8Q5c2h8lnMvx9UDYrPoyxT59zFfXz+fFBgMV+6Y+lX/q5Tf3DpkXE3mjx6
         r4p8n1NUdM+XroD4eMysJWUh8ceZ+8c250s2iHf9Bfw+EZWbVai/H/GxAM9REIAHJq7E
         Nq3pilBVU8weqHwC/j/ibaxqk8hL3CYbhsbcCmg1zquQCL8wkiMRg0aXIC8PfSV87p1g
         1g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wu/ZxCGSsJ+oivX8kkncERiBTBwcaObKtaxtxVxyM6E=;
        b=PbSX2VFdpw+oNQknTBUTbrjV97MrgNCbR17zZD+20CJl/qaOoms1p1IsSTqzOXbcFe
         RMuMnnd+mxVVJtpTSCPTrhrLul2x8QV8PW/EiHfVGx3Lfw2wPnDLX4T/VDjxPVn9lfDM
         BGQarBlU5S8xSjDJe6NLtWL3cKcPWClKaDZb/sPerSX5QUQSASyjC7xeflrHOujHUnll
         ikFHNJNY7H+sZXTUfAbTo3nUFgNbeo5mjv8ZrrUlzoYorawsR4EuLDvEadGh5D9emlTU
         ZgBHvNxBCMCctIlU6bEBUlBVkDkW0giHy1WDQrHoCB3lVW3afW0EHJDkI11mqd6fNsR+
         w7gQ==
X-Gm-Message-State: AOAM533NSH/I9sYLMXpYX5VyAxFTzYteC+qeJBkGKwvBBUeWjCiOPRA3
        E69HzxE7qScdWb6xMn5UvO8Z6yDNqye5T6chDx+DEA==
X-Google-Smtp-Source: ABdhPJwOijd5WgV9me5Rti0PSTtwawWMernnmcAkVkEktGsVjkReg4dg+5XeNqBVRLChj0pbMbguqeQBWLObtqbjcvY=
X-Received: by 2002:a17:906:4787:: with SMTP id cw7mr47479334ejc.311.1639403295706;
 Mon, 13 Dec 2021 05:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20211212031335.36369-1-wangborong@cdjrlc.com>
In-Reply-To: <20211212031335.36369-1-wangborong@cdjrlc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Dec 2021 14:48:04 +0100
Message-ID: <CAMRc=MfT72KJVQKCRqdToPSf1kysyu=8RLktmB7Dpbv8dDB8ZQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sta2x11: fix typo in a comment
To:     wangborong@cdjrlc.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 4:13 AM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `all' in the comment in line 327 is repeated. Remove one
> of them from the comment.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/gpio/gpio-sta2x11.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
> index 392fcab06ab8..e07cca0f8d35 100644
> --- a/drivers/gpio/gpio-sta2x11.c
> +++ b/drivers/gpio/gpio-sta2x11.c
> @@ -324,7 +324,7 @@ static int gsta_alloc_irq_chip(struct gsta_gpio *chip)
>         if (rv)
>                 return rv;
>
> -       /* Set up all all 128 interrupts: code from setup_generic_chip */
> +       /* Set up all 128 interrupts: code from setup_generic_chip */
>         {
>                 struct irq_chip_type *ct = gc->chip_types;
>                 int i, j;
> --
> 2.34.1
>

Applied, thanks!

Bart
