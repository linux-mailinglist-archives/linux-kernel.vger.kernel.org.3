Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F94D432C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiCJJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiCJJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:07:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C7138591
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:06:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m12so6047478edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6cIzH9Xv2kAkc5CGXg0dY9Os86ok8VlKX0nfdrGmxk=;
        b=jpKZmPtf6ts6t37Un7YGRrU2DFJ6hgABzNVvc5F/xqhFGBYn9GtXPHLTuQm7KQXp3h
         JVLx+o0Ii0Za6aEjUl6ek2ELUNyImfY0j1QNv95kYqfCunwKCfb/WigoihneECSzc/Hq
         I+rjbreLPdBwTQdCm4VOy51pD5zuUb75iTlq/M4TTab7SJxclAPF5bQJSBTr1oi5YPfP
         BeuHvw8NEaksj2ikNUsg3AiQpw9FRWPKvfTRP9xetRtZ8pdnAC4kt/OslkAYXUqoclrV
         9St8KE95+2mCXuRADQFO7cFyZbNfY7BbLafpDzjxujdGy5VLrI1lGuyhjdLASHiFvjvv
         tDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6cIzH9Xv2kAkc5CGXg0dY9Os86ok8VlKX0nfdrGmxk=;
        b=vI5frQV3/c8D5qHSilEvYAbU0DBqXYsx3GfSW//crPvsujH2Cua1XQ+o1CHjcGVaZr
         j+ScBCpqXljZcjB4mGJmcNc9ikR7reILB8kjgBwSB33+KulPgP96gBY8mQTRJTJkuzp7
         VptNxzw6Wd5Wzup8CCQ2cimbcomOGl2Z7bWUbPk3k5dMBuvKPrj8eyfVJBWXUJM56xRb
         O1vB+T/lyYKryv+Wke+4mnuViyMRhTq/fdyPxXm60zfNH4weJewZ5PZl5ALyNAlA4Znh
         RiWWdEm/HdAu6KPaSx85WtuCQ1OX8KxkeecbQ/mZShipLzoXD9onm7YYCPc6ZN92E8BN
         KnDg==
X-Gm-Message-State: AOAM530Y37k9WJrVxV+jQwLxm7ejV6R/e24b3WLiC0LEj/GZA8v+TDZV
        oETzZxkY0gwcR9byc5pqUVnQOhTisghiDEIp0Pg1DTqYaMo=
X-Google-Smtp-Source: ABdhPJx7aWsbpdFfLgAkL53l1vKBP7Cca1RRlZ4Npp4WBGJ4Q+Lzy+ZFciMD2QfDYIxUv6TqceyCzIUYlLc+vLpWD8s=
X-Received: by 2002:a05:6402:2550:b0:416:997f:1239 with SMTP id
 l16-20020a056402255000b00416997f1239mr3312677edb.141.1646903202481; Thu, 10
 Mar 2022 01:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20220310011617.29660-1-kris@embeddedTS.com> <20220310011617.29660-3-kris@embeddedTS.com>
In-Reply-To: <20220310011617.29660-3-kris@embeddedTS.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 10 Mar 2022 10:06:22 +0100
Message-ID: <CAMRc=McZng+m6Q9kCtwcVNB=No681mtChKR9ZAgANkfHx2fm7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: ts4900: Use SPDX header
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 2:16 AM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> Remove boilerplate, use the SPDX license identifier.
>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/gpio/gpio-ts4900.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
> index d918d2df4de2..69854fd2382a 100644
> --- a/drivers/gpio/gpio-ts4900.c
> +++ b/drivers/gpio/gpio-ts4900.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Digital I/O driver for Technologic Systems I2C FPGA Core
>   *
>   * Copyright (C) 2015, 2018 Technologic Systems
>   * Copyright (C) 2016 Savoir-Faire Linux
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether expressed or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License version 2 for more details.
>   */
>
>  #include <linux/gpio/driver.h>
> --
> 2.11.0
>

Applied, thanks!

Bart
