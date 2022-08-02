Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D2588304
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiHBUNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiHBUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:13:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E021E28;
        Tue,  2 Aug 2022 13:13:39 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id o14so2594138ilt.2;
        Tue, 02 Aug 2022 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DL/ZVcyFLAnfrw96dmA8vfu5gvQx7dHVG0w0JJK5RBc=;
        b=gdTcFJdfR0AwMKZ5XWwdKoJpGiq7trN4eIOa3vq/HD39p1/0LkDrT+zQDznxSc6/2h
         e0cY+B3BvtKXryV0ZeLUmudtgcqcjLSZ/0m4YD4wBpjJG+bDEAtvXJl9wMEyhU90fvhg
         kOxk7tTuE3iCmt31OKfPKo7yAnus/QxhnCNSfeKUSB4f33UFTAkD6lYc7Hp1fNuAxIlC
         KLfBBHbSvgXf1pjn+aXy+i9x1KGEirSQvWelm6HU1kNs0zZv9HpnHf1ZbthhKz3Woreq
         4u2tTnSnC0JAgvLL+RfSHoEf5kc1O4CHTNli/cG2zDM5KLh/h15u3OX7TA+I2LDKt7ay
         ZVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DL/ZVcyFLAnfrw96dmA8vfu5gvQx7dHVG0w0JJK5RBc=;
        b=jpPb7QK9Jhh7ElwIrUaEtehaTBkYVm8qAblRG5/MkKNoPl3cz6u1N4SFgR7ZKK4Mpk
         14Cp5DGsYSvKOkpl4/4/g4DZ8QfO5+v8bLs3H8DwpzIyEr2HT/uOCd7K+fUZYdJhN/Xs
         b4QkairSQZ5a+cogT/aq9TYQaZPXl3alFC5+7rwzijgmruzLFHSlPflg4qxmvoSBy+3y
         YES9GLEwZav91j6/90IP7Mbeiaz7sNjmzWPxzsyu2s+W/vYGbn4HUMtg7vMmCkuahiye
         9YufhPw6XSDIfIcVK++luqGzQ3wzEEWqm+a28cHDp0t5zusQzABWnwJPZA2HxLekl2kX
         cHpQ==
X-Gm-Message-State: AJIora8R54UmO7iUoMYbnrikqf4yWIN2tFrbeEokEZ7x3cliYvjBpc4O
        pyvGV+s/+8dgWY5KGWSsm6X2Sj1hVglBXR8vNcg=
X-Google-Smtp-Source: AGRyM1udb+wpnV/B84jdMXpXMuZdSVsTfo3XgTv/UrOwbBffVxGJKkyha31fiC+aaS6wAPCmj/H2h+FrstJtN1gU0A0=
X-Received: by 2002:a05:6e02:152c:b0:2dc:9b02:b590 with SMTP id
 i12-20020a056e02152c00b002dc9b02b590mr8792059ilu.320.1659471219135; Tue, 02
 Aug 2022 13:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <7eec2e24a231510577647853a32bddb89a762128.1659468931.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7eec2e24a231510577647853a32bddb89a762128.1659468931.git.christophe.jaillet@wanadoo.fr>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Tue, 2 Aug 2022 13:13:27 -0700
Message-ID: <CAF8JNhKKyzqSm_52QeErUHusNEaPNjkBeJ0LKbEDNMY-dc5WnA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Simplify comments
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 12:45 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Remove a left-over from commit 2874c5fd2842 ("treewide: Replace GPLv2
> boilerplate/reference with SPDX - rule 152").
> An empty comment block can be removed.
>
> While at it remove, also remove what is supposed to be the path/filename of
> the file.
> This is really low value... and wrong since commit 471d17148c8b
> ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
> v1 -> v2
>   - add wacom.h, wacom_wac.c, wacom_wac.h
> ---
>  drivers/hid/wacom.h     | 5 +----
>  drivers/hid/wacom_sys.c | 5 -----
>  drivers/hid/wacom_wac.c | 5 -----
>  drivers/hid/wacom_wac.h | 4 +---
>  4 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
> index 3f8b24a57014..4da50e19808e 100644
> --- a/drivers/hid/wacom.h
> +++ b/drivers/hid/wacom.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
> - * drivers/input/tablet/wacom.h
> - *
>   *  USB Wacom tablet support
>   *
>   *  Copyright (c) 2000-2004 Vojtech Pavlik     <vojtech@ucw.cz>
> @@ -78,10 +76,9 @@
>   *                 - integration of the Bluetooth devices
>   */
>
> -/*
> - */
>  #ifndef WACOM_H
>  #define WACOM_H
> +
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 194a2e327591..21612fdae9c3 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1,13 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * drivers/input/tablet/wacom_sys.c
> - *
>   *  USB Wacom tablet support - system specific code
>   */
>
> -/*
> - */
> -
>  #include "wacom_wac.h"
>  #include "wacom.h"
>  #include <linux/input/mt.h>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index d049239256a2..1bbd24ebacad 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1,13 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * drivers/input/tablet/wacom_wac.c
> - *
>   *  USB Wacom tablet support - Wacom specific code
>   */
>
> -/*
> - */
> -
>  #include "wacom_wac.h"
>  #include "wacom.h"
>  #include <linux/input/mt.h>
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index fef1538005b5..5ca6c06d143b 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * drivers/input/tablet/wacom_wac.h
> - */
> +
>  #ifndef WACOM_WAC_H
>  #define WACOM_WAC_H
>
> --
> 2.34.1
>
