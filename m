Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755958CBCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiHHQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiHHQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:02:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE465659D;
        Mon,  8 Aug 2022 09:02:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s2so6815109qtx.6;
        Mon, 08 Aug 2022 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MgJLgmbjRM5QolIw6FeSChBx0ufKjXuviaShsm9u4Oc=;
        b=o7O8xEWLvgwpV43E7Nyk9/hzLWLqLVxvgXJQst9KwndG47flo0/dMewxUM+wMpXGjW
         DnqAHeCaT03gqvBKVrkiXKXeRC8RoZH7Pjk6U8ZMAd8AopI2agcxnVB7ZN0jFUMKLkK2
         K3XnSJztNAyN23SQK1z3ykYunu34v1HpVVzd3MMNJdJr1EfRabuSI8j++4LOo4EoRpoH
         cT7j23Jfpt2yAJOAVfMofVHZq/8/Xad6kkPidpbUF6Lu3DXNivpWbC8zs+yzqOa0xgyq
         aUgwCdwcWO0YnN5huwqhoXCKFl5LIizWp6OHrjrrb4WAJLrSnPW1caRO97HXpvZq29tg
         3hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MgJLgmbjRM5QolIw6FeSChBx0ufKjXuviaShsm9u4Oc=;
        b=URWZ8UO7CJ85cqBwZ097NcPOkqXoCpVHHQWFq7XlPNbDlj6NQ/Epe5k1AX8pdNXrKT
         HYWkQBgkv5e/lqMHyhuyTp8qOQFZ4LwJQ+IRpY+YG2oxXQ2uQb56g4V0wKfXX7kaoSej
         OhqhZ/jVHY+tyc3XSf9cbtIvTSeJ/R44/jtg5i8+BwRtskzsS+rkhrsJWTW6y8fpF2BT
         w4gptCmujAjR5JBpfievU9dm98ATYWkuzKW7j8wBWnN9yjHOM7fFnhvdrs4ZY3auG7v3
         GRHmVbGtgtAl+sP2u8k6WtuUEAoVYl4RFYvs72xGQ/lv75zIBtRXnBMfXNHVDSJNlvxL
         0WGA==
X-Gm-Message-State: ACgBeo0IMvLlz0Jxw27YY+UByF4EvgqQZsXOSHYWOsLOmAiHFmNNqbsg
        iRI1xwBFEdK8NN4ahS4fTp78xEd0lxqMKe8icZdNzvmNOz8=
X-Google-Smtp-Source: AA6agR7qfMaHbD0SGpEUdDQwHNPUf93TJMZtRBGDhQOyLX6z101QJY9LHNemvkBQb+DchXCThMqMv4ilKZvUvM+a3Hs=
X-Received: by 2002:a05:622a:14d2:b0:341:9fcb:79a6 with SMTP id
 u18-20020a05622a14d200b003419fcb79a6mr16262657qtx.195.1659974529776; Mon, 08
 Aug 2022 09:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-3-luke@ljones.dev>
In-Reply-To: <20220808030420.8633-3-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 18:01:30 +0200
Message-ID: <CAHp75VcR-strGDhaGE78NjToamK98e8UO-rQhU-Ow81AavU5YA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 5:07 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for changing the laptop keyboard LED modes. These
> are visible effects such as static, rainbow, pulsing, colour cycles.
>
> Two sysfs attributes are added to asus-nb-wmi:
> - keyboard_rgb_mode
> - keyboard_rgb_mode_index

...

> +       if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) != 3)
> +               return -EINVAL;

Same comment as per v1.

...

> +       asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ? mode : 0x0a;

Same comment as per v1.

...

> +       switch (speed) {
> +       case 0:
> +               asus->keyboard_rgb_mode.speed = 0xe1;
> +               break;
> +       case 1:
> +               asus->keyboard_rgb_mode.speed = 0xeb;
> +               break;
> +       case 2:
> +               asus->keyboard_rgb_mode.speed = 0xf5;
> +               break;
> +       default:
> +               asus->keyboard_rgb_mode.speed = 0xeb;

break;

> +       }

...

> +

A blank line is not needed here.

> +static DEVICE_ATTR_WO(keyboard_rgb_mode);

-- 
With Best Regards,
Andy Shevchenko
