Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10855847CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiG1VmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiG1VmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:42:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD76069C;
        Thu, 28 Jul 2022 14:42:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bp15so5305991ejb.6;
        Thu, 28 Jul 2022 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GVWM8KDlgWl9FAw3nke74hvfEJOpdeYFEgFkcinpKNc=;
        b=bysSJ6a9V5jE+Kbbhxd7/Duh4WyyGfYgBIt6fKo257mRk4kAlS1FSVxiFpzZ1O6foj
         FCGQEdgTbFRrdYyuLhnuFRopOi7Q4Aoilm2gT6eyw4p4Us9w65LyRiNYNX7K+7mxshvn
         r04cREj6q2StXzQ0cbaEF7ywJz3+C3ewjb3UiurB1aVOBzvShi7wX6cn6Dplg0BG2STm
         WVVgvYsPwVFClI+loFKDHFUXy2Q1N+lzWMycla6BtWL/LULywnqBVMCcDXpMOr57derV
         LPqCTATZiO0B9E4WrMjs3AqxSUmTt8OG3utczKDe/XuLloXktAbqMWNsau8P/Vhyux9b
         8zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GVWM8KDlgWl9FAw3nke74hvfEJOpdeYFEgFkcinpKNc=;
        b=sExhidFHGZZb6v4H6LQ5vD7muw6cjp1U8rkaZs7MsZcMDUMnbGHatzbRHK6rTbg+vh
         VHBP4PvW/5yD71AUIpio/0b9E8sDlQhetDgW8dP9f1b/e2p/jWA2nCgSKoaaObw156SO
         48a5Rc9vBYPqMs5ghxHpZ4Khn8+AAaniIx6nD1hwHe3KUIehPk0N3gJqBmxaoW1OwV2/
         9CBzL3FUO7I7hydM+R9+6lE5tNFCuwBBZ1dSN8jkdC2GWzfBa/T5zBqUDgScwtlajlhd
         jCGqjwZFQq3g7DXuAGSKFqmh7MTlOedG8R+1+JxlQw8wlf36DGDGp0RkMtshSmzt/No9
         0JUg==
X-Gm-Message-State: AJIora8y3ErWpGR7vM9Wuq8LttPmnpyKzpqmvT3mI9NSqfVUJVzhBamc
        ZykPn1JTEqOGScbf4ZcgttOtVC9CFNFRskavjak=
X-Google-Smtp-Source: AGRyM1vf5SSTXOummeDa1QN+YUdXQLIusj+2vV9QKJVTdhyMRmDU/OKDz3Nx1knVsYe6O/b0b0b+VICU8/Y4o6lAdrs=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr625974ejc.242.1659044528358; Thu, 28
 Jul 2022 14:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220728155652.29516-1-henning.schild@siemens.com> <20220728155652.29516-4-henning.schild@siemens.com>
In-Reply-To: <20220728155652.29516-4-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 23:41:31 +0200
Message-ID: <CAHp75VehvE1cN9kMAhkuRrgek9Tt9OExpYnkPYNqocGPEG6Tew@mail.gmail.com>
Subject: Re: [PATCH 3/4] leds: simatic-ipc-leds-gpio: add new model 227G
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
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

On Thu, Jul 28, 2022 at 5:57 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> This adds support of the Siemens Simatic IPC227G. Its LEDs are connected
> to GPIO pins provided by the gpio-f7188x module. We make sure that
> gets loaded, if not enabled in the kernel config no LED support will be
> available.

...

> +       switch (plat->devmode) {
> +       case SIMATIC_IPC_DEVICE_127E:
> +               simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
> +               break;
> +       case SIMATIC_IPC_DEVICE_227G:

> +               if (!IS_ENABLED(CONFIG_GPIO_F7188X))
> +                       return -ENODEV;

Hmm... What is the difference with the 127E model in the sense of the
driver absence? Why do we need this check?

> +               request_module("gpio-f7188x");

I'm not sure why you need request_module().

> +               simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
> +               break;
> +       default:
> +               return -ENODEV;
> +       }

-- 
With Best Regards,
Andy Shevchenko
