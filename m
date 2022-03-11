Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAA4D5E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347469AbiCKJaX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Mar 2022 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiCKJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:30:21 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69181BE0C8;
        Fri, 11 Mar 2022 01:29:18 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id p8so6532882qvg.12;
        Fri, 11 Mar 2022 01:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ttJJ0M7nwthX5OY+c4KyfOxHE7Mzj3zYgXoHBRNpMKo=;
        b=kHNAjjRQ9w/95fQGc5Z0W1bYYssi06+2MwxSk1Fk816LHWZkuWXGJPZWb/ykudM6Pd
         opUXYygWjgtc9xUqh8sIoKRGXnYu3/Rgh8dy/yBBzVysBn1LGLaLvXC+Y4oO/gDh05dH
         D2Ee3BjZno45KlFuEg8hnor1Qr0nPpdZ6OgaUS1oV8dN4t9X0N41b+n6wZvG6l6RYOkZ
         Ydg7JlqdPFKF13yGEfNjcFmSHdUPKyiU9fkiWy9VKesxSaoCSxAm1pd+TjQrRKkvwwdz
         mgwxKRSMK9/jC0hg943vrAsQxyOdElq9YsswUO3HwYeMl+XuSQGub+Pyy4gsTQ++CKtL
         uE+w==
X-Gm-Message-State: AOAM5301V+Gv4/msGc7OjQEMFF2jvdHskqt7eSIzLGkPUpjZTA3dLOhO
        q36Ji8EMdGq+/e9Q/d405EMDmCDDlIuL5A==
X-Google-Smtp-Source: ABdhPJyGWZPUy1k1zWXOeYUZxcGGbgqTA18Lg6ztFwf3mC/xI8FQ5g6gLq92tjVULyV42QVEeOjixQ==
X-Received: by 2002:a0c:be89:0:b0:42c:38b2:9d17 with SMTP id n9-20020a0cbe89000000b0042c38b29d17mr7030610qvi.50.1646990957363;
        Fri, 11 Mar 2022 01:29:17 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id h17-20020ac87d51000000b002de919e3187sm5168588qtb.28.2022.03.11.01.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:29:17 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2dbc48104beso86633217b3.5;
        Fri, 11 Mar 2022 01:29:16 -0800 (PST)
X-Received: by 2002:a81:6dd1:0:b0:2dc:56d1:1dae with SMTP id
 i200-20020a816dd1000000b002dc56d11daemr7246044ywc.479.1646990956518; Fri, 11
 Mar 2022 01:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20220310221246.10009-1-zajec5@gmail.com>
In-Reply-To: <20220310221246.10009-1-zajec5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Mar 2022 10:29:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXej1-BdCsOMJF9EU9RHJ+o3dhN1Wt1=Dg-0ib=NiicgQ@mail.gmail.com>
Message-ID: <CAMuHMdXej1-BdCsOMJF9EU9RHJ+o3dhN1Wt1=Dg-0ib=NiicgQ@mail.gmail.com>
Subject: Re: [PATCH V2] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

On Thu, Mar 10, 2022 at 11:13 PM Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
>
> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
> documentation change regarding "depends" usage. Adjust Kconfig entry to
> match current guidelines. Make this symbol available for relevant
> architectures only.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform dependency practises")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Use precise "depends" (exact platforms)

Thanks for the update!

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>         tristate "Broadcom BCM63xx/BCM33xx UART support"
>         select SERIAL_CORE
> -       depends on COMMON_CLK
> +       depends on ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
> +       default y

Merely enabling COMPILE_TEST should not enable additional drivers.

>         help
>           This enables the driver for the onchip UART core found on
>           the following chipsets:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
